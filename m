Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C85CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 20:49:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F72C4026D;
	Fri,  7 Nov 2025 21:49:38 +0100 (CET)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTP id B3ED640261
 for <dev@dpdk.org>; Fri,  7 Nov 2025 21:49:36 +0100 (CET)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-b9a5b5b47bfso676548a12.1
 for <dev@dpdk.org>; Fri, 07 Nov 2025 12:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762548576; x=1763153376; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DCyY0kIP230PPCVjLzIMd9uH7/mZ520skG5RgOZsu2o=;
 b=a/B1KxaWth5SKTFFvmR6VSB9XPa0/5ddXEESwWl4d+3nZ1r3XpvKQQ9vACTA3pK+IZ
 DSYJhwuyLUOQoaZSFvteQTOaydfNBKIfEQLxYBPHiufaSuIQFNK6R18Zex8/1/JWFARL
 G7MzjEM0r9boQi8qIn2fdtWAbPoXRasGJZbvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762548576; x=1763153376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DCyY0kIP230PPCVjLzIMd9uH7/mZ520skG5RgOZsu2o=;
 b=RCjTUiAPtkaJrF/0LY1l8moCoUgh5awXr8TmcG6Cs/a4GOQxUqDebj5FtdpWjz/E+X
 5mmvk+8rr7wuJihRcQn5oWUq5LeMkXn06chSGSxTw/b+jJkM1FY3eiicX4QSYgPkh5k1
 YVYRIdIcqIcDlz9I3KyNJh5gm6wALN14i25vEc8X6yrw8n0Dgpg+mf6uUb3CuI7nLSoW
 5hBY+udDQx/lFjDGKUzBi5QOPahg6du4hNfnVUA7t/9S7RhnFwWItAPdlJnP8R0eU7tG
 yXN9aC+fSOHhYeaX1wt5151az/GNNrqHKmw7mTxCYUfRUmueqDq9PiiXRVjC2bg/xlP2
 Bp2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXalKG6xk4k1OK9ZFeHMKcX18WH2IWLdXD1O1wnacCxXzfOfKGk5TZiOmuE264p66nAHN4=@dpdk.org
X-Gm-Message-State: AOJu0YwySROUVfCTL9TUfg6pgg9SRsjPGu8fgcJT7uxIB8ZpHAKPxYZC
 u0kgStDNZKfNqS3sJ2X0R95HEGYDXg/ubeOI4p38nJmb75/ZplkiLvEkmUrgWcdx5R+g4ZNqsm6
 cVEFBrQdkXlpkw6nmk5KV5KCF3Ac7LepQdE3cRAH6xg==
X-Gm-Gg: ASbGnctTLsKOarfD/H1WNNMEesJdWueZhTElfC4x6Co6gL7e0We1krUAsw9dLgaAMSu
 yxNTjqGVCPlEU2AKzo5oZsv1nh9gqqO9vygC9uEGssYO4Ik7C9wSvTPVlxTJ0QzMIyUIECJl4ig
 5GNTNn+q9RIeBUpJ3MyKJTOrK8sLyaCMm5SlnUBAcYZrwto7dsrDwfPk3Z453FO3C8yS1EvETZD
 J3BJy+hJt7kyR6icoFVg4ZdfhGNDpfxunltgU9T8CwGc2b9DuNA5t6MQzqEEJqb7sFRsReX93ws
 LdNNjlJZ/SSWfneTAnJm
X-Google-Smtp-Source: AGHT+IFNDQvaPNAgYKm0KGWn368IotNkUnm0P3v+JxSMl0uXEHWQairWh2HDPhOxdh4wlUNUY/ePGVBET8N51VGBGR4=
X-Received: by 2002:a17:902:d485:b0:252:50ad:4e6f with SMTP id
 d9443c01a7336-297e570ac2fmr5446795ad.54.1762548575815; Fri, 07 Nov 2025
 12:49:35 -0800 (PST)
MIME-Version: 1.0
References: <20251024174702.600147-1-dmarx@iol.unh.edu>
 <20251024185056.607160-1-dmarx@iol.unh.edu>
 <20251024185056.607160-3-dmarx@iol.unh.edu>
In-Reply-To: <20251024185056.607160-3-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 7 Nov 2025 15:48:26 -0500
X-Gm-Features: AWmQ_blwfLhqYzlQVvndtEMzlefjHE2DEO_nFLxSsEBwJ3ZDwqaIsyLqn8_VzaQ
Message-ID: <CAJvnSUAHYDFrZ2cEZPUxdunAe95MpQbvwpU7AUtGFK9q+XRmKA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] dts: add virtio forwarding test suite
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000c2dc0606430751e7"
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

--000000000000c2dc0606430751e7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 2:51=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote=
:

