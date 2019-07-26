<?php

namespace App\Controller;

use App\Form\OrderingType;
use App\Entity\Ordering;
use App\Manager\OrderManager;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\Form\Form;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use App\Entity\Product;
use GuzzleHttp\Client;
use Stripe\Stripe;

class LandingPageController extends Controller
{
    /**
     * @Route("/", name="landing_page")
     * @throws \Exception
     */
    public function index(Request $request): Response
    {

        $products = $this->getDoctrine()
            ->getRepository(Product::class)
            ->findAll();

        $order = new Ordering();
        $form = $this->createForm(OrderingType::class, $order);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $product = $this->getDoctrine()
            ->getRepository(Product::class)
            ->findOneBy([
                'id'    =>  $request->request->get('order')['product'],
            ]);
            $order->setProduct($product);
            $order->setPaymentType($request->request->get('order')['payment_method']);

            $response = $this->postApi($order, 'WAITING');

            if ($response->success && $response->success == 'Order successfully saved') {
                
                $order->setStatusMessage($response->success);
                $order->setApiId($response->order_id);
                
                $entityManager = $this->getDoctrine()->getManager();
                $entityManager->persist($order);
                $entityManager->flush();

                if ($order->getPaymentType() == 'stripe') {
                    return $this->redirectToRoute('payment_stripe', ['order' => $order->getId()]);
                    
                }
                else if ($order->getPaymentType() == 'paypal') {
                    return $this->redirectToRoute('payment_charge', ['order' => $order->getId()]);
                }
                

            }
            else {
                $this->addFlash(
                    'error',
                    'Une erreur est survenue lors de l\'enregistrement de la commande. Veuillez réessayer ulterieurement.'
                );

                return $this->redirectToRoute('landing_page');
            }
        }

