Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D23C83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 01:23:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F62A4021E;
	Tue, 15 Jul 2025 03:23:46 +0200 (CEST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id AF7554013F
 for <dev@dpdk.org>; Tue, 15 Jul 2025 03:23:44 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bh1cN31JCz2TT2n;
 Tue, 15 Jul 2025 09:21:40 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id F118C180043;
 Tue, 15 Jul 2025 09:23:42 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Jul 2025 09:23:42 +0800
Message-ID: <b47768ab-d8b6-4ad5-b65d-92d7e658dc47@huawei.com>
Date: Tue, 15 Jul 2025 09:23:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] app/testpmd: fix set cores list string size
To: Dengdui Huang <huangdengdui@huawei.com>, <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <aman.deep.singh@intel.com>,
 <lihuisong@huawei.com>, <liuyonglong@huawei.com>
References: <20250708125159.2457578-1-huangdengdui@huawei.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250708125159.2457578-1-huangdengdui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

On 2025/7/8 20:51, Dengdui Huang wrote:
> The cmdline_fixed_string_t has a length of only 128, which will
> become insufficient when there are many cores, so it should be
> replaced with a cmdline_multi_string_t of larger capacity.
> 
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>

