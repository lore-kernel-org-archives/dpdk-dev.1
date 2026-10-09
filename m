Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B802CA601F
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 19:08:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87E8640274;
	Fri,  9 Oct 2026 21:08:16 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 9090A4026A
 for <dev@dpdk.org>; Fri,  9 Oct 2026 21:08:14 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2df8c28a0b1so305395ad.1
 for <dev@dpdk.org>; Fri, 09 Oct 2026 12:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791572894;
 x=1792177694; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cVWHsRs9LOia0HR7R2gsbi72sxqiNwgGMjlb+Y8RkdA=;
 b=c3NJeu2u1fHSXO9+GBknpr5xmebuGdTtxIwubSL25rsoSrZ6R3eIQ0Kefw1tdIw238
 KvVERW1rKyMo9eo9ULfemfTrUy6OSBAUBfW73o1UP54YZdnKBoL6AgcCYn80GsQTxA/B
 Ek84doK9QPiA1FkSDmXxBfYkqNlE7towP43KnIEfTjEuZ16+589nsimwR/uV/WDDrHsc
 rFZF8LQwnh5gUwG9jsCXbqDfnnCMytB4EITVgNi+Fe5iATDLihDeEnQMOdJufQ0SpIMb
 lv8Pk2XdAS18r+k2uDvX5/OfpAzkacUy0Yvh5w+zxnxCK/beRQhmmIx+Mtct/3E+QTEL
 sKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791572894; x=1792177694;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cVWHsRs9LOia0HR7R2gsbi72sxqiNwgGMjlb+Y8RkdA=;
 b=2OturzBkF9TmU00G30mLHGuIHQYfqGekC7UmcsIwK+BY8t9/L6jD8Mcq6oxvcFO3mn
 qj4T3FYfag3ofkxAdj4pQjDU5WKCVcHQSZ8yB2xe8IKVovFIgQY1fOoY0TVciTiLwH9+
 eaEPp4ARPrNJF8IB1gD+9DP1d+RqnA4EOUgTmZeL2gHChvLkcTgDQefVGT3VZEZK+kmg
 aaymBmIlBrqsTS5BE17T23W15VjuVyDZIeTWvdGlMll7n7npH+iTb1UFT15sJ2AaRslv
 DRyACruPUEs7paWAiOA3+3YbQCM+mb3qLXtBz+IsUPKGA9GAl8y5N7mKk/c5BF2LYZUq
 eZuw==
X-Gm-Message-State: AFq9FYLvWT8N2V/nDxmxJKthiCp2SkO8IcATkdlOS5MnI+M/UqStceN0
 4wE33ci34hK1AMR5sXqCEuXjsY3KH58JwApBM9Dy9a3WZsnCW/IZx5SeBxjfxrH2M3I=
X-Gm-Gg: AYBFou3s27KZHyR91dtG4xlpm2byXqEdpucpct7lQL2a5IOmidK0w0QXwzueUsKXTYy
 FY1byjKpSKq+IGIQJ9s25ClZOx/A03IjxCkhmtnT8AAZuTnhm5uvLt4xXDp2RTqYIuONhD45vTE
 Jc9CGyxJlz4wLORhr6wLWuAkV5WR22URSkg9BuJrbiu+x6lUWv7p+wh4QW1B1prrYzKbIRDZzun
 jYwH76hHV+e9djeHgfgNp/G3nfrqz0b2TBmWI5gZxLDgwm2f/RZqSMGoQnWQs/ehvNcQXSsWbwy
 mzTH6v0fz5FYaPXOHRi9wu6tq+aVZKyYxkEM+qqM/NtjpEsxr2bBMOSDJ3yPjD0ziD5fknV4WhS
 LSl1nbjYLV4F3jb6WP+ZV6VZA0PqaEuq3xBRldhsVflhu0JlXGL9Jy2SzFva8k2y3nuAZ1khiQE
 vUfdWwdcg9ee3f4slcJSjeM2hPhpYHx/GXtij3NCH8jXZhI3SjiL06N2+zy+V59EqSgVOGTLCVr
 UvMrxrzMgrTjEaGwH1Pn1mtaP3BMaALwpDW+lQwRRbAio+gBkU=
X-Received: by 2002:a17:902:e5cf:b0:2df:9556:6848 with SMTP id
 d9443c01a7336-2e8427f76bbmr22708615ad.4.1791572893479; 
 Fri, 09 Oct 2026 12:08:13 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421ae999sm15238515ad.31.2026.10.09.12.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 12:08:12 -0700 (PDT)
Date: Fri, 9 Oct 2026 12:08:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v7-S1 0/6] dpaa2: bus, DMA and mempool base fixes
Message-ID: <20261009120809.0d07f730@phoenix.local>
In-Reply-To: <20261009105019.1121083-1-prashant.gupta_3@nxp.com>
References: <20261006150749.3591526-1-prashant.gupta_3@nxp.com>
 <20261009105019.1121083-1-prashant.gupta_3@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri,  9 Oct 2026 16:20:13 +0530
Prashant Gupta <prashant.gupta_3@nxp.com> wrote:

> This series is the first of four that upstream the missing NXP dpaa2
> driver changes. It collects the foundational bus/fslmc, dma/dpaa2 and
> mempool/dpaa2 fixes that the later series build on:
> 
> - defer fslmc bus initialization to probe; reduce probe logging
>   and skip ignored devices during DPRC population,
> - use memcpy to fill the dpaa2 QDMA completion index ring,
> - release FLE objects immediately on completion ring overflow and
>   only account them after successful context-ring insertion,
> - validate FLE pool memory chunks at vchan setup by verifying
>   consistent VA-to-IOVA offsets across the mempool and free the
>   pool on setup failure,
> - resolve the mempool ops index locally in secondary processes by
>   scanning rte_mempool_ops_table, removing the need for IPC.
> 
> Every commit builds cleanly (including the aarch64 DPAA cross build with
> -Werror) and the series remains bisectable.
> 
> Gagandeep Singh (1):
>   dma/dpaa2: validate FLE pool IOVA mapping at vchan setup
> 
> Hemant Agrawal (1):
>   bus/fslmc: reduce probe logging and skip ignored devices
> 
> Jun Yang (3):
>   dma/dpaa2: use memcpy to fill completion index ring
>   dma/dpaa2: release SG FLE on completion ring overflow
>   mempool/dpaa2: look up ops index locally in secondary
> 
> Prashant Gupta (1):
>   bus/fslmc: defer bus initialization to probe
> 
>  drivers/bus/fslmc/fslmc_bus.c            | 92 +++++++++++++-----------
>  drivers/bus/fslmc/fslmc_vfio.c           |  3 +-
>  drivers/bus/fslmc/portal/dpaa2_hw_dprc.c |  4 ++
>  drivers/dma/dpaa2/dpaa2_qdma.c           | 86 +++++++++++++++++-----
>  drivers/mempool/dpaa2/dpaa2_hw_mempool.c | 24 ++++++-
>  5 files changed, 144 insertions(+), 65 deletions(-)
> 

Applied this first series to next-net. The review was clean.
