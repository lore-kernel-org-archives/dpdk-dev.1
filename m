Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8507DC98310
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 07:48:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7630642F02;
	Thu, 24 Sep 2026 09:48:51 +0200 (CEST)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id BFBB842EE5
 for <dev@dpdk.org>; Thu, 24 Sep 2026 09:48:50 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=P+vUHQnvrsyJS54Gl8eqyzTAtBM+6AZyKlaIsYpiaBU=;
 b=3JTgyuJo/2Ecwjb5Ro5LActEyEyYL9GSUUIjUnxDYuzF4PvULUu66dYC1t8Ftu7VgnEWQMLR5
 SLOO0UPedV4/ez3poNIBwYdspuKt0oCa/0EXlDFKO65TClISl4r/czT4d2sEKj7zdgtZQa41pDu
 hdVIY07ewZ8X89lQcrFKRvQ=
Received: from mail.maildlp.com (unknown [172.19.163.163])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hr5Hm6BnTzLlSh;
 Thu, 24 Sep 2026 15:36:36 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id D31724057A;
 Thu, 24 Sep 2026 15:48:42 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 24 Sep 2026 15:48:42 +0800
Message-ID: <365085aa-15a5-4a78-a137-a568085d10aa@huawei.com>
Date: Thu, 24 Sep 2026 15:48:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/16] net/hns3: use common division round up macro
To: Joshua Washington <joshwash@google.com>, Xingui Yang
 <yangxingui@huawei.com>
CC: <dev@dpdk.org>, Stephen Hemminger <stephen@networkplumber.org>
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260923010742.2468145-1-joshwash@google.com>
 <20260923010742.2468145-8-joshwash@google.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260923010742.2468145-8-joshwash@google.com>
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
> The RTE_DIV_ROUND_UP in rte_common.h makes DIV_ROUND_UP redundant.
> 
> Signed-off-by: Joshua Washington <joshwash@google.com>
> Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/hns3/hns3_ethdev.h | 2 --
>  drivers/net/hns3/hns3_fdir.c   | 2 +-
>  drivers/net/hns3/hns3_regs.c   | 8 ++++----
>  drivers/net/hns3/hns3_rss.c    | 8 ++++----
>  4 files changed, 9 insertions(+), 11 deletions(-)

