Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECA8C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 07:58:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF0EF40274;
	Fri, 10 Jul 2026 09:58:46 +0200 (CEST)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id 12B8F4026A
 for <dev@dpdk.org>; Fri, 10 Jul 2026 09:58:45 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=bpOHCvt+eHDXaRRBkddKtu+3+9xmyN0+6F29UClWPLM=;
 b=DsaOTjz0HgpxMNNHsh8HFo57BMtx9/sXNAy91TZLQG/bFnid2Bd01jD2n6B4JZ/LXRKC8z6Ru
 iL56Dm740F2sdgfTiO8GeoKVv+uMlATixqoYaFUpdNWZ88bDUD0e0okvyrrkLFsTYhjHGP35uH3
 ytgTpc3JJf5GdwirltbRsBs=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gxPBJ3wdGzpSvB;
 Fri, 10 Jul 2026 15:50:00 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 2FCA34058C;
 Fri, 10 Jul 2026 15:58:44 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 10 Jul 2026 15:58:43 +0800
Message-ID: <72d68ed9-43c1-4e6f-9fa6-a9a99ddd34e5@huawei.com>
Date: Fri, 10 Jul 2026 15:58:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] dma/ae4dma: add AMD AE4DMA DMA PMD
To: Raghavendra Ningoji <raghavendra.ningoji@amd.com>, <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <bruce.richardson@intel.com>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>, <rjarry@redhat.com>,
 <thomas@monjalon.net>
References: <20260710073608.3034898-1-raghavendra.ningoji@amd.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260710073608.3034898-1-raghavendra.ningoji@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500009.china.huawei.com (7.202.194.199)
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

On 7/10/2026 3:36 PM, Raghavendra Ningoji wrote:
> This series adds a new dmadev poll-mode driver for the AMD AE4DMA
> hardware DMA engine, split into introduction, control path and data
> path patches, plus a small dmadev test-suite patch.

