Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181D9C5CFDB
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 20:57:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FBC5402D1;
	Wed, 12 Aug 2026 22:57:11 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 4151D4026E
 for <dev@dpdk.org>; Wed, 12 Aug 2026 22:57:10 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-38dd55ad76cso381074a91.1
 for <dev@dpdk.org>; Wed, 12 Aug 2026 13:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786568229;
 x=1787173029; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hyjS6qPdlEmE5yS5f/pUkruyN2XRyeDJWAcoWxrmQxc=;
 b=Hj/cIyBXd7kIRK7hSdyCMaK4gP3VeYTBjdUMIVgr+ABacumNpmelY4YvFnpgOM+qPd
 dKulDHcHNFE1mYYkom477CJAseVrNOj7uVctCWsoxeVJd9/RxYNBrp69i1GNQBKCp4LP
 iIJhWdx92l3gRSZS0nyuqiPJggDpzErWUqxNl7hj76KydKdSUslsUag2T0Fsh1c2O9Ck
 kOv/gnMh/xoLo5vyTL7EE/LPTAFdXMDubSIER+eNjeg7Avh/ikcz+9A4o9qX3ipFSAXG
 2W49DpnIqi8GlDIuYf70Zg65He/ggP1dUie7VA/BmFLowB+aX9Bm/OY3xiWP36vl9BT8
 Rpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786568229; x=1787173029;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hyjS6qPdlEmE5yS5f/pUkruyN2XRyeDJWAcoWxrmQxc=;
 b=LiV/xW7CX+VCUgl0B1kZ50cwoWQ8cYpRm0CFkooCfzdXXpgvzX0GGjhg4rWsi9xKjZ
 Ot9gWlNI1495+7/6m7HqQcEfTTwIRM/7ETvp6OmlrDd/Z1KThIrh1DA1494FxQcYrFri
 ext1vTCKd0koPVlnGarJ+KdT5cuhgf25+Xjtzj13Nla7ohNLYs1z5LHmOExpZA6Nuszy
 wOCnEGWIeEvx6V0QkFeZa2JjWqTPCU1duve8cM6rqD+O643KhSxSkIzgtHBWF8l7oCXw
 Y3aLV/9tDKsqpoAgSqUxI6m3gK8RB1/XSt6b5L4OXoLy86I1a/Ed2/NsEmpPZajRtezR
 kvEA==
X-Gm-Message-State: AOJu0YwxBBLQLm20zI+fhJ66ZYGQVNabRPYmMQY8vYc9kcWJvIm80lhL
 sabEYemnpnwuBWewRMqVAJQDsmmGrWi3m7U5Mh32i47bOwRxWCUQPu8RZl2xKIwS9LQ=
X-Gm-Gg: AR+sD12K6phUY5Nn+/fy/7/S95GUCX6W4uYRWv3ti92z3I1GAolG1mH6JHJ5FMV7DIF
 mAfgz52TZpCeDs4i1YU24S9aSI/6LYehGdwAGaqUSbe2U3dOPmo9lGosrjJ3r+gz/vl2fAjEd4K
 ziXnrOxvQsJ05GncgoYY1Yxfat9lIOuB+xxfwQr9RakJUWc88FvDKypcS47xhjaI7S/8Hy4sRTW
 tTJL8rtpH6AB+fwTwSpt75oR9OFUnbeOU4xygRA5RPy4RR/e9vDL4qp767A7Q2fkkLXGjOpfK93
 49mo+ohJgCe9EfHAkJilYp52Ve3B5CzS2SrdetxiZSwxBlKGvamOLu5+PJjnIXwjCDhuVBSlP5s
 6n0eOC6GiVpt9RSUtFBuZM1akYpZb/eV+ilBhFq/D9e+xQ02QOEi1nxaemKnyeRcxgD/ro3+kwT
 LZ5P3VlIFZ3UtPEA+Bfr++Rphg6KODHBvmg7ZCNdlAjQaCBKb0VNsSv5/GYgnC6oXBpt7Da+4Tt
 kw+pB7K4pKLpVItOp4CR312wAp45Q==
X-Received: by 2002:a17:90a:d005:b0:36d:b12b:f57d with SMTP id
 98e67ed59e1d1-3931f581f38mr317883a91.12.1786568229068; 
 Wed, 12 Aug 2026 13:57:09 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1412d8bcfbasm962545c88.4.2026.08.12.13.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 13:57:08 -0700 (PDT)
Date: Wed, 12 Aug 2026 13:56:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: sandeep.penigalapati@intel.com
Cc: dev@dpdk.org, Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan
 <mtahhan@redhat.com>, stable@dpdk.org
