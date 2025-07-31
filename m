Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA85BC87FCC
	for <dpdk-dev@archiver.kernel.org>; Thu, 31 Jul 2025 10:26:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B4C9402E6;
	Thu, 31 Jul 2025 12:26:55 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 9CB964025A;
 Thu, 31 Jul 2025 12:26:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru C2F6E38
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1753957613;
 bh=Oj1KAv0FSV5EZdS0CO3+4RgIS9djUnMxUGf7E2ac5o0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hl+Ny1PflOdFoGfM771zeSe6Ncja9OmedmcqBKAcSR4otiQi39MtkGaPgolUk2l7A
 McNrcCFeA1vh0HAfPGVi1/JBQLWXuODoe1ccO7utLKw34Ek4940om7AvnkV5H7sCkE
 1sydic1HS0LmJQnOBy3VdNB++TjN+2LrLDb2FJDw=
Received: from [192.168.1.39] (unknown [188.170.87.221])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id C2F6E38;
 Thu, 31 Jul 2025 13:26:52 +0300 (MSK)
Message-ID: <5a75dd27-a19b-4dad-b3bd-cc7f31e4619d@oktetlabs.ru>
Date: Thu, 31 Jul 2025 13:26:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/rte_net: fix inner L2 length for tunneled Ethernet
 packets
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>, dev@dpdk.org,
 ivan.malov@arknetworks.am, jasvinder.singh@intel.com,
 bruce.richardson@intel.com
Cc: thomas@monjalon.net, stable@dpdk.org
References: <e7c3c2b2-5f7a-eec4-cbd8-cd17ecec4c46@arknetworks.am>
 <20250729050647.52745-1-14pwcse1224@uetpeshawar.edu.pk>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20250729050647.52745-1-14pwcse1224@uetpeshawar.edu.pk>
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

On 7/29/25 08:06, Khadem Ullah wrote:
> Hi Ivan,
> 
> No, it does not breaking testpmd or any other applications.
> Yes, the structure is correct in rte_net.h and comment as well.
> 
> You can run testpmd in rxonly mode and set verbose to 3, send the following packet from remote and you will observe the output as given below:
> 
> pkt=Ether(src="04:3f:72:f3:7a:43",dst="C8:0A:A9:04:49:1A")/IP(src="19.168.1.1",dst="19.168.1.1")/UDP(dport=4789)/VXLAN(vni=4094)/Ether(dst="22:11:11:11:11:10")/IP(dst="19.168.1.1")/UDP()
> 
> 
> port 0/queue 0: received 1 packets
>    src=04:3F:72:F3:7A:43 - dst=C8:0A:A9:04:49:1A - pool=mb_pool_0 - type=0x0800 - length=92 - nb_segs=1 - hw ptype: L2_ETHER L3_IPV4_EXT_UNKNOWN L4_UDP  - sw ptype: L2_ETHER L3_IPV4 L4_UDP TUNNEL_VXLAN INNER_L2_ETHER INNER_L3_IPV4 INNER_L4_UDP  - l2_len=14 - l3_len=20 - l4_len=8 - tunnel_len=8 - inner_l2_len=30 - inner_l3_len=20 - inner_l4_len=8 - Destination UDP port=4789 - Receive queue=0x0
>    ol_flags: RTE_MBUF_F_RX_L4_CKSUM_GOOD RTE_MBUF_F_RX_IP_CKSUM_GOOD RTE_MBUF_F_RX_OUTER_L4_CKSUM_UNKNOWN
> 
> The length is 92 bytes which is correct but inner_l2_len=30 which is incorrect. According to standard, the following calculation is true of VXLAN header (50 bytes) and VXLAN packet size(92 bytes).
> 
> 50-byte VXLAN header =(14-byte outer ethernet header + 20-byte outer IP header + 8-byte outer UDP header + 8-byte VXLAN header )
> 
>   92-bytes VXLAN packet size= (14-byte outer Ethernet header + 20-byte outer IP header + 8-byte outer UDP header + 8-byte VXLAN header )+ (14-byte inner Ethernet header + 20-byte inner IP header  + 8-byte inner UDP)
> 
> This patch correct the inner_l2_len which is 14 bytes.

No, you're incorrectly assume that sum of all *_len fields should give 
you a length of all packet headers. It is wrong assumption in accordance
with the definition of inner_l2_len which includes outer-l4-len (UDP),
tunnel header (VXLAN) and inner Ethernet header for the packet.
