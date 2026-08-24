Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EB4C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 03:08:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 604524027C;
	Mon, 24 Aug 2026 05:08:42 +0200 (CEST)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by mails.dpdk.org (Postfix) with ESMTP id 6CD4040270
 for <dev@dpdk.org>; Mon, 24 Aug 2026 05:08:41 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=h+3jnc3xsZ+lnolFgErWNskDyrlsYOKVHQCwMzcSnpo=;
 b=oIDyDCvNTe1cT1f54M7sxsGqR6DAKDBG9OVG5Nd8iRrHAwl/r+5pEQyc5fRSk3zhPXRV3mFbS
 1XHgX+dJC5KlunzYLyx3mdtSMXN2usG3Bl5cJW3l6mndR9UYwbHXEFQnAdupbCrzJj7DfEa4mQT
 VBsE7fHeww/hfJ4x8PFYO6Y=
Received: from mail.maildlp.com (unknown [172.19.163.127])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hSwZR0ZzVzKm6S;
 Mon, 24 Aug 2026 10:57:51 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id ECC3040573;
 Mon, 24 Aug 2026 11:08:38 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 11:08:37 +0800
Message-ID: <236350de-72d0-4ddb-8332-51910ca6d741@huawei.com>
Date: Mon, 24 Aug 2026 11:08:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/68] eal: document when to use rte_memcpy
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
 <20260821192646.146382-9-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260821192646.146382-9-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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
> The choice between rte_memcpy() and memcpy() was not documented,
> which has led to rte_memcpy() being used in places where it gives
> no benefit, such as the control path and copies of a constant size.
> 
> Document the guidance: structure assignment for fixed size objects,
> memcpy() for the control path and for constant sizes, and rte_memcpy()
> only for variable size copies in the data path.
> 
> Suggested-by: Morten Brørup <mb@smartsharesystems.com>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

