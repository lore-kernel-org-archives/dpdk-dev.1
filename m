Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFA3606A326
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 02:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=zt3LUNfy
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9476E40281;
	Wed,  4 Nov 2026 03:08:58 +0100 (CET)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com
 [113.46.200.223])
 by mails.dpdk.org (Postfix) with ESMTPS id CE92F4026E
 for <dev@dpdk.org>; Wed,  4 Nov 2026 03:08:56 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=oCkrqQLbcp8jgvS3FLct9k+tRRgE4jK3xa8BVvaDbeo=;
 b=zt3LUNfyrXoIH2xrjpx8S0C/RRM/X8TpNuCqRhN0V0ABeB01JbGmpYBZzjCMrQaiMaqSjeaTt
 wMxPvTKNDgBFY1nvU5hhp31XoxAcOQqnVN6hM1bAEeraHZ7764yv1RjWW0G45pgEd7jgUiO8ekD
 UNdOJ8fkHDy4T34oKyZkyp8=
Received: from mail.maildlp.com (unknown [172.19.163.200])
 by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4jK84V2PVRzmVZw;
 Wed,  4 Nov 2026 10:08:42 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id D82464055B;
 Wed,  4 Nov 2026 10:08:52 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 4 Nov 2026 10:08:52 +0800
Message-ID: <714a77be-ce37-4ebe-8cb5-96fbc6cdffe9@huawei.com>
Date: Wed, 4 Nov 2026 10:08:51 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] examples/l3fwd: dynamic NUMA-aware alloc lcore_conf
From: fengchengwen <fengchengwen@huawei.com>
To: Thomas Monjalon <thomas@monjalon.net>, Konstantin Ananyev
 <konstantin.v.ananyev@yandex.ru>
CC: <stephen@networkplumber.org>, <dev@dpdk.org>
References: <20260623032301.17570-1-fengchengwen@huawei.com>
 <xvTXknUbSMSD_Fg-tQD_aw@monjalon.net>
 <4687e093-ac82-4ac7-aac5-838be6c52433@huawei.com>
 <ksiekRtOSqOSIIkKFdXdAw@monjalon.net>
 <cf705046-36bd-4b38-bc56-6106bbba335b@huawei.com>
Content-Language: en-US
In-Reply-To: <cf705046-36bd-4b38-bc56-6106bbba335b@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/2026 12:13 PM, fengchengwen wrote:
> On 11/1/2026 10:26 PM, Thomas Monjalon wrote:
>> 31/10/2026 02:37, fengchengwen:
>>> On 10/30/2026 8:59 PM, Thomas Monjalon wrote:
>>>> 30/10/2026 11:52, Konstantin Ananyev:
>>>>>> BTW: SOCKET_ID_ANY seemed need redefined as RTE_SOCKET_ID_ANY, If there is no
>>>>>>       objection, I will make the changes in the next independent patch.
>>>>>
>>>>> Yep, that's probably a good thing to do, and probably 26.11 is a good 
>>>>> time to do that.
>>>>> BTW, I think it was discussed before, but I can't remember why we didn't 
>>>>> fix it so far.
>>>>
>>>> 1/ We should not break this API easily as it is used a lot.
>>>> If we do the change we need to keep the compat alias for some time.
>>>>
>>>> 2/ The term SOCKET is used in many places instead of NUMA.
>>>> There is a confusion between CPU and memory which deserves to be fixed.
>>>>
>>>
>>> My plan is a 3-patch series:
>>> 1. Add RTE_SOCKET_ID_ANY and deprecation documentation.
>>> 2. Replace all in-tree SOCKET_ID_ANY with RTE_SOCKET_ID_ANY.
>>> 3. Mark SOCKET_ID_ANY with RTE_DEPRECATED after in-tree migration completes,
>>>    so warnings only hit out-of-tree users while DPDK itself builds cleanly.
>>>
>>> I will avoid the bigger "socket -> NUMA node" terminology refactor in this series.
>>> That would be a massive semantic change with large churn, better handled via separate
>>> RFC later.
>>>
>>> If this plan looks acceptable, I will start the implementation.
>>
>> My doubt is that while introducing a new API,
>> it may be better to apply it in correct places with correct definition,
>> avoiding mixing CPU and memory.
> 
> OK, I will try to implement it (avoiding mixing CPU and memory)

I have sent out the full patch series for the tree-wide NUMA terminology
refactor as we briefly discussed. The overall modification scope is
quite large, touching many areas across DPDK.

I understand this brings substantial code churn and API compatibility
concerns. I would appreciate hearing feedback and guidance from the
community on how we should proceed.

Regards,
Chengwen

> 
>>
>>
> 

