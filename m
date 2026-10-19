Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB19606A319
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 21:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=fKsezjaT
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33F8D40297;
	Mon, 19 Oct 2026 23:27:19 +0200 (CEST)
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net
 [31.44.14.18]) by mails.dpdk.org (Postfix) with ESMTP id 37AB64021E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 23:27:17 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-64.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-64.yp-c.yandex.net)
 by forward502d.mail.yandex.net (postfix) with ESMTPS id 5A07CC009A;
 Tue, 20 Oct 2026 00:27:14 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-64 with ESMTPSA id
 BRhp6LagVqM0-pYGDkeL2; Tue, 20 Oct 2026 00:27:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1792445233; bh=oz5HBMGDGBxZWAzrF1DksQWettMA7PoxqsZnc0tSPQw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=fKsezjaT/VehNM8xFxpkt4+CS2LrG9qCu8EUlP+hZQ5gPa2eBMVeYD0UJAZwj1a3L
 ODfXrvZOQhKJzqRoR9MQ4XkJrZhs2zdSuegEWohy7CjJC91scFKFJEwYRcZauRy8Ps
 z66d5qDJ4RQVXsfwZ47KQruaK9nF4Lhe2wTVsFec=
Authentication-Results: mail-nwsmtp-smtp-production-main-64;
 dkim=pass header.i=@yandex.ru
Message-ID: <52dfdbb3-76a4-4cd4-a789-d864156b949e@yandex.ru>
Date: Mon, 19 Oct 2026 22:27:11 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] bpf: make callback handle atomic with relaxed
 access
To: Marat Khalili <qm2k21@gmail.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org, stephen@networkplumber.org
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261012210917.161343-1-qm2k21@gmail.com>
 <20261012210917.161343-9-qm2k21@gmail.com>
Content-Language: en-US, ru
From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
In-Reply-To: <20261012210917.161343-9-qm2k21@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1




> The callback handle member cb of struct bpf_eth_cbi is concurrently
> cleared by the control plane on unload and read by the datapath to
> decide whether to execute the BPF filter program. Without atomic typing,
> this concurrent access constitutes a data race in the C11 memory model,
Hmm... why is that?
So far, I don't see any.
Can you probably point where you believe is a data-race, and how using 
atomic
load/store can prevent it.

