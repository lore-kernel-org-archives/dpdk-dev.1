Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406B9CCFA13
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 09:02:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 811D9400D6;
	Mon, 10 Nov 2025 10:02:19 +0100 (CET)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 2FEEF400D5
 for <dev@dpdk.org>; Mon, 10 Nov 2025 10:02:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru C7A7488
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1762765337;
 bh=8XZTQ3m4kAnEKsE9jkiBejEE/3b+KSw/zyRXa0PpMKU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=J8e55CsknGEm7gYiP9llaGP8IRDFcwCSkWAVtKN+C9esT+2nzSj9jYbDSgkGa/JgH
 5lsyAtMW9PrNiKmiLyB5Qx0cyKI/eAYMAXOmzOI+0WIzhJg89YDi0iu0JgexQCyk8W
 leFuVs6yWWgsoC9OcwASIH5imuspBGHdKMB1aTCg=
Received: from [192.168.1.42] (unknown [188.170.87.245])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id C7A7488;
 Mon, 10 Nov 2025 12:02:16 +0300 (MSK)
Message-ID: <1fd7889d-9187-4bf6-b7c0-863783bfc7ed@oktetlabs.ru>
Date: Mon, 10 Nov 2025 12:02:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] ethdev: fix UAF in rte_eth_tx_burst with filtering
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: bruce.richardson@intel.com, Thomas Monjalon <thomas@monjalon.net>,
 John McNamara <john.mcnamara@intel.com>
References: <20251029235400.1486861-1-stephen@networkplumber.org>
 <11bf07b2-30fe-4935-a43c-fe64a37cc0b4@oktetlabs.ru>
 <98CBD80474FA8B44BF855DF32C47DC35F65544@smartserver.smartshare.dk>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65544@smartserver.smartshare.dk>
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

On 11/10/25 11:34, Morten Brørup wrote:
> +TO: Konstantin, regarding Stage Ordered Ring.
> 
>> From: Andrew Rybchenko [mailto:andrew.rybchenko@oktetlabs.ru]
>> Sent: Sunday, 9 November 2025 16.23
>>
>> If I remember correctly we should avoid function names in summary.
>>
>> (I'm really surprised that callbacks and rte_eth_tx_burst() are
>> supposed to reorder mbufs in tx_pkts array, but it looks like it
>> the only sensible option.)
> 
> Reordering the packets is incompatible with the Stage Ordered Ring.
> When the transmit function returns e.g. 2 non-consumed packets, the metadata will be associated with the 2 last packets in the original burst passed to the transmit function, not the 2 packets moved to the last position in the array.

Good point.

