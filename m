Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDA9C021A4
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 08:35:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEF0C4064A;
	Fri, 14 Feb 2025 09:35:10 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 30C7440263
 for <dev@dpdk.org>; Fri, 14 Feb 2025 09:35:09 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YvQJ41wsfzkXMx;
 Fri, 14 Feb 2025 16:31:32 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id E0FCD180116;
 Fri, 14 Feb 2025 16:35:06 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Feb 2025 16:35:06 +0800
Message-ID: <0f34c087-944a-475d-8f19-e6ee53d9dc74@huawei.com>
Date: Fri, 14 Feb 2025 16:35:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] examples/l3fwd: add option to set Tx burst size
To: Jie Hai <haijie1@huawei.com>, <dev@dpdk.org>, <thomas@monjalon.net>,
 <ferruh.yigit@amd.com>, <stephen@networkplumber.org>, Huisong Li
 <lihuisong@huawei.com>, =?UTF-8?Q?Morten_Br=C3=B8rup?=
 <mb@smartsharesystems.com>
CC: <huangdengdui@huawei.com>
References: <20241122071336.18470-1-haijie1@huawei.com>
 <20241204020622.977156-1-haijie1@huawei.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20241204020622.977156-1-haijie1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2024/12/4 10:06, Jie Hai wrote:
> The application send packets only when the buffer is full, or the
> buffer is empty and the packets to be sent extends TX_PKT_BURST.
> The change of MAX_PKT_BURST make TX buffer size and TX_PKT_BURST
> increase, while the default cache size is 256. The packets in
> the TX direction occupy the cache. As a result, the performance
> deteriorates.
> 
> Restore the default Tx burst and add option '--tx-burst' to set
> the Tx burst size. To ensure consistency, rename the option
> '--burst' to '--rx-burst'. The valid range of the user-provided
> value is (0, MAX_PKT_BURST] for both directions.
> 
> Fixes: d5c4897ecfb2 ("examples/l3fwd: add option to set RX burst size")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Jie Hai <haijie1@huawei.com>

