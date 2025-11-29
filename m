Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6401D116EA
	for <dpdk-dev@archiver.kernel.org>; Sat, 29 Nov 2025 00:32:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D7A64021F;
	Sat, 29 Nov 2025 01:32:35 +0100 (CET)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id E78924013F;
 Sat, 29 Nov 2025 01:32:33 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=AVy9RtzzfFBxkwLXdEiqjEo5FReDZd8xZdYsjL75O+Y=;
 b=N07DXLXL5ZMn3ZkwuDpScY7U56gzVuE5XMfPUhoM+ZBSGnNr1UQYCH7dj35HdFC/EUOkfMrtn
 XP2lhdox+QJt9i7mxqdFxoTqw2f1gvbtDxnF7vILBufiGg3lV6gZ4RwFrMX2WzCXn3pDPWXnFeI
 7/2w/Z+RkCmElUKEiKamc9s=
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dJB0J5cr5z1prLY;
 Sat, 29 Nov 2025 08:30:40 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 7B38F1402C1;
 Sat, 29 Nov 2025 08:32:31 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 29 Nov 2025 08:32:31 +0800
Message-ID: <d4a367ac-8082-4583-96d8-a2db3774f9b6@huawei.com>
Date: Sat, 29 Nov 2025 08:32:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] bus/uacce: fix const pointer in device matching
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Huisong Li <lihuisong@huawei.com>, Zhangfei Gao
 <zhangfei.gao@linaro.org>
References: <20251128135616.2662164-1-david.marchand@redhat.com>
 <20251128135616.2662164-3-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251128135616.2662164-3-david.marchand@redhat.com>
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

Reviewed-by: Chengwen Feng <fengchengwen@huawei.com>

On 11/28/2025 9:56 PM, David Marchand wrote:
> With latest glibc (Fedora Rawhide):
> ../drivers/bus/uacce/uacce.c: In function 'uacce_match':
> ../drivers/bus/uacce/uacce.c:346:21: warning: assignment discards
> 	'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>   346 |                 map = strstr(dev->algs, id_table->dev_alg);
>       |                     ^
> 
> Fixes: 62b906cf06ba ("bus/uacce: introduce UACCE bus")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