> 
>>
>> On 10/30/25 02:54, Stephen Hemminger wrote:
>>> When packets are filtered by Tx callback, they return value
>>> needs to include those packets; otherwise the application will
>>> do a duplicate free of those mbufs.
>>>
>>> The example would be application that sent a burst of 8 packets,
>>> and 2 were filtered but the PMD was busy and could not send any.
>>> The result should be a return value of 2 and mbufs 0..1 should
>>> be freed and 2..7 should be untouched and up to application to
>>> resend or drop.
>>>
>>> Original buggy code would return 0 and 0..1 would be freed
>>> 2..7 would be unused. Application would then try and drop
>>> or resend an already freed mbuf.
>>>
>>> Bugzilla ID: 1816
>>> Fixes: 4dc294158cac ("ethdev: support optional Rx and Tx callbacks")
>>> Cc: bruce.richardson@intel.com
>>> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
>>> ---
>>>    lib/ethdev/rte_ethdev.h | 47 ++++++++++++++++++++++++++++++--------
>> ---
>>>    1 file changed, 35 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
>>> index a66c2abbdb..d2cfe390f9 100644
>>> --- a/lib/ethdev/rte_ethdev.h
>>> +++ b/lib/ethdev/rte_ethdev.h
>>> @@ -6714,6 +6714,10 @@ rte_eth_tx_burst(uint16_t port_id, uint16_t
>> queue_id,
>>>    	}
>>>    #endif
>>>
>>> +	uint16_t requested_pkts = nb_pkts;
>>> +	uint16_t filtered_pkts = 0;
>>> +	rte_mbuf_history_mark_bulk(tx_pkts, nb_pkts,
>> RTE_MBUF_HISTORY_OP_TX);
>>> +
>>>    #ifdef RTE_ETHDEV_RXTX_CALLBACKS
>>>    	{
>>>    		void *cb;
>>> @@ -6727,22 +6731,41 @@ rte_eth_tx_burst(uint16_t port_id, uint16_t
>> queue_id,
>>>    		cb = rte_atomic_load_explicit(&p->txq.clbk[queue_id],
>>>    				rte_memory_order_relaxed);
>>>    		if (unlikely(cb != NULL))
>>> -			nb_pkts = rte_eth_call_tx_callbacks(port_id,
>> queue_id,
>>> -					tx_pkts, nb_pkts, cb);
>>> +			filtered_pkts = nb_pkts -
>>> +				rte_eth_call_tx_callbacks(port_id, queue_id,
>> tx_pkts, nb_pkts, cb);
>>>    	}
>>>    #endif
>>>
>>> -	uint16_t requested_pkts = nb_pkts;
>>> -	rte_mbuf_history_mark_bulk(tx_pkts, nb_pkts,
>> RTE_MBUF_HISTORY_OP_TX);
>>> -
>>> -	nb_pkts = p->tx_pkt_burst(qd, tx_pkts, nb_pkts);
>>> -
>>> -	if (requested_pkts > nb_pkts)
>>> -		rte_mbuf_history_mark_bulk(tx_pkts + nb_pkts,
>>> -				requested_pkts - nb_pkts,
>> RTE_MBUF_HISTORY_OP_TX_BUSY);
>>> +	uint16_t sent_pkts = p->tx_pkt_burst(qd, tx_pkts, nb_pkts -
>> filtered_pkts);
>>> +	uint16_t result_pkts = sent_pkts + filtered_pkts;
>>> +
>>> +	if (unlikely(result_pkts < requested_pkts)) {
>>
>> First of all unlikely() is wrong here. It is not an error path. It is
>> OK
>> when not everything is sent and it should not cost too much as unlikely
>> does.
>> Second, I'd remove the condition completely. It is not a big deal to
>> calculate unsent_pkts and call trace (if enabled) with zero
>> unsent_pkts.
>>
>>> +		uint16_t unsent_pkts = requested_pkts - result_pkts;
>>> +
>>> +		if (unlikely(filtered_pkts > 0)) {
>>
>> Same here for unlikely().
>> Also since filtered_pkts appear in RTE_ETHDEV_RXTX_CALLBACKS case,
>> I'd put it under corresponding conditional compilation to be
>> consistent.
>> Yes, code with conditional compilation is hard to read, but consistency
>> is more important here.
>>
>>> +			/* Need to reshuffle packet list so that unsent
>> packets are
>>> +			 * after the return value
>>> +			 *
>>> +			 * Original: MMMMMM
>>> +			 * Filter:   MMMMMF filtered = 1
>>> +			 * Tx_burst: SSSUUF sent = 3 unsent = 2
>>> +			 *
>>> +			 * Return:   SSSFUU
>>> +			 *   return from tx_burst is 4
>>> +			 */
>>> +			memmove(tx_pkts + result_pkts, tx_pkts + sent_pkts,
>>> +				unsent_pkts * sizeof(struct rte_mbuf *));
>>> +
>>> +			/* Tx filter process does not drop the packets until
>> here */
>>> +			rte_pktmbuf_free_bulk(tx_pkts + sent_pkts,
>> filtered_pkts);
> 
> NAK.
> If the callback consumes the packet, the callback must free it too. The callback could consume the packet for other purposes, e.g. redirection, so freeing it here would introduce use-after-free bugs.

Good point as well. However, it still requires reordering which has
problem mentioned above.

> 
>>> +		}
>>> +
>>> +		rte_mbuf_history_mark_bulk(tx_pkts + result_pkts,
>> unsent_pkts,
>>> +					   RTE_MBUF_HISTORY_OP_TX_BUSY);
>>> +	}
>>>
>>> -	rte_ethdev_trace_tx_burst(port_id, queue_id, (void **)tx_pkts,
>> nb_pkts);
>>> -	return nb_pkts;
>>> +	rte_ethdev_trace_tx_burst(port_id, queue_id, (void **)tx_pkts,
>> result_pkts);
>>> +	return result_pkts;
>>>    }
>>>
>>>    /**
> 
> IMO, letting a Tx callback change the number of packets to actually transmit has too many side effects.
> E.g. port packet counters are not updated accordingly if a callback consumes a packet and silently drops it.
> 
> The Ethdev Tx API is not designed for the ethdev layer to handle any of retransmit-or-drop (when insufficient descriptors), redirect, mirror, drop (redirect/mirror/drop of all packets or selectively based on e.g. VLAN or BPF filter).
> 
> IMO, we should update the callback API to reflect this, by changing the callback return type to void.
> 

