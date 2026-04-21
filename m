Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155B9F8925C
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Apr 2026 11:07:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44E564029D;
	Tue, 21 Apr 2026 13:07:17 +0200 (CEST)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id BC6F94027C
 for <dev@dpdk.org>; Tue, 21 Apr 2026 13:07:15 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=oIL046+itCFT60gMTyHFz0Is1w0kyCfRuW+aapxSNq8=;
 b=OCjPnYm2BzIQRXzlJ/yQU6ixCuqfzBiutZup1a5+ZlkdJCkkWB0DJYC8qU2FCToHuaZvKV6PW
 hjv0PAht8+1mnLvYjGPmucmszH/lFbmlYoK4r2vsftS1BIlAOm23HmfmO0k8i69/zGpkI5hkGUf
 hTRMT09DVnj7Hg6IJYWz1Z8=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4g0KC42SBJzcb19;
 Tue, 21 Apr 2026 19:00:32 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
 by mail.maildlp.com (Postfix) with ESMTPS id 81E7A40571;
 Tue, 21 Apr 2026 19:07:13 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Apr 2026 19:07:13 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 21 Apr
 2026 19:07:12 +0800
Message-ID: <74f2cac1-e2a9-4a0f-8e99-424347ce3576@huawei.com>
Date: Tue, 21 Apr 2026 19:07:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/15] power/kvm_vm: enforce enabled lcore ID check
From: "lihuisong (C)" <lihuisong@huawei.com>
To: <sivaprasad.tummala@amd.com>
CC: <anatoly.burakov@intel.com>, <dev@dpdk.org>, <thomas@monjalon.net>,
 <fengchengwen@huawei.com>, <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, 
 Stephen Hemminger <stephen@networkplumber.org>
References: <20260416030612.2379407-1-lihuisong@huawei.com>
 <20260416030612.2379407-2-lihuisong@huawei.com>
 <20260416084825.0a371d4a@phoenix.local>
 <46a0f67d-a8be-49a5-914c-e7a5f02ff3a8@huawei.com>
In-Reply-To: <46a0f67d-a8be-49a5-914c-e7a5f02ff3a8@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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


On 4/17/2026 10:51 AM, lihuisong (C) wrote:
>
> On 4/16/2026 11:48 PM, Stephen Hemminger wrote:
>> On Thu, 16 Apr 2026 11:05:58 +0800
>> Huisong Li <lihuisong@huawei.com> wrote:
>>
>>> The locre ID in cpufreq power must be enabled core in application.
>> Spelling error, use checkpatch next time, it runs a spell checker.
>> Also run devtools/check-git-log there other issues in the commit 
>> messages.
> Sorry for this.
> Yeah, I used checkpatch.sh and check-git-log.sh before sent out.
> But it didn't found this. I guess that because the "locre" is not a word.
>>> Use rte_lcore_is_enabled to verify lcore_id.
>>>
>>> Fixes: 6f987b594fa6 ("power: refactor core power management")
>>> Cc: stable@dpdk.org
>>>
>>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>>> ---
>> The rte_lcore_is_enabled() will return false for service lcores.
>> Is this a bug or a feature here?
> My understanding is that the ROLE_RTE core is used to tasks on data 
> plane and the ROLE_SERVICE core is used to periodic or control-plane 
> tasks.
> Currently, power management in DPDK is mainly processed based on 
> services on the data plane, like the usage in pmd_mgmt or l3fwd-power.
> However, the tasks on the service cores may also occupy 100% CPU.
> Therefore, power library or driver should be able to be work with 
> these tasks.
> From this perspective, allowing the ROLE_SERVICE core to set power has 
> the least impact on applications in this series.
> what do you think, Stephen?
Hi Sivaprasad,

Do you think we need to allow the role_service core to set cpufreq?

/Huisong
