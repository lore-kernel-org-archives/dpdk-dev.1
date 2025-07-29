Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23CFC87FC9
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 12:40:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7C744026C;
	Tue, 29 Jul 2025 14:40:30 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id D0870400D5
 for <dev@dpdk.org>; Tue, 29 Jul 2025 14:40:29 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16F391516;
 Tue, 29 Jul 2025 05:40:21 -0700 (PDT)
Received: from [10.57.3.118] (unknown [10.57.3.118])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BBD33F673;
 Tue, 29 Jul 2025 05:40:27 -0700 (PDT)
Message-ID: <a74fe639-e6b1-42d1-b681-9d2158c5be4a@arm.com>
Date: Tue, 29 Jul 2025 13:40:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] dts: add exception handling to checksum verify
 method
Content-Language: en-GB
To: Dean Marx <dmarx@iol.unh.edu>, probb@iol.unh.edu,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org
References: <20250722172214.202308-1-dmarx@iol.unh.edu>
 <20250722172214.202308-2-dmarx@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250722172214.202308-2-dmarx@iol.unh.edu>
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

On 22/07/2025 18:22, Dean Marx wrote:
> --- a/dts/tests/TestSuite_checksum_offload.py
> +++ b/dts/tests/TestSuite_checksum_offload.py
> @@ -89,8 +89,11 @@ def send_packet_and_verify_checksum(
>               if testpmd_packet.l4_dport == id:
>                   is_IP = PacketOffloadFlag.RTE_MBUF_F_RX_IP_CKSUM_GOOD in testpmd_packet.ol_flags
>                   is_L4 = PacketOffloadFlag.RTE_MBUF_F_RX_L4_CKSUM_GOOD in testpmd_packet.ol_flags
> -        self.verify(is_L4 == good_L4, "Layer 4 checksum flag did not match expected checksum flag.")
> -        self.verify(is_IP == good_IP, "IP checksum flag did not match expected checksum flag.")
> +        try:
> +            self.verify(is_L4 == good_L4, "Layer 4 checksum flag did not match expected checksum flag.")
> +            self.verify(is_IP == good_IP, "IP checksum flag did not match expected checksum flag.")
> +        except NameError:
> +            self.verify(False, "Test packet was dropped when it should have been received.")

Doesn't really look like the right approach. As it stands I can't tell 
from the code at first glance why are we checking for NameError. I am 
guessing this is because is_L4 is_IP weren't set. We shouldn't cause 
Python to fail on their inexistence and then recover. We should rather 
verify that they exist.

I'd propose to set is_L4 and is_IP to None at the beginning of the 
method. Then after the for loop, check that they are not None through 
self.verify. If mypy becomes unhappy because it can't compare bool with 
bool | None, then verify the non-nullness with an if and do 
self.verify(False, ...) as you are doing already. This will guarantee to 
mypy that the variables won't be None afterwards.
