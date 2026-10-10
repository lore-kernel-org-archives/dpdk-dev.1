Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D39CA9EBD
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 03:00:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEE07402B4;
	Sat, 10 Oct 2026 05:00:04 +0200 (CEST)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id BB9F84027C
 for <dev@dpdk.org>; Sat, 10 Oct 2026 05:00:02 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=mVYv9gpOKwNHGSNF8rADpcwPCOPGPsHgsHEI3cSD2CI=;
 b=CX5hOuxt3+wF7jcZn7Dy5F8gdOZ6YueZ8bM0KFOnkFoIDvurrcSLtfpt3j4uF1gOqOhlrIpbc
 JjqRMqPaTHqyXSxnqa8/v+AittSc2UBpTB7KNBUPIT07SLPCR8RKBw0HIfiiwXKvp50COLhDTFw
 rrdve+QlXWgHDJLsAgAhyiM=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4j1p7300rrz1prQt;
 Sat, 10 Oct 2026 10:47:42 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 243154056D;
 Sat, 10 Oct 2026 11:00:00 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sat, 10 Oct 2026 10:59:59 +0800
Message-ID: <385b6ff5-20d3-4be4-baca-8ad5cd0ed4e3@huawei.com>
Date: Sat, 10 Oct 2026 10:59:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/dma: cleanup PCI probing in Intel drivers
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: Bruce Richardson <bruce.richardson@intel.com>, Kevin Laatz
 <kevin.laatz@intel.com>, Conor Walsh <conor.walsh@intel.com>
References: <20261009114830.3630886-1-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20261009114830.3630886-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500009.china.huawei.com (7.202.194.199)
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

On 10/9/2026 7:48 PM, David Marchand wrote:
> Drivers are not responsible for setting the rte_device driver reference
> since this has been factorized in EAL.
> 
> Fixes: f282771a04ef ("bus: factorize driver reference")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

