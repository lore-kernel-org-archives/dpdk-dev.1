Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D0CCCFA06
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 13:58:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54197402D7;
	Tue,  4 Nov 2025 14:58:56 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 81CDA40269
 for <dev@dpdk.org>; Tue,  4 Nov 2025 14:58:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762264734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sQe5clGjaa4ZOnM1SMjAc94HOUaA1KXjnq0O1rvDoPQ=;
 b=HHiyBcP9Zd6xMBUbe2Q43knzwBPF5/0i9SbXv/KRVNq6tjXp3B4F2VIQoMHXIWOb6onHyH
 zg3cv7noGNwdGSwz08aUo7VYb97k6ewAgEbYKxsV+axx/SqPFOeQGPW1HrwKATt0eSG5i7
 mNIJsp6Cd+YUo4AumbLkfiS/63O4kWk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-feIMkSafNemxHhRdNitfrg-1; Tue, 04 Nov 2025 08:58:53 -0500
X-MC-Unique: feIMkSafNemxHhRdNitfrg-1
X-Mimecast-MFC-AGG-ID: feIMkSafNemxHhRdNitfrg_1762264732
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-378d710cb33so19589801fa.3
 for <dev@dpdk.org>; Tue, 04 Nov 2025 05:58:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762264731; x=1762869531;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sQe5clGjaa4ZOnM1SMjAc94HOUaA1KXjnq0O1rvDoPQ=;
 b=d2n/WVjtrJ9CA/Dy3JXtxB1B8HPHNvUnZeYyorviNX77q2jJ8aE/QlHm7hUYVuq1O6
 0ETlghDqMa4Qgn/EDmYhTOBNZnwKVh0NQDqYked/96jSEaOWvFb+vamWbYQhsp97E3CB
 I+YWaZohUUjFDqVUjRQoFMIPdWI2MBI/XfnKMmgRlakNp53VKPtAqslezNLoSa/eMGzh
 sL56KOZ5DXIg2JmcgMpo8ZYi5iU//Bd+mzPzTwiBbiDZNBSx6vsUOGYvDlMF13gsAtPC
 8nC53oJfOf2WNXQz8VfDUL+FL9ksyfY4Hi1PjWv4L7iOssvB2BMBRn3/VlxVR1HD4sZg
 2x7Q==
X-Gm-Message-State: AOJu0YzqBcffQWaPhRo9fj1iLFRkhCfbmEaFszkedZpkxTnlyHpQmfLh
 PrVzaSh0iA2qKinGfaavuKrq9xLrXaamGhlMvRPzMtDeFJBhhakh6hZl8zk2CeetI7pAaMFbHFv
 QQJuMJsZKdeWrTW0LNE9WP4w2eY+127QibtlcIKRtlVKMHi0zpazg6YU+M7DtEQPOlK1W2UdxRT
 RvQUGIaXAtAAwiFXjSaTYoYEgaXd0lQQ==
X-Gm-Gg: ASbGncv5DY0LSAX3XNgg7sWPtyXlYfacNxi3cIYDz9snssk7Ydx26gHjUM6t+Jlo5Wd
 a1QhSq9RdvJcThTuY40+udbMP1+8L1NICBMarR/Z55xKMBNx843xss5YLRmyeL07Om1vz+F8QrH
 89Fl/P5PZUE9fDoiD3ftpd8A+KWTxm1qCzVdvgaiEz2m+suQraAjdcBkVDzg==
X-Received: by 2002:a05:651c:997:b0:37a:d2e:4c0c with SMTP id
 38308e7fff4ca-37a18de2c12mr39815781fa.47.1762264731254; 
 Tue, 04 Nov 2025 05:58:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+eVTE+KG0tcJoxMssIES8/0kdkhDVubrXmj5O6WpVqPWGlm0pNXYtJKqGH6VNK+/E2snoHLMCAcJlEhItSkA=
X-Received: by 2002:a05:651c:997:b0:37a:d2e:4c0c with SMTP id
 38308e7fff4ca-37a18de2c12mr39815721fa.47.1762264730757; Tue, 04 Nov 2025
 05:58:50 -0800 (PST)
MIME-Version: 1.0
References: <20251031131159.1199221-1-david.marchand@redhat.com>
 <20251104100214.1818660-1-david.marchand@redhat.com>
In-Reply-To: <20251104100214.1818660-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 4 Nov 2025 14:58:39 +0100
X-Gm-Features: AWmQ_blCl9kxQswapvUYcZhBhssMc-3js51K-puh8WxRNxQ0UrGchHDxXzlnd7w
Message-ID: <CAJFAV8zEM4Ohdk+wg1Ryz4n1VC2KC3nCkRBX7iRMakY3scfqEg@mail.gmail.com>
Subject: Re: [PATCH v2] mbuf: dump Tx offload metadata
To: dev@dpdk.org
Cc: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N7TeguEPg-f4512h1VIFfG63gIijf5pXffBF6N-bAC0_1762264732
X-Mimecast-Originator: redhat.com
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

