Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAC9C44508
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Jul 2026 08:12:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37E5440290;
	Wed, 15 Jul 2026 10:12:04 +0200 (CEST)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id 493554028B
 for <dev@dpdk.org>; Wed, 15 Jul 2026 10:12:03 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=gU0XDM2tl0/SZEmaaent6N01VovHHZMVYsBSCY8T2iw=;
 b=eanWpkGtl8IRmMp/5wks9bQxSz6OMzwj/dWuBD8oiSWOJoL81RR3Dj6KHKwwJDJw9ScBZXZpW
 6ssqXA3DeQ18HLKpDATfseKn5t6IxdX/8+zbPRQ/aTvM9dzcb8o7+4S1vO2F4KlnYNDAaua474P
 LznSLpKQR1fkLa54yzCQqv0=
Received: from mail.maildlp.com (unknown [172.19.162.140])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4h0TDV50Qnz1prQc;
 Wed, 15 Jul 2026 16:02:34 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 0CE3420333;
 Wed, 15 Jul 2026 16:11:55 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 15 Jul 2026 16:11:54 +0800
Message-ID: <e0b59e0b-1fb7-4a7b-84bb-9fc47f4feb5a@huawei.com>
Date: Wed, 15 Jul 2026 16:11:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mempool cache change
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, Kishore
 Padmanabha <kishore.padmanabha@broadcom.com>, Thomas Monjalon
 <thomas@monjalon.net>
CC: <dev@dpdk.org>, Wisam Jaddo <wisamm@nvidia.com>
References: <b54ad1f1692a0274da705d446972efd1@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6596D@smartserver.smartshare.dk>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6596D@smartserver.smartshare.dk>
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

On 7/15/2026 4:08 AM, Morten Brørup wrote:
> Hi Kishore,
> 
> For your testing purposes, please follow the guidance provided to Wisam Jaddo:
> https://inbox.dpdk.org/dev/98CBD80474FA8B44BF855DF32C47DC35F65964@smartserver.smartshare.dk/

We need to recompile in this case. We should try to avoid recompilation.
I think it is necessary to adjust RTE_MEMPOOL_CACHE_MAX_SIZE to 768 as a
default configuration.

Thanks

> 
> Thank you for testing!
> 
> Venlig hilsen / Kind regards,
> -Morten Brørup
> 
> From: Kishore Padmanabha [mailto:kishore.padmanabha@broadcom.com] 
> Sent: Tuesday, 14 July 2026 18.49
> To: Thomas Monjalon; Morten Brørup
> Cc: dev@dpdk.org
> Subject: mempool cache change
> 
> Hi Thomas,
>  
> The recent change done as part of BUG ID: 1027, with commit id  https://git.dpdk.org/dpdk/commit/?id=f5e1310f16e0909e7e7f71807123644c63b23cba
> Is causing performance drop for the bnxt NIC in 26.07 release.
>  
> The smaller, shallower cache increases the miss rate, causing refills to hit the shared ring more frequently. 
> In the old code, the cache only touched the shared ring when it climbed past 768 instead of 512. That extra 256 elements of headroom allowed significantly more frees to remain local.
>  
> Could we make the change in config/rte_config.h for RTE_MEMPOOL_CACHE_MAX_SIZE to be 768 instead of 512. Since we use –mbcache=512 as argument for the performance tests.
>  
> Thanks,
> Kishore
>  
>  

