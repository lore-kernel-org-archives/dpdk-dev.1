Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8902260A2606
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=qqF7etv7
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8496D40297;
	Mon, 19 Oct 2026 22:51:04 +0200 (CEST)
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net
 [31.44.14.18]) by mails.dpdk.org (Postfix) with ESMTP id C0D414021E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 22:51:03 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-34.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-34.yp-c.yandex.net)
 by forward502d.mail.yandex.net (postfix) with ESMTPS id 84050C0114;
 Mon, 19 Oct 2026 23:51:01 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-34 with ESMTPSA id
 wogLuHadKqM0-QSWN9EY1; Mon, 19 Oct 2026 23:51:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1792443061; bh=74pT3+BFyZ8pxUvKYKnklLAQfzAEGdlXGRn8ritWCW0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=qqF7etv7vdGYB03TRD6rSliQdYaYhB83j6/llDnPFexhvsG6CHKSWtGpn5fEOF0Pj
 CP9klPgX/XRmbdH6diCo0nkaGx9WwHMzGnDqmNB8hRYQ83bd5CuYviE/1czJZK0k/t
 em48GYB57j26odak3A84XJn5m+AVzlTjAMWTvEWY=
Authentication-Results: mail-nwsmtp-smtp-production-main-34;
 dkim=pass header.i=@yandex.ru
Message-ID: <8f751b5c-941e-467f-b4d8-6d65e2b0db5b@yandex.ru>
Date: Mon, 19 Oct 2026 21:50:58 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] bpf: simplify callback inuse tracking to boolean
 flag
To: Marat Khalili <qm2k21@gmail.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org, stephen@networkplumber.org
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261012210917.161343-1-qm2k21@gmail.com>
 <20261012210917.161343-6-qm2k21@gmail.com>
Content-Language: en-US, ru
From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
In-Reply-To: <20261012210917.161343-6-qm2k21@gmail.com>
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




> The even/odd usage counter semantics in struct bpf_eth_cbi was
> originally used to detect when in-flight packet callbacks complete.
> However, with at most one thread running the callback per port/queue
> pair and no risk of the ABA problem, a boolean flag (true for in use,
> false for idle) suffices.
>
> Change member use to bool and replace the counter increment in the
> datapath with stores of true and false. Simplify bpf_eth_cbi_wait()
> to a direct pause loop waiting until the flag is false, removing the
> now unnecessary RTE_WAIT_UNTIL_MASKED macro and casts. Update the
> documentation and synchronization sequence diagram accordingly.

As I explained in previous mail, it is not about even/odd.
It is about waiting while current 'quiscent' period will end.
By 'simplifying' that to use just boll values (0/1) you introduce
a live-lock in CP: it can be blocked for very long time waiting
while DP thread will keep processing packets.
So mu vote is: NACK.

As I said before - probably the best option to improving current BPF CB 
mechanism,
would be to make ethedev CB to obey RCU-like behavior.
Konstantin


