Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3D8C5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 01:37:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45CD34065A;
	Wed,  4 Jun 2025 03:37:16 +0200 (CEST)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mails.dpdk.org (Postfix) with ESMTP id 4E5E2402DC
 for <dev@dpdk.org>; Wed,  4 Jun 2025 03:37:14 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bBqwB16Ppz27hdM
 for <dev@dpdk.org>; Wed,  4 Jun 2025 09:38:02 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id E7EC1180042
 for <dev@dpdk.org>; Wed,  4 Jun 2025 09:37:10 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Jun 2025 09:37:10 +0800
Message-ID: <3eb61fe1-ccf5-4c73-907f-f3a38b4496ee@huawei.com>
Date: Wed, 4 Jun 2025 09:37:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] argparse additions and rework
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20250527092113.903910-1-bruce.richardson@intel.com>
 <20250603153233.2427833-1-bruce.richardson@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250603153233.2427833-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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

Thanks for this patchset, Bruce.
Series-acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 2025/6/3 23:32, Bruce Richardson wrote:
> This patchset is based off the work to adjust how we do argument parsing
> inside EAL. To enable argparse to be effectively used for EAL, we have
> new features and some changes in the first two patches, which are
> relatively small - though are ABI/API affecting.
> 
> These add support for saving off strings and boolean values, have argparse
> stop parsing at a "--", and finally have argparse return the number of
> arguments actually parsed on success.
> 
> The third patch is a bigger change. It was inspired by the fact that
> when adding the boolean and string support we had to update some
> "MAX" value defines used in the code. This is obviously not good from
> an ABI/API perspective, once the library becomes part of the stable ABI.
> In order to remove these MAX values, patch 3 looks to replace the
> #define values with enums - which means some rework splitting the
> various flags into separate categories, and similarly splitting the
> single "flags" field with separate fields specifying if an argument
> value is required, what type that value should have, and then a
> final smaller field for any additional modifiers.
> 
> v2: minor changes to patch 2 (see log at end of that patch)
> 
> Bruce Richardson (3):
>   argparse: add support for string and boolean args
>   argparse: make argparse EAL-args compatible
>   argparse: use enums to remove max-value defines in lists
> 
>  app/test/test_argparse.c               | 229 ++++++++++++++-----------
>  doc/guides/rel_notes/release_25_07.rst |  50 ++++++
>  examples/dma/dmafwd.c                  |  20 +--
>  examples/flow_filtering/main.c         |   4 +-
>  lib/argparse/rte_argparse.c            | 184 ++++++++++++--------
>  lib/argparse/rte_argparse.h            |  94 +++++-----
>  6 files changed, 355 insertions(+), 226 deletions(-)
> 
> --
> 2.48.1
> 

