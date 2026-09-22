Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0B0C982FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 16:24:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D1E042E7D;
	Tue, 22 Sep 2026 18:24:36 +0200 (CEST)
Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com
 [74.125.227.170])
 by mails.dpdk.org (Postfix) with ESMTP id 2245B42E7D
 for <dev@dpdk.org>; Tue, 22 Sep 2026 18:24:35 +0200 (CEST)
Received: by mail-pj2-f42.google.com with SMTP id
 d9443c01a7336-2df4c9d14b8so148055ad.0
 for <dev@dpdk.org>; Tue, 22 Sep 2026 09:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790094274;
 x=1790699074; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+VApACXAuftRNpu5sujxGC8ghWtPWETZGqempANhbPc=;
 b=u8v63ApgZ96r9ARX0QNFfRi1caty4Quo/OXEQSJ0cxjhbnfmadQG+J4ugdj19Wn4em
 vALzeD4AQaSOAqeYPgULKuGmTV51/QRzFgMkx09dzGkroHKqu2rixRIHKeItwua72+Q1
 Ax1DdFOlUU5Olqx/2Jy5PmcDH7Q1yY0nM0YZfz+bKOkmdgBXRNgW0Tmn2QoAddiARhFL
 gcCt75ICiC+N8EcLoQb9raU6IP38sIzUbM4WilZTqSxNYukKpzCKAAQWZ3Mi5khQ4w/u
 dwCJG69vvX0YTd2HV1yG5uP8w9SR5u4IDWH63qS7PIEzDC86mwqmmotYX2P6oDVxcX16
 tj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790094274; x=1790699074;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+VApACXAuftRNpu5sujxGC8ghWtPWETZGqempANhbPc=;
 b=FZ05742mmNWnQ/KCJhS6BgtM33UiG2WI6YY7M4v9INa/T4wSWvUhyrNhiX+J+c/6/2
 znmz+whx0ldvm8fXRcbdUu6B5wiqJ21fQimp3nsliyoYZSdNKSQUE0rQHsQBeBYzKsfA
 aMrx8f7hUL4SWSOd6ApGdthiYZfKT2D4TnSui+PvwSe0Qv9oQZtlHUhKUq2eNOPw44yQ
 X3gyset6qmLDqoEh1jk0oTm1zpsBkLAnzLs+FYfphmcMxdcpAluCLA5FGNTT79X0DdQa
 /Tc5Zv2gnr4Q8EnCqC6XaZbCOKUIhuxIatywgbatLnjonNfaIcZbiG13vk1OgCXzGlAS
 x3jg==
X-Gm-Message-State: AFuF++lovlj8EKHr6HVnu/TH2IT6aiAuyIZKBwhAG09b+jEb+fbUp5GC
 jjiMT4ebOjrdwnY37Q+0uga5cYaM/dZ7ZdemqrrODC+F29Jbe/pBJUNeAKoRdgMSBc4=
X-Gm-Gg: AYBFou3BXe4MMtVLJcF18Pk/keF1g5HOA0iTolEtPFOY/uqYQT71DvN9khbkt40gh0u
 SlV+SbX+LCemNlcdZ8/uq523Ic/CVONEbjITqKPUI9Utlk9iJgGrNWbs5ra0UBb4vYjP8OXHdo9
 UdUokpubrK9eIRpvGlY2Iq5wZdQREsKw6jr/QjYerqQ43ERMD9W9ZSUXHT4WqlxbKyk0XgS4tNN
 q0CS7cXJmaNXPdQucBw4FdU/if9oQBeacwVAKJ8OsKEkdyxpOrZNYVvRnuICPMSTZH3HsGlv+Q7
 Tb2YZPbm8s7iomhnbAFEdCzxYPjfZbfdF/3oV88H+gOwyyNH4+cObytnDWSNf1WUGgHCRViULNz
 PRuFI6QPWqS1/ApqBBYZDiupMEENO6ocWZKDZhruLtXm0vrWnPOMrYt55xEOAK+PAFcwj9sklHl
 O6qLITCM8H2NDECGyaiJDT9vVCd2uy3dUQpK+QE3deGmENurEsIOrySumEQ+DKMTvus0S7wW5hQ
 BdCgucPJKE6sLKg1JQfR5HaBq7K1PEi2N/XWTBw
