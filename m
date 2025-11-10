Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05567CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 01:12:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01822400D6;
	Mon, 10 Nov 2025 02:12:29 +0100 (CET)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id E70AA400D5;
 Mon, 10 Nov 2025 02:12:26 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=nfpdDSH8uCzecm1Bc7UKswZyszJrl63ySejz7lH1UPQ=;
 b=SYEjS7o0yJo1TERYHkz95RRLgEEgTC19XsCF72pd9KEHScF1jrqiK9Cpi4uxUiNj+2PGHjqXW
 rFCjwogRMPsSljGOznSaXJPZ8VwHutr2sSFMlWTrI265ACn1U6bvwBvUhC9zIVKxE03xREVZF3J
 jutA9qS18PMJoKTx73zXapI=
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4d4WnM32CHzRhVq;
 Mon, 10 Nov 2025 09:10:47 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 02CEA140156;
 Mon, 10 Nov 2025 09:12:25 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Nov 2025 09:12:24 +0800
Message-ID: <372dab45-826c-4f55-8d6a-50f6a93fe2d6@huawei.com>
Date: Mon, 10 Nov 2025 09:12:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/33] ethdev: fix variable shadowing issues
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Declan
 Doherty <declan.doherty@intel.com>, Rosen Xu <rosen.xu@altera.com>, Huisong
 Li <lihuisong@huawei.com>, Konstantin Ananyev <konstantin.ananyev@huawei.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251107155034.436809-1-bruce.richardson@intel.com>
 <20251107155034.436809-4-bruce.richardson@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251107155034.436809-4-bruce.richardson@intel.com>
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

On 11/7/2025 11:49 PM, Bruce Richardson wrote:
> Remove unneeded extra variable definitions, and rename variables as
> necessary to ensure clean compile with -Wshadow warnings enabled.
> 
> Fixes: e489007a411c ("ethdev: add generic create/destroy ethdev APIs")
> Fixes: 1bb4a528c41f ("ethdev: fix max Rx packet length")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

