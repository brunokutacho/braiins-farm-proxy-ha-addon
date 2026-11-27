# Braiins Farm Proxy – add-on para Home Assistant (não oficial)

[English](README.md)

Roda o [Braiins Farm Proxy](https://academy.braiins.com/farm-proxy/sv2-proxy/) no Home Assistant OS.
Suas mineradoras se conectam ao proxy na sua rede local, e o proxy fala com a Braiins Pool em **Stratum V2**
(criptografado e autenticado), em vez do Stratum V1 sem criptografia que permite o
[sequestro de hashrate](https://braiins.com/blog/bitcoin-hashrate-hijacking-unencrypted-stratum-v1).

> **Não oficial.** Este projeto não é feito, apoiado nem suportado pela Braiins. O binário do proxy **não** está neste repositório:
> ele é baixado de `downloads.braiins.com` quando o add-on é construído, e o SHA-256 é conferido contra o valor fixado no `Dockerfile`.
> Leia os termos da própria Braiins para o proxy antes de usar.

## Status
- Testado em um Raspberry Pi 5 com Home Assistant OS (aarch64) e uma Bitaxe.
- `amd64` é construído do mesmo jeito, mas **não foi testado**.
- Versão do Braiins Farm Proxy incluída: 0.1.1.

## Instalação
[![Add this repository to your Home Assistant](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fbrunokutacho%2Fbraiins-farm-proxy-ha-addon)

Clique no botão acima (ele abre o seu Home Assistant), confirme e depois instale
**Braiins Farm Proxy (SV2)** na Loja de add-ons.

Ou faça à mão: **Configurações → Add-ons** (chamado **Apps** nas versões recentes) **→ Loja → ⋮ → Repositórios**,
adicione `https://github.com/brunokutacho/braiins-farm-proxy-ha-addon` e instale o add-on. O primeiro build leva alguns minutos, porque acontece no seu aparelho.

Depois defina `web_password` na aba **Configuração**, inicie o add-on e siga a [documentação](braiins_sv2_proxy/DOCS.md).

## Como funciona
- O `braiins-proxy run` não tem opção de senha, e pedidos vindos de loopback não pedem senha. Por isso a interface web do proxy escuta
  só em `127.0.0.1:8081` dentro do container, e o **nginx** a publica na porta 8080 com senha.
  Com `web_password` vazia, a interface web não é exposta.
- As mineradoras conectam na porta 3333.
- O proxy roda como usuário comum; a configuração fica em `/data` do add-on.

## Segurança
- Mineradora → proxy é Stratum V1 em texto puro na sua rede. Mantenha o proxy numa rede confiável e não encaminhe a porta 3333 para a internet.
- A porta 3333 não tem autenticação. Tire qualquer pool direto do pool de reserva das mineradoras, ou o proxy pode ser contornado.
- A interface web usa autenticação básica sobre HTTP simples.

## Contribuindo
Contribuições são bem-vindas: relatos de problemas, testes em outros equipamentos e mineradoras, documentação, traduções e código.
Leia o [CONTRIBUTING.md](CONTRIBUTING.md) (em inglês) antes. Problemas de segurança: veja o [SECURITY.md](SECURITY.md).
Ao participar você concorda com o [código de conduta](CODE_OF_CONDUCT.md).

Mantenedor: [Bruno Kutacho](https://github.com/brunokutacho).

## Licença
MIT para os arquivos deste repositório (veja [LICENSE](LICENSE)). Não cobre o Braiins Farm Proxy.
