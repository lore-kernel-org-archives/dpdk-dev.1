Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9529BC021B3
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Feb 2025 02:08:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FD754027D;
	Sat, 22 Feb 2025 03:08:48 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 45D1F40267
 for <dev@dpdk.org>; Sat, 22 Feb 2025 03:08:47 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Z09KJ5jZszdb8P;
 Sat, 22 Feb 2025 10:04:04 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 88FA31400FD;
 Sat, 22 Feb 2025 10:08:44 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 22 Feb 2025 10:08:44 +0800
Message-ID: <cc6faa6a-6c22-48d4-a9fc-c29b070eb57f@huawei.com>
Date: Sat, 22 Feb 2025 10:08:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test/ring: fix return uninitialized variable
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>, <dev@dpdk.org>
CC: <honnappa.nagarahalli@arm.com>
References: <20250219142314.82235-1-konstantin.ananyev@huawei.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250219142314.82235-1-konstantin.ananyev@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

On 2025/2/19 22:23, Konstantin Ananyev wrote:
> This change addresses the CID 455328: Uninitialized variables  (UNINIT).
> Strictly speaking right now it should never happen, as role_mask is not
> zero. But that might change in future, as more test-cases will be
> introduced. Anyway the fix is trivial.
> 
> Coverity issue: 455328
> Fixes: 70581c355d69 ("test/ring: add unit tests for soring API")
> 
> Signed-off-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

