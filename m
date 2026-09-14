Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C88C88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 16:14:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D099640E64;
	Mon, 14 Sep 2026 18:14:31 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 71AA540A7F
 for <dev@dpdk.org>; Mon, 14 Sep 2026 18:14:30 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccda24a3so1675872a91.0
 for <dev@dpdk.org>; Mon, 14 Sep 2026 09:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789402469;
 x=1790007269; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wpJDDSKfl5sq3SChrGf7iE+UxKYAblECNhRjiwSrLoA=;
 b=FFgcWaUtJWtuyYivawvS7hvduIW/SlX4CcimaypnCtsgEPvD7Pe0/nxWiwaao86z4U
 5Kui0JNzdH89UwKsyUD3osl5mrHMW+4R8Yo+izwwPFt4K0yXI6e0qVq+J2l4oVQQKSny
 5T3+0VqxfWFhmqdLLuM3A9+uUDRtM6vHjep5sgifpFnvIT2YsWeYwoWUSFYUzVlqbK8/
 EZX7JGMG1VL2V6wZJl4an4itRhG++Y09gqPtRGX9EWufyUpEj+2a0Mavpb4HdxojthA0
 L6j+WFvuduR5vSrWTcj9Ock4dIarSUwBAgZ9sJ1JXehleGNL9kIB0tyfOEjmV4Y0lNC2
 Oxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789402469; x=1790007269;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wpJDDSKfl5sq3SChrGf7iE+UxKYAblECNhRjiwSrLoA=;
 b=g/odZkHB7stCLnNDbs7lodL8Bbu0nI2o7oV9OzmsgEACqifOHdqMBgHhpE9umR2dck
 TFq2jo8fVtoD0smZwJ2B40CQrE1Q5fBR3gNdouCv/UQ3cMTQS/EQJtGte5n2M/QhGVE0
 5266CR9V0R3iGblzV9dAJBi2sCD7jxWOXRqeYpQq1CMcQZe2M1vDvZxVGWmGUnR36WjW
 10Kb5z1M9vdgWX4I91hfcFtxwibtMNPpBEOT679hltXA77WTchmShjjwg2DGrYgPZC8P
 L5isi0PMn9o6fbaVDowbM2nZe5EqtkmsehFAYTmr0+z7XglI9xnKYwkfI4xG21m6XRkb
 UVlA==
X-Gm-Message-State: AFuF++kyJmHly0ugoi9IOoND/GoVsZ5osJ1ljUSc7uA1cXP0+H/7cP/n
 QDoRvGfvGdumStnccjsrjYVw6z09xqBNvfzLXDMxDyDE95wqcn8T96YaXittkD71YHQ=
X-Gm-Gg: AYBFou2Xsr/SY/2wB0bitHgQAXfvbBt1bpSRF1Aq0tZRE47O7MB7uY3wgN6Ok3sHDGN
 FsKXtJWMTJMwJgKacRBK7/hGnZarDzR9J4BBQNsazjPCAkJVoiv9vNsim7qdZfQjX9wxwZXOOpl
 vTXnwIKKqksX79FCsrRvPCiOKDac2v1YfoaTaq2CsXvaLIzdY+kENbFlt0id4zk9srNeOjHitla
 iXpQbgOixsH1N5u5gh8BIARPgYcUVWIfG+irR3WJNyXrBMuylk4cwxgwEcvpIbCi7PEEQhdxO1p
 qgOzDyJ1gLuqjeNS9eP2BjPaM23cbFKYSTZPRhN76q4SznUaehljLqND93UY2tUAAWGkK7e9tOo
 UeQg9aqVjGcGW3bWZ9qEoKwt5SNZtzl9tRIhNBBRl7EsU7sAN0kCu9P3x7QnyIqTQhqvckXYUcv
 DRzJuMhPbZDSjSLAjSUL3sXQ9ovYdn0gixjlIgfQjTfMIQmK2dzIY+CNdkGVBiYAEqXH7c3qvzK
 +s1mbTsYjDtLWV+AdI5bKgCyb/QXoIFskFCoudo
