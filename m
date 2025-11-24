Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC32CFA466
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Nov 2025 08:11:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33AD94021E;
	Mon, 24 Nov 2025 09:11:15 +0100 (CET)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com
 [113.46.200.224])
 by mails.dpdk.org (Postfix) with ESMTP id E884A400D7
 for <dev@dpdk.org>; Mon, 24 Nov 2025 09:11:13 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=I3ip1osNMSeiNFXjQmlSWctTwsF5Q4K3gLBWxvef7fg=;
 b=1bkHef7IGbJqF5xwWCgmGNy2WdYEH3J38eetqkdOF8AimW//fJt1Wn9cz0skRMkB2l5NOhRw8
 /13VU7zbQzE0FI25Gb7vrDPjABwjJTQgMawPaBEQDtahIQ/lwrV2hhPfuEkiVf5tJs7GI3lVjVi
 rOrqWaaNKxzz15Jv4RWmPl0=
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dFJPv43LWz1cySW;
 Mon, 24 Nov 2025 16:09:23 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id A0B861A0174;
 Mon, 24 Nov 2025 16:11:10 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 24 Nov 2025 16:11:10 +0800
Message-ID: <9b202324-caea-4a87-bc19-ba0ad1cbf8b4@huawei.com>
Date: Mon, 24 Nov 2025 16:11:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] examples/l3fwd: support specify link speed
From: fengchengwen <fengchengwen@huawei.com>
To: Thomas Monjalon <thomas@monjalon.net>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: <anatoly.burakov@intel.com>, <david.hunt@intel.com>,
 <sivaprasad.tummala@amd.com>, <huisong@huawei.com>, <liuyonglong@huawei.com>, 
 Dengdui Huang <huangdengdui@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>
References: <20250827013106.2453922-1-huangdengdui@huawei.com>
 <551821a7-6836-420c-b62f-5a6168de9abe@huawei.com>
Content-Language: en-US
In-Reply-To: <551821a7-6836-420c-b62f-5a6168de9abe@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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

Kindly ping for upstream.

On 8/27/2025 7:01 PM, fengchengwen wrote:
> Reviewed-by: Chengwen Feng <fengchengwen@huawei.com>
> 
> On 8/27/2025 9:31 AM, Dengdui Huang wrote:
>> Currently, l3fwd starts in auto-negotiation mode, but it may fail to
>> link up when auto-negotiation is not supported. Therefore, it is
>> necessary to support starting with a specified speed for port.
>>
>> Additionally, this patch does not support changing the duplex mode.
>> So speeds like 10M, 100M are not configurable using this method.
>>
>> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>

