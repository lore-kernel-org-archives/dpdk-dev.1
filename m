Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FE3C87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 11:22:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F1B24042E;
	Mon, 11 Aug 2025 13:22:39 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 6E0CA4013F;
 Mon, 11 Aug 2025 13:22:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 7896869
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1754911357;
 bh=EZManbMwi77o5Nh4+PLjh4f+cVclgl3Fsv5qlz5spqI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=GfBkudNFod/xsNDHc8ZUxk3FcWcSqQdtuyVNRgLLg2PfEpZ2vecGuEH+RXjaxdQfe
 oYnOWuoiMtJ3ZW1jGb7q6DqWFToYT3PfsdRWxs9/Zl/N60IoZW44NmqvhZgi0Ioih2
 r0oLL0pfyvwvV2cnTBfvkriGlR0OyRmoKtpZIqps=
Received: from [192.168.1.41] (unknown [188.170.86.252])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 7896869;
 Mon, 11 Aug 2025 14:22:37 +0300 (MSK)
Message-ID: <676e5102-280b-4ec7-ac91-9dc8dc5ffa67@oktetlabs.ru>
Date: Mon, 11 Aug 2025 14:22:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/rte_net: fix inner L2 length for tunneled Ethernet
 packets
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Cc: dev@dpdk.org, jasvinder.singh@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, ivan.malov@arknetworks.am, stable@dpdk.org
References: <5a75dd27-a19b-4dad-b3bd-cc7f31e4619d@oktetlabs.ru>
 <20250801112834.60310-1-14pwcse1224@uetpeshawar.edu.pk>
 <7416c5c9-7485-4de1-8006-78a6df128080@oktetlabs.ru>
 <CA++2-x71R+MGC0_ZmC3p8jJ4=q3ZaW3zQeNwrGMp2UuXTkQm0Q@mail.gmail.com>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <CA++2-x71R+MGC0_ZmC3p8jJ4=q3ZaW3zQeNwrGMp2UuXTkQm0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 8/11/25 13:13, Khadem Ullah wrote:
> Hi Andrew,
> You are right, but I haven't found any other reference to the specific 
> usage of the definition i.e. in correspondence with vxlan_decap,
> tunneled offload API and in mbuf packet type .
> According to tunnel offload API, vxlan encap/decap action, the inner 
> header represents the original header
> while the outer represents the encapsulated ones.
> if performed vxlan_decap, it will decapped the outermost and the inner 
> header will remain the original header.
> 
> Please also check tunnel offload api in https://doc.dpdk.org/ 
> guides-20.11/prog_guide/rte_flow.html <https://doc.dpdk.org/ 
> guides-20.11/prog_guide/rte_flow.html>
> 
> Tunnel Offload API provides hardware independent, unified model to 
> offload tunneled traffic. Key model elements are:
> 
>   *
> 
>     apply matches to both outer and inner packet headers during entire
>     offload procedure;
> 
>   *
> 
>     restore outer header of partially offloaded packet;
> 
>   *
> 
>     model is implemented as a set of helper functions.
> 
> 
> E.g., the following two rules (tunnel offload) with  tunnel match and 
> give the innermost packet.
> |||flow create 0 ingress group 0 tunnel_set 1 pattern eth / ipv4 / udp 
> dst is 4789 / vxlan / end actions jump group 1 / end ||flow create 0 
> ingress group 1 tunnel_match 1 pattern eth / ipv4 / udp dst is 4789 / 
> vxlan / eth / ipv4 / end actions queue index 3 / end|
> 
> |pkt = Ether(dst='24:aa:aa:aa:aa:11',src='50:bb:bb:bb:bb:22')/IP()/ 
> UDP(dport=4789,sport=4789)/VXLAN(vni=10)/|
> |Ether(dst='24:cc:cc:cc:cc:33',src='50:dd:dd:dd:dd:44')/IP()/ UDP()
> 
> |
> image.png
> The outer headers were decapsulated and the inner header was redirected 
> to queue 3.
> 
> Incase of two tunneled packets, the outermost tunnel is stripped and the 
> packet from the inner tunnel onward is forwarded to queue 3.
> 
> You can also check  (Action: VXLAN_DECAP) that performs a decapsulation 
> action by stripping
> 
> all headers of the VXLAN tunnel network overlay from the matched flow.
> 
> So, according to vxlan_decap and tunnel offload api, the inner header 
> information must be the information of the innermost not the outmost.
> 
> and then the following would be correct in testpmd:
>   92-bytes VXLAN packet size= (14-byte outer Ethernet header + 20-byte 
> outer IP header + 8-byte outer UDP header + 8-byte VXLAN header )+
> 
>   (14-byte inner Ethernet header + 20-byte inner IP header  + 8-byte 
> inner UDP)

