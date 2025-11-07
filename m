Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B9ACCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 20:15:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C17C2402A3;
	Fri,  7 Nov 2025 21:15:40 +0100 (CET)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id A11724026D
 for <dev@dpdk.org>; Fri,  7 Nov 2025 21:15:38 +0100 (CET)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-b9ab6cdf64bso528816a12.0
 for <dev@dpdk.org>; Fri, 07 Nov 2025 12:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762546538; x=1763151338; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0ElUfRXUDdQHlrBgbnXid5o9o3QulreE7+RFljZfsr8=;
 b=Ms9eurvwim2+04wZw2a3HWARn6hMFtYACBXyxqvLRz6RImehnN9sCRIv9KS3oWc1Yn
 xL7Wv2b5Xyh0YKYcrIgdLbdiMkLyybD/aSZHj99eqj8AmVYDOBZQzwKXOW5tG2Hd78zk
 tGcBQlK9Z8Yzub4z1iXUkinY7zio3oOS5kamY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762546538; x=1763151338;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ElUfRXUDdQHlrBgbnXid5o9o3QulreE7+RFljZfsr8=;
 b=pDAJo8uS0+TSwNbrcF+uC0xfaBSztF8tmwtjqMvpAJL7WnXq32GfiaWzpGavhWUhrV
 oSS8T+Yv6RDloHLmyyVFskGYGfZ3xALKpKL1HGEIEjd+ty4XwZM3IqkkogCeGZgosk79
 ZiKseHkCWHY2+RJVpMmrYk7sQ8QYea59WDyaab17Bm2MWVG7id4QmmSp7S0PsNCouJ1+
 YNy/92vFs+6XKahAVe/WZZMT7gBsfz5nKxyXmGtsVfIMzHAEh+OHzAZuOKszS7zKPkJr
 lqmM2DdS3CvkVUSyLp5cgobzgr1SatwutuCD+9rDuD/CDgZdacszDDqTynKXXo7e18G9
 BM4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMAbfjrpQxaBfq52AYMs25OpOTY+XXvdBslDUOmvUcQsUuDfX1IkPoZgUO+NXLO04kJzc=@dpdk.org
X-Gm-Message-State: AOJu0YxY0FNfgrUQxCjxk61fyg7bQVZfCVvuUr3z4AhZbxAy3ls1GH8U
 swuD7v4JjXyQIN6noqsl3zA5hh1YiV+iOdxXKYLFjA83l2cgPezvhlUCvmJF08c37I8ACBp5F+G
 qd/WJjyDWpLt7uid4Sn7CMEMZHmkX8Hkr8BMM088H8A==
X-Gm-Gg: ASbGnct4XqXFA9PaadWgpNNdCp2HZrMjTr3IIUJUY8P1h8JwZz4CbE0wrEWG8VrAEBQ
 sHZ4KNOkmjxlXumLws9JUIjP1c2eaD6pY7UfEN2htPjYC9Gi5vAQ/EST0TDMNoWAxcGns8oljnL
 DitE3S0gzvtlCiJwEgXuYG+5Pq0k96I9s9VKBuYx912AxaO9zht0S2TLmGoBG2o0V4+0ePCArMW
 JWvdxeYGpN0Quk8ZPOE6tiS3VGPcu/mjurHyTfRuaUjkZ8wJLJ0VlH624CAedyge/Fqxhx0DeDS
 HV44R+/OF9YgyTrlbB8X+WhpJ1NV
X-Google-Smtp-Source: AGHT+IE4XjASc9z9FjS11FS3jZZGlE6DsQcv2bwkCpNmGaAdSJ4x9IPtN/MNpSIekMoh7w4l+7KKEOL03eVudnXiPyI=
X-Received: by 2002:a17:902:cf0b:b0:290:ad7a:bb50 with SMTP id
 d9443c01a7336-297c96a5cd5mr33347645ad.27.1762546537676; Fri, 07 Nov 2025
 12:15:37 -0800 (PST)
