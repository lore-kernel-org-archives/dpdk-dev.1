Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B861FF512F
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 00:32:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AF5940261;
	Wed,  8 Apr 2026 02:32:27 +0200 (CEST)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTP id 6B2744013F
 for <dev@dpdk.org>; Wed,  8 Apr 2026 02:32:25 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=sIFomdjU0EhSsJAZ13eGdEBXIrVwGBIV8uqxHU5+dv8=;
 b=l4LrD3ZA8L7lTz+4N3VJWTdomNYOMMNTH7+IkeHoSH2mL5DY+iUDToqxxkG6kpmmyHLYk+86t
 QdkdHl28XZME9XLmMHIraX3vyQrVTS4t9+jlqPNA6ICTZ1A6R+U/TrMW7JyF73pi6iKat+bcm9S
 7bfjBm0G4kaQ2jbkoRKr/Yc=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fr3lY2SB3z1T4G8;
 Wed,  8 Apr 2026 08:26:33 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 90CA04056A;
 Wed,  8 Apr 2026 08:32:23 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 8 Apr 2026 08:32:23 +0800
Message-ID: <69c24b9f-f1b0-4899-95a6-6f62e28965d1@huawei.com>
Date: Wed, 8 Apr 2026 08:32:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/23] examples/ethtool: resolve shadow variable
 warnings
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: Bruce Richardson <bruce.richardson@intel.com>
References: <20260407035209.650419-1-stephen@networkplumber.org>
 <20260407151732.272195-1-stephen@networkplumber.org>
 <20260407151732.272195-2-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260407151732.272195-2-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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

On 4/7/2026 11:15 PM, Stephen Hemminger wrote:
> Fix shadow variable warning by renaming the function parameter
> from 'app_cfg' to 'ptr_cfg' to avoid shadowing the global variable.
> 
> ../examples/ethtool/ethtool-app/main.c:89:44: warning: declaration of
> 'app_cfg' shadows a global declaration [-Wshadow]
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

