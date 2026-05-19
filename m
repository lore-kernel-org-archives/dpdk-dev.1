Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CB3CD5BA4
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 13:09:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F4DF40296;
	Tue, 19 May 2026 15:09:54 +0200 (CEST)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com
 [113.46.200.227])
 by mails.dpdk.org (Postfix) with ESMTP id 87C324025E
 for <dev@dpdk.org>; Tue, 19 May 2026 15:09:51 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=15MO0aQecAYM+t4p33p2y3ucATLZTNIOzCazBwRoaQQ=;
 b=kyRlN/Am6JL57U1wCJvS27VeDbKA5jkoXrGWD0uLEo65S63euACzBewMP9oA2AoOhKIbIGYgS
 +5Qo5p/2LBTSKTGpeD+V+igngiE5PNCH8faui4xBLmCpqomUvptd5YnG/smVi7eQRqGu/jBeude
 rMxQEh2t2/bgOLwKgKG+ELI=
Received: from mail.maildlp.com (unknown [172.19.163.127])
 by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gKZbF3lgkznTVy;
 Tue, 19 May 2026 21:02:49 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id BA65440572;
 Tue, 19 May 2026 21:09:48 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 May 2026 21:09:48 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 19 May
 2026 21:09:47 +0800
Message-ID: <a7483ea3-1ad7-4bb5-91d5-fa8539331c98@huawei.com>
Date: Tue, 19 May 2026 21:09:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/15] power: unify and improve lcore ID verification
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>, <dev@dpdk.org>, 
 <thomas@monjalon.net>, <fengchengwen@huawei.com>, <yangxingui@huawei.com>, 
 <zhanjie9@hisilicon.com>
References: <20260416030612.2379407-1-lihuisong@huawei.com>
 <20260507024230.1198111-1-lihuisong@huawei.com>
 <20260518105954.2309f802@phoenix.local>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260518105954.2309f802@phoenix.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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

Thanks for giving me this AI review feedback.
Some of them are still acceptable. will fix it in next version.

Is this summary from AI generated for each patche series?
May ask where you obtained this information about AI review?


