Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AA7112584F
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 16:09:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7D524060A;
	Wed, 11 Mar 2026 17:09:04 +0100 (CET)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by mails.dpdk.org (Postfix) with ESMTP id 8517B402E7
 for <dev@dpdk.org>; Wed, 11 Mar 2026 17:09:03 +0100 (CET)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-1279eced0b9so14797094c88.0
 for <dev@dpdk.org>; Wed, 11 Mar 2026 09:09:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773245342; cv=none;
 d=google.com; s=arc-20240605;
 b=DkgD+co58FCYA0xXHoJjpkPaVZQRvlexy+0bju5FEzDhIEQbgIHApDUrBxhQ9a58Wo
 YpwuDN5+oF0MXck76hJ2ta6EkPbRAhtEbOXYl3hM1uFuyPGE/J8OzQE48wgJgXF/Fk1i
 dPyvVDOhkNc/1+6Xw7HLuL2Ub3gjYAE6Le+Z84VvkXMy+CTWvoLFKLAT2tb/M/G4u8BK
 r9JCjA2PUdqgHY0KXdg24P5nx5LCQa0ccsCabPfzUK6bkkNKwgaHNb3GolR9ni6WCMP2
 i7wkVDKiw1f1UIggjukyBEq8pGqCqlx/D1/Y6L04Cdf6k2tNvUuPhMZNaJ/p3LGOOI8m
 6bPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ek0jeFDwClllHU09fwi47mRMr7O0z6eb3VXiyaLLdJY=;
 fh=vOacCA3KriQ8GbBGVTWOHptXo7Mn5YQ03NEfreP65yM=;
 b=S2q1Zy7uALdMUZfJR5QTOlwEzLBNacNkWeO99LFKPIG6IYadz0glh+QP2tpnbZK8Ys
 qEumqi/G7FYnJi3fBmmdSbJ2y4DjcPVVoNNcFFAGFUDKpbPq5VJ/PDelVqaKmHdRLu+T
 mNWxMIZqRi/eErf6/fNlMRPMMAvMOjGtjWP63zyCZ6ujj3Uk+9l6Fi5lEzBNtBueYinF
 JYaogVBg537lpqk9gZlf5qGwj6kN1pEpSLWQ53L6PNXmJZobP1Q6NLNWRdYbA86N+uOs
 zkaG2S/jY8wjGYQWdQiv6ZIdQ/43OS63ojgSD5wDglCPUG7neNjmzSwqyFjsbxFowIQY
 pqCw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773245342; x=1773850142; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ek0jeFDwClllHU09fwi47mRMr7O0z6eb3VXiyaLLdJY=;
 b=WM2I+u+zFz6rX9omICF9OvLQ4KmLEnwIyWV3yRTbnfkzsgZM1OQWZiL16uznMF7g5j
 zfcnlkgKbYkK/wv5V+a2COzQicbt74y0lAAP3leK4j/vz4T/Rj7BWWeJeZ+yLSK19KU4
 fYKv6TX2O5nl0sJbUF4oxgHxiKjUn6bRkKrXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773245342; x=1773850142;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ek0jeFDwClllHU09fwi47mRMr7O0z6eb3VXiyaLLdJY=;
 b=E/h2PGlBtXIvXQld6yqu+9QEw4TKocb/WvY05bbqhSgbcFljG2JsAp5+4V7YBksh2i
 xaggEb+35+Vt5p/+62ymJpzSfy8rR6casAdYp48ap3NP6TrdIMroILG86hBqfzF9VGhr
 5u+WA3BVomRqdO4OnWpu6qXbxi3mtOl9+kC/Ok2HjPu7PXkg0ZxXI92QVdlO26pdAUsn
 mauLYHzobi89HQXe3ZLaedSHVjavCputvuYz7k2Kt3oWQlESlkvU8WXyaWGtJydaEqxS
 spY5/s0UDe69G/ij8iuRJ+kyz0mQVmIKA8qzTIbpcN+PFQkQIgy61pJ5ZAIFoKllef4G
 p36A==
