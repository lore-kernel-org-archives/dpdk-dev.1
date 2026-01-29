Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AB4D73E84
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 19:59:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AD5A40274;
	Thu, 29 Jan 2026 20:59:38 +0100 (CET)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51]) by mails.dpdk.org (Postfix) with ESMTP id 086844014F
 for <dev@dpdk.org>; Thu, 29 Jan 2026 20:59:36 +0100 (CET)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b87003e998bso397318066b.1
 for <dev@dpdk.org>; Thu, 29 Jan 2026 11:59:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769716776; cv=none;
 d=google.com; s=arc-20240605;
 b=ZNpJD83cnW6d9HWjM3xsl6WRhQHchkyD3GhC0CDUsZjO5CzSx41oug79OKOJSYnjtX
 6p3REjn04nWf2MVLNH6fWl3GwpV/hepcPHBm/cIJZEtbXjCDyYrskeOvZZhW1S3J1dCA
 IyW/uYXY+be34GjPA/U3n/852kEESxLqSj8Ta5LLOy5AxlVvj+XJHdCxY8f2fT0eFbfI
 xflzeec08o8vVuUG3mLoCWBSaEW75zBoYl3URHp51AduXkzRRvVtGljgL7dn3jzGLekP
 SCs6g3kTxXIZdbq+Wc9+Q+d4hsn/9jNLbQULEPl6ceuwGPKE2qaOpI3M+Fs9aiPCEhEM
 4V0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nvzGnLgO8X70Bl4Z0KA5L2kvKol8dO9UO/pk+Dx1gAw=;
 fh=woCvo8oC7aEqPH/2/K+1ZuKnb23EkXdWGfkdifc9IZU=;
 b=jPkTj0XOwwAr9b4EXHcFq7EDXU2yqUqcUs66NQ8XYLsnak63feEqBsRHVND7rCWdgs
 iUqwK9cNNdJ0YY/S/WfSGIA6hEoq3EjpVEqBeAlpOBI/va07NuUy43jk7aYk4wzZmJcq
 kjCNP594QXxQYBzJQ2P5EosdDjaUM5LVn4knDKwdkWXHNLUQu7iH81qYLn2XmkR2upqy
 wVfg/clUPdiRQWn6KZ7IyG0Z7aPwQ7ox/NhgFosfykp2K5c3YmE5v//vXxTTGb//JQsO
 8IrtPXBSH3zZ4BBiUPIbidJ4GR00TR2/arw0xivOSURUsRho+Y+xXthd3UjQqxlj1XUn
 QODA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1769716776; x=1770321576; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nvzGnLgO8X70Bl4Z0KA5L2kvKol8dO9UO/pk+Dx1gAw=;
 b=AHUW+7ABpxQxrx51Xp0BwvLiERZnlFLYF4MT1d2uPR9FKYqf22BT6jxchY9kUlib/E
 2isq3PdOP3BZF8Lq16C2G2jU0BMdnCjFMKtUvrPae4eRmDg2+k7K2IV+m+iXPb4XnYc4
 R76uxhBZ6trP7TVloWeTr1UljpF/ol4dwXwA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769716776; x=1770321576;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nvzGnLgO8X70Bl4Z0KA5L2kvKol8dO9UO/pk+Dx1gAw=;
 b=OHCPWFra+aReYfsp6qauWTvfHlsQJNi+IqKqFYoR/SpRfSytF3Ej+pSaSLbd8cUNpm
 WFslKNt2HbLnYUjiUW68al697nBHrUS3e9dfnbuHZPbf3FUDbfDkGicdXcBvcQyd6b4j
 8F5/z/zIeIfRlGZlip9ccfup/IJn0QsO2cwX1q5GchrW5DT75laq6VwOqGxiUW/A07yY
 eUs6S9Ub2XTbrHacNXQkJj9nS+/tHixHtQbtWaEkE6PiksI5rGB4v5+geDiFp0BmWwwU
 W8qWnjlEq6EB66wv/iDAjSjziqegeUO1aD1E3zSYCuTpNQ/LcTAzDp00tkbgwfc4olLv
 Nfbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl0OClTG9efWh9PLsKddmHYROut0seAC9un3HaGOTZ16zcwA7X4Vd7miANBf2vKJZjxag=@dpdk.org
X-Gm-Message-State: AOJu0Yy/tESJEew3Qp5siJbJG0CJAoEAlG+ciHhO5KkrGhMFGI0jyMJQ
 Kb/nbkg5SO01ri92VLyiJ9VfxJbnvJFitW7oRSnM572doiZ2FVsvm/JcqdFW70mgdY4EgQWLMt+
 vJ2HYkJe9/c8ztMimY5gR1DzRSPSdX7WXDc++kN47dA==
