Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46F9F8E4A0
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Apr 2026 02:54:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1BED40650;
	Fri, 17 Apr 2026 04:54:04 +0200 (CEST)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com
 [113.46.200.223])
 by mails.dpdk.org (Postfix) with ESMTP id 770F940608
 for <dev@dpdk.org>; Fri, 17 Apr 2026 04:54:01 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=j7ia668geuVl9SmdSBU97WEdp1f7qbD6KvnKwDqJKdo=;
 b=C2FxB2Tx02a0PpPYDzanCa0x4GwDk7QYkxBRRPyiA+DWaire6JtEdvt/441As71tsQy0VxgT/
 l/4g/Xi08yhqUkQ6CW5pgGpjupz9PB4T7hip4N8LpnwVgia/lZMsGwxicTOxvTZX1+MYeX4ghYt
 UUf2zMjyUB9bFFEgGYv1F4s=
Received: from mail.maildlp.com (unknown [172.19.162.92])
 by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4fxfSB3xxBzmV69;
 Fri, 17 Apr 2026 10:47:38 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 6B9004056E;
 Fri, 17 Apr 2026 10:53:59 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Apr 2026 10:53:54 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 17 Apr
 2026 10:53:53 +0800
Message-ID: <4f28d51f-5af7-4561-a65b-14da05a0a26f@huawei.com>
Date: Fri, 17 Apr 2026 10:53:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/15] power: unify and improve lcore ID verification
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>, <dev@dpdk.org>, 
 <thomas@monjalon.net>, <fengchengwen@huawei.com>, <yangxingui@huawei.com>, 
 <zhanjie9@hisilicon.com>
References: <20260416030612.2379407-1-lihuisong@huawei.com>
 <20260416085146.7c268cb8@phoenix.local>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260416085146.7c268cb8@phoenix.local>
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


On 4/16/2026 11:51 PM, Stephen Hemminger wrote:
> On Thu, 16 Apr 2026 11:05:57 +0800
> Huisong Li <lihuisong@huawei.com> wrote:
>
>> This patch series reworks the lcore ID verification logic within the power
>> library to ensure consistency and improve maintainability. Currently, various
>> cpufreq drivers implement their own lcore ID checks, often relying on simple
>> range checks that do not account for whether a core is actually enabled in
>> the application.
>>
>> Key Changes:
>> 1. Replaces basic range checks with rte_lcore_is_enabled() across all
>>     cpufreq drivers (ACPI, AMD P-state, CPPC, Intel P-state, and KVM VM).
>>     This ensures the power library only operates on lcores assigned to the
>>     application.
>> 2. Introduces a common macro in the power library's internal headers to
>>     standardize lcore ID verification.
>> 3. Moves the verification logic from individual driver implementations up
>>     to the high-level framework API. This reduces duplication code and
>>     ensures that all drivers benefit from uniform validation.
>> 4. Updates the power QoS and PMD Management libraries to use the new macro.
>>
>> Huisong Li (15):
>>    power/kvm_vm: enforce enabled lcore ID check
>>    power/acpi_cpufreq: enforce enabled lcore ID check
>>    power/amd_pstate: enforce enabled lcore ID check
>>    power/cppc_cpufreq: enforce enabled lcore ID check
>>    power/intel_pstate: enforce enabled lcore ID check
>>    power: enforce enabled lcore ID check
>>    power: add a common macro to verify lcore ID
>>    power/pmd_mgmt: replace lcore ID verification with new macro
>>    power/qos: replace the lcore ID verification with new macro
>>    power/cpufreq: add the lcore ID verification to framework
>>    power/acpi_cpufreq: remove the verification of lcore ID
>>    power/amd_pstate: remove the verification of lcore ID
>>    power/cppc_cpufreq: remove the verification of lcore ID
>>    power/intel_pstate: remove the verification of lcore ID
>>    power/kvm_vm: remove the verification of lcore ID
>>
>>   drivers/power/acpi/acpi_cpufreq.c             | 65 -------------------
>>   drivers/power/amd_pstate/amd_pstate_cpufreq.c | 65 -------------------
>>   drivers/power/cppc/cppc_cpufreq.c             | 65 -------------------
>>   .../power/intel_pstate/intel_pstate_cpufreq.c | 65 -------------------
>>   drivers/power/kvm_vm/kvm_vm.c                 | 10 ---
>>   lib/power/power_common.h                      |  7 ++
>>   lib/power/rte_power_cpufreq.c                 | 14 ++++
>>   lib/power/rte_power_pmd_mgmt.c                | 25 ++-----
>>   lib/power/rte_power_qos.c                     | 10 +--
>>   9 files changed, 30 insertions(+), 296 deletions(-)
>>
> Patch 3 did not get sent in the series maybe too big or mail issue?
It is in the series. I can see it in dpdk patch list.
https://patches.dpdk.org/project/dpdk/patch/20260416030612.2379407-2-lihuisong@huawei.com/ 

