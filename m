Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EFAEDB7D0
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 01:18:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AACC640261;
	Wed,  8 Apr 2026 03:18:48 +0200 (CEST)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by mails.dpdk.org (Postfix) with ESMTP id C3AB44013F
 for <dev@dpdk.org>; Wed,  8 Apr 2026 03:18:46 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=6eCIYZlp1CnH2drhD1a5G4mUcrMevhon0Iz5M0AEEh8=;
 b=6Osuns3FVMXvQqvAqyYep6NFC1SMikknmbOZQ/AYHAItt4L4dbvHHPEEa+RR069QwpoA1pFPN
 bQpDqtGvPm6+WHGSJVpHIyD7mu4WYFj2Eb2/5m5OcgF97p5+he8w5d60OaEn4pjslYH4WUqZwny
 sYu/arRbFuiYYePFGiMQFwY=
Received: from mail.maildlp.com (unknown [172.19.162.92])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fr4mX2GLxzKm4k;
 Wed,  8 Apr 2026 09:12:28 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 0D57040565;
 Wed,  8 Apr 2026 09:18:44 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 8 Apr 2026 09:18:43 +0800
Message-ID: <94aa1f9b-1361-48d5-ae56-109212ce2852@huawei.com>
Date: Wed, 8 Apr 2026 09:18:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] bus: factorize devargs lookup
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: Bruce Richardson <bruce.richardson@intel.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Maxime Leroy <maxime@leroys.fr>, Kevin Traynor
 <ktraynor@redhat.com>, Parav Pandit <parav@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
 <nikhil.agarwal@amd.com>, Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia
 <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>, Long Li
 <longli@microsoft.com>, Wei Hu <weh@microsoft.com>, Kevin Laatz
 <kevin.laatz@intel.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260407115211.1903623-1-david.marchand@redhat.com>
 <20260407115211.1903623-6-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260407115211.1903623-6-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

For uacce part:
Tested-by: Chengwen Feng <fengchengwen@huawei.com>

On 4/7/2026 7:52 PM, David Marchand wrote:
> Each bus reimplements some similar devargs lookup code.
> 
> The differences are in how some bus (PCI, VMBUS etc...) normalizes the
> device names. We can't use the .parse existing handler from outside the
> bus code itself, as the size of the bus specific device location address
> is unknown.
> Introduce a bus specific helper to compare two device names and
> hide this ugly detail.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
> Tested-by: Maxime Leroy <maxime@leroys.fr>
> Acked-by: Kevin Traynor <ktraynor@redhat.com>

