Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7717C02192
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 06:37:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD42D42799;
	Fri,  7 Feb 2025 07:37:20 +0100 (CET)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mails.dpdk.org (Postfix) with ESMTP id 9139442798
 for <dev@dpdk.org>; Fri,  7 Feb 2025 07:37:18 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Yq41C6w3mz1V6GH;
 Fri,  7 Feb 2025 14:33:35 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id CF8A21402C1;
 Fri,  7 Feb 2025 14:37:15 +0800 (CST)
Received: from [10.67.121.193] (10.67.121.193) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Feb 2025 14:37:15 +0800
Message-ID: <da1670b8-5db6-41a4-8c7e-c89d3a8d9160@huawei.com>
Date: Fri, 7 Feb 2025 14:37:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mbuf: add packet offload Rx flag for keep CRC
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, <dev@dpdk.org>, 
 <stephen@networkplumber.org>
CC: <lihuisong@huawei.com>, <fengchengwen@huawei.com>, <haijie1@huawei.com>,
 <liuyonglong@huawei.com>
References: <20250124095957.3496874-1-huangdengdui@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9F9E9@smartserver.smartshare.dk>
Content-Language: en-US
From: huangdengdui <huangdengdui@huawei.com>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9F9E9@smartserver.smartshare.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.193]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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


On 2025/1/24 22:34, Morten Brørup wrote:
>> From: Dengdui Huang [mailto:huangdengdui@huawei.com]
>> Sent: Friday, 24 January 2025 11.00
>>
>> After discussion[1], the drivers do not include the CRC in the packet
>> length calculation. This will cause users to be confused about whether
>> the mbuf contains CRC data. This patch adds a packet offload Rx flag,
>> indicating that CRC data exists at the end of the mbuf chain.
>>
>> [1] https://inbox.dpdk.org/dev/20240206011030.2007689-1-
>> haijie1@huawei.com/
>>
>> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
>> ---
> 
> Mbufs with F_RX_KEEP_CRC requires much more than this.
> 
> If the packet length omits the 4 byte Ethernet CRC, and the last segment only holds the CRC, rte_mbuf_check() will fail and cause panic in rte_mbuf_sanity_check().
> And many functions working on segments, such as rte_pktmbuf_copy(), linearize(), etc. need to be patched to check for F_RX_KEEP_CRC when working on the packet. This will degrade performance, and we are also talking about frequently used dataplane functions.
> 
Currently, when the CRC data is stored at the end of a packet, neither data_len nor pkt_len contains the CRC length. Therefore, using rte_pktmbuf_copy() and linearization() for packets containing CRC data is also problematic.

> Furthermore, if we really need to support KEEP_CRC with segmented packets, we need to add test cases with the CRC partially in the last segment, and with only the CRC in the last segment, for functions and libraries supporting segmented packets. Regardless if the packet length includes the 4 bytes CRC or not.
> 
> KEEP_CRC looks exotic to me, and am worried that full support for KEEP_CRC will impact performance and would be essentially untested in a bunch of libraries. I don't want exotic features impacting the performance of frequently used dataplane functions.
> Can you please remind me of the use cases for KEEP_CRC?
> 
> Perhaps support for KEEP_CRC could be a build time option (default omitted, for performance and test coverage reasons)?
> 
> Alternatively, support for KEEP_CRC could be limited to non-segmented packets?
> 
> Or, how about a completely different approach:
> Drivers supporting KEEP_CRC can strip the 4 byte CRC (like stripping a VLAN tag) and store it in an mbuf dynfield.
> 
> 

It's a good idea to store it in mbuf dynfield. As mentioned above, storing CRC data at the end of the mbuf is very complex and currently imperfect. Can this feature be re-implemented in this simpler way?
