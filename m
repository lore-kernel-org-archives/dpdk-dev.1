Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD055CD5BD2
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 03:57:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFC6E4027C;
	Fri, 29 May 2026 05:57:29 +0200 (CEST)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTP id 3A8DE40264
 for <dev@dpdk.org>; Fri, 29 May 2026 05:57:28 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=Ek1BOqeMUFCo2uqp+WfjFCFFnPHXpDiU1ZneTIDb6qE=;
 b=B0tupScdvyUpBN9kU3/zunZdG/y/QIc66JQT6i9KYHevoKjVkTfoivGmBZh2oBDErgBXoK35b
 LlwgOYXXJLl9i4VOqB/2rk1zlTxHqaE4ZQ0qTKo6GRomSZu9pcoeiGg2AcqV3b2sGM4swhV+0bn
 94TY1Cdn/t6LX5GLNpf+/qc=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gRTr20xsKz1T4jF;
 Fri, 29 May 2026 11:49:22 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id C6E6D4048F;
 Fri, 29 May 2026 11:57:25 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 29 May 2026 11:57:25 +0800
Message-ID: <57f6a15e-4406-4490-a59e-2946764a0a3b@huawei.com>
Date: Fri, 29 May 2026 11:57:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/25] bus: remove device and driver checks in DMA
 map/unmap
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <bruce.richardson@intel.com>, Parav Pandit <parav@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>, Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Tomasz Duszynski <tduszynski@marvell.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260527075654.3780732-1-david.marchand@redhat.com>
 <20260527075654.3780732-6-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260527075654.3780732-6-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 5/27/2026 3:56 PM, David Marchand wrote:
> Add rte_dev_is_probed() check in rte_dev_dma_map() and
> rte_dev_dma_unmap() before calling bus-specific implementations.
> 
> The device parameter passed to bus DMA map/unmap operations cannot be
> NULL as the caller already dereferenced the bus structure to invoke
> these operations.
> The driver reference in the bus-specific device cannot be NULL since
> calling the .dma_map is done after dereferencing this pointer.
> 
> Remove redundant checks on probed device, and NULL checks on the
> device/driver parameter and derived device/driver pointers.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