> even though hardware pointer accesses are single-copy atomic and untorn.
>
> Change cb to RTE_ATOMIC and use rte_atomic_load_explicit() and
> rte_atomic_store_explicit() with rte_memory_order_relaxed for all its
> accesses. On modern architectures this produces the exact same machine
> code while eliminating undefined behavior.
>
> In addition, marking cb as atomic improves code self-documentation by
> making it immediately evident that cb is an active part of the cross-
> thread synchronization mechanism on par with use.
>
> Signed-off-by: Marat Khalili <qm2k21@gmail.com>
> ---
>   lib/bpf/bpf_pkt.c | 42 +++++++++++++++++++++++++-----------------
>   1 file changed, 25 insertions(+), 17 deletions(-)
>
> diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
> index c5fa85bf84..0b59ce22f1 100644
> --- a/lib/bpf/bpf_pkt.c
> +++ b/lib/bpf/bpf_pkt.c
> @@ -85,7 +85,7 @@
>   struct __rte_cache_aligned bpf_eth_cbi {
>   	/* used by both data & control path */
>   	RTE_ATOMIC(bool) use;    /* usage flag: true when in use, false otherwise */
> -	const struct rte_eth_rxtx_callback *cb;  /* callback handle */
> +	RTE_ATOMIC(const struct rte_eth_rxtx_callback *) cb;  /* callback handle */
>   	struct rte_bpf *bpf;
>   	struct rte_bpf_jit jit;
>   	/* used by control path only */
> @@ -313,7 +313,7 @@ bpf_rx_callback_vm(__rte_unused uint16_t port, __rte_unused uint16_t queue,
>   	cbi = user_param;
>   
>   	bpf_eth_cbi_inuse(cbi);
> -	rc = (cbi->cb != NULL) ?
> +	rc = (rte_atomic_load_explicit(&cbi->cb, rte_memory_order_relaxed) != NULL) ?
>   		pkt_filter_vm(cbi->bpf, pkt, nb_pkts, 1) :
>   		nb_pkts;
>   	bpf_eth_cbi_unuse(cbi);
> @@ -330,7 +330,7 @@ bpf_rx_callback_jit(__rte_unused uint16_t port, __rte_unused uint16_t queue,
>   
>   	cbi = user_param;
>   	bpf_eth_cbi_inuse(cbi);
> -	rc = (cbi->cb != NULL) ?
> +	rc = (rte_atomic_load_explicit(&cbi->cb, rte_memory_order_relaxed) != NULL) ?
>   		pkt_filter_jit(&cbi->jit, pkt, nb_pkts, 1) :
>   		nb_pkts;
>   	bpf_eth_cbi_unuse(cbi);
> @@ -346,7 +346,7 @@ bpf_tx_callback_vm(__rte_unused uint16_t port, __rte_unused uint16_t queue,
>   
>   	cbi = user_param;
>   	bpf_eth_cbi_inuse(cbi);
> -	rc = (cbi->cb != NULL) ?
> +	rc = (rte_atomic_load_explicit(&cbi->cb, rte_memory_order_relaxed) != NULL) ?
>   		pkt_filter_vm(cbi->bpf, pkt, nb_pkts, 0) :
>   		nb_pkts;
>   	bpf_eth_cbi_unuse(cbi);
> @@ -362,7 +362,7 @@ bpf_tx_callback_jit(__rte_unused uint16_t port, __rte_unused uint16_t queue,
>   
>   	cbi = user_param;
>   	bpf_eth_cbi_inuse(cbi);
> -	rc = (cbi->cb != NULL) ?
> +	rc = (rte_atomic_load_explicit(&cbi->cb, rte_memory_order_relaxed) != NULL) ?
>   		pkt_filter_jit(&cbi->jit, pkt, nb_pkts, 0) :
>   		nb_pkts;
>   	bpf_eth_cbi_unuse(cbi);
> @@ -383,7 +383,7 @@ bpf_rx_callback_mb_vm(__rte_unused uint16_t port, __rte_unused uint16_t queue,
>   
>   	cbi = user_param;
>   	bpf_eth_cbi_inuse(cbi);
> -	rc = (cbi->cb != NULL) ?
> +	rc = (rte_atomic_load_explicit(&cbi->cb, rte_memory_order_relaxed) != NULL) ?
>   		pkt_filter_mb_vm(cbi->bpf, pkt, nb_pkts, 1) :
>   		nb_pkts;
>   	bpf_eth_cbi_unuse(cbi);
> @@ -400,7 +400,7 @@ bpf_rx_callback_mb_jit(__rte_unused uint16_t port, __rte_unused uint16_t queue,
>   
>   	cbi = user_param;
>   	bpf_eth_cbi_inuse(cbi);
> -	rc = (cbi->cb != NULL) ?
> +	rc = (rte_atomic_load_explicit(&cbi->cb, rte_memory_order_relaxed) != NULL) ?
>   		pkt_filter_mb_jit(&cbi->jit, pkt, nb_pkts, 1) :
>   		nb_pkts;
>   	bpf_eth_cbi_unuse(cbi);
> @@ -416,7 +416,7 @@ bpf_tx_callback_mb_vm(__rte_unused uint16_t port, __rte_unused uint16_t queue,
>   
>   	cbi = user_param;
>   	bpf_eth_cbi_inuse(cbi);
> -	rc = (cbi->cb != NULL) ?
> +	rc = (rte_atomic_load_explicit(&cbi->cb, rte_memory_order_relaxed) != NULL) ?
>   		pkt_filter_mb_vm(cbi->bpf, pkt, nb_pkts, 0) :
>   		nb_pkts;
>   	bpf_eth_cbi_unuse(cbi);
> @@ -432,7 +432,7 @@ bpf_tx_callback_mb_jit(__rte_unused uint16_t port, __rte_unused uint16_t queue,
>   
>   	cbi = user_param;
>   	bpf_eth_cbi_inuse(cbi);
> -	rc = (cbi->cb != NULL) ?
> +	rc = (rte_atomic_load_explicit(&cbi->cb, rte_memory_order_relaxed) != NULL) ?
>   		pkt_filter_mb_jit(&cbi->jit, pkt, nb_pkts, 0) :
>   		nb_pkts;
>   	bpf_eth_cbi_unuse(cbi);
> @@ -484,7 +484,7 @@ static void
>   bpf_eth_cbi_unload(struct bpf_eth_cbi *bc)
>   {
>   	/* mark this cbi as empty */
> -	bc->cb = NULL;
> +	rte_atomic_store_explicit(&bc->cb, NULL, rte_memory_order_relaxed);
>   
>   	/* make sure datapath doesn't use bpf anymore, then destroy bpf */
>   	bpf_eth_cbi_wait(bc);
> @@ -495,16 +495,21 @@ bpf_eth_cbi_unload(struct bpf_eth_cbi *bc)
>   static void
>   bpf_eth_unload(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue)
>   {
> +	const struct rte_eth_rxtx_callback *cb;
>   	struct bpf_eth_cbi *bc;
>   
>   	bc = bpf_eth_cbh_find(cbh, port, queue);
> -	if (bc == NULL || bc->cb == NULL)
> +	if (bc == NULL)
> +		return;
> +
> +	cb = rte_atomic_load_explicit(&bc->cb, rte_memory_order_relaxed);
> +	if (cb == NULL)
>   		return;
>   
>   	if (cbh->type == BPF_ETH_RX)
> -		rte_eth_remove_rx_callback(port, queue, bc->cb);
> +		rte_eth_remove_rx_callback(port, queue, cb);
>   	else
> -		rte_eth_remove_tx_callback(port, queue, bc->cb);
> +		rte_eth_remove_tx_callback(port, queue, cb);
>   
>   	bpf_eth_cbi_unload(bc);
>   }
> @@ -581,6 +586,7 @@ bpf_eth_elf_install(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue,
>   	struct rte_bpf *bpf, uint32_t flags)
>   {
>   	int32_t rc;
> +	const struct rte_eth_rxtx_callback *cb;
>   	struct bpf_eth_cbi *bc;
>   	rte_rx_callback_fn frx;
>   	rte_tx_callback_fn ftx;
> @@ -625,18 +631,20 @@ bpf_eth_elf_install(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue,
>   		return -ENOMEM;
>   
>   	/* remove old one, if any */
> -	if (bc->cb != NULL)
> +	if (rte_atomic_load_explicit(&bc->cb, rte_memory_order_relaxed) != NULL)
>   		bpf_eth_unload(cbh, port, queue);
>   
>   	bc->bpf = bpf;
>   	bc->jit = jit;
>   
>   	if (cbh->type == BPF_ETH_RX)
> -		bc->cb = rte_eth_add_rx_callback(port, queue, frx, bc);
> +		cb = rte_eth_add_rx_callback(port, queue, frx, bc);
>   	else
> -		bc->cb = rte_eth_add_tx_callback(port, queue, ftx, bc);
> +		cb = rte_eth_add_tx_callback(port, queue, ftx, bc);
> +
> +	rte_atomic_store_explicit(&bc->cb, cb, rte_memory_order_relaxed);
>   
> -	if (bc->cb == NULL) {
> +	if (cb == NULL) {
>   		rc = -rte_errno;
>   		bpf_eth_cbi_cleanup(bc);
>   	} else

