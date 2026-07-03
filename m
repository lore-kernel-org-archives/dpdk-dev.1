Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37815C43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 04:07:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A132402D1;
	Fri,  3 Jul 2026 06:07:13 +0200 (CEST)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id 26A8540291
 for <dev@dpdk.org>; Fri,  3 Jul 2026 06:07:10 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=nEDOq9znT0ebNaBR4F25oq2q6oDZgsjr8zXFQowO/wE=;
 b=ZPdTlt1mru4HmbZE9407+cZUiheEPP0Jb18GY+/t1BvW2ZudcP0PnhkpQs/W1D8u6X2aSzs0V
 XnQOj8TV1bsRBcTmp+GHjXGSMqLBcKr4DUhcbKQzijY/ncp0wjvMy2YT5oL0derYX82tdZj1vmq
 F0cObo9dKfcULsfnMLGy63s=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gs0Mm68G5zRhQt;
 Fri,  3 Jul 2026 11:57:56 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
 by mail.maildlp.com (Postfix) with ESMTPS id 5A4F140575;
 Fri,  3 Jul 2026 12:07:06 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 3 Jul
 2026 12:07:05 +0800
Message-ID: <64f3e01b-f8cd-4c94-9fa2-dfb3ce687bb1@huawei.com>
Date: Fri, 3 Jul 2026 12:07:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] examples/l3fwd-power: fix uncore deinit for
 non-legacy
To: "Macnamara, Chris" <chris.macnamara@intel.com>,
 <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, 
 <john.mcnamara@intel.com>, <lihuisong@huawei.com>
References: <20260526081138.1434947-1-lihuisong@huawei.com>
 <20260526081138.1434947-2-lihuisong@huawei.com>
 <6df97f76-27d7-49f2-8d23-30601c12ca0a@intel.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <6df97f76-27d7-49f2-8d23-30601c12ca0a@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo100005.china.huawei.com (7.202.195.212)
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

Hi Macnamara,

Thanks for your review.


