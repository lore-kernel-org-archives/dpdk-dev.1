Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC80CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 19:13:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D559E4026D;
	Mon, 10 Nov 2025 20:13:32 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 95BA540264
 for <dev@dpdk.org>; Mon, 10 Nov 2025 20:13:31 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3226D2F;
 Mon, 10 Nov 2025 11:13:23 -0800 (PST)
Received: from [10.122.38.161] (unknown [10.122.38.161])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC3A33F5A1;
 Mon, 10 Nov 2025 11:13:30 -0800 (PST)
Message-ID: <76b57d51-502d-4b46-94d9-6c2dab85de7f@arm.com>
Date: Mon, 10 Nov 2025 13:13:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] ring: safe partial ordering for head/tail update
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 David Marchand <david.marchand@redhat.com>
Cc: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Ola Liljedahl <ola.liljedahl@arm.com>,
 Dhruv Tripathi <dhruv.tripathi@arm.com>
References: <20251002174137.3612042-1-wathsala.vithanage@arm.com>
 <20251002174137.3612042-2-wathsala.vithanage@arm.com>
 <cfc073b8137541f1be3e01650d6bcf14@huawei.com>
 <566b4c6c-f081-4db8-bc8b-2a576a82e1c3@arm.com>
 <CAJFAV8yumnbPjakBAtkoqrZvWCo90F51Ri9Eje44sAmm_S43gw@mail.gmail.com>
 <7b9710689ad44caba2c9868967ac97d7@huawei.com>
Content-Language: en-US
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
In-Reply-To: <7b9710689ad44caba2c9868967ac97d7@huawei.com>
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


On 11/10/25 04:25, Konstantin Ananyev wrote:
> Hi David,
>
>> Hello Wathsala,
>>
>> On Mon, 13 Oct 2025 at 20:10, Wathsala Vithanage
>> <wathsala.vithanage@arm.com> wrote:
>>>> LGTM, though. I think that we also need to make similar changes in
>>>> rte_ring_hts_elem_pvt.h and rte_ring_rts_elem_pvt.h:
>>>> for CAS use 'acq_rel' order instead of simple 'acquire'.
>>>> Let me know would you have a bandwidth to do that.
>>> My bad, I forgot those two cases. I will send a v3.
>> Should we wait for this v3?
>> We want to close rc2 this week.
>>
> Just submitted v3 with discussed extra changes.
> Also added fixes, cc to stable, etc.
> Hope it still can make 25.11
> Wathsala, pls shout or submit v4 if you feel something is missing.
> Thanks
> Konstantin

Thanks Konstantin, you beat me to the punch. I have a slightly different 
version with comments explaining the synchronizes with relationships. If 
you don't mind I can send it as V4.

--wathsala



