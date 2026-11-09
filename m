Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80825606A330
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=rIogefZz
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47C4D4028F;
	Mon,  9 Nov 2026 18:57:57 +0100 (CET)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTPS id 1D5E840270
 for <dev@dpdk.org>; Mon,  9 Nov 2026 18:57:54 +0100 (CET)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-8b600fae14dso485820b3a.2
 for <dev@dpdk.org>; Mon, 09 Nov 2026 09:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794247072;
 x=1794851872; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JaeTivUjdfQFYV4jcerws/uFFFWpjJI0caXGxPdvAyY=;
 b=rIogefZzN59h8mioQ18dgduyThhDM9NKf0a7g5pOszfHSwJPf9LCTrtic8dlcm6Fn4
 5d+BFauZVXNw0i7xT3/WqxlGjSAj7jTJIxP3hinFAw5j7/emvBKtgFVt0pvoAfb7P5L7
 ZzK4vtoY9JCoLRJpE6CUl6/bXqpi15KBaG/RUkZZniSh4tptq1D6vlRrWELjA8YwfMsg
 79CJmxKYl1ai648xUJEuI2uB1EVLybBRHhb0ugoXxP4ON7e6dx0srOPWic9UcK2Qtu2H
 ZUVKrQQFo/gR3BoxnABg446Mkt/SDiJksLTCC0bZlem63Ip8RNubHkWBvRbSKyGW6Ypj
 axkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794247072; x=1794851872;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JaeTivUjdfQFYV4jcerws/uFFFWpjJI0caXGxPdvAyY=;
 b=aEGjwCvJIkcm91xcNGEwpQOvqRORQcYf/KTDs9KkjSaqo6FAdBnxHSPh3CZKO9am2n
 7gBXbBub6hEgdkzTz9STTavFyoEExW0O1qukMa7uBil3AS2zkcdV1zokJiGnZGJGqVoo
 i5qipkSiSf5wGJJ1XPNyLT4zaJcKRk4V0so/akHKH5D5tZlauGeUuMgw24Ie89ztB66V
 6MU/pzEGM7WJOKIwZLWXcaEr/3Ykbp7sp/FFyctBCGSgZICFT9bwlYCIQMDkUolMiuo4
 C6iO2BmXuJLrNHeR09MJXSdrUxQmmZVXYYNYuVrO+HN7Z5ZR/HDz62c40kKGkSbyG28X
 ZsTA==
X-Gm-Message-State: APuU4Z/8NoXMf1iiXGnby/x1Sry1eaKHjwNKdc4mnva06Ds94dxEmUsU
 5/XFmhecW7Y0FZ4g9VBP2m/O0Lt0wsub0VaNmqS+ekeG9y+8aHCGS3tndRBne+mdPYs=
X-Gm-Gg: AYBFou3dqyOkKhlOWzf8wm7EWjLpIl7N3rBFW9AO9Tx2bOfJyvHJo4hqaiB5WXzJDtf
 Im/csoHhR7vWISWL+Ukkt3IUrWoiKQMwnuBbH73zd2qYvdndL5cgqMU1zpJaIJHGfrYwH776UAu
 cPPKGeUmHSMRK/9El94jRzkPtFTrmdaayTc1bu2jPKPNpofHu01/xCU7CRXsDouNZEv2B/+X1RN
 lTudBbwTWeFivTWTyiSpy/9NeKXTIcI8Xhj+m/VjNp1ve1wgBWDlFMde89qrcDiXTc2vMqrRz0P
 Vhb//x7pqvvDKA0B4XGI7fwHV73vZ7XhIoll13SilxFnDajVQQCiNeKGSdBmCzaHuMnBWPC1VS5
 68AwZjIXtLk6x4NCO9UKcp/swV8HNA74/RaKhnQd0DSILvGtKT3wh0syAvEuEL2ZClwyTNZSBud
 svNCB10+/ihAEPKuXGEy7LHJPggleXBUFNVRt4yvMtLlnyupCNG3+zLdOenlIZLru0wlVRQVw/J
 Y5Mosj1FadDq2TBpI+s0KvCZiDnoXpBvkw2GCXufqEfEzWNTtycQBgggg5lYjIwf08VCTq79vex
 c5jw82oOMIWt1T5IgYRDi7hSP89k7UJbr/w1xZybDVC5tEJsGzxMlyMyohP0hObulzWHHGEkVvr
 23tvZVhrGyqYSy0WrqQ==
X-Received: by 2002:a05:6a21:47c8:b0:3e2:1418:aae8 with SMTP id
 adf61e73a8af0-3eed51bf3f5mr3954570637.72.1794247072416; 
 Mon, 09 Nov 2026 09:57:52 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdd8d7bf1a1sm33793a12.27.2026.11.09.09.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 09:57:52 -0800 (PST)
Date: Mon, 9 Nov 2026 09:57:50 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 0/3] net/gve: TSO descriptor count fixes for GVE DQO
Message-ID: <20261109095750.7b0465ac@phoenix.local>
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

Ready for next-net but AI review found some dead code.
Could you test that assumption and send new version.

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
