Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A3CD3CCA1
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 08:28:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA95E4067C;
	Thu, 15 Jan 2026 09:28:02 +0100 (CET)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id 46E0D4003C;
 Thu, 15 Jan 2026 09:28:01 +0100 (CET)
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id AB749CC1A;
 Thu, 15 Jan 2026 09:28:00 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 9EA76CC19; Thu, 15 Jan 2026 09:28:00 +0100 (CET)
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id D0C6ECC18;
 Thu, 15 Jan 2026 09:27:58 +0100 (CET)
Message-ID: <0885d2dc-7287-4f4c-a887-0e1dc855d2bc@lysator.liu.se>
Date: Thu, 15 Jan 2026 09:27:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/31] eventdev: fix variable shadowing issues
To: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
Cc: stable@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, Nikhil Rao <nikhil.rao@intel.com>,
 Jay Jayatheerthan <jay.jayatheerthan@intel.com>,
 =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20260114154450.2969716-1-bruce.richardson@intel.com>
 <20260114154450.2969716-5-bruce.richardson@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
In-Reply-To: <20260114154450.2969716-5-bruce.richardson@intel.com>
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

On 1/14/26 16:44, Bruce Richardson wrote:
> Rename a macro variable to avoid shadowing conflicts, and reduce the
> scope of another variable for the same reason.
> 
> Fixes: a3bbf2e09756 ("eventdev: add eth Tx adapter implementation")
> Fixes: 7f33abd49b26 ("eventdev/eth_rx: support appropriately report idle")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>   lib/eventdev/rte_event_eth_rx_adapter.c | 5 ++---
>   lib/eventdev/rte_event_eth_tx_adapter.c | 8 ++++----
>   2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/eventdev/rte_event_eth_rx_adapter.c b/lib/eventdev/rte_event_eth_rx_adapter.c
> index 994f256322..d564e14b72 100644
> --- a/lib/eventdev/rte_event_eth_rx_adapter.c
> +++ b/lib/eventdev/rte_event_eth_rx_adapter.c
> @@ -1191,7 +1191,6 @@ rxa_intr_thread(void *arg)
>   static inline bool
>   rxa_intr_ring_dequeue(struct event_eth_rx_adapter *rx_adapter)
>   {
> -	uint32_t n;
>   	uint32_t nb_rx = 0;
>   	int rxq_empty;
>   	struct eth_event_enqueue_buffer *buf;
> @@ -1260,9 +1259,9 @@ rxa_intr_ring_dequeue(struct event_eth_rx_adapter *rx_adapter)
>   		if (rxa_shared_intr(dev_info, queue)) {
>   			uint16_t i;
>   			uint16_t nb_queues;
> +			uint32_t n = 0;
>   
>   			nb_queues = dev_info->dev->data->nb_rx_queues;
> -			n = 0;
>   			for (i = dev_info->next_q_idx; i < nb_queues; i++) {
>   				uint8_t enq_buffer_full;
>   
> @@ -1289,7 +1288,7 @@ rxa_intr_ring_dequeue(struct event_eth_rx_adapter *rx_adapter)
>   						RTE_MAX_RXTX_INTR_VEC_ID - 1 :
>   						0;
>   		} else {
> -			n = rxa_eth_rx(rx_adapter, port, queue, nb_rx,
> +			uint32_t n = rxa_eth_rx(rx_adapter, port, queue, nb_rx,

Split 'n' definition and the function call.

With or without that fix,
Reviewed-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>

>   				rx_adapter->max_nb_rx,
>   				&rxq_empty, buf, stats);
>   			rx_adapter->qd_valid = !rxq_empty;
> diff --git a/lib/eventdev/rte_event_eth_tx_adapter.c b/lib/eventdev/rte_event_eth_tx_adapter.c
> index 83b6af0955..91c7be55c7 100644
> --- a/lib/eventdev/rte_event_eth_tx_adapter.c
> +++ b/lib/eventdev/rte_event_eth_tx_adapter.c
> @@ -64,11 +64,11 @@ do { \
>   
>   #define TXA_CHECK_OR_ERR_RET(id) \
>   do {\
> -	int ret; \
> +	int _ret; \
>   	RTE_EVENT_ETH_TX_ADAPTER_ID_VALID_OR_ERR_RET((id), -EINVAL); \
> -	ret = txa_init(); \
> -	if (ret != 0) \
> -		return ret; \
> +	_ret = txa_init(); \
> +	if (_ret != 0) \
> +		return _ret; \
>   	if (!txa_adapter_exist((id))) \
>   		return -EINVAL; \
>   } while (0)

