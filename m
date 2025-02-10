Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1186FC021A1
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 19:42:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4CE9402A1;
	Mon, 10 Feb 2025 20:42:37 +0100 (CET)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
 [209.85.208.181])
 by mails.dpdk.org (Postfix) with ESMTP id 46EBB4021E
 for <dev@dpdk.org>; Mon, 10 Feb 2025 20:42:36 +0100 (CET)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-307e067f236so3176801fa.0
 for <dev@dpdk.org>; Mon, 10 Feb 2025 11:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1739216555; x=1739821355; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k14JrcnX4wzcj5ecER8H4mcAU6o68V3w0zHL2mfZU5w=;
 b=JjnTh75vf00EINn1uU7dEkklaxm99y0hDblI+XAwE0JjyclXByIDf8lTsD1cVfxjhp
 QTxCvKvSpnafhdBZ6XfCxff4blqcH0EvRjGABe0IOAH/6uz934+/FllKsdqkAZkuTL5N
 nBhrEgxXoC6Oro/NZ2Bk6iNGPG4pLCnpUcMOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739216555; x=1739821355;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k14JrcnX4wzcj5ecER8H4mcAU6o68V3w0zHL2mfZU5w=;
 b=cpq1l8hwUv0uCryF6tC1SYIQUG/6TBXpgOGraSfbQQUvkrKFCZNBCPgtl/yQxDwHm9
 HWUAfShPvKhjWtfCAHBEiYK6AhyqJ4BepDfPr5jCI7rc7nC9qjSDohdQVfy2dcx2Ljzg
 zZd+qnviZ08S3yItFQkoxVbggpSM9vUx01qA7kfkPIry7z6gB6Mxd6i/AY4K8cGSHQ+t
 z0DlV1PD3Jz/nzmDVZq01//6cnDzeH1hv/9jW0rrL6o1AEUypQUvyDV/ywhka+z65AaU
 yxtf+6GgweJbIe0B8D0RID81/G+7HuOuJw3fMoTFNYN089MXGHLkhXY93XtFxPXJzDwu
 IgEg==
X-Gm-Message-State: AOJu0YyMG3wQHRlM1heFBrJK1D9IKc66qZEYPlrEolzyxahJKaGEyHRz
 hx0M4kqDJqzJ185M8DMxaQueIqz5t8HsyMrlSS8TDVVwR76kyCoEUTbypnzuc3oHCtnWBSExuf2
 PHd860A8EkV6oGq7BUXwsrzfLHH9gr70rZhM/hg==
X-Gm-Gg: ASbGncum0javyCISaDW+8UpFkI81mP2Ukc3tp7ovKYgL/xZpiD5XLZklntVE3OE+R1q
 RO3g5XrO1DS61Mdc9rSa4VKwgD35KdjsOZxN3QQidGOkGx6Qo7y6JZWcjJKYPHUPZJ9/5Ouu93f
 mRHUYJpLgQ0kvH5Wni6EQmoqE16IeMdR8=
X-Google-Smtp-Source: AGHT+IGSkWiDCCB9OynkDXH/B9rtI3d0+3drO6uvPrM8S4k1vYJYE/pJVLuYRu1uyjpx9jmY9M+khq76uWNyisU/+xs=
X-Received: by 2002:a2e:a548:0:b0:308:ee65:7f40 with SMTP id
 38308e7fff4ca-308ee65851dmr7151151fa.2.1739216555358; Mon, 10 Feb 2025
 11:42:35 -0800 (PST)
MIME-Version: 1.0
References: <20250203151613.2436570-1-luca.vizzarro@arm.com>
 <20250203151613.2436570-4-luca.vizzarro@arm.com>
In-Reply-To: <20250203151613.2436570-4-luca.vizzarro@arm.com>
From: Nicholas Pratte <npratte@iol.unh.edu>
Date: Mon, 10 Feb 2025 14:42:24 -0500
X-Gm-Features: AWEUYZnaPfNVnG5_0IOrt7IwiO2xxcRZgwE-HAcvI50w3ptb1EhblMdGpx-ZplY
Message-ID: <CAKXZ7ejE83ODLObphUZ6i-n+CW-TmE+hes75t6wM0Q3fV+wAxw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] dts: revamp Topology model
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Patrick Robb <probb@iol.unh.edu>, 
 Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Reviewed-by: Nicholas Pratte <npratte@iol.unh.edu>