X-Received: by 2002:a17:90b:2789:b0:39d:f2a1:2a with SMTP id
 98e67ed59e1d1-39df2a103d6mr5159999a91.19.1789402469410; 
 Mon, 14 Sep 2026 09:14:29 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdd28acbsm163691a91.10.2026.09.14.09.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 09:14:29 -0700 (PDT)
Date: Mon, 14 Sep 2026 09:14:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rita Ruvinsky <rita.ruvinsky@weka.io>
Cc: dev@dpdk.org, longli@microsoft.com, weh@microsoft.com, stable@dpdk.org
Subject: Re: [PATCH] net/mana: fix Tx stall from send queue free-space unit
 mismatch
Message-ID: <20260914091419.22e3ef6e@phoenix.local>
In-Reply-To: <20260914105809.919580-1-rita.ruvinsky@weka.io>
References: <20260914105809.919580-1-rita.ruvinsky@weka.io>
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

On Mon, 14 Sep 2026 13:58:08 +0300
Rita Ruvinsky <rita.ruvinsky@weka.io> wrote:

> gdma_post_work_request() subtracted a unit count from an entry count:
> 
>   queue_free_units = queue->count - (queue->head - queue->tail);
> 
> queue->count is in entries, while head and tail are in WQE alignment
> units. On a 512-entry, 128KB send queue the check saw 512 units of
> capacity instead of queue->size / GDMA_WQE_ALIGNMENT_UNIT_SIZE = 4096,
> and returned -EBUSY with the queue one eighth full. A workload that
> fills that window faster than it drains makes rte_eth_tx_burst() return
> 0 for long enough to look like a dead port.
> 
> Derive the capacity from queue->size, which is also what the ring wrap
> in gdma_get_wqe_pointer() uses. Rx is unaffected: its WQEs occupy
> exactly one unit, so entries and units coincide.
> 
> Fixes: 56dd45c0ce7b ("net/mana: implement hardware layer operations")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Rita Ruvinsky <rita.ruvinsky@weka.io>
> ---

Applied to next-net

The long form AI review had some observations worth including:

On Mon, 14 Sep 2026 13:58:08 +0300
Rita Ruvinsky <rita.ruvinsky@weka.io> wrote:

> gdma_post_work_request() subtracted a unit count from an entry count:

The unit analysis is right.  head/tail are advanced in alignment
units (queue->head += wqe_size / GDMA_WQE_ALIGNMENT_UNIT_SIZE, and
gdma_get_wqe_pointer() multiplies head by the same constant), while
sq_count comes from rdma-core as attr->cap.max_send_wr and sq_size as
align_hw_size(max_send_wr * get_wqe_size(max_send_sge)).  Deriving the
capacity from size is the only self-consistent choice, and it is what
mana_gd_wq_avail_space() in the kernel driver does.

Info:

1. The debug line in the -EBUSY path still reports queue->count:

	DP_LOG(DEBUG, "WQE size %u queue count %u head %u tail %u",
	       wqe_size, queue->count, queue->head, queue->tail);

After this patch count no longer takes part in the decision for the
send or receive queue; only gdma_poll_completion_queue() still uses it,
for the CQ.  The one line printed when a post is rejected no longer
shows what it was rejected against.  Suggest:

	DP_LOG(DEBUG, "WQE size %u queue size %u free %u head %u tail %u",
	       wqe_size, queue->size, queue_free_units,
	       queue->head, queue->tail);

2. The comment describes the old bug rather than the invariant:

	/* head/tail count WQE alignment units, so the capacity they are
	 * compared against must too: queue->count is in entries and
	 * undercounts the queue, stalling Tx well below capacity.
	 */

The stall belongs in the commit message, where it already is.  In the
source the invariant is enough:

	/* head and tail are in WQE alignment units, so the capacity must
	 * come from the queue size in bytes, not the entry count.
	 */

3. Worth a sentence in the commit message that the kernel mana driver
computes the same limit in mana_gd_wq_avail_space(), in bytes:

	u32 used_space = (wq->head - wq->tail) * GDMA_WQE_BU_SIZE;
	return wq->queue_size - used_space;

It is independent confirmation of the unit convention and tells anyone
backporting this that the two drivers now agree.
