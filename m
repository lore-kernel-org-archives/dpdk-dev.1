Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A16F9B5F5
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Apr 2026 09:18:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3A8F4042C;
	Wed, 22 Apr 2026 11:18:26 +0200 (CEST)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTP id 7D77B402E0
 for <dev@dpdk.org>; Wed, 22 Apr 2026 11:18:25 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=7Gx7CD8voKpvmDNq+8mRKKADG8Irz6TKTPGhRw1sIn0=;
 b=d8Qhpk9+myJV9gyTGwLgOzy2wET1n9lY0RIW3rsdmk0L8oTtt1sNroj4Gl8dEVsXgupa0fHxy
 fhPFQcYd4dbLgwUxhq4pEhOxQOPgkncuex57SdacSi91wQsNjdU3p6EnRRwm/E2NzS6tOJ+J212
 Xgd3SY1uWpoGV8TZJmCaUFA=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4g0tlb5kYsz1T4M8;
 Wed, 22 Apr 2026 17:12:11 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 4EE954048F;
 Wed, 22 Apr 2026 17:18:22 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Apr 2026 17:18:22 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 22 Apr
 2026 17:18:21 +0800
Message-ID: <6270443d-38f4-4ab9-8898-e6c162867a53@huawei.com>
Date: Wed, 22 Apr 2026 17:18:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/15] power/kvm_vm: enforce enabled lcore ID check
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>, <dev@dpdk.org>, 
 <thomas@monjalon.net>, <fengchengwen@huawei.com>, <yangxingui@huawei.com>, 
 <zhanjie9@hisilicon.com>
References: <20260416030612.2379407-1-lihuisong@huawei.com>
 <20260416030612.2379407-2-lihuisong@huawei.com>
 <20260416084825.0a371d4a@phoenix.local>
 <46a0f67d-a8be-49a5-914c-e7a5f02ff3a8@huawei.com>
 <20260421072315.2a57d5df@phoenix.local>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260421072315.2a57d5df@phoenix.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100009.china.huawei.com (7.202.194.112)
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


On 4/21/2026 10:23 PM, Stephen Hemminger wrote:
> On Fri, 17 Apr 2026 10:51:48 +0800
> "lihuisong (C)" <lihuisong@huawei.com> wrote:
>
>> On 4/16/2026 11:48 PM, Stephen Hemminger wrote:
>>> On Thu, 16 Apr 2026 11:05:58 +0800
>>> Huisong Li <lihuisong@huawei.com> wrote:
>>>   
>>>> The locre ID in cpufreq power must be enabled core in application.
>>> Spelling error, use checkpatch next time, it runs a spell checker.
>>> Also run devtools/check-git-log there other issues in the commit messages.
>> Sorry for this.
>> Yeah, I used checkpatch.sh and check-git-log.sh before sent out.
>> But it didn't found this. I guess that because the "locre" is not a word.
>>>> Use rte_lcore_is_enabled to verify lcore_id.
>>>>
>>>> Fixes: 6f987b594fa6 ("power: refactor core power management")
>>>> Cc: stable@dpdk.org
>>>>
>>>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>>>> ---
>>> The rte_lcore_is_enabled() will return false for service lcores.
>>> Is this a bug or a feature here?
>> My understanding is that the ROLE_RTE core is used to tasks on data
>> plane and the ROLE_SERVICE core is used to periodic or control-plane tasks.
>> Currently, power management in DPDK is mainly processed based on
>> services on the data plane, like the usage in pmd_mgmt or l3fwd-power.
>> However, the tasks on the service cores may also occupy 100% CPU.
>> Therefore, power library or driver should be able to be work with these
>> tasks.
>>   From this perspective, allowing the ROLE_SERVICE core to set power has
>> the least impact on applications in this series.
>> what do you think, Stephen?
>
> Service lcore's are just things doing other work.
> They really should not be doing non-blocking poll, that is a mistake.
> The service cores are intended for control path things.
got it.
>
> The power API should ignore them in general but not break if a user
> calls a power API from a service thread.
What you suggest is that we should allow the service core to 
successfully set the power API?
I know this approach has the least impact.

However, pmd_mgmt lib is also used together with the data plane task of 
network devices.
They should only allow the ROLE_RTE core to use them.
I originally wanted to extract a common macro to verify the lcore in 
power lib.
This common macro is not appropriate to pmd_mgmt lib if this common 
macro counts ROLE_SERVICE core as valid.

But we don't know if aplication having the service core thread used 
cpufreq API.
Although they may not be used in general, it seems that we need allow 
the service core to set the cpufreq API.
