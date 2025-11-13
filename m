Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82D5CD4F28
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 07:23:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBE1440A6F;
	Thu, 13 Nov 2025 08:23:27 +0100 (CET)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id 069CE4003C
 for <dev@dpdk.org>; Thu, 13 Nov 2025 08:23:26 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=W/gw9wy3FL4394BPYDebGaVAdFVamYoC6iW1gXV7+no=;
 b=K/sdDXlEjrdkKIzCNix6zOIzKASBkm+1fwRYeQodLOLRDLST2Dd+8uQo9Ra9sqx7CQDX4PHnC
 kk6rYMm+ldtctSW7MFv/PBD0RMyCcFq5QMEyFy1n7RAqkJGwyn+A/ICLEfYm6irw8+QdiRvy0hd
 6cfIt9eX/wrcW3b9DT0vkEs=
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4d6Wst4kqPzpSvR;
 Thu, 13 Nov 2025 15:21:38 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 27B081402CF;
 Thu, 13 Nov 2025 15:23:23 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 13 Nov 2025 15:23:22 +0800
Message-ID: <a99915bd-31c5-4224-a427-55d4f758bb4b@huawei.com>
Date: Thu, 13 Nov 2025 15:23:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] vhost_user: Increase number of memory regions
To: "Bathija, Pravin" <Pravin.Bathija@dell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "pravin.m.bathija.dev@gmail.com" <pravin.m.bathija.dev@gmail.com>
References: <20251104042142.2787631-1-pravin.bathija@dell.com>
 <20251104042142.2787631-6-pravin.bathija@dell.com>
 <d7af7a2d-939a-45b3-9353-2787ef1dd513@huawei.com>
 <SJ0PR19MB46063C6E41E929271093CE1FF5CFA@SJ0PR19MB4606.namprd19.prod.outlook.com>
 <9f38ffe8-bfd0-4af0-bf2f-f1239823c9cd@huawei.com>
 <SJ0PR19MB4606F0D91D66F05CACF74626F5CDA@SJ0PR19MB4606.namprd19.prod.outlook.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <SJ0PR19MB4606F0D91D66F05CACF74626F5CDA@SJ0PR19MB4606.namprd19.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

On 11/13/2025 10:13 AM, Bathija, Pravin wrote:
> Answers inline
> 
> 
> Internal Use - Confidential
>> -----Original Message-----
>> From: fengchengwen <fengchengwen@huawei.com>
>> Sent: Tuesday, November 11, 2025 5:26 PM
>> To: Bathija, Pravin <Pravin.Bathija@dell.com>; dev@dpdk.org
>> Cc: pravin.m.bathija.dev@gmail.com
>> Subject: Re: [PATCH v3 5/5] vhost_user: Increase number of memory regions
>>
>>
>> [EXTERNAL EMAIL]
>>
>> On 11/11/2025 7:34 PM, Bathija, Pravin wrote:
>>> Responses inline.
>>>
>>>
>>> Internal Use - Confidential
>>>> -----Original Message-----
>>>> From: fengchengwen <fengchengwen@huawei.com>
>>>> Sent: Tuesday, November 4, 2025 12:12 AM
>>>> To: Bathija, Pravin <Pravin.Bathija@dell.com>; dev@dpdk.org
>>>> Cc: pravin.m.bathija.dev@gmail.com
>>>> Subject: Re: [PATCH v3 5/5] vhost_user: Increase number of memory
>>>> regions
>>>>
>>>>
>>>> [EXTERNAL EMAIL]
>>>>
>>>> On 11/4/2025 12:21 PM, Pravin M Bathija wrote:
>>>>> In this patch the number of memory regions are increased from
>>>>> 8 to 128. When a vhost-user front-end such as qemu or libblkio
>>>>> queries the back-end such as dpdk with the message, get max number
>>>>> of memory slots, the back-end replies with this number 128 instead
>>>>> of the previously defined 8. The back-end also allocates that many
>>>>> slots in the memory table where regions are added/removed as
>>>>> requested by the vhost-user front-end. This also helps the vhost-
>>>>> user front-end to limit the number of memory regions when sending
>>>>> the set mem table message ar adding memory regions.
>>>>>
>>>>> Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
>>>>> ---
>>>>>  lib/vhost/vhost_user.h | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/lib/vhost/vhost_user.h b/lib/vhost/vhost_user.h index
>>>>> 5a0e747b58..c6ad5b76d6 100644
>>>>> --- a/lib/vhost/vhost_user.h
>>>>> +++ b/lib/vhost/vhost_user.h
>>>>> @@ -11,7 +11,7 @@
>>>>>
>>>>>  /* refer to hw/virtio/vhost-user.c */
>>>>>
>>>>> -#define VHOST_MEMORY_MAX_NREGIONS 8
>>>>> +#define VHOST_MEMORY_MAX_NREGIONS 128
>>>>
>>>> The address translation may increase a lot if the real region is 128.
>>>> Maybe we should add another patch to optimize it.
>>>
>>> Could you please share more thoughts on this ?  Are you concerned about
>> the number of addresses and translation table bloat ? What optimization are
>> you suggesting ?
>>
>> Because each memory region is independent and does not overlap, maybe we
>> could use binary search to optimize it.
> 
> From what I gather, both of your latest comments, for patches 4 and 5 are related to performance impact because of 128 memory regions. My thoughts on this are, I will work on an algorithm to optimize as you suggested. Meanwhile we could approve patches 1-4. The rest of the implementation does not need 128 memory regions. The existing 8 regions are fine. I put in this change as I felt it makes the system scale more and was also suggested by Maxime. I think patches 1-4 stand by themselves and have been thoroughly tested. Please let me know your thoughts on this.

I am OK for this.

> 
>>
>>>
>>>>
>>>>>
>>>>>  #define VHOST_USER_NET_SUPPORTED_FEATURES \
>>>>>     (VIRTIO_NET_SUPPORTED_FEATURES | \
>>>
>>>
> 
> 

