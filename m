Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7665EC87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 00:44:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73790402A8;
	Thu, 14 Aug 2025 02:44:44 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 5F5E74026D
 for <dev@dpdk.org>; Thu, 14 Aug 2025 02:44:41 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c2RHt0F20z13N7H;
 Thu, 14 Aug 2025 08:41:14 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 0BD5E180B5A;
 Thu, 14 Aug 2025 08:44:39 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Aug 2025 08:44:38 +0800
Message-ID: <758d6a5c-4c1a-4506-a32f-38c4b5543046@huawei.com>
Date: Thu, 14 Aug 2025 08:44:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v0 1/1] doc: announce inter-device DMA
 capability support in dmadev
To: Vamsi Krishna Attunuru <vattunuru@marvell.com>, "thomas@monjalon.net"
 <thomas@monjalon.net>
CC: Jerin Jacob <jerinj@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>, Pavan
 Nikhilesh Bhagavatula <pbhagavatula@marvell.com>, "kevin.laatz@intel.com"
 <kevin.laatz@intel.com>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 "techboard@dpdk.com" <techboard@dpdk.com>
References: <20250710085101.1678775-1-vattunuru@marvell.com>
 <01a66ad9-a763-457a-b0b2-c6aae1948f84@huawei.com>
 <SJ4PPFEA6F74CA24501C3384EF778E0B3F6A657A@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
 <2243786a-eb7c-4807-b507-199936764e54@huawei.com>
 <SJ4PPFEA6F74CA2EBA656AF4C3C4CF8790DA656A@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
 <f97b576f-a67f-4752-9576-7ece752d8a56@huawei.com>
 <SJ4PPFEA6F74CA2D1893CA98B40B00BB5E4A650A@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
 <SJ4PPFEA6F74CA23C5196C41F03ED52284CA65AA@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
 <SJ4PPFEA6F74CA25F39BCE20F1AF8F9CD9EA624A@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
 <SJ4PPFEA6F74CA25E46352CC7F3F2F8314EA62AA@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <SJ4PPFEA6F74CA25E46352CC7F3F2F8314EA62AA@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

I agree the feature discussed in TB.

The original scheme is too vague and hard to understand, although after several round of clarification.