On 5/19/2026 1:59 AM, Stephen Hemminger wrote:
> On Thu, 7 May 2026 10:42:15 +0800
> Huisong Li <lihuisong@huawei.com> wrote:
>
>> This patch series reworks the lcore ID verification logic within the
>> power library to ensure consistency and improve maintainability.
>>
>> Currently, various cpufreq drivers implement their own lcore ID checks,
>> which are limited to simple range validation and involve significant
>> code duplication. Moreover, these checks do not account for whether the
>> core is actually managed by the application.
>>
>> For the verification in cpufreq-related APIs and power QoS APIs, although
>> service cores do not typically invoke these APIs, they may operate in
>> polling modes where power management is required. To maintain compatibility
>> with applications using service cores, the validation logic now explicitly
>> allows both ROLE_RTE and ROLE_SERVICE.
>>
>> But the lcore ID in the pmd_mgmt library must be ROLE_RTE because it is
>> mainly used together with the data plane of ethdev PMD. So use
>> rte_lcore_is_enabled to verify.
>>
>> Key Changes:
>> 1. Add lcore role verification to individual cpufreq drivers.
>> 2. Introduces a unified macro in the power library to standardize lcore ID
>>     checks.
>> 3. Moves verification logic from individualdrivers to the framework level.
>>     This reduces code duplication.
>> 4. Allow the service cores to configure power QoS.
>> 5. Use rte_lcore_is_enabled to verfify the lcore ID in pmd_mgmt.
>>
>> ---
>> v2:
>>   - Allow the service cores to set power API.
>>
>> ---
>>
>> Huisong Li (15):
>>    eal: add interface to check if lcore is EAL managed
>>    power/kvm_vm: validate lcore role in cpufreq API
>>    power/acpi_cpufreq: validate lcore role in cpufreq API
>>    power/amd_pstate: validate lcore role in cpufreq API
>>    power/cppc_cpufreq: validate lcore role in cpufreq API
>>    power/intel_pstate: validate lcore role in cpufreq API
>>    power: add a common macro to verify lcore ID
>>    power/cpufreq: add the lcore ID verification to framework
>>    power/acpi_cpufreq: remove the verification of lcore ID
>>    power/amd_pstate: remove the verification of lcore ID
>>    power/cppc_cpufreq: remove the verification of lcore ID
>>    power/intel_pstate: remove the verification of lcore ID
>>    power/kvm_vm: remove the verification of lcore ID
>>    power: allow the service core to config power QoS
>>    power: add lcore ID check for PMD mgmt
>>
>>   drivers/power/acpi/acpi_cpufreq.c             | 65 -------------------
>>   drivers/power/amd_pstate/amd_pstate_cpufreq.c | 65 -------------------
>>   drivers/power/cppc/cppc_cpufreq.c             | 65 -------------------
>>   .../power/intel_pstate/intel_pstate_cpufreq.c | 65 -------------------
>>   drivers/power/kvm_vm/kvm_vm.c                 | 10 ---
>>   lib/eal/common/eal_common_lcore.c             | 11 ++++
>>   lib/eal/include/rte_lcore.h                   | 11 ++++
>>   lib/power/power_common.h                      |  7 ++
>>   lib/power/rte_power_cpufreq.c                 | 14 +++-
>>   lib/power/rte_power_pmd_mgmt.c                | 21 +++---
>>   lib/power/rte_power_qos.c                     | 10 +--
>>   11 files changed, 55 insertions(+), 289 deletions(-)
>>
> Lots of AI review feedback on this one:
>
> Patch 01/15: eal: add interface to check if lcore is EAL managed
> =================================================================
>
> Warning: New public API rte_lcore_is_eal_managed() is exported as
> a stable ABI symbol (RTE_EXPORT_SYMBOL), but DPDK policy requires
> new public APIs to be introduced as experimental:
>
>      +RTE_EXPORT_SYMBOL(rte_lcore_is_eal_managed)
>      +int rte_lcore_is_eal_managed(unsigned int lcore_id)
>
> The declaration in rte_lcore.h is also missing the __rte_experimental
> attribute. The export should be:
>
>      RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_lcore_is_eal_managed, 26.07)
>      int rte_lcore_is_eal_managed(unsigned int lcore_id)
>
> and the prototype in lib/eal/include/rte_lcore.h should carry
> __rte_experimental.
>
> Warning: This series adds a new public API but does not update the
> release notes in doc/guides/rel_notes/release_26_07.rst (or whatever
> the current target release is). New API additions must be documented
> in the release notes under the "New Features" section.
>
>
> Patch 07/15: power: add a common macro to verify lcore ID
> =========================================================
>
> Info: The macro evaluates lcore_id twice (once in
> rte_lcore_is_eal_managed() and once in POWER_LOG). All current
> call-sites pass a plain variable so there is no observable bug, but
> a side-effecting argument would be evaluated twice. Same caveat
> applies to the existing RTE_ETH_VALID_PORTID_OR_ERR_RET pattern, so
> this is consistent with existing DPDK convention.
>
>
> Patch 14/15: power: allow the service core to config power QoS
> ==============================================================
>
> Info: The check changes from rte_lcore_is_enabled() (ROLE_RTE only)
> to rte_lcore_is_eal_managed() (ROLE_RTE + ROLE_SERVICE), so the log
> message wording changes from "is not enabled" to the macro's "is
> invalid" text. For a service core that was previously rejected, the
> new "invalid" wording is less informative than the prior message,
> but this is minor.
>
>
> Patch 15/15: power: add lcore ID check for PMD mgmt
> ====================================================
>
> Info: This patch tightens the validation from "lcore_id within
> RTE_MAX_LCORE range" to "lcore_id is ROLE_RTE". Combined with the
> Fixes: tag and Cc: stable, this is a behavioural change in stable
> branches: callers that previously passed a non-enabled lcore_id
> (ROLE_OFF / ROLE_SERVICE / ROLE_NON_EAL) will now receive -EINVAL
> where they previously succeeded into the function body. The commit
> message correctly justifies the data-plane (ROLE_RTE) requirement,
> but the behaviour change should be called out explicitly in the
> commit log so stable maintainers and downstream users are aware.
>
>
> Series-level observation
> ========================
>
> Info: Patches 02-06 add per-driver lcore role checks, and patches
> 09-13 remove the same checks once patch 08 lifts validation into
> the framework. The net effect is that each driver's lcore check is
> modified and then deleted within the same series. The series could
> be reorganized to:
>
>    1. Patch 01: add rte_lcore_is_eal_managed()
>    2. Patch 07: add the RTE_POWER_VALID_LCOREID_OR_ERR_RET macro
>    3. Patch 08: add validation to the framework (rte_power_cpufreq.c)
>    4. Patches 14, 15: pmd_mgmt and QoS adjustments
>
> skipping patches 02-06 and 09-13 entirely. This would reduce review
> load and avoid intermediate states where the same check exists in
> two places. If the current structure is intentional for incremental
> bisection, that rationale would be worth mentioning in a cover
> letter.
