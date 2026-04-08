Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59651105D98C
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 00:30:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3E6940299;
	Wed,  8 Apr 2026 02:30:18 +0200 (CEST)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id 266B140261
 for <dev@dpdk.org>; Wed,  8 Apr 2026 02:30:16 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=tcCiWEcVNlcBa9Uu0xMSFgjWgrL+7hXiGXmlrsC1kTg=;
 b=aSfg5AidyD4XM8PMjrdok/MtuP2YVcGk5sIYPKy2HQttns/VhHzbqzpZ1yH4Xu8pOWgcNDFF6
 R1tCKUf4n9SoINjcvpasiPv4LkaH/2IgwaWttaDV2RfJmLenlgwnVx1oMP0gIwvf49hQ1MsrBMR
 If3BOqOb05VIE6dICxfxb2E=
Received: from mail.maildlp.com (unknown [172.19.162.92])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fr3hc3qpLzLlT3;
 Wed,  8 Apr 2026 08:24:00 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 9766A40565;
 Wed,  8 Apr 2026 08:30:13 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 8 Apr 2026 08:30:13 +0800
Message-ID: <943ed76e-d43c-4a06-a508-0192f4269d69@huawei.com>
Date: Wed, 8 Apr 2026 08:30:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/23] examples/dma: resolve shadow variable warnings
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: Bruce Richardson <bruce.richardson@intel.com>, Kevin Laatz
 <kevin.laatz@intel.com>
References: <20260407035209.650419-1-stephen@networkplumber.org>
 <20260407151732.272195-1-stephen@networkplumber.org>
 <20260407151732.272195-4-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260407151732.272195-4-stephen@networkplumber.org>
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
> Fix shadow variable warnings by:
> - Renaming 'copy_mode' parameter to 'mode' in dma_parse_copy_mode()
> - Removing 'nb_queues' parameter from port_init() and using the
>   global variable directly, since it's always called with the
>   global nb_queues value
> 
> ../examples/dma/dmafwd.c:593:33: warning: declaration of 'copy_mode'
> shadows a global declaration [-Wshadow]
> ../examples/dma/dmafwd.c:881:68: warning: declaration of 'nb_queues'
> shadows a global declaration [-Wshadow]
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

