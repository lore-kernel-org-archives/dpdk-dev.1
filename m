Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB5AC5B56A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 12:34:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED41E40E1F;
	Tue, 11 Aug 2026 14:34:03 +0200 (CEST)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id 90DCF4027F
 for <dev@dpdk.org>; Tue, 11 Aug 2026 14:34:01 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=tr/adHyjWdRXkaLedsiqLDi0iwjZtzVWBmUXZ1lnJvc=;
 b=dG+VQQWjTUiZ9lD6WdIXKCzl/xXnpgE1qorDVWdk1/X7OlmqM/HVdU5HJaq/hHO02i7k8MPGr
 3M0ICxKXWX4+5CIqWSGyhYKafl70rCAZNddfznbfG2TyZ9KqEMN8HyJsl09upHjmTaZDhTjs2Vd
 6OdmtYkXABh05QMzjtnxm6w=
Received: from mail.maildlp.com (unknown [172.19.162.197])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hK9kl1hxczpSvB;
 Tue, 11 Aug 2026 20:23:11 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
 by mail.maildlp.com (Postfix) with ESMTPS id 4B76540579;
 Tue, 11 Aug 2026 20:33:53 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Aug
 2026 20:33:52 +0800
Message-ID: <0f39f5c6-7a39-4b7b-a934-f3464a2cdddd@huawei.com>
Date: Tue, 11 Aug 2026 20:33:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] power: uncore power improvements and auto-detection
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>, <dev@dpdk.org>, 
 <thomas@monjalon.net>, <fengchengwen@huawei.com>, <yangxingui@huawei.com>, 
 <zhanjie9@hisilicon.com>
References: <20260729025149.2158868-1-lihuisong@huawei.com>
 <20260810092148.24aafd71@phoenix.local>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260810092148.24aafd71@phoenix.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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