MIME-Version: 1.0
References: <20251017203159.557830-1-dmarx@iol.unh.edu>
 <20251024181606.604135-1-dmarx@iol.unh.edu>
 <20251024181606.604135-2-dmarx@iol.unh.edu>
In-Reply-To: <20251024181606.604135-2-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 7 Nov 2025 15:14:27 -0500
X-Gm-Features: AWmQ_bltWO6YVdRHMI-nVuQm3U4M_3BG1SH9y4txrGqQyT4Ctc9iBUCuuTIlCZQ
Message-ID: <CAJvnSUDywCd9cdjWtpGjpkdB0Mk-dYs+bmra_CKKNhkD6Q44Mg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dts: add QinQ test suite
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000004751e6064306d831"
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

--0000000000004751e6064306d831
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 2:16=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote=
:

> +        packets =3D [
> +            Ether(dst=3D"00:11:22:33:44:55", src=3D"66:77:88:99:aa:bb")
> +            / Dot1AD(vlan=3D100)
> +            / Dot1Q(vlan=3D200)
> +            / IP(dst=3D"192.0.2.1", src=3D"198.51.100.1")
> +            / UDP(dport=3D1234, sport=3D5678),

+            Ether(dst=3D"00:11:22:33:44:55", src=3D"66:77:88:99:aa:bb")
> +            / Dot1AD(vlan=3D101)
> +            / Dot1Q(vlan=3D200)
> +            / IP(dst=3D"192.0.2.1", src=3D"198.51.100.1")
> +            / UDP(dport=3D1234, sport=3D5678),
> +        ]
>

Add  / Raw(b"xxxxx"), to both packets above if we keep this testcase.


> +        with TestPmd() as testpmd:
> +            testpmd.set_vlan_filter(0, True)
> +            testpmd.set_vlan_extend(0, True)
> +            testpmd.rx_vlan(100, 0, True)
> +            self._send_packet_and_verify(packets[0], testpmd,
> should_receive=3DTrue)
> +            self._send_packet_and_verify(packets[1], testpmd,
> should_receive=3DFalse)
> +
>

