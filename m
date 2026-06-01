Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9215ECD5BD1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 14:27:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E341D4065E;
	Mon,  1 Jun 2026 16:27:16 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 453274065E;
 Mon,  1 Jun 2026 16:27:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 4BA245A
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1780324033;
 bh=x3U06ai0bubLByL2j1kjElHo6CKRHVQHUrtXP1zPLC4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MVKRlPIRtQBmH5bOUJDHYNW0Z1VrjcUJ3WxVA3Fc5DBDRVXI95lecBSlC4o2e3Ges
 SJXE8ceA7W2GQ7oiV/0lBGK0rGVaPyONmfrJTxPtbEufmiTGhvMvl0WqwJVzyNDURC
 8QLb9JnhZuv5D6IRCPuT+DmzV2K2Pwo3NgYSVF8k=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 4BA245A;
 Mon,  1 Jun 2026 17:27:13 +0300 (MSK)
Message-ID: <428ec661-ea18-4186-9595-6364ede9a8a0@oktetlabs.ru>
Date: Mon, 1 Jun 2026 17:27:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: fix GTP Tunnel parse out-of-bounds read
To: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Jie Hai <haijie1@huawei.com>
References: <20260409161556.141251-1-stephen@networkplumber.org>
 <-yUhN_HpTAq8QmssYJx54A@monjalon.net>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <-yUhN_HpTAq8QmssYJx54A@monjalon.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 6/1/26 3:59 PM, Thomas Monjalon wrote:
> Any comment about this fix?
> 
> 
> 09/04/2026 18:15, Stephen Hemminger:
>> If packet is fragmented across multiple mbufs or the packet
>> has only GTP header the code would reference outside
>> the incoming mbuf.
>>
>> Send GTP packet:
>> - Valid GTP header (8 bytes)
>> - msg_type = 0xff
>> - e=1, s=1, pn=1 (sets gtp_len = 12)
>> - Total packet size = 10 bytes
>>
>> Read at gh + 12 accesses 2 bytes beyond packet end.
>>
>> The fix is to use rte_pktmbuf_read in a manner similar
>> to the read of the GTP header.
>>
>> Fixes: 64ed7f854cf4 ("net: add tunnel packet type parsing")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

The overall idea LGTM. However one nit in the code.

Reviewed-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

>> ---
>>   lib/net/rte_net.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
>> index 458b4814a9..da4018437b 100644
>> --- a/lib/net/rte_net.c
>> +++ b/lib/net/rte_net.c
>> @@ -219,8 +219,7 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
>>   	case RTE_GTPU_UDP_PORT: {
>>   		const struct rte_gtp_hdr *gh;
>>   		struct rte_gtp_hdr gh_copy;
>> -		uint8_t gtp_len;
>> -		uint8_t ip_ver;
>> +		uint32_t gtp_len;
>>   		gh = rte_pktmbuf_read(m, *off, sizeof(*gh), &gh_copy);
>>   		if (unlikely(gh == NULL))
>>   			return 0;
>> @@ -231,9 +230,16 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
>>   		 * Check message type. If message type is 0xff, it is
>>   		 * a GTP data packet. If not, it is a GTP control packet
>>   		 */
>> +		*off += gtp_len;
>>   		if (gh->msg_type == 0xff) {
>> -			ip_ver = *(const uint8_t *)((const char *)gh + gtp_len);
>> -			ip_ver = (ip_ver) & 0xf0;
>> +			const uint8_t *l3_hdr;

l3_hdr is confusing here. It sounds like a complete layer 3 header, but
it is just one first byte. May be it would be useful to highlight that
it is an inner Layer 3 header.

E.g. inner_l3_hdr_byte (I'm not fully happy with the name too, but
I hope idea is clear)

>> +			uint8_t l3_copy, ip_ver;
>> +
>> +			l3_hdr = rte_pktmbuf_read(m, *off, sizeof(*l3_hdr), &l3_copy);

sizeof(l3_copy) would be safer here.

>> +			if (unlikely(l3_hdr == NULL))
>> +				return 0;
>> +
>> +			ip_ver = *l3_hdr & 0xf0;
>>   			if (ip_ver == RTE_GTP_TYPE_IPV4)
>>   				*proto = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
>>   			else if (ip_ver == RTE_GTP_TYPE_IPV6)
>> @@ -243,7 +249,6 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
>>   		} else {
>>   			*proto = 0;
>>   		}
>> -		*off += gtp_len;
>>   		hdr_lens->inner_l2_len = gtp_len + sizeof(struct rte_udp_hdr);
>>   		hdr_lens->tunnel_len = gtp_len;
>>   		if (port_no == RTE_GTPC_UDP_PORT)
>>
> 
> 
> 
> 
> 

