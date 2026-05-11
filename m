Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E78BCD37B2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 01:10:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C798402BD;
	Mon, 11 May 2026 03:10:29 +0200 (CEST)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTP id 09E2C402B8
 for <dev@dpdk.org>; Mon, 11 May 2026 03:10:27 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=exlWVTbG51ujlNLOyHlKjZRwhrmvnnO/70yrj5ipOu8=;
 b=2FGsUi6XoXW1v6exf6MKlySMCs329boGhB4X1hAPNfz+beZBfFZ4xVuPu8QrQyGqs5qgEs9au
 Vu4FGsOrtzR0o0mkbsTH1T4HMTEHWSH/Fh1txx0jJr0e+oEPbamjI+nmFwI1sJfDoY0B4GF3vhf
 QZRG2pChDD/tkrBagt1DxdY=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gDM0k5dbTz12LJk;
 Mon, 11 May 2026 09:03:18 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 525E74056A;
 Mon, 11 May 2026 09:10:25 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 May 2026 09:10:24 +0800
Message-ID: <5a7c0fff-515c-425d-bd25-538cccabfb09@huawei.com>
Date: Mon, 11 May 2026 09:10:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] power: some cleancode for cpufreq library
To: Huisong Li <lihuisong@huawei.com>, <anatoly.burakov@intel.com>,
 <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>
References: <20260509084503.2917038-1-lihuisong@huawei.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260509084503.2917038-1-lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

Series-acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 5/9/2026 4:45 PM, Huisong Li wrote:
> Move some common definition to common header file.
> 
> Huisong Li (3):
>   power: move power state structure to power cpufreq header
>   power: unify decimal format macro for strtoul
>   power: use common decimal macro definition
> 
>  drivers/power/acpi/acpi_cpufreq.c                 |  8 --------
>  drivers/power/amd_pstate/amd_pstate_cpufreq.c     |  9 ---------
>  drivers/power/cppc/cppc_cpufreq.c                 |  9 ---------
>  drivers/power/intel_pstate/intel_pstate_cpufreq.c |  8 --------
>  lib/power/power_common.c                          |  1 -
>  lib/power/power_common.h                          |  2 ++
>  lib/power/power_cpufreq.h                         | 10 ++++++++++
>  lib/power/rte_power_qos.c                         |  2 +-
>  8 files changed, 13 insertions(+), 36 deletions(-)
> 

