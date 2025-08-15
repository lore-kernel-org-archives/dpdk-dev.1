Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52308CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 00:30:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D44E4025D;
	Fri, 15 Aug 2025 02:30:41 +0200 (CEST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mails.dpdk.org (Postfix) with ESMTP id 32DDE4021F
 for <dev@dpdk.org>; Fri, 15 Aug 2025 02:30:40 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c32xv5Jvpz2gL3n;
 Fri, 15 Aug 2025 08:27:47 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 6861F1A0188;
 Fri, 15 Aug 2025 08:30:38 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 Aug 2025 08:30:37 +0800
Message-ID: <73b2a9a0-153c-4964-902d-a61c835ef341@huawei.com>
Date: Fri, 15 Aug 2025 08:30:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Enable warnings about use of comma operator
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250814212901.88863-1-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250814212901.88863-1-stephen@networkplumber.org>
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

On 8/15/2025 5:28 AM, Stephen Hemminger wrote:
> This series was motivated by recent thread on netdev
> about build with -Wcomma in clang. This warning catches code
> that uses comma where a semi-colon is a better choice.
> 
> v2 - rebase and drop any driver related changes
> 
> Stephen Hemminger (6):
>   eal: replace unnecessary comma operator
>   ipsec: replace unnecessary comma operator
>   graph: replace unnecessary comma operator
>   test: replace unnecessary comma operators
>   app/testpmd: replace comma operator with bracket
>   config: enable comma warnings
> 
>  app/test-pmd/cmdline_flow.c          |  6 ++++--
>  app/test-pmd/config.c                | 10 ++++++----
>  app/test/test_compressdev.c          |  4 ++--
>  app/test/test_link_bonding_rssconf.c |  2 +-
>  app/test/test_thash.c                |  2 +-
>  config/meson.build                   |  1 +
>  drivers/meson.build                  |  2 +-
>  lib/eal/common/rte_malloc.c          |  4 ++--
>  lib/eal/linux/eal_alarm.c            |  6 ++++--
>  lib/graph/graph_stats.c              |  2 +-
>  lib/ipsec/misc.h                     |  3 ++-
>  11 files changed, 25 insertions(+), 17 deletions(-)
> 
> --
> 2.47.2

