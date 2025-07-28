Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3317BC87FC9
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 13:51:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 100254029A;
	Mon, 28 Jul 2025 15:51:25 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 24DD740297
 for <dev@dpdk.org>; Mon, 28 Jul 2025 15:51:24 +0200 (CEST)
Received: from debian (unknown [78.109.65.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 73812E057F;
 Mon, 28 Jul 2025 17:51:22 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 73812E057F
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1753710683;
 bh=r/7Jth75YzpN3kM4lrfwt/nb9OaepmPQy9T4HlROq5s=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=779TW2mqw3M/aBUkl5TI42t/Vp8RpPc3Id2OcFXt6E5WLdljcWQCPLwlkFSpF2YMg
 b17MhslGc2IGU6wHftJfuWxF6v93PtDXabmrZk3/9KMM61kiXanBPq/Kql4li2cQDq
 ByM0SQxOgLAZTNJEPhcfaRYofIQJ6g2RM9zsqFtaOtEsmUWShqZxJjtSCOqhSvimY0
 axjf3pzbrZIfI7Nk9jLrB9rTkuLSmYFwFSYl6NVS4NxbTG1fKCP+uNIVX2yLpkdBxF
 5qxfsHhrEB7U4puHlKMBhV5Z0r/q4a594SQRUKadrZ16hbq1gjf/bb7lRPLUOCTK7X
 nKhGBC5qWsLdA==
Date: Mon, 28 Jul 2025 17:51:21 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: =?ISO-8859-15?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
cc: dev@dpdk.org, Tetsuya Mukawa <mtetsuyah@gmail.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 Vipin Varghese <Vipin.Varghese@amd.com>, 
 Thiyagarjan P <Thiyagarajan.P@amd.com>
Subject: RE: [PATCH v2] net/null: Add fast mbuf release TX offload
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FDCC@smartserver.smartshare.dk>
Message-ID: <a6af581e-5b71-268e-b065-e12e11543b3f@arknetworks.am>
References: <20250624181416.167181-1-mb@smartsharesystems.com>
 <20250726044827.569456-1-mb@smartsharesystems.com>
 <b0cd9f5d-91d2-62e5-6a14-f567395c21b5@arknetworks.am>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDCC@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1395191632-1753710682=:9077"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1395191632-1753710682=:9077
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

Hi Morten,

On Mon, 28 Jul 2025, Morten Brørup wrote:

>> From: Ivan Malov [mailto:ivan.malov@arknetworks.am]
>> Sent: Saturday, 26 July 2025 08.15
>>
>> Hi Morten,
>>
>> Good patch. Please see below.
>>
>> On Sat, 26 Jul 2025, Morten Brørup wrote:
>>
>>> Added fast mbuf release, re-using the existing mbuf pool pointer
>>> in the queue structure.
>>>
>>> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
>>> ---
>>> v2:
>>> * Also announce the offload as a per-queue capability.
>>> * Added missing test of per-device offload configuration when
>> configuring
>>>  the queue.
>>> ---
>>> drivers/net/null/rte_eth_null.c | 33 ++++++++++++++++++++++++++++++---
>>> 1 file changed, 30 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/null/rte_eth_null.c
>> b/drivers/net/null/rte_eth_null.c
>>> index 8a9b74a03b..09cfc74494 100644
>>> --- a/drivers/net/null/rte_eth_null.c
>>> +++ b/drivers/net/null/rte_eth_null.c
>>> @@ -34,6 +34,17 @@ struct pmd_internals;
>>> struct null_queue {
>>> 	struct pmd_internals *internals;
>>>
>>> +	/**
>>> +	 * For RX queue:
>>> +	 *  Mempool to allocate mbufs from.
>>> +	 *
>>> +	 * For TX queue:
>>
>> Perhaps spell it 'Rx', 'Tx', but this is up to you.
>
> I just checked, and it seems all three spellings "rx", "Rx" and "RX" are being used in DPDK.
> I personally prefer RX, so I'll keep that.
>
>>
>>> +	 *  Mempool to free mbufs to, if fast release of mbufs is enabled.
>>> +	 *  UINTPTR_MAX if the mempool for fast release of mbufs has not
>> yet been detected.
>>> +	 *  NULL if fast release of mbufs is not enabled.
>>> +	 *
>>> +	 *  @see RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE
>>> +	 */
>>
>> May be it would be better to have a separate 'tx_pkt_burst' callback, to
>> avoid
>> conditional checks below. Though, I understand this will downgrade the
>> per-queue
>> capability to the per-port only, so feel free to disregard this point.
>
> I considered this, and I can imagine an application using FAST_FREE for its primary queues, and normal free for some secondary queues.
> Looking at other drivers - which have implemented a runtime check, not separate callbacks for FAST_FREE - I guess they came to the same conclusion.
>
>>
>>> 	struct rte_mempool *mb_pool;
>>> 	void *dummy_packet;
>>>
>>> @@ -151,7 +162,16 @@ eth_null_tx(void *q, struct rte_mbuf **bufs,
>> uint16_t nb_bufs)
>>> 	for (i = 0; i < nb_bufs; i++)
>>> 		bytes += rte_pktmbuf_pkt_len(bufs[i]);
>>>
>>> -	rte_pktmbuf_free_bulk(bufs, nb_bufs);
>>> +	if (h->mb_pool != NULL) { /* RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE */
>>> +		if (unlikely(h->mb_pool == (void *)UINTPTR_MAX)) {
>>> +			if (unlikely(nb_bufs == 0))
>>> +				return 0; /* Do not dereference uninitialized
>> bufs[0]. */
>>> +			h->mb_pool = bufs[0]->pool;
>>> +		}
>>> +		rte_mbuf_raw_free_bulk(h->mb_pool, bufs, nb_bufs);
>>> +	} else {
>>> +		rte_pktmbuf_free_bulk(bufs, nb_bufs);
>>> +	}
>>> 	rte_atomic_fetch_add_explicit(&h->tx_pkts, nb_bufs,
>> rte_memory_order_relaxed);
>>> 	rte_atomic_fetch_add_explicit(&h->tx_bytes, bytes,
>> rte_memory_order_relaxed);
>>>
>>> @@ -259,7 +279,7 @@ static int
>>> eth_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
>>> 		uint16_t nb_tx_desc __rte_unused,
>>> 		unsigned int socket_id __rte_unused,
>>> -		const struct rte_eth_txconf *tx_conf __rte_unused)
>>> +		const struct rte_eth_txconf *tx_conf)
>>> {
>>> 	struct rte_mbuf *dummy_packet;
>>> 	struct pmd_internals *internals;
>>> @@ -284,6 +304,10 @@ eth_tx_queue_setup(struct rte_eth_dev *dev,
>> uint16_t tx_queue_id,
>>>
>>> 	internals->tx_null_queues[tx_queue_id].internals = internals;
>>> 	internals->tx_null_queues[tx_queue_id].dummy_packet =
>> dummy_packet;
>>> +	internals->tx_null_queues[tx_queue_id].mb_pool =
>>> +			(dev->data->dev_conf.txmode.offloads | tx_conf-
>>> offloads) &
>>> +			RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE ?
>>> +			(void *)UINTPTR_MAX : NULL;
>>
>> Given the fact that FAST_FREE and MULTI_SEGS are effectively
>> conflicting,
>> wouldn't it be better to have a check for the presence of both flags
>> here? I'm
>> not sure whether this is already checked at the generic layer above the
>> PMD.
>
> Interesting thought - got me looking deeper into this.
>
> It seems MULTI_SEGS is primarily a capability flag.
> The description of the MULTI_SEGS flag [1] could be interpreted that way too:
> /** Device supports multi segment send. */
>
> [1]: https://elixir.bootlin.com/dpdk/v25.07/source/lib/ethdev/rte_ethdev.h#L1614
>
> E.g. the i40e driver offers MULTI_SEGS capability per-device, but not per-queue. And it doesn't use the MULTI_SEGS flag for any purpose (beyond capability reporting).
>
> Furthermore, enabling MULTI_SEGS on TX (per device or per queue) wouldn't mean that all transmitted packets are segmented; it only means that the driver must be able to handle segmented packets.
> I.e. MULTI_SEGS could be enabled on a device, and yet it would be acceptable to enable FAST_FREE on a queue on that device.

Yes, you are correct and I apologise. It's capability, not the requestor bit.

Thank you.

>
>>
>> Thank you.
>
> Thank you for reviewing.
>
>>
>>>
>>> 	return 0;
>>> }
>>> @@ -309,7 +333,10 @@ eth_dev_info(struct rte_eth_dev *dev,
>>> 	dev_info->max_rx_queues = RTE_DIM(internals->rx_null_queues);
>>> 	dev_info->max_tx_queues = RTE_DIM(internals->tx_null_queues);
>>> 	dev_info->min_rx_bufsize = 0;
>>> -	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
>> RTE_ETH_TX_OFFLOAD_MT_LOCKFREE;
>>> +	dev_info->tx_queue_offload_capa =
>> RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;
>>> +	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
>>> +			RTE_ETH_TX_OFFLOAD_MT_LOCKFREE |
>>> +			dev_info->tx_queue_offload_capa;
>>>
>>> 	dev_info->reta_size = internals->reta_size;
>>> 	dev_info->flow_type_rss_offloads = internals-
>>> flow_type_rss_offloads;
>>> --
>>> 2.43.0
>>>
>>>
>
--8323328-1395191632-1753710682=:9077--
