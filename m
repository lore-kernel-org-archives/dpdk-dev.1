Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41156CA6015
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 22:41:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 414D74021F;
	Fri,  9 Oct 2026 00:41:35 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id E051840144
 for <dev@dpdk.org>; Fri,  9 Oct 2026 00:41:32 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3ab3260b35dso160498a91.1
 for <dev@dpdk.org>; Thu, 08 Oct 2026 15:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791499292;
 x=1792104092; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RAgHB+6TRXqWTGnv9g7ebmgNnoNXz/bdbYYxkoZu2L8=;
 b=lClEMudiz8FtbjmHFDr5cWE1bCmul1ld1dlLAcD+60SD1Jt0dTYj9TgckLVXaGwcbO
 x9vMovbWUqzVjeSYlY31ZhOBCX+pmBsTMWeYHnQMGSg4xJdPJS96KAZXCR5NqI2LDSNn
 MblZtbRFGk6ad0qEJ6Fii3XqVW+MJV1fNB7gUDYAUJj2MglTIjoCfKSC0V4Xt2xFTZft
 O5RijVmSEhTu3EkcDYrMlb04K33jCtEJbZT53p4n8M0oM8ob/6hCKc6kep2877QNXscI
 xCB4n3HbjE9gN/yW+4LaVzBsW22vs1vSMZOoXD7rH6gBHIXGaMepfyPJn0iOjFccVkZc
 HOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791499292; x=1792104092;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RAgHB+6TRXqWTGnv9g7ebmgNnoNXz/bdbYYxkoZu2L8=;
 b=kzYuLtnJ6aAESAzjXMB0RRsrenA5rcYNWJPZ08soYAg1nVfExO6+TPhhoZ08Tp+akR
 iLwofngRdnHDQJkxyzDb5C45mgsdhZtRxlQKX4GpXk6wfG9AQujmqS0OaXxvGsxouEDv
 qqlgkiXJbfRqslSfTEOfIL1R8/y8U39pkvbkKCIdJtt/6NQGvEmTCZYZwYdm/TKLcO98
 bNI+jYkZSRVJM9/eC/m7SOY6w99GG2Ifu1K3VIz/KcuQZRsi8XsoRBkqLkw1kJ9PMKNj
 pqmY4+IveS55kSbr+ZxRKRbqROVOmlVKgCfbK1PjVNH9HHhIZY5dKJb4wntcWG40vYvV
 5Iag==
X-Gm-Message-State: AFq9FYL0R9EYhGz5bvegOZw84eBVAL/Z6aDDyQBlopCZRET/BAXzxrdU
 GONKJzkbs7/XLVz/2Mc5tolB25HMSS2v6dYAksjkFj5ORMALBOts9+SzmzesghHTLiU=
X-Gm-Gg: AYBFou0lHhGJT4q9Q2gnpFqYGZ+MiOlCSUOteMziowBBpO3U17oqy6sLKa5g1h292wp
 KzZXt6ULtmixSj2ykxotQZ3RD+N0Q1GOm8pUBV+NtP4jxMNGkKO0h69EWZVI3AJfYJMcuwwpEfk
 pVB8ZTbNTBQhahFfgt2MQd4jcU67QN0odql9M/CYxhUVx95rilovH1BosKiwbDuJj2OKl8ljkjb
 7e6fV36cJcU1b+as242lrPqSqlbt3VUfcohx1WDkEeowV6V2VAc126JoKgcx78ITxWNtXxdCjgf
 TMmrOS2zIrFmONW+BFd2HJrPZUMIV1SxQrQPCJ4Akg/gSwq7HSxtVWNr5rY3s9BLrAJXV2O8nEZ
 WuHyZXKwZaL7SHbnza7uORsbVus1ZPHkUsa/IXiFQeguGBjXYTtLz3rRjyqr1PzcGMd0AwyUd5n
 z8VABAVAPEX/A3QAIiD2sUPJIXFMIN1J5kL78EqpoSxVlfIy+gVfQssAiszjaCMUwwHG82JREIQ
 lfYA+H+OOgGq5UxuCXBXcnxZHDSkIlIZUn34cE3zSWfAAtc35o=
X-Received: by 2002:a17:90b:2688:b0:3a4:adea:50ad with SMTP id
 98e67ed59e1d1-3ab3a775938mr192333a91.27.1791499291887; 
 Thu, 08 Oct 2026 15:41:31 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab37817414sm649268a91.2.2026.10.08.15.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 15:41:31 -0700 (PDT)
