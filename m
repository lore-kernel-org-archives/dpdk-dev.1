Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C32DFD4609
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 02:11:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D0354021F;
	Thu, 26 Feb 2026 03:11:12 +0100 (CET)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTP id D9892400D6
 for <dev@dpdk.org>; Thu, 26 Feb 2026 03:11:10 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=JgxpkvbmWGks7go03VPhkENN7cIeSKbl3ablhcOUv1k=;
 b=Y5Lgv+VwKniLb9UXbVtM7NjTaBzdmJYQUxTH8xVc4Y+jdlixasVmyuEM5N8VGSPOwkapJ/eyw
 ezv4wPB+uvtNP/fx8YZwDv64n+rZZiIDAAHHGRVFcPq3Rv6h1O7b/G8DYvs3GrqdLCn37z9FHaX
 I5Yt2AeD1fNFqxO+BsN1hjE=
Received: from mail.maildlp.com (unknown [172.19.163.0])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fLvvQ6lhTz1T4MK;
 Thu, 26 Feb 2026 10:06:10 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id B74094036C;
 Thu, 26 Feb 2026 10:11:03 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Feb 2026 10:11:03 +0800
Message-ID: <ac35b365-8efe-4930-99ee-1d68a92cc972@huawei.com>
Date: Thu, 26 Feb 2026 10:11:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Extend NUMA nodes limit
To: Liangxing Wang <wangliangxing@hygon.cn>, <thomas@monjalon.net>,
 <stephen@networkplumber.org>
CC: <dev@dpdk.org>
References: <20260225080419.727470-1-wangliangxing@hygon.cn>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260225080419.727470-1-wangliangxing@hygon.cn>
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

Series-acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 2/25/2026 4:04 PM, Liangxing Wang wrote:
> This patchset use RTE_MAX_NUMA_NODES instead of hardcoded values to
> extend NUMA nodes limit for some examples and test app. Also remove
> unused NB_SOCKETS macro for ip_reassembly example and graph app.
> 
> Liangxing Wang (2):
>   examples: extend NUMA nodes limit
>   app: extend NUMA nodes limit
> 
>  app/graph/ethdev_rx_priv.h         | 1 -
>  app/test/test_pmd_perf.c           | 2 +-
>  examples/ip_reassembly/main.c      | 2 --
>  examples/ipsec-secgw/ipsec-secgw.h | 2 +-
>  examples/l3fwd-graph/main.c        | 2 +-
>  examples/l3fwd-power/main.c        | 2 +-
>  examples/l3fwd/l3fwd.h             | 2 +-
>  examples/vhost_crypto/main.c       | 2 +-
>  8 files changed, 6 insertions(+), 9 deletions(-)
> 

