Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44BCC021B0
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 03:00:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC4284014F;
	Thu, 20 Feb 2025 04:00:36 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id B229240041
 for <dev@dpdk.org>; Thu, 20 Feb 2025 04:00:35 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YyyZ32lJVzpVnR;
 Thu, 20 Feb 2025 10:55:55 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 91361140154;
 Thu, 20 Feb 2025 11:00:32 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Feb 2025 11:00:32 +0800
Message-ID: <2bd54b44-7753-4b26-a380-13426d936860@huawei.com>
Date: Thu, 20 Feb 2025 11:00:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] dmadev: remove unnecessary deref of function
 pointers
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: Kevin Laatz <kevin.laatz@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>
References: <20250217185743.169778-1-stephen@networkplumber.org>
 <20250220023509.630569-1-stephen@networkplumber.org>
 <20250220023509.630569-11-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250220023509.630569-11-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2025/2/20 10:32, Stephen Hemminger wrote:
> The expression *dev->dev_ops->dev_info_get and
> dev->dev_ops->dev_info_get are equivalent.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

