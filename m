Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A67CAC599
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 06:34:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 027D24027F;
	Tue, 16 Sep 2025 08:34:31 +0200 (CEST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mails.dpdk.org (Postfix) with ESMTP id 8696F4025A
 for <dev@dpdk.org>; Tue, 16 Sep 2025 08:34:29 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cQsVd4lrtz1R93v;
 Tue, 16 Sep 2025 14:31:21 +0800 (CST)
Received: from kwepemr200009.china.huawei.com (unknown [7.202.195.137])
 by mail.maildlp.com (Postfix) with ESMTPS id D34611400CB;
 Tue, 16 Sep 2025 14:34:26 +0800 (CST)
Received: from [10.67.121.193] (10.67.121.193) by
 kwepemr200009.china.huawei.com (7.202.195.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Sep 2025 14:34:26 +0800
Message-ID: <efc43c28-b6d5-4fe6-abe3-0f7da30c32ce@huawei.com>
Date: Tue, 16 Sep 2025 14:34:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] app/testpmd: fix L4 protocol retrieval from L3 header
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
References: <20250830012913.1117632-1-huangdengdui@huawei.com>
 <20250915093954.6f02c3f2@hermes.local>
Content-Language: en-US
From: huangdengdui <huangdengdui@huawei.com>
In-Reply-To: <20250915093954.6f02c3f2@hermes.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.193]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr200009.china.huawei.com (7.202.195.137)
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


On 2025/9/16 0:39, Stephen Hemminger wrote:
> On Sat, 30 Aug 2025 09:29:13 +0800
> Dengdui Huang <huangdengdui@huawei.com> wrote:
> 
>> Currently, when retrieving the L4 protocol from the L3 header,
>> the case of IPv6 with extension headers is not handled correctly.
>> This patch fixes it.
>>
>> Fixes: 76730c7b9b5a ("app/testpmd: use packet type parsing API")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
>> ---
>>  app/test-pmd/csumonly.c | 39 ++++++++++++++++-----------------------
>>  1 file changed, 16 insertions(+), 23 deletions(-)
>>
>> diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
>> index d355dbd8c0..a6e872e5a4 100644
>> --- a/app/test-pmd/csumonly.c
>> +++ b/app/test-pmd/csumonly.c
>> @@ -525,20 +525,8 @@ get_tunnel_ol_flags_by_ptype(uint32_t ptype)
>>  	}
>>  }
>>  
>> -static void
>> -parse_inner_l4_proto(void *outer_l3_hdr,
>> -			struct testpmd_offload_info *info)
>> -{
>> -	struct rte_ipv4_hdr *ipv4_hdr = outer_l3_hdr;
>> -	struct rte_ipv6_hdr *ipv6_hdr = outer_l3_hdr;
>> -	if (info->ethertype == _htons(RTE_ETHER_TYPE_IPV4))
>> -		info->l4_proto = ipv4_hdr->next_proto_id;
>> -	else
>> -		info->l4_proto = ipv6_hdr->proto;
>> -}
>> -
>>  static uint8_t
>> -parse_l4_proto(const struct rte_mbuf *m, uint32_t off, uint32_t ptype)
>> +parse_l4_proto(const struct rte_mbuf *m, uint32_t off, uint32_t ptype, bool parse_inner)
>>  {
>>  	int frag = 0, ret;
>>  
>> @@ -557,16 +545,19 @@ parse_l4_proto(const struct rte_mbuf *m, uint32_t off, uint32_t ptype)
>>  		if (unlikely(ip6h == NULL))
>>  			return 0;
>>  
>> -		if ((ptype & RTE_PTYPE_INNER_L3_MASK) ==
>> -				RTE_PTYPE_INNER_L3_IPV6_EXT) {
>> -			ret = rte_net_skip_ip6_ext(ip6h->proto, m, &off, &frag);
>> -			if (ret < 0)
>> -				return 0;
>> -			return ret;
>> -		}
>> +		if (!parse_inner && (ptype & RTE_PTYPE_L3_MASK) != RTE_PTYPE_L3_IPV6_EXT)
>> +			return ip6h->proto;
>> +
>> +		if (parse_inner && (ptype & RTE_PTYPE_INNER_L3_MASK) != RTE_PTYPE_INNER_L3_IPV6_EXT)
>> +			return ip6h->proto;
>>  
>> -		return ip6h->proto;
>> +		off += sizeof(struct rte_ipv6_hdr);
>> +		ret = rte_net_skip_ip6_ext(ip6h->proto, m, &off, &frag);
>> +		if (ret < 0)
>> +			return 0;
>> +		return ret;
>>  	}
>> +
>>  	return 0;
>>  }
>>  
>> @@ -705,7 +696,7 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
>>  		info.l4_len = hdr_lens.l4_len;
>>  		info.ethertype = get_ethertype_by_ptype(eth_hdr,
>>  					ptype & RTE_PTYPE_L3_MASK);
>> -		info.l4_proto = parse_l4_proto(m, info.l2_len, ptype);
>> +		info.l4_proto = parse_l4_proto(m, info.l2_len, ptype, false);
> 
> 
> Setting parse_inner to false would cause l4_proto to be set to the extension
> header type (rather than the real L4 protocol). Was this change intentional?
> Looks like it would cause checksum to be computed incorrectly for simple
> case of IPV6 with extension header and TCP.
> 

Setting `parse_inner` to `false` does not result in `l4_proto` being assigned as an extended header type.
The purpose of `parse_inner` is solely to indicate whether the `parse_l4_proto` function is handling the outer packet header or the inner packet header.
Perhaps renaming the variable to `is_inner` would be more appropriate.