Date: Thu, 8 Oct 2026 15:41:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org, Gagandeep Singh <g.singh@nxp.com>
Subject: Re: [PATCH v6-S1 5/6] dma/dpaa2: validate FLE pool IOVA mapping at
 vchan setup
Message-ID: <20261008154127.22a649cf@phoenix.local>
In-Reply-To: <20261006150749.3591526-6-prashant.gupta_3@nxp.com>
References: <20260929142117.3109066-1-prashant.gupta_3@nxp.com>
 <20261006150749.3591526-1-prashant.gupta_3@nxp.com>
 <20261006150749.3591526-6-prashant.gupta_3@nxp.com>
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

On Tue,  6 Oct 2026 20:37:48 +0530
Prashant Gupta <prashant.gupta_3@nxp.com> wrote:

> From: Gagandeep Singh <g.singh@nxp.com>
> 
> The enqueue path turns every FLE virtual address into an IOVA with a
> single subtraction:
> 
> 	fle_iova = (uint64_t)fle - qdma_vq->fle_iova2va_offset;
> 
> That offset is derived once from fle_pool->mz, which is the memzone
> holding the mempool header, not the memzone(s) holding the objects. The
> objects are reserved separately by rte_mempool_populate_default(), so
> nothing so far confirmed that the offset taken from the header is also
> the offset of the chunks the FLEs are allocated from.
> 
> Walk the pool with rte_mempool_mem_iter() after creation and check both
> properties the fast path depends on. First, that every chunk is
> reachable through the IOMMU/SMMU, using DPAA2_VADDR_TO_IOVA_AND_CHECK().
> Second, that every chunk has the same VA to IOVA delta as the offset
> cached in the virtual queue, which a pool spread over chunks with
> different deltas would violate, for example with IOVA as PA and
> fragmented hugepages. Either way the IOVAs programmed into the FLEs
> would be wrong, so reject the setup instead.
> 
> On failure log the pool name, release the pool with rte_mempool_free()
> and clear the pointer, so that a later vchan-setup retry does not trip
> over a stale pool-name collision.
> 
> Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
> Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
> ---

This AI review item seems serious enough that a new version is needed.


[PATCH 5/6] dma/dpaa2: validate FLE pool IOVA mapping at vchan setup

Error: vchan setup fails on 2M hugepages.

DPAA2_VADDR_TO_IOVA_AND_CHECK() on a whole chunk only succeeds if
the chunk fits in one fslmc dmaseg, and fslmc creates one dmaseg
per memseg (hugepage). The FLE pool is 8192 x 2312 bytes, about
19 MB, so on 2M pages the check always fails.

Also the reference offset comes from fle_pool->mz (the mempool
header), not from the object memory.

Take the offset from the first chunk and compare the rest:

struct dpaa2_qdma_fle_pool_check {
	uint64_t iova2va_offset;
	bool bad;
};

static void
dpaa2_qdma_fle_pool_iova_check(struct rte_mempool *mp __rte_unused,
	void *opaque, struct rte_mempool_memhdr *memhdr,
	unsigned int mem_idx)
{
	struct dpaa2_qdma_fle_pool_check *check = opaque;
	uint64_t offset;

	if (memhdr->iova == RTE_BAD_IOVA) {
		check->bad = true;
		return;
	}

	offset = (uint64_t)memhdr->addr - memhdr->iova;
	if (mem_idx == 0)
		check->iova2va_offset = offset;
	else if (offset != check->iova2va_offset)
		check->bad = true;
}

and in dpaa2_qdma_vchan_setup() drop the mz based iova/va:

	rte_mempool_mem_iter(qdma_dev->vqs[vchan].fle_pool,
		dpaa2_qdma_fle_pool_iova_check, &fle_check);
	if (fle_check.bad) {
		DPAA2_QDMA_ERR("%s spans inconsistent IOVA offsets",
			       pool_name);
		ret = -EINVAL;
		goto err_pool;
	}
	qdma_dev->vqs[vchan].fle_iova2va_offset =
		fle_check.iova2va_offset;

Warning: the later error paths (both rte_mempool_get_bulk() calls,
ring_cntx_idx alloc) still return with fle_pool allocated, so the
retry case in the commit message is still broken. Send all of them
to one label:

	return 0;

err_pool:
	rte_mempool_free(qdma_dev->vqs[vchan].fle_pool);
	qdma_dev->vqs[vchan].fle_pool = NULL;
	return ret;
}

