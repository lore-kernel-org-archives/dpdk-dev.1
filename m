Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EF4C83F03
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 20:19:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 251AA40661;
	Wed,  2 Jul 2025 22:19:46 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id 651084064C
 for <dev@dpdk.org>; Wed,  2 Jul 2025 22:19:44 +0200 (CEST)
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id EEFD74516
 for <dev@dpdk.org>; Wed,  2 Jul 2025 22:19:43 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id E30E64461; Wed,  2 Jul 2025 22:19:43 +0200 (CEST)
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id 82FE14514;
 Wed,  2 Jul 2025 22:19:42 +0200 (CEST)
Message-ID: <ff692fe7-03b5-408d-8112-5a4b30d9f96b@lysator.liu.se>
Date: Wed, 2 Jul 2025 22:19:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] event/eth_tx: prefetch mbuf headers
To: "Naga Harish K, S V" <s.v.naga.harish.k@intel.com>,
 =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Cc: Jerin Jacob <jerinj@marvell.com>,
 Peter Nilsson <peter.j.nilsson@ericsson.com>
References: <20250328054339.489914-1-mattias.ronnblom@ericsson.com>
 <SN7PR11MB7044C3B89BCFC25021522487A164A@SN7PR11MB7044.namprd11.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
In-Reply-To: <SN7PR11MB7044C3B89BCFC25021522487A164A@SN7PR11MB7044.namprd11.prod.outlook.com>
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

On 2025-05-27 12:55, Naga Harish K, S V wrote:
> 
> 
>> -----Original Message-----
>> From: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
>> Sent: Friday, March 28, 2025 11:14 AM
>> To: dev@dpdk.org
>> Cc: Mattias Rönnblom <hofors@lysator.liu.se>; Naga Harish K, S V
>> <s.v.naga.harish.k@intel.com>; Jerin Jacob <jerinj@marvell.com>; Mattias
>> Rönnblom <mattias.ronnblom@ericsson.com>; Peter Nilsson
>> <peter.j.nilsson@ericsson.com>
>> Subject: [PATCH] event/eth_tx: prefetch mbuf headers
>>
>> Prefetch mbuf headers, resulting in ~10% throughput improvement when the
>> Ethernet RX and TX Adapters are hosted on the same core (likely ~2x in case a
>> dedicated TX core is used).
>>
>> Signed-off-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
>> Tested-by: Peter Nilsson <peter.j.nilsson@ericsson.com>
>> ---
>>   lib/eventdev/rte_event_eth_tx_adapter.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/lib/eventdev/rte_event_eth_tx_adapter.c
>> b/lib/eventdev/rte_event_eth_tx_adapter.c
>> index 67fff8b7d6..d740ae00f9 100644
>> --- a/lib/eventdev/rte_event_eth_tx_adapter.c
>> +++ b/lib/eventdev/rte_event_eth_tx_adapter.c
>> @@ -598,6 +598,12 @@ txa_process_event_vector(struct txa_service_data
>> *txa,
>>   	return nb_tx;
>>   }
>>
>> +static inline void
>> +txa_prefetch_mbuf(struct rte_mbuf *mbuf) {
>> +	rte_mbuf_prefetch_part1(mbuf);
>> +}
>> +
>>   static void
>>   txa_service_tx(struct txa_service_data *txa, struct rte_event *ev,
>>   	uint32_t n)
>> @@ -608,6 +614,20 @@ txa_service_tx(struct txa_service_data *txa, struct
>> rte_event *ev,
>>
>>   	stats = &txa->stats;
>>
>> +	for (i = 0; i < n; i++) {
>> +		struct rte_event *event = &ev[i];
>> +
>> +		if (unlikely(event->event_type & RTE_EVENT_TYPE_VECTOR))
> 
> 
> This gives a branch prediction advantage to non-vector events. Is that the intention?
> 

Yes.

>> {
>> +			struct rte_event_vector *vec = event->vec;
>> +			struct rte_mbuf **mbufs = vec->mbufs;
>> +			uint32_t k;
>> +
>> +			for (k = 0; k < vec->nb_elem; k++)
>> +				txa_prefetch_mbuf(mbufs[k]);
>> +		} else
>> +			txa_prefetch_mbuf(event->mbuf);
>> +	}
>> +
>>   	nb_tx = 0;
>>   	for (i = 0; i < n; i++) {
>>   		uint16_t port;
>> --
>> 2.43.0
> 

