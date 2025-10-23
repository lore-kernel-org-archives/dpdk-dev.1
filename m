Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D396CCD1BC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 13:00:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A3C4402C1;
	Thu, 23 Oct 2025 15:00:12 +0200 (CEST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTP id 3C13F40151
 for <dev@dpdk.org>; Thu, 23 Oct 2025 15:00:11 +0200 (CEST)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-b608df6d2a0so670460a12.1
 for <dev@dpdk.org>; Thu, 23 Oct 2025 06:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761224410; x=1761829210; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0S+7KUal2B9Dw+k6retsRlgzQL7NYUGJ+Nm2c0lpjTE=;
 b=PtRkZYyhOFi34DTMeL5kFCbbhq+aE398chMj7HIvNs4JyfTD2oKyqcBz/Cl4b4TG37
 RZIBnBm5094zTaw2KSu2ZID3k3yapDN+N7/R0Ab246NJs/wH4vQUIvclbo/aXzhRHuYa
 5+LruYu61dGRkTHNCM8oFnMIi0ZfshAqSowN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761224410; x=1761829210;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0S+7KUal2B9Dw+k6retsRlgzQL7NYUGJ+Nm2c0lpjTE=;
 b=YDHdCu1D0WDEHtg8BuezYxAMOO3jPqpDIVr/yN5ckmWBmIOm5p+3UCBXIzMTLnuV9K
 niHHn6CIKTjF43jBLFAmXZECsFZEwXr/GPa4taWI0y/zGNpJrvZIA14vHwkFl6uP5mes
 DKByZp0AS4jkC7d4BgBaP1qLeg/TmJZToJxIPSa7eUg0KoxMh73rwUkKiv/45jLYxFmr
 AIriArWWVmL3YpsMGkA6oixoqXNbR0Q17v1zyXqZde70QE80bjnpKUd99RacM0aSdTDg
 eBxXVhv0iRxDdNTmelIIKPaiH9ajBANxFnreoX22RrJHEM5duR3ScAe3FbYSCIaY2tGq
 KxvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZCk2wIgXzFs8djHWiv/yVyRTz/WSECIT+hc9UV0kGr8goot+iOdDsQlL9lXHxYZ2Sk5E=@dpdk.org
X-Gm-Message-State: AOJu0Yz/kbeVyW0LiI6IchPeDWYK3wnphKIlZrxcG2nJkqf7xAy8XWZ7
 ejMmewfXDUbkM5C8F/Wo9H/eqM29VLLP3phqFVocZLQUq/HzT1UEkz72nMceJ6AnKFW7xhiZ1u0
 RGhze9BFuYrMUeJ7i815ohp1S450N4g8u4NVIDwKoLg==
X-Gm-Gg: ASbGncvY3fDvHS5A2sge/p476yBQ3Yqhihut4F6todgVHGppgFRvgqydLvC/978yI1h
 /OfmiSvrh1eLESg0mprjHjnKdcRJmMVnfDmF/QpKMUqfb+obElcfXVD5EbOUkL0fPl0g1eva3oE
 /nocThly4KS0wYp/7LPR8cIKptrxpABwCh9ZgJdKkjOOP82jhXd0zjvm0OhKNxfZ4kdxEadEBHc
 /dgX2Nyvdm2MeEH2b6qhT6O/4Y3OSrsb6MbIf29YBuf8j5WCDodFft6cCbUb31mbpmLIHW4UrJn
 d0FK21TCjXu6Op4s3AmwBvrQOuQ=
X-Google-Smtp-Source: AGHT+IEddHbChH2lGYCmult07MgKWbDQlw30lkOL7s86cHxBsYveLdfwmgcqEdlgPhqr3sekNAkcb3irsyk/MJ4LQ6M=
X-Received: by 2002:a17:903:3546:b0:267:e097:7a9c with SMTP id
 d9443c01a7336-290cc6d4ba8mr320329395ad.53.1761224410158; Thu, 23 Oct 2025
 06:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250916200458.259376-1-dmarx@iol.unh.edu>
 <20251003192717.444490-1-dmarx@iol.unh.edu>
 <20251003192717.444490-2-dmarx@iol.unh.edu>
In-Reply-To: <20251003192717.444490-2-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 23 Oct 2025 08:59:17 -0400
X-Gm-Features: AS18NWBBmtWbuG6lI_e96QYXjNtG-yxBYbK6QUrEDgX-DnY1JLg1dmQ5rch2Uok
Message-ID: <CAJvnSUC3gt3McAjK1UWpwtw2ay1YphYMbTZFysnoSEawcmafOg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dts: add virtio forwarding test suite
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000566d320641d303bc"
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

--000000000000566d320641d303bc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 3:27=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote:

> Add test suite covering virtio-user and vhost
> server/client forwarding scenarios with
> testpmd packet validation.
>
> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> ---
>  doc/api/tests.TestSuite_virtio_fwd.rst |   8 ++
>  dts/tests/TestSuite_virtio_fwd.py      | 180 +++++++++++++++++++++++++
>  2 files changed, 188 insertions(+)
>  create mode 100644 doc/api/tests.TestSuite_virtio_fwd.rst
>  create mode 100644 dts/tests/TestSuite_virtio_fwd.py
>
> diff --git a/doc/api/tests.TestSuite_virtio_fwd.rst
> b/doc/api/tests.TestSuite_virtio_fwd.rst
> new file mode 100644
> index 0000000000..782eddad2d
> --- /dev/null
> +++ b/doc/api/tests.TestSuite_virtio_fwd.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: BSD-3-Clause
> +
> +virtio_fwd Test Suite
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +.. automodule:: tests.TestSuite_virtio_fwd
> +   :members:
> +   :show-inheritance:
> \ No newline at end of file
> diff --git a/dts/tests/TestSuite_virtio_fwd.py
> b/dts/tests/TestSuite_virtio_fwd.py
> new file mode 100644
> index 0000000000..194bd24257
> --- /dev/null
> +++ b/dts/tests/TestSuite_virtio_fwd.py
> @@ -0,0 +1,180 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 University of New Hampshire
> +
> +"""Virtio forwarding test suite.
> +
> +Verify vhost/virtio pvp and loopback topology functionalities.
>

Loopback doesn't seem quite right. Maybe you can just say pvp and fully
virtual?


> +"""
> +
> +from scapy.layers.inet import IP
> +from scapy.layers.l2 import Ether
> +
> +from api.capabilities import LinkTopology
> +from api.testpmd import TestPmd
> +from api.testpmd.config import SimpleForwardingModes
> +from framework.parser import TextParser
> +from framework.test_suite import TestSuite, func_test
> +from framework.testbed_model.capability import requires
> +from framework.testbed_model.linux_session import LinuxSession
> +from framework.testbed_model.virtual_device import VirtualDevice
> +
> +
> +@requires(topology_type=3DLinkTopology.TWO_LINKS)
>

two links is true for the pvp test, but the other two dont require any
links, right?


> +class TestVirtioFwd(TestSuite):
> +    """Virtio forwarding test suite."""
> +
> +    class ForwardingParsers:
> +        """Class for gathering Rx/Tx packets from testpmd stats."""
> +
> +        rx_packets =3D TextParser.find_int(r"RX-packets:\s*(\d+)")
> +        tx_packets =3D TextParser.find_int(r"TX-packets:\s*(\d+)")
> +
> +    class vdevs:
> +        """Class containing virtio-user and vhost-user virtual devices."=
""
> +
> +        virtio_user =3D VirtualDevice(
> +
> "net_virtio_user0,mac=3D00:01:02:03:04:05,path=3D/tmp/vhost-net,server=3D=
1"
> +        )
> +        vhost_user =3D
> VirtualDevice("eth_vhost0,iface=3D/tmp/vhost-net,client=3D1")
>

+1 to Luca's comment about not needing these to be internal classes.


> +
> +    @func_test
> +    def virtio_server(self) -> None:
> +        """Test virtio server packet transmission.
> +
> +        Steps:
> +            * Launch a testpmd session with a vhost-user virtual device
> (client side).
> +            * Launch a testpmd session with a virtio-user virtual device
> (server side).
> +            * Set the forwarding mode to mac in both sessions.
> +            * Start packet forwarding on vhost session.
> +            * Send a burst of packets from the virtio session.
> +            * Stop packet forwarding on vhost session and collect Rx
> packet stats.
> +
> +        Verify:
> +            * Vhost session receives packets from virtio session.
> +        """
> +        with (
> +            TestPmd(
> +                prefix=3D"vhost",
> +                no_pci=3DTrue,
> +                memory_channels=3D4,
> +                vdevs=3D[self.vdevs.vhost_user],
> +            ) as vhost,
> +            TestPmd(
> +                prefix=3D"virtio",
> +                no_pci=3DTrue,
> +                memory_channels=3D4,
> +                vdevs=3D[self.vdevs.virtio_user],
> +            ) as virtio,
> +        ):
> +            vhost.set_forward_mode(SimpleForwardingModes.mac)
> +            virtio.set_forward_mode(SimpleForwardingModes.mac)
> +
> +            vhost.start()
> +            virtio.start_tx_first(burst_num=3D32)
> +
> +            forwarding_stats =3D vhost.stop()
> +
> +            rx_packets =3D
> self.ForwardingParsers.rx_packets["TextParser_fn"](forwarding_stats) or 0
> +            tx_packets =3D
> self.ForwardingParsers.tx_packets["TextParser_fn"](forwarding_stats) or 0
> +
> +            self.verify(
> +                rx_packets !=3D 0 and tx_packets !=3D 0,
> +                "Vhost session failed to receive packets from virtio
> session.",
> +            )
> +
> +    @func_test
> +    def virtio_server_reconnect(self) -> None:
> +        """Test virtio server reconnection.
> +
> +        Steps:
> +            * Launch a testpmd session with a vhost-user virtual device
> (client side).
> +            * Launch a testpmd session with a virtio-user virtual device
> (server side).
> +            * Close the virtio session and relaunch it.
> +            * Start packet forwarding on vhost session.
> +            * Send a burst of packets from the virtio session.
> +            * Stop packet forwarding on vhost session and collect Rx
> packet stats.
> +
> +        Verify:
> +            * Vhost session receives packets from relaunched virtio
> session.
> +        """
> +        with TestPmd(
> +            prefix=3D"vhost",
> +            no_pci=3DTrue,
> +            memory_channels=3D4,
> +            vdevs=3D[self.vdevs.vhost_user],
> +        ) as vhost:
> +            with TestPmd(
> +                prefix=3D"virtio",
> +                no_pci=3DTrue,
> +                memory_channels=3D4,
> +                vdevs=3D[self.vdevs.virtio_user],
> +            ) as virtio:
> +                pass
> +            # end session and reconnect
> +            with TestPmd(
> +                prefix=3D"virtio",
> +                no_pci=3DTrue,
> +                memory_channels=3D4,
> +                vdevs=3D[self.vdevs.virtio_user],
> +            ) as virtio:
> +                virtio.set_forward_mode(SimpleForwardingModes.mac)
> +                vhost.set_forward_mode(SimpleForwardingModes.mac)
> +
> +                vhost.start()
> +                virtio.start_tx_first(burst_num=3D32)
> +
> +                forwarding_stats =3D vhost.stop()
> +
> +                rx_packets =3D (
> +
> self.ForwardingParsers.rx_packets["TextParser_fn"](forwarding_stats) or 0
> +                )
> +                tx_packets =3D (
> +
> self.ForwardingParsers.tx_packets["TextParser_fn"](forwarding_stats) or 0
> +                )
> +
> +                self.verify(
> +                    rx_packets !=3D 0 and tx_packets !=3D 0,
> +                    "Vhost session failed to receive packets from virtio
> session.",
> +                )
> +
> +    @func_test
> +    def pvp_loop(self) -> None:
> +        """Test vhost/virtio physical-virtual-physical loop topology.
> +
> +        Steps:
> +            * Launch testpmd session with a physical NIC and virtio-user
> vdev
> +                connected to a vhost-net socket.
> +            * Configure the tap interface that is created with IP addres=
s
> and
> +                set link state to UP.
> +            * Launch second testpmd session with af_packet vdev connecte=
d
> to
> +                the tap interface.
> +            * Start packet forwarding on both testpmd sessions.
> +            * Send 100 packets to the physical interface from external
> tester.
> +            * Capture packets on the same physical interface.
> +
> +        Verify:
> +            * Physical interface receives all 100 sent packets.
> +        """
> +        self.sut_node =3D self._ctx.sut_node
> +        if not isinstance(self.sut_node.main_session, LinuxSession):
> +            self.verify(False, "Must be running on a Linux environment."=
)
> +        with TestPmd(
> +            prefix=3D"virtio",
> +
> vdevs=3D[VirtualDevice("virtio_user0,path=3D/dev/vhost-net,queues=3D1,que=
ue_size=3D1024")],
> +        ) as virtio:
> +            self.sut_node.main_session.send_command("ip link set dev tap=
0
> up", privileged=3DTrue)
> +            with TestPmd(
> +                prefix=3D"vhost", no_pci=3DTrue,
> vdevs=3D[VirtualDevice("net_af_packet0,iface=3Dtap0")]
> +            ) as vhost:
> +                virtio.set_forward_mode(SimpleForwardingModes.mac)
> +                vhost.set_forward_mode(SimpleForwardingModes.mac)
> +                vhost.start()
> +                virtio.start()
> +
> +                packet =3D Ether() / IP()
> +                packets =3D [packet] * 100
> +                captured_packets =3D self.send_packets_and_capture(packe=
ts)
> +
> +                self.verify(
> +                    len(captured_packets) >=3D 100, "Sent packets not
> received on physical interface."
> +                )
>

Can you remind me what docs you were working from for setting up the pvp
test? I'm guessing how you've done it is valid, but I originally thought we
needed 2 tap interfaces and that vhost had to run in --no-pci, not virtio.
Better safe than sorry. :)


> --
> 2.51.0
>
>
Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--000000000000566d320641d303bc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 3, =
2025 at 3:27=E2=80=AFPM Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu">=
dmarx@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Add test suite covering virtio-user and vhost<br>
server/client forwarding scenarios with<br>
testpmd packet validation.<br>
<br>
Signed-off-by: Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" target=3D=
"_blank">dmarx@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0doc/api/tests.TestSuite_virtio_fwd.rst |=C2=A0 =C2=A08 ++<br>
=C2=A0dts/tests/TestSuite_virtio_fwd.py=C2=A0 =C2=A0 =C2=A0 | 180 +++++++++=
++++++++++++++++<br>
=C2=A02 files changed, 188 insertions(+)<br>
=C2=A0create mode 100644 doc/api/tests.TestSuite_virtio_fwd.rst<br>
=C2=A0create mode 100644 dts/tests/TestSuite_virtio_fwd.py<br>
<br>
diff --git a/doc/api/tests.TestSuite_virtio_fwd.rst b/doc/api/tests.TestSui=
te_virtio_fwd.rst<br>
new file mode 100644<br>
index 0000000000..782eddad2d<br>
--- /dev/null<br>
+++ b/doc/api/tests.TestSuite_virtio_fwd.rst<br>
@@ -0,0 +1,8 @@<br>
+.. SPDX-License-Identifier: BSD-3-Clause<br>
+<br>
+virtio_fwd Test Suite<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>
+<br>
+.. automodule:: tests.TestSuite_virtio_fwd<br>
+=C2=A0 =C2=A0:members:<br>
+=C2=A0 =C2=A0:show-inheritance:<br>
\ No newline at end of file<br>
diff --git a/dts/tests/TestSuite_virtio_fwd.py b/dts/tests/TestSuite_virtio=
_fwd.py<br>
new file mode 100644<br>
index 0000000000..194bd24257<br>
--- /dev/null<br>
+++ b/dts/tests/TestSuite_virtio_fwd.py<br>
@@ -0,0 +1,180 @@<br>
+# SPDX-License-Identifier: BSD-3-Clause<br>
+# Copyright(c) 2025 University of New Hampshire<br>
+<br>
+&quot;&quot;&quot;Virtio forwarding test suite.<br>
+<br>
+Verify vhost/virtio pvp and loopback topology functionalities.<br></blockq=
uote><div><br></div><div>Loopback doesn&#39;t seem quite right. Maybe you c=
an just say pvp and fully virtual?</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
+&quot;&quot;&quot;<br>
+<br>
+from scapy.layers.inet import IP<br>
+from scapy.layers.l2 import Ether<br>
+<br>
+from api.capabilities import LinkTopology<br>
+from api.testpmd import TestPmd<br>
+from api.testpmd.config import SimpleForwardingModes<br>
+from framework.parser import TextParser<br>
+from framework.test_suite import TestSuite, func_test<br>
+from framework.testbed_model.capability import requires<br>
+from framework.testbed_model.linux_session import LinuxSession<br>
+from framework.testbed_model.virtual_device import VirtualDevice<br>
+<br>
+<br>
+@requires(topology_type=3DLinkTopology.TWO_LINKS)<br></blockquote><div><br=
></div><div>two links is true for the pvp test, but the other two dont requ=
ire any links, right?</div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
+class TestVirtioFwd(TestSuite):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Virtio forwarding test suite.&quot;&quot;&=
quot;<br>
+<br>
+=C2=A0 =C2=A0 class ForwardingParsers:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Class for gathering Rx/Tx pa=
ckets from testpmd stats.&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_packets =3D TextParser.find_int(r&quot;RX-p=
ackets:\s*(\d+)&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_packets =3D TextParser.find_int(r&quot;TX-p=
ackets:\s*(\d+)&quot;)<br>
+<br>
+=C2=A0 =C2=A0 class vdevs:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Class containing virtio-user=
 and vhost-user virtual devices.&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_user =3D VirtualDevice(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;net_virtio_user0,mac=3D00:=
01:02:03:04:05,path=3D/tmp/vhost-net,server=3D1&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost_user =3D VirtualDevice(&quot;eth_vhost0,=
iface=3D/tmp/vhost-net,client=3D1&quot;)<br></blockquote><div><br></div><di=
v>+1 to Luca&#39;s comment about not needing these to be internal classes.<=
br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def virtio_server(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Test virtio server packet tr=
ansmission.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Launch a testpmd session with =
a vhost-user virtual device (client side).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Launch a testpmd session with =
a virtio-user virtual device (server side).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Set the forwarding mode to mac=
 in both sessions.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Start packet forwarding on vho=
st session.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Send a burst of packets from t=
he virtio session.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Stop packet forwarding on vhos=
t session and collect Rx packet stats.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Vhost session receives packets=
 from virtio session.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmd(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prefix=3D&quot;vho=
st&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 no_pci=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_channels=3D=
4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdevs=3D[self.vdev=
s.vhost_user],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ) as vhost,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmd(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prefix=3D&quot;vir=
tio&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 no_pci=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_channels=3D=
4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdevs=3D[self.vdev=
s.virtio_user],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ) as virtio,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost.set_forward_mode(SimpleFor=
wardingModes.mac)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio.set_forward_mode(SimpleFo=
rwardingModes.mac)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost.start()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio.start_tx_first(burst_num=
=3D32)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 forwarding_stats =3D vhost.stop(=
)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_packets =3D self.ForwardingPa=
rsers.rx_packets[&quot;TextParser_fn&quot;](forwarding_stats) or 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_packets =3D self.ForwardingPa=
rsers.tx_packets[&quot;TextParser_fn&quot;](forwarding_stats) or 0<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_packets !=3D 0 =
and tx_packets !=3D 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Vhost sessio=
n failed to receive packets from virtio session.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def virtio_server_reconnect(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Test virtio server reconnect=
ion.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Launch a testpmd session with =
a vhost-user virtual device (client side).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Launch a testpmd session with =
a virtio-user virtual device (server side).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Close the virtio session and r=
elaunch it.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Start packet forwarding on vho=
st session.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Send a burst of packets from t=
he virtio session.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Stop packet forwarding on vhos=
t session and collect Rx packet stats.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Vhost session receives packets=
 from relaunched virtio session.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmd(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prefix=3D&quot;vhost&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 no_pci=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_channels=3D4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdevs=3D[self.vdevs.vhost_user],=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ) as vhost:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmd(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prefix=3D&quot;vir=
tio&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 no_pci=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_channels=3D=
4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdevs=3D[self.vdev=
s.virtio_user],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ) as virtio:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # end session and reconnect<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmd(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prefix=3D&quot;vir=
tio&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 no_pci=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_channels=3D=
4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdevs=3D[self.vdev=
s.virtio_user],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ) as virtio:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio.set_forward=
_mode(SimpleForwardingModes.mac)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost.set_forward_=
mode(SimpleForwardingModes.mac)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost.start()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio.start_tx_fi=
rst(burst_num=3D32)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 forwarding_stats =
=3D vhost.stop()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_packets =3D (<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
.ForwardingParsers.rx_packets[&quot;TextParser_fn&quot;](forwarding_stats) =
or 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_packets =3D (<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
.ForwardingParsers.tx_packets[&quot;TextParser_fn&quot;](forwarding_stats) =
or 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_p=
ackets !=3D 0 and tx_packets !=3D 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;Vhost session failed to receive packets from virtio session.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def pvp_loop(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Test vhost/virtio physical-v=
irtual-physical loop topology.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Launch testpmd session with a =
physical NIC and virtio-user vdev<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 connected to a vho=
st-net socket.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Configure the tap interface th=
at is created with IP address and<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set link state to =
UP.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Launch second testpmd session =
with af_packet vdev connected to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 the tap interface.=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Start packet forwarding on bot=
h testpmd sessions.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Send 100 packets to the physic=
al interface from external tester.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Capture packets on the same ph=
ysical interface.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Physical interface receives al=
l 100 sent packets.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.sut_node =3D self._ctx.sut_node<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not isinstance(self.sut_node.main_session, =
LinuxSession):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify(False, &quot;Must be=
 running on a Linux environment.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmd(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prefix=3D&quot;virtio&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdevs=3D[VirtualDevice(&quot;vir=
tio_user0,path=3D/dev/vhost-net,queues=3D1,queue_size=3D1024&quot;)],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ) as virtio:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.sut_node.main_session.send_=
command(&quot;ip link set dev tap0 up&quot;, privileged=3DTrue)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmd(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prefix=3D&quot;vho=
st&quot;, no_pci=3DTrue, vdevs=3D[VirtualDevice(&quot;net_af_packet0,iface=
=3Dtap0&quot;)]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ) as vhost:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio.set_forward=
_mode(SimpleForwardingModes.mac)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost.set_forward_=
mode(SimpleForwardingModes.mac)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost.start()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio.start()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet =3D Ether()=
 / IP()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets =3D [packe=
t] * 100<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 captured_packets =
=3D self.send_packets_and_capture(packets)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len(=
captured_packets) &gt;=3D 100, &quot;Sent packets not received on physical =
interface.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br></blockquote>=
<div><br></div><div>Can you remind me what docs you were working from for s=
etting up the pvp test? I&#39;m guessing how you&#39;ve done it is valid, b=
ut I originally thought we needed 2 tap interfaces and that vhost had to ru=
n in --no-pci, not virtio. Better safe than sorry. :)</div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
-- <br>
2.51.0<br>
<br></blockquote><div><br></div><div>Reviewed-by: Patrick Robb &lt;<a href=
=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;=C2=A0</div></div></=
div>

--000000000000566d320641d303bc--