On Tue, 4 Nov 2025 at 11:02, David Marchand <david.marchand@redhat.com> wro=
te:
>
> When debugging TSO and other checksum offloads, dumping the various
> l*_len fields and TSO segmentation size can be helpful.
>
> Example in OVS that dumps a mbuf on rte_eth_tx_prepare failure:
>
> Before:
> netdev_dpdk(pmd-c30/id:11)|DBG|dpdk0: First invalid packet:
> dump mbuf at 0x2201a916c0, iova=3D0x2200800580, buf_len=3D6864
>   pkt_len=3D6804, ol_flags=3D0x3114800000000102, nb_segs=3D1, port=3D6553=
5, ptype=3D0
>   segment at 0x2201a916c0, data=3D0x22008005b2, len=3D6804, off=3D50, ref=
cnt=3D1
>   Dump data at [0x22008005b2], len=3D6804
> ...
>
> After:
> netdev_dpdk(pmd-c30/id:11)|DBG|dpdk0: First invalid packet:
> dump mbuf at 0x2201a916c0, iova=3D0x2200800580, buf_len=3D6864, pkt_len=
=3D6804
>   outer_l2_len=3D14, outer_l3_len=3D40, l2_len=3D38, l3_len=3D40, l4_len=
=3D32
>   ol_flags=3D0x3114800000000102, nb_segs=3D1, port=3D65535, ptype=3D0
>   segment at 0x2201a916c0, data=3D0x22008005b2, len=3D6804, off=3D50, ref=
cnt=3D1
>   Dump data at [0x22008005b2], len=3D6804
> ...
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  lib/mbuf/rte_mbuf.c | 41 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 37 insertions(+), 4 deletions(-)
>
> diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
> index 0d931c7a15..12710a59df 100644
> --- a/lib/mbuf/rte_mbuf.c
> +++ b/lib/mbuf/rte_mbuf.c
> @@ -750,10 +750,43 @@ rte_pktmbuf_dump(FILE *f, const struct rte_mbuf *m,=
 unsigned dump_len)
>
>         __rte_mbuf_sanity_check(m, 1);
>
> -       fprintf(f, "dump mbuf at %p, iova=3D%#" PRIx64 ", buf_len=3D%u\n"=
, m, rte_mbuf_iova_get(m),
> -               m->buf_len);
> -       fprintf(f, "  pkt_len=3D%u, ol_flags=3D%#"PRIx64", nb_segs=3D%u, =
port=3D%u",
> -               m->pkt_len, m->ol_flags, m->nb_segs, m->port);
> +       fprintf(f, "dump mbuf at %p, iova=3D%#" PRIx64 ", buf_len=3D%u, p=
kt_len=3D%u\n",
> +               m, rte_mbuf_iova_get(m), m->buf_len, m->pkt_len);
> +       if (m->ol_flags & RTE_MBUF_F_TX_OFFLOAD_MASK) {
> +               const char *sep =3D "";
> +
> +               fprintf(f, "  ");
> +               if (m->outer_l2_len !=3D 0) {
> +                       fprintf(f, "%souter_l2_len=3D%u", sep, m->outer_l=
2_len);

One more round will be needed for MSVC (CI did not report it on v1,
some tests did not run..).
../lib/mbuf/rte_mbuf.c(760): error C2220: the following warning is
treated as an error
../lib/mbuf/rte_mbuf.c(760): warning C4477: 'fprintf' : format string
'%u' requires an argument of type 'unsigned int', but variadic
argument 2 has type 'const uint64_t'
../lib/mbuf/rte_mbuf.c(760): note: consider using '%llu' in the format stri=
ng
../lib/mbuf/rte_mbuf.c(760): note: consider using '%Iu' in the format strin=
g
../lib/mbuf/rte_mbuf.c(760): note: consider using '%I64u' in the format str=
ing

This is probably because of the bitfields we have for the tx_offload field.
lib/mbuf/rte_mbuf_core.h:       RTE_MBUF_L2_LEN_BITS =3D 7,
lib/mbuf/rte_mbuf_core.h:       RTE_MBUF_L3_LEN_BITS =3D 9,
lib/mbuf/rte_mbuf_core.h:       RTE_MBUF_L4_LEN_BITS =3D 8,
lib/mbuf/rte_mbuf_core.h:       RTE_MBUF_OUTL3_LEN_BITS =3D 9,
lib/mbuf/rte_mbuf_core.h:       RTE_MBUF_OUTL2_LEN_BITS =3D 7,
lib/mbuf/rte_mbuf_core.h:                       uint64_t
l2_len:RTE_MBUF_L2_LEN_BITS;
lib/mbuf/rte_mbuf_core.h:                       uint64_t
l3_len:RTE_MBUF_L3_LEN_BITS;
lib/mbuf/rte_mbuf_core.h:                       uint64_t
l4_len:RTE_MBUF_L4_LEN_BITS;
lib/mbuf/rte_mbuf_core.h:                       uint64_t
outer_l3_len:RTE_MBUF_OUTL3_LEN_BITS;
lib/mbuf/rte_mbuf_core.h:                       uint64_t
outer_l2_len:RTE_MBUF_OUTL2_LEN_BITS;


Passing %PRIu64 instead of %u breaks build with gcc and clang.
../lib/mbuf/rte_mbuf.c: In function =E2=80=98rte_pktmbuf_dump=E2=80=99:
../lib/mbuf/rte_mbuf.c:760:36: error: format =E2=80=98%lu=E2=80=99 expects =
argument of
type =E2=80=98long unsigned int=E2=80=99, but argument 4 has type =E2=80=98=
int=E2=80=99
[-Werror=3Dformat=3D]
760 | fprintf(f, "%souter_l2_len=3D%"PRIu64, sep, m->outer_l2_len);
| ^~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~
| |
| int


I'll go with simple casting, like:
+            fprintf(f, "%souter_l2_len=3D%u", sep, (unsigned
int)m->outer_l2_len);


--=20
David Marchand

