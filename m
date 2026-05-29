Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D13CD6E43
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 10:24:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93E0C4021E;
	Fri, 29 May 2026 12:24:06 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id EF1A8400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 12:24:04 +0200 (CEST)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfout.phl.internal (Postfix) with ESMTP id 5C968EC006C;
 Fri, 29 May 2026 06:24:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Fri, 29 May 2026 06:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1780050244;
 x=1780136644; bh=Kq84WmefwT4wEikD3EbQoa8M32bxXq7R35jcj/5lw6U=; b=
 cU3v10Db4jvh/UgSq91OTuHdLGKQOmP1DeQpEegfYqjM4zhj4YDRXLGhTmx3manB
 TTB99WABCdfY6Zf90WWbE3q+ZVgqF9dqXH+xbXK3ZX9aGLLQ7Syt/j4c6mcn8gBQ
 llLi+KxifBl6nhhwwsfOrW+bh1oUCwdFM5ZsZjNokmo8RvnnQ46nh03rrZGLYbOE
 eVn+paunMrmAjJm9glbp/HV4vZcOYlsrwbKqLOmXuhHjw156z5jr4K3uDvnCrSfg
 JumT5efH3T3+RadTZ/xu6OpQNWtE3qgAWPH+yEIlYrHuW2WtRL1DCe76ECzX+2M6
 7O89TfT1KmmO4aTgYdVnuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1780050244; x=
 1780136644; bh=Kq84WmefwT4wEikD3EbQoa8M32bxXq7R35jcj/5lw6U=; b=E
 ZPH65nsIvDqGkS08D5EaJTa3LG463qpgr780HYYaTbxmhhm9uozZ6PmdeTGjPWGb
 zMU6dXzoaNuhfme9QwS+Q1G/GZSMzhEd0+q8z+/Qbhl5AipaMRWj1Ji+uvIujvq2
 NEQjYJP/NKOvvs0QvTsMucnLhTPl3U0BTXGcpf/7jGpBRdroxj0ev92/b/qOTVdv
 IqeudNHBcC1seBAIxgZp4vfmm71keOEZHCy+uZI0wPwt5i/pwVOYkjrN38SlPT4W
 POeS47FF8rBhigHoj8VZCaHFJ0ozpMpmAsTgrCMHCob1A+WRSIjzPzU+N59iaBpm
 qPDDPpXBAmIY5YVRZpHoA==
X-ME-Sender: <xms:Q2kZatduDgyNOailYmdkAYleTuqbv5OGuw8gaWWdxwcw5gi4hZYbbw>
 <xme:Q2kZavhGhldxuTv_4oOe78x9rvhjCk4FxIeHUpwpyhsQLBMjItTNnw18FQ7sHbwk5
 wqTsgxHVLwzLZ6cx_ea6WuPv6uHiW1YfhUteWKvdpss9hvD4pXx7Qo>
X-ME-Received: <xmr:Q2kZalq6I0BusRzDCCUEDZk7SILgq14NzGbWRkbclSeMvq3_nL7JQEpvFjF6ppg0KufvuDrCMyog5lB-tqCePmYFGg>
X-ME-Proxy-Cause: dmFkZTE9jyqZrQfhSx/IZ1QH9f2VkyWWqwhzc3n+5Fu4xudMuKtHLw/gZY2JXPJw9NL6xp
 azlA+E8RIJ+OTEGS4T+k3bFfuO89uZNp6Vhz7Cez/nXBkvhbdYUX8SS3o2m0VGzoyX7Cnm
 GZeFVBMPUdzhkpIIsrTb5vcVqSMSaW7nLrQcptT7mK/SOnFgZfTlWg6QosBZI8Q1vKIWIn
 ShGGN+ZOQ/T5JmpNN/2zo5GFFZbU9fPWLUScHA5YnUiXxuY9RC9UqEwV3CasrGvjeshumb
 jxk7QPp3zynXzP6czyIIfGDglQ1tWzDnusEjhTAteTU7OBf5x/r2JO69ECfBK6ni584mTx
 CFwkKMZsJAkm8VxeqHjN0pCj7TCPDTNKBnDub5EXCOSdnBZGP37OYs9AINdnEyOwe1WZcZ
 gOTKhgdh2KNLXpTZFlJtilOk2gA6hXK99WP7Tk0zXDzDxvvLMk5XHYRbtuvXRLR0CiTILC
 OBOhnzylmLDDJ172DDTOACbIDSCHj6Zr/bbt3CcmmVT3Sd1Tij+oZL6LSOgtH7OIW6h4cH
 vKZJj8ghs7TCOXbwbrdlFEdo7x43cudvjL4/9Cf4rRjJhguUuaShLJn6ZpOxLOGmUuZ12B
 OLYEU6OlQyNpGgXQYYut7NWua+EM32awxVXYwYXbCTL77f7usS3fSbPpIk2g
