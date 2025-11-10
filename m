Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C60CCCFA1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 01:13:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EE67400D6;
	Mon, 10 Nov 2025 02:13:40 +0100 (CET)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id 54C13400D6
 for <dev@dpdk.org>; Mon, 10 Nov 2025 02:13:38 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=CuhYbolpdvTIw5XZpfRe7XX5w3h03JGUqsk0qgvIQFo=;
 b=G8PtiMwt7vsjjB6F1+keQYUDvRauxCItGJXkloWynUrec/xXjSq41bSS4ZkUGUsYQI6hSn+9L
 juRXNZC5PkuHtf5dKcn9EZ2PuzmlINY+LnYQwC4r+6JKFIAPgOS8qss0GJhzUM9IdcEuI19P4C/
 5xDLWEESmeNyyEyxYs2t+g0=
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4d4Wpk0Ldrz1prKZ;
 Mon, 10 Nov 2025 09:11:58 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id B092418007F;
 Mon, 10 Nov 2025 09:13:36 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Nov 2025 09:13:36 +0800
Message-ID: <cb9276ee-25ef-4617-8e5f-6c706cfaf2d2@huawei.com>
Date: Mon, 10 Nov 2025 09:13:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 25/33] app/test-dma-perf: renamed shadowed variable
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Cheng Jiang <honest.jiang@foxmail.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251107155034.436809-1-bruce.richardson@intel.com>
 <20251107155034.436809-26-bruce.richardson@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251107155034.436809-26-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

On 11/7/2025 11:50 PM, Bruce Richardson wrote:
> Rename second instance of variable named "i" in load_configs() to avoid
> shadowing warnings.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