>
> +    @requires(topology_type=3DLinkTopology.TWO_LINKS)
> +    @func_test
> +    def pvp_loop(self) -> None:
> +        """Test vhost/virtio physical-virtual-physical topology.
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
> +            * Vhost session receives/forwards 100+ packets.
> +            * Physical interface receives all 100 sent packets.
> +        """
> +        self.sut_node =3D self._ctx.sut_node
> +        if not isinstance(self.sut_node.main_session, LinuxSession):
> +            verify(False, "Must be running on a Linux environment.")
> +        with TestPmd(
> +            prefix=3D"virtio",
> +
> vdevs=3D[VirtualDevice("virtio_user0,path=3D/dev/vhost-net,queues=3D1,que=
ue_size=3D1024")],
> +        ) as virtio:
> +            self.sut_node.main_session.set_interface_link_up(name=3D"tap=
0")
>

Is it the case that if I already have tap0 created on my SUT machine, this
testsuite will create a tap1 and then the testsuite will fail to run
properly on the line above (because tap1 won't be brought up)? If there is
no way of getting around this limitation, we should add a new capability
for "tap interface names available" or something and skip if tap0 is found
in "ip a" or a similar solution.


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
> +                captured_packets =3D send_packets_and_capture(packets)
> +
> +                vhost.stop()
> +                virtio.stop()
> +
> +                vhost_forwarding_stats, vhost_raw_output =3D
> vhost.show_port_stats_all()
> +
> +                rx_packets =3D vhost_forwarding_stats[0].rx_packets
> +                tx_packets =3D vhost_forwarding_stats[0].tx_packets
> +
> +                log(f"Vhost forwarding statistics:\n{vhost_raw_output}")
> +
> +                verify(
> +                    rx_packets >=3D 100 and tx_packets >=3D 100,
> +                    f"PVP loop forwarding verification failed: vhost
> interface RX=3D{rx_packets},"
> +                    f" TX=3D{tx_packets} (expected =E2=89=A5100 each).",
> +                )
> +
> +                verify(
> +                    len(captured_packets) >=3D 100, "Sent packets not
> received on physical interface."
> +                )
> --
> 2.51.0
>
>

Otherwise, change the pvp requirement to ONE_LINK, set portlist to 0, 2, 1
(2 is the vdev) when 2 link topology, and 0, 1 when 1 link, and set
forwarding to chained mode so that the packet forwarding works as expected
regardless of whether we have 1 or 2 physical interfaces the testpmd
instance is using.

Thanks.

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--000000000000c2dc0606430751e7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 24, 2025=
 at 2:51=E2=80=AFPM Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" targ=
et=3D"_blank">dmarx@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><br>
+=C2=A0 =C2=A0 @requires(topology_type=3DLinkTopology.TWO_LINKS)<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def pvp_loop(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Test vhost/virtio physical-v=
irtual-physical topology.<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Vhost session receives/forward=
s 100+ packets.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Physical interface receives al=
l 100 sent packets.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.sut_node =3D self._ctx.sut_node<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not isinstance(self.sut_node.main_session, =
LinuxSession):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(False, &quot;Must be runn=
ing on a Linux environment.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmd(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prefix=3D&quot;virtio&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdevs=3D[VirtualDevice(&quot;vir=
tio_user0,path=3D/dev/vhost-net,queues=3D1,queue_size=3D1024&quot;)],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ) as virtio:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.sut_node.main_session.set_i=
nterface_link_up(name=3D&quot;tap0&quot;)<br></blockquote><div><br></div><d=
iv>Is it the case that if I already have tap0 created on my SUT machine, th=
is testsuite will create a tap1 and then the testsuite will fail to run pro=
perly on the line above (because tap1 won&#39;t be brought up)? If there is=
 no way of getting around this limitation, we should add a new capability f=
or &quot;tap interface names available&quot; or something and skip if tap0 =
is found in &quot;ip a&quot; or a similar solution.</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
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
=3D send_packets_and_capture(packets)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost.stop()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio.stop()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost_forwarding_s=
tats, vhost_raw_output =3D vhost.show_port_stats_all()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_packets =3D vho=
st_forwarding_stats[0].rx_packets<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_packets =3D vho=
st_forwarding_stats[0].tx_packets<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log(f&quot;Vhost f=
orwarding statistics:\n{vhost_raw_output}&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_p=
ackets &gt;=3D 100 and tx_packets &gt;=3D 100,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;PVP loop forwarding verification failed: vhost interface RX=3D{rx_packet=
s},&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot; TX=3D{tx_packets} (expected =E2=89=A5100 each).&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len(=
captured_packets) &gt;=3D 100, &quot;Sent packets not received on physical =
interface.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-- <br>
2.51.0<br>
<br></blockquote><div><br></div><div><br></div><div>Otherwise, change the p=
vp requirement to ONE_LINK, set portlist to 0, 2, 1 (2 is the vdev) when 2 =
link topology, and 0, 1 when 1 link, and set forwarding to chained mode so =
that the packet forwarding works as expected regardless of whether we have =
1 or 2 physical interfaces the testpmd instance is using.</div><div><br></d=
iv><div>Thanks.</div><div><br></div><div>Reviewed-by: Patrick Robb &lt;<a h=
ref=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;=C2=A0=C2=A0</div=
></div></div>
</div>

--000000000000c2dc0606430751e7--
