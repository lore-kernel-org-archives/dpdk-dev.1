Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094D0606A324
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 04:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=A7pLg1QO
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1987340264;
	Mon,  2 Nov 2026 05:13:12 +0100 (CET)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTPS id DEA5D4003C
 for <dev@dpdk.org>; Mon,  2 Nov 2026 05:13:10 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=E94mVWRZ+L/ORsfDOW/PmwjaDQ/aFknNSUCQ/qUpq3U=;
 b=A7pLg1QO+CdTr9CyFPTuMAOmXy1SDbcZQ0xXgCjvXpNU9wyrC0ZZg3kXWIWz7UAoHF4b8/wXx
 NxbNE0vbfwW/kpx1zXxfujGh1g6cKSmoGUW6HfHOOSKMgfWdQCWUYJ1bzHDnlC1qxIxQ4+R+wN+
 JAlNoShIjMBV69ghXCKnw/8=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4jHywZ3xbSzpSxf;
 Mon,  2 Nov 2026 12:12:46 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 906DB40575;
 Mon,  2 Nov 2026 12:13:07 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 2 Nov 2026 12:13:07 +0800
Message-ID: <cf705046-36bd-4b38-bc56-6106bbba335b@huawei.com>
Date: Mon, 2 Nov 2026 12:13:06 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] examples/l3fwd: dynamic NUMA-aware alloc lcore_conf
To: Thomas Monjalon <thomas@monjalon.net>, Konstantin Ananyev
 <konstantin.v.ananyev@yandex.ru>
CC: <stephen@networkplumber.org>, <dev@dpdk.org>
References: <20260623032301.17570-1-fengchengwen@huawei.com>
 <xvTXknUbSMSD_Fg-tQD_aw@monjalon.net>
 <4687e093-ac82-4ac7-aac5-838be6c52433@huawei.com>
 <ksiekRtOSqOSIIkKFdXdAw@monjalon.net>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <ksiekRtOSqOSIIkKFdXdAw@monjalon.net>
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
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/1/2026 10:26 PM, Thomas Monjalon wrote:
> 31/10/2026 02:37, fengchengwen:
>> On 10/30/2026 8:59 PM, Thomas Monjalon wrote:
>>> 30/10/2026 11:52, Konstantin Ananyev:
>>>>> BTW: SOCKET_ID_ANY seemed need redefined as RTE_SOCKET_ID_ANY, If there is no
>>>>>       objection, I will make the changes in the next independent patch.
>>>>
>>>> Yep, that's probably a good thing to do, and probably 26.11 is a good 
>>>> time to do that.
>>>> BTW, I think it was discussed before, but I can't remember why we didn't 
>>>> fix it so far.
>>>
>>> 1/ We should not break this API easily as it is used a lot.
>>> If we do the change we need to keep the compat alias for some time.
>>>
>>> 2/ The term SOCKET is used in many places instead of NUMA.
>>> There is a confusion between CPU and memory which deserves to be fixed.
>>>
>>
>> My plan is a 3-patch series:
>> 1. Add RTE_SOCKET_ID_ANY and deprecation documentation.
>> 2. Replace all in-tree SOCKET_ID_ANY with RTE_SOCKET_ID_ANY.
>> 3. Mark SOCKET_ID_ANY with RTE_DEPRECATED after in-tree migration completes,
>>    so warnings only hit out-of-tree users while DPDK itself builds cleanly.
>>
>> I will avoid the bigger "socket -> NUMA node" terminology refactor in this series.
>> That would be a massive semantic change with large churn, better handled via separate
>> RFC later.
>>
>> If this plan looks acceptable, I will start the implementation.
> 
> My doubt is that while introducing a new API,
> it may be better to apply it in correct places with correct definition,
> avoiding mixing CPU and memory.

OK, I will try to implement it (avoiding mixing CPU and memory)

> 
> 

