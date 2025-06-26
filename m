Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD61C7EE31
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 14:36:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FED74021F;
	Thu, 26 Jun 2025 16:36:27 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id CBAF140156
 for <dev@dpdk.org>; Thu, 26 Jun 2025 16:36:25 +0200 (CEST)
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id 6F072B0DE
 for <dev@dpdk.org>; Thu, 26 Jun 2025 16:36:25 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 626A9B145; Thu, 26 Jun 2025 16:36:25 +0200 (CEST)
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id BC166B144;
 Thu, 26 Jun 2025 16:36:23 +0200 (CEST)
Message-ID: <32c86de3-5d1f-4e42-ae1d-19eccaac48e5@lysator.liu.se>
Date: Thu, 26 Jun 2025 16:36:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [PATCH] eventdev: make flag types consistent with API
To: Jerin Jacob <jerinj@marvell.com>,
 =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
References: <20250626135238.168921-1-mattias.ronnblom@ericsson.com>
 <BY3PR18MB478506E493537E8C47F2B21FC87AA@BY3PR18MB4785.namprd18.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
In-Reply-To: <BY3PR18MB478506E493537E8C47F2B21FC87AA@BY3PR18MB4785.namprd18.prod.outlook.com>
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

On 2025-06-26 16:12, Jerin Jacob wrote:
>> -----Original Message-----
>> From: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
>> Sent: Thursday, June 26, 2025 7:23 PM
>> To: Jerin Jacob <jerinj@marvell.com>
>> Cc: dev@dpdk.org; Mattias Rönnblom <hofors@lysator.liu.se>; Mattias
>> Rönnblom <mattias.ronnblom@ericsson.com>
>> Subject: [EXTERNAL] [PATCH] eventdev: make flag types consistent with API
>>
>> Make RTE_EVENT_DEV_CAP_* flags' type consistent with the
>> rte_event_dev_info. event_dev_cap's type. Make
>> RTE_EVENT_DEV_CFG_PER_DEQUEUE_TIMEOUT consistent with
>> rte_event_dev_config. event_dev_cfg. Make RTE_EVENT_QUEUE_CFG_*
>> consistent with rte_event_queue_conf. event_queue_cfg.
>> ZjQcmQRYFpfptBannerStart Prioritize security for external emails:
>> Confirm sender and content safety before clicking links or opening attachments
>> <https://us-phishalarm-
>> ewt.proofpoint.com/EWT/v1/CRVmXkqW!ts3Z1f8UAnUatM-
>> c2X0aD7H4_qqzjrySG1jUvYxf1eRBZ8860NkImwsi5uDUghDl9AKXmmrCtH3GlRgf
>> gCqT-4SjRdXOG8_TYEA-KJNabA$>
>> Report Suspicious
>>
>> ZjQcmQRYFpfptBannerEnd
>> Make RTE_EVENT_DEV_CAP_* flags' type consistent with the
>> rte_event_dev_info.event_dev_cap's type.
>>
>> Make RTE_EVENT_DEV_CFG_PER_DEQUEUE_TIMEOUT consistent with
>> rte_event_dev_config.event_dev_cfg.
>>
>> Make RTE_EVENT_QUEUE_CFG_* consistent with
>> rte_event_queue_conf.event_queue_cfg.
>>
>> Make RTE_EVENT_PORT_CFG_* consistent with
>> rte_event_port_conf.event_port_cfg.
>>
>> Make RTE_EVENT_TIMER_ADAPTER_CAP_* consistent with the caps parameter
>> in rte_event_eth_rx_adapter_caps_get().
>>
>> The flags were all unsigned long longs (64 bits), but the event_dev_cap,
>> event_dev_cfg, event_queue_cfg, and event_port_cfg fields and the caps
>> parameter are all uint32_t. This change makes the flags uint32_ts.
>>
>> Signed-off-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
>> ---
>>   lib/eventdev/rte_eventdev.h | 64 ++++++++++++++++++-------------------
>>   1 file changed, 32 insertions(+), 32 deletions(-)
>>
>> diff --git a/lib/eventdev/rte_eventdev.h b/lib/eventdev/rte_eventdev.h index
>> 3c7fcbf0be..9b44c24f0e 100644
>> --- a/lib/eventdev/rte_eventdev.h
>> +++ b/lib/eventdev/rte_eventdev.h
>> @@ -249,7 +249,7 @@ struct rte_mbuf; /* we just use mbuf pointers; no need
>> to include rte_mbuf.h */  struct rte_event;
>>
>>   /* Event device capability bitmap flags */
>> -#define RTE_EVENT_DEV_CAP_QUEUE_QOS           (1ULL << 0)
>> +#define RTE_EVENT_DEV_CAP_QUEUE_QOS           (UINT32_C(1) << 0)
> 
> Use RTE_BIT*
> 
> 

Of course. Thanks.


