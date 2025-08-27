Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0BACA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 11:02:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41FA840292;
	Wed, 27 Aug 2025 13:02:14 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by mails.dpdk.org (Postfix) with ESMTP id 5349A4028E
 for <dev@dpdk.org>; Wed, 27 Aug 2025 13:02:12 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cBhMC0HYNzdcft;
 Wed, 27 Aug 2025 18:57:43 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 30F23140135;
 Wed, 27 Aug 2025 19:02:09 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 Aug 2025 19:02:08 +0800
Message-ID: <83a3c050-7369-4ff4-9b1e-4db6dde1ea25@huawei.com>
Date: Wed, 27 Aug 2025 19:02:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] examples/l3fwd-power: support specify link speed
To: Dengdui Huang <huangdengdui@huawei.com>, <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <anatoly.burakov@intel.com>,
 <david.hunt@intel.com>, <sivaprasad.tummala@amd.com>, <huisong@huawei.com>,
 <liuyonglong@huawei.com>
References: <20250827013106.2453922-1-huangdengdui@huawei.com>
 <20250827013106.2453922-2-huangdengdui@huawei.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250827013106.2453922-2-huangdengdui@huawei.com>
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

Reviewed-by: Chengwen Feng <fengchengwen@huawei.com>

On 8/27/2025 9:31 AM, Dengdui Huang wrote:
> Currently, l3fwd-power starts in auto-negotiation mode, but it may fail
> to link up when auto-negotiation is not supported. Therefore, it is
> necessary to support starting with a specified speed for port.
> 
> Additionally, this patch does not support changing the duplex mode.
>  So speeds like 10M, 100M are not configurable using this method.
> 
> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>