X-ME-Proxy: <xmx:Q2kZavErbfESKppp8jvw4sQLLOxonBt2I4Kns82ykYl0JG5-ausatw>
 <xmx:Q2kZavlDoJWNV0UvwURQxthYQAdO9zOQ_McUukzO5h-Kkbfg2jIUYg>
 <xmx:Q2kZaqkqpTI29AEXbJVBk9g5lVrVkqxwdm4BO7eLXvudhl7fzrmDhA>
 <xmx:Q2kZaot71EDWgLU_bolMxTdAS6Ae_ysvztrZHjl8nxrJBd4amur6iQ>
 <xmx:RGkZanKt5d9OfrBs3S0nxkTHSYd4rYPN1NlfvJJR0qn8rZXWit3sqb5H>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 May 2026 06:24:02 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH] net/sxe2: fix 32-bit SSE build
Date: Fri, 29 May 2026 12:24:01 +0200
Message-ID: <LCxtFOVzRm6YSPuFAGwngA@monjalon.net>
In-Reply-To: <CAJFAV8xY0uM=RbcR64ZMc-eOTVkzZc0PFTCBCaQkNNE7uuvZeg@mail.gmail.com>
References: <20260528084717.1754057-1-thomas@monjalon.net>
 <CAJFAV8xY0uM=RbcR64ZMc-eOTVkzZc0PFTCBCaQkNNE7uuvZeg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

28/05/2026 11:47, David Marchand:
> On Thu, 28 May 2026 at 10:47, Thomas Monjalon <thomas@monjalon.net> wrote:
> >
> > Seen in OBS on i586 Debian:
> >
> > from ../drivers/net/sxe2/sxe2_txrx_vec_sse.c:5:
> >         In function =E2=80=98_mm_loadu_si128=E2=80=99,
> >                 inlined from =E2=80=98rte_memcpy=E2=80=99
> >                 inlined from =E2=80=98sxe2_rx_pkts_refactor=E2=80=99
> >                         at ../drivers/net/sxe2/sxe2_txrx_vec_common.h:2=
33:2:
> >         /usr/lib/gcc/i686-linux-gnu/12/include/emmintrin.h:703:10: erro=
r:
> >         array subscript 8 is outside array bounds of =E2=80=98struct rt=
e_mbuf *[32]=E2=80=99
> >
> > The important options to reproduce are "-m32 -O2 -march=3Dcorei7".
> >
> > In 32-bit build the pointer array done_pkts[32] is smaller:
> >         32 * 4 =3D 128 bytes
> > so an SSE access  would be outside the bound.
> >
> > The libc memcpy does not trigger such warning
> > and is a good choice to copy an array of pointers.
> >
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
>=20
> I reproduced and checked Debian 13 32 bits build with OBS.
> Tested-by: David Marchand <david.marchand@redhat.com>

=46ixes: ac60f302cbef ("net/sxe2: add vectorized Rx and Tx")

Applied


