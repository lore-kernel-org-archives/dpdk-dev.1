Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A429C0219B
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 01:37:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8524C402BB;
	Wed, 12 Feb 2025 02:37:18 +0100 (CET)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mails.dpdk.org (Postfix) with ESMTP id 0C7D340269
 for <dev@dpdk.org>; Wed, 12 Feb 2025 02:37:17 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Yt16Z5N1mz1V6Xv;
 Wed, 12 Feb 2025 09:33:26 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id B06511A016C;
 Wed, 12 Feb 2025 09:37:12 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Feb 2025 09:37:12 +0800
Message-ID: <2d9c20a2-772a-4703-aa19-92d3e8088a9f@huawei.com>
Date: Wed, 12 Feb 2025 09:37:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/11] eal: introduce new secure memory fill
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: Tyler Retzlaff <roretzla@linux.microsoft.com>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250211173720.1188517-1-stephen@networkplumber.org>
 <20250211173720.1188517-2-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250211173720.1188517-2-stephen@networkplumber.org>
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

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

On 2025/2/12 1:35, Stephen Hemminger wrote:
> When memset() is used before a release function such as free,
> the compiler if allowed to optimize the memset away under
> the as-if rules. This is normally ok, but in certain cases such
> as passwords or security keys it is problematic.
> 
> Introduce a DPDK wrapper which is equivalent to the C++ memset_s
> function.  Naming chosen to be similar to kernel.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

