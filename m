Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088B2C28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 06:08:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13F0440261;
	Fri, 28 Mar 2025 07:08:04 +0100 (CET)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id BE91D4021E
 for <dev@dpdk.org>; Fri, 28 Mar 2025 07:08:02 +0100 (CET)
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id 3A08118111
 for <dev@dpdk.org>; Fri, 28 Mar 2025 07:08:02 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 2BFE417FFF; Fri, 28 Mar 2025 07:08:02 +0100 (CET)
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id 7D9A217FFD;
 Fri, 28 Mar 2025 07:08:00 +0100 (CET)
Message-ID: <d0277a40-c17f-4ebf-99b3-bdb7e9190519@lysator.liu.se>
Date: Fri, 28 Mar 2025 07:07:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] event/eth_tx: prefetch mbuf headers
To: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 dev@dpdk.org
Cc: Naga Harish K S V <s.v.naga.harish.k@intel.com>,
 Jerin Jacob <jerinj@marvell.com>,
 Peter Nilsson <peter.j.nilsson@ericsson.com>
References: <20250328054339.489914-1-mattias.ronnblom@ericsson.com>
Content-Language: en-US
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
In-Reply-To: <20250328054339.489914-1-mattias.ronnblom@ericsson.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

On 2025-03-28 06:43, Mattias Rönnblom wrote:
> Prefetch mbuf headers, resulting in ~10% throughput improvement when
> the Ethernet RX and TX Adapters are hosted on the same core (likely
> ~2x in case a dedicated TX core is used).
> 
> Signed-off-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
> Tested-by: Peter Nilsson <peter.j.nilsson@ericsson.com>

What should be added is that what's been tested is the 
non-RTE_EVENT_TYPE_VECTOR case.

> ---
>   lib/eventdev/rte_event_eth_tx_adapter.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/lib/eventdev/rte_event_eth_tx_adapter.c b/lib/eventdev/rte_event_eth_tx_adapter.c
> index 67fff8b7d6..d740ae00f9 100644
> --- a/lib/eventdev/rte_event_eth_tx_adapter.c
> +++ b/lib/eventdev/rte_event_eth_tx_adapter.c
> @@ -598,6 +598,12 @@ txa_process_event_vector(struct txa_service_data *txa,
>   	return nb_tx;
>   }
>   
> +static inline void
> +txa_prefetch_mbuf(struct rte_mbuf *mbuf)
> +{
> +	rte_mbuf_prefetch_part1(mbuf);
> +}
> +
>   static void
>   txa_service_tx(struct txa_service_data *txa, struct rte_event *ev,
>   	uint32_t n)
> @@ -608,6 +614,20 @@ txa_service_tx(struct txa_service_data *txa, struct rte_event *ev,
>   
>   	stats = &txa->stats;
>   
> +	for (i = 0; i < n; i++) {
> +		struct rte_event *event = &ev[i];
> +
> +		if (unlikely(event->event_type & RTE_EVENT_TYPE_VECTOR)) {
> +			struct rte_event_vector *vec = event->vec;
> +			struct rte_mbuf **mbufs = vec->mbufs;
> +			uint32_t k;
> +
> +			for (k = 0; k < vec->nb_elem; k++)
> +				txa_prefetch_mbuf(mbufs[k]);
> +		} else
> +			txa_prefetch_mbuf(event->mbuf);
> +	}
> +
>   	nb_tx = 0;
>   	for (i = 0; i < n; i++) {
>   		uint16_t port;

