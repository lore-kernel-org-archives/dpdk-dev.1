Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C86C5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 01:22:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17DC84065A;
	Wed,  4 Jun 2025 03:22:11 +0200 (CEST)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mails.dpdk.org (Postfix) with ESMTP id 882C8402DC
 for <dev@dpdk.org>; Wed,  4 Jun 2025 03:22:09 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4bBqXS38WYz1fy9Q
 for <dev@dpdk.org>; Wed,  4 Jun 2025 09:20:56 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id F1367140275
 for <dev@dpdk.org>; Wed,  4 Jun 2025 09:22:06 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Jun 2025 09:22:06 +0800
Message-ID: <1454bed2-02e9-4d32-99b6-ca886113f62f@huawei.com>
Date: Wed, 4 Jun 2025 09:22:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] argparse: use enums to remove max-value defines in
 lists
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20250527092113.903910-1-bruce.richardson@intel.com>
 <20250527092113.903910-4-bruce.richardson@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250527092113.903910-4-bruce.richardson@intel.com>
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

It looks more clear and user-friendly for splitting the flag.
Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 2025/5/27 17:21, Bruce Richardson wrote:
> The use of lists of #defines with _MAX entries at the end causes issues
> for ABI compatibility as those MAX values often leak through to
> applications and can cause issues when changed.
> 
> We can rework the code to increase type safety by splitting the flags
> field and using enums for each set of values explicitly:
> 
> * One enum for whether an argument takes a parameter or not (or
>   optionally takes one)
> * One enum for the type of the argument.
> * A separate flags field for any additional info - right now this is
>   only to indicate an argument can appear more than once.
> 
> The use of the MAX field is no longer necessary using the enums as we
> can use an inline function with a switch statement to check for valid
> values. Compilers like GCC will warn when an enum value is missing from
> the switch statement, easing future maintenance if enum values are
> added.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
