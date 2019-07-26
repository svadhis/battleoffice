<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass="App\Repository\ProductRepository")
 */
class Product
{
    /**
     * @ORM\Id()
     * @ORM\GeneratedValue()
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $name;

    /**
     * @ORM\Column(type="integer")
     */
    private $regularPrice;

    /**
     * @ORM\Column(type="integer")
     */
    private $reducedPrice;

    /**
     * @ORM\Column(type="integer")
     */
    private $baseQuantity;

    /**
     * @ORM\Column(type="integer")
     */
    private $offeredQuantity;

    /**
     * @ORM\Column(type="boolean")
     */
    private $popular;

    /**
     * @ORM\OneToMany(targetEntity="App\Entity\Ordering", mappedBy="product")
     */
    private $orderings;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): self
    {
        $this->name = $name;

        return $this;
    }

    public function getRegularPrice(): ?int
    {
        return $this->regularPrice;
    }

    public function setRegularPrice(int $regularPrice): self
    {
        $this->regularPrice = $regularPrice;

        return $this;
    }

    public function getReducedPrice(): ?int
    {
        return $this->reducedPrice;
    }

    public function setReducedPrice(int $reducedPrice): self
    {
        $this->reducedPrice = $reducedPrice;

        return $this;
    }

    public function getBaseQuantity(): ?int
    {
        return $this->baseQuantity;
    }

    public function setBaseQuantity(int $baseQuantity): self
    {
        $this->baseQuantity = $baseQuantity;

        return $this;
    }

    public function getOfferedQuantity(): ?int
    {
        return $this->offeredQuantity;
    }

    public function setOfferedQuantity(int $offeredQuantity): self
    {
        $this->offeredQuantity = $offeredQuantity;

        return $this;
    }

    public function getPopular(): ?bool
    {
        return $this->popular;
    }

    public function setPopular(bool $popular): self
    {
        $this->popular = $popular;

        return $this;
    }
}
