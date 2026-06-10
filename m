Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888E0CD8CB2
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 01:08:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59FF540151;
	Wed, 10 Jun 2026 03:08:21 +0200 (CEST)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by mails.dpdk.org (Postfix) with ESMTP id D673E400D5
 for <dev@dpdk.org>; Wed, 10 Jun 2026 03:08:19 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=1vLNbFRsaHG0wbdxdKrHThFoMsvRDz7bCJKaPM1T2NM=;
 b=Gmzdjuh/i3YR3wcUgUdJ21QC3Qsg5WyUp47JQFiak93XhHyxlMo0A8FpDoSkqdfkLIjFW4BxQ
 qY1Sggknh5L91Nd8LUxc8ZvJExcjeQuD0Nr2/XfmxraWwAvOl7yV0+49gEQaGC07WMHfK62mqAY
 w5Vw3sXSAxxZL2qm4JD2gAI=
Received: from mail.maildlp.com (unknown [172.19.162.92])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gZnWS5rF4zKm60;
 Wed, 10 Jun 2026 09:00:20 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 51C5640562;
 Wed, 10 Jun 2026 09:08:17 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Jun 2026 09:08:17 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 10 Jun
 2026 09:08:16 +0800
Message-ID: <466233e4-2d99-45cc-baf2-9b9a4eeca828@huawei.com>
Date: Wed, 10 Jun 2026 09:08:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] power: some cleancode for cpufreq library
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, 
 <lihuisong@huawei.com>
References: <20260509084503.2917038-1-lihuisong@huawei.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260509084503.2917038-1-lihuisong@huawei.com>
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

Kindly ping for review.

On 5/9/2026 4:45 PM, Huisong Li wrote:
> Move some common definition to common header file.
>
> Huisong Li (3):
>    power: move power state structure to power cpufreq header
>    power: unify decimal format macro for strtoul
>    power: use common decimal macro definition
>
>   drivers/power/acpi/acpi_cpufreq.c                 |  8 --------
>   drivers/power/amd_pstate/amd_pstate_cpufreq.c     |  9 ---------
>   drivers/power/cppc/cppc_cpufreq.c                 |  9 ---------
>   drivers/power/intel_pstate/intel_pstate_cpufreq.c |  8 --------
>   lib/power/power_common.c                          |  1 -
>   lib/power/power_common.h                          |  2 ++
>   lib/power/power_cpufreq.h                         | 10 ++++++++++
>   lib/power/rte_power_qos.c                         |  2 +-
>   8 files changed, 13 insertions(+), 36 deletions(-)
>
