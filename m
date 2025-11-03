Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D33BCCF9E3
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 02:40:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86D1840270;
	Mon,  3 Nov 2025 03:40:18 +0100 (CET)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id 39E514021E
 for <dev@dpdk.org>; Mon,  3 Nov 2025 03:40:16 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=lpnqzSiEDsEIJsMMes3H/hfN9Grgf6cfRoHjJ25ZcdM=;
 b=2nH75PGt0gaAvnY5O0RZTdtnOyciwr87HMu3QCDzttHBeTL0DSLUUu36VMjdHgTmEsCQwGJ8p
 +TTC6YsytKTT2w+FENnQiigNLCj5PTcoIZai0e3piOJPp85czwO2zClSBtmHxkwgV8kYPN7j1a+
 Ognm0KPPxK/9gVPodbkxbIs=
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4d0G422Q1mzcZyZ;
 Mon,  3 Nov 2025 10:38:42 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id C8922180493;
 Mon,  3 Nov 2025 10:40:14 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Nov 2025 10:40:14 +0800
Message-ID: <7d809cc9-941e-49af-b2d1-c4bb40c44407@huawei.com>
Date: Mon, 3 Nov 2025 10:40:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: fix incorrect L2 length for GRE tunneling packet
To: Thomas Monjalon <thomas@monjalon.net>, <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <aman.deep.singh@intel.com>,
 <lihuisong@huawei.com>, <liuyonglong@huawei.com>, Dengdui Huang
 <huangdengdui@huawei.com>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ivan Malov <ivan.malov@oktetlabs.ru>, Ivan Malov <ivan.malov@arknetworks.am>, 
 Sunil Kumar Kori <skori@marvell.com>, <yangxingui@h-partners.com>
References: <20250723104710.558623-1-huangdengdui@huawei.com>
 <3634305.KRxA6XjA2N@thomas>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <3634305.KRxA6XjA2N@thomas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

This commit also fix one access not-initialized inner_l2_len problem, consider:
If the packet is one tunnel type which recognize by ptype_tunnel_without_udp(), and
application don't init "struct rte_net_hdr_lens hdr_lens;" , then the inner_l2_len will
be random without this commit because later process the inner_l2_len both are both += ops.

On 9/24/2025 10:41 PM, Thomas Monjalon wrote:
> Looking for review, please.
> 
> 
> 23/07/2025 12:47, Dengdui Huang:
>> The meaning of L2_len in the parsing result of the rte_net_get_ptype()
>> is the same as the L2_len field in the mbuf. For tunnel packets,
>> the L2_len should include protocol header of tunnel packets.
>>
>> Bugzilla ID: 1754
>> Fixes: d21d855464ff ("net: support GRE in software packet type parser")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
>> ---
>>  lib/net/rte_net.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
>> index 44fb6c0f51..c70b57fdc0 100644
>> --- a/lib/net/rte_net.c
>> +++ b/lib/net/rte_net.c
>> @@ -481,6 +481,7 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
>>  
>>  		pkt_type |= ptype_tunnel_without_udp(&proto, m, &off);
>>  		hdr_lens->tunnel_len = off - prev_off;
>> +		hdr_lens->inner_l2_len = off - prev_off;
>>  	}
>>  
>>  	/* same job for inner header: we need to duplicate the code
>>
> 
> 
> 
> 
> 

