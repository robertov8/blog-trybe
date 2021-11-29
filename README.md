<div id="top"></div>

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/robertov8/blog-trybe">
    <img src="assets/logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Blog</h3>

  <p align="center">
    A simple API project for blogs
    <br />
    <a href="https://sordid-toe.surge.sh/"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/robertov8/blog-trybe">Report Bug</a>
    ·
    <a href="https://github.com/robertov8/blog-trybe">Request Feature</a>
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#learn-more">Learn more</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

This blog CRUD project is a technical test that tests elixir language skills.
<p align="right">(<a href="#top">back to top</a>)</p>


## Getting Started

Below are the instructions on how to install the necessary tools and run the environment locally

### Prerequisites

Install asdf to have elixir and erlang available in the terminal and install docker

With the tools installed, run the commands below to have a compatible environment

- [asdf](https://asdf-vm.com/guide/getting-started.html#_2-download-asdf)
- [docker](https://docs.docker.com/engine/install/ubuntu/)
- [docker-compose](https://docs.docker.com/compose/install/)

```bash
# https://github.com/asdf-vm/asdf-erlang
asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git

asdf elixir 1.12.3
asdf erlang 24.0.5
```

<p align="right">(<a href="#top">back to top</a>)</p>

### Installation

To start your Phoenix server:

* Run docker services `docker-compose up`
* Install dependencies with `mix deps.get`
* Create and migrate your database with `mix ecto.setup`
* Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- USAGE EXAMPLES -->
## [Usage](docs/USAGE.md)

The link above contains detailed information on all routes and form of authentication.

<p align="right">(<a href="#top">back to top</a>)</p>

## Learn more

* Official website: https://www.phoenixframework.org/
* Guides: https://hexdocs.pm/phoenix/overview.html
* Docs: https://hexdocs.pm/phoenix
* Forum: https://elixirforum.com/c/phoenix-forum
* Source: https://github.com/phoenixframework/phoenix
