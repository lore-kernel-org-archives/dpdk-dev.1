Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80059606A320
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 20:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=lHTfvawf
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C823840297;
	Mon, 19 Oct 2026 22:44:34 +0200 (CEST)
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net
 [31.44.14.16]) by mails.dpdk.org (Postfix) with ESMTP id 65C394021E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 22:44:32 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-21.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-21.yp-c.yandex.net)
 by forward500d.mail.yandex.net (postfix) with ESMTPS id 192298074E;
 Mon, 19 Oct 2026 23:44:31 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-21 with ESMTPSA id
 SigdN9adY0U0-GjoqeijZ; Mon, 19 Oct 2026 23:44:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1792442670; bh=MXeNNTwH21n00vA0WrFVde8H5zmRJhYf9mT7CQZxUDY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=lHTfvawf3HpjTwA49KaeLlgxzia5o/63v91MpbopqYmUQimWZfxdyTTpGsfgM3TO1
 ESju5UrFm0ezAq0EBAjvnieq/jv+blfDjbctzDeEr31B9qvJKy1dDspDhijRM2e7W2
 Kmr/0Xn/epgwwd9Nwt4zPL+Qh+UDi8pBxE6XSLNs=
Authentication-Results: mail-nwsmtp-smtp-production-main-21;
 dkim=pass header.i=@yandex.ru
Message-ID: <530fc92a-d723-4464-9296-d8b2207186ed@yandex.ru>
Date: Mon, 19 Oct 2026 21:44:26 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] bpf: document packet callback unload sequence
To: Marat Khalili <qm2k21@gmail.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org, stephen@networkplumber.org
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261012210917.161343-1-qm2k21@gmail.com>
 <20261012210917.161343-2-qm2k21@gmail.com>
Content-Language: en-US, ru
From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
In-Reply-To: <20261012210917.161343-2-qm2k21@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



> Add a detailed comment with the sequence diagram to bpf_pkt.c describing
> the current de-facto synchronization protocol on BPF program unload
> between the control plane and the data plane.
>
> Signed-off-by: Marat Khalili <qm2k21@gmail.com>
> ---
>   lib/bpf/bpf_pkt.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 64 insertions(+), 1 deletion(-)
>
> diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
> index f072fdaaed..4223ef624e 100644
> --- a/lib/bpf/bpf_pkt.c
> +++ b/lib/bpf/bpf_pkt.c
> @@ -21,9 +21,72 @@
>   #include "bpf_impl.h"
>   
>   /*
> - * information about installed BPF rx/tx callback
> + * CP-DP synchronization mechanism
> + *
> + * After the callback is installed to a port/queue, removing it safely is a non-trivial task.
> + * The `rte_bpf` object can only be destroyed while the callback is not being executed,
> + * while the number of synchronization calls in the packet callback must be minimized.
> + *
> + * APIs `rte_eth_remove_rx_callback` and `rte_eth_remove_tx_callback` remove the callback from
> + * the callback list and upon return guarantee that it will not be called again,
> + * but not that any existing invocation of the callback has completed.
> + *
> + * Current synchronization mechanism relies on the following per-port/queue entities:
> + * 1. List of installed port/queue callbacks ("cbs" on the diagram);
> + * 2. Member `cb` of struct `bpf_eth_cbi`;
> + * 3. Member `use` of struct `bpf_eth_cbi`;
> + *
> + * BPF program is only executed if the first two are set, and increments `use` at the start and
> + * end of the callback execution so that in the safe state its value is even.
> + * This relies on only one thread calling the per-port/queue callback at a time.
> + *
> + * Unload processing starts with clearing the first two entities,
> + * then waits for `use` to become even before destroying the BPF program.

That's not entirely correct.
As I said before, it is sort of hand-made RCU.
So first it checks if there is active users:
  if ((puse & BPF_ETH_CBI_INUSE) != 0) {
then, if so, it waits till active user ends its 'current quiescent' period:
RTE_WAIT_UNTIL_MASKED((__rte_atomic uint32_t *)(uintptr_t)&cbi->use,
                         UINT32_MAX, !=, puse, rte_memory_order_acquire);

Note that 'cbi->use' can be odd, as long as its value is not equal to 
puse, i.e.
quiecent period had changed.

> + * The whole operation is protected by a control-plane-only spinlock (not shown on the diagram).
> + *
> + * Typical sequence of synchronization actions between CP and DP on unload is shown below:
> + * ```
> + *   +----+                +-----+         +-----+        +----+         +-----+          +----+
> + *   | CP |                | cbs |         | use |        | cb |         | bpf |          | DP |
> + *   +----+                +-----+         +-----+        +----+         +-----+          +----+
> + *     |                      |               |              |              |                |
> + *     |                      |<---------------------- fetch callback -----------------------|
> + *     |                      |               |              |              |                |
> + *     |                      |               |<------------- increment to odd --------------|
> + *     |                      |               |              |              |                |
> + *     |-- remove callback -->|               |              |              |       rte_smp_mb()
> + *     |                      |               |              |              |                |
> + *     |                      |               |              |<------ fetch non-NULL --------|
> + *     |                      |               |              |              |                |
> + *     |------------------- store NULL --------------------->|              |                |
> + *     |                      |               |              |              |                |
> + *   rte_smp_mb()             |               |              |              |                |
> + *     |                      |               |              |              |                |
> + *   rte_smp_mb()             |               |              |              |                |
> + *     |                      |               |              |              |                |
> + *     +-if use is odd        |               |              |              | if cb not NULL-+
> + *     | |                    |               |              |              |              | |
> + *     | +------------ fetch odd ------------>|              |              |<-- execute --+ |
> + *     | |                    |               |              |              |  BPF program | |
> + *     | +-while use is same  |               |              |              |              +-+
> + *     | | |                  |               |              |              |                |
> + *     | | +---------- fetch odd ------------>|              |              |      rte_smp_rmb()
> + *     | | |                  |               |              |              |                |
> + *     +-+-+                  |               |<------------- increment to even -------------|
> + *     |                      |               |              |              |                |
> + *     |------------- fetch even ------------>|              |              |                |
> + *     |                      |               |              |              |                |
> + *     |----------------- destroy BPF program and cleanup ----------------->|                |
> + *     |                      |               |              |              |                |
> + *   +----+                +-----+         +-----+        +----+         +-----+          +----+
> + *   | CP |                | cbs |         | use |        | cb |         | bpf |          | DP |
> + *   +----+                +-----+         +-----+        +----+         +-----+          +----+
> + * ```
>    */
>   
> +/*
> + * information about installed BPF rx/tx callback
> + */
>   struct __rte_cache_aligned bpf_eth_cbi {
>   	/* used by both data & control path */
>   	RTE_ATOMIC(uint32_t) use;    /*usage counter */

