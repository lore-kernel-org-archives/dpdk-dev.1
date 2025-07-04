Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211FBC83030
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Jul 2025 04:29:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A55940651;
	Fri,  4 Jul 2025 06:29:23 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id A881D40654
 for <dev@dpdk.org>; Fri,  4 Jul 2025 06:29:21 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-23c840a5fe7so4814715ad.2
 for <dev@dpdk.org>; Thu, 03 Jul 2025 21:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1751603361; x=1752208161; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g3ZYlS3dg1+WKeYXY9BracL+bOuKUSXXeRPidZNwiBU=;
 b=AaVC5qu+T3RmEy8beEODhipOIjmkArGNRv/3+JpGkyQPGmNQeIO4qtsQaEywUmVW9S
 JsFBfyZ+MCWCfuVsnJ447WBCxbvzKwL+ISmDAMJZpASgDWTiGoszxUCKrirQ83MPmWz8
 ZxKimcvP2GvGmXEofkzlYumicrzYijYbceFiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751603361; x=1752208161;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g3ZYlS3dg1+WKeYXY9BracL+bOuKUSXXeRPidZNwiBU=;
 b=BgK5saFKrUdNnlAExNRh1V1srkCB/WzYcGcWgk+64ekoF/v6sc4rLt8YZkAvoRx/Bc
 vOu2JVSlP3N8Ljkjb61pz4fnrfwcgpEIcOeb8zy0mCgk9vXXeo/vRDWCcoUXAyCVQQ7w
 ZBcj1M+/FU6NbZw4Pzkqbk6P4hGVKq2X50WYgC8Hz9VgQFD+qCFFz3yR/O4FaLgD5WY8
 Hejhu+B1dEjtd3FVVvpx39doiY/NIh3E3bqsq737JHgDub+4yaaaqkjxnoRMEe/p6Fr8
 b7pW2gxvWu6eqU3GjyE+tSA3ni2kWYeTEBQJ1Degf13ezsEkfY40P8U4QRpVrmtSR0pu
 0ohA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd/tydqzRhe3OmAscoLqyF/ixUYE9aJVUwjREtiZIFFFHvTwCQPbS5Wpy5FaPYUXITqsI=@dpdk.org
X-Gm-Message-State: AOJu0Ywyh0fWU0y6j6hGp+7941M70eYfHgZ4ve26mwjt1iQ0KnX8mZvs
 VIO6MfFm+NGr6+1bDaZh/NTg+UIdusH/nvC/1qTCozl0mS7DpECSr2CDC22myDjlE4QpyDGhlTO
 WeSA5b1W9/3SSGsRvMJnEqiq30gHfgPEoNDivKHGLvQ==
X-Gm-Gg: ASbGnctZNTdZh7wKCcidKhV7GqBlsSlXNTrqnsy2CP8F4yjhzz0xGPP5WLnKvFJkRUI
 wj8DYtr2CEQ+jSjDUJFIZ11KUXwYfidCDmospIuGi9+Lh3d3qbfBREPpAsRHFYrwbRVj6FbP8zR
 ZzvDUjEpE0OnZ8u1lnEJ6hCipxgBqxdTzzH553VkDRQ8uJ0GvlNQQizf2YMiY=
X-Google-Smtp-Source: AGHT+IG7/+hoc0dk7FwEwDOSkPsld3YFQS4nXOY6LRu6dS8S6jWV5/8KuGn++LBTvJmWhOQxICDujuHbV0cAWSH3iUI=
X-Received: by 2002:a17:903:90d:b0:234:8ec1:4af1 with SMTP id
 d9443c01a7336-23c85fa19f6mr19955075ad.0.1751603360808; Thu, 03 Jul 2025
 21:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250626152755.197560-3-dmarx@iol.unh.edu>
 <20250702162331.352313-1-dmarx@iol.unh.edu>
 <20250702162331.352313-3-dmarx@iol.unh.edu>
In-Reply-To: <20250702162331.352313-3-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 4 Jul 2025 00:23:43 -0400
X-Gm-Features: Ac12FXx0soIjbWOhhJ9zARDKbk-QDMfhX2ZHWPOKgSg90HlCK4npXq_IFoipxsw
Message-ID: <CAJvnSUDR-T_u-PTy1jovzusZzoQ9znkQVFza9VACNAa65gY3fg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] dts: add physical function capability check
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000001bd5e3063912f038"
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

--0000000000001bd5e3063912f038
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 12:23=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote=
:

