Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA1FCA5FCE
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 07:45:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 378D4402B5;
	Mon,  5 Oct 2026 09:45:09 +0200 (CEST)
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net
 [31.44.14.16]) by mails.dpdk.org (Postfix) with ESMTP id E25A940290
 for <dev@dpdk.org>; Mon,  5 Oct 2026 09:45:07 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:891f:0:640:5a77:0])
 by forward500d.mail.yandex.net (postfix) with ESMTPS id A02DA84D40;
 Mon, 05 Oct 2026 10:45:06 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (smtp)
 with ESMTPSA id 4jFNhOriNa60-Ymiu14Xq; 
 Mon, 05 Oct 2026 10:45:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1791186306; bh=0TVM0jpkqNDrZ705n7AzXz+Erl8SIM2GSHjMta7ERoE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=ndN8P+v4oTyrN8oa4itEuuIQ2b30R5uVA8sPaSwUi73zvIYQsilG4Kwk6gm2V0T63
 EvR3q/eNxuHyu4ZL9KqsYjQy6aX/wHJFq57hUorU0bWv1OyXk7pmC+FGMH6jLP/GnH
 15gBcw8rVP0IycTxXwNs6psf/TscyPGq1ndNGVhk=
Authentication-Results: mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
Message-ID: <8b945572-dd97-4040-ac1f-37dd14edba3d@yandex.ru>
Date: Mon, 5 Oct 2026 08:45:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mbuf: avoid temporary array for bulk free
To: Nam Tran <hoangnamtran18122005@gmail.com>, mb@smartsharesystems.com
Cc: dev@dpdk.org, stephen@networkplumber.org
References: <20260922012856.30090-1-hoangnamtran18122005@gmail.com>
 <20260929002527.7-1-hoangnamtran18122005@gmail.com>
Content-Language: en-US, ru
From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
In-Reply-To: <20260929002527.7-1-hoangnamtran18122005@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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