X-Received: by 2002:a17:902:e542:b0:2d3:6cb4:e79e with SMTP id
 d9443c01a7336-2df69878112mr194715ad.5.1790094273963; 
 Tue, 22 Sep 2026 09:24:33 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df5d02f448sm13733655ad.34.2026.09.22.09.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 09:24:33 -0700 (PDT)
Date: Tue, 22 Sep 2026 09:24:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org, Bruce Richardson
 <bruce.richardson@intel.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Jie Liu <liujie5@linkdatatechnology.com>
Subject: Re: [PATCH v3] net/sxe2: replace private mempool cache bypass with
 rte_mbuf_raw_free_bulk
Message-ID: <20260922092431.0c78a054@phoenix.local>
In-Reply-To: <20260921155214.2690954-1-kai.ji@intel.com>
References: <20260827151011.2122104-1-kai.ji@intel.com>
 <20260921155214.2690954-1-kai.ji@intel.com>
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

On Mon, 21 Sep 2026 15:52:13 +0000
Kai Ji <kai.ji@intel.com> wrote:

> The AVX-512 TX completion path directly manipulated the mempool cache
> internals (cache->objs, cache->len, cache->flushthresh) instead of using
> the mempool API.  This pattern is the same private bypass that existed in
> the Intel common TX library before it was removed by commit 062d6fe5d00d
> ("net/intel: do not bypass mbuf lib for buffer fast-free") for the same
> reason: it omits mbuf instrumentation (history marking) and reaches
> directly into mempool cache internals, including the flushthresh field
> that is now obsolete (kept only for API/ABI compatibility), making the
> private fast path fragile against mempool cache layout changes.
> 
> Replace with a single rte_mbuf_raw_free_bulk() call, matching the Intel
> common library.  The RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE contract in
> rte_ethdev.h requires the application to guarantee that per-queue all
> mbufs come from the same mempool, have refcnt == 1, and are direct;
> that documented guarantee, whose @see already points to
> rte_mbuf_raw_free_bulk(), is exactly what makes this call correct.  The
> compiler inlines the bulk-free call to eliminate the overhead
> difference.
> 
> Fixes: 0af0bdcdcf83 ("net/sxe2: add AVX512 Rx and Tx")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Kai Ji <kai.ji@intel.com>
> ---

AI review had some suggestions here. They seem good:

Review: [PATCH v3] net/sxe2: replace private mempool cache bypass with
rte_mbuf_raw_free_bulk

Applied cleanly to main (6bbb7b3). common/sxe2 + net/sxe2 build clean
with -Dwerror=true, AVX512 object included.

The code change is correct. rte_mbuf_raw_free_bulk() takes the mbuf
array directly and the static_assert covers the cast. Remaining
comments are on the tags and the commit message.

Warning

  Drop "Cc: stable@dpdk.org". net/sxe2 first shipped in v26.07
  (0af0bdcdcf83 is contained in v26.07-rc2 onward); 25.11 LTS does
  not have this driver, so there is no stable branch to backport to.

  The old code was not functionally broken on current mempool:
  flushthresh is still initialized to cache->size, objs[] is still
  2 * RTE_MEMPOOL_CACHE_MAX_SIZE, and rs_thresh is capped at 64, so
  the cache invariant held. What is lost is mbuf history marking
  and debug sanity checks. That is a cleanup, not a stable fix;
  the Fixes: tag is optional.

  Commit message is too long for a 35 line deletion. Also "The
  compiler inlines the bulk-free call to eliminate the overhead
  difference" is an unsupported claim; either give throughput
  numbers or drop the sentence. Suggest:

    The AVX512 Tx free path writes directly into the mempool
    cache (objs, len, flushthresh). This skips mbuf history
    marking and depends on mempool cache internals; flushthresh
    is now obsolete.

    Use rte_mbuf_raw_free_bulk(), as done for net/intel in
    commit 062d6fe5d00d ("net/intel: do not bypass mbuf lib for
    buffer fast-free"). MBUF_FAST_FREE guarantees single pool,
    refcnt 1 and direct mbufs per queue.

Info

  The "(rs_thresh & 31) == 0" condition only existed to feed the
  32-wide unrolled AVX512 copy loop. rs_thresh is validated to
  32..64 in sxe2_txrx_vec.c, so e.g. rs_thresh=48 currently falls
  back to the per-mbuf prefree path even with MBUF_FAST_FREE set.
  With rte_mbuf_raw_free_bulk() the guard serves no purpose; drop
  it.

  No v2 -> v3 changelog below the "---".