X-Gm-Message-State: AOJu0Yx8DHaI56ke/8qA9e4JrsYjpLfuy4aZoU/CUSBZBIghK5tr+G4p
 xX9zLXPXmXd3fnjBNk/avmGdrTYKgeFqqfQNha87QTWo9QroQERAP9W0K3lZjuKRWuu+LefYDSs
 96AIJ9FoneM7PgHv5BLCyLFFUFjM8iZwYBc75o0rxTg==
X-Gm-Gg: ATEYQzxSJa0db2CVKYKOc8gUhRbR9k5DgpCopml4VOrkIYKbhG2duPuAN5MY5ur3D5o
 N9Yz31dUeTHBteGdGV5cUId0GuOy52pzPXYII2iISP7qZi3VxiiI9l1+uJyaigCUtp/Jh0VNOhQ
 8+S8HQI/eF8B36g6x3OsMnjeFjnPkUCwDwX/8K0mvgHx/DwXMO5K9Xc5Zd4EhrX9/QT/ZVTg9q/
 u3lHpzeGRd7CGD9c56WTNeqGyc8f0vfh8g/x3vFjsdjAMr36ROkIkKjCmTViUJqvrK+JypgP2Eq
 y+q/CznF3p9xroOzGZtQyvZCOPnXRtYqtM3L42e/uglSxSvhANUu48zvkACdGFcoiApcdd7T
X-Received: by 2002:a05:7022:4392:b0:127:9e95:a2f with SMTP id
 a92af1059eb24-128e77cc5a2mr1329347c88.2.1773245342229; Wed, 11 Mar 2026
 09:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250820140651.39604-1-dmarx@iol.unh.edu>
 <20260311160307.441948-1-probb@iol.unh.edu>
 <20260311160307.441948-2-probb@iol.unh.edu>
In-Reply-To: <20260311160307.441948-2-probb@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 11 Mar 2026 12:05:58 -0400
X-Gm-Features: AaiRm50aZwiSRj3Fa6LkNaQw2klrMVdSPFypjFLlEkVF1rb11Cuzoih_ksGTgdo
Message-ID: <CAJvnSUCEv_2BOOqb8gM_XDF6A0ZJrFWgtQYLh7p=hVROogXKnQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] dts: rewrite two link topology requirements
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, abailey@iol.unh.edu, 
 manjunathgouda.hosamani@intel.com, Paul.Szczepanek@arm.com, 
 thomas@monjalon.net
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

This is the final version of this series. I ran Andrew's v5 across all
of the testcases in DTS and discovered 2 testcases which require the
two link topology because they have hardcoded steps involving port 1.
During the next release Dean or Andrew will update these so that they
are actually tolerant to a single link DTS setup, but for now I'm just
decorating them according to the code as it exists. Provided that this
passes the CI checks I will merge to next-dts.