> rte_pktmbuf_free_bulk() currently stages freeable mbufs in a
> temporary array before returning them to their mempool. For flat
> packet arrays, this copies pointers even when the input array
> already contains contiguous freeable mbufs.
>
> Track contiguous same-pool runs in the input array and pass them
> directly to rte_mbuf_raw_free_bulk(). Flush at 64 entries to
> preserve the existing mempool-cache behavior. Also flush on NULL
> entries, retained mbufs, and pool changes. Keep the array-based
> fallback for chained packets.
>
> Add coverage for NULL entries, mixed mempools, shared and indirect
> mbufs, and a flat run followed by a chained packet.
>
> Signed-off-by: Nam Tran <hoangnamtran18122005@gmail.com>
> Reviewed-by: Morten Brørup <mb@smartsharesystems.com>
> ---
> v2:
> - Cap same-pool runs at 64 to retain mempool-cache behavior.
> - Move the sanity check after the chained-packet fallback decision.
> - Add mixed flat/chained and indirect-mbuf regression cases.
> - Remove the earlier timing claim; the capped version has not yet
>    been benchmarked on x86 or with a cached mempool.
>
> Tested: ARM64 Linux debug build and mbuf_autotest passed.
>
>   app/test/test_mbuf.c | 94 ++++++++++++++++++++++++++++++++++++++++++++
>   lib/mbuf/rte_mbuf.c  | 74 ++++++++++++++++++++++++++++++++--
>   2 files changed, 165 insertions(+), 3 deletions(-)
>
> diff --git a/app/test/test_mbuf.c b/app/test/test_mbuf.c
> index db23259745..249e541173 100644
> --- a/app/test/test_mbuf.c
> +++ b/app/test/test_mbuf.c
> @@ -833,6 +833,100 @@ test_pktmbuf_pool_bulk(void)
>   		goto err;
>   	}
>   
> +	printf("Test bulk free with NULL entries.\n");
> +
> +	ret = rte_pktmbuf_alloc_bulk(pool, mbufs, 4);
> +	if (ret != 0)
> +		goto err;
> +
> +	m = mbufs[1];
> +	mbufs[1] = NULL;
> +	rte_pktmbuf_free_bulk(mbufs, 4);
> +	rte_pktmbuf_free(m);
> +
> +	if (!rte_mempool_full(pool)) {
> +		printf("mempool not full after NULL-entry bulk free\n");
> +		goto err;
> +	}
> +
> +	printf("Test bulk free with multiple pools.\n");
> +
> +	for (i = 0; i < 4; i++) {
> +		mbufs[i] = rte_pktmbuf_alloc((i & 1) ? pool2 : pool);
> +		if (mbufs[i] == NULL)
> +			goto err;
> +	}
> +
> +	rte_pktmbuf_free_bulk(mbufs, 4);
> +
> +	if (!(rte_mempool_full(pool) && rte_mempool_full(pool2))) {
> +		printf("mempools not full after mixed-pool bulk free\n");
> +		goto err;
> +	}
> +
> +	printf("Test bulk free with shared mbuf.\n");
> +
> +	ret = rte_pktmbuf_alloc_bulk(pool, mbufs, 4);
> +	if (ret != 0)
> +		goto err;
> +
> +	m = mbufs[1];
> +	rte_mbuf_refcnt_update(m, 1);
> +	rte_pktmbuf_free_bulk(mbufs, 4);
> +
> +	if (rte_mbuf_refcnt_read(m) != 1) {
> +		printf("shared mbuf reference count incorrect\n");
> +		goto err;
> +	}
> +
> +	rte_pktmbuf_free(m);
> +
> +	if (!rte_mempool_full(pool)) {
> +		printf("mempool not full after shared mbuf free\n");
> +		goto err;
> +	}
> +
> +	printf("Test bulk free of flat mbufs around a chain.\n");
> +
> +	ret = rte_pktmbuf_alloc_bulk(pool, mbufs, 5);
> +	if (ret != 0)
> +		goto err;
> +
> +	ret = rte_pktmbuf_chain(mbufs[1], mbufs[2]);
> +	if (ret != 0)
> +		goto err;
> +	mbufs[2] = mbufs[3];
> +	mbufs[3] = mbufs[4];
> +	rte_pktmbuf_free_bulk(mbufs, 4);
> +
> +	if (!rte_mempool_full(pool)) {
> +		printf("mempool not full after mixed flat and chain bulk free\n");
> +		goto err;
> +	}
> +
> +	printf("Test bulk free with an indirect mbuf.\n");
> +
> +	m = rte_pktmbuf_alloc(pool);
> +	if (m == NULL)
> +		goto err;
> +	mbufs[0] = rte_pktmbuf_alloc(pool);
> +	mbufs[1] = rte_pktmbuf_clone(m, pool);
> +	mbufs[2] = rte_pktmbuf_alloc(pool);
> +	if (mbufs[0] == NULL || mbufs[1] == NULL || mbufs[2] == NULL)
> +		goto err;
> +
> +	rte_pktmbuf_free_bulk(mbufs, 3);
> +	if (rte_mbuf_refcnt_read(m) != 1) {
> +		printf("indirect mbuf reference count incorrect\n");
> +		goto err;
> +	}
> +	rte_pktmbuf_free(m);
> +
> +	if (!rte_mempool_full(pool)) {
> +		printf("mempool not full after indirect mbuf bulk free\n");
> +		goto err;
> +	}
> +
>   	printf("Test bulk free of single long chain.\n");
>   
>   	/* Bulk allocate all mbufs in the pool, in one go. */
> diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
> index 005bfaa573..99b2ea07cf 100644
> --- a/lib/mbuf/rte_mbuf.c
> +++ b/lib/mbuf/rte_mbuf.c
> @@ -555,9 +555,8 @@ __rte_pktmbuf_free_seg_via_array(struct rte_mbuf *m,
>    */
>   #define RTE_PKTMBUF_FREE_PENDING_SZ 64
>   
> -/* Free a bulk of packet mbufs back into their original mempools. */
> -RTE_EXPORT_SYMBOL(rte_pktmbuf_free_bulk)
> -void rte_pktmbuf_free_bulk(struct rte_mbuf **mbufs, unsigned int count)
> +static void
> +__rte_pktmbuf_free_bulk_fallback(struct rte_mbuf **mbufs, unsigned int count)
>   {
>   	struct rte_mbuf *m, *m_next, *pending[RTE_PKTMBUF_FREE_PENDING_SZ];
>   	unsigned int idx, nb_pending = 0;
> @@ -582,6 +581,75 @@ void rte_pktmbuf_free_bulk(struct rte_mbuf **mbufs, unsigned int count)
>   		rte_mbuf_raw_free_bulk(pending[0]->pool, pending, nb_pending);
>   }
>   
> +/* Free a bulk of packet mbufs back into their original mempools. */
> +RTE_EXPORT_SYMBOL(rte_pktmbuf_free_bulk)
> +void rte_pktmbuf_free_bulk(struct rte_mbuf **mbufs, unsigned int count)
> +{
> +	struct rte_mempool *run_pool = NULL;
> +	unsigned int run_start = 0;
> +	unsigned int run_count = 0;
> +	unsigned int idx;
> +
> +	for (idx = 0; idx < count; idx++) {
> +		struct rte_mbuf *m = mbufs[idx];
> +
> +		if (unlikely(m == NULL)) {
> +			if (run_count != 0) {
> +				rte_mbuf_raw_free_bulk(run_pool,
> +						&mbufs[run_start], run_count);
> +				run_count = 0;
here (and in other similar places), I think you also has to update 
run_start also.
BTW, I don't think you need both run_count and run_start.
Knowing the run_count and idx is enough to deduce run_start (or 
visa-versa).
> +			}
> +			continue;
> +		}
> +
> +		/*
> +		 * Preserve the generic path for chained packets. No mbuf in
> +		 * this suffix has been modified yet.
> +		 */
> +		if (unlikely(m->next != NULL)) {
> +			if (run_count != 0)
> +				rte_mbuf_raw_free_bulk(run_pool,
> +						&mbufs[run_start], run_count);
> +
> +			__rte_pktmbuf_free_bulk_fallback(&mbufs[idx],
> +					count - idx);
> +			return;
> +		}
> +
> +		__rte_mbuf_sanity_check(m, 1);
> +		m = rte_pktmbuf_prefree_seg(m);
> +		if (unlikely(m == NULL)) {
> +			if (run_count != 0) {
> +				rte_mbuf_raw_free_bulk(run_pool,
> +						&mbufs[run_start], run_count);
> +				run_count = 0;
> +			}
> +			continue;
> +		}
> +
> +		if (run_count != 0 && m->pool != run_pool) {
> +			rte_mbuf_raw_free_bulk(run_pool,
> +					&mbufs[run_start], run_count);
> +			run_count = 0;
> +		}
> +
> +		if (run_count == 0) {
> +			run_pool = m->pool;
> +			run_start = idx;
> +		}
> +
> +		run_count++;
> +		if (run_count == RTE_PKTMBUF_FREE_PENDING_SZ) {
> +			rte_mbuf_raw_free_bulk(run_pool,
> +					&mbufs[run_start], run_count);
> +			run_count = 0;
> +		}
> +	}
> +
> +	if (run_count != 0)
> +		rte_mbuf_raw_free_bulk(run_pool, &mbufs[run_start], run_count);
> +}
> +
>   /* Creates a shallow copy of mbuf */
>   RTE_EXPORT_SYMBOL(rte_pktmbuf_clone)
>   struct rte_mbuf *