> Add a physical function NIC capability that checks
> if the test run is using PFs. Add PF capability
> requirement to all suites/cases that do not
> run without error on virtual functions.
>
> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> ---
>  dts/framework/remote_session/testpmd_shell.py | 22 +++++++++++++++++++
>  dts/tests/TestSuite_dynamic_config.py         |  3 ++-
>  dts/tests/TestSuite_dynamic_queue_conf.py     |  1 +
>  dts/tests/TestSuite_l2fwd.py                  |  3 ++-
>  dts/tests/TestSuite_mac_filter.py             |  1 +
>  dts/tests/TestSuite_mtu.py                    |  4 +++-
>  dts/tests/TestSuite_pmd_buffer_scatter.py     |  1 +
>  dts/tests/TestSuite_port_control.py           |  3 ++-
>  dts/tests/TestSuite_port_stats.py             |  2 ++
>  dts/tests/TestSuite_promisc_support.py        |  4 +++-
>  dts/tests/TestSuite_rte_flow.py               |  1 +
>  dts/tests/TestSuite_softnic.py                |  3 ++-
>  dts/tests/TestSuite_uni_pkt.py                |  2 ++
>  13 files changed, 44 insertions(+), 6 deletions(-)
>
> diff --git a/dts/framework/remote_session/testpmd_shell.py
> b/dts/framework/remote_session/testpmd_shell.py
> index 6d75f89969..ad8cb273dc 100644
> --- a/dts/framework/remote_session/testpmd_shell.py
> +++ b/dts/framework/remote_session/testpmd_shell.py
> @@ -2655,6 +2655,23 @@ def get_capabilities_flow_ctrl(
>          else:
>              unsupported_capabilities.add(NicCapability.FLOW_CTRL)
>
> +    def get_capabilities_physical_function(
> +        self,
> +        supported_capabilities: MutableSet["NicCapability"],
> +        unsupported_capabilities: MutableSet["NicCapability"],
> +    ) -> None:
> +        """Store capability representing a physical function test run.
> +
> +        Args:
> +            supported_capabilities: Supported capabilities will be added
> to this set.
> +            unsupported_capabilities: Unsupported capabilities will be
> added to this set.
> +        """
> +        ctx =3D get_ctx()
> +        if ctx.topology.vf_ports =3D=3D []:
> +            supported_capabilities.add(NicCapability.PHYSICAL_FUNCTION)
> +        else:
> +            unsupported_capabilities.add(NicCapability.PHYSICAL_FUNCTION=
)
> +
>

Another option would be to read directly from
config.virtual_functions_testrun. But, it's the same thing at the end of
the day.


>
>  class NicCapability(NoAliasEnum):
>      """A mapping between capability names and the associated
> :class:`TestPmdShell` methods.
> @@ -2803,6 +2820,11 @@ class NicCapability(NoAliasEnum):
>      )
>      #: Device supports flow ctrl.
>      FLOW_CTRL: TestPmdShellNicCapability =3D
> (TestPmdShell.get_capabilities_flow_ctrl, None)
> +    #: Device is running on a physical function.
> +    PHYSICAL_FUNCTION: TestPmdShellNicCapability =3D (
> +        TestPmdShell.get_capabilities_physical_function,
> +        None,
> +    )
>
>      def __call__(
>          self,
> diff --git a/dts/tests/TestSuite_dynamic_config.py
> b/dts/tests/TestSuite_dynamic_config.py
> index 1fce31a0b5..49f295a39a 100644
> --- a/dts/tests/TestSuite_dynamic_config.py
> +++ b/dts/tests/TestSuite_dynamic_config.py
> @@ -20,11 +20,12 @@
>  from scapy.packet import Raw
>
>  from framework.params.testpmd import SimpleForwardingModes
> -from framework.remote_session.testpmd_shell import TestPmdShell
> +from framework.remote_session.testpmd_shell import NicCapability,
> TestPmdShell
>  from framework.test_suite import TestSuite, func_test
>  from framework.testbed_model.capability import TopologyType, requires
>
>
> +@requires(NicCapability.PHYSICAL_FUNCTION)
>  @requires(topology_type=3DTopologyType.two_links)
>  class TestDynamicConfig(TestSuite):
>      """Dynamic config suite.
> diff --git a/dts/tests/TestSuite_dynamic_queue_conf.py
> b/dts/tests/TestSuite_dynamic_queue_conf.py
> index 344dd540eb..f8c7dbfb71 100644
> --- a/dts/tests/TestSuite_dynamic_queue_conf.py
> +++ b/dts/tests/TestSuite_dynamic_queue_conf.py
> @@ -117,6 +117,7 @@ def wrap(self: "TestDynamicQueueConf", is_rx_testing:
> bool) -> None:
>      return wrap
>
>
> +@requires(NicCapability.PHYSICAL_FUNCTION)
>  class TestDynamicQueueConf(TestSuite):
>      """DPDK dynamic queue configuration test suite.
>
> diff --git a/dts/tests/TestSuite_l2fwd.py b/dts/tests/TestSuite_l2fwd.py
> index 0555d75ed8..5ffa2dcd19 100644
> --- a/dts/tests/TestSuite_l2fwd.py
> +++ b/dts/tests/TestSuite_l2fwd.py
> @@ -9,7 +9,7 @@
>
>  from framework.context import filter_cores
>  from framework.params.testpmd import EthPeer, SimpleForwardingModes
> -from framework.remote_session.testpmd_shell import TestPmdShell
> +from framework.remote_session.testpmd_shell import NicCapability,
> TestPmdShell
>  from framework.test_suite import TestSuite, func_test
>  from framework.testbed_model.capability import requires
>  from framework.testbed_model.cpu import LogicalCoreCount
> @@ -17,6 +17,7 @@
>  from framework.utils import generate_random_packets
>
>
> +@requires(NicCapability.PHYSICAL_FUNCTION)
>  @requires(topology_type=3DTopologyType.two_links)
>  class TestL2fwd(TestSuite):
>      """L2 forwarding test suite."""
> diff --git a/dts/tests/TestSuite_mac_filter.py
> b/dts/tests/TestSuite_mac_filter.py
> index 9dbfec5da2..2387fdfac2 100644
> --- a/dts/tests/TestSuite_mac_filter.py
> +++ b/dts/tests/TestSuite_mac_filter.py
> @@ -25,6 +25,7 @@
>  from framework.testbed_model.capability import requires
>
>
> +@requires(NicCapability.PHYSICAL_FUNCTION)
>  class TestMacFilter(TestSuite):
>      """Mac address allowlist filtering test suite.
>
> diff --git a/dts/tests/TestSuite_mtu.py b/dts/tests/TestSuite_mtu.py
> index af6ab88501..d5b3fe02af 100644
> --- a/dts/tests/TestSuite_mtu.py
> +++ b/dts/tests/TestSuite_mtu.py
> @@ -17,8 +17,9 @@
>  from scapy.layers.l2 import Ether
>  from scapy.packet import Raw
>
> -from framework.remote_session.testpmd_shell import TestPmdShell
> +from framework.remote_session.testpmd_shell import NicCapability,
> TestPmdShell
>  from framework.test_suite import TestSuite, func_test
> +from framework.testbed_model.capability import requires
>
>  STANDARD_FRAME =3D 1518  # --max-pkt-len will subtract l2 information at=
 a
> minimum of 18 bytes.
>  JUMBO_FRAME =3D 9018
> @@ -30,6 +31,7 @@
>  VENDOR_AGNOSTIC_PADDING =3D 9  # Used as a work around for varying MTU
> definitions between vendors.
>
>
> +@requires(NicCapability.PHYSICAL_FUNCTION)
>  class TestMtu(TestSuite):
>      """DPDK PMD jumbo frames and MTU update test suite.
>
> diff --git a/dts/tests/TestSuite_pmd_buffer_scatter.py
> b/dts/tests/TestSuite_pmd_buffer_scatter.py
> index 5e23f28bc6..015163dd11 100644
> --- a/dts/tests/TestSuite_pmd_buffer_scatter.py
> +++ b/dts/tests/TestSuite_pmd_buffer_scatter.py
> @@ -28,6 +28,7 @@
>  from framework.testbed_model.capability import NicCapability, requires
>
>
> +@requires(NicCapability.PHYSICAL_FUNCTION)
>  @requires(NicCapability.RX_OFFLOAD_SCATTER)
>  class TestPmdBufferScatter(TestSuite):
>      """DPDK PMD packet scattering test suite.
> diff --git a/dts/tests/TestSuite_port_control.py
> b/dts/tests/TestSuite_port_control.py
> index ad5a09c58e..58783f1d18 100644
> --- a/dts/tests/TestSuite_port_control.py
> +++ b/dts/tests/TestSuite_port_control.py
> @@ -13,11 +13,12 @@
>  from scapy.packet import Packet, Raw
>
>  from framework.params.testpmd import SimpleForwardingModes
> -from framework.remote_session.testpmd_shell import TestPmdShell
> +from framework.remote_session.testpmd_shell import NicCapability,
> TestPmdShell
>  from framework.test_suite import TestSuite, func_test
>  from framework.testbed_model.capability import TopologyType, requires
>
>
> +@requires(NicCapability.PHYSICAL_FUNCTION)
>  @requires(topology_type=3DTopologyType.two_links)
>  class TestPortControl(TestSuite):
>      """DPDK Port Control Testing Suite."""
> diff --git a/dts/tests/TestSuite_port_stats.py
> b/dts/tests/TestSuite_port_stats.py
> index 2bb8747399..ddd28623b3 100644
> --- a/dts/tests/TestSuite_port_stats.py
> +++ b/dts/tests/TestSuite_port_stats.py
> @@ -19,6 +19,7 @@
>
>  from framework.params.testpmd import SimpleForwardingModes
>  from framework.remote_session.testpmd_shell import (
> +    NicCapability,
>      RtePTypes,
>      TestPmdShell,
>      TestPmdVerbosePacket,
> @@ -27,6 +28,7 @@
>  from framework.testbed_model.capability import TopologyType, requires
>
>
> +@requires(NicCapability.PHYSICAL_FUNCTION)
>  @requires(topology_type=3DTopologyType.two_links)
>  class TestPortStats(TestSuite):
>      """DPDK Port statistics testing suite.
> diff --git a/dts/tests/TestSuite_promisc_support.py
> b/dts/tests/TestSuite_promisc_support.py
> index 445f6e1d69..8a7a7efb57 100644
> --- a/dts/tests/TestSuite_promisc_support.py
> +++ b/dts/tests/TestSuite_promisc_support.py
> @@ -11,10 +11,12 @@
>  from scapy.layers.l2 import Ether
>  from scapy.packet import Raw
>
> -from framework.remote_session.testpmd_shell import TestPmdShell
> +from framework.remote_session.testpmd_shell import NicCapability,
> TestPmdShell
>  from framework.test_suite import TestSuite, func_test
> +from framework.testbed_model.capability import requires
>
>
> +@requires(NicCapability.PHYSICAL_FUNCTION)
>  class TestPromiscSupport(TestSuite):
>      """Promiscuous mode support test suite."""
>
> diff --git a/dts/tests/TestSuite_rte_flow.py
> b/dts/tests/TestSuite_rte_flow.py
> index e70f7ea8d1..4855e4261d 100644
> --- a/dts/tests/TestSuite_rte_flow.py
> +++ b/dts/tests/TestSuite_rte_flow.py
> @@ -316,6 +316,7 @@ def test_queue_action_IP(self) -> None:
>              test_queue=3D2,
>          )
>
> +    @requires(NicCapability.PHYSICAL_FUNCTION)
>      @func_test
>      def test_queue_action_L4(self) -> None:
>          """Validate flow rules with queue actions and TCP/UDP patterns.
> diff --git a/dts/tests/TestSuite_softnic.py
> b/dts/tests/TestSuite_softnic.py
> index c1873dca4c..27754c08e7 100644
> --- a/dts/tests/TestSuite_softnic.py
> +++ b/dts/tests/TestSuite_softnic.py
> @@ -9,7 +9,7 @@
>  from pathlib import Path, PurePath
>
>  from framework.params.testpmd import EthPeer
> -from framework.remote_session.testpmd_shell import TestPmdShell
> +from framework.remote_session.testpmd_shell import NicCapability,
> TestPmdShell
>  from framework.test_suite import TestSuite, func_test
>  from framework.testbed_model.capability import requires
>  from framework.testbed_model.topology import TopologyType
> @@ -17,6 +17,7 @@
>  from framework.utils import generate_random_packets
>
>
> +@requires(NicCapability.PHYSICAL_FUNCTION)
>  @requires(topology_type=3DTopologyType.two_links)
>  class TestSoftnic(TestSuite):
>      """Softnic test suite."""
> diff --git a/dts/tests/TestSuite_uni_pkt.py
> b/dts/tests/TestSuite_uni_pkt.py
> index fdb9c29059..690c5d4fd1 100644
> --- a/dts/tests/TestSuite_uni_pkt.py
> +++ b/dts/tests/TestSuite_uni_pkt.py
> @@ -20,6 +20,7 @@
>  from scapy.packet import Packet, Raw
>
>  from framework.remote_session.testpmd_shell import (
> +    NicCapability,
>      RtePTypes,
>      SimpleForwardingModes,
>      TestPmdShell,
> @@ -258,6 +259,7 @@ def test_nsh_packet_detect(self) -> None:
>          with TestPmdShell() as testpmd:
>              self.setup_session(testpmd=3Dtestpmd, expected_flags=3Dflag_=
list,
> packet_list=3Dpacket_list)
>
> +    @requires(NicCapability.PHYSICAL_FUNCTION)
>      @func_test
>      def test_vxlan_tunnel_packet_detect(self) -> None:
>          """Ensure the correct flags are shown in the verbose output when
> sending VXLAN packets.
> --
> 2.49.0
>
>
In principle some of the functions performed in these testsuites should be
possible via VFs.

As a follow up task in 25.11 we should assess this and see if the total
list of VF compatible testsuites can be extended.

Reviewed-by: Patrick Robb <probb@iol.unh.edu>
Tested-by: Patrick Robb <probb@iol.unh.edu>

--0000000000001bd5e3063912f038
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 2, 2025 =
at 12:23=E2=80=AFPM Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" targ=
et=3D"_blank">dmarx@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Add a physical function NIC capability tha=
t checks<br>
if the test run is using PFs. Add PF capability<br>
requirement to all suites/cases that do not<br>
run without error on virtual functions.<br>
<br>
Signed-off-by: Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" target=3D=
"_blank">dmarx@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/framework/remote_session/testpmd_shell.py | 22 ++++++++++++++++++=
+<br>
=C2=A0dts/tests/TestSuite_dynamic_config.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 3 ++-<br>
=C2=A0dts/tests/TestSuite_dynamic_queue_conf.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
1 +<br>
=C2=A0dts/tests/TestSuite_l2fwd.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 ++-<br>
=C2=A0dts/tests/TestSuite_mac_filter.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0dts/tests/TestSuite_mtu.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 +++-<br>
=C2=A0dts/tests/TestSuite_pmd_buffer_scatter.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
1 +<br>
=C2=A0dts/tests/TestSuite_port_control.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 3 ++-<br>
=C2=A0dts/tests/TestSuite_port_stats.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 2 ++<br>
=C2=A0dts/tests/TestSuite_promisc_support.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 4 +++-<br>
=C2=A0dts/tests/TestSuite_rte_flow.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0dts/tests/TestSuite_softnic.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 3 ++-<br>
=C2=A0dts/tests/TestSuite_uni_pkt.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 2 ++<br>
=C2=A013 files changed, 44 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/=
remote_session/testpmd_shell.py<br>
index 6d75f89969..ad8cb273dc 100644<br>
--- a/dts/framework/remote_session/testpmd_shell.py<br>
+++ b/dts/framework/remote_session/testpmd_shell.py<br>
@@ -2655,6 +2655,23 @@ def get_capabilities_flow_ctrl(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsupported_capabilities.ad=
d(NicCapability.FLOW_CTRL)<br>
<br>
+=C2=A0 =C2=A0 def get_capabilities_physical_function(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: MutableSet[&quot;NicCa=
pability&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: MutableSet[&quot;Nic=
Capability&quot;],<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Store capability representin=
g a physical function test run.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: Supporte=
d capabilities will be added to this set.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: Unsupp=
orted capabilities will be added to this set.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx =3D get_ctx()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ctx.topology.vf_ports =3D=3D []:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities.add(NicCa=
pability.PHYSICAL_FUNCTION)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities.add(Nic=
Capability.PHYSICAL_FUNCTION)<br>
+<br></blockquote><div><br></div><div>Another option would be to read direc=
tly from config.virtual_functions_testrun. But, it&#39;s the same thing at =
the end of the day.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
<br>
=C2=A0class NicCapability(NoAliasEnum):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;A mapping between capability names an=
d the associated :class:`TestPmdShell` methods.<br>
@@ -2803,6 +2820,11 @@ class NicCapability(NoAliasEnum):<br>
=C2=A0 =C2=A0 =C2=A0)<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports flow ctrl.<br>
=C2=A0 =C2=A0 =C2=A0FLOW_CTRL: TestPmdShellNicCapability =3D (TestPmdShell.=
get_capabilities_flow_ctrl, None)<br>
+=C2=A0 =C2=A0 #: Device is running on a physical function.<br>
+=C2=A0 =C2=A0 PHYSICAL_FUNCTION: TestPmdShellNicCapability =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_physical_functio=
n,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
+=C2=A0 =C2=A0 )<br>
<br>
=C2=A0 =C2=A0 =C2=A0def __call__(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self,<br>
diff --git a/dts/tests/TestSuite_dynamic_config.py b/dts/tests/TestSuite_dy=
namic_config.py<br>
index 1fce31a0b5..49f295a39a 100644<br>
--- a/dts/tests/TestSuite_dynamic_config.py<br>
+++ b/dts/tests/TestSuite_dynamic_config.py<br>
@@ -20,11 +20,12 @@<br>
=C2=A0from scapy.packet import Raw<br>
<br>
=C2=A0from framework.params.testpmd import SimpleForwardingModes<br>
-from framework.remote_session.testpmd_shell import TestPmdShell<br>
+from framework.remote_session.testpmd_shell import NicCapability, TestPmdS=
hell<br>
=C2=A0from framework.test_suite import TestSuite, func_test<br>
=C2=A0from framework.testbed_model.capability import TopologyType, requires=
<br>
<br>
<br>
+@requires(NicCapability.PHYSICAL_FUNCTION)<br>
=C2=A0@requires(topology_type=3DTopologyType.two_links)<br>
=C2=A0class TestDynamicConfig(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Dynamic config suite.<br>
diff --git a/dts/tests/TestSuite_dynamic_queue_conf.py b/dts/tests/TestSuit=
e_dynamic_queue_conf.py<br>
index 344dd540eb..f8c7dbfb71 100644<br>
--- a/dts/tests/TestSuite_dynamic_queue_conf.py<br>
+++ b/dts/tests/TestSuite_dynamic_queue_conf.py<br>
@@ -117,6 +117,7 @@ def wrap(self: &quot;TestDynamicQueueConf&quot;, is_rx_=
testing: bool) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0return wrap<br>
<br>
<br>
+@requires(NicCapability.PHYSICAL_FUNCTION)<br>
=C2=A0class TestDynamicQueueConf(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;DPDK dynamic queue configuration test=
 suite.<br>
<br>
diff --git a/dts/tests/TestSuite_l2fwd.py b/dts/tests/TestSuite_l2fwd.py<br=
>
index 0555d75ed8..5ffa2dcd19 100644<br>
--- a/dts/tests/TestSuite_l2fwd.py<br>
+++ b/dts/tests/TestSuite_l2fwd.py<br>
@@ -9,7 +9,7 @@<br>
<br>
=C2=A0from framework.context import filter_cores<br>
=C2=A0from framework.params.testpmd import EthPeer, SimpleForwardingModes<b=
r>
-from framework.remote_session.testpmd_shell import TestPmdShell<br>
+from framework.remote_session.testpmd_shell import NicCapability, TestPmdS=
hell<br>
=C2=A0from framework.test_suite import TestSuite, func_test<br>
=C2=A0from framework.testbed_model.capability import requires<br>
=C2=A0from framework.testbed_model.cpu import LogicalCoreCount<br>
@@ -17,6 +17,7 @@<br>
=C2=A0from framework.utils import generate_random_packets<br>
<br>
<br>
+@requires(NicCapability.PHYSICAL_FUNCTION)<br>
=C2=A0@requires(topology_type=3DTopologyType.two_links)<br>
=C2=A0class TestL2fwd(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;L2 forwarding test suite.&quot;&quot;=
&quot;<br>
diff --git a/dts/tests/TestSuite_mac_filter.py b/dts/tests/TestSuite_mac_fi=
lter.py<br>
index 9dbfec5da2..2387fdfac2 100644<br>
--- a/dts/tests/TestSuite_mac_filter.py<br>
+++ b/dts/tests/TestSuite_mac_filter.py<br>
@@ -25,6 +25,7 @@<br>
=C2=A0from framework.testbed_model.capability import requires<br>
<br>
<br>
+@requires(NicCapability.PHYSICAL_FUNCTION)<br>
=C2=A0class TestMacFilter(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Mac address allowlist filtering test =
suite.<br>
<br>
diff --git a/dts/tests/TestSuite_mtu.py b/dts/tests/TestSuite_mtu.py<br>
index af6ab88501..d5b3fe02af 100644<br>
--- a/dts/tests/TestSuite_mtu.py<br>
+++ b/dts/tests/TestSuite_mtu.py<br>
@@ -17,8 +17,9 @@<br>
=C2=A0from scapy.layers.l2 import Ether<br>
=C2=A0from scapy.packet import Raw<br>
<br>
-from framework.remote_session.testpmd_shell import TestPmdShell<br>
+from framework.remote_session.testpmd_shell import NicCapability, TestPmdS=
hell<br>
=C2=A0from framework.test_suite import TestSuite, func_test<br>
+from framework.testbed_model.capability import requires<br>
<br>
=C2=A0STANDARD_FRAME =3D 1518=C2=A0 # --max-pkt-len will subtract l2 inform=
ation at a minimum of 18 bytes.<br>
=C2=A0JUMBO_FRAME =3D 9018<br>
@@ -30,6 +31,7 @@<br>
=C2=A0VENDOR_AGNOSTIC_PADDING =3D 9=C2=A0 # Used as a work around for varyi=
ng MTU definitions between vendors.<br>
<br>
<br>
+@requires(NicCapability.PHYSICAL_FUNCTION)<br>
=C2=A0class TestMtu(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;DPDK PMD jumbo frames and MTU update =
test suite.<br>
<br>
diff --git a/dts/tests/TestSuite_pmd_buffer_scatter.py b/dts/tests/TestSuit=
e_pmd_buffer_scatter.py<br>
index 5e23f28bc6..015163dd11 100644<br>
--- a/dts/tests/TestSuite_pmd_buffer_scatter.py<br>
+++ b/dts/tests/TestSuite_pmd_buffer_scatter.py<br>
@@ -28,6 +28,7 @@<br>
=C2=A0from framework.testbed_model.capability import NicCapability, require=
s<br>
<br>
<br>
+@requires(NicCapability.PHYSICAL_FUNCTION)<br>
=C2=A0@requires(NicCapability.RX_OFFLOAD_SCATTER)<br>
=C2=A0class TestPmdBufferScatter(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;DPDK PMD packet scattering test suite=
.<br>
diff --git a/dts/tests/TestSuite_port_control.py b/dts/tests/TestSuite_port=
_control.py<br>
index ad5a09c58e..58783f1d18 100644<br>
--- a/dts/tests/TestSuite_port_control.py<br>
+++ b/dts/tests/TestSuite_port_control.py<br>
@@ -13,11 +13,12 @@<br>
=C2=A0from scapy.packet import Packet, Raw<br>
<br>
=C2=A0from framework.params.testpmd import SimpleForwardingModes<br>
-from framework.remote_session.testpmd_shell import TestPmdShell<br>
+from framework.remote_session.testpmd_shell import NicCapability, TestPmdS=
hell<br>
=C2=A0from framework.test_suite import TestSuite, func_test<br>
=C2=A0from framework.testbed_model.capability import TopologyType, requires=
<br>
<br>
<br>
+@requires(NicCapability.PHYSICAL_FUNCTION)<br>
=C2=A0@requires(topology_type=3DTopologyType.two_links)<br>
=C2=A0class TestPortControl(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;DPDK Port Control Testing Suite.&quot=
;&quot;&quot;<br>
diff --git a/dts/tests/TestSuite_port_stats.py b/dts/tests/TestSuite_port_s=
tats.py<br>
index 2bb8747399..ddd28623b3 100644<br>
--- a/dts/tests/TestSuite_port_stats.py<br>
+++ b/dts/tests/TestSuite_port_stats.py<br>
@@ -19,6 +19,7 @@<br>
<br>
=C2=A0from framework.params.testpmd import SimpleForwardingModes<br>
=C2=A0from framework.remote_session.testpmd_shell import (<br>
+=C2=A0 =C2=A0 NicCapability,<br>
=C2=A0 =C2=A0 =C2=A0RtePTypes,<br>
=C2=A0 =C2=A0 =C2=A0TestPmdShell,<br>
=C2=A0 =C2=A0 =C2=A0TestPmdVerbosePacket,<br>
@@ -27,6 +28,7 @@<br>
=C2=A0from framework.testbed_model.capability import TopologyType, requires=
<br>
<br>
<br>
+@requires(NicCapability.PHYSICAL_FUNCTION)<br>
=C2=A0@requires(topology_type=3DTopologyType.two_links)<br>
=C2=A0class TestPortStats(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;DPDK Port statistics testing suite.<b=
r>
diff --git a/dts/tests/TestSuite_promisc_support.py b/dts/tests/TestSuite_p=
romisc_support.py<br>
index 445f6e1d69..8a7a7efb57 100644<br>
--- a/dts/tests/TestSuite_promisc_support.py<br>
+++ b/dts/tests/TestSuite_promisc_support.py<br>
@@ -11,10 +11,12 @@<br>
=C2=A0from scapy.layers.l2 import Ether<br>
=C2=A0from scapy.packet import Raw<br>
<br>
-from framework.remote_session.testpmd_shell import TestPmdShell<br>
+from framework.remote_session.testpmd_shell import NicCapability, TestPmdS=
hell<br>
=C2=A0from framework.test_suite import TestSuite, func_test<br>
+from framework.testbed_model.capability import requires<br>
<br>
<br>
+@requires(NicCapability.PHYSICAL_FUNCTION)<br>
=C2=A0class TestPromiscSupport(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Promiscuous mode support test suite.&=
quot;&quot;&quot;<br>
<br>
diff --git a/dts/tests/TestSuite_rte_flow.py b/dts/tests/TestSuite_rte_flow=
.py<br>
index e70f7ea8d1..4855e4261d 100644<br>
--- a/dts/tests/TestSuite_rte_flow.py<br>
+++ b/dts/tests/TestSuite_rte_flow.py<br>
@@ -316,6 +316,7 @@ def test_queue_action_IP(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_queue=3D2,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
<br>
+=C2=A0 =C2=A0 @requires(NicCapability.PHYSICAL_FUNCTION)<br>
=C2=A0 =C2=A0 =C2=A0@func_test<br>
=C2=A0 =C2=A0 =C2=A0def test_queue_action_L4(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Validate flow rules wit=
h queue actions and TCP/UDP patterns.<br>
diff --git a/dts/tests/TestSuite_softnic.py b/dts/tests/TestSuite_softnic.p=
y<br>
index c1873dca4c..27754c08e7 100644<br>
--- a/dts/tests/TestSuite_softnic.py<br>
+++ b/dts/tests/TestSuite_softnic.py<br>
@@ -9,7 +9,7 @@<br>
=C2=A0from pathlib import Path, PurePath<br>
<br>
=C2=A0from framework.params.testpmd import EthPeer<br>
-from framework.remote_session.testpmd_shell import TestPmdShell<br>
+from framework.remote_session.testpmd_shell import NicCapability, TestPmdS=
hell<br>
=C2=A0from framework.test_suite import TestSuite, func_test<br>
=C2=A0from framework.testbed_model.capability import requires<br>
=C2=A0from framework.testbed_model.topology import TopologyType<br>
@@ -17,6 +17,7 @@<br>
=C2=A0from framework.utils import generate_random_packets<br>
<br>
<br>
+@requires(NicCapability.PHYSICAL_FUNCTION)<br>
=C2=A0@requires(topology_type=3DTopologyType.two_links)<br>
=C2=A0class TestSoftnic(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Softnic test suite.&quot;&quot;&quot;=
<br>
diff --git a/dts/tests/TestSuite_uni_pkt.py b/dts/tests/TestSuite_uni_pkt.p=
y<br>
index fdb9c29059..690c5d4fd1 100644<br>
--- a/dts/tests/TestSuite_uni_pkt.py<br>
+++ b/dts/tests/TestSuite_uni_pkt.py<br>
@@ -20,6 +20,7 @@<br>
=C2=A0from scapy.packet import Packet, Raw<br>
<br>
=C2=A0from framework.remote_session.testpmd_shell import (<br>
+=C2=A0 =C2=A0 NicCapability,<br>
=C2=A0 =C2=A0 =C2=A0RtePTypes,<br>
=C2=A0 =C2=A0 =C2=A0SimpleForwardingModes,<br>
=C2=A0 =C2=A0 =C2=A0TestPmdShell,<br>
@@ -258,6 +259,7 @@ def test_nsh_packet_detect(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with TestPmdShell() as testpmd:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.setup_session(testpmd=
=3Dtestpmd, expected_flags=3Dflag_list, packet_list=3Dpacket_list)<br>
<br>
+=C2=A0 =C2=A0 @requires(NicCapability.PHYSICAL_FUNCTION)<br>
=C2=A0 =C2=A0 =C2=A0@func_test<br>
=C2=A0 =C2=A0 =C2=A0def test_vxlan_tunnel_packet_detect(self) -&gt; None:<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Ensure the correct flag=
s are shown in the verbose output when sending VXLAN packets.<br>
-- <br>
2.49.0<br>
<br></blockquote><div><br></div><div>In principle some of the functions per=
formed in these testsuites should be possible via VFs.</div><div><br></div>=
<div>As a follow up task in 25.11 we should assess this and see if the tota=
l list of VF compatible testsuites=C2=A0can be extended.</div><div><br></di=
v><div>Reviewed-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu">p=
robb@iol.unh.edu</a>&gt;<div>Tested-by: Patrick Robb &lt;<a href=3D"mailto:=
probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div></div><div><br></div><div=
>=C2=A0</div></div></div>
</div>

--0000000000001bd5e3063912f038--
