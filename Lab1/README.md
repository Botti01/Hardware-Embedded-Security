# Lab 1: Introduction to Verilog

## Introduction

In this lab, you will become familiar with Verilog and Hardware Description Languages (HDLs), which are used to design digital circuits. You'll begin by learning the basics, exploring how HDLs work, and understanding how they differ from traditional programming languages. After that, you'll apply this knowledge by building progressively more complex modules.

## Prerequisites

To complete this lab, you'll need a machine with a Linux-based operating system. You can use either a virtual machine or a dual-boot setup. The following instructions assume you're using a Debian-based distribution such as Ubuntu.

## Getting Started

Follow these steps to set up your environment:

**Update the package list and upgrade the system:**
    Open a terminal and run the following commands to ensure your system is up to date:
  ```bash
  sudo apt update
  sudo apt upgrade
  ```

**Install the required packages:**

- **Git:**
  `git` is a distributed version control system that you'll use to clone, push, and pull repositories throughout this course. Install Git by running:

  ```bash
  sudo apt install git
  ```

- **Icarus Verilog:**
  `Icarus Verilog` is a Verilog simulation tool that you'll use to compile and simulate your Verilog designs throughout this course. To install Icarus Verilog on your system, run the following command:

  ```bash
  sudo apt install iverilog
  ```

- **GTKWave:**
  `GTKWave` is a waveform viewer that you'll use to visualize and analyze the results of your Verilog simulations throughout this course. To install GTKWave on your system, run the following command:

  ```bash
  sudo apt install gtkwave
  ```


**Clone the Lab Repository:**
  Once Git is installed, you can clone the repository that contains all the necessary files for this lab:

  ```bash
  git clone <repository-url>
  ```

## Lab Exercises
  After completing the setup, proceed with the following exercises:
  - [Exercise 1: Introduction to Verilog and Digital Design](./Ex1_HDLIntro/README.md)
  - [Exercise 2: Building a Full Adder in Verilog](./Ex2_FullAdder/README.md)
  - [Exercise 3: Building a Ripple Carry Adder using Full Adders](./Ex3_RippleCarryAdder/README.md)
  - [Exercise 4: Building a Counter (Sequential Logic)](./Ex4_Counter/README.md)
