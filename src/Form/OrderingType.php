<?php

namespace App\Form;

use App\Entity\Ordering;
use App\Entity\Product;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use App\Form\ClientType;
use App\Form\ProductType;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;

class OrderingType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('address1')
            ->add('address2')
            ->add('city')
            ->add('postalCode')
            ->add('country', ChoiceType::class, [
                'choices'  => [
                    'France' => 'France',
                    'Belgique' => 'Belgique',
                    'Luxembourg' => 'Luxembourg',
                ],
            ])
            ->add('phone')
            ->add('client', ClientType::class)
        ;
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults([
            'data_class' => Ordering::class,
            'allow_extra_fields' => true,
        ]);
    }
}
