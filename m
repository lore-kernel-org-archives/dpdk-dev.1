Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3046AC83F17
	for <dpdk-dev@archiver.kernel.org>; Sat, 26 Jul 2025 09:09:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 049B8402DD;
	Sat, 26 Jul 2025 11:09:37 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 5073B40144
 for <dev@dpdk.org>; Sat, 26 Jul 2025 11:09:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru F1B3450
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1753520974;
 bh=ZOdXCE3fbrbSFsMebvEOA2aiatOeoAbq0c8LvqRaxWk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=g+D3Ihi+rFAMOJCtwViqrwVtvoxRs3N++d7V/HD05EIFgO1VoRAd+OR2Tg/kg16du
 T48pbf0pqTx0JSvtdWtK7pbNtoAXhDl4XhzmEWnXXAR9pm7Du5osbGSdnzLcFK4vOR
 x25EHnaYCUVyZLIBcbaXEBsQFHtIbI5EyT1PpTDo=
Received: from [192.168.1.39] (unknown [188.170.87.221])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id F1B3450;
 Sat, 26 Jul 2025 12:09:33 +0300 (MSK)
Message-ID: <2858a9d1-894a-4e21-8a44-81bedfeb41c4@oktetlabs.ru>
Date: Sat, 26 Jul 2025 12:09:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ethdev: remove callback checks from fast path
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Sunil Kumar Kori <skori@marvell.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Ferruh Yigit <ferruh.yigit@amd.com>
References: <20250429181132.2544771-1-skori@marvell.com>
 <20250512150732.65743-1-skori@marvell.com>
 <20250512150732.65743-2-skori@marvell.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FC9E@smartserver.smartshare.dk>
 <CO6PR18MB386002BE3B4FF5646A41404AB46AA@CO6PR18MB3860.namprd18.prod.outlook.com>
 <CO6PR18MB3860D388FFE168A3ED50D5F4B470A@CO6PR18MB3860.namprd18.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FCFC@smartserver.smartshare.dk>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FCFC@smartserver.smartshare.dk>
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

On 6/16/25 17:30, Morten Brørup wrote:
>> From: Sunil Kumar Kori [mailto:skori@marvell.com]
>> Sent: Monday, 16 June 2025 10.36
>>
>>>>> From: Sunil Kumar Kori <skori@marvell.com>
>>>>> Sent: Monday, 12 May 2025 17.07
>>>>>
>>>>> rte_eth_fp_ops contains ops for fast path APIs. Each API validates
>>>>> availability of callback and then invoke it.
>>>>> These checks impact data path performace.
>>>>
>>>> Picking up the discussion from another thread [1]:
>>>>
>>>>> From: Konstantin Ananyev [mailto:konstantin.ananyev@huawei.com]
>>>>> Sent: Wednesday, 28 May 2025 11.14
>>>>>
>>>>> So what we are saving with that patch: one cmp and one un-taken branch:
>>>>> @@ -6399,8 +6399,6 @@ rte_eth_rx_queue_count(uint16_t port_id,
>>>>> uint16_t
>>>>> queue_id)
>>>>>   		return -EINVAL;
>>>>>   #endif
>>>>>
>>>>> -	if (p->rx_queue_count == NULL)
>>>>> -		return -ENOTSUP;
>>>>>   	return p->rx_queue_count(qd);
>>>>>   }
>>>>
>>>> These are inline functions, so we also save some code space,
>>>> instruction cache, and possibly an entry in the branch predictor -
>>>> everywhere these functions are instantiated by the compiler.
>>>>
>>>>>
>>>>> I wonder is how realistic (and measurable) is the gain?
>>>>
>>>> The performance optimization is mainly targeting the mbuf recycle
>>>> operations, i.e. the hot fast path, where every cycle counts.
>>>> And while optimizing those, the other ethdev fast path callbacks are
>>>> also optimized.
>>>>
>>>> Yes, although we all agree that there is no downside to this
>>>> optimization, it would be nice to see some performance numbers.
>>>>
>>> Sure, I will get performance numbers for Marvell platform and will share.
>>>
>>
>> Hi Morten,
>> I got performance numbers on multiple Marvell's platforms and observed gain
>> around 0.1% (~20K pps) with this patch. Other than this, there are other fast
>> path callbacks (rx_pkt_burst and tx_pkt_burst) which avoid this check.

I'm really impressed that 0.1% is measurable since it means that the 
measurement results of different runs have higher order of stability.

>> IMO, this patch has no negative impact and slight improvement & cleanup the
>> fast path. Please suggest.
> 
> I still like this patch, so I confirm my ACK:
> 
> Acked-by: Morten Brørup <mb@smartsharesystems.com>
> 

