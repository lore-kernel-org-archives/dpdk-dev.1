Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE17CD98DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 09:12:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FAF0436DF;
	Mon, 15 Jun 2026 11:12:39 +0200 (CEST)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id BBED7400D5
 for <dev@dpdk.org>; Mon, 15 Jun 2026 11:12:38 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=InbOhk4wBjb/6sbV4Eodsx4s4Ry3Bc66/1uBSuM8QnI=;
 b=j5Y9PlXU5ut8fP4c/KrPvG1GzXDfn6JbHuLKkh/WzMulntlwdEiXMIfz+Ky+A/chZogfqKaQ6
 Q/v4WIPs8RPyk09CeGQUYn2BFcoWn0dwRO6GCJ4fSM+zgKe4bJn4ACrE/Pr74yerormmPax16CE
 vmQxoz3LDHnWBsXOqWc7u34=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gf41S6wd9zcZyh;
 Mon, 15 Jun 2026 17:04:12 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
 by mail.maildlp.com (Postfix) with ESMTPS id C16CA4056D;
 Mon, 15 Jun 2026 17:12:33 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 15 Jun 2026 17:12:33 +0800
Message-ID: <81b33891-68b5-d07b-b14d-8427b2ce369b@huawei.com>
Date: Mon, 15 Jun 2026 17:12:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2] app/testpmd: add padding mode to txonly engine
Content-Language: en-CA
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <david.marchand@redhat.com>, <aman.deep.singh@intel.com>, 
 <fengchengwen@huawei.com>, <yangshuaisong@h-partners.com>,
 <lihuisong@huawei.com>, <liuyonglong@huawei.com>, <kangfenglong@huawei.com>
References: <20260612091217.2899755-1-yangxingui@huawei.com>
 <20260612091343.14344ef7@phoenix.local>
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <20260612091343.14344ef7@phoenix.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.108]
X-ClientProxiedBy: kwepemh500013.china.huawei.com (7.202.181.146) To
 kwepemj100018.china.huawei.com (7.202.194.12)
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



On 2026/6/13 0:13, Stephen Hemminger wrote:
> On Fri, 12 Jun 2026 17:12:17 +0800
> Xingui Yang <yangxingui@huawei.com> wrote:
> 
>> Add a new padding mode to the txonly forwarding engine, which allows
>> sending packets with configurable small sizes without standard L2/L3
>> headers. This is useful for testing NIC padding logic.
>>
>> When padding mode is enabled via --tx-pkt-pad-mode flag:
>> - l2_len and l3_len are set to 0 instead of standard header lengths
>> - Packet data is filled with a static pattern instead of
>>    Ethernet/IP/UDP headers
>> - Minimum packet length validation is bypassed to allow small
>>    packet sizes (e.g., set txpkts 14)
>>
>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>> v2: Fix compilation exception of unterminated-string-initialization
>> ---
> 
> What about something like this (*not tested*) patch.

Hi Stephen,

Thank you for the valuable suggestion! Your approach is cleaner and
more elegant for generating runt frames with truncated headers.

However, our use case requires sending packets smaller than the
Ethernet header size (e.g., `set txpkts 9` or `set txpkts 2`).
These ultra-small packets are needed to test NIC padding logic where
no standard L2/L3 headers are present at all.

We could combine both approaches:
- Allow packet lengths down to 1 byte (remove the 14-byte minimum)
- Dynamically compute l2_len/l3_len based on actual packet length
- Use a fill pattern for packets too small to hold Ethernet header
- Keep the checksum offload handling from your patch

This way testpmd can support the full range:
- Normal packets (>= 14 + 20 + 8 bytes): full headers with checksum
- Runt frames (14-42 bytes): truncated headers, checksums disabled
- Ultra-small packets (<14 bytes): fill pattern only, l2_len/l3_len = 0

Would this combined approach be acceptable? We can submit a v3 patch
incorporating your suggestions plus support for ultra-small packets.

Thanks,
Xingui Yang
