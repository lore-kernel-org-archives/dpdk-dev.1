Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA55606A31E
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=h-partners.com header.i=@h-partners.com header.a=rsa-sha256 header.s=dkim header.b=QmuAP/OS
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F9E2402C9;
	Thu, 26 Nov 2026 12:47:52 +0100 (CET)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTPS id 946C4402BD
 for <dev@dpdk.org>; Thu, 26 Nov 2026 12:47:49 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=4FyBKO71ffIOZ5QIXtyt2YdOGbZBIA+rwy3PBXzKDMk=;
 b=QmuAP/OS4RSf/1z0CyJz1SHDCubw0mWHqd1gorJw+ziqVu8N+dA4+V4jt2804b6G7MNL8T8PN
 8KIGJazoOvm3xq0TxB/kTleisc0SK94Qlwrafqw9h//VSDt7S4PlGsZSffIHCLyEZpVXNbkULlS
 3k8f/4krmMer5j5XELksbLo=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4jZvsC39kmzpSy5;
 Thu, 26 Nov 2026 19:46:39 +0800 (CST)
Received: from dggpemr100003.china.huawei.com (unknown [7.185.36.150])
 by mail.maildlp.com (Postfix) with ESMTPS id BE5074057F;
 Thu, 26 Nov 2026 19:47:43 +0800 (CST)
Received: from [10.67.121.46] (10.67.121.46) by dggpemr100003.china.huawei.com
 (7.185.36.150) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 26 Nov
 2026 19:47:43 +0800
Message-ID: <87de364b-23b9-49bf-bc3e-5b6a79ddadc6@h-partners.com>
Date: Thu, 26 Nov 2026 19:47:42 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] support uncore power management on Hisilicon platforms
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>, <fengchengwen@huawei.com>,
 <yangxingui@h-partners.com>, <yangxingui@huawei.com>
References: <20261125140616.3965843-1-yangshuaisong@h-partners.com>
 <20261125105607.5a8c631f@phoenix.local>
Content-Language: en-GB
From: Shuaisong Yang <yangshuaisong@h-partners.com>
In-Reply-To: <20261125105607.5a8c631f@phoenix.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemr100003.china.huawei.com (7.185.36.150)
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Stephen,

The uncore options in l3fwd-power are not introduced by this series:
-u/-U/-i have been there since 10db2a5b87 ("examples/l3fwd-power:
add options for uncore frequency"). On the application side, this
series only cleans up that pre-existing handling (dedicated helpers,
rollback on failure) and lets users pick which package/die to control
instead of always applying to all of them (--uncore-freq).

The intended split is:
- Driver/environment setup stays inside the library: the app just
  calls rte_power_set_uncore_env(RTE_UNCORE_PM_ENV_AUTO_DETECT) and
  the library selects the driver itself. Patch 7 adds the detect
  callback used by that mechanism, and the Hisilicon driver registers
  itself without any application configuration.
- What remains in the application is the policy: which uncore domains
  to control and which frequency to pin (min/max/index). That is a
  per-application choice, and l3fwd-power is the sample demonstrating
  the rte_power APIs, as it already does for cpufreq and PM QoS.

We kept this out of EAL because uncore pinning is a policy rather
than environment abstraction: whether to touch uncore at all, and
which dies and values to use, differs from application to
application, while an EAL option would force one static policy on
all of them.

That said, if you think one-shot static uncore pinning belongs in
EAL, or a library-level "init all" helper would help, we are happy
to discuss it as a follow-up. Would the current approach be
acceptable for this series?

Thanks,
Shuaisong Yang

On 2026/11/26 2:56, Stephen Hemminger wrote:
> On Wed, 25 Nov 2026 22:06:06 +0800
> Shuaisong Yang <yangshuaisong@h-partners.com> wrote:
> 
>> This series reworks the uncore frequency handling of the l3fwd-power
>> sample and extends the power library with a Hisilicon uncore driver
>> and uncore frequency telemetry.
>>
>> The first six patches restructure the power management code of
>> l3fwd-power: the uncore and cpufreq/QoS setup and cleanup paths are
>> extracted into dedicated helpers, the failure paths now roll back
>> the steps already taken, and the sample can set the frequency of a
>> specific package/die instead of applying the change to all of them.
>>
>> The last three patches extend the power library:
>>
>> - a detect callback is added to the uncore driver ops, letting a
>>   driver report by itself whether it can manage the platform;
>> - a new Hisilicon uncore driver is added on top of the devfreq
>>   sysfs interface of those platforms;
>> - the current uncore frequency is exposed through telemetry.
>>
>> Signed-off-by: Shuaisong Yang <yangshuaisong@h-partners.com>
> 
> Why does application need to handle args about uncore?
> Seems to defeat the purpose having EAL.
> The setup should be in EAL not the application.

