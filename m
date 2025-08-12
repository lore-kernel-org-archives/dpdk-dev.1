Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BBBC87FCB
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 04:04:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0066040270;
	Tue, 12 Aug 2025 06:04:28 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id E0C4E4026C
 for <dev@dpdk.org>; Tue, 12 Aug 2025 06:04:27 +0200 (CEST)
Received: from debian (unknown [78.109.69.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 5BAB3E097E;
 Tue, 12 Aug 2025 08:04:26 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 5BAB3E097E
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1754971466;
 bh=pWhyrqt9WP5GTOUC4e7kLLJBx98C3Ltmd91CtW5jKi8=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=zOVbW8w1Yb8x/AfGe3eQj1vPNn3au0QwhbjQCcvaK9icdU+vZuEOb06yN085YzEPf
 L7GfaYTWeSx9cF2szBuZa7K07NkRl9l4m8WMk3j1OSb0CL1xFwSoebiM8oKA/Ql+0O
 f/5Y+OBHnrmGHLaMny3mzoxLf9ATuinB8c+4IBzoKU3BkaMMaqwoGudPChCNWTbYkF
 a7Sk1uP0NCXw3tefrcCLpG5zEjOYmjnQXDFyoSMUxtIx4KBaTakWQYkjTrMgcPEwNC
 5XuWhDpLWg8UDP8MaDv3tSR2clHSdoWZILS56MeaU+xnyORtCnZKzhSH/AFviXy5qg
 AbFBcwxtSK3Rg==
Date: Tue, 12 Aug 2025 08:04:18 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Junlong Wang <wang.junlong1@zte.com.cn>
cc: stephen@networkplumber.org, chen.bingbin@zte.com.cn, dev@dpdk.org
Subject: Re: [v4,2/2] net/zxdh: add support flow director ops
In-Reply-To: <20250812012309.2092560-1-wang.junlong1@zte.com.cn>
Message-ID: <78a0102d-984f-5993-bdeb-b78b1b089a90@arknetworks.am>
References: <20250808071048.1906724-3-wang.junlong1@zte.com.cn>
 <20250812012309.2092560-1-wang.junlong1@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2135105265-1754971466=:8223"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2135105265-1754971466=:8223
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 12 Aug 2025, Junlong Wang wrote:

> Hi Maintainer,
> 
> > A general question: does the implementation somehow enforce any specific order
> > of actions? Say, check that ENCAP does not follow DROP? And does it need to
> > enforce, for example, a check that action DECAP is only used when the pattern
> > has matched on the very presence of an encap. header in the packet?
> 
>  1、The DROP action is only supported in ingress direction, And check that DECAP 
>  does not follow DROP.
>  2、It is based on matching the five-tuple of the packet to perform decap and encap
> 
> 
> 
> >> +void zxdh_flow_global_init(void)
> >> +{
> >> +    int i;
> >> +    for (i = 0; i < MAX_FLOW_COUNT_NUM; i++) {
> >> +        rte_spinlock_init(&flow_count_ref[i].count_lock);
> >> +        flow_count_ref[i].count_ref = 0;
> 
> > Just a question: does this absolutely need to be PMD-global and not per-device?
> 
>  Yes, currently, one card only supports 2048 fd rules, 

You say 'one card'. But isn't the driver capable of serving multiple cards
installed on the host and passed to DPDK? If yes, then does it make sense to
confine the total rule capacity of multiple cards to that of just one card?

Perhaps it's just my misunderstanding.

>  and there is no limit on the maximum usage of single pf/vf.
> 
> 
> 
> >> +    print_ether_addr("\nL2\t  dst=", &key->mac_dst, print_buf, buf_size, cur_len);
> >> +    print_ether_addr(" - src=", &key->mac_src, print_buf, buf_size, cur_len);
> >> +    MKDUMPSTR(print_buf, buf_size, *cur_len, " -eth type=0x%04x", key->ether_type);
> 
> > Just to make sure: is this in big-endian or little-endian? The original value of
> > EtherType supposedly comes from RTE flow item spec as a big-endian value.
> 
>  little-endian, HW supports little-endian.
>  We parsed from the RTE flow item spec, performed byte-order conversion,
>  and assigned it to the key.

Sorry - I might've overlooked that in the code. Did not see endianness
converstions in 'fd_flow_parse_pattern', for example. Or does 'data_bitwise' do
that? If yes, then perhaps add a comment to that helper to make it clearer.

> 
> 
> 
> >> +    count->bytes = (uint64_t)(rte_le_to_cpu_32(fstats.hit_bytes_hi)) << 32 |
> >> +                    rte_le_to_cpu_32(fstats.hit_bytes_lo);
> >> +    count->hits = (uint64_t)(rte_le_to_cpu_32(fstats.hit_pkts_hi)) << 32 |
> >> +                    rte_le_to_cpu_32(fstats.hit_pkts_lo);
> 
> > Shouldn't this also check for 'count->reset' (input field)? If the HW does not
> > support resetting the counter upon query, perhaps reject the query then?
> 
> > Also, this sets 'bytes' and 'hits', but not indicate the values are valid by
> > setting 'bytes_set' and 'hits_set'. Why? Please take a look at other PMDs.
> 
>  HW supports query by default, but we currently do not support determining 
>  whether to enable query based on count->reset.
> 
>  Currently, it is not supported to indicate that 'bytes' and 'hits' are valid
>  by setting 'bytes_set' and 'hits_set'.

Do you mean HW does not guarantee that 'hit_bytes_hi/lo' and 'hit_pkts_hi/lo'
are at all valid? That's odd. Perhaps the driver can indicate 'hits/bytes_set'
at least when the actual counters are non-zero?

I may be wrong, but it appears DPDK-based applications expect these 'set' fields
to be 'true' when reading the counters. For example, take a look at OvS [1].

[1] https://github.com/openvswitch/ovs/blob/00dcc546a1b9669b66a8985ceecd8266e33607d7/lib/netdev-offload-dpdk.c#L2562

> 
> 
> 
> 
> >> +        case RTE_FLOW_ITEM_TYPE_ETH:
> >> +            eth_spec = item->spec;
> >> +            eth_mask = item->mask;
> >> +            if (eth_spec && eth_mask) {
> >> +                key->mac_dst = eth_spec->dst;
> >> +                key->mac_src  = eth_spec->src;
> >> +                key_mask->mac_dst  = eth_mask->dst;
> >> +                key_mask->mac_src  = eth_mask->src;
> >> +
> >> +                if (eth_mask->type == 0xffff) {
> >> +                    key->ether_type = eth_spec->type;
> >> +                    key_mask->ether_type = eth_mask->type;
> >> +                }
> >> +            }
> 
> > 1) If both 'spec' and 'mask' are 'NULL', shouldn't the code set some broader
> > match on the sole presence of a Ethernet header?
> > 2) If 'mask' is 'NULL' and 'spec' is not (or vice versa), isn't this an error?
> 
> >> +            break;
> >> +        case RTE_FLOW_ITEM_TYPE_VLAN:
> >> +            vlan_spec = item->spec;
> >> +            vlan_mask = item->mask;
> >> +            if (vlan_spec && vlan_mask) {
> >> +                key->vlan_tci  = vlan_spec->tci;
> >> +                key_mask->vlan_tci = vlan_mask->tci;
> >> +            }
> 
> > Similar questions here. For example, the user having provided the item VLAN
> > but having omitted both 'spec' and 'mask' can be translated into setting the
> > VLAN EtherType in 'key->ether_type', with an appropriate check of whether this
> > key has already been set to an overlapping value by the previous (ETH) item.
> 
>  In my opinion, The values of 'spec' and 'mask' will not be null.
>  If the user does not set 'spec' and 'mask', the passed-in values will be set to 00 and ff by default,
>  which is ensured by the upper-layer interface of dpdk.

Wait a minute.. does this mean that if the user passes, say, ETH / IPV4 / UDP
pattern and the 'spec' and 'mask' of ETH are both 'null', the actual key/mask
values in the HW rule will be, say, for the EtherType, '0000' and 'ffff'?
Is this correct? And which part of DPDK interface envisages that?

Again, may be it's just my misunderstanding.

Thank you.

> 
> 
>  Other issues will de modified, and will be resubbmitted.
> 
>
--8323328-2135105265-1754971466=:8223--
