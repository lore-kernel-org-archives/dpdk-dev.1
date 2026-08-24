Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C12C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 03:07:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D2264027C;
	Mon, 24 Aug 2026 05:07:08 +0200 (CEST)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com
 [113.46.200.225])
 by mails.dpdk.org (Postfix) with ESMTP id 723E940270
 for <dev@dpdk.org>; Mon, 24 Aug 2026 05:07:06 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=qKd14d1a9v2s5LBV8Gk+ue7ddtWciIfXUVFnPKk1Xyo=;
 b=MAy9HHR8ylsZ805H5NgTCkqNYbhvkObvtzhXHWbPB+A8zrkSsOvekl7DGEMsnYn1BMr/ieG6x
 a+r5Q5Td2tDPb8cPq2AK2CjPHXpaX/bBwPjZ1ve37aUn0I7xn+5SMiZskEjtM/D0m6JQIf8jOfM
 d2vMUr1ptN6lJ+Eoc/Bofmw=
Received: from mail.maildlp.com (unknown [172.19.162.92])
 by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4hSwXg6hZqz1K96b;
 Mon, 24 Aug 2026 10:56:19 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 5127B40565;
 Mon, 24 Aug 2026 11:07:04 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 11:07:03 +0800
Message-ID: <07a04510-62ec-4adf-bc84-47c45021e5b9@huawei.com>
Date: Mon, 24 Aug 2026 11:07:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/68] examples: add missing include of rte_memcpy.h
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: Nicolas Chautru <nicolas.chautru@intel.com>, Kevin Laatz
 <kevin.laatz@intel.com>, Bruce Richardson <bruce.richardson@intel.com>, Radu
 Nicolau <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
 <20260821192646.146382-8-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260821192646.146382-8-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

Reviewed-by: Chengwen Feng <fengchengwen@huawei.com>

On 8/22/2026 3:24 AM, Stephen Hemminger wrote:
> These files use rte_memcpy() but relied on rte_memcpy.h being
> included indirectly via another header. Add the direct include
> so that later patches which remove now-unnecessary includes of
> rte_memcpy.h do not break the build.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

