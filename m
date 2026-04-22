Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42539F9B60D
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Apr 2026 10:36:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24D524064E;
	Wed, 22 Apr 2026 12:36:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4B367402E0
 for <dev@dpdk.org>; Wed, 22 Apr 2026 12:36:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776854162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WeOdnyzbx1cBOnpLI66fDHWlDGnVDy4yGciXQ9WfPnw=;
 b=U9CavwRNhtRqNU7LYKPmLkmSwOZdJFNy6TnJSc1Plw95HIloaz+o6yJQZSL3kZZOPW9KGt
 ssOqF18YdOeQ5yQQN5XgiPsbKgmc+GdC7+UZRjnZ18CuxElifZdejjJRbo9DTT4rZI48+6
 bzp6CCHPmp73DzNCmFcHLMMmbGdrvig=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-DXsUdIbuO2-cocgylO1MLA-1; Wed, 22 Apr 2026 06:36:01 -0400
X-MC-Unique: DXsUdIbuO2-cocgylO1MLA-1
X-Mimecast-MFC-AGG-ID: DXsUdIbuO2-cocgylO1MLA_1776854160
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43ea7a5da42so3245667f8f.1
 for <dev@dpdk.org>; Wed, 22 Apr 2026 03:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776854160; x=1777458960;
 h=in-reply-to:references:user-agent:to:from:cc:subject:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t2MWUwK18Vd/s0S6gFsKLUpwbkSOIgJz6IOOtNAmVf4=;
 b=XuWzfo/McvUZrZDzhJL1ijCLF7vHA5DYAMiznX/5qQh7sjDql1uE21SiUY9uMGk+Qt
 AWbvSAHKJd4VWmSnH57s3foe257wh5G/f6RH/efZScbMxWOHbPmhuqeNmb8oeYOi2srJ
 aRHlozoVvVmaWYLoeajHfutbNjrapJUz/DORUypllOpf/3ZvxoXyAvUeXKISnnsJmPbD
 dJez2v76RWb/vNhomfxZLrpHgptCbHF7ntK6qL6dfT69ksZcHY27qDu9j63lU+pQp9Xv
 dH7XaziB2nW734N7md+ho1Gt73/5oGL7iC1GPjiNglTBY85dpTBRJjGQhaGq21qo2857
 rQ0Q==
X-Gm-Message-State: AOJu0YxpfcTpNRpMYY3Qp3c10xX7LgtM9A4qoDIyQaDf8rMKKTYbaM1i
 FAcsL1KteX3/a2oDu22VJf7T8xNxjW+IzBSm9Eb++AFsnY62OwLBgXVin+ffsgXrL4AZkZZKQE7
 eN5P1GvHh7oznz7YWA1M+5srcn48IheZ5E6RCh+I/DytqyuHT3BXRdD0UegGGljaBF4f95xOoYk
 2iUAVEiRDdkLrxPc3zLMXDbHuk4A==
X-Gm-Gg: AeBDietd4pskgNZ41IXlyH7CqxEzC/7xyPsJbED/Y7tyc7FPh5MeRM3k3SgW9krqdjV
 RznTYo46u55c3U7XmeoIivJsX0+audHVGLRtXn8vytT2tcPNHpxTKwXPvG5f9RBhvjtRma4MRi4
 aJj6TXXBwx74YsmMnDA2LstX7yi+h/l8KGf9iTFT2KucYPew850K5U6RTAQkwpZgJBcYTeaqQlA
 UlxQtrF8oiSUgJO7hBE11SiHkVpoCCxqdG5wb8gcYcVWbrcGR0DUsGRK8F5RklpbCqcTS0nKcRD
 VDTB7IN8AYXz9MpUm2rRVuVoIPHs2Z5XZTJfewXJdKCQstSy0ejIWBJgKsFuLuHz8+gcK5GO5Dd
 m7fJO6u+0NwKIVH+ACEBXq5jIKJ55KDgZq1luIbNmo+HiKM65I88RrgWbxyJPG0XLClt+inp4YH
 Ba1kxKnJ+/fDXCl/o=
X-Received: by 2002:a05:600c:a103:b0:48a:58e1:6d17 with SMTP id
 5b1f17b1804b1-48a58e16ee0mr47911745e9.20.1776854159967; 
 Wed, 22 Apr 2026 03:35:59 -0700 (PDT)
X-Received: by 2002:a05:600c:a103:b0:48a:58e1:6d17 with SMTP id
 5b1f17b1804b1-48a58e16ee0mr47911315e9.20.1776854159505; 
 Wed, 22 Apr 2026 03:35:59 -0700 (PDT)