>
> Signed-off-by: Marat Khalili <qm2k21@gmail.com>
> ---
>   lib/bpf/bpf_pkt.c | 49 ++++++++++++++++++-----------------------------
>   1 file changed, 19 insertions(+), 30 deletions(-)
>
> diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
> index b1e25e4e7c..429feb76ad 100644
> --- a/lib/bpf/bpf_pkt.c
> +++ b/lib/bpf/bpf_pkt.c
> @@ -6,6 +6,7 @@
>   #include <string.h>
>   #include <errno.h>
>   #include <stdint.h>
> +#include <stdbool.h>
>   
>   #include <sys/queue.h>
>   
> @@ -36,12 +37,12 @@
>    * 2. Member `cb` of struct `bpf_eth_cbi`;
>    * 3. Member `use` of struct `bpf_eth_cbi`;
>    *
> - * BPF program is only executed if the first two are set, and increments `use` at the start and
> - * end of the callback execution so that in the safe state its value is even.
> + * BPF program is only executed if the first two are set, and sets `use` to true at the start and
> + * to false at the end of the callback execution.
>    * This relies on only one thread calling the per-port/queue callback at a time.
>    *
>    * Unload processing starts with clearing the first two entities,
> - * then waits for `use` to become even before destroying the BPF program.
> + * then waits for `use` to become false before destroying the BPF program.
>    * The whole operation is protected by a control-plane-only spinlock (not shown on the diagram).
>    *
>    * Typical sequence of synchronization actions between CP and DP on unload is shown below:
> @@ -52,7 +53,7 @@
>    *     |                      |               |              |              |                |
>    *     |                      |<---------------------- fetch callback -----------------------|
>    *     |                      |               |              |              |                |
> - *     |                      |               |<------------- increment to odd --------------|
> + *     |                      |               |<------------ store true ---------------------|
>    *     |                      |               |              |              |                |
>    *     |-- remove callback -->|               |              |              |       rte_smp_mb()
>    *     |                      |               |              |              |                |
> @@ -62,17 +63,17 @@
>    *     |                      |               |              |              |                |
>    *   rte_smp_mb()             |               |              |              |                |
>    *     |                      |               |              |              |                |
> - *     +-if use is odd        |               |              |              | if cb not NULL-+
> + *     +-while use is true    |               |              |              | if cb not NULL-+
>    *     | |                    |               |              |              |              | |
> - *     | +------------ fetch odd ------------>|              |              |<-- execute --+ |
> + *     | +----------- fetch true ------------>|              |              |<-- execute --+ |
>    *     | |                    |               |              |              |  BPF program | |
> - *     | +-while use is same  |               |              |              |              +-+
> - *     | | |                  |               |              |              |                |
> - *     | | +---------- fetch odd ------------>|              |              |      rte_smp_rmb()
> - *     | | |                  |               |              |              |                |
> - *     +-+-+                  |               |<------------- increment to even -------------|
> + *     | |                    |               |              |              |              +-+
> + *     | |                    |               |              |              |                |
> + *     | |                    |               |              |              |      rte_smp_rmb()
> + *     | |                    |               |              |              |                |
> + *     +-+                    |               |<------------ store false --------------------|
>    *     |                      |               |              |              |                |
> - *     |------------- fetch even ------------>|              |              |                |
> + *     |------------ fetch false ------------>|              |              |                |
>    *     |                      |               |              |              |                |
>    *     |----------------- destroy BPF program and cleanup ----------------->|                |
>    *     |                      |               |              |              |                |
> @@ -87,7 +88,7 @@
>    */
>   struct __rte_cache_aligned bpf_eth_cbi {
>   	/* used by both data & control path */
> -	RTE_ATOMIC(uint32_t) use;    /*usage counter */
> +	RTE_ATOMIC(bool) use;    /* usage flag: true when in use, false otherwise */
>   	const struct rte_eth_rxtx_callback *cb;  /* callback handle */
>   	struct rte_bpf *bpf;
>   	struct rte_bpf_jit jit;
> @@ -97,12 +98,6 @@ struct __rte_cache_aligned bpf_eth_cbi {
>   	uint16_t queue;
>   };
>   
> -/*
> - * Odd number means that callback is used by datapath.
> - * Even number means that callback is not used by datapath.
> - */
> -#define BPF_ETH_CBI_INUSE  1
> -
>   /*
>    * List to manage RX/TX installed callbacks.
>    */
> @@ -141,20 +136,20 @@ static struct bpf_eth_cbh tx_cbh = {
>   static __rte_always_inline void
>   bpf_eth_cbi_inuse(struct bpf_eth_cbi *cbi)
>   {
> -	cbi->use++;
> +	cbi->use = true;
>   	/* make sure no store/load reordering could happen */
>   	rte_smp_mb();
>   }
>   
>   /*
> - * Marks given callback list as not used by datapath.
> + * Marks given callback as not used by datapath.
>    */
>   static __rte_always_inline void
>   bpf_eth_cbi_unuse(struct bpf_eth_cbi *cbi)
>   {
>   	/* make sure all previous loads are completed */
>   	rte_smp_rmb();
> -	cbi->use++;
> +	cbi->use = false;
>   }
>   
>   /*
> @@ -163,18 +158,12 @@ bpf_eth_cbi_unuse(struct bpf_eth_cbi *cbi)
>   static void
>   bpf_eth_cbi_wait(const struct bpf_eth_cbi *cbi)
>   {
> -	uint32_t puse;
> -
>   	/* make sure all previous loads and stores are completed */
>   	rte_smp_mb();
>   
> -	puse = cbi->use;
> -
>   	/* in use, busy wait till current RX/TX iteration is finished */
> -	if ((puse & BPF_ETH_CBI_INUSE) != 0) {
> -		RTE_WAIT_UNTIL_MASKED((__rte_atomic uint32_t *)(uintptr_t)&cbi->use,
> -			UINT32_MAX, !=, puse, rte_memory_order_relaxed);
> -	}
> +	while (cbi->use)
> +		rte_pause();
>   }
>   
>   static void

