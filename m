Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352DCC87FCA
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 Aug 2025 13:23:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81B054066C;
	Fri,  1 Aug 2025 15:23:28 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 47D0140263;
 Fri,  1 Aug 2025 15:23:27 +0200 (CEST)
Received: from debian (unknown [78.109.65.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 942C2E0162;
 Fri,  1 Aug 2025 17:23:25 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 942C2E0162
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1754054606;
 bh=i0bC5cm8iDmOT4RvJwYKFrH5mEMO+8dLOsAsp17/qxg=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=FYyYGH6cp0XhUgYT3bAHfl8dnS4ZME9z/UcRbIfX7mTVRNeuKBbh8FPlUTIMr/h3n
 kO8uAWdvbMsH2LDCOMfqS22JeLk2yI5ryd4GWBklBhUIcEbD+HRUzWwcwQOU8/wBFS
 sqKWP0f1i20Ho1actzbrP+Rea/Gclu/JW26IjCwbMbmDFFYAS8zzGHeXAS1aXH9sv3
 mn9UJJdfHmZhvgVdNOUVu1mKiAJ0hj2D4YbH7nJnpCRKF69g3Zzog4gMuDRnVFZU3G
 tgToKor96OdJ191XCXUZljp4cKRi0Df/VYpI8lxU4FdfPU9UmmcAIVuMjw2eRjPW2/
 /RcSNY+LUANUg==
Date: Fri, 1 Aug 2025 17:23:24 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
cc: dev@dpdk.org, andrew.rybchenko@oktetlabs.ru, jasvinder.singh@intel.com, 
 bruce.richardson@intel.com, thomas@monjalon.net, stable@dpdk.org
Subject: Re: [PATCH] net/rte_net: fix inner L2 length for tunneled Ethernet
 packets
In-Reply-To: <20250801112834.60310-1-14pwcse1224@uetpeshawar.edu.pk>
Message-ID: <812ed3d3-d52a-405d-45bf-244de8eafca4@arknetworks.am>
References: <5a75dd27-a19b-4dad-b3bd-cc7f31e4619d@oktetlabs.ru>
 <20250801112834.60310-1-14pwcse1224@uetpeshawar.edu.pk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

Hi,

On Fri, 1 Aug 2025, Khadem Ullah wrote:

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
>        uint32_t packet_type; /**< L2/L3/L4 and tunnel information. */
>        __extension__
>        struct {
>          uint8_t l2_type:4;   /**< (Outer) L2 type. */
>          uint8_t l3_type:4;   /**< (Outer) L3 type. */
>          uint8_t l4_type:4;   /**< (Outer) L4 type. */
>          uint8_t tun_type:4;  /**< Tunnel type. */
>          union {
>            uint8_t inner_esp_next_proto;
>            /**< ESP next protocol type, valid if
>             * RTE_PTYPE_TUNNEL_ESP tunnel type is set
>             * on both Tx and Rx.
>             */
>            __extension__
>            struct {
>              uint8_t inner_l2_type:4;
>              /**< Inner L2 type. */
>              uint8_t inner_l3_type:4;
>              /**< Inner L3 type. */
>            };
>          };
>          uint8_t inner_l4_type:4; /**< Inner L4 type. */
>        };
>      };
>
>
> Based on the above, it seems that inner_l2_len have to the length of Ether.
> Ther might need to be some correspondent between both fields to potray the same information.
> Or, the inner_l2_type and inner_l2_len are completly different ?

On the one hand, there is mbuf structure, which has got no 'tunnel_len' field.
It has 'l2_len' field [1] with a comment saying that for a tunnel packet, it
includes some extra terms apart from just 'inner L2 header size'. This use of
the 'l2_len' mbuf field is absolutely legitimate, and PMDs confirm this stance.

On the other hand, there is 'rte_net_hdr_lens' structure [2], which does have a
separate 'tunnel_len' field and, in general, has got slightly different naming.
And the 'inner_l2_len' field has a comment that looks almost like a copy-paste
from the mbuf structure. So does 'inner_l2_len' really need to include extra
terms, given the presence of a dedicated 'tunnel_len' field? Is it at all
correct or could it have been overlooked? One should take a closer look.

[1] https://github.com/DPDK/dpdk/blob/b222395561638f89562e4ef42e1eabf2d6db43dd/lib/mbuf/rte_mbuf_core.h#L628
[2] https://github.com/DPDK/dpdk/blob/b222395561638f89562e4ef42e1eabf2d6db43dd/lib/net/rte_net.h#L22

Thank you.

>
> Best Regards,
> Khadem
>
