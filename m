Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789E1C02199
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 00:52:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8748140280;
	Sat,  8 Feb 2025 01:52:48 +0100 (CET)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by mails.dpdk.org (Postfix) with ESMTP id 4501940270;
 Sat,  8 Feb 2025 01:52:46 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YqXJQ3ZkGz1W5MM;
 Sat,  8 Feb 2025 08:48:22 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id C70A31802F4;
 Sat,  8 Feb 2025 08:52:43 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 8 Feb 2025 08:52:43 +0800
Message-ID: <cad8a726-afa6-4edc-90bb-d89dfb6c0cb1@huawei.com>
Date: Sat, 8 Feb 2025 08:52:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] test: improve resiliency of malloc autotest
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>
References: <20250117125912.985475-1-bruce.richardson@intel.com>
 <20250207143234.850682-1-bruce.richardson@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250207143234.850682-1-bruce.richardson@intel.com>
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

On 2025/2/7 22:32, Bruce Richardson wrote:
> The test case "test_multi_alloc_statistics" was brittle in that it did
> some allocations and frees and then checked statistics without
> considering the initial state of the malloc heaps. This meant that,
> depending on what allocations/frees were done beforehand, the test can
> sometimes fail.
> 
> We can improve resiliency by running the test using a new malloc heap,
> which means it is unaffected by any previous allocations.
> 
> Bugzilla ID: 1579
> Fixes: a40a1f8231b4 ("app: various tests update")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

