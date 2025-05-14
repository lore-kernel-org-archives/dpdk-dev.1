Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D9DC3ABD8
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 20:23:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61CD8402DC;
	Wed, 14 May 2025 22:23:23 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id DE544402C8
 for <dev@dpdk.org>; Wed, 14 May 2025 22:23:21 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-7414c7e45acso45399b3a.3
 for <dev@dpdk.org>; Wed, 14 May 2025 13:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747254201; x=1747859001; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lWxMPeyCfkHe+eaK8M5wzt+9JyPJVkV3bol2vjVE59c=;
 b=OfTyAdZ2vdCyUYgQH8thc7EbqKugc4b+TFWJ+kszWi5HM8NengUFbh8D14NwMbvfst
 fnfKGtg2oTBwSCiZB+NOm+G/cr3plBNheaTM8vkj3BpiZDRbShaSrI9pGnm13D5y8oDd
 OYrX0GOFEHFQWsm/KJpZUUI7N4pW9iIJQR5tY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747254201; x=1747859001;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lWxMPeyCfkHe+eaK8M5wzt+9JyPJVkV3bol2vjVE59c=;
 b=pARddsk9mKlkhAIlGJRa47QvXU2onwpMr6JRlZiWPP/sbUtYy8RKGEOZAdYEyE/0Vx
 xO4NEnM67qryQqDtsfqjXdO82joC3pU2XDPYuHEV2KpcLEPlK3699ZAJfIHqw4nw5APl
 gdmWy9KcTsBIKz9cLx1b3ipOhsu6MehwgCxVHA5dHu2Szamw0ObJues9ES5ydXeSSbbm
 weH96SGo9691UHHKRgMiPGtJOxZlLjp92JAw+v6fBr/39aospC5yZ7PJ9LpcioZ3/WKE
 +pSrpP9X3o4HgVipDHWC1xK7usCBrZXJvNUsloExk1AC1APWdX86JrJX2uNcKlThspQW
 9Dbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJRX1lhsy8xOwLXCh0riBfVdXBNGMcfj3N7QwfUqSf3jokNXW84/lg4DqjpFqaRsP3QdE=@dpdk.org
X-Gm-Message-State: AOJu0Yyu5Ih7IM/TQOTEMrF4Nm1dDNhqy4Em9c/ZiMHxD2h2BacWVs05
 TGtoHZL37WrcArYni4Cu+zCcLVPsKDKBLaz1xBgwZNLqMdLqqf7as//pZFvSVHkMtQuEy6uobXl
 LK0LwkRbfWTnILXRrSd7+ZuvTiXNn2HnPtRyqqw==
X-Gm-Gg: ASbGnctw/sbgw+SGSmZlNSu+6Wmd3P/VOgpQL7/hDnMVQAniFYFkl1OYJSCmjRf9AUm
 NHB1388+L8TGTY1+iQfVUfKuH1kDK5fx/YZo3DhGjfdIch6R/zllfZ6jf9EhPSD3P3Hues8tE8I
 sytz5lbRskAf21IksCBIbYSPl8Nkhl3VS5d0GLya6p4NZd/qLS
X-Google-Smtp-Source: AGHT+IGflijlBlK8MqN1GHyMsCVHjjuwUrKeed8WIUhb2ZAbNzud8MLbgaBs6OCowWlZAZkwqcLvgFsXZRGAOSNrDCk=
X-Received: by 2002:a05:6a21:e8b:b0:1f1:3f0:8b32 with SMTP id
 adf61e73a8af0-215ff214b7emr2974113637.10.1747254200841; Wed, 14 May 2025
 13:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250306214747.579340-1-dmarx@iol.unh.edu>
 <20250306214747.579340-5-dmarx@iol.unh.edu>
In-Reply-To: <20250306214747.579340-5-dmarx@iol.unh.edu>
From: Nicholas Pratte <npratte@iol.unh.edu>
Date: Wed, 14 May 2025 16:23:10 -0400
X-Gm-Features: AX0GCFu-0hOMlrSLNcJ9SbVJly4OG1EcKfA9hpCli72tKDD4sKaV54cvSmtfrtE
Message-ID: <CAKXZ7eiH5y6Cp5UR05cLOn6nVOx_X8_7J0h2BMyEw1-dqLw6kg@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] change verification field in unified packet suite
To: Dean Marx <dmarx@iol.unh.edu>
Cc: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
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

Looks good!

Reviewed-by: Nicholas Pratte <npratte@iol.unh.edu>