On 8/11/2026 12:21 AM, Stephen Hemminger wrote:
> On Wed, 29 Jul 2026 10:51:43 +0800
> Huisong Li <lihuisong@huawei.com> wrote:
>
>> This series improves the uncore power management in l3fwd-power
>> and adds automatic detection of uncore drivers in the power library.
>>
>> - Fix uncore deinitialization for non-legacy modes.
>> - Enable power QoS for all modes (not just legacy).
>> - Fix uncore help text and log messages.
>> - Relocate uncore initialization from arg parsing to init_power_library().
>> - Support automatic probing of uncore drivers in AUTO_DETECT and delete
>>    useless code for auto-detection uncore environment.
>>
>> ---
>>   v4:
>>   - Fix '!global_uncore_ops' to 'global_uncore_ops == NULL' from AI review.
>>   v3 link:
>>    https://inbox.dpdk.org/dev/20260728120208.1858832-1-lihuisong@huawei.com/
>>
>>   v3:
>>   - update feature to release_26_11.rst.
>>   - add a new patch to delte useless for automatic detection environment.
>>   v2 link:
>>    https://inbox.dpdk.org/dev/20260526081138.1434947-1-lihuisong@huawei.com/
>>
>>   v2:
>>   - Remove the patch which add global uncore init and deinit interface.
>>   - Remove the last patch in l3fwd-power about these new interface.
>>     Will send them after this series.
>>   v1 link:
>>    https://inbox.dpdk.org/dev/20260512023513.460169-1-lihuisong@huawei.com/
>>
>> Huisong Li (6):
>>    examples/l3fwd-power: fix uncore deinit for non-legacy
>>    examples/l3fwd-power: enable power QoS for all modes
>>    examples/l3fwd-power: fix uncore help and log info
>>    examples/l3fwd-power: relocate uncore initialization
>>    power: support automatic detection of uncore driver
>>    power: remove unused auto-detection uncore
>>
>>   doc/guides/rel_notes/release_26_11.rst        |   6 +
>>   .../sample_app_ug/l3_forward_power_man.rst    |   2 +-
>>   examples/l3fwd-power/main.c                   | 256 +++++++++---------
>>   lib/power/rte_power_uncore.c                  |  78 +++---
>>   4 files changed, 185 insertions(+), 157 deletions(-)
>>
> Most of the developers are off enjoying summer vacation.
> But AI is still around and finds some things here:
> Note: some of what it complains about is noise.
Understand.
Thanks for AI review.
Will pick up some to fix.
>
> Applied to main (26.11-rc0) and reviewed against source. Applies cleanly.
>
> Note on check-git-log: it reports "Wrong 'Fixes' reference" for both
> tags. That is a shallow-clone artifact. Both references are correct
> against full history:
>    10db2a5b8724 ("examples/l3fwd-power: add options for uncore frequency")
>    3b3af56d3c9c ("power: fix uncore configuration")
>
>
> Patch 4/6 examples/l3fwd-power: relocate uncore initialization
>
> Warning: new file-scope variable g_uncore_cfg is neither static nor
> prefixed. It is used only in main.c. Make it static and drop the g_
> prefix, which is not DPDK style.
>
>    static struct uncore_cfg {
>            enum uncore_choice uncore_choice;
>            uint32_t freq_idx;
>    } uncore_cfg;
>
> Info: the out-of-range message carries over an off-by-one. The test
> rejects freq_idx > freq_array_len - 1 but the message says "choose a
> value from 0 to %d" with freq_array_len. Since the line is being
> rewritten anyway, print freq_array_len - 1.
>
>
> Patch 5/6 power: support automatic detection of uncore driver
>
> Error: resource leak in power_uncore_probe_driver().
>
>            ret = ops->init(0, 0);
>            if (ret == 0) {
>                    uint32_t env = power_uncore_driver_name2env(ops->name);
>                    if (env == UINT32_MAX)
>                            continue;
>                    ...
>                    ops->exit(0, 0);
>
> On the env == UINT32_MAX path the driver has already been initialized
> successfully but ops->exit(0, 0) is never called before moving to the
> next driver. For intel_uncore that leaves f_cur_min and f_cur_max open
> and the original min/max frequencies never written back. Restructure so
> exit() runs on every successful init:
>
>            ret = ops->init(0, 0);
>            if (ret != 0)
>                    continue;
>            env = power_uncore_driver_name2env(ops->name);
>            ops->exit(0, 0);
>            if (env == UINT32_MAX)
>                    continue;
>            global_uncore_env = env;
>            global_uncore_ops = ops;
>            break;
>
> Not reachable with the two in-tree drivers, since both "intel-uncore"
> and "amd-hsmp" are in uncore_env_str, but the branch is deliberate and
> is wrong as written.
>
> Error: function return type must be on its own line.
>
>    static uint32_t power_uncore_driver_name2env(char *name)
>    static int power_uncore_probe_driver(void)
>
> should be
>
>    static uint32_t
>    power_uncore_driver_name2env(const char *name)
>
>    static int
>    power_uncore_probe_driver(void)
>
> The parameter should also be const char *; ops->name is only read.
>
> Warning: the release note is filed under "New Features" but the commit
> carries Fixes: and Cc: stable@dpdk.org. Pick one. Either this is a
> backportable fix, in which case drop the New Features entry, or it is a
> feature, in which case drop Fixes and Cc: stable. As written the stable
> maintainers receive a patch that advertises itself as a new feature.
>
> Info: the AUTO_DETECT path now returns -ENODEV while every other error
> path in rte_power_set_uncore_env() returns -1. Not wrong, but the error
> convention is now inconsistent within one function.
>
>
> Patch 6/6 power: remove unused auto-detection uncore
>
> Warning: behaviour change to an exported stable symbol with no release
> note. Previously rte_power_uncore_init() fell back to auto-detection
> when no environment had been set; it now returns -1 with "Please set
> uncore environment first." Applications relying on the implicit
> fallback break at runtime with no build-time signal. Add a release note
> describing the new requirement.
