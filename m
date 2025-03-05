Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2B9C19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 07:43:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 395D140156;
	Wed,  5 Mar 2025 08:43:58 +0100 (CET)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id E72B3400EF
 for <dev@dpdk.org>; Wed,  5 Mar 2025 08:43:56 +0100 (CET)
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id 76FEE16E67
 for <dev@dpdk.org>; Wed,  5 Mar 2025 08:43:56 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 66AD316DCD; Wed,  5 Mar 2025 08:43:56 +0100 (CET)
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id 5CEF016CDD;
 Wed,  5 Mar 2025 08:43:51 +0100 (CET)
Message-ID: <3ed22143-1abe-410f-813c-6777c2d9b012@lysator.liu.se>
Date: Wed, 5 Mar 2025 08:43:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Introduce Topology NUMA grouping for lcores
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 "Varghese, Vipin" <Vipin.Varghese@amd.com>,
 Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, roretzla@linux.microsoft.com, bruce.richardson@intel.com,
 john.mcnamara@intel.com, dmitry.kozliuk@gmail.com,
 ajit.khaparde@broadcom.com, "Song, Keesang" <Keesang.Song@amd.com>,
 pbhagavatula@marvell.com, jerinj@marvell.com, ruifeng.wang@arm.com,
 mattias.ronnblom@ericsson.com, anatoly.burakov@intel.com,
 stephen@networkplumber.org, "Yigit, Ferruh" <Ferruh.Yigit@amd.com>,
 honnappa.nagarahalli@arm.com, wathsala.vithanage@arm.com,
 konstantin.ananyev@huawei.com
References: <20241105102849.1947-1-vipin.varghese@amd.com>
 <PH7PR12MB85960CB35BB467CEBBC2CA2F82FF2@PH7PR12MB8596.namprd12.prod.outlook.com>
 <2097299.UkFFEUeh36@thomas>
 <98CBD80474FA8B44BF855DF32C47DC35E9FA33@smartserver.smartshare.dk>
 <PH7PR12MB8596C47BD103ADF3C275C10E82C92@PH7PR12MB8596.namprd12.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FABA@smartserver.smartshare.dk>
Content-Language: en-US
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FABA@smartserver.smartshare.dk>
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

On 2025-03-04 11:08, Morten Brørup wrote:
>> From: Varghese, Vipin [mailto:Vipin.Varghese@amd.com]
>> Sent: Monday, 3 March 2025 10.06
>>
>> [Public]
>>
>> Hi Morten,
>>
>> snipped
>>
>>>
>>>> From: Thomas Monjalon [mailto:thomas@monjalon.net]
>>>> Sent: Thursday, 13 February 2025 09.34
>>>>
>>>> 13/02/2025 04:09, Varghese, Vipin:
>>>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>>>
>>>>> Adding Thomas and Ajit to the loop.
>>>>>
>>>>> Hi Ajit, we have been using the patch series for identifying the
>>>> topology and getting l3 cache id for populating the steering tag
>> for
>>>> Device Specific Model & MSI-x driven af-xdp for the experimental
>> STAG
>>>> firmware on Thor.
>>>
>>> Excellent. A real life example use case helps the review process a
>> lot!
>>
>> Steering tag is one of the examples or uses, as shared in the current
>> patch series  we make use of these for other examples too.
>> Eventdev, pkt-distributor and graph nodes are also in works to exploit
>> L2|L3 cache local coherency too.
>>
>>>
>>>>>
>>>>> Hence current use of topology library helps in 1. workload
>> placement
>>>>> in same Cache or IO domain 2. populating id for MSIx or Device
>>>>> specific model for steering tags.
>>>>>
>>>>> Thomas and Ajith can we get some help to get this mainline too?
>>>>
>>>> Yes, sorry the review discussions did not start.
>>>> It has been forgotten.
>>>
>>> I think the topology/domain API in the EAL should be co-designed with
>> the steering
>>> tag API in the ethdev library, so the design can be
>> reviewed/discussed in its entirety.
>>
>> As shared in the discussion, we have been exploring simplified approach
>> for steering tags, namely
>>
>> 1. pci-dev args (crude way)
>> 2. flow api for RX (experimental way)
>>
>> Based on the platform (in case of AMD EPYC, these are translated to `L3
>> id + 1`)
>>
>> We do agree rte_ethdev library can use topology API. Current topology
>> API are designed to be made independent from steering tags, as other
>> examples do make use of the same.
>>
>>>
>>> To help the review discussion, please consider describing the
>> following:
>>> Which APIs are for slow path, and which are for fast path?
>>> Which APIs are "must have", i.e. core to making it work at all, and
>> which APIs are
>>> "nice to have", i.e. support APIs to ease use of the new features?
>>
>> Yes, will try to do the same in updated version. For Slow and Fast path
>> API I might need some help, as I was under the impression current
>> behavior is same rte_lcore (invoked at setup and before remote launch).
>> But will check again.
> 
> Probably they are all used for configuration only, and thus all slow path; but if there are any fast path APIs, they should be highlighted as such.
> 

Preferably, software work schedulers like DSW should be able to read 
topology information during run-time/steady-state operation. If topology 
APIs are slow or non-MT-safe, they will need to build up their own data 
structures for such information (which is not crazy idea, but leads to 
duplication).

I didn't follow the hwloc discussions, so I may lack some context for 
this discussion.

>>
>>>
>>> I haven't looked at the hwloc library's API; but I guess these new
>> EAL functions are
>>> closely related. Is it a thin wrapper around the hwloc library, or is
>> it very different?
>> This is very thin wrapper on top of hwloc library only. But with DPDK
>> RTE_MAX_LCORE & RTE_NUMA boundary check and population.
> 
> OK. The hwloc library is portable across Linux, BSD and Windows, which is great!
> 
> Please also describe the benefits of using this DPDK library, compared to directly using the hwloc library.
> 