The testcase does look good except that form what I'm seeing, vlan_filter
is not supported for 88a8 + 8100 packets (it won't read the 88a8 tag). I
sent Bruce and Morten an email about it. But, I think the most reasonable
thing is to remove this testcase for the 25.11 release since the expected
behavior is either not well defined, or vlan_filter is not supposed to be
able to read 88a8 tags.


> +    @func_test
> +    def test_qinq_forwarding(self) -> None:
> +        """QinQ Rx filter test case.
> +
> +        Steps:
> +            Launch testpmd with mac forwarding mode.
> +            Disable VLAN filter mode on port 0.
> +            Send test packet and capture verbose output.
> +
> +        Verify:
> +            Check that the received packet has two separate VLAN layers
> in proper QinQ fashion.
> +            Check that the received packet outer and inner VLAN layer ha=
s
> the appropriate ID.
> +        """
> +        test_packet =3D (
> +            Ether(dst=3D"ff:ff:ff:ff:ff:ff")
> +            / Dot1AD(vlan=3D100)
> +            / Dot1Q(vlan=3D200)
> +            / IP(dst=3D"1.2.3.4")
> +            / UDP(dport=3D1234, sport=3D4321)
> +            / Raw(load=3D"xxxxx")
> +        )
> +        with TestPmd() as testpmd:
> +            testpmd.set_vlan_filter(0, False)
> +            testpmd.start()
> +            received_packets =3D send_packet_and_capture(test_packet)
> +            packet =3D self._get_relevant_packet(received_packets)
> +
> +            verify(packet is not None, "Packet was dropped when it shoul=
d
> have been received.")
> +
> +            if packet is not None:
> +                verify(bool(packet.haslayer(Dot1AD)), "QinQ layer not
> found in packet")
>

I guess you can also verify that packet haslayer(Dot1Q)


> +
> +                if outer_vlan :=3D packet.getlayer(Dot1AD):
> +                    outer_vlan_id =3D outer_vlan.vlan
> +                    verify(
> +                        outer_vlan_id =3D=3D 100,
> +                        f"Outer VLAN ID was {outer_vlan_id} when it
> should have been 100.",
> +                    )
> +                else:
> +                    verify(False, "VLAN layer not found in received
> packet.")
> +
> +                if outer_vlan and (inner_vlan :=3D
> outer_vlan.getlayer(Dot1Q)):
> +                    inner_vlan_id =3D inner_vlan.vlan
> +                    verify(
> +                        inner_vlan_id =3D=3D 200,
> +                        f"Inner VLAN ID was {inner_vlan_id} when it
> should have been 200",
> +                    )
> +
> +    @requires_nic_capability(NicCapability.RX_OFFLOAD_QINQ_STRIP)
> +    @func_test
> +    def test_qinq_strip(self) -> None:
> +        """Test combinations of VLAN/QinQ strip settings with various
> QinQ packets.
> +
> +        Steps:
> +            Launch testpmd with QinQ and VLAN strip enabled.
> +            Send four VLAN/QinQ related test packets.
> +
> +        Verify:
> +            Check received packets have the expected VLAN/QinQ
> layers/tags.
> +        """
> +        test_packets =3D [
> +            Ether() / Dot1Q() / IP() / UDP(dport=3D1234, sport=3D4321) /
> Raw(load=3D"xxxxx"),
> +            Ether()
> +            / Dot1Q(vlan=3D100)
> +            / Dot1Q(vlan=3D200)
> +            / IP()
> +            / UDP(dport=3D1234, sport=3D4321)
> +            / Raw(load=3D"xxxxx"),
> +            Ether() / Dot1AD() / IP() / UDP(dport=3D1234, sport=3D4321) =
/
> Raw(load=3D"xxxxx"),
> +            Ether() / Dot1AD() / Dot1Q() / IP() / UDP(dport=3D1234,
> sport=3D4321) / Raw(load=3D"xxxxx"),
> +        ]
> +        with TestPmd() as testpmd:
> +            testpmd.set_qinq_strip(0, True)
> +            testpmd.set_vlan_strip(0, True)
> +            testpmd.start()
> +
> +            received_packets1 =3D send_packet_and_capture(test_packets[0=
])
> +            packet1 =3D self._get_relevant_packet(received_packets1)
> +            received_packets2 =3D send_packet_and_capture(test_packets[1=
])
> +            packet2 =3D self._get_relevant_packet(received_packets2)
> +            received_packets3 =3D send_packet_and_capture(test_packets[2=
])
> +            packet3 =3D self._get_relevant_packet(received_packets3)
> +            received_packets4 =3D send_packet_and_capture(test_packets[3=
])
> +            packet4 =3D self._get_relevant_packet(received_packets4)
>

rename to make them more descriptive? I.e. vlan_packet, 2_vlan_packet,
qinq_packet, qinq_vlan_packet? Or similar.


> +
> +            testpmd.stop()
> +
> +            tests =3D [
> +                ("Single 8100 tag", self._strip_verify(packet1, False,
> "Single 8100 tag")),
> +                (
> +                    "Double 8100 tag",
> +                    self._strip_verify(packet2, True, "Double 8100 tag")=
,
> +                ),
> +                ("Single 88a8 tag", self._strip_verify(packet3, False,
> "Single 88a8 tag")),
> +                (
> +                    "QinQ (88a8 and 8100 tags)",
> +                    self._strip_verify(packet4, False, "QinQ (88a8 and
> 8100 tags)"),
> +                ),
> +            ]
>

this is good for testing behavior when we have both vlan_strip and
qinq_strip enabled. What about when we have only vlan_strip enabled or only
qinq_strip enabled? I.e. when we have only vlan_strip enabled, and we send
an 88a8 only packet, nothing should get stripped at all. It probably makes
sense to have different testcases for vlan strip, qinq_strip, and
vlan_strip + qinq_strip.


> +
> +            failed =3D [ctx for ctx, result in tests if not result]
> +
> +            verify(
> +                not failed,
> +                f"The following packets were not stripped correctly: {',
> '.join(failed)}",
> +            )
> --
> 2.51.0
>
>
Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--0000000000004751e6064306d831
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div dir=3D"ltr"><div dir=3D"lt=
r"><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Fri, Oct 24, 2025 at 2:16=E2=80=AFPM Dean Marx &lt;<a href=3D"mai=
lto:dmarx@iol.unh.edu" target=3D"_blank">dmarx@iol.unh.edu</a>&gt; wrote:</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packets =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether(dst=3D&quot;00:11:22:33:44=
:55&quot;, src=3D&quot;66:77:88:99:aa:bb&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / Dot1AD(vlan=3D100)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / Dot1Q(vlan=3D200)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / IP(dst=3D&quot;192.0.2.1&quot;=
, src=3D&quot;198.51.100.1&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / UDP(dport=3D1234, sport=3D5678=
),=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether(dst=3D&quot;00:11:22:33:44=
:55&quot;, src=3D&quot;66:77:88:99:aa:bb&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / Dot1AD(vlan=3D101)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / Dot1Q(vlan=3D200)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / IP(dst=3D&quot;192.0.2.1&quot;=
, src=3D&quot;198.51.100.1&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / UDP(dport=3D1234, sport=3D5678=
),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br></blockquote><div><br></div><div>Add=C2=
=A0 / Raw(b&quot;xxxxx&quot;), to both packets above if we keep this testca=
se.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmd() as testpmd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.set_vlan_filter(0, True)=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.set_vlan_extend(0, True)=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.rx_vlan(100, 0, True)<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._send_packet_and_verify(pac=
kets[0], testpmd, should_receive=3DTrue)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._send_packet_and_verify(pac=
kets[1], testpmd, should_receive=3DFalse)<br>
+<br></blockquote><div><br></div><div>The testcase does look good except th=
at form what I&#39;m seeing, vlan_filter is not supported for 88a8=C2=A0+ 8=
100 packets (it won&#39;t read the 88a8 tag). I sent Bruce and Morten an em=
ail about it. But, I think the most reasonable thing is to remove this test=
case for the 25.11 release since the expected behavior is either not well d=
efined, or vlan_filter is not supposed to be able to read 88a8 tags.</div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def test_qinq_forwarding(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;QinQ Rx filter test case.<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Launch testpmd with mac forwardi=
ng mode.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Disable VLAN filter mode on port=
 0.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Send test packet and capture ver=
bose output.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Check that the received packet h=
as two separate VLAN layers in proper QinQ fashion.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Check that the received packet o=
uter and inner VLAN layer has the appropriate ID.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_packet =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether(dst=3D&quot;ff:ff:ff:ff:ff=
:ff&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / Dot1AD(vlan=3D100)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / Dot1Q(vlan=3D200)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / IP(dst=3D&quot;1.2.3.4&quot;)<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / UDP(dport=3D1234, sport=3D4321=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / Raw(load=3D&quot;xxxxx&quot;)<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmd() as testpmd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.set_vlan_filter(0, False=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.start()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_packets =3D send_packet=
_and_capture(test_packet)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet =3D self._get_relevant_pa=
cket(received_packets)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(packet is not None, &quot=
;Packet was dropped when it should have been received.&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if packet is not None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(bool(packet=
.haslayer(Dot1AD)), &quot;QinQ layer not found in packet&quot;)<br></blockq=
uote><div><br></div><div>I guess you can also verify that packet haslayer(D=
ot1Q)</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if outer_vlan :=3D=
 packet.getlayer(Dot1AD):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 oute=
r_vlan_id =3D outer_vlan.vlan<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 veri=
fy(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 outer_vlan_id =3D=3D 100,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 f&quot;Outer VLAN ID was {outer_vlan_id} when it should have bee=
n 100.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 veri=
fy(False, &quot;VLAN layer not found in received packet.&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if outer_vlan and =
(inner_vlan :=3D outer_vlan.getlayer(Dot1Q)):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 inne=
r_vlan_id =3D inner_vlan.vlan<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 veri=
fy(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 inner_vlan_id =3D=3D 200,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 f&quot;Inner VLAN ID was {inner_vlan_id} when it should have bee=
n 200&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br=
>
+<br>
+=C2=A0 =C2=A0 @requires_nic_capability(NicCapability.RX_OFFLOAD_QINQ_STRIP=
)<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def test_qinq_strip(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Test combinations of VLAN/Qi=
nQ strip settings with various QinQ packets.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Launch testpmd with QinQ and VLA=
N strip enabled.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Send four VLAN/QinQ related test=
 packets.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Check received packets have the =
expected VLAN/QinQ layers/tags.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_packets =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether() / Dot1Q() / IP() / UDP(d=
port=3D1234, sport=3D4321) / Raw(load=3D&quot;xxxxx&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / Dot1Q(vlan=3D100)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / Dot1Q(vlan=3D200)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / IP()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / UDP(dport=3D1234, sport=3D4321=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / Raw(load=3D&quot;xxxxx&quot;),=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether() / Dot1AD() / IP() / UDP(=
dport=3D1234, sport=3D4321) / Raw(load=3D&quot;xxxxx&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether() / Dot1AD() / Dot1Q() / I=
P() / UDP(dport=3D1234, sport=3D4321) / Raw(load=3D&quot;xxxxx&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmd() as testpmd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.set_qinq_strip(0, True)<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.set_vlan_strip(0, True)<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.start()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_packets1 =3D send_packe=
t_and_capture(test_packets[0])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet1 =3D self._get_relevant_p=
acket(received_packets1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_packets2 =3D send_packe=
t_and_capture(test_packets[1])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet2 =3D self._get_relevant_p=
acket(received_packets2)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_packets3 =3D send_packe=
t_and_capture(test_packets[2])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet3 =3D self._get_relevant_p=
acket(received_packets3)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_packets4 =3D send_packe=
t_and_capture(test_packets[3])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet4 =3D self._get_relevant_p=
acket(received_packets4)<br></blockquote><div><br></div><div>rename to make=
 them more descriptive? I.e. vlan_packet, 2_vlan_packet, qinq_packet, qinq_=
vlan_packet? Or similar.</div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.stop()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tests =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;Single 8100=
 tag&quot;, self._strip_verify(packet1, False, &quot;Single 8100 tag&quot;)=
),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;Double 8100 tag&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
._strip_verify(packet2, True, &quot;Double 8100 tag&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;Single 88a8=
 tag&quot;, self._strip_verify(packet3, False, &quot;Single 88a8 tag&quot;)=
),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;QinQ (88a8 and 8100 tags)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
._strip_verify(packet4, False, &quot;QinQ (88a8 and 8100 tags)&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br></blockquote><div><br></div=
><div>this is good for testing behavior when we have both vlan_strip and qi=
nq_strip enabled. What about when we have only vlan_strip enabled or only q=
inq_strip enabled? I.e. when we have only vlan_strip enabled, and we send a=
n 88a8 only packet, nothing should get stripped at all. It probably makes s=
ense to have different testcases for vlan strip, qinq_strip, and vlan_strip=
=C2=A0+ qinq_strip.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 failed =3D [ctx for ctx, result =
in tests if not result]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 not failed,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;The followi=
ng packets were not stripped correctly: {&#39;, &#39;.join(failed)}&quot;,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-- <br>
2.51.0<br>
<br></blockquote><div><br></div><div>Reviewed-by: Patrick Robb &lt;<a href=
=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;=C2=A0</div></div></=
div>
</div>

--0000000000004751e6064306d831--
