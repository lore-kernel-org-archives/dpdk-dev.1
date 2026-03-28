Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5520310F3DC8
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Mar 2026 03:38:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 925C742E6C;
	Sat, 28 Mar 2026 04:38:24 +0100 (CET)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTP id 235EA402D9
 for <dev@dpdk.org>; Sat, 28 Mar 2026 04:38:23 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=17qnjphaPJk0akZWS4Zr6NXBcYjAV8sNxDhr6hyfHc0=;
 b=h5fO0NAK3230pcPrODYMqpCkqo1+d1tI9JFC6iO94DABVUhlzzyokySqGthgQtPjb07jgbBEL
 EnLmPIAI90RW8cbtxEw+z0hi+RaojqObi+Id4fajaQIO+fVTAzcp86se43VYO9Lfsv/PM8bJXvW
 +JzsD+qxP2nnF+LdPO+tvO0=
Received: from mail.maildlp.com (unknown [172.19.162.197])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fjNPf3Z2Rz12LGb;
 Sat, 28 Mar 2026 11:32:54 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 3DB3540576;
 Sat, 28 Mar 2026 11:38:20 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 28 Mar 2026 11:38:19 +0800
Message-ID: <33eb482d-9de2-403b-94ef-4d81212ab9e9@huawei.com>
Date: Sat, 28 Mar 2026 11:38:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] bus: factorize device selection
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: Bruce Richardson <bruce.richardson@intel.com>, Robin Jarry
 <rjarry@redhat.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, Maxime Leroy
 <maxime@leroys.fr>, Parav Pandit <parav@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
 <nikhil.agarwal@amd.com>, Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia
 <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>, Long Li
 <longli@microsoft.com>, Wei Hu <weh@microsoft.com>, Kevin Laatz
 <kevin.laatz@intel.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260326102424.2361945-1-david.marchand@redhat.com>
 <20260326102424.2361945-7-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260326102424.2361945-7-david.marchand@redhat.com>
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

For uacce part,
Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 3/26/2026 6:24 PM, David Marchand wrote:
> All buses (thankfully) implement the same logic when it comes to
> selecting the devices to probe based on -a/-b options.
> As we want to adjust how devices are selected, provide a common helper
> in EAL and use it in the buses.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> Reviewed-by: Robin Jarry <rjarry@redhat.com>
> Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
> Tested-by: Maxime Leroy <maxime@leroys.fr>

