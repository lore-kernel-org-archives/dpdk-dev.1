Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420CEC83F04
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 16:38:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 588284064C;
	Wed,  2 Jul 2025 18:38:00 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 4A4A44028E
 for <dev@dpdk.org>; Wed,  2 Jul 2025 18:37:58 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0F5D22C7;
 Wed,  2 Jul 2025 09:37:42 -0700 (PDT)
Received: from [10.1.35.68] (JR4XG4HTQC-2.cambridge.arm.com [10.1.35.68])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 449123F66E;
 Wed,  2 Jul 2025 09:37:56 -0700 (PDT)
Message-ID: <6f7c2436-7b2c-4b0b-b1e0-538bce473f31@arm.com>
Date: Wed, 2 Jul 2025 17:37:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] dts: add performance test functions to test suite
 API
Content-Language: en-GB
To: Patrick Robb <probb@iol.unh.edu>, Paul.Szczepanek@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, nprattedev@gmail.com,
 mmahajan@iol.unh.edu, abailey@iol.unh.edu, thomas.wilks@arm.com,
 Nicholas Pratte <npratte@iol.unh.edu>
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20250702052154.381690-1-probb@iol.unh.edu>
 <20250702052154.381690-5-probb@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250702052154.381690-5-probb@iol.unh.edu>
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

On 02/07/2025 06:21, Patrick Robb wrote:
> From: Nicholas Pratte <npratte@iol.unh.edu>
> 
> Provide functional performance method to run performance tests using a
> user-supplied performance traffic generator. The single core performance
> test is included, with some basic statistics checks verifying TG packet
is the test missing?
> transmission rates.
> 
> Bugzilla ID: 1697
> Signed-off-by: Nicholas Pratte <npratte@iol.unh.edu>
> Signed-off-by: Patrick Robb <probb@iol.unh.edu>
> Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
> ---
>   dts/configurations/tests_config.example.yaml | 12 +++++++
>   dts/framework/test_suite.py                  | 34 ++++++++++++++++++--
>   2 files changed, 43 insertions(+), 3 deletions(-)
> 
> diff --git a/dts/configurations/tests_config.example.yaml b/dts/configurations/tests_config.example.yaml
> index c011ac0588..c56951b2b0 100644
> --- a/dts/configurations/tests_config.example.yaml
> +++ b/dts/configurations/tests_config.example.yaml
> @@ -3,3 +3,15 @@
>   # Define the custom test suite configurations
>   hello_world:
>     msg: A custom hello world to you!
> +single_core_forward_perf:
> +  test_parameters:
> +    - frame_size: 64
> +      num_descriptors: 128
> +      expected_mpps: 30.1234
> +    - frame_size: 64
> +      num_descriptors: 128
> +      expected_mpps: 30.2341
> +    - frame_size: 512
> +      num_descriptors: 128
> +      expected_mpps: 19.453376
> +  delta_tolerance: 0.05

where does this come from? Is it meant for the missing test suite?

> \ No newline at end of file
> diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
> index 75d7a6eb6c..4044c85d4d 100644
> --- a/dts/framework/test_suite.py
> +++ b/dts/framework/test_suite.py
> @@ -38,6 +38,10 @@
>       CapturingTrafficGenerator,
>       PacketFilteringConfig,
>   )
> +from framework.testbed_model.traffic_generator.performance_traffic_generator import (
> +    PerformanceTrafficGenerator,
> +    PerformanceTrafficStats,
> +)
>   
>   from .exception import ConfigurationError, InternalError, TestCaseVerifyError
>   from .logger import DTSLogger, get_dts_logger
> @@ -254,11 +258,11 @@ def send_packets_and_capture(
>               A list of received packets.
>           """
>           assert isinstance(
> -            self._ctx.func_tg, CapturingTrafficGenerator
> +            self._ctx.tg, CapturingTrafficGenerator

This looks like it's fixing an issue I noted earlier in the review, 
should be squashed.

>           ), "Cannot capture with a non-capturing traffic generator"
>           # TODO: implement @requires for types of traffic generator
>           packets = self._adjust_addresses(packets)
> -        return self._ctx.func_tg.send_packets_and_capture(
> +        return self._ctx.tg.send_packets_and_capture(
>               packets,
>               self._ctx.topology.tg_port_egress,
>               self._ctx.topology.tg_port_ingress,
> @@ -266,6 +270,27 @@ def send_packets_and_capture(
>               duration,
>           )
>   
> +    def assess_performance_by_packet(
> +        self, packet: Packet, send_mpps: int, duration: int = 60
> +    ) -> PerformanceTrafficStats:
> +        """Send a given packet for a given duration and assess basic performance statistics.
> +
> +        Send `packet` and assess NIC performance for a given duration, corresponding to the test
> +        suite's given topology.
> +
> +        Args:
> +            packet: The packet to send.
> +            send_mpps: The millions packets per second send rate.
> +            duration: Performance test duration (in seconds).
> +
> +        Returns:
> +            Performance statistics of the generated test.
> +        """
> +        assert isinstance(
> +            self._ctx.tg, PerformanceTrafficGenerator
> +        ), "Cannot run performance tests on non-performance traffic generator."
> +        return self._ctx.tg.calculate_traffic_and_stats(packet, send_mpps, duration)
> +
>       def send_packets(
>           self,
>           packets: list[Packet],
> @@ -275,8 +300,11 @@ def send_packets(
>           Args:
>               packets: Packets to send.
>           """
> +        assert isinstance(
> +            self._ctx.tg, CapturingTrafficGenerator
> +        ), "Cannot run performance tests on non-capturing traffic generator."

I am still unsure if we are meant to have co-existing traffic 
generators. But we should make everything more tolerant, ideally this 
should never be reached, and DTS should automatically skip tests 
appropriately. The above assertion and message don't really appear 
related, so this should also be rectified.

>           packets = self._adjust_addresses(packets)
> -        self._ctx.func_tg.send_packets(packets, self._ctx.topology.tg_port_egress)
> +        self._ctx.tg.send_packets(packets, self._ctx.topology.tg_port_egress)
>   
>       def get_expected_packets(
>           self,

