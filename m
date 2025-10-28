Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73238CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 00:45:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44B4140281;
	Tue, 28 Oct 2025 01:45:43 +0100 (CET)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id A08F54021E;
 Tue, 28 Oct 2025 01:45:41 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=rN/SwWmZSGG54YMT9Aw4T6UsOSFexgmAfrinEbCzM8Q=;
 b=RrazYI8WxDtc2GzwNavRx/gVKkv9A17Two5k9/tQ2rz4kK8+Jg2Pjv5vmdLA7EIBE33bNAuzA
 jBuxGS7Vz3p+2CpHCQ+CrP+G6j35kEQdPQP13YdZIjvLwhn6wL7lKYg0TTVMAT+vfDoRgjhuOie
 QJiHkp6TS4AIPEWcAHy4O5A=
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4cwWqp5GLPzRhRJ;
 Tue, 28 Oct 2025 08:45:10 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 0795C180080;
 Tue, 28 Oct 2025 08:45:39 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Oct 2025 08:45:38 +0800
Message-ID: <35d7b613-6f37-4d7a-b0b7-022cb65a36c1@huawei.com>
Date: Tue, 28 Oct 2025 08:45:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmadev: fix build if RTE_DMADEV_DEBUG enabled
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: <stable@dpdk.org>, <david.marchand@redhat.com>, Kevin Laatz
 <kevin.laatz@intel.com>, Bruce Richardson <bruce.richardson@intel.com>
References: <20251027164621.175861-1-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251027164621.175861-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

On 10/28/2025 12:46 AM, Stephen Hemminger wrote:
> Missing definition of errnos causes build failure:
> 
> In file included from ../lib/dmadev/rte_dmadev_trace.h:16,
>                  from ../lib/dmadev/rte_dmadev_trace_points.c:8:
> ../lib/dmadev/rte_dmadev.h: In function ‘rte_dma_copy’:
> ../lib/dmadev/rte_dmadev.h:1183:25: error: ‘EINVAL’ undeclared (first use in this function)
>  1183 |                 return -EINVAL;
>       |                         ^~~~~~
> 
> Bugzilla ID: 1814
> Fixes: 8f1d23ece06a ("eal: deprecate RTE_FUNC_PTR_* macros")
> Cc: david.marchand@redhat.com
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

