Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCF4606A33E
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BkFoH3lc
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43A0D4026E;
	Wed,  4 Nov 2026 10:34:31 +0100 (CET)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by mails.dpdk.org (Postfix) with ESMTPS id 98B0B40151
 for <dev@dpdk.org>; Wed,  4 Nov 2026 10:34:29 +0100 (CET)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c4cac7a7d3cso62326866b.3
 for <dev@dpdk.org>; Wed, 04 Nov 2026 01:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793784869;
 x=1794389669; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eCVATw2zVzGbz0vSs2YnV8MkPwFi7NaMf1W3t34ZsQU=;
 b=BkFoH3lcxNVGNpzdK+Q6REuHEBFf2joz+giSbnHGGP0LxqyrYX3v7+qgkbwDWpfoPf
 PTGQzow7x4/8rejL9YV1uCTulVm8KUPOinwe0trtHEOTSjUlEejohHSfWOSwOobLbrY4
 b7VujLD9i1TmXpYTzqJs9wXDWghW+GuRb0EG6SFGSkoX8dyxO4dVoxtwoBiKxSgStPeD
 VSpKFe9fOPDa3hltbqkVXbQX7SjXWE9b6K36i1Az4DWUg53UpcucdFmQebiRIV8u203B
 dSxFUh+MUOdUHYBQOnwvto9uIh6thh9ueELWT/P3Lb2I0roHqGBaW2iX8cbHdPVzRSrK
 UCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793784869; x=1794389669;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eCVATw2zVzGbz0vSs2YnV8MkPwFi7NaMf1W3t34ZsQU=;
 b=CBGHy5BJOygL16VnTvaolvqgBFk/pHz9dilBtebgIKZKbj4scJh6HVNqm6umP2U0HN
 bvBMVVDywexIzbC6/ij9G80cB9RnaVc6IQKjITZgAGELRT4MOPgNoMETiRuI7zoArQEQ
 dReROhosLGagZ56yZRsS/4suI3xVZrjnBrXw3ZIE6OBdiBAKm5upVM5MVu4DlBHOv3GX
 FjlSyEIsGc8hSWD6FbIKAeUDCeWfP2Nc9PNM7q/thP87cjmcr0lfTkkbfI26Awrcy3EI
 exkzJBKrrNHbAyfSOzERD3x0nvVOrrJIK/J0pQk1vVpVY5A0l/MtsI7hx9QtzSnHxlVw
 LIRA==
X-Gm-Message-State: APuU4Z//56m2DcKpjanC2m7cZFAfIAFeAKzInWHqV5vE2KtROOTHQlu0
 FnpxoRRLd7PI+a110T896dXxUSnLqUiyuupR26+mRkelpkF/kXOkcarRQAEh/JGMK34=
X-Gm-Gg: AYBFou2iPVlTqiIDRntqW8g+5GRTOFdvMjqqo6P4FD/t+bIqNqTQu4K/FNPt/9rvFPg
 VFJcUGK6U1287GVhS5khma/IiufydvIu+V5MdAYMdKn6mRBWukH1RdgVlUiigt2PhwKCYPdcyO3
 SxiC6OCV6fnF60scCB1zNpquoXwwtVIoSx+BxrARuNP1uD/pAQ1aAjW8docQMIurBq/fBOSeQBw
 4K7fAwRQRMUoqYU7kBUso8ai0Ni1o6ontiv4KAC3XuzZio+PEDN08B1FNnM5HHuJh6nyuPummnS
 Hh+NkbU4vOXJOl4JFaOTYvegv+n5/mplqTQlP4lkgtYQwYLwpc1M5Y+R2LxJipGCC1XNS15HTKR
 S94kkQU007be5MPiNfsQ1LdZDKmdTjJ8ddrwo4m2i/D0FLRtaqMDHo+6+NHdD8R95TqXe+IwaWJ
 6g/SDIqR9jYlS69G9pu6kUONw6FvDccQjX2F2GZYskZdm5sagvc0lplocH7ZVNTv7hNry72a1+P
 V9fb0/r3q+ngizXeWc4XZluyAqUD4CNVaznCUm8d78Tt0FG9EC/EiCvUyXUJPHWlmR4+puDf1ua
 UGujpduxHv84W9gsKaTiWd6qDTFZN9Swd33CeR9OK207xUcZJ7+jos9EzkjGohuZxB70OeVTNrf
 Im3bJHl1wUzIARxQ=
