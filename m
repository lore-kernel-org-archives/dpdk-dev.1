Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42440606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 18:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=AmMmdAcm
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2233402C9;
	Tue, 17 Nov 2026 19:56:28 +0100 (CET)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTPS id E3894402A4
 for <dev@dpdk.org>; Tue, 17 Nov 2026 19:56:26 +0100 (CET)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-8b9c51097e2so63378b3a.1
 for <dev@dpdk.org>; Tue, 17 Nov 2026 10:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794941785;
 x=1795546585; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9iOOwYpK71M6K4HibrY1ZbEyCxIMaPcUWOSTphCC8tY=;
 b=AmMmdAcmXYvDujz03Gj8hFiKhVnWAYzr6YLiFhJQikZJw7tI3fjS/o6Gf88po2xHLx
 7u+2emNLF5YgWKmR0QCU/TRe4m3R2DO1HyjTZgzfUTRfb9+LpBsqWYsCfs0z+nUO+u9H
 bwKIAtwTVJfbaKQsXXarGjRUV9Aarqw8Nl/jY+h7rnc7upb7g+xXeJEBfUakpV6bHv+O
 K4aXi/xpq5qDa1sT7ikgEa0p5ETpiGxf4HD1433ULD8NdziQefEOKuJU1ZjwxJw+qusQ
 01nR7PXVjZ3HIRfWPC0LHpXWSnzlLLgdIOghwwuSbl05XTdZhs2n4pSq4losIXYNOgQj
 IesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794941785; x=1795546585;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9iOOwYpK71M6K4HibrY1ZbEyCxIMaPcUWOSTphCC8tY=;
 b=biAQ4cBoveEmpauzIH0NPG5VWTBERYdtld7k1fECbX1zZ+z6mVfyAZDQM67J4s3bpD
 zaYBkwa1P3A5lCcpgo2lnsy4/EHMW/mdJS8Df0IXiSz3yHNVJ16NgiRnTWTifm2bek2M
 FizaXXl/2+xbTiqsjcbgNzjfbl1B9vDB9TZYKPcNQnrF14Mke/vS53/F9iIg3Wi3lyhM
 W507VeZHXp0Wi+L6OIFuKQtSUbouSSUyGl5wg65qgZyfx1lmX0kMuDTZX2fOrYt3iOrU
 jVUeacx20Dvy3LY28VabIy8xVK56uUDkUoffV5wtxyFewR7LyUBLqP6w3hpmWkt/p1tL
 PdFw==
X-Forwarded-Encrypted: i=1;
 AL+hErG04pl6cPutwpRY2l68JaysOQ1XKwqxbW5TJ9jYZbrSnjOYF47GsykTomlm/67yvnNbxXk=@dpdk.org
X-Gm-Message-State: APuU4Z803+kCdiJohdsE9rzv4mcRBpYSIYlO1GbwOtrNNskiM+y7P6Us
 jOz3Lm4IHeMsvu59XdsoDWGKJRCjyJvke2Szap606KkMoBTclDP2ejitRF25h5PPpOI=
X-Gm-Gg: AYBFou178OaPNEsAJAXSDYXZGr+eG4TpY6Ezhi5gS0tHk8QDJG+1EXLK/+Z+KgxJr8k
 24ZzZA3Za9iNsqkGqG7eC92czD/EMwea1KeyA3HhhGlg+6zHyWwGNl9EM3DrPrYDRyZDYqIV/+5
 tiZW/y16e6ej7zzGTOCKTlu47l+p7v6U5Xiexlw2oUmURriLgTS5fcStmximIwaFfpOfInRo6QV
 c9l8uPV3pRs9PecwezGqygNxUumidZhKA92+/LbNC1HWpxDASjlwYglaHolBwLOWirLkvEYnKyD
 YltZeJ6DU2uvPj9AiHY9ZwoyiPoT0yFerqcKdpKbNZNgK3xMM/qqOZfTfAEuUMnPH9HS2QZKit5
 XOeXaX+YMv2UakkBerom1Y6k8qjff8BetZR1XarA6HXVTft+fIt/Xug+QMw6QCtN3iUoat7F6Nz
 XwNw/fXc1zXaOWGoqVST7MEqlnxIofhd2qhCrXI1FRX/AUgFGz3my4u0jTnvWFVe9wegZeAO3oM
 7GkhnokQuR85L82sxAC4z+hxW+BWF9x6qflSFn2QxZ8EafOAQdW9EVdcB7FNnznikBok68xTYiV
 h/VEMDEiMytBBZPYv0NHIDSdch/4shWF9uw2v2z1s1WnsxAoUVGJ62JJq/JicrJ9iY0fUcqgJQ=
 =
X-Received: by 2002:a05:6a00:94d1:b0:8b5:faab:187 with SMTP id
 d2e1a72fcca58-8c5d3d0cf00mr79202b3a.24.1794941785345; 
 Tue, 17 Nov 2026 10:56:25 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c5ca7aaadasm53419b3a.13.2026.11.17.10.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 10:56:25 -0800 (PST)
Date: Tue, 17 Nov 2026 10:56:23 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mark Bulatov <ms.bulatov7@gmail.com>
Cc: Chaoyong He <chaoyong.he@corigine.com>, Niklas =?UTF-8?B?U8O2ZGVybHVu?=
 =?UTF-8?B?ZA==?= <niklas.soderlund@corigine.com>, dev@dpdk.org,
 stable@dpdk.org
Subject: Re: [PATCH v2] net/nfp: fix uninit local var in
 nfp_pre_tun_table_check_del
Message-ID: <20261117105623.53dd615f@phoenix.local>
In-Reply-To: <20261116171857.5306-1-ms.bulatov7@gmail.com>
References: <20261116171857.5306-1-ms.bulatov7@gmail.com>
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 16 Nov 2026 20:18:56 +0300
Mark Bulatov <ms.bulatov7@gmail.com> wrote:

> If the search fails, it leads to a null pointer dereference when attempting
> to initialize nfp_mac_idx.
> 
> Fix this by adding a check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: d3c33bdf1f18 ("net/nfp: prepare for IPv4 UDP tunnel decap flow action")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Mark Bulatov <ms.bulatov7@gmail.com>
> ---
AI review had observations worth doing a cleanup pass to fix.

[PATCH 1/2] net/nfp: fix uninit local var in nfp_pre_tun_table_check_del

Info: the commit message covers only half of the bug.
  find_entry can reach the dereference in two states. If no
  pre_tun_bitmap[] slot is set, the loop body never runs and
  find_entry is uninitialized. If slots are set but none matches,
  find_entry holds the NULL from the last search. pre_tun_cnt counts
  entries for all representors, so pre_tun_cnt > 1 does not mean
  this representor's MAC is in the table. Suggested body:

    find_entry is left uninitialized if no pre-tunnel slot is in
    use, and is NULL if no slot matches this representor's MAC.
    Either case is then dereferenced when computing nfp_mac_idx.

    Initialize find_entry and fail the delete if no entry is found.

Info: put the check directly after the search loop.
  The check sits after "nfp_flow_meta = nfp_flow->payload.meta;",
  which has nothing to do with it. It reads better as part of the
  search:

	for (i = 1; i < NFP_TUN_PRE_TUN_RULE_LIMIT; i++) {
		...
	}

	if (find_entry == NULL) {
		PMD_DRV_LOG(ERR, "Pre-tunnel table entry not found.");
		ret = -EINVAL;
		goto free_entry;
	}

	nfp_flow_meta = nfp_flow->payload.meta;

