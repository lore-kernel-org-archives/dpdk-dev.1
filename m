Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E649CA6002
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 16:25:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD7FD40268;
	Wed,  7 Oct 2026 18:25:37 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 3213D40265
 for <dev@dpdk.org>; Wed,  7 Oct 2026 18:25:36 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2e4af975346so24960885ad.0
 for <dev@dpdk.org>; Wed, 07 Oct 2026 09:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791390335;
 x=1791995135; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Y+3OJ/QwfUr3YOBMEY0SAhM7da68ts6ZmwcOyRAew10=;
 b=mn/TWLrmpY9Vb+V7Z5aegI3zZPbVGJZxGlVhTDNCBZgWCK0s7Fthe0atj0aPR6u4pk
 DBrDpVVu0Y3qasD9UgtbzVcPqI7ox2acCeBKuU3BUlRwGFtwOwWGAWMT9K4RhGW4jSIK
 xEf7EwrG2YzV1110IekBDKwANNliARzFlmWo6a228pBB7GXlJs0wCdB1edG/LCC1R/aE
 LPs+0F1HJBMzmvLI/2FOgAXjqrl6CqvwEf294IjWV9BVW7xNjwStcq3V6JvASbnawYXH
 eS/92LRi3BYRDdYBgc1LkQiEKPoLsPeVBQcpnVPUMr1y8Cq5ncQj5DnhevNvVD53n+f9
 GLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791390335; x=1791995135;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y+3OJ/QwfUr3YOBMEY0SAhM7da68ts6ZmwcOyRAew10=;
 b=ymFMTf+4+Vkuc5J87hSZBCtOGQF9pDq2QIG+1PkUAjFuyRY3J6aC9/FNEZHEV223LO
 5YDK1mEQtNlHNpbGEm40cZ+qKLdz2I8ZA8lHBcqmYWFy3dIqUkIHkOJPW9Ay6huNhOae
 VCnUoq1JLpSKTESiNd/owz9BMF1pAKfINgOVXeO1jYgoqm7VZz7aXzB5TeHBcvW7JTbh
 /okOjD8kJn6QEbv8Vt0xJ+NMhQ77s3wsS4rrCK1BiZfz2tvAEluDYKl/ZQoshg1fkHOj
 uZZgv+jXT+fvqoviYDjPCqQutao7sGsSrdtl3WBVyoi6K51q8TVEt7UveRdMyexpc8VE
 783g==
X-Gm-Message-State: AFq9FYJLA2blcfaNI2RkjJe3suMrgPn3n91m/BlzsSS9Cxaj49ZvtqLj
 6aMHt5B/u0NGnF9hj/f/0reaqcNPb76+RyJ/pGajJRHLaHXZK7XJI2OHRU2TxBkX6Bn8oi5xIFY
 2+kKLetI=
X-Gm-Gg: AYBFou1FXc5LrOpXSb3L1Uftrlf4IY5hG0O1FhX5I+X+xu0hY4fEfVhDSh8QUhpfKQ8
 iDNVFsokZyh14afbA/JZ/OrZcB6ydM4hyXz52Jd5qn82yyfLFp69Vqi3+7M0D/m0/YxZ40pvjvZ
 QCYNU/Z8rHAZAmbJyAD4tGElFLUOqJDry+LuITllktM4Xf3zmy8ZdgYMqAITTrRAMDj9JvHwmIy
 bReLvhf7quKmAc7pjMJCL9P4RWzeF+T4aoytPki2/vw2Z2r9EJU2deL6tf/DPgySNftM5AyL/75
 ymKSgxlKvPQLkWw3/UFf1Njunygdf8c66TcYNroVns6Earj8NJbnLW8yLwmxVSwBEIHR9cjtfZQ
 0raQpoFO+hGKL2j18+5Izr75bHmqxOnjjPtSPrVaoqvDMq7mEIXgr/8gxC+dIBITzO6p1RTmPGS
 NxyZ5Kan1j2sWekBMzKiMgB05PBddk/OEvT9/FqsROIhJCLgGRKnTvybDQHie0cahJtD1Df+HPW
 DCwN9+JB0gaeBX+rSTV3ayuIbhtsjq7D4HhZww5
X-Received: by 2002:a17:902:e550:b0:2dd:c100:3134 with SMTP id
 d9443c01a7336-2e6003b6d74mr24870405ad.48.1791390334933; 
 Wed, 07 Oct 2026 09:25:34 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e6046fe05fsm13890965ad.27.2026.10.07.09.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 09:25:34 -0700 (PDT)
Date: Wed, 7 Oct 2026 08:51:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v6-S1 0/6] dpaa2: bus, DMA and mempool base fixes
Message-ID: <20261007085129.52bddd92@phoenix.local>
In-Reply-To: <20261006150749.3591526-1-prashant.gupta_3@nxp.com>
References: <20260929142117.3109066-1-prashant.gupta_3@nxp.com>
 <20261006150749.3591526-1-prashant.gupta_3@nxp.com>
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

On Tue,  6 Oct 2026 20:37:43 +0530
Prashant Gupta <prashant.gupta_3@nxp.com> wrote:

> This series is the first of four that upstream the missing NXP dpaa2
> driver changes. It collects the foundational bus/fslmc, dma/dpaa2 and
> mempool/dpaa2 fixes that the later series build on:
> 
> - defer fslmc bus initialization to probe; reduce probe logging
>   and skip ignored devices during DPRC population,
> - use memcpy to fill the dpaa2 QDMA completion index ring,
> - release SG FLE on completion ring overflow in the dpaa2 QDMA
>   dequeue path,
> - validate the FLE pool IOVA mapping at vchan setup and free the pool
>   on failure,
> - resolve the mempool ops index locally in secondary processes by
>   scanning rte_mempool_ops_table, removing the need for IPC.

When running AI locally which also has context from previous reviews,
it found a couple of things. I goaded it to be more concise and
provide more concrete suggestions.

Review: [PATCH v6-S1 0/6] DPAA2 fixes

Applies to main, every commit builds with -Dwerror=true.
Patch 5 needs rework, patch 4 a small follow-up. 1-3 look good.


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


[PATCH 4/6] dma/dpaa2: release SG FLE on completion ring overflow

Warning: the LONG branch still records the FLE before the ring
insert. Make it match the SG branch:

		fle_sdd = (void *)(uintptr_t)DPAA2_GET_FD_FLC(fd);
		ret = qdma_cntx_idx_ring_eq(qdma_vq->ring_cntx_idx,
				&idx, 1, free_space);
		if (unlikely(ret != 1)) {
			rte_mempool_put(qdma_vq->fle_pool, fle_sdd);
			return -ENOSPC;
		}
		qdma_vq->fle_elem[*fle_elem_nb] = fle_sdd;
		(*fle_elem_nb)++;

Warning: drop "This matches how the caller treats a failed dq_fd()
as having consumed nothing." The FD is already pulled from QBMAN,
so on -ENOSPC its completions are lost, not retried.


[PATCH 6/6] mempool/dpaa2: look up ops index locally in secondary

Info: drop the unrelated blank line removal before
bp_list->next; this goes to stable.
