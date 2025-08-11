Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308C0C87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 11:10:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79C104042E;
	Mon, 11 Aug 2025 13:10:02 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 236CB4013F
 for <dev@dpdk.org>; Mon, 11 Aug 2025 13:10:01 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 673041D13;
 Mon, 11 Aug 2025 04:09:52 -0700 (PDT)
Received: from [10.57.2.91] (unknown [10.57.2.91])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5D1B3F63F;
 Mon, 11 Aug 2025 04:09:59 -0700 (PDT)
Message-ID: <321f7361-5f6a-4017-a7b5-6fbd5a10bb17@arm.com>
Date: Mon, 11 Aug 2025 12:09:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dts: add steps and verify sections to docstrings
Content-Language: en-GB
To: Dean Marx <dmarx@iol.unh.edu>, probb@iol.unh.edu,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org
References: <20250722171957.200698-1-dmarx@iol.unh.edu>
 <20250807145002.297452-1-dmarx@iol.unh.edu>
 <20250807145002.297452-2-dmarx@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250807145002.297452-2-dmarx@iol.unh.edu>
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

Looks mostly fine but as noted in the earlier patch, should be * not -. 
Just one small issue:

On 07/08/2025 15:50, Dean Marx wrote:
> diff --git a/dts/tests/TestSuite_mtu.py b/dts/tests/TestSuite_mtu.py
> index d5b3fe02af..0d36f18b00 100644
> --- a/dts/tests/TestSuite_mtu.py
> +++ b/dts/tests/TestSuite_mtu.py
> @@ -127,35 +127,35 @@ def assess_mtu_boundary(self, testpmd_shell: TestPmdShell, mtu: int) -> None:
>       def test_runtime_mtu_updating_and_forwarding(self) -> None:
>           """Verify runtime MTU adjustments and assess packet forwarding behavior.
>   
> -        Test:
> -            * Start TestPMD in a paired topology.
> -            * Set port MTU to 1500.
> -            * Send packets of 1491, 1500 and 1509 bytes.
> -                * Verify the first two packets are forwarded and the last is dropped.
> -
> -            * Set port MTU to 2400.
> -            * Send packets of 1491, 1500 and 1509 bytes.
> -                * Verify all three packets are forwarded.
> -            * Send packets of 2391, 2400 and 2409 bytes.
> -                * Verify the first two packets are forwarded and the last is dropped.
> -
> -            * Set port MTU to 4800.
> -            * Send packets of 1491, 1500 and 1509 bytes.
> -                * Verify all three packets are forwarded.
> -            * Send packets of 4791, 4800 and 4809 bytes.
> -                * Verify the first two packets are forwarded and the last is dropped.
> -
> -            * Set port MTU to 9000.
> -            * Send packets of 1491, 1500 and 1509 bytes.
> -                * Verify all three packets are forwarded.
> -            * Send packets of 8991, 9000 and 9009 bytes.
> -                * Verify the first two packets are forwarded and the last is dropped.
> +        Steps:
> +            - Start TestPMD in a paired topology.
> +            - Set port MTU to 1500.
> +            - Send packets of 1491, 1500 and 1509 bytes.
> +                Verify the first two packets are forwarded and the last is dropped.
Looks like you broke the second level list by removing the *. The format 
of the original looked fine. Same for the below> +
> +            - Set port MTU to 2400.
> +            - Send packets of 1491, 1500 and 1509 bytes.
> +                Verify all three packets are forwarded.
> +            - Send packets of 2391, 2400 and 2409 bytes.
> +                Verify the first two packets are forwarded and the last is dropped.
> +
> +            - Set port MTU to 4800.
> +            - Send packets of 1491, 1500 and 1509 bytes.
> +                Verify all three packets are forwarded.
> +            - Send packets of 4791, 4800 and 4809 bytes.
> +                Verify the first two packets are forwarded and the last is dropped.
> +
> +            - Set port MTU to 9000.
> +            - Send packets of 1491, 1500 and 1509 bytes.
> +                Verify all three packets are forwarded.
> +            - Send packets of 8991, 9000 and 9009 bytes.
> +                Verify the first two packets are forwarded and the last is dropped.
>           Verify:
> -            * Verifies the successful forwarding of packets via a search for an inserted payload.
> +            - Verifies the successful forwarding of packets via a search for an inserted payload.
>                 If the payload is found, the packet was transmitted successfully. Otherwise, the
>                 packet is considered dropped.
>   
> -            * Verify that standard MTU packets forward, in addition to packets within the limits of
> +            - Verify that standard MTU packets forward, in addition to packets within the limits of
>                 an MTU size set during runtime.
>           """
>           with TestPmdShell(tx_offloads=0x8000, mbuf_size=[JUMBO_MTU + 200]) as testpmd:
