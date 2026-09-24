Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB84C98314
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 07:47:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7156342F02;
	Thu, 24 Sep 2026 09:47:30 +0200 (CEST)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id 4AA8242EE5
 for <dev@dpdk.org>; Thu, 24 Sep 2026 09:47:29 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=vY/+Hzq46S2KJcIAgJJvoEwn9844kdnp/FqTIuGB3es=;
 b=VZrDCPC2AuYkHrX0eqQ/oQjgPPREtxdMwGg2AJUxxqffrrav9lVL/xKBdtSnobRLfJGAPOB4g
 +HKlSrXX7HVRYxAg+YYrCnhoTml/kIFW2R1UXS1KA9GUF5j0pbwxOyYGeoiHjM6e14K9Hqb+19f
 enKQ3x5kDGw3cd5mYBM93h4=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hr5GP0LH8zpSyG
 for <dev@dpdk.org>; Thu, 24 Sep 2026 15:35:25 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 9F2D44057F
 for <dev@dpdk.org>; Thu, 24 Sep 2026 15:47:24 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 24 Sep 2026 15:47:24 +0800
Message-ID: <da073656-c189-4f79-b9e9-fea1535e3238@huawei.com>
Date: Thu, 24 Sep 2026 15:47:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/16] eal: introduce division round up macro
To: Joshua Washington <joshwash@google.com>
CC: <dev@dpdk.org>
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260923010742.2468145-1-joshwash@google.com>
 <20260923010742.2468145-2-joshwash@google.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260923010742.2468145-2-joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

On 9/23/2026 9:07 AM, Joshua Washington wrote:
> A number of drivers define the DIV_ROUND_UP macro -- add it to
> rte_common.h so that other code looking to use that functionality
> doesn't have to re-define it.
> 
> Signed-off-by: Joshua Washington <joshwash@google.com>