Received: from localhost (2a01cb00021ec0002fb5ec50e5a775d4.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2fb5:ec50:e5a7:75d4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc177dafsm540605635e9.4.2026.04.22.03.35.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 03:35:59 -0700 (PDT)
Mime-Version: 1.0
Date: Wed, 22 Apr 2026 12:35:58 +0200
Message-Id: <DHZM8BMMI03W.1FC611PP4C7HC@redhat.com>
Subject: Re: [PATCH dpdk] net: fix L2 ptype assignment in VLAN loop
Cc: <stable@dpdk.org>
From: "Robin Jarry" <rjarry@redhat.com>
To: <dev@dpdk.org>, "Gregory Etelson" <getelson@nvidia.com>
User-Agent: aerc/0.21.0-142-gcff39137b013-dirty
References: <20260422102814.645299-2-rjarry@redhat.com>
In-Reply-To: <20260422102814.645299-2-rjarry@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -If5aC_eX7Ax0HbMft14bICwcMKHBoTfcz5uFrfwZVs_1776854160
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

Robin Jarry, Apr 22, 2026 at 12:28:
> Since commit 1f250674085a ("net: fix packet type for stacked VLAN"),
> rte_net_get_ptype() uses |=3D to set the L2 ptype inside the VLAN
> parsing loop. Since pkt_type is already initialized with
> RTE_PTYPE_L2_ETHER (0x1), or-ing it with RTE_PTYPE_L2_ETHER_VLAN
> (0x6) results in RTE_PTYPE_L2_ETHER_QINQ (0x7). This causes single
> VLAN frames to be misidentified as QinQ.
>
> This was detected while testing DPDK 25.11.1 in grout. The net/tap
> driver calls rte_net_get_ptype() in tap_verify_csum() to determine
> the L2 header length. With the wrong ptype, l2_len is set to 22
> (ether + QinQ =3D 14 + 8) instead of 18 (ether + VLAN =3D 14 + 4),
> shifting the IP header pointer by 4 bytes. The checksum is then
> computed on garbage data, causing valid packets to be dropped.
>
> Use a simple assignment to replace the L2 ptype instead. Add VLAN
> and QinQ test packets in cksum_autotest to prevent regressions.
>
> Fixes: 1f250674085a ("net: fix packet type for stacked VLAN")
> Cc: stable@dpdk.org
>
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---
>  app/test/test_cksum.c | 29 +++++++++++++++++++++++++++++
>  lib/net/rte_net.c     |  2 +-
>  2 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/app/test/test_cksum.c b/app/test/test_cksum.c
> index ea443382a128..3cc42eccedd9 100644
> --- a/app/test/test_cksum.c
> +++ b/app/test/test_cksum.c
> @@ -75,6 +75,27 @@ static const char test_cksum_ipv6_udp[] =3D {
>  =090x00, 0x35, 0x00, 0x09, 0x87, 0x70, 0x78,
>  };
> =20
> +/* generated in scapy with Ether()/Dot1Q(vlan=3D42)/IP()/UDP()/Raw('x') =
*/
> +static const char test_cksum_vlan_ipv4_udp[] =3D {
> +=090xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
> +=090x00, 0x00, 0x00, 0x00, 0x81, 0x00, 0x00, 0x2a,
> +=090x08, 0x00, 0x45, 0x00, 0x00, 0x1d, 0x00, 0x01,
> +=090x00, 0x00, 0x40, 0x11, 0x7c, 0xcd, 0x7f, 0x00,
> +=090x00, 0x01, 0x7f, 0x00, 0x00, 0x01, 0x00, 0x35,
> +=090x00, 0x35, 0x00, 0x09, 0x89, 0x6f, 0x78,
> +};
> +
> +/* generated in scapy with Ether()/Dot1AD(vlan=3D42)/Dot1Q(vlan=3D43)/IP=
()/UDP()/Raw('x') */
> +static const char test_cksum_qinq_ipv4_udp[] =3D {
> +=090xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
> +=090x00, 0x00, 0x00, 0x00, 0x88, 0xa8, 0x00, 0x2a,
> +=090x81, 0x00, 0x00, 0x2b, 0x08, 0x00, 0x45, 0x00,
> +=090x00, 0x1d, 0x00, 0x01, 0x00, 0x00, 0x40, 0x11,
> +=090x7c, 0xcd, 0x7f, 0x00, 0x00, 0x01, 0x7f, 0x00,
> +=090x00, 0x01, 0x00, 0x35, 0x00, 0x35, 0x00, 0x09,
> +=090x89, 0x6f, 0x78,
> +};
> +
>  /* generated in scapy with Ether()/IP(options=3D'\x00')/UDP()/Raw('x')) =
*/
>  static const char test_cksum_ipv4_opts_udp[] =3D {
>  =090xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
> @@ -252,6 +273,14 @@ test_cksum(void)
>  =09=09=09  sizeof(test_cksum_ipv6_udp)) < 0)
>  =09=09GOTO_FAIL("checksum error on ipv6_udp");
> =20
> +=09if (test_l4_cksum(pktmbuf_pool, test_cksum_vlan_ipv4_udp,
> +=09=09=09  sizeof(test_cksum_vlan_ipv4_udp)) < 0)
> +=09=09GOTO_FAIL("checksum error on vlan_ipv4_udp");
> +
> +=09if (test_l4_cksum(pktmbuf_pool, test_cksum_qinq_ipv4_udp,
> +=09=09=09  sizeof(test_cksum_qinq_ipv4_udp)) < 0)
> +=09=09GOTO_FAIL("checksum error on qinq_ipv4_udp");

The tests are useless, they don't check that the L2 ptype is correct.
I'll send a v2 with proper ptype tests.