        return $this->render('landing_page/index_new.html.twig', [
            'order' => $order,
            'form' => $form->createView(),
            'products'  =>  $products,
        ]);
    }

    /**
     * @Route("/payment/{order}", name="payment_stripe")
     */
    public function paymentStripe(Ordering $order)
    {
        return $this->render('landing_page/payment.html.twig', [
            'order' => $order,
        ]);
    }

    /**
     * @Route("/charge/{order}", name="payment_charge")
     */
    public function paymentCharge(Ordering $order, \Swift_Mailer $mailer)
    {

        if ($order->getPaymentType() == 'stripe') {
            // Set your secret key: remember to change this to your live secret key in production
            // See your keys here: https://dashboard.stripe.com/account/apikeys
            Stripe::setApiKey('sk_test_aY17Hbx3t6GacRy9k35F5c1G00b8kFjGMf');

            // Token is created using Checkout or Elements!
            // Get the payment token ID submitted by the form:
            if ($_POST['stripeToken']) {
                $token = $_POST['stripeToken'];
                $order->setStripeToken($token);
            }
            else {
                $token = $order->getStripeToken();
            }
            
            try{
                $charge = \Stripe\Charge::create([
                    'amount' => $order->getProduct()->getReducedPrice(),
                    'currency' => 'eur',
                    'description' => 'Charge for order #' . $order->getApiId(),
                    'source' => $token,
                ]); 
            } catch(\Stripe\Error\Card $e) {
            $this->addFlash(
                'stripe',
                'Un problème est survenu lors du paiement. Veuillez essayer avec une autre carte.'
            );

            return $this->redirectToRoute('payment_stripe', ['order' => $order->getId()]);

            } catch (\Stripe\Error\RateLimit $e) {
            // Too many requests made to the API too quickly
            $this->addFlash(
                'stripe',
                'Un problème est survenu lors du paiement. Veuillez réessayer ulterieurement.'
            );

            return $this->redirectToRoute('payment_stripe', ['order' => $order->getId()]);

            } catch (\Stripe\Error\Base $e) {
            // Display a very generic error to the user, and maybe send
            // yourself an email
            $this->addFlash(
                'stripe',
                'Un problème est survenu lors du paiement. Veuillez réessayer ulterieurement.'
            );

            return $this->redirectToRoute('payment_stripe', ['order' => $order->getId()]);

            }
            
        }

        $response = $this->updateApi($order->getApiId());
    
        if ($response->success && $response->success == 'Order successfully saved') {
            $order->setStatusMessage($response->success . ' and PAID');
            
            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->flush();

            $message = (new \Swift_Message('Confirmation de commande - Battleoffice.com'))
            ->setFrom('no-reply@battleoffice.com')
            ->setTo($order->getClient()->getEmail())
            ->setBody(
                $this->renderView(
                    'emails/confirmation.html.twig', [
                        'order' => $order
                    ]
                ),
                'text/html'
            )
            ;

            $mailer->send($message);

            return $this->redirectToRoute('confirmation');
        }
        else {
            $this->addFlash(
                'error',
                'Une erreur est survenue lors de l\'enregistrement de la commande. Veuillez réessayer ulterieurement.'
            );

            return $this->redirectToRoute('landing_page');
        }
    }

    /**
     * @Route("/confirmation", name="confirmation")
     */
    public function confirmation()
    {
        return $this->render('landing_page/confirmation.html.twig', [
        ]);
    }

    public function postApi($order, $status)
    {
        if ($order->getAddress1() == NULL) {
            $shippingAddress = [
                'address_line1' =>  $order->getClient()->getAddress1(),
                'address_line2'  =>  $order->getClient()->getAddress2(),
                'city'  =>  $order->getClient()->getCity(),
                'zipcode'   =>  $order->getClient()->getPostalCode(),
                'country'   =>  $order->getClient()->getCountry(),
                'phone' =>  $order->getClient()->getPhone()
            ];
        }
        else {
            $shippingAddress = [
                'address_line1' =>  $order->getAddress1(),
                'address_line2'  =>  $order->getAddress2(),
                'city'  =>  $order->getCity(),
                'zipcode'   =>  $order->getPostalCode(),
                'country'   =>  $order->getCountry(),
                'phone' =>  $order->getPhone(),
            ];
        }

        $apiClient = new Client([
            
            // Base URI is used with relative requests
            'base_uri'  =>  'https://api-commerce.simplon-roanne.com/',
            'headers'   =>  [
                'Authorization'     => 'Bearer mJxTXVXMfRzLg6ZdhUhM4F6Eutcm1ZiPk4fNmvBMxyNR4ciRsc8v0hOmlzA0vTaX',
                'User-Agent'        => 'Elo et Nico'
            ],
            'json'      =>  [
                'order'     =>  [
                    'product'           =>  $order->getProduct()->getName(),
                    'payment_method'    =>  $order->getPaymentType(),
                    'status'            =>  $status,
                    'client'            =>  [
                        'firstname'         =>  $order->getClient()->getFirstName(),
                        'lastname'          =>  $order->getClient()->getLastName(),
                        'email'             =>  $order->getClient()->getEmail(),               
                    ],
                    'addresses'         =>  [
                        'billing'           =>  [
                            'address_line1'     =>  $order->getClient()->getAddress1(),
                            'address_line2'     =>  $order->getClient()->getAddress2(),
                            'city'              =>  $order->getClient()->getCity(),
                            'zipcode'           =>  $order->getClient()->getPostalCode(),
                            'country'           =>  $order->getClient()->getCountry(),
                            'phone'             =>  $order->getClient()->getPhone(),
                        ],
                        'shipping'          =>  $shippingAddress,
                    ]
                ]
            ]
        ]);

        $response = $apiClient->request('POST', 'order');

        $response = json_decode($response->getBody()->getContents());

        return $response;
    }

    public function updateApi($id)
    {
        $apiClient = new Client([
            
            // Base URI is used with relative requests
            'base_uri'  =>  'https://api-commerce.simplon-roanne.com/',
            'headers'   =>  [
                'Authorization'    => 'Bearer mJxTXVXMfRzLg6ZdhUhM4F6Eutcm1ZiPk4fNmvBMxyNR4ciRsc8v0hOmlzA0vTaX',
                'User-Agent' => 'Elo et Nico'
            ],
            'json'      =>  [
                'status'    =>  'PAID'
            ]
        ]);

        $response = $apiClient->request('POST', 'order/' . $id . '/status');

        $response = json_decode($response->getBody()->getContents());

        return $response;
    }
}