X-Received: by 2002:a17:907:7250:b0:c42:aec7:c805 with SMTP id
 a640c23a62f3a-c4ca792ee06mr1355194166b.3.1793784868757; 
 Wed, 04 Nov 2026 01:34:28 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be.
 [194.78.224.93]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e4a7677sm49267466b.86.2026.11.04.01.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 01:34:28 -0800 (PST)
Date: Wed, 4 Nov 2026 10:34:25 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 0/3] net/gve: TSO descriptor count fixes for GVE DQO
Message-ID: <20261104103425.35ba4ce2@stephen-xps.local>
In-Reply-To: <20261103181442.381856-1-joshwash@google.com>
References: <20261030184304.508282-1-joshwash@google.com>
 <20261103181442.381856-1-joshwash@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue,  3 Nov 2026 10:14:39 -0800
Joshua Washington <joshwash@google.com> wrote:

> https://inbox.dpdk.org/dev/20250707231812.1937260-7-joshwash@google.com/
> introduced descriptor limit checks for TSO packets in DPDK.
> Unfortunately, a couple of bugs have been found in the implementation.
> 
> This patch series introduces fixes for those bugs and adds support for
> the tx_pkt_prepare callback to reject potentially invalid packets before
> they are dropped in the transmission path. Before a recently introduced
> patch, the GVE behavior was to stop transmitting at the first invalid
> packet, which would allow the application to do any necessary
> linearization or packet modification before attempting to transmit
> again. It turns out that that behavior is considered incorrect, so offer
> tx_pkt_prepare as an alternative.
> 
> Changes in v3:
> - Remove extraneous Fixes tags.
> - Drop patch 2 allowing multi-segment HEADERS, since that conflicts with
>   tx_pkt_prepare.
> 
> Changes in v2:
> - Rely on tx_pkt->nb_segs for descriptor limit calculation only as a
>   precursor, falling back to the traditional gve_tx_pkt_nb_data_descs()
>   if that optimization fails.
> - Only call rte_net_intel_cksum_preapre on TSO packets that request
>   checksum offloading. This enforces the additional requirement that
>   headers are all in the same mbuf segment.
> - Introduce new patch to validate minimum header length
> 
> Joshua Washington (3):
>   net/gve: fix TSO segment offset calculation
>   net/gve: introduce Tx packet preparation for DQO format
>   net/gve: validate minimum header length for TSO packets
> 
>  drivers/net/gve/base/gve_desc_dqo.h |  1 +
>  drivers/net/gve/gve_ethdev.h        |  3 +
>  drivers/net/gve/gve_tx_dqo.c        | 86 +++++++++++++++++++++++++++--
>  3 files changed, 85 insertions(+), 5 deletions(-)

Looks good will pick it up next week.
AI found some dead code.

Review: [PATCH v3 0/3] net/gve: DQO TSO validation fixes

Applied to next-net (339c992f25) with no conflicts. Each commit
builds with -Dwerror=true.

v3 drops the multi-mbuf header patch and keeps the data_len >=
headlen check. That resolves both v2 warnings.


Patch 2/3: net/gve: introduce Tx packet preparation for DQO format

Info: the csum test is dead code. GVE_TX_CKSUM_OFFLOAD_MASK_DQO
includes RTE_MBUF_F_TX_TCP_SEG through GVE_TX_CKSUM_OFFLOAD_MASK,
so "csum && tso" is just "tso". Simplify to:

	if (tso) {
		err = rte_net_intel_cksum_prepare(tx_pkt);
		if (err != 0) {
			rte_errno = -err;
			return i;
		}
	}

The commit message should then say that the pseudo-header is seeded
for all TSO packets, not "for packets with checksum offloading
enabled".


Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>

