Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39420C7EE30
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 02:38:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F6CC402B1;
	Wed,  2 Jul 2025 04:38:17 +0200 (CEST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id E6AFC4028C
 for <dev@dpdk.org>; Wed,  2 Jul 2025 04:38:15 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bX3r50BsBz2Cfgc;
 Wed,  2 Jul 2025 10:34:13 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 8F8FC1A016C;
 Wed,  2 Jul 2025 10:38:13 +0800 (CST)
Received: from [10.67.121.193] (10.67.121.193) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Jul 2025 10:38:12 +0800
Message-ID: <e158a8b8-74d1-4df9-ada7-7485ac58336b@huawei.com>
Date: Wed, 2 Jul 2025 10:38:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: huangdengdui <huangdengdui@huawei.com>
Subject: Does rte_net_get_ptype() support processing packets with two 0x8100
 VLAN tags?
To: "dev@dpdk.org" <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <jasvinder.singh@intel.com>,
 <thomas@monjalon.net>, <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, liuyonglong <liuyonglong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.193]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo500011.china.huawei.com (7.202.195.194)
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

Hi everyone,

The current rte_net_get_ptype() only supports parsing packets with  a single 0x8100 VLAN tag and two 0x88a8 VLAN tags,
but does not support processing packets with two 0x8100 VLAN tags.

Some network cards (e.g., hns3) do support parsing packets with two 0x8100 VLAN tags.
Can this API be extended to support such packets?

I understand that two 0x8100 VLAN tag packets aren't commonly used, so I'm uncertain whether adding support is necessary.

Anyone is welcome to discuss this and share their opinions.

Thanks,
/Dengdui
