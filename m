Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA846C369D3
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Apr 2025 08:20:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D6704021F;
	Mon, 28 Apr 2025 10:20:27 +0200 (CEST)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by mails.dpdk.org (Postfix) with ESMTP id 6A43740156
 for <dev@dpdk.org>; Mon, 28 Apr 2025 10:20:25 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZmGZG0wR1z1d0nV;
 Mon, 28 Apr 2025 16:19:18 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 5B81D1402DF;
 Mon, 28 Apr 2025 16:20:23 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 28 Apr 2025 16:20:22 +0800
Message-ID: <2c503191-c235-4fbc-ae7a-d21dbe83d2a7@huawei.com>
Date: Mon, 28 Apr 2025 16:20:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: fengchengwen <fengchengwen@huawei.com>
Subject: add one example of DPI ?
To: thomas Monjalon <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Hi all,

Currently, we supported several DPI application scenarios performance tuning,
in these scenarios, the DPDK library ethdev, ring, mbuf and hash APIs are used.

One of the scenarios is:

    ------------------------                           -------------------------
    |                      |       rte_ring-0          |                       |
    |  packet-recv-process | ===>  rte_ring-1  ===>    | packet-detect-process |
    |                      |         ...               |                       |
    |                      |       rte_ring-n          |                       |
    ------------------------                           -------------------------

    packet-recv-process dispatch flow to different rings by such 'rte_hash_crc' function.
    packet-detect-process build flow context based on rte_hash library.

I think it is necessary to add a DPI example to show that DPDK has the basic
capability of building DPI applications and provides best performance practices.

Hope to listen to the community's opinions.

Thanks

