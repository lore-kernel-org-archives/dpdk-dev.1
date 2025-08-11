Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C2EC87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 09:40:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24D5A4025D;
	Mon, 11 Aug 2025 11:40:00 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id A97EE400D5;
 Mon, 11 Aug 2025 11:39:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru BDB9075
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1754905198;
 bh=8q+/rq9lDa6XFx80erITKVxI0GEcNEzZ20ZWa9W3WzI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kyednv5f/kkkhIX2qeadZQcwxEA7+rJRL/qJ+dp5y8xpenGpQGws2QY0d9vaVJsZB
 SyurEClvVWTPGJUCfopJVu6QHjz+IJ01IZ2zQhYct+hHhC6y2Bo4fSjcogxKWJ4drK
 SVBIjc+c6qDEubp70u/LnTNrgNL6GON6obbTTG7g=
Received: from [192.168.1.41] (unknown [188.170.86.252])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id BDB9075;
 Mon, 11 Aug 2025 12:39:57 +0300 (MSK)
Message-ID: <7416c5c9-7485-4de1-8006-78a6df128080@oktetlabs.ru>
Date: Mon, 11 Aug 2025 12:39:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/rte_net: fix inner L2 length for tunneled Ethernet
 packets
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>, dev@dpdk.org,
 jasvinder.singh@intel.com, bruce.richardson@intel.com
Cc: thomas@monjalon.net, ivan.malov@arknetworks.am, stable@dpdk.org
References: <5a75dd27-a19b-4dad-b3bd-cc7f31e4619d@oktetlabs.ru>
 <20250801112834.60310-1-14pwcse1224@uetpeshawar.edu.pk>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20250801112834.60310-1-14pwcse1224@uetpeshawar.edu.pk>
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

On 8/1/25 14:28, Khadem Ullah wrote:
> Hi Andrew,
> 
> Thanks for your feedback.
> 
> Please check mbuf packet types and the following test case:
> https://doc.dpdk.org/dts-20.02/test_plans/uni_pkt_test_plan.html#test-case-vxlan-tunnel-packet-type-detect
> sendp([Ether()/IP()/UDP()/Vxlan()/Ether()/IP(frag=5)/Raw('\0'*40)],
> iface=txItf)
> 
> (outer) L2 type: ETHER
> (outer) L3 type: IPV4_EXT_UNKNOWN
> (outer) L4 type: Unknown
> Tunnel type: GRENAT
> Inner L2 type: ETHER
> Inner L3 type: IPV4_EXT_UNKNOWN
> Inner L4 type: L4_FRAG
> 
> 
> union {
>          uint32_t packet_type; /**< L2/L3/L4 and tunnel information. */
>          __extension__
>          struct {
>            uint8_t l2_type:4;   /**< (Outer) L2 type. */
>            uint8_t l3_type:4;   /**< (Outer) L3 type. */
>            uint8_t l4_type:4;   /**< (Outer) L4 type. */
>            uint8_t tun_type:4;  /**< Tunnel type. */
>            union {
>              uint8_t inner_esp_next_proto;
>              /**< ESP next protocol type, valid if
>               * RTE_PTYPE_TUNNEL_ESP tunnel type is set
>               * on both Tx and Rx.
>               */
>              __extension__
>              struct {
>                uint8_t inner_l2_type:4;
>                /**< Inner L2 type. */
>                uint8_t inner_l3_type:4;
>                /**< Inner L3 type. */
>              };
>            };
>            uint8_t inner_l4_type:4; /**< Inner L4 type. */
>          };
>        };
> 
> 
> Based on the above, it seems that inner_l2_len have to the length of Ether.


Why?

> Ther might need to be some correspondent between both fields to potray the same information.
> Or, the inner_l2_type and inner_l2_len are completly different ?

Definition says that it is different.

> 
> Best Regards,
> Khadem