X-Gm-Gg: AZuq6aJMCHGgygt380z6T6ea6PELH/BMUWxg4H+veGGirhkLfoOwXZ5rKxH+1Frf5rt
 2+HJ7ZEdD2DcVC+LwU8Jh2mUVbUgy3OnkFYp8CuwwwkLZQ9kxghbI8PT8T7FC0ZyouauQAC4Ylo
 G46QgpNk5vfg3iXAM6Ndbq0KYkcGISyBRszE1sCXil/qkY9PfGbKtGdYKG0QtLOLXcDmzkQIZOa
 f9lQT8cYVjAZ7IVvyFzfo3Z/Zhyqm7oFD4Wi8iuhVt2tJY+fAYbWub7YD7/u+wzrKffk5ZJsXRK
 vQoPNwebhvak+nP3el7Cxl03ExiM
X-Received: by 2002:a17:907:7293:b0:b8d:bcea:452 with SMTP id
 a640c23a62f3a-b8ddf8046e7mr283303566b.6.1769716776407; Thu, 29 Jan 2026
 11:59:36 -0800 (PST)
MIME-Version: 1.0
References: <20251217195155.32350-1-dmarx@iol.unh.edu>
In-Reply-To: <20251217195155.32350-1-dmarx@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Thu, 29 Jan 2026 14:59:25 -0500
X-Gm-Features: AZwV_QhOxIc0vczb2FExKQkOPHjiNJ7tPs2W8ns9us9IwxS9KE4tpfdE6r1cvOE
Message-ID: <CABJ3N2Ud-PzOMTLi0Dgo76fsmUucF=BHLHXk0kZcJo-HreTBXA@mail.gmail.com>
Subject: Re: [RFC PATCH] dts: add PVVP case to virtio suite
To: Dean Marx <dmarx@iol.unh.edu>
Cc: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000cfa8f806498c4b10"
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

--000000000000cfa8f806498c4b10
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>

On Wed, Dec 17, 2025 at 2:52=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote=
:

