Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AC5C83F34
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 07:32:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 861DA4014F;
	Thu, 17 Jul 2025 09:32:01 +0200 (CEST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mails.dpdk.org (Postfix) with ESMTP id 8A1C3400EF
 for <dev@dpdk.org>; Thu, 17 Jul 2025 09:32:00 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bjPhK0yzvz2FbNs;
 Thu, 17 Jul 2025 15:29:53 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 26FAD140123;
 Thu, 17 Jul 2025 15:31:58 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 17 Jul 2025 15:31:57 +0800
Message-ID: <372e1430-a0a9-4d36-b90c-38be3955932b@huawei.com>
Date: Thu, 17 Jul 2025 15:31:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: support VLAN stacking packet type parsing
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, Dengdui Huang
 <huangdengdui@huawei.com>, <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <jasvinder.singh@intel.com>,
 <thomas@monjalon.net>, <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <liuyonglong@huawei.com>
References: <20250703093027.1259459-1-huangdengdui@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD8D@smartserver.smartshare.dk>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FD8D@smartserver.smartshare.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

On 2025/7/4 18:18, Morten Brørup wrote:
>> From: Dengdui Huang [mailto:huangdengdui@huawei.com]
>> Sent: Thursday, 3 July 2025 11.30
>>
>> The current rte_net_get_ptype() only supports parsing packets with
>> one 0x8100 VLAN tag or two 0x88a8 VLAN tags. This patch extends it
>> to support parsing packets with two 0x8100 VLAN tags.
>>
>> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
>> ---
>>  lib/net/rte_net.c | 34 ++++++++++++++++++++++------------
>>  lib/net/rte_net.h |  2 ++
>>  2 files changed, 24 insertions(+), 12 deletions(-)
>>
>> diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
>> index 44fb6c0f51..fa8d023ca7 100644
>> --- a/lib/net/rte_net.c
>> +++ b/lib/net/rte_net.c
>> @@ -352,14 +352,19 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf
>> *m,
>>  	if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN)) {
>>  		const struct rte_vlan_hdr *vh;
>>  		struct rte_vlan_hdr vh_copy;
>> +		uint8_t vlan_num = 1;
>>
>>  		pkt_type = RTE_PTYPE_L2_ETHER_VLAN;
>> -		vh = rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
>> -		if (unlikely(vh == NULL))
>> -			return pkt_type;
>> -		off += sizeof(*vh);
>> -		hdr_lens->l2_len += sizeof(*vh);
>> -		proto = vh->eth_proto;
>> +		while (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) &&
>> +		       vlan_num <= MAX_VLAN_STACKING_TAGS) {
>> +			vh = rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
>> +			if (unlikely(vh == NULL))
>> +				return pkt_type;
>> +			off += sizeof(*vh);
>> +			hdr_lens->l2_len += sizeof(*vh);
>> +			proto = vh->eth_proto;
>> +			vlan_num++;
>> +		}
> 
> It's not that simple.
> 
> VLAN tags are not like MPLS labels.
> With the MPLS packet type, we expect a stack of labels.
> But with VLAN tagged packets, we expect exactly one VLAN tag at each outer/inner layer of headers. (Or no VLAN tag at the inner layer.)
> 
> This function already supports packets with 2 VLAN tags:
> A stack of 2 VLAN tags is currently detected as 1 outer VLAN tag, adjusting hdr_lens->l2_len accordingly, and 1 inner VLAN tag, adjusting hdr_lens->inner_l2_len accordingly.
> This behavior should not be changed.

I notice current the hdr_lens->inner_l2_len was added one comment: /* Outer_L4_len + ... + inner L2_len for tunneling pkt. */
It means the inner_l2_len was used in tunneling packet.

But one IPv4 packet carry two 8100 VLANs, it will parsed with hdr_lens->inner_l2_len was set by rte_net_get_ptype, it is unreasonable I think.

I notice Linux kernel vlan_get_protocol() [1], it will parse max 8 vlan (whether the TPID is 8100 or 88A8, [2])

I think we should parse like Linux kernel. If worried about breaking the ABI/API, consider adding a new function.

[1] https://elixir.bootlin.com/linux/v6.15.6/source/include/linux/if_vlan.h#L645
[2] https://elixir.bootlin.com/linux/v6.15.6/source/include/linux/if_vlan.h#L310

> 
> I don't have a firm idea about how to better represent packets with a stack of 3+ VLAN tags than what we do today, so suggestions are welcome.
> 
> Which use case is this patch addressing?
> Maybe information about the use case could guide us in some direction.
> 
>>  	} else if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) {
>>  		const struct rte_vlan_hdr *vh;
>>  		struct rte_vlan_hdr vh_copy;
>> @@ -504,15 +509,20 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf
>> *m,
>>  	if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN)) {
>>  		const struct rte_vlan_hdr *vh;
>>  		struct rte_vlan_hdr vh_copy;
>> +		uint8_t vlan_num = 1;
>>
>>  		pkt_type &= ~RTE_PTYPE_INNER_L2_MASK;
>>  		pkt_type |= RTE_PTYPE_INNER_L2_ETHER_VLAN;
>> -		vh = rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
>> -		if (unlikely(vh == NULL))
>> -			return pkt_type;
>> -		off += sizeof(*vh);
>> -		hdr_lens->inner_l2_len += sizeof(*vh);
>> -		proto = vh->eth_proto;
>> +		while (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) &&
>> +		       vlan_num <= MAX_VLAN_STACKING_TAGS) {
>> +			vh = rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
>> +			if (unlikely(vh == NULL))
>> +				return pkt_type;
>> +			off += sizeof(*vh);
>> +			hdr_lens->inner_l2_len += sizeof(*vh);
>> +			proto = vh->eth_proto;
>> +			vlan_num++;
>> +		}
>>  	} else if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) {
>>  		const struct rte_vlan_hdr *vh;
>>  		struct rte_vlan_hdr vh_copy;
>> diff --git a/lib/net/rte_net.h b/lib/net/rte_net.h
>> index 65d724b84b..fdd55d57c8 100644
>> --- a/lib/net/rte_net.h
>> +++ b/lib/net/rte_net.h
>> @@ -13,6 +13,8 @@
>>  extern "C" {
>>  #endif
>>
>> +#define MAX_VLAN_STACKING_TAGS	2
>> +
>>  /**
>>   * Structure containing header lengths associated to a packet, filled
>>   * by rte_net_get_ptype().
>> --
>> 2.33.0
> 
> 