I'm sorry, it is all very interesting, but I don't understand how it is
related to inner_l2_len definition discussion.

Also, please, stop top posting.


> On Mon, Aug 11, 2025 at 2:39 PM Andrew Rybchenko 
> <andrew.rybchenko@oktetlabs.ru <mailto:andrew.rybchenko@oktetlabs.ru>> 
> wrote:
> 
>     On 8/1/25 14:28, Khadem Ullah wrote:
>      > Hi Andrew,
>      >
>      > Thanks for your feedback.
>      >
>      > Please check mbuf packet types and the following test case:
>      > https://doc.dpdk.org/dts-20.02/test_plans/
>     uni_pkt_test_plan.html#test-case-vxlan-tunnel-packet-type-detect
>     <https://doc.dpdk.org/dts-20.02/test_plans/
>     uni_pkt_test_plan.html#test-case-vxlan-tunnel-packet-type-detect>
>      > sendp([Ether()/IP()/UDP()/Vxlan()/Ether()/IP(frag=5)/Raw('\0'*40)],
>      > iface=txItf)
>      >
>      > (outer) L2 type: ETHER
>      > (outer) L3 type: IPV4_EXT_UNKNOWN
>      > (outer) L4 type: Unknown
>      > Tunnel type: GRENAT
>      > Inner L2 type: ETHER
>      > Inner L3 type: IPV4_EXT_UNKNOWN
>      > Inner L4 type: L4_FRAG
>      >
>      >
>      > union {
>      >          uint32_t packet_type; /**< L2/L3/L4 and tunnel
>     information. */
>      >          __extension__
>      >          struct {
>      >            uint8_t l2_type:4;   /**< (Outer) L2 type. */
>      >            uint8_t l3_type:4;   /**< (Outer) L3 type. */
>      >            uint8_t l4_type:4;   /**< (Outer) L4 type. */
>      >            uint8_t tun_type:4;  /**< Tunnel type. */
>      >            union {
>      >              uint8_t inner_esp_next_proto;
>      >              /**< ESP next protocol type, valid if
>      >               * RTE_PTYPE_TUNNEL_ESP tunnel type is set
>      >               * on both Tx and Rx.
>      >               */
>      >              __extension__
>      >              struct {
>      >                uint8_t inner_l2_type:4;
>      >                /**< Inner L2 type. */
>      >                uint8_t inner_l3_type:4;
>      >                /**< Inner L3 type. */
>      >              };
>      >            };
>      >            uint8_t inner_l4_type:4; /**< Inner L4 type. */
>      >          };
>      >        };
>      >
>      >
>      > Based on the above, it seems that inner_l2_len have to the length
>     of Ether.
> 
> 
>     Why?
> 
>      > Ther might need to be some correspondent between both fields to
>     potray the same information.
>      > Or, the inner_l2_type and inner_l2_len are completly different ?
> 
>     Definition says that it is different.
> 
>      >
>      > Best Regards,
>      > Khadem
> 
> 
> 
> -- 
> Engr. Khadem Ullah,
> Software Engineer,
> Dreambig Semiconductor Inc
> https://dreambigsemi.com/ <https://dreambigsemi.com/>