> Add an additional test case to the virtio_fwd suite which
> tests packet forwarding across a physical-virtual-virtual-physical
> topology.
>
> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> ---
>  dts/tests/TestSuite_virtio_fwd.py | 99 +++++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
>
> diff --git a/dts/tests/TestSuite_virtio_fwd.py
> b/dts/tests/TestSuite_virtio_fwd.py
> index bdecdb76fd..e78da7da05 100644
> --- a/dts/tests/TestSuite_virtio_fwd.py
> +++ b/dts/tests/TestSuite_virtio_fwd.py
> @@ -6,6 +6,8 @@
>  Verify vhost/virtio pvp and fully virtual functionalities.
>  """
>
> +from pathlib import PurePath
> +
>  from scapy.layers.inet import IP
>  from scapy.layers.l2 import Ether
>
> @@ -195,3 +197,100 @@ def pvp_loop(self) -> None:
>                      f"PVP loop forwarding verification failed: vhost
> interface RX=3D{rx_packets},"
>                      f" TX=3D{tx_packets} (expected =E2=89=A5100 each).",
>                  )
> +
> +    @requires(topology_type=3DLinkTopology.ONE_LINK)
> +    @func_test
> +    def pvvp_loop(self) -> None:
> +        """Test vhost/virtio physical-virtual-virtual-physical topology.
> +
> +        Steps:
> +            * Create directory for vhost-user socket files.
> +            * Launch primary testpmd session with physical NICs and two
> virtio-user
> +                vdevs connected to vhost-user sockets in server mode.
> +            * Launch first vhost testpmd session with vhost vdev
> connected to the
> +                first vhost-user socket as client.
> +            * Launch second vhost testpmd session with vhost vdev
> connected to the
> +                second vhost-user socket as client.
> +            * Configure port forwarding order in primary session to chai=
n
> physical
> +                port through both virtual devices.
> +            * Start packet forwarding on all three testpmd sessions.
> +            * Send 100 packets to the physical interface from external
> tester.
> +
> +        Verify:
> +            * Both vhost sessions receive/forward 100+ packets each.
> +        """
> +        self.sut_node =3D self._ctx.sut_node
> +        if not isinstance(self.sut_node.main_session, LinuxSession):
> +            verify(False, "Must be running on a Linux environment.")
> +        self.sut_node.main_session.remove_remote_dir("/tmp/vhost-sockets=
")
> +
> self.sut_node.main_session.create_directory(PurePath("/tmp/vhost-sockets"=
))
> +        with (
> +            TestPmd(
> +                prefix=3D"vhost1",
> +                vdevs=3D[
> +
> VirtualDevice("net_vhost0,iface=3D/tmp/vhost-sockets/vhost0,queues=3D1,cl=
ient=3D1")
> +                ],
> +                no_pci=3DTrue,
> +            ) as vhost1,
> +            TestPmd(
> +                prefix=3D"vhost2",
> +                vdevs=3D[
> +
> VirtualDevice("net_vhost1,iface=3D/tmp/vhost-sockets/vhost1,queues=3D1,cl=
ient=3D1")
> +                ],
> +                no_pci=3DTrue,
> +            ) as vhost2,
> +            TestPmd(
> +                prefix=3D"virtio",
> +                vdevs=3D[
> +                    VirtualDevice(
> +
> "net_virtio_user0,mac=3D00:00:00:00:00:01,path=3D/tmp/vhost-sockets/vhost=
0,queues=3D1,queue_size=3D1024,server=3D1"
> +                    ),
> +                    VirtualDevice(
> +
> "net_virtio_user1,mac=3D00:00:00:00:00:02,path=3D/tmp/vhost-sockets/vhost=
1,queues=3D1,queue_size=3D1024,server=3D1"
> +                    ),
> +                ],
> +                port_topology=3DPortTopology.chained,
> +            ) as virtio,
> +        ):
> +            virtio.set_forward_mode(SimpleForwardingModes.mac)
> +            vhost1.set_forward_mode(SimpleForwardingModes.mac)
> +            vhost2.set_forward_mode(SimpleForwardingModes.mac)
> +
> +            portlist_order =3D [0, 2, 3, 1] if len(virtio.ports) =3D=3D =
4 else
> [0, 2, 1]
> +            virtio.set_portlist(order=3Dportlist_order)
> +
> +            virtio.start()
> +            vhost1.start()
> +            vhost2.start()
> +
> +            packet =3D Ether() / IP()
> +            packets =3D [packet] * 100
> +            send_packets_and_capture(packets)
> +
> +            vhost1.stop()
> +            vhost2.stop()
> +            virtio.stop()
> +
> +            vhost1_forwarding_stats, vhost1_raw_output =3D
> vhost1.show_port_stats_all()
> +            vhost2_forwarding_stats, vhost2_raw_output =3D
> vhost2.show_port_stats_all()
> +
> +            rx_packets_vhost1 =3D vhost1_forwarding_stats[0].rx_packets
> +            tx_packets_vhost1 =3D vhost1_forwarding_stats[0].tx_packets
> +
> +            rx_packets_vhost2 =3D vhost2_forwarding_stats[0].rx_packets
> +            tx_packets_vhost2 =3D vhost2_forwarding_stats[0].tx_packets
> +
> +            log(f"Vhost1 forwarding statistics:\n{vhost1_raw_output}")
> +            log(f"Vhost2 forwarding statistics:\n{vhost2_raw_output}")
> +
> +            verify(
> +                rx_packets_vhost1 >=3D 100 and tx_packets_vhost1 >=3D 10=
0,
> +                f"PVP loop forwarding verification failed: vhost1
> interface RX=3D{rx_packets_vhost1},"
> +                f" TX=3D{tx_packets_vhost1} (expected =E2=89=A5100 each)=
.",
> +            )
> +
> +            verify(
> +                rx_packets_vhost2 >=3D 100 and tx_packets_vhost2 >=3D 10=
0,
> +                f"PVP loop forwarding verification failed: vhost2
> interface RX=3D{rx_packets_vhost2},"
> +                f" TX=3D{tx_packets_vhost2} (expected =E2=89=A5100 each)=
.",
> +            )
> --
> 2.51.0
>
>

--000000000000cfa8f806498c4b10
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@i=
ol.unh.edu">abailey@iol.unh.edu</a>&gt;</div><br><div class=3D"gmail_quote =
gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 17=
, 2025 at 2:52=E2=80=AFPM Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu=
">dmarx@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Add an additional test case to the virtio_fwd suite whic=
h<br>
tests packet forwarding across a physical-virtual-virtual-physical<br>
topology.<br>
<br>
Signed-off-by: Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" target=3D=
"_blank">dmarx@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/tests/TestSuite_virtio_fwd.py | 99 ++++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 99 insertions(+)<br>
<br>
diff --git a/dts/tests/TestSuite_virtio_fwd.py b/dts/tests/TestSuite_virtio=
_fwd.py<br>
index bdecdb76fd..e78da7da05 100644<br>
--- a/dts/tests/TestSuite_virtio_fwd.py<br>
+++ b/dts/tests/TestSuite_virtio_fwd.py<br>
@@ -6,6 +6,8 @@<br>
=C2=A0Verify vhost/virtio pvp and fully virtual functionalities.<br>
=C2=A0&quot;&quot;&quot;<br>
<br>
+from pathlib import PurePath<br>
+<br>
=C2=A0from scapy.layers.inet import IP<br>
=C2=A0from scapy.layers.l2 import Ether<br>
<br>
@@ -195,3 +197,100 @@ def pvp_loop(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0f&quot;PVP loop forwarding verification failed: vhost interface RX=3D{rx=
_packets},&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0f&quot; TX=3D{tx_packets} (expected =E2=89=A5100 each).&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
+<br>
+=C2=A0 =C2=A0 @requires(topology_type=3DLinkTopology.ONE_LINK)<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def pvvp_loop(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Test vhost/virtio physical-v=
irtual-virtual-physical topology.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create directory for vhost-use=
r socket files.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Launch primary testpmd session=
 with physical NICs and two virtio-user<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdevs connected to=
 vhost-user sockets in server mode.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Launch first vhost testpmd ses=
sion with vhost vdev connected to the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 first vhost-user s=
ocket as client.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Launch second vhost testpmd se=
ssion with vhost vdev connected to the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 second vhost-user =
socket as client.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Configure port forwarding orde=
r in primary session to chain physical<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port through both =
virtual devices.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Start packet forwarding on all=
 three testpmd sessions.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Send 100 packets to the physic=
al interface from external tester.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Both vhost sessions receive/fo=
rward 100+ packets each.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.sut_node =3D self._ctx.sut_node<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not isinstance(self.sut_node.main_session, =
LinuxSession):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(False, &quot;Must be runn=
ing on a Linux environment.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.sut_node.main_session.remove_remote_dir(&=
quot;/tmp/vhost-sockets&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.sut_node.main_session.create_directory(Pu=
rePath(&quot;/tmp/vhost-sockets&quot;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmd(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prefix=3D&quot;vho=
st1&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdevs=3D[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Virt=
ualDevice(&quot;net_vhost0,iface=3D/tmp/vhost-sockets/vhost0,queues=3D1,cli=
ent=3D1&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 no_pci=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ) as vhost1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmd(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prefix=3D&quot;vho=
st2&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdevs=3D[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Virt=
ualDevice(&quot;net_vhost1,iface=3D/tmp/vhost-sockets/vhost1,queues=3D1,cli=
ent=3D1&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 no_pci=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ) as vhost2,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmd(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prefix=3D&quot;vir=
tio&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdevs=3D[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Virt=
ualDevice(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;net_virtio_user0,mac=3D00:00:00:00:00:01,path=3D/tmp/vhost=
-sockets/vhost0,queues=3D1,queue_size=3D1024,server=3D1&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Virt=
ualDevice(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;net_virtio_user1,mac=3D00:00:00:00:00:02,path=3D/tmp/vhost=
-sockets/vhost1,queues=3D1,queue_size=3D1024,server=3D1&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_topology=3DPo=
rtTopology.chained,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ) as virtio,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio.set_forward_mode(SimpleFo=
rwardingModes.mac)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost1.set_forward_mode(SimpleFo=
rwardingModes.mac)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost2.set_forward_mode(SimpleFo=
rwardingModes.mac)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 portlist_order =3D [0, 2, 3, 1] =
if len(virtio.ports) =3D=3D 4 else [0, 2, 1]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio.set_portlist(order=3Dport=
list_order)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio.start()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost1.start()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost2.start()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet =3D Ether() / IP()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets =3D [packet] * 100<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_packets_and_capture(packets=
)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost1.stop()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost2.stop()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio.stop()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost1_forwarding_stats, vhost1_=
raw_output =3D vhost1.show_port_stats_all()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost2_forwarding_stats, vhost2_=
raw_output =3D vhost2.show_port_stats_all()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_packets_vhost1 =3D vhost1_for=
warding_stats[0].rx_packets<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_packets_vhost1 =3D vhost1_for=
warding_stats[0].tx_packets<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_packets_vhost2 =3D vhost2_for=
warding_stats[0].rx_packets<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_packets_vhost2 =3D vhost2_for=
warding_stats[0].tx_packets<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log(f&quot;Vhost1 forwarding sta=
tistics:\n{vhost1_raw_output}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log(f&quot;Vhost2 forwarding sta=
tistics:\n{vhost2_raw_output}&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_packets_vhost1 =
&gt;=3D 100 and tx_packets_vhost1 &gt;=3D 100,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;PVP loop fo=
rwarding verification failed: vhost1 interface RX=3D{rx_packets_vhost1},&qu=
ot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot; TX=3D{tx_p=
ackets_vhost1} (expected =E2=89=A5100 each).&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_packets_vhost2 =
&gt;=3D 100 and tx_packets_vhost2 &gt;=3D 100,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;PVP loop fo=
rwarding verification failed: vhost2 interface RX=3D{rx_packets_vhost2},&qu=
ot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot; TX=3D{tx_p=
ackets_vhost2} (expected =E2=89=A5100 each).&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-- <br>
2.51.0<br>
<br>
</blockquote></div>

--000000000000cfa8f806498c4b10--
