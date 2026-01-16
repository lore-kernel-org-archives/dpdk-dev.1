Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC86AD4A601
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 05:55:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5623427D7;
	Fri, 16 Jan 2026 06:55:25 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 9E5C9427D3
 for <dev@dpdk.org>; Fri, 16 Jan 2026 06:55:24 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so19320765e9.0
 for <dev@dpdk.org>; Thu, 15 Jan 2026 21:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768542924;
 x=1769147724; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AzsQcJK+Kyr8wHxhP6YiEHjMytB9VOVxm9U7f2R9k04=;
 b=umMLgeigs/eOmZIm37gZp5i4GAVDSAesEKO2x9AkVKKN28IJ+TDF9rbt8Q3BEgwMBV
 +sm+DpzXMl5Py+vOIA5riOfCsK7w0Nu4CpPfrzDaiy+s4xvKnjo4Hb8SBKk7k3QbOK91
 vnvb/vhxEnhP2ntoTMSW1IX7ASSFgXGx4LBYlGMbR60QtnolQJJE7W7Pt0wdH84A5OjN
 YmyDdKHNRNnIN7Leyl/VkG5e4fgbzJ1lD8vWuSbt9aADnjc8OGQOEyrbVCwXvDQlqPPC
 yQCdatgiJyLjcNxR0OsT59GAKNYYpcph3uYB2pbEnCl0QPKPAcAIZ/GCJN3K6R+oJcCw
 DRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768542924; x=1769147724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AzsQcJK+Kyr8wHxhP6YiEHjMytB9VOVxm9U7f2R9k04=;
 b=pkKdFrBTuHyGcrY3SV6+OjdZifJyFO7HmWbFOCtiV9XaU7pOwUod8cB52J6pjOX1hK
 WjepTFPlCfW5z0JP9WytTMYmUpjS8D2FubPo4+PQxCHOEsgYGW6nqP58DoOuaPazpkKk
 h6IGkaLAmRiK3gWKysNNuiKi+q6lNYUgkNjNjtJFO3lLES+vF3kjQnWdFR/eMBETQoJ/
 SoC3SYngoPeY9c+bf7ry6VZjdHRUU1wkSHKoo2zi3sisFos7LYnczH8PvOVNKwTlfZWX
 ArB1p0thMYrM75hCfGbnV32js65W/dqXZCwogxxlgwDxgzuDApeJK5GrbAUGJbryhTwj
 ofdg==
X-Gm-Message-State: AOJu0YwudfLrxUi8JIawz3jdlPDj75NDZVVWBxSgcs/iJy49Lc7p53DO
 wLX0nhin33bCS2GIPTddm93KWmOKsSpGY+cZzf+pg6oaUATi1lqLdc7OysSbl5ofk50=
X-Gm-Gg: AY/fxX7DPmZY6pDOM+8/xxLiZWemf6OAdEzFfSRg4PIvbdkC3nsis/5VeZeCPZRz/MB
 +g/3Xww4IDTllAD3x2/oedJIvdJcqNxEKdqqmYDsR/8HBOYO6kwGCWfgl1w6P+lHSFBFbMPRBKs
 6WT6gmVNkxJcdPeimr1IWLgl4c00BNotPAgYqTFMNfKpG1mcihOubzpLwEWj6MjkkJjQ1w2UsBV
 k0MUSDB6pjJ8pVGfGcK2exrCAjvGNl9T52RFWxcZqnAK56jgtQKqfXr28pjivj4UK/mnu9LyAMA
 e3i3BmyEFka2RbhRMFh58NQzgayrHZyZt19eue5g6psraSGYDl4771OP/RkpcsTb8WJbVeMzuZ5
 Ancuqe31G7nx/4N8q0Suyf6x2/F+QJA7kd5AVedjIKeCDxndHFkUXiNrkVrMBt3VYxPuBwpBGti
 UA4dAqfJWy8Ww+1NMCPWwf4rE/ocOPOZDAOgYZ1kLzwz//yoRJYCLR
X-Received: by 2002:a05:600c:4f8a:b0:480:1d32:afc6 with SMTP id
 5b1f17b1804b1-4801e2f8e54mr21757505e9.4.1768542923630; 
 Thu, 15 Jan 2026 21:55:23 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4b26764fsm81203075e9.12.2026.01.15.21.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 21:55:23 -0800 (PST)
Date: Thu, 15 Jan 2026 21:55:16 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] mbuf: fix packet copy
Message-ID: <20260115215516.68a1c942@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65664@smartserver.smartshare.dk>
References: <98CBD80474FA8B44BF855DF32C47DC35F65664@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Thu, 15 Jan 2026 11:53:19 +0100
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> Stephen,
>=20
> As the author of rte_pktmbuf_copy(), can you please review this patch?
>=20
> You might find my answers to Konstantin's review informative:
> https://patchwork.dpdk.org/project/dpdk/patch/20251119120403.907511-1-mb@=
smartsharesystems.com/#181914
>=20
>=20
> Venlig hilsen / Kind regards,
> -Morten Br=C3=B8rup
>=20
>=20
> From: Morten Br=C3=B8rup [mailto:mb@smartsharesystems.com]=20
> Sent: Wednesday, 19 November 2025 13.04
>=20
> Requests for copying the at the end of a packet incorrectly returned NULL,
> as if copying past the end of a packet.
>=20
> When allocating copies from a mempool using pinned external buffers, the
> external flag was not preserved in these mbufs.
>=20
> Fixes: c3a90c381daa ("mbuf: add a copy routine")
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> ---
>  lib/mbuf/rte_mbuf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
> index 0d931c7a15..e639aff03e 100644
> --- a/lib/mbuf/rte_mbuf.c
> +++ b/lib/mbuf/rte_mbuf.c
> @@ -675,7 +675,7 @@ rte_pktmbuf_copy(const struct rte_mbuf *m, struct rte=
_mempool *mp,
>  	__rte_mbuf_sanity_check(m, 1);
> =20
>  	/* check for request to copy at offset past end of mbuf */
> -	if (unlikely(off >=3D m->pkt_len))
> +	if (unlikely(off > m->pkt_len))
>  		return NULL;

It makes more sense to return NULL (as error) rather than creating a 0
length mbuf in this corner case.

>  	mc =3D rte_pktmbuf_alloc(mp);
> @@ -688,8 +688,8 @@ rte_pktmbuf_copy(const struct rte_mbuf *m, struct rte=
_mempool *mp,
> =20
>  	__rte_pktmbuf_copy_hdr(mc, m);
> =20
> -	/* copied mbuf is not indirect or external */
> -	mc->ol_flags =3D m->ol_flags & ~(RTE_MBUF_F_INDIRECT|RTE_MBUF_F_EXTERNA=
L);
> +	/* copy flags except indirect and external, and preserve flags of newly=
 allocated mbuf */
> +	mc->ol_flags |=3D m->ol_flags & ~(RTE_MBUF_F_INDIRECT|RTE_MBUF_F_EXTERN=
AL);

Should have space in expression.
At that point it is a new mbuf (the copy) so offload flags should be clear,=
 not sure
what the issue is here.
But hadn't expected usage of this function with an external mbuf pool.


> =20
>  	prev =3D &mc->next;
>  	m_last =3D mc;

