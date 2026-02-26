Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A0FFD4609
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 02:09:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB76C4021F;
	Thu, 26 Feb 2026 03:09:06 +0100 (CET)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id 84DB5400D6;
 Thu, 26 Feb 2026 03:09:03 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=6fYoXZT3IBM1bFkSOQCnKwNY+bkBDdrUtTjDg8br3b4=;
 b=6YaqbwNQkSxeQRIvqkUU/Ljf1qncwiVcdsm9xCdqbbB9SuA0UZXnafwJJvS91pCE4p89l12dW
 gkz5zB7xJI/CVURxjPlL8NktIoZZ2recWpBvvy4OJRgOEXi2+n5DpC7P5Qx1v/r1E2rkgtNUNna
 2qK/HfLzavxW6dnGAXBbMyI=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fLvrs1QtLzcb40;
 Thu, 26 Feb 2026 10:03:57 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 467C740561;
 Thu, 26 Feb 2026 10:08:59 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Feb 2026 10:08:58 +0800
Message-ID: <f8149a16-f017-4d01-87d3-6e38b945877d@huawei.com>
Date: Thu, 26 Feb 2026 10:08:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] app/dma-perf: fixes buffer overflow error
To: Vipin Varghese <vipin.varghese@amd.com>, <dev@dpdk.org>,
 <honest.jiang@foxmail.com>
CC: <stable@dpdk.org>, <cheng1.jiang@intel.com>
References: <20260225114120.2036-1-vipin.varghese@amd.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260225114120.2036-1-vipin.varghese@amd.com>
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

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 2/25/2026 7:41 PM, Vipin Varghese wrote:
> test-dma-perf limits the number of worker thread to 128.
> The current change accomadates to RTE_MAX_LCORES. This allows
> high core density platforms to run the test on `(RTE_MAX_LCORE - 1)`
> 
> Without the change we encounter `buffer overflow detected, terminated`.
> 
> Fixes: 623dc9364dc6 ("app/dma-perf: introduce DMA performance test")
> Cc: cheng1.jiang@intel.com
> Cc: stable@dpdk.org
> Signed-off-by: Vipin Varghese <vipin.varghese@amd.com>