Subject: Re: [PATCH v1] net/af_xdp: fix shared UMEM refcount corruption
Message-ID: <20260812135656.0bd405cc@phoenix.local>
In-Reply-To: <20260812220843.75727-1-sandeep.penigalapati@intel.com>
References: <20260812220843.75727-1-sandeep.penigalapati@intel.com>
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

On Wed, 12 Aug 2026 18:08:43 -0400
sandeep.penigalapati@intel.com wrote:

> From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> 
> Shared UMEM is meant to be shared by a limited number of sockets,
> governed by the mempool size (max_xsks). When the UMEM was already at
> capacity (refcnt >= max_xsks), xdp_umem_configure() returned the UMEM
> without incrementing its refcount, so the extra socket used it
> unaccounted for.
> 
> This missing reference has two consequences. During queue setup the
> fill-queue reservation is chosen from the refcount, so the sharing
> socket reserves into its own uninitialised fill queue and crashes. At
> close, the under-counted refcount reaches zero while the UMEM is still
> in use, freeing it early and causing a use-after-free.
> 
> Reject sharing once the UMEM is at capacity by returning NULL, so queue
> setup fails cleanly with -ENOMEM. This enforces the per-mempool socket
> limit that shared UMEM was always intended to respect. Also document the
> shared mempool sizing requirement (4096 mbufs per socket).
> 
> Fixes: 74b46340e2d4 ("net/af_xdp: support shared UMEM")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> ---

Detailed AI review found some issues:

Review of [PATCH v1] net/af_xdp: fix shared UMEM refcount corruption

Verified against DPDK main (26.11.0-rc0).  Applies cleanly; the driver
builds with -Dwerror=true at debugoptimized and minsize.  Fixes tag
74b46340e2d4 checks out and that commit does introduce the flaw.

Error:

1. drivers/net/af_xdp/rte_eth_af_xdp.c

   The new "return NULL" leaves rxq->mb_pool set while rxq->umem stays
   NULL: eth_rx_queue_setup() assigns rxq->mb_pool before calling
   xsk_configure(), and nothing clears it on the error path.

   get_shared_umem() then walks that stale entry and dereferences the
   NULL umem:

	if (mb_pool == internals->rx_queues[i].mb_pool) {
		if (ctx_exists(...))
			...
		if (rte_atomic_load_explicit(&internals->rx_queues[i].umem->refcnt,

   Any later queue setup using the same mempool crashes as soon as the
   failed rxq is the first match in the scan -- for example after the
   port that owns the UMEM is closed and removed from internal_list.

   The same scan can also reach a freed or over-shared pointer through
   the existing out_umem path in xsk_configure(), which calls
   xdp_umem_destroy(rxq->umem) without clearing rxq->umem, and leaves
   rxq->umem pointing at a still-live UMEM this rxq no longer holds a
   reference to.

   Both are latent today, but this patch makes reaching that state a
   routine outcome rather than an unusual one, so it should be closed
   here:

	/* in get_shared_umem() */
	if (internals->rx_queues[i].umem == NULL)
		continue;

   and clear rxq->umem unconditionally on the xsk_configure() error
   path, not only when the refcount reaches zero.

Warning:

2. doc/guides/nics/af_xdp.rst

   The new paragraph runs three sentences together across wrapped
   lines.  doc/guides/contributing/documentation.rst asks for one
   sentence per line, wrapped at punctuation points.

Info:

3. This is a behaviour change on a stable branch: setups that appeared
   to work (until close, or until the fill-queue crash) now fail at
   queue setup with -ENOMEM.  That is the right trade, but it is worth
   stating explicitly in the commit message for the stable maintainers.

4. The reflow of the rte_atomic_fetch_add_explicit() call is unrelated
   churn.  While the line is being touched: rte_memory_order_acquire on
   a refcount increment orders nothing useful; relaxed is sufficient
   there, and the matching decrement in eth_dev_close() wants release
   plus an acquire fence before xdp_umem_destroy().  Pre-existing, so
   only worth folding in if you are already rewriting the line.

5. The load and the increment are still not atomic with respect to each
   other -- get_shared_umem() releases internal_list_lock before
   returning, so two ports configured concurrently on the same mempool
   can both observe cnt < max_xsks and both increment past the cap.
   Control path, so the exposure is small, but a compare-exchange loop
   (or doing the check while holding internal_list_lock) is what
   actually enforces the limit the commit message describes.

6. refcnt is uint8_t while max_xsks is uint32_t.  A mempool of
   256 * 4096 mbufs or more produces max_xsks > 255, and the refcount
   wraps before the cap is ever reached.  Pre-existing.

7. "Port initialisation fails if the mempool is too small" -- it is the
   Rx queue setup that fails; "Queue setup fails" would be more precise
   and matches the -ENOMEM the caller returns.
