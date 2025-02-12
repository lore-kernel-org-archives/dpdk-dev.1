Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CF0C0219B
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 01:40:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CC82402BB;
	Wed, 12 Feb 2025 02:40:26 +0100 (CET)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mails.dpdk.org (Postfix) with ESMTP id 76F7940269
 for <dev@dpdk.org>; Wed, 12 Feb 2025 02:40:24 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Yt1BF0VsZz1ltYk;
 Wed, 12 Feb 2025 09:36:37 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 445F5180214;
 Wed, 12 Feb 2025 09:40:22 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Feb 2025 09:40:21 +0800
Message-ID: <3110f2b3-f38b-40d9-bd30-d935900aa0d2@huawei.com>
Date: Wed, 12 Feb 2025 09:40:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/11] test: remove unneeded memset
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: Bruce Richardson <bruce.richardson@intel.com>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250211173720.1188517-1-stephen@networkplumber.org>
 <20250211173720.1188517-9-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250211173720.1188517-9-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

On 2025/2/12 1:35, Stephen Hemminger wrote:
> Since tmp is not used later in the function, this memset
> is unnecessary. Even though this is harmless,
> it causes tools that look for security issues
> around memset to flag this a bug.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

