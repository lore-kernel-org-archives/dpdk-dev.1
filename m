Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C162BF8E4A0
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Apr 2026 02:51:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B856940608;
	Fri, 17 Apr 2026 04:51:54 +0200 (CEST)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTP id D16EB402E0
 for <dev@dpdk.org>; Fri, 17 Apr 2026 04:51:52 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=twY19SLykMBleG4c/7sKZXF7Tk3RcjXZUubYJnvBcvs=;
 b=JA732B1eizon5cHMICfDMC5IDoI76ShCmAd5vfRPuZJEuogy/EalWIOxhr8SVVCOGYRVsPbgV
 6QXNGgQNvTNnKIdPO91idPURv4oxD52eIe8aVAb/GK06u6sZZYSJYv1foD8jotUKLWk3B8Nqdg+
 56ubVqe0SRX/Sx9htxgxkUY=
Received: from mail.maildlp.com (unknown [172.19.162.140])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fxfPn2M3hz12LDP;
 Fri, 17 Apr 2026 10:45:33 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 5029F2012A;
 Fri, 17 Apr 2026 10:51:50 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Apr 2026 10:51:50 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 17 Apr
 2026 10:51:49 +0800
Message-ID: <46a0f67d-a8be-49a5-914c-e7a5f02ff3a8@huawei.com>
Date: Fri, 17 Apr 2026 10:51:48 +0800
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
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260416084825.0a371d4a@phoenix.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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


On 4/16/2026 11:48 PM, Stephen Hemminger wrote:
> On Thu, 16 Apr 2026 11:05:58 +0800
> Huisong Li <lihuisong@huawei.com> wrote:
>
>> The locre ID in cpufreq power must be enabled core in application.
> Spelling error, use checkpatch next time, it runs a spell checker.
> Also run devtools/check-git-log there other issues in the commit messages.
Sorry for this.
Yeah, I used checkpatch.sh and check-git-log.sh before sent out.
But it didn't found this. I guess that because the "locre" is not a word.
>> Use rte_lcore_is_enabled to verify lcore_id.
>>
>> Fixes: 6f987b594fa6 ("power: refactor core power management")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
> The rte_lcore_is_enabled() will return false for service lcores.
> Is this a bug or a feature here?
My understanding is that the ROLE_RTE core is used to tasks on data 
plane and the ROLE_SERVICE core is used to periodic or control-plane tasks.
Currently, power management in DPDK is mainly processed based on 
services on the data plane, like the usage in pmd_mgmt or l3fwd-power.
However, the tasks on the service cores may also occupy 100% CPU.
Therefore, power library or driver should be able to be work with these 
tasks.
 From this perspective, allowing the ROLE_SERVICE core to set power has 
the least impact on applications in this series.
what do you think, Stephen?