On 8/14/2025 12:46 AM, Vamsi Krishna Attunuru wrote:
> Hi Thomas, Feng
> 
> Can this feature be discussed in the next techboard meeting and decide on supporting it
> together with the ABI breaking changes in 25.11, rather than using the versions scheme.
> Since there are no further comments after we aligned with the Feng's feedback, it would be
> good to finalize the approach.
> 
> Regards
> Vamsi
> 
>> -----Original Message-----
>> From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
>> Sent: Wednesday, July 30, 2025 10:07 AM
>> To: fengchengwen <fengchengwen@huawei.com>;
>> bruce.richardson@intel.com; Vladimir Medvedkin
>> <vladimir.medvedkin@intel.com>; Anatoly Burakov
>> <anatoly.burakov@intel.com>
>> Cc: Jerin Jacob <jerinj@marvell.com>; thomas@monjalon.net;
>> dev@dpdk.org; Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>;
>> kevin.laatz@intel.com
>> Subject: RE: [EXTERNAL] Re: [PATCH v0 1/1] doc: announce inter-device DMA
>> capability support in dmadev
>>
>> Gentle reminder to share your feedback. >Hi Bruce, Vladimir, Anatoly >
>>> Regarding inter-device or inter-domain DMA capability, could please clarify if
>>> Intel idxd driver will support this feature. >I believe the changes Feng has
>> ZjQcmQRYFpfptBannerStart Prioritize security for external emails:
>> Confirm sender and content safety before clicking links or opening
>> attachments <https://us-phishalarm-
>> ewt.proofpoint.com/EWT/v1/CRVmXkqW!uq3V-
>> r_YrnsUWi9yeT3UAKXL4FFc4ONZAyvoCMlneUv-fN8An8AKohi4aES-
>> ZG37anFsJG5Rq3NspRNGjPgt5I9U4c9cEVeu_P4sHAEFMopboItEI9hkXOMUrJ
>> m_Pyoic-gg6kRF3p9wjJrTGA$>
>> Report Suspicious
>>
>> ZjQcmQRYFpfptBannerEnd
>> Gentle reminder to share your feedback.
>>
>>> Hi Bruce, Vladimir, Anatoly
>>>
>>> Regarding inter-device or inter-domain DMA capability, could please
>>> clarify if Intel idxd driver will support this feature.
>>> I believe the changes Feng has suggested here are in line with the
>>> earlier "[PATCH v1 0/3] Add support for inter-domain DMA operations"
>>> proposal. We are planning to implement this feature support in version
>> 25.11.
>>>
>>> Your feedback would be appreciated, we are aiming for a more generic
>>> solution.
>>>
>>> Regards
>>> Vamsi
>>>
>>>
>>>>> On 2025/7/16 18:59, Vamsi Krishna Attunuru wrote:
>>>>>>
>>>>>>>
>>>>>>> Thanks for the explanation.
>>>>>>>
>>>>>>> Let me tell you what I understand:
>>>>>>> 1\ Two dmadev (must belong to the same DMA controller?) each
>>>>>>> passthrough to diffent domain (VM or container) 2\ The kernel DMA
>>>>>>> controller driver could config access groups --- there is a secure
>>>>>>> mechanism
>>>>> (like Intel IDPTE)
>>>>>>>   and the two dmadev could communicate if the kernel DMA
>>>>>>> controller driver has put them in the same access groups.
>>>>>>> 3\ Application setup access group and get handle (maybe the new
>>>>> 'dev_idx'
>>>>>>> which you announce in this commit),
>>>>>>>   and then setup one vchan which config the handle.
>>>>>>>   and later launch copy request based on this vchan.
>>>>>>> 4\ The driver will pass the request to dmadev-1 hardware, and
>>>>>>> dmadev-1 hardware will do some verification,
>>>>>>>   and maybe use dmadev-2 stream ID for read/write operations?
>>>>>>>
>>>>>>> A few question about this:
>>>>>>> 1\ What the prototype of 'dev_idx', is it uint16_t?
>>>>>> Yes, it can be uint16_t and use two different dev_idx (src_dev_idx
>>>>>> &
>>>>>> dest_dev_idx) for read & write.
>>>>>>
>>>>>>> 2\ How to implement read/write between two dmadev ?  use two
>>>>>>> different dev_idx? the first for read and the second for write?
>>>>>> Yes, two different dev_idx will be used.
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> I also re-read the patchset "[PATCH v1 0/3] Add support for
>>>>>>> inter-domain DMA operations", it introduce:
>>>>>>> 1\ One 'int controller-id' in the rte_dma_info. which maybe used
>>>>>>> in
>>>>>>> vendor- specific secure mechanism.
>>>>>>> 2\ Two new OP_flag and two new datapath API.
>>>>>>> The reason why this patch didn't continue (I guess) is whether
>>>>>>> setup one new vchan. Yes, vchan was designed to represents
>>>>>>> different transfer contexts. But each vchan has its own
>>>>>>> enqueue/dequeue/ring, it more act like one logic dmadev, some of
>>>>>>> the hardware can fit this model well, some may not (like Intel in
>>>>>>> this
>>> case).
>>>>>>>
>>>>>>>
>>>>>>> So how about the following scheme:
>>>>>>> 1\ Add inter-domain capability bits, for example:
>>>>>>> RTE_DMA_CAPA_INTER_PROCESS_DOMAIN,
>>>>>>> RTE_DMA_CAPA_INTER_OS_DOMAIN 2\ Add one
>> domain_controller_id
>>>> in
>>>>> the
>>>>>>> rte_dma_info which maybe used in vendor-specific secure
>> mechanism.
>>>>>>> 3\ Add four OP_FLAGs:
>>>>>>> RTE_DMA_OP_FLAG_SRC_INTER_PROCESS_DOMAIN_HANDLE,
>>>>>>> RTE_DMA_OP_FLAG_DST_INTER_PROCESS_DOMAIN_HANDLE
>>>>>>>                      RTE_DMA_OP_FLAG_SRC_INTER_OS_DOMAIN_HANDLE,
>>>>>>> RTE_DMA_OP_FLAG_DST_INTER_OS_DOMAIN_HANDLE
>>>>>>> 4\ Reserved 32bit from flag parameter (which all enqueue API both
>>>>>>> supports) as the src and dst handle.
>>>>>>>   or only reserved 16bit from flag parameter if we restrict don't
>>>>>>> support 3rd transfer.
>>>>>>
>>>>>> Yes, the above approach seems acceptable to me. I believe src & dst
>>>>>> handles require 16-bit values. Reserving 32-bits from flag
>>>>>> parameter would leave 32 flags available, which should be fine.
>>>>>
>>>>> Great
>>>>> tip: there are still 24bit flag reserved after apply this scheme.
>>>>>
>>>>> Would like more comments.
>>>>>
>>>>
>>>> If there are no major comments at this time, can we proceed with
>>>> accepting and merging this notice in this release. Further review can
>>>> continue once the RFC is available next month.
>>>>
>>>> Thanks & Regards
>>>> Vamsi
>>>>
>>>>>>
>>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>> On 2025/7/15 13:35, Vamsi Krishna Attunuru wrote:
>>>>>>>> Hi Feng,
>>>>>>>>
>>>>>>>> Thanks for depicting the feature use case.
>>>>>>>>
>>>>>>>> From the application’s perspective, inter VM/process
>>>>>>>> communication is
>>>>>>> required to exchange the src & dst buffer details, however the
>>>>>>> specifics of this communication mechanism are outside the scope in
>>>>>>> this context. Regarding the address translations, these buffer
>>>>>>> addresses can be either IOVA as PA or IOVA as VA. The DMA hardware
>>>>>>> must use the appropriate IOMMU stream IDs when initiating the DMA
>>>>>>> transfers. For example, in the use case shown in the diagram,
>>>>>>> dmadev-1 and dmadev-2 would join an access group managed by the
>>>>>>> kernel DMA controller driver. This controller driver will
>>>>>>> configure the access group on the DMA hardware, enabling the
>>>>>>> hardware to select the correct stream IDs for read/write
>>>>>>> operations. New rte_dma APIs could be introduced to join or leave
>>>>>>> the access group or to query the access group details.
>>>>>>> Additionally, a secure token mechanism (similar to
>>>>> vfio-pci token) can be implemented to validate any dmadev attempting
>>>>> to join the access group.
>>>>>>>>
>>>>>>>> Regards.
>>>>>>>>
>>>>>>>> From: fengchengwen <fengchengwen@huawei.com>
>>>>>>>> Sent: Tuesday, July 15, 2025 6:29 AM
>>>>>>>> To: Vamsi Krishna Attunuru <vattunuru@marvell.com>;
>>> dev@dpdk.org;
>>>>>>>> Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>;
>>>>>>>> kevin.laatz@intel.com; bruce.richardson@intel.com;
>>>>>>>> mb@smartsharesystems.com
>>>>>>>> Cc: Jerin Jacob <jerinj@marvell.com>; thomas@monjalon.net
>>>>>>>> Subject: [EXTERNAL] Re: [PATCH v0 1/1] doc: announce inter-device
>>>>>>>> DMA capability support in dmadev
>>>>>>>>
>>>>>>>> Hi Vamsi, From the commit log, I guess this commit mainly want to
>>>>>>>> meet following case: --------------- ---------------- | Container
>>>>>>>> |
>>>>>>>> | VirtMachine | | | | | | dmadev-1 | | dmadev2 | ---------------
>>>>>>>> ---------------- |
>>>>>>> | ------------------------------ ZjQcmQRYFpfptBannerStart
>>>>>>> | Prioritize security for
>>>>>>> external emails:
>>>>>>>> Confirm sender and content safety before clicking links or
>>>>>>>> opening
>>>>>>> attachments
>>>>>>>>     Report Suspicious
>>>>>>>> <https://urldefense.proofpoint.com/v2/url?u=https-3A__us-
>>>> 2Dphishala
>>>>>>>> <https://urldefense.proofpoint.com/v2/url?u=https-3A__us-
>>>>>>>>>> 2Dphishala  >>>>>>> r
>>>>>>>> <https://urldefense.proofpoint.com/v2/url?u=https-3A__us-
>>>> 2Dphishala
>>>>>>>> <https://urldefense.proofpoint.com/v2/url?u=https-3A__us-
>>>>>>>>>> 2Dphishala  >>>>>>> r  >>>>> m-
>>>>> 2D&d=DwIDaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=WllrYaumVkxaWjgKto6
>> E
>>> _r
>>>> t
>>>>> DQsh
>>>>>>>>
>>>>> hIhik2jkvzFyRhW8&m=3uFGFVHxC4YLkjWHNg9s9rNDHd_ozbhLepOYCAki
>> Z
>>> K
>>>> x
>>>>> M0sQ0m
>>>>>>>>
>>>>> 43gqgTQl1cK9koZ&s=3_mvLYuMWu7RbHD3mj21CP65O5JY8L8AK8oVFutdT
>>> W
>>>> U
>>>>> &e=
>>>>>>>
>>>>> ewt.proofpoint.com/EWT/v1/CRVmXkqW!tg3ZldV0Yr_wdSwWmT2aDdK
>> Mi
>>> -
>>>>>>>
>>>>> 4rn2z58vFaxwfOeocS1P19w1BeRdyGs5sjnhV2rU_6m8MOWj4KFbuXKkKJI
>> v
>>> c
>>>> q
>>>>>>> wWD2WEwJW_0$ >
>>>>>>>> ZjQcmQRYFpfptBannerEnd
>>>>>>>>
>>>>>>>> Hi Vamsi,
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> From the commit log, I guess this commit mainly want to meet
>>>>>>>> following
>>>>>>> case:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>      ---------------             ----------------
>>>>>>>>
>>>>>>>>      |  Container  |             |  VirtMachine |
>>>>>>>>
>>>>>>>>      |             |             |              |
>>>>>>>>
>>>>>>>>      |  dmadev-1   |             |   dmadev2    |
>>>>>>>>
>>>>>>>>      ---------------             ----------------
>>>>>>>>
>>>>>>>>            |                            |
>>>>>>>>
>>>>>>>>            ------------------------------
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> App run in the container could launch DMA transfer from local
>>>>>>>> buffer to the VirtMachine by config
>>>>>>>>
>>>>>>>> dmadev-1/2 (the dmadev-1/2 are passthrough to diffent OS domain).
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Could you explain how to use it from application perspective (for
>>>>>>>> example address translation) and
>>>>>>>>
>>>>>>>> application & hardware restrictions?
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> BTW: In this case, there are two OS domain communication, and I
>>>>>>>> remember there are also inter-process
>>>>>>>>
>>>>>>>> DMA RFC, so maybe we could design more generic solution if you
>>>>>>>> provide
>>>>>>> more info.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Thanks
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2025/7/10 16:51, Vamsi Krishna wrote:
>>>>>>>>
>>>>>>>>> From: Vamsi Attunuru
>>>>>>>>> <vattunuru@marvell.com<mailto:vattunuru@marvell.com>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>>> Modern DMA hardware supports data transfer between multiple
>>>>>>>>
>>>>>>>>> DMA devices, enabling data communication across isolated domains
>>>>>>>>> or
>>>>>>>>
>>>>>>>>> containers. To facilitate this, the ``dmadev`` library requires
>>>>>>>>> changes
>>>>>>>>
>>>>>>>>> to allow devices to register with or unregisters from DMA groups
>>>>>>>>> for
>>>>>>>>
>>>>>>>>> inter-device communication. This feature is planned for
>>>>>>>>> inclusion
>>>>>>>>
>>>>>>>>> in DPDK 25.11.
>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>>> Signed-off-by: Vamsi Attunuru
>>>>>>>>> <vattunuru@marvell.com<mailto:vattunuru@marvell.com>>
>>>>>>>>
>>>>>>>>> ---
>>>>>>>>
>>>>>>>>>  doc/guides/rel_notes/deprecation.rst | 7 +++++++
>>>>>>>>
>>>>>>>>>  1 file changed, 7 insertions(+)
>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>>> diff --git a/doc/guides/rel_notes/deprecation.rst
>>>>>>>>> b/doc/guides/rel_notes/deprecation.rst
>>>>>>>>
>>>>>>>>> index e2d4125308..46836244dd 100644
>>>>>>>>
>>>>>>>>> --- a/doc/guides/rel_notes/deprecation.rst
>>>>>>>>
>>>>>>>>> +++ b/doc/guides/rel_notes/deprecation.rst
>>>>>>>>
>>>>>>>>> @@ -152,3 +152,10 @@ Deprecation Notices
>>>>>>>>
>>>>>>>>>  * bus/vmbus: Starting DPDK 25.11, all the vmbus API defined in
>>>>>>>>
>>>>>>>>>    ``drivers/bus/vmbus/rte_bus_vmbus.h`` will become internal to
>>>> DPDK.
>>>>>>>>
>>>>>>>>>    Those API functions are used internally by DPDK core and
>>>>>>>>> netvsc
>>>> PMD.
>>>>>>>>
>>>>>>>>> +
>>>>>>>>
>>>>>>>>> +* dmadev: a new capability flag ``RTE_DMA_CAPA_INTER_DEV``
>> will
>>>>>>>>> +be added
>>>>>>>>
>>>>>>>>> +  to advertise DMA device's inter-device DMA copy capability.
>>>>>>>>> + To enable
>>>>>>>>
>>>>>>>>> +  this functionality, a few dmadev APIs will be added to
>>>>>>>>> + configure the DMA
>>>>>>>>
>>>>>>>>> +  access groups, facilitating coordinated data communication
>>>>>>>>> + between
>>>>>>> devices.
>>>>>>>>
>>>>>>>>> +  A new ``dev_idx`` field will be added to the ``struct
>>>>>>>>> + rte_dma_vchan_conf``
>>>>>>>>
>>>>>>>>> +  structure to configure a vchan for data transfers between any
>>>>>>>>> + two DMA
>>>>>>> devices.
>>>>>>>>
>>>>>>>>
>>>>>>
> 

