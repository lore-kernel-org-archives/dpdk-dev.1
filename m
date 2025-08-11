Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4AFC87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 11:48:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B35F4042E;
	Mon, 11 Aug 2025 13:48:00 +0200 (CEST)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mails.dpdk.org (Postfix) with ESMTP id 297D94013F
 for <dev@dpdk.org>; Mon, 11 Aug 2025 13:47:59 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4c0tFm4tnqz3TqYC;
 Mon, 11 Aug 2025 19:49:00 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id EDAC01800B2;
 Mon, 11 Aug 2025 19:47:56 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 Aug 2025 19:47:56 +0800
Message-ID: <fdce3d2b-a031-4f9c-b0fa-54f5908d3378@huawei.com>
Date: Mon, 11 Aug 2025 19:47:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] testpmd: Do not enable mbuf fast release TX
 offload by default
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, <dev@dpdk.org>, 
 Aman Singh <aman.deep.singh@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Ivan
 Malov <ivan.malov@arknetworks.am>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>
References: <20250731090731.671589-1-mb@smartsharesystems.com>
 <20250803194218.683318-1-mb@smartsharesystems.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250803194218.683318-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

On 8/4/2025 3:42 AM, Morten Brørup wrote:
> Enabling some offload by default may conflict with a manually configured
> offload.
> Specifically, the mbuf fast release TX offload, which conflicts with multi
> segment packet TX offload, was enabled by default.
> Therefore, mbuf fast release TX offload (the only TX offload which was
> enabled by default) is not enabled by default anymore.
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>

