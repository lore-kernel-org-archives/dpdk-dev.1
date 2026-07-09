Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0497C43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 01:47:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A67BA4028C;
	Thu,  9 Jul 2026 03:47:16 +0200 (CEST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id C6CB64026E
 for <dev@dpdk.org>; Thu,  9 Jul 2026 03:47:15 +0200 (CEST)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4798bea72f9so127694f8f.1
 for <dev@dpdk.org>; Wed, 08 Jul 2026 18:47:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783561635; cv=none;
 d=google.com; s=arc-20260327;
 b=ROu95W3uRv4Oc5BY5avC2TRWJ10KoaQHbosn1YFf+3rBEmNK0ADQrULrcEdoHv2udh
 4TqmjlUkuwBGH/GoScnjvny2VCNfZlOjq4/o4XgCqZjKhIc4P3pZQ/ktwUOUhKZErD5U
 uglPNbjYdYqX2roHwyqZ1hooP/1UjHl8+nuCPLpRTic2lteKb1bQyuVP1vy7x+8SSVOH
 fx/IoWLMTb59WftCYikeeOsdnjoY6sITSr4XL32ApW8wLfbDDJjQMkLTdEUsh64D1G0l
 +d6aqWMvynQJAblYAjlQvqQJml147bhR3FU9P1iAGplZ8hxy8PmxvWxEdiit3YD4Z2Nx
 gk/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=q5iFGC53gc1oKNuWqpif/4p5v9XoE4oFAGcF4mlx7ck=;
 fh=mp+PpwKhMzdZxPffIZSF/YA+u4tVf5Z4OMqpf0Rn54k=;
 b=jBMISe4XVaeZhnQKtvLS+tESAmA8y5y+vl+vk9oIxFVsL/4L+wvWSoCnrGEWOlzn3+
 nn/kNKYJc/U2Vju2m6IDfBYmDvx1DxmATCzJd4Ffk/nnEFFIqDxNf0CCxm7B7IHRw+io
 rcFMxxJJLJnwp3ODdd/7kMzEOe8j3rOZ+dhlqDMRETtuqliU+LZ32mqVLSOcxKrl1g0E
 r4HwOZraXsCDKdytu/8bVI37CQhb+OYcMvg3j6BJgV/MvMgfXmxu1Rj+nh9ouv5JEcWT
 BtJP/yxk9cB6TRxtQPCmmFOSXg/8EdhiyoIAMwfiZV913SZiBtyN7WogYIpqOaewUT1k
 hVaA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783561635; x=1784166435; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=q5iFGC53gc1oKNuWqpif/4p5v9XoE4oFAGcF4mlx7ck=;
 b=ZcZq54p/Wp0DhbNd8PaioDf8QqPsvcRknK5dwtsQe5LI7RgVqx3FUGfWt63bBosIwr
 SOhSgzz+rnNqrDd/rjZlt8k1Q/2TIbZ8Jve+javOB9fHeYBXsrg16VFqh2weP+AnfHM4
 V6707+YlHbEf0VHWWBDYo+ES5lXlJ+XusJ00HSkCGdAyHd6b1vOHSOu2B3KKBaEmsqki
 x02Ad5p2CgoL4PkVkS0tKz6ziKr7pMkj7yiEd0MXSqcz4VJXcvcAiyO5hosEx9/Xaz05
 gtflFov0+zu1n08w6WMTZXiAxNWEKF9FCgbDlT5oZA7C+ZG95dTTknaz+tVvoj2VthTt
 YJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783561635; x=1784166435;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=q5iFGC53gc1oKNuWqpif/4p5v9XoE4oFAGcF4mlx7ck=;
 b=UGxUlfaLgCexBIBT35D3qYOh9q2ThxOh7wBDSdGHBS9Urt/7gUYBy2bABCVxul0nk5
 bG3j1vcUpPR/y/YQtTJrutxQN+373vhDXwtpVuVdKyE9EBXl6CZqFS36tbQHUzLV4LtF
 KEweG5jspcv0gnQKbgRFTlpd6Jr9yb0hljyxYNcS/IsnATr4jEm/yrLRGviQ1s+HV6GE
 2xzNnCBV2kmRwUMvOadg54PZRcDeG7O9o4PVnrEsOcnwy6fidbKMxa/ainIoioH59VGE
 rc45/RUXJuJGsxe9M6ya+iTWOgVh+4bcIhtRtBXN59/VBixCf2zc61scAPQWZFe+jbtA
 O4vw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqrb1fNjmRfu3TnpNZj+nMDqF6B0mch0F1e/7IrndO6km53TGsmTNR9cIjDPkrPlJOG2hA=@dpdk.org
X-Gm-Message-State: AOJu0Ywu+Pwo0a4cicK+F6brr3wir4HO3BxMkJcnx5z2kTThb7tNlKws
 R3cc5wxVHtpBaEyTd0JCNKA53bYKxXC4Pdu1fLxXHfgw9hdeqDi/lUqeHoYrkrFeInnQtf2f4o6
 WZJwTH4L2IvK5QEOPwESvL23v4kVHjpM=
X-Gm-Gg: AfdE7cl6B3YgbUMy3lhO6rOixEEpI6U7mxC1Szm1rqOzNL9AC9PMF4zl6TT+vKniK3f
 kWuUDnpQoE1NbJnscBjJOFTNiaSm7pqWmF/PaPOl4qXGudhajFrCMhTQpOtiws/EnNMeHUdSVKb
 ek9L3zDQfN6PGc6Fd8r1T3O9TzNbRsIyKeMkjKuKEhvuGAsiX4/JTe8KEUq2z69F2CXnQo2cCXo
 AwCipwuUNOsYN7Iy3dtk9TB7DBIWYfQe9BmJNX2Mj3snq+CuHfsz4ZgwQY+Ks5aW28inKHAAMJa
 XDgDQ9MR9OtTPVeBSdG/2X5oS4tVezs8tUvmdaQs/Y48oqHzSFSyVlsn
X-Received: by 2002:a05:6000:24ca:b0:462:e086:35f with SMTP id
 ffacd0b85a97d-47df0725e5cmr5346228f8f.21.1783561635144; Wed, 08 Jul 2026
 18:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260327180232.443820-1-abailey@iol.unh.edu>
 <20260511154617.75903-1-abailey@iol.unh.edu>
In-Reply-To: <20260511154617.75903-1-abailey@iol.unh.edu>
From: Patrick Robb <patrickrobb1997@gmail.com>
Date: Wed, 8 Jul 2026 21:47:03 -0400
X-Gm-Features: AUfX_mzystmyh3MKJ7AWHpBa0rk9i3_ArF6cAanjFNF19ZWOSRVCHcqUiX5TMMU
Message-ID: <CAK6DuxvAxvX_hKDk7GvKuGvgzGQOH8nAYSxUQK0bUiOieVoCXQ@mail.gmail.com>
Subject: Re: [PATCH v2] dts: add ipgre test suite
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, ahassick@iol.unh.edu, 
 lylavoie@iol.unh.edu, knimoji@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000b2a65f065623cd03"
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

--000000000000b2a65f065623cd03
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 11:46=E2=80=AFAM Andrew Bailey <abailey@iol.unh.edu=
> wrote:

> Port over the IP GRE test suite from old DTS to next DTS. This test
> suite covers GRE tunneling and checksum offload verification using this
> protocol.
>
> Bugzilla ID: 1480
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
>  doc/api/dts/tests.TestSuite_ip_gre.rst |   8 +
>  dts/api/testpmd/__init__.py            |  23 ++
>  dts/tests/TestSuite_ip_gre.py          | 301 +++++++++++++++++++++++++
>  3 files changed, 332 insertions(+)
>  create mode 100644 doc/api/dts/tests.TestSuite_ip_gre.rst
>  create mode 100644 dts/tests/TestSuite_ip_gre.py
>
> diff --git a/doc/api/dts/tests.TestSuite_ip_gre.rst
> b/doc/api/dts/tests.TestSuite_ip_gre.rst
> new file mode 100644
> index 0000000000..e8ce01dc0b
> --- /dev/null
> +++ b/doc/api/dts/tests.TestSuite_ip_gre.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: BSD-3-Clause
> +
> +ip_gre Test Suite
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. automodule:: tests.TestSuite_ip_gre
> +   :members:
> +   :show-inheritance:
> diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
> index e9187440bb..bb5cbd6725 100644
> --- a/dts/api/testpmd/__init__.py
> +++ b/dts/api/testpmd/__init__.py
> @@ -951,6 +951,29 @@ def set_flow_control(
>                      f"Testpmd failed to set the {flow_ctrl} in port
> {port}."
>                  )
>
> +    def set_csum_parse_tunnel(self, port: int, on: bool, verify: bool =
=3D
> True) -> None:
> +        """Set parse tunnel on or of in testpmd for a given port.
>

Should be =E2=80=9Coff=E2=80=9D not =E2=80=9Cof=E2=80=9D


> +
> +        Args:
> +            port: The ID of the requested port
> +            on: set parse tunnel on if `on` is :data:`True`, otherwise o=
ff
> +            verify: if :data:`True`, the output of the command is scanne=
d
> to verify that
> +                parse tunnel was set successfully
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and the command
> +                fails to execute.
> +
> +        """
> +        output =3D self.send_command(f"csum parse-tunnel {'on' if on els=
e
> 'off'} {port}")
> +        if verify and f"Parse tunnel is {'on' if on else'off'}" not in
> output:
>

Missing a space after "else".


> +            self._logger.debug(
> +                f"Testpmd failed to set csum parse-tunnel {'on' if on
> else 'off'} in port {port}"
> +            )
> +            raise InteractiveCommandExecutionError(
> +                f"Testpmd failed to set csum parse-tunnel {'on' if on
> else 'off'} in port {port}"
> +            )
> +
>      def show_port_flow_info(self, port: int) -> TestPmdPortFlowCtrl |
> None:
>          """Show port info flow.
>
> diff --git a/dts/tests/TestSuite_ip_gre.py b/dts/tests/TestSuite_ip_gre.p=
y
> new file mode 100644
> index 0000000000..fc51eef181
> --- /dev/null
> +++ b/dts/tests/TestSuite_ip_gre.py
> @@ -0,0 +1,301 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2026 University of New Hampshire
> +
> +"""DPDK IP GRE test suite."""
> +
> +from scapy.layers.inet import GRE, IP, TCP, UDP
> +from scapy.layers.inet6 import IPv6
> +from scapy.layers.l2 import Dot1Q, Ether
> +from scapy.layers.sctp import SCTP
> +from scapy.packet import Packet
> +
> +from api.capabilities import (
> +    NicCapability,
> +    requires_nic_capability,
> +)
> +from api.packet import send_packet_and_capture
> +from api.test import verify
> +from api.testpmd import TestPmd
> +from api.testpmd.config import SimpleForwardingModes
> +from api.testpmd.types import (
> +    ChecksumOffloadOptions,
> +    PacketOffloadFlag,
> +    RtePTypes,
> +    TestPmdVerbosePacket,
> +)
> +from framework.test_suite import TestSuite, func_test
> +
> +SRC_ID =3D "FF:FF:FF:FF:FF:FF"
>

Why did you choose the broadcast address instead of a "normal" address?
Just want to hear your reasoning.


> +
> +
> +class TestIpGre(TestSuite):
> +    """IP GRE test suite."""
> +
> +    def _check_for_matching_packet(
> +        self, output: list[TestPmdVerbosePacket], flags: RtePTypes
> +    ) -> bool:
> +        """Returns :data:`True` if the packet in verbose output contains
> all specified flags."""
> +        for packet in output:
> +            if packet.src_mac =3D=3D SRC_ID:
> +                if flags not in packet.hw_ptype and flags not in
> packet.sw_ptype:
> +                    return False
> +        return True
> +
> +    def _send_packet_and_verify_flags(
> +        self, expected_flag: RtePTypes, packet: Packet, testpmd: TestPmd
> +    ) -> None:
> +        """Sends a packet to the DUT and verifies the verbose ptype
> flags."""
> +        send_packet_and_capture(packet=3Dpacket)
> +        verbose_output =3D
> testpmd.extract_verbose_output(testpmd.stop(verify=3DTrue))
> +        valid =3D self._check_for_matching_packet(output=3Dverbose_outpu=
t,
> flags=3Dexpected_flag)
> +        verify(valid, f"Packet type flag did not match the expected flag=
:
> {expected_flag}.")


Is it worth logging a packet transmission issue vs a flag setting / flag
processing issue in different ways? And re the previous 2 functions if
verbose_output is None will _check_for_matching_packet return True in
error? Just checking that this is sound.


> +
> +    def _setup_session(
> +        self, testpmd: TestPmd, expected_flags: list[RtePTypes],
> packet_list=3Dlist[Packet]
> +    ) -> None:
> +        """Sets the forwarding and verbose mode of each test case
> interactive shell session."""
> +        testpmd.set_forward_mode(SimpleForwardingModes.rxonly)
> +        testpmd.set_verbose(level=3D1)
> +        for i in range(0, len(packet_list)):
> +            testpmd.start(verify=3DTrue)
> +            self._send_packet_and_verify_flags(
> +                expected_flag=3Dexpected_flags[i], packet=3Dpacket_list[=
i],
> testpmd=3Dtestpmd
> +            )
>

If expected_flags and packet_list are related lists of the same length, is
it better if we use 1 list of tuples [(expected flag, packet)]?

+
> +    def _send_packet_and_verify_checksum(
> +        self, packet: Packet, good_L4: bool, good_IP: bool, testpmd:
> TestPmd
>

If we are going to say good_L4 can we say good_L3 or does that reduce
clarity to you? Figure we should stay consistent.


> +    ) -> None:
> +        """Send packet and verify verbose output matches expected
> output."""
> +        testpmd.start()
> +        send_packet_and_capture(packet=3Dpacket)
> +        verbose_output =3D testpmd.extract_verbose_output(testpmd.stop()=
)
> +        is_IP =3D is_L4 =3D None
> +        for testpmd_packet in verbose_output:
> +            if testpmd_packet.src_mac =3D=3D SRC_ID:
> +                is_IP =3D PacketOffloadFlag.RTE_MBUF_F_RX_IP_CKSUM_GOOD =
in
> testpmd_packet.ol_flags
> +                is_L4 =3D PacketOffloadFlag.RTE_MBUF_F_RX_L4_CKSUM_GOOD =
in
> testpmd_packet.ol_flags
>

is_IP -> good_L3_checksum? If the meaning of the is_IP variable is that
there is an IP layer, I disagree with the name because it is possible for
there to be an IP layer and a bad checksum. I do see below the verify logic
is for if the checksum is correct.

Do we have any logic here to verify we are acting on the correct packet,
given that it may not be a quiet wire?


> +        verify(
> +            is_IP is not None and is_L4 is not None,
> +            "Test packet was dropped when it should have been received."=
,
>

Reviewed-by: Patrick Robb <patrickrobb1997@gmail.com>

--000000000000b2a65f065623cd03
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 11, 2026=
 at 11:46=E2=80=AFAM Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.ed=
u" target=3D"_blank">abailey@iol.unh.edu</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">Port over the IP GRE test suite fro=
m old DTS to next DTS. This test<br>
suite covers GRE tunneling and checksum offload verification using this<br>
protocol.<br>
<br>
Bugzilla ID: 1480<br>
<br>
Signed-off-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu" tar=
get=3D"_blank">abailey@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0doc/api/dts/tests.TestSuite_ip_gre.rst |=C2=A0 =C2=A08 +<br>
=C2=A0dts/api/testpmd/__init__.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 23 ++<br>
=C2=A0dts/tests/TestSuite_ip_gre.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 301=
 +++++++++++++++++++++++++<br>
=C2=A03 files changed, 332 insertions(+)<br>
=C2=A0create mode 100644 doc/api/dts/tests.TestSuite_ip_gre.rst<br>
=C2=A0create mode 100644 dts/tests/TestSuite_ip_gre.py<br>
<br>
diff --git a/doc/api/dts/tests.TestSuite_ip_gre.rst b/doc/api/dts/tests.Tes=
tSuite_ip_gre.rst<br>
new file mode 100644<br>
index 0000000000..e8ce01dc0b<br>
--- /dev/null<br>
+++ b/doc/api/dts/tests.TestSuite_ip_gre.rst<br>
@@ -0,0 +1,8 @@<br>
+.. SPDX-License-Identifier: BSD-3-Clause<br>
+<br>
+ip_gre Test Suite<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
+<br>
+.. automodule:: tests.TestSuite_ip_gre<br>
+=C2=A0 =C2=A0:members:<br>
+=C2=A0 =C2=A0:show-inheritance:<br>
diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py<br>
index e9187440bb..bb5cbd6725 100644<br>
--- a/dts/api/testpmd/__init__.py<br>
+++ b/dts/api/testpmd/__init__.py<br>
@@ -951,6 +951,29 @@ def set_flow_control(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0f&quot;Testpmd failed to set the {flow_ctrl} in port {port}.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
<br>
+=C2=A0 =C2=A0 def set_csum_parse_tunnel(self, port: int, on: bool, verify:=
 bool =3D True) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Set parse tunnel on or of in=
 testpmd for a given port.<br></blockquote><div><br></div><div>Should be =
=E2=80=9Coff=E2=80=9D not =E2=80=9Cof=E2=80=9D<br></div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port: The ID of the requested po=
rt<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 on: set parse tunnel on if `on` =
is :data:`True`, otherwise off<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: if :data:`True`, the out=
put of the command is scanned to verify that<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parse tunnel was s=
et successfully<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and the command<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fails to execute.<=
br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(f&quot;csum parse=
-tunnel {&#39;on&#39; if on else &#39;off&#39;} {port}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify and f&quot;Parse tunnel is {&#39;on&=
#39; if on else&#39;off&#39;}&quot; not in output:<br></blockquote><div><br=
></div><div>Missing a space after &quot;else&quot;.</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;Testpmd fai=
led to set csum parse-tunnel {&#39;on&#39; if on else &#39;off&#39;} in por=
t {port}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveCommandExecutio=
nError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;Testpmd fai=
led to set csum parse-tunnel {&#39;on&#39; if on else &#39;off&#39;} in por=
t {port}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def show_port_flow_info(self, port: int) -&gt; TestPmdP=
ortFlowCtrl | None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Show port info flow.<br=
>
<br>
diff --git a/dts/tests/TestSuite_ip_gre.py b/dts/tests/TestSuite_ip_gre.py<=
br>
new file mode 100644<br>
index 0000000000..fc51eef181<br>
--- /dev/null<br>
+++ b/dts/tests/TestSuite_ip_gre.py<br>
@@ -0,0 +1,301 @@<br>
+# SPDX-License-Identifier: BSD-3-Clause<br>
+# Copyright(c) 2026 University of New Hampshire<br>
+<br>
+&quot;&quot;&quot;DPDK IP GRE test suite.&quot;&quot;&quot;<br>
+<br>
+from scapy.layers.inet import GRE, IP, TCP, UDP<br>
+from scapy.layers.inet6 import IPv6<br>
+from scapy.layers.l2 import Dot1Q, Ether<br>
+from scapy.layers.sctp import SCTP<br>
+from scapy.packet import Packet<br>
+<br>
+from api.capabilities import (<br>
+=C2=A0 =C2=A0 NicCapability,<br>
+=C2=A0 =C2=A0 requires_nic_capability,<br>
+)<br>
+from api.packet import send_packet_and_capture<br>
+from api.test import verify<br>
+from api.testpmd import TestPmd<br>
+from api.testpmd.config import SimpleForwardingModes<br>
+from api.testpmd.types import (<br>
+=C2=A0 =C2=A0 ChecksumOffloadOptions,<br>
+=C2=A0 =C2=A0 PacketOffloadFlag,<br>
+=C2=A0 =C2=A0 RtePTypes,<br>
+=C2=A0 =C2=A0 TestPmdVerbosePacket,<br>
+)<br>
+from framework.test_suite import TestSuite, func_test<br>
+<br>
+SRC_ID =3D &quot;FF:FF:FF:FF:FF:FF&quot;<br></blockquote><div><br></div><d=
iv>Why did you choose the broadcast address instead of a &quot;normal&quot;=
 address? Just want to hear your reasoning.=C2=A0</div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+<br>
+class TestIpGre(TestSuite):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;IP GRE test suite.&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 def _check_for_matching_packet(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, output: list[TestPmdVerbosePacket], flag=
s: RtePTypes<br>
+=C2=A0 =C2=A0 ) -&gt; bool:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Returns :data:`True` if the =
packet in verbose output contains all specified flags.&quot;&quot;&quot;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for packet in output:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if packet.src_mac =3D=3D SRC_ID:=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if flags not in pa=
cket.hw_ptype and flags not in packet.sw_ptype:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn False<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return True<br>
+<br>
+=C2=A0 =C2=A0 def _send_packet_and_verify_flags(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, expected_flag: RtePTypes, packet: Packet=
, testpmd: TestPmd<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Sends a packet to the DUT an=
d verifies the verbose ptype flags.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 send_packet_and_capture(packet=3Dpacket)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 verbose_output =3D testpmd.extract_verbose_out=
put(testpmd.stop(verify=3DTrue))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 valid =3D self._check_for_matching_packet(outp=
ut=3Dverbose_output, flags=3Dexpected_flag)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(valid, f&quot;Packet type flag did not =
match the expected flag: {expected_flag}.&quot;)<span style=3D"background-c=
olor:transparent">=C2=A0</span></blockquote><div><br></div><div>Is it worth=
 logging a packet transmission issue vs a flag setting / flag processing is=
sue in different ways? And re the previous 2 functions if verbose_output is=
 None will _check_for_matching_packet return True in error? Just checking t=
hat this is sound.</div><div><span style=3D"background-color:transparent">=
=C2=A0</span></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 def _setup_session(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, testpmd: TestPmd, expected_flags: list[R=
tePTypes], packet_list=3Dlist[Packet]<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Sets the forwarding and verb=
ose mode of each test case interactive shell session.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.set_forward_mode(SimpleForwardingModes=
.rxonly)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.set_verbose(level=3D1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for i in range(0, len(packet_list)):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.start(verify=3DTrue)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._send_packet_and_verify_fla=
gs(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expected_flag=3Dex=
pected_flags[i], packet=3Dpacket_list[i], testpmd=3Dtestpmd<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br></blockquote><div><br></div=
><div>If expected_flags and packet_list are related lists of the same lengt=
h, is it better if we use 1 list of tuples [(expected flag, packet)]?</div>=
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 def _send_packet_and_verify_checksum(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, packet: Packet, good_L4: bool, good_IP: =
bool, testpmd: TestPmd<br></blockquote><div><br></div><div>If we are going =
to say good_L4 can we say good_L3 or does that reduce clarity to you? Figur=
e we should stay consistent.</div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Send packet and verify verbo=
se output matches expected output.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.start()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 send_packet_and_capture(packet=3Dpacket)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 verbose_output =3D testpmd.extract_verbose_out=
put(testpmd.stop())<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 is_IP =3D is_L4 =3D None<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for testpmd_packet in verbose_output:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if testpmd_packet.src_mac =3D=3D=
 SRC_ID:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_IP =3D PacketOf=
floadFlag.RTE_MBUF_F_RX_IP_CKSUM_GOOD in testpmd_packet.ol_flags<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_L4 =3D PacketOf=
floadFlag.RTE_MBUF_F_RX_L4_CKSUM_GOOD in testpmd_packet.ol_flags<br></block=
quote><div><br></div><div>is_IP -&gt; good_L3_checksum? If the meaning of t=
he is_IP variable is that there is an IP layer, I disagree with the name be=
cause it is possible for there to be an IP layer and a bad checksum. I do s=
ee below the verify logic is for if the checksum is correct.</div><div><br>=
</div><div>Do we have any logic here to verify we are acting on the correct=
 packet, given that it may not be a quiet wire?</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_IP is not None and is_L4 is n=
ot None,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Test packet was dropped wh=
en it should have been received.&quot;,<br></blockquote><div><br></div><div=
>Reviewed-by: Patrick Robb &lt;<a href=3D"mailto:patrickrobb1997@gmail.com"=
>patrickrobb1997@gmail.com</a>&gt;=C2=A0</div></div></div>
</div>

--000000000000b2a65f065623cd03--