On Thu, Mar 6, 2025 at 4:47=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote:
>
> Changes the unified packet testing suite to use layer 4
> destination ports as packet verification IDs.
>
> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> ---
>  dts/tests/TestSuite_uni_pkt.py | 106 ++++++++++++++++-----------------
>  1 file changed, 51 insertions(+), 55 deletions(-)
>
> diff --git a/dts/tests/TestSuite_uni_pkt.py b/dts/tests/TestSuite_uni_pkt=
.py
> index 656a69b0f1..fdb9c29059 100644
> --- a/dts/tests/TestSuite_uni_pkt.py
> +++ b/dts/tests/TestSuite_uni_pkt.py
> @@ -44,7 +44,7 @@ def check_for_matching_packet(
>      ) -> bool:
>          """Returns :data:`True` if the packet in verbose output contains=
 all specified flags."""
>          for packet in output:
> -            if packet.dst_mac =3D=3D "00:00:00:00:00:01":
> +            if packet.l4_dport =3D=3D 50000:
>                  if flags not in packet.hw_ptype and flags not in packet.=
sw_ptype:
>                      return False
>          return True
> @@ -82,8 +82,8 @@ def test_l2_packet_detect(self) -> None:
>              Check that each packet has a destination MAC address matchin=
g the set ID.
>              Check the packet type fields in verbose output, verify the f=
lags match.
>          """
> -        mac_id =3D "00:00:00:00:00:01"
> -        packet_list =3D [Ether(dst=3Dmac_id, type=3D0x88F7) / Raw(), Eth=
er(dst=3Dmac_id) / ARP() / Raw()]
> +        dport_id =3D 50000
> +        packet_list =3D [Ether(type=3D0x88F7) / UDP(dport=3Ddport_id) / =
Raw(), Ether() / ARP() / Raw()]
>          flag_list =3D [RtePTypes.L2_ETHER_TIMESYNC, RtePTypes.L2_ETHER_A=
RP]
>          with TestPmdShell() as testpmd:
>              self.setup_session(testpmd=3Dtestpmd, expected_flags=3Dflag_=
list, packet_list=3Dpacket_list)
> @@ -101,14 +101,14 @@ def test_l3_l4_packet_detect(self) -> None:
>              Check that each packet has a destination MAC address matchin=
g the set ID.
>              Check the packet type fields in verbose output, verify the f=
lags match.
>          """
> -        mac_id =3D "00:00:00:00:00:01"
> +        dport_id =3D 50000
>          packet_list =3D [
> -            Ether(dst=3Dmac_id) / IP() / Raw(),
> -            Ether(dst=3Dmac_id) / IP() / UDP() / Raw(),
> -            Ether(dst=3Dmac_id) / IP() / TCP() / Raw(),
> -            Ether(dst=3Dmac_id) / IP() / SCTP() / Raw(),
> -            Ether(dst=3Dmac_id) / IP() / ICMP() / Raw(),
> -            Ether(dst=3Dmac_id) / IP(frag=3D5) / TCP() / Raw(),
> +            Ether() / UDP(dport=3Ddport_id) / IP() / Raw(),
> +            Ether() / IP() / UDP(dport=3Ddport_id) / Raw(),
> +            Ether() / IP() / TCP(dport=3Ddport_id) / Raw(),
> +            Ether() / UDP(dport=3Ddport_id) / IP() / SCTP() / Raw(),
> +            Ether() / UDP(dport=3Ddport_id) / IP() / ICMP() / Raw(),
> +            Ether() / IP(frag=3D5) / TCP(dport=3Ddport_id) / Raw(),
>          ]
>          flag_list =3D [
>              RtePTypes.L3_IPV4 | RtePTypes.L2_ETHER,
> @@ -134,12 +134,12 @@ def test_ipv6_l4_packet_detect(self) -> None:
>              Check that each packet has a destination MAC address matchin=
g the set ID.
>              Check the packet type fields in verbose output, verify the f=
lags match.
>          """
> -        mac_id =3D "00:00:00:00:00:01"
> +        dport_id =3D 50000
>          packet_list =3D [
> -            Ether(dst=3Dmac_id) / IPv6() / Raw(),
> -            Ether(dst=3Dmac_id) / IPv6() / UDP() / Raw(),
> -            Ether(dst=3Dmac_id) / IPv6() / TCP() / Raw(),
> -            Ether(dst=3Dmac_id) / IPv6() / IPv6ExtHdrFragment() / Raw(),
> +            Ether() / UDP(dport=3Ddport_id) / IPv6() / Raw(),
> +            Ether() / IPv6() / UDP(dport=3Ddport_id) / Raw(),
> +            Ether() / IPv6() / TCP(dport=3Ddport_id) / Raw(),
> +            Ether() / UDP(dport=3Ddport_id) / IPv6() / IPv6ExtHdrFragmen=
t() / Raw(),
>          ]
>          flag_list =3D [
>              RtePTypes.L2_ETHER | RtePTypes.L3_IPV6,
> @@ -163,15 +163,15 @@ def test_l3_tunnel_packet_detect(self) -> None:
>              Check that each packet has a destination MAC address matchin=
g the set ID.
>              Check the packet type fields in verbose output, verify the f=
lags match.
>          """
> -        mac_id =3D "00:00:00:00:00:01"
> +        dport_id =3D 50000
>          packet_list =3D [
> -            Ether(dst=3Dmac_id) / IP() / IP(frag=3D5) / UDP() / Raw(),
> -            Ether(dst=3Dmac_id) / IP() / IP() / Raw(),
> -            Ether(dst=3Dmac_id) / IP() / IP() / UDP() / Raw(),
> -            Ether(dst=3Dmac_id) / IP() / IP() / TCP() / Raw(),
> -            Ether(dst=3Dmac_id) / IP() / IP() / SCTP() / Raw(),
> -            Ether(dst=3Dmac_id) / IP() / IP() / ICMP() / Raw(),
> -            Ether(dst=3Dmac_id) / IP() / IPv6() / IPv6ExtHdrFragment() /=
 Raw(),
> +            Ether() / IP() / IP(frag=3D5) / UDP(dport=3Ddport_id) / Raw(=
),
> +            Ether() / UDP(dport=3Ddport_id) / IP() / IP() / Raw(),
> +            Ether() / IP() / IP() / UDP(dport=3Ddport_id) / Raw(),
> +            Ether() / IP() / IP() / TCP(dport=3Ddport_id) / Raw(),
> +            Ether() / UDP(dport=3Ddport_id) / IP() / IP() / SCTP() / Raw=
(),
> +            Ether() / UDP(dport=3Ddport_id) / IP() / IP() / ICMP() / Raw=
(),
> +            Ether() / UDP(dport=3Ddport_id) / IP() / IPv6() / IPv6ExtHdr=
Fragment() / Raw(),
>          ]
>          flag_list =3D [
>              RtePTypes.TUNNEL_IP | RtePTypes.L3_IPV4_EXT_UNKNOWN | RtePTy=
pes.INNER_L4_FRAG,
> @@ -198,14 +198,14 @@ def test_gre_tunnel_packet_detect(self) -> None:
>              Check that each packet has a destination MAC address matchin=
g the set ID.
>              Check the packet type fields in verbose output, verify the f=
lags match.
>          """
> -        mac_id =3D "00:00:00:00:00:01"
> +        dport_id =3D 50000
>          packet_list =3D [
> -            Ether(dst=3Dmac_id) / IP() / GRE() / IP(frag=3D5) / Raw(),
> -            Ether(dst=3Dmac_id) / IP() / GRE() / IP() / Raw(),
> -            Ether(dst=3Dmac_id) / IP() / GRE() / IP() / UDP() / Raw(),
> -            Ether(dst=3Dmac_id) / IP() / GRE() / IP() / TCP() / Raw(),
> -            Ether(dst=3Dmac_id) / IP() / GRE() / IP() / SCTP() / Raw(),
> -            Ether(dst=3Dmac_id) / IP() / GRE() / IP() / ICMP() / Raw(),
> +            Ether() / UDP(dport=3Ddport_id) / IP() / GRE() / IP(frag=3D5=
) / Raw(),
> +            Ether() / UDP(dport=3Ddport_id) / IP() / GRE() / IP() / Raw(=
),
> +            Ether() / IP() / GRE() / IP() / UDP(dport=3Ddport_id) / Raw(=
),
> +            Ether() / IP() / GRE() / IP() / TCP(dport=3Ddport_id) / Raw(=
),
> +            Ether() / UDP(dport=3Ddport_id) / IP() / GRE() / IP() / SCTP=
() / Raw(),
> +            Ether() / UDP(dport=3Ddport_id) / IP() / GRE() / IP() / ICMP=
() / Raw(),
>          ]
>          flag_list =3D [
>              RtePTypes.TUNNEL_GRENAT | RtePTypes.INNER_L4_FRAG | RtePType=
s.INNER_L3_IPV4_EXT_UNKNOWN,
> @@ -231,15 +231,20 @@ def test_nsh_packet_detect(self) -> None:
>              Check that each packet has a destination MAC address matchin=
g the set ID.
>              Check the packet type fields in verbose output, verify the f=
lags match.
>          """
> -        mac_id =3D "00:00:00:00:00:01"
> +        dport_id =3D 50000
>          packet_list =3D [
> -            Ether(dst=3Dmac_id, type=3D0x894F) / NSH() / IP(),
> -            Ether(dst=3Dmac_id, type=3D0x894F) / NSH() / IP() / ICMP(),
> -            Ether(dst=3Dmac_id, type=3D0x894F) / NSH() / IP(frag=3D1, fl=
ags=3D"MF"),
> -            Ether(dst=3Dmac_id, type=3D0x894F) / NSH() / IP() / TCP(),
> -            Ether(dst=3Dmac_id, type=3D0x894F) / NSH() / IP() / UDP(),
> -            Ether(dst=3Dmac_id, type=3D0x894F) / NSH() / IP() / SCTP(tag=
=3D1) / SCTPChunkData(data=3D"x"),
> -            Ether(dst=3Dmac_id, type=3D0x894F) / NSH() / IPv6(),
> +            Ether(type=3D0x894F) / UDP(dport=3Ddport_id) / NSH() / IP(),
> +            Ether(type=3D0x894F) / UDP(dport=3Ddport_id) / NSH() / IP() =
/ ICMP(),
> +            Ether(type=3D0x894F) / UDP(dport=3Ddport_id) / NSH() / IP(fr=
ag=3D1, flags=3D"MF"),
> +            Ether(type=3D0x894F) / NSH() / IP() / TCP(dport=3Ddport_id),
> +            Ether(type=3D0x894F) / NSH() / IP() / UDP(dport=3Ddport_id),
> +            Ether(type=3D0x894F)
> +            / UDP(dport=3Ddport_id)
> +            / NSH()
> +            / IP()
> +            / SCTP(tag=3D1)
> +            / SCTPChunkData(data=3D"x"),
> +            Ether(type=3D0x894F) / UDP(dport=3Ddport_id) / NSH() / IPv6(=
),
>          ]
>          flag_list =3D [
>              RtePTypes.L2_ETHER_NSH | RtePTypes.L3_IPV4_EXT_UNKNOWN | Rte=
PTypes.L4_NONFRAG,
> @@ -267,24 +272,15 @@ def test_vxlan_tunnel_packet_detect(self) -> None:
>              Check that each packet has a destination MAC address matchin=
g the set ID.
>              Check the packet type fields in verbose output, verify the f=
lags match.
>          """
> -        mac_id =3D "00:00:00:00:00:01"
> +        dport_id =3D 50000
>          packet_list =3D [
> -            Ether(dst=3Dmac_id) / IP() / UDP() / VXLAN() / Ether() / IP(=
frag=3D5) / Raw(),
> -            Ether(dst=3Dmac_id) / IP() / UDP() / VXLAN() / Ether() / IP(=
) / Raw(),
> -            Ether(dst=3Dmac_id) / IP() / UDP() / VXLAN() / Ether() / IP(=
) / UDP() / Raw(),
> -            Ether(dst=3Dmac_id) / IP() / UDP() / VXLAN() / Ether() / IP(=
) / TCP() / Raw(),
> -            Ether(dst=3Dmac_id) / IP() / UDP() / VXLAN() / Ether() / IP(=
) / SCTP() / Raw(),
> -            Ether(dst=3Dmac_id) / IP() / UDP() / VXLAN() / Ether() / IP(=
) / ICMP() / Raw(),
> -            (
> -                Ether(dst=3Dmac_id)
> -                / IP()
> -                / UDP()
> -                / VXLAN()
> -                / Ether()
> -                / IPv6()
> -                / IPv6ExtHdrFragment()
> -                / Raw()
> -            ),
> +            Ether() / IP() / UDP(dport=3Ddport_id) / VXLAN() / Ether() /=
 IP(frag=3D5) / Raw(),
> +            Ether() / IP() / UDP(dport=3Ddport_id) / VXLAN() / Ether() /=
 IP() / Raw(),
> +            Ether() / IP() / UDP(dport=3Ddport_id) / VXLAN() / Ether() /=
 IP() / UDP() / Raw(),
> +            Ether() / IP() / UDP(dport=3Ddport_id) / VXLAN() / Ether() /=
 IP() / TCP() / Raw(),
> +            Ether() / IP() / UDP(dport=3Ddport_id) / VXLAN() / Ether() /=
 IP() / SCTP() / Raw(),
> +            Ether() / IP() / UDP(dport=3Ddport_id) / VXLAN() / Ether() /=
 IP() / ICMP() / Raw(),
> +            (Ether() / IP() / UDP() / VXLAN() / Ether() / IPv6() / IPv6E=
xtHdrFragment() / Raw()),
>          ]
>          flag_list =3D [
>              RtePTypes.TUNNEL_GRENAT | RtePTypes.INNER_L4_FRAG | RtePType=
s.INNER_L3_IPV4_EXT_UNKNOWN,
> --
> 2.48.1
>
