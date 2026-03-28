Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6959010F3DC8
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Mar 2026 03:13:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AE1E402E7;
	Sat, 28 Mar 2026 04:13:55 +0100 (CET)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id 92817402D9
 for <dev@dpdk.org>; Sat, 28 Mar 2026 04:13:53 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=Crvmvopz4BU1iBANbmodXauGkTQGDsZ4BUlChtIJ0I8=;
 b=URVV/FXbAPqsNPqxkC3T1Bsm6bQcVy56HstBdZmWs0KX/EAmjEuXd5hkOLnhl4JtNUKjkmxYU
 ZJxlb4VtLYIVWp0ioPzgxukYdNOxpCEeGUF1USGYQkiS93tCfq4VrjXD9JIweiZmZRn7cPZRzzD
 EqpuqHXM/bWDwbCC/erx1K8=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fjMs43wzXzpTL9;
 Sat, 28 Mar 2026 11:08:08 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 2707240538;
 Sat, 28 Mar 2026 11:13:49 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 28 Mar 2026 11:13:48 +0800
Message-ID: <3048a42a-4481-4cf0-ad4d-52302409f804@huawei.com>
Date: Sat, 28 Mar 2026 11:13:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] drivers: cleanup devargs lookup in bus scan
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: Bruce Richardson <bruce.richardson@intel.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Kevin Traynor <ktraynor@redhat.com>, Maxime Leroy
 <maxime@leroys.fr>, Parav Pandit <parav@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
 <nikhil.agarwal@amd.com>, Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu
 <rosen.xu@altera.com>, Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski
 <tduszynski@marvell.com>, Long Li <longli@microsoft.com>, Wei Hu
 <weh@microsoft.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260326102424.2361945-1-david.marchand@redhat.com>
 <20260326102424.2361945-5-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260326102424.2361945-5-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

For uacce part,
Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 3/26/2026 6:24 PM, David Marchand wrote:
> Don't hardcode the bus names in the RTE_EAL_DEVARGS_FOREACH() calls.
> The bus name is set by code in EAL.
> Even if there is nothing broken, let's reuse the name from the bus object.
> 
> And remove the now useless macros.
> 
> Note: in the ifpga bus case, the lookup loop was using an incorrect macro
> (IFPGA_ARG_NAME instead of IFPGA_BUS_NAME), yet it was working fine
> as this macro is aligned with the ifpga bus name.
> Besides, the raw/ifpga wants to hotplug a device in this bus, so keep
> this bus name macro and add a check the bus name is aligned at init time.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
> Acked-by: Kevin Traynor <ktraynor@redhat.com>
> Tested-by: Maxime Leroy <maxime@leroys.fr>
> ---
> Changes since v1:
> - fixed ifpga hotplug in raw/ifpga,