On 7/2/2026 7:06 PM, Macnamara, Chris wrote:
>> Uncore resources were not being deinitialized in non-legacy modes (such
>> as pmd-mgmt), causing the uncore frequency not to return to its original
>> value after the application exited.
>>
>> The root cause is that uncore initialization can be performed for all
>> modes, whereas the deinitialization logic is incorrectly restricted
>> to legacy mode only. So do the deinitialization of uncore on all app
>> modes.
>>
>> Fixes: 10db2a5b8724 ("examples/l3fwd-power: add options for uncore 
>> frequency")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   examples/l3fwd-power/main.c | 66 ++++++++++++++++++++-----------------
>>   1 file changed, 35 insertions(+), 31 deletions(-)
>>
>> diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
>> index 02ec17d799..1122aeb930 100644
>> --- a/examples/l3fwd-power/main.c
>> +++ b/examples/l3fwd-power/main.c
>> @@ -2271,28 +2271,31 @@ init_power_library(void)
>>       unsigned int lcore_id;
>>       int ret = 0;
>>   -    RTE_LCORE_FOREACH(lcore_id) {
>> -        /* init power management library */
>> -        ret = rte_power_init(lcore_id);
>> -        if (ret) {
>> -            RTE_LOG(ERR, L3FWD_POWER,
>> -                "Library initialization failed on core %u\n",
>> -                lcore_id);
>> -            return ret;
>> -        }
>> -        /* we're not supporting the VM channel mode */
>> -        env = rte_power_get_env();
>> -        if (env != PM_ENV_ACPI_CPUFREQ &&
>> -                env != PM_ENV_PSTATE_CPUFREQ &&
>> -                env != PM_ENV_AMD_PSTATE_CPUFREQ &&
>> -                env != PM_ENV_CPPC_CPUFREQ) {
>> -            RTE_LOG(ERR, L3FWD_POWER,
>> -                "Only ACPI and PSTATE mode are supported\n");
>> -            return -1;
>> +    /* only legacy mode relies on the initialization of cpufreq 
>> library */
>> +    if (app_mode == APP_MODE_LEGACY) {
>> +        RTE_LCORE_FOREACH(lcore_id) {
>> +            /* init power management library */
>> +            ret = rte_power_init(lcore_id);
>> +            if (ret) {
>> +                RTE_LOG(ERR, L3FWD_POWER,
>> +                    "Library initialization failed on core %u\n",
>> +                    lcore_id);
>> +                return ret;
>> +            }
>> +            /* we're not supporting the VM channel mode */
>> +            env = rte_power_get_env();
>> +            if (env != PM_ENV_ACPI_CPUFREQ &&
>> +                    env != PM_ENV_PSTATE_CPUFREQ &&
>> +                    env != PM_ENV_AMD_PSTATE_CPUFREQ &&
>> +                    env != PM_ENV_CPPC_CPUFREQ) {
>> +                RTE_LOG(ERR, L3FWD_POWER,
>> +                    "Only ACPI and PSTATE mode are supported\n");
>> +                return -1;
>> +            }
>>           }
>>       }
>>   -    if (cpu_resume_latency != -1) {
>> +    if (app_mode == APP_MODE_LEGACY && cpu_resume_latency != -1) {
>>           RTE_LCORE_FOREACH(lcore_id) {
>>               /* Back old CPU resume latency. */
>>               ret = rte_power_qos_get_cpu_resume_latency(lcore_id);
>> @@ -2329,14 +2332,16 @@ deinit_power_library(void)
>>       unsigned int lcore_id, max_pkg, max_die, die, pkg;
>>       int ret = 0;
>>   -    RTE_LCORE_FOREACH(lcore_id) {
>> -        /* deinit power management library */
>> -        ret = rte_power_exit(lcore_id);
>> -        if (ret) {
>> -            RTE_LOG(ERR, L3FWD_POWER,
>> -                "Library deinitialization failed on core %u\n",
>> -                lcore_id);
>> -            return ret;
>> +    if (app_mode == APP_MODE_LEGACY) {
>> +        RTE_LCORE_FOREACH(lcore_id) {
>> +            /* deinit power management library */
>> +            ret = rte_power_exit(lcore_id);
>> +            if (ret) {
>> +                RTE_LOG(ERR, L3FWD_POWER,
>> +                    "Library deinitialization failed on core %u\n",
>> +                    lcore_id);
>> +                return ret;
>> +            }
>>           }
>>       }
>>   @@ -2360,7 +2365,7 @@ deinit_power_library(void)
>>           }
>>       }
>>   -    if (cpu_resume_latency != -1) {
>> +    if (app_mode == APP_MODE_LEGACY && cpu_resume_latency != -1) {
>>           RTE_LCORE_FOREACH(lcore_id) {
>>               /* Restore the original value. */
>>               rte_power_qos_set_cpu_resume_latency(lcore_id,
>
> Agree there is an issue with uncore deinit.
>
> cpu_resume_latency & init_power_library: After this patch, 
> cpu_resume_latency (for C-state PM QoS control) is gated behind 
> APP_MODE_LEGACY even though it's orthogonal to the cpufreq library, so 
> it's silently ignored in pmd-mgmt/interrupt modes. It’s used for C 
> state management which applies in other modes such as interrupt mode.
Yeah, so patch 2/5 lets PM QoS can be used for all mode.
>
> Also init_power_library() now has both its blocks legacy-guarded 
> internally, the newly-unconditional call by removing APP_MODE_LEGACY 
> to it is a no-op in non-legacy modes. This leaves the two functions 
> inconsistent: init_power_library() does nothing outside legacy mode, 
> whereas deinit_power_library() still has real work to do in every mode 
> because of the uncore cleanup.
Yes, use this method to deinitialize the uncore.
Currently, the initialization of uncore is located in the parameter 
parsing function, which lead to the inconsistent.
>
> Consider, keep the APP_MODE_LEGACY guard at the init call site as the 
> init is truly legacy only or split the uncore teardown into its own 
> deinit_uncore() so that deinit_power_library() stays strictly about 
> cpufreq.
This patch doesn't plan to change the original logical about uncore.
The initialization or deinitialization of all power libs is completed in 
the same function. It is good to user.
And patch 4/5 is doing this.

In addition, I think the initialization for power libs is a little 
scattered in usage.
I am thinking how to simply these initializations for user.
For example, fill a configuration about power then call one power_init 
ops to complete all initialization.
Anyway, the current changes being made are also beneficial for this matter.
>
>
