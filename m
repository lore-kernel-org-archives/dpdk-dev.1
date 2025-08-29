Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DC7C8303F
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 09:18:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70FB640263;
	Fri, 29 Aug 2025 11:18:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BE8EF4025A
 for <dev@dpdk.org>; Fri, 29 Aug 2025 11:18:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756459080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=C2EAZ+d8lVxd6uVfmFKDjN3TPYJhjyvSvtgPT3R49SE=;
 b=FliuWMmkvR/O63e1PGST1excsZDgWeE6gDGUGG7+y+jpraJnKonzApGbgZ8l/moeu9scrn
 lK6aZvPAVzZRV/OaJp4RFcLE/pUhDw2enCB8RJqvczydMNoBSeaLSuXnVbzP52iNYpStOt
 50qJbd1eynfryksPJW9uoCmnI+JJ6Jc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-EKKQ4izfMt6qVZe5zVTv6A-1; Fri,
 29 Aug 2025 05:17:57 -0400
X-MC-Unique: EKKQ4izfMt6qVZe5zVTv6A-1
X-Mimecast-MFC-AGG-ID: EKKQ4izfMt6qVZe5zVTv6A_1756459075
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D0C6195608B; Fri, 29 Aug 2025 09:17:55 +0000 (UTC)
Received: from [10.45.242.23] (unknown [10.45.242.23])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E6D818004A3; Fri, 29 Aug 2025 09:17:51 +0000 (UTC)
Message-ID: <ab711389-82ca-4aa4-9796-55106d5fc00b@redhat.com>
Date: Fri, 29 Aug 2025 11:17:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] vhost_user: configure memory slots
To: "Bathija, Pravin" <Pravin.Bathija@dell.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 David Marchand <david.marchand@redhat.com>, Chenbo Xia <chenbox@nvidia.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 "pravin.m.bathija.dev@gmail.com" <pravin.m.bathija.dev@gmail.com>,
 Thomas Monjalon <thomas@monjalon.net>
References: <20250812023358.2400020-1-pravin.bathija@dell.com>
 <15537925.JCcGWNJJiE@thomas>
 <SJ0PR19MB4606D8D898219FE2296C7FB4F53DA@SJ0PR19MB4606.namprd19.prod.outlook.com>
 <SJ0PR19MB46063FDCC149084AFBD7C4E1F53DA@SJ0PR19MB4606.namprd19.prod.outlook.com>
 <8391ac53-0b5c-468c-ae38-341842f5c492@redhat.com>
 <SJ0PR19MB46063A880B831758A7455613F539A@SJ0PR19MB4606.namprd19.prod.outlook.com>
 <SJ0PR19MB460649E8A3D39B224CFB4469F53AA@SJ0PR19MB4606.namprd19.prod.outlook.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Autocrypt: addr=maxime.coquelin@redhat.com; keydata=
 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
 Mwqu3GQ=
In-Reply-To: <SJ0PR19MB460649E8A3D39B224CFB4469F53AA@SJ0PR19MB4606.namprd19.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4UaN-CW9lQKsyfe7nW67xRdj3DlrRcXqArsuuQvIoD4_1756459075
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Pravin,

On 8/29/25 11:11 AM, Bathija, Pravin wrote:
> Dear Maxime, Bruce, David, Chenbo,
> 
> Could you please help review the code ? The goal is to merge the changes before September 18 when the merge window closes for SPDK v25.09.

I will help review the code, but there are no guarantee it will be
merged in main branch before September 18th.

Can you elaborate about the tests you have run?
Have you ensured it is still working properly with Vhsot-user/Virtio-net?

Maxime

