Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0756C87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 12:33:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23706402D0;
	Thu,  7 Aug 2025 14:33:26 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 32F0E4027C
 for <dev@dpdk.org>; Thu,  7 Aug 2025 14:33:24 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4byRM10KpGz13N5K;
 Thu,  7 Aug 2025 20:30:05 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 9BE0E1400DC;
 Thu,  7 Aug 2025 20:33:21 +0800 (CST)
Received: from [10.67.121.193] (10.67.121.193) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Aug 2025 20:33:21 +0800
Message-ID: <605ede7c-2842-4c36-bcb4-f9a0e9c1ac1c@huawei.com>
Date: Thu, 7 Aug 2025 20:33:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/rte_net: fix inner L2 length for tunneled Ethernet
 packets
To: Ivan Malov <ivan.malov@arknetworks.am>, Khadem Ullah
 <14pwcse1224@uetpeshawar.edu.pk>
CC: <dev@dpdk.org>, <andrew.rybchenko@oktetlabs.ru>,
 <jasvinder.singh@intel.com>, <bruce.richardson@intel.com>,
 <thomas@monjalon.net>, Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
References: <5a75dd27-a19b-4dad-b3bd-cc7f31e4619d@oktetlabs.ru>
 <20250801112834.60310-1-14pwcse1224@uetpeshawar.edu.pk>
 <812ed3d3-d52a-405d-45bf-244de8eafca4@arknetworks.am>
Content-Language: en-US
From: huangdengdui <huangdengdui@huawei.com>
In-Reply-To: <812ed3d3-d52a-405d-45bf-244de8eafca4@arknetworks.am>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.193]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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


On 2025/8/1 21:23, Ivan Malov wrote:
> Hi,
> 
> On Fri, 1 Aug 2025, Khadem Ullah wrote:
> 
>> Hi Andrew,
>>
>> Thanks for your feedback.
>>
>> Please check mbuf packet types and the following test case:
>> https://doc.dpdk.org/dts-20.02/test_plans/uni_pkt_test_plan.html#test-case-vxlan-tunnel-packet-type-detect
>> sendp([Ether()/IP()/UDP()/Vxlan()/Ether()/IP(frag=5)/Raw('\0'*40)],
>> iface=txItf)
>>
>> (outer) L2 type: ETHER
>> (outer) L3 type: IPV4_EXT_UNKNOWN
>> (outer) L4 type: Unknown
>> Tunnel type: GRENAT
>> Inner L2 type: ETHER
>> Inner L3 type: IPV4_EXT_UNKNOWN
>> Inner L4 type: L4_FRAG
>>
>>
>> union {
>>        uint32_t packet_type; /**< L2/L3/L4 and tunnel information. */
>>        __extension__
>>        struct {
>>          uint8_t l2_type:4;   /**< (Outer) L2 type. */
>>          uint8_t l3_type:4;   /**< (Outer) L3 type. */
>>          uint8_t l4_type:4;   /**< (Outer) L4 type. */
>>          uint8_t tun_type:4;  /**< Tunnel type. */
>>          union {
>>            uint8_t inner_esp_next_proto;
>>            /**< ESP next protocol type, valid if
>>             * RTE_PTYPE_TUNNEL_ESP tunnel type is set
>>             * on both Tx and Rx.
>>             */
>>            __extension__
>>            struct {
>>              uint8_t inner_l2_type:4;
>>              /**< Inner L2 type. */
>>              uint8_t inner_l3_type:4;
>>              /**< Inner L3 type. */
>>            };
>>          };
>>          uint8_t inner_l4_type:4; /**< Inner L4 type. */
>>        };
>>      };
>>
>>
>> Based on the above, it seems that inner_l2_len have to the length of Ether.
>> Ther might need to be some correspondent between both fields to potray the same information.
>> Or, the inner_l2_type and inner_l2_len are completly different ?
> 
> On the one hand, there is mbuf structure, which has got no 'tunnel_len' field.
> It has 'l2_len' field [1] with a comment saying that for a tunnel packet, it
> includes some extra terms apart from just 'inner L2 header size'. This use of
> the 'l2_len' mbuf field is absolutely legitimate, and PMDs confirm this stance.
> 
> On the other hand, there is 'rte_net_hdr_lens' structure [2], which does have a
> separate 'tunnel_len' field and, in general, has got slightly different naming.
> And the 'inner_l2_len' field has a comment that looks almost like a copy-paste
> from the mbuf structure. So does 'inner_l2_len' really need to include extra
> terms, given the presence of a dedicated 'tunnel_len' field? Is it at all
> correct or could it have been overlooked? One should take a closer look.

When processing a tunnel packet, it is preferable for the inner_l2_len in rte_net_hdr_lens and the l2_len in the mbuf to have consistent meanings, as these two fields are typically used together.

Additionally, I think it would be better to add the tunnel_len field to tx_offload in the mbuf[1].
Moreover, inner_l2_len should only include the length of the Ethernet header.

[1] https://elixir.bootlin.com/dpdk/v25.07/source/lib/mbuf/rte_mbuf_core.h#L656


> 
> [1] https://github.com/DPDK/dpdk/blob/b222395561638f89562e4ef42e1eabf2d6db43dd/lib/mbuf/rte_mbuf_core.h#L628
> [2] https://github.com/DPDK/dpdk/blob/b222395561638f89562e4ef42e1eabf2d6db43dd/lib/net/rte_net.h#L22
> 
> Thank you.
> 
>>
>> Best Regards,
>> Khadem
>>
