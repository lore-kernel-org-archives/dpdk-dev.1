Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC228CD8CA8
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 01:35:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FA8240650;
	Wed, 10 Jun 2026 03:35:54 +0200 (CEST)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com
 [113.46.200.227])
 by mails.dpdk.org (Postfix) with ESMTP id 742F4400D5;
 Wed, 10 Jun 2026 03:35:53 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=PrI0Sw52rGBJ5B9TrrpZE20rn4eavEiydzz7aEr398M=;
 b=6iLHKCGV5AobBWawphlf29likexN1jdnkne/7Uo/i47DsF7HT/4H6IUX4YDy6wCHM92AfHy5F
 otLK0kyRbERkblDMT3Va22mdKfEyFI/sef2JRDfnn0RYvTGEt+n7rnwitFqLOXYa96h/Pt5X+h4
 EtcAENV+rXmOzDa0BsaPwgw=
Received: from mail.maildlp.com (unknown [172.19.163.163])
 by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gZp7N6vKCznV13;
 Wed, 10 Jun 2026 09:28:00 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 43B6D4048B;
 Wed, 10 Jun 2026 09:35:50 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Jun 2026 09:35:49 +0800
Message-ID: <cd21b6e3-1efe-4ad6-9110-13b8c88f3248@huawei.com>
Date: Wed, 10 Jun 2026 09:35:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] eal: fix off by one in in tailq name init
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>
References: <20260607150418.30885-1-stephen@networkplumber.org>
 <20260609155419.263787-1-stephen@networkplumber.org>
 <20260609155419.263787-2-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260609155419.263787-2-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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

On 6/9/2026 11:53 PM, Stephen Hemminger wrote:
> The tailq name is defined as 32 bytes, but name would be
> silently truncated at 31 bytes. The function strlcpy() size
> already accounts for the nul character at the end.

nul -> NUL

> 
> 
> Fixes: f9acaf84e923 ("replace snprintf with strlcpy without adding extra include")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