> Regards,
> Pravin
> 
> 
> Internal Use - Confidential
>> -----Original Message-----
>> From: Bathija, Pravin
>> Sent: Tuesday, August 26, 2025 11:47 AM
>> To: Maxime Coquelin <maxime.coquelin@redhat.com>; Bruce Richardson
>> <bruce.richardson@intel.com>; David Marchand
>> <david.marchand@redhat.com>; Chenbo Xia <chenbox@nvidia.com>
>> Cc: dev@dpdk.org; pravin.m.bathija.dev@gmail.com; Thomas Monjalon
>> <thomas@monjalon.net>
>> Subject: RE: [PATCH 0/3] vhost_user: configure memory slots
>>
>> Answers inline.
>>
>>> -----Original Message-----
>>> From: Maxime Coquelin <maxime.coquelin@redhat.com>
>>> Sent: Monday, August 25, 2025 1:49 AM
>>> To: Bathija, Pravin <Pravin.Bathija@dell.com>; Bruce Richardson
>>> <bruce.richardson@intel.com>; David Marchand
>>> <david.marchand@redhat.com>; Chenbo Xia <chenbox@nvidia.com>
>>> Cc: dev@dpdk.org; pravin.m.bathija.dev@gmail.com; Thomas Monjalon
>>> <thomas@monjalon.net>
>>> Subject: Re: [PATCH 0/3] vhost_user: configure memory slots
>>>
>>>
>>> [EXTERNAL EMAIL]
>>>
>>> Hi,
>>>
>>> Please try to fix your email client so that we can follow the replies inlined.
>>
>> Thank you for the input. I have made the necessary adjustments. Please let me
>> know if there is anything missing.
>>
>>>
>>> On 8/22/25 9:33 AM, Bathija, Pravin wrote:
>>>> Dear Maxime, Bruce, David, Chenbo,
>>>>
>>>> I would like to follow up on the status of the patches and when we
>>>> should
>>> expect these to be merged into the mainline.
>>>>
>>>> Please let me know if I can help answer any questions you might have.
>>>>
>>>> Regards,
>>>> Pravin
>>>>
>>>>
>>>> Internal Use - Confidential
>>>> -----Original Message-----
>>>> From: Bathija, Pravin
>>>> Sent: Thursday, August 21, 2025 7:48 PM
>>>> To: Thomas Monjalon <thomas@monjalon.net>
>>>> Cc: dev@dpdk.org; pravin.m.bathija.dev@gmail.com; Maxime Coquelin
>>>> <maxime.coquelin@redhat.com>; Chenbo Xia <chenbox@nvidia.com>;
>> David
>>>> Marchand <david.marchand@redhat.com>; Bruce Richardson
>>>> <bruce.richardson@intel.com>
>>>> Subject: RE: [PATCH 0/3] vhost_user: configure memory slots
>>>>
>>>> Comments inline:
>>>>
>>>> -----Original Message-----
>>>> From: Thomas Monjalon <thomas@monjalon.net>
>>>> Sent: Tuesday, August 19, 2025 4:36 AM
>>>> To: Bathija, Pravin <Pravin.Bathija@dell.com>
>>>> Cc: dev@dpdk.org; pravin.m.bathija.dev@gmail.com; Maxime Coquelin
>>>> <maxime.coquelin@redhat.com>; Chenbo Xia <chenbox@nvidia.com>;
>> David
>>>> Marchand <david.marchand@redhat.com>; Bruce Richardson
>>>> <bruce.richardson@intel.com>
>>>> Subject: Re: [PATCH 0/3] vhost_user: configure memory slots
>>>>
>>>>
>>>> [EXTERNAL EMAIL]
>>>>
>>>> Comments inline
>>>>
>>>> 12/08/2025 04:33, Pravin M Bathija:
>>>>> - add protocol feature support add and removal of memory
>>>>> regions/slots dynamically.
>>>>> - this patch set has been tested with multiple instances of fio
>>>>
>>>> What is "fio"?
>>>> Fio is an open-source tool to test I/O workloads on disks and file systems.
>>>>
>>>>> connected via libblkio to spdk target backed unix domain socket.
>>>>> - please apply this this patch-set to dpdk mainline as well as
>>>>> version 25.03.0.
>>>>
>>>> As mentionned previously, we don't plan to maintain 25.03.
>>>> I understand you need it for SPDK,
>>>> but I think SPDK should rely only on LTS branches.
>>>> Is there a specific reason why 25.03 is required in SPDK?
>>>>
>>>> When we do sub-module init on spdk master, it uses dpdk version
>>>> 25.03 from
>>> it's own sub-repo.
>>>> Our changes for vhost have already been pushed to spdk master. We
>>>> have also pushed the same dpdk changes in the spdk sub-repo "dpdk"
>>>> which is version 25.03. I was just ensuring that there is uniformity
>>>> in the 25.03
>>> codebase, whether it is on the spdk sub-repo or 25.03 within dpdk repo.
>>>
>>> Ok, still, it would be better for SPDK to uses LTS as we have no plans
>>> to add extra stable branches.
>>>
>>> Also, your series may be considered as a feature and not a bug fix, so
>>> even if
>>> 25.03 would be a stable branch (which it is not), it would not be
>>> backported against it.
>>
>> Understood. I would request that we merge my changes into DPDK mainline
>> before September 18 when the merge window closes for SPDK v25.09.
>>
>>>
>>>>
>>>>
>>>>> v2:
>>>>> - fixed warnings with e-mail address
>>>>> - fixed warnings with typos
>>>>> - there is a warning about __rte_packed_begin not being in pair
>>>>> with __rte_packed_end which on reading the code turns out to be
>>>>> false. It is an anomaly of how git-format generates the patch and
>>>>> how check-patch checks it.
>>>>
>>>> When sending a v2, please use -v2 so it is reflected in the email subject.
>>>> I will remember this for next time. Thank you for pointing that out.
>>>>
>>>>> Pravin M Bathija (3):
>>>>>     mailmap: add user
>>>>>     vhost_user: configure memory slots
>>>>>     vhost_user: support for memory regions
>>>>>
>>>>>    .mailmap               |   1 +
>>>>>    lib/vhost/rte_vhost.h  |   4 +
>>>>>    lib/vhost/vhost_user.c | 325
>>>>> +++++++++++++++++++++++++++++++++++------
>>>>>    lib/vhost/vhost_user.h |  10 ++
>>>>>    4 files changed, 296 insertions(+), 44 deletions(-)
>>>>
>>>>
>>>>
> 