On Mon, Feb 3, 2025 at 10:17=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.co=
m> wrote:
>
> Change the Topology model to add further flexility in its usage as a
> standalone entry point to test suites.
>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
> ---
>  dts/framework/testbed_model/topology.py | 85 +++++++++++++------------
>  1 file changed, 45 insertions(+), 40 deletions(-)
>
> diff --git a/dts/framework/testbed_model/topology.py b/dts/framework/test=
bed_model/topology.py
> index 814c3f3fe4..cf5c2c28ba 100644
> --- a/dts/framework/testbed_model/topology.py
> +++ b/dts/framework/testbed_model/topology.py
> @@ -9,10 +9,12 @@
>  """
>
>  from collections.abc import Iterator
> +from dataclasses import dataclass
>  from enum import Enum
>  from typing import NamedTuple
>
> -from framework.config.node import PortConfig
> +from typing_extensions import Self
> +
>  from framework.exception import ConfigurationError
>
>  from .port import Port
> @@ -43,35 +45,32 @@ class PortLink(NamedTuple):
>      tg_port: Port
>
>
> +@dataclass(frozen=3DTrue)
>  class Topology:
>      """Testbed topology.
>
>      The topology contains ports processed into ingress and egress ports.
> -    If there are no ports on a node, dummy ports (ports with no actual v=
alues) are stored.
> -    If there is only one link available, the ports of this link are stor=
ed
> +    If there are no ports on a node, accesses to :attr:`~Topology.tg_por=
t_egress` and alike will
> +    raise an exception. If there is only one link available, the ports o=
f this link are stored
>      as both ingress and egress ports.
>
> -    The dummy ports shouldn't be used. It's up to :class:`~framework.run=
ner.DTSRunner`
> -    to ensure no test case or suite requiring actual links is executed
> -    when the topology prohibits it and up to the developers to make sure=
 that test cases
> -    not requiring any links don't use any ports. Otherwise, the underlyi=
ng methods
> -    using the ports will fail.
> +    It's up to :class:`~framework.test_run.TestRun` to ensure no test ca=
se or suite requiring actual
> +    links is executed when the topology prohibits it and up to the devel=
opers to make sure that test
> +    cases not requiring any links don't use any ports. Otherwise, the un=
derlying methods using the
> +    ports will fail.
>
>      Attributes:
>          type: The type of the topology.
> -        tg_port_egress: The egress port of the TG node.
> -        sut_port_ingress: The ingress port of the SUT node.
> -        sut_port_egress: The egress port of the SUT node.
> -        tg_port_ingress: The ingress port of the TG node.
> +        sut_ports: The SUT ports.
> +        tg_ports: The TG ports.
>      """
>
>      type: TopologyType
> -    tg_port_egress: Port
> -    sut_port_ingress: Port
> -    sut_port_egress: Port
> -    tg_port_ingress: Port
> +    sut_ports: list[Port]
> +    tg_ports: list[Port]
>
> -    def __init__(self, port_links: Iterator[PortLink]):
> +    @classmethod
> +    def from_port_links(cls, port_links: Iterator[PortLink]) -> Self:
>          """Create the topology from `port_links`.
>
>          Args:
> @@ -80,34 +79,40 @@ def __init__(self, port_links: Iterator[PortLink]):
>          Raises:
>              ConfigurationError: If an unsupported link topology is suppl=
ied.
>          """
> -        dummy_port =3D Port(
> -            "",
> -            PortConfig(
> -                name=3D"dummy",
> -                pci=3D"0000:00:00.0",
> -                os_driver_for_dpdk=3D"",
> -                os_driver=3D"",
> -            ),
> -        )
> -
> -        self.type =3D TopologyType.no_link
> -        self.tg_port_egress =3D dummy_port
> -        self.sut_port_ingress =3D dummy_port
> -        self.sut_port_egress =3D dummy_port
> -        self.tg_port_ingress =3D dummy_port
> +        type =3D TopologyType.no_link
>
>          if port_link :=3D next(port_links, None):
> -            self.type =3D TopologyType.one_link
> -            self.tg_port_egress =3D port_link.tg_port
> -            self.sut_port_ingress =3D port_link.sut_port
> -            self.sut_port_egress =3D self.sut_port_ingress
> -            self.tg_port_ingress =3D self.tg_port_egress
> +            type =3D TopologyType.one_link
> +            sut_ports =3D [port_link.sut_port]
> +            tg_ports =3D [port_link.tg_port]
>
>              if port_link :=3D next(port_links, None):
> -                self.type =3D TopologyType.two_links
> -                self.sut_port_egress =3D port_link.sut_port
> -                self.tg_port_ingress =3D port_link.tg_port
> +                type =3D TopologyType.two_links
> +                sut_ports.append(port_link.sut_port)
> +                tg_ports.append(port_link.tg_port)
>
>                  if next(port_links, None) is not None:
>                      msg =3D "More than two links in a topology are not s=
upported."
>                      raise ConfigurationError(msg)
> +
> +        return cls(type, sut_ports, tg_ports)
> +
> +    @property
> +    def tg_port_egress(self) -> Port:
> +        """The egress port of the TG node."""
> +        return self.tg_ports[0]
> +
> +    @property
> +    def sut_port_ingress(self) -> Port:
> +        """The ingress port of the SUT node."""
> +        return self.sut_ports[0]
> +
> +    @property
> +    def sut_port_egress(self) -> Port:
> +        """The egress port of the SUT node."""
> +        return self.sut_ports[1 if self.type is TopologyType.two_links e=
lse 0]
> +
> +    @property
> +    def tg_port_ingress(self) -> Port:
> +        """The ingress port of the TG node."""
> +        return self.tg_ports[1 if self.type is TopologyType.two_links el=
se 0]
> --
> 2.43.0
>