On Wed, Mar 11, 2026 at 12:06=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> w=
rote:
>
> From: Andrew Bailey <abailey@iol.unh.edu>
>
> Some of the DTS test suites require two link topologies
> in order to run, but not all truly require two links
> for proper testing. Rewrite the topology requirements
> on these test suites to reflect the actual
> requirements.
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> Reviewed-by: Patrick Robb <probb@iol.unh.edu>
> ---
>  dts/framework/test_suite.py             | 8 ++++----
>  dts/tests/TestSuite_blocklist.py        | 3 ++-
>  dts/tests/TestSuite_checksum_offload.py | 3 ---
>  dts/tests/TestSuite_dual_vlan.py        | 2 ++
>  dts/tests/TestSuite_port_control.py     | 3 ---
>  dts/tests/TestSuite_uni_pkt.py          | 3 ---
>  dts/tests/TestSuite_vlan.py             | 2 +-
>  7 files changed, 9 insertions(+), 15 deletions(-)
>
> diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
> index e86096cefe..69ce26040a 100644
> --- a/dts/framework/test_suite.py
> +++ b/dts/framework/test_suite.py
> @@ -23,7 +23,7 @@
>  from ipaddress import IPv4Interface, IPv6Interface, ip_interface
>  from pkgutil import iter_modules
>  from types import ModuleType
> -from typing import TYPE_CHECKING, ClassVar, Protocol, TypeVar, Union, ca=
st
> +from typing import TYPE_CHECKING, Any, ClassVar, Protocol, TypeVar, Unio=
n, cast
>
>  from scapy.layers.inet import IP
>  from scapy.packet import Packet
> @@ -332,11 +332,11 @@ def _decorator(func: TestSuiteMethodType) -> type[T=
estCase]:
>
>
>  #: The decorator for functional test cases.
> -func_test: Callable =3D TestCase.make_decorator(TestCaseType.FUNCTIONAL)
> +func_test: Callable[[Any], type["TestCase"]] =3D TestCase.make_decorator=
(TestCaseType.FUNCTIONAL)
>  #: The decorator for performance test cases.
> -perf_test: Callable =3D TestCase.make_decorator(TestCaseType.PERFORMANCE=
)
> +perf_test: Callable[[Any], type["TestCase"]] =3D TestCase.make_decorator=
(TestCaseType.PERFORMANCE)
>  #: The decorator for cryptography test cases.
> -crypto_test: Callable =3D TestCase.make_decorator(TestCaseType.CRYPTO)
> +crypto_test: Callable[[Any], type["TestCase"]] =3D TestCase.make_decorat=
or(TestCaseType.CRYPTO)
>
>
>  @dataclass
> diff --git a/dts/tests/TestSuite_blocklist.py b/dts/tests/TestSuite_block=
list.py
> index ba37f39ab3..c57231de22 100644
> --- a/dts/tests/TestSuite_blocklist.py
> +++ b/dts/tests/TestSuite_blocklist.py
> @@ -16,7 +16,6 @@
>  from framework.testbed_model.port import Port
>
>
> -@requires_link_topology(LinkTopology.TWO_LINKS)
>  class TestBlocklist(TestSuite):
>      """DPDK device blocklisting test suite."""
>
> @@ -45,6 +44,7 @@ def no_blocklisted(self) -> None:
>          """
>          self._verify_blocklisted_ports([])
>
> +    @requires_link_topology(LinkTopology.TWO_LINKS)
>      @func_test
>      def one_port_blocklisted(self) -> None:
>          """Run testpmd with one blocklisted port.
> @@ -57,6 +57,7 @@ def one_port_blocklisted(self) -> None:
>          """
>          self._verify_blocklisted_ports(self.topology.sut_ports[:1])
>
> +    @requires_link_topology(LinkTopology.TWO_LINKS)
>      @func_test
>      def all_but_one_port_blocklisted(self) -> None:
>          """Run testpmd with all but one blocklisted port.
> diff --git a/dts/tests/TestSuite_checksum_offload.py b/dts/tests/TestSuit=
e_checksum_offload.py
> index 394a73c31d..90ca798e56 100644
> --- a/dts/tests/TestSuite_checksum_offload.py
> +++ b/dts/tests/TestSuite_checksum_offload.py
> @@ -20,9 +20,7 @@
>  from scapy.packet import Packet, Raw
>
>  from api.capabilities import (
> -    LinkTopology,
>      NicCapability,
> -    requires_link_topology,
>      requires_nic_capability,
>  )
>  from api.packet import send_packet_and_capture
> @@ -33,7 +31,6 @@
>  from framework.test_suite import TestSuite, func_test
>
>
> -@requires_link_topology(LinkTopology.TWO_LINKS)
>  @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_IPV4_CKSUM)
>  @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_UDP_CKSUM)
>  @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_TCP_CKSUM)
> diff --git a/dts/tests/TestSuite_dual_vlan.py b/dts/tests/TestSuite_dual_=
vlan.py
> index 860eae7424..1b77dd2b47 100644
> --- a/dts/tests/TestSuite_dual_vlan.py
> +++ b/dts/tests/TestSuite_dual_vlan.py
> @@ -18,6 +18,7 @@
>  from scapy.layers.l2 import Dot1Q, Ether
>  from scapy.packet import Packet, Raw
>
> +from api.capabilities import LinkTopology, requires_link_topology
>  from api.packet import send_packet_and_capture
>  from api.test import verify
>  from api.testpmd import TestPmd
> @@ -161,6 +162,7 @@ def _configure_testpmd(self, shell: TestPmd, options:=
 TestCaseOptions, add: bool
>          if self.TestCaseOptions.VLAN_STRIP in options:
>              shell.set_vlan_strip(self.rx_port, add)
>
> +    @requires_link_topology(LinkTopology.TWO_LINKS)
>      @func_test
>      def insert_second_vlan(self) -> None:
>          """Test that a packet with a single VLAN can have an additional =
one inserted into it.
> diff --git a/dts/tests/TestSuite_port_control.py b/dts/tests/TestSuite_po=
rt_control.py
> index d9cc5ff4c9..6be47838d0 100644
> --- a/dts/tests/TestSuite_port_control.py
> +++ b/dts/tests/TestSuite_port_control.py
> @@ -13,9 +13,7 @@
>  from scapy.packet import Packet, Raw
>
>  from api.capabilities import (
> -    LinkTopology,
>      NicCapability,
> -    requires_link_topology,
>      requires_nic_capability,
>  )
>  from api.packet import send_packets_and_capture
> @@ -26,7 +24,6 @@
>
>
>  @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
> -@requires_link_topology(LinkTopology.TWO_LINKS)
>  class TestPortControl(TestSuite):
>      """DPDK Port Control Testing Suite."""
>
> diff --git a/dts/tests/TestSuite_uni_pkt.py b/dts/tests/TestSuite_uni_pkt=
.py
> index 97d61cd03a..222276ce67 100644
> --- a/dts/tests/TestSuite_uni_pkt.py
> +++ b/dts/tests/TestSuite_uni_pkt.py
> @@ -20,9 +20,7 @@
>  from scapy.packet import Packet, Raw
>
>  from api.capabilities import (
> -    LinkTopology,
>      NicCapability,
> -    requires_link_topology,
>      requires_nic_capability,
>  )
>  from api.packet import send_packet_and_capture
> @@ -33,7 +31,6 @@
>  from framework.test_suite import TestSuite, func_test
>
>
> -@requires_link_topology(LinkTopology.TWO_LINKS)
>  class TestUniPkt(TestSuite):
>      """DPDK Unified packet test suite.
>
> diff --git a/dts/tests/TestSuite_vlan.py b/dts/tests/TestSuite_vlan.py
> index 2c5abd68bf..898673fc86 100644
> --- a/dts/tests/TestSuite_vlan.py
> +++ b/dts/tests/TestSuite_vlan.py
> @@ -29,7 +29,6 @@
>
>
>  @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_VLAN_FILTER)
> -@requires_link_topology(LinkTopology.TWO_LINKS)
>  class TestVlan(TestSuite):
>      """DPDK VLAN test suite.
>
> @@ -178,6 +177,7 @@ def vlan_no_receipt(self) -> None:
>              testpmd.start()
>              self._send_vlan_packet_and_verify(should_receive=3DFalse, st=
rip=3DFalse, vlan_id=3D2)
>
> +    @requires_link_topology(LinkTopology.TWO_LINKS)
>      @func_test
>      def vlan_header_insertion(self) -> None:
>          """Ensure that VLAN packet is received with the correct inserted=
 VLAN tag.
> --
> 2.49.0
>
