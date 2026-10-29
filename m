Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCA6606A31A
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Oct 2026 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=i0hyu/0r
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AB5A4025A;
	Thu, 29 Oct 2026 17:53:08 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id A28D240151
 for <dev@dpdk.org>; Thu, 29 Oct 2026 17:53:06 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A437A1682;
 Thu, 29 Oct 2026 09:53:02 -0700 (PDT)
Received: from [10.57.16.241] (unknown [10.57.16.241])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3C793F673;
 Thu, 29 Oct 2026 09:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1793292785; bh=PsiNKxgMpHH6DprLLQ12iGIUuRj+sLoFdGaqXGkoRfg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=i0hyu/0ranXq3C7Y71JnXCYlcbxUEyq7+2vnpbAODm7fZb3i0HLTMVN7IkC1BBEwg
 xzupWmL3nxOB0hd9zacv7crfjSiPYWwXmsnwtHCds+Ux0UzPVX4RIG11BcuYlyk7QS
 PWySBvzR4V0yKT3xINAThppZZ5dK6H/dHfkcmu9g=
Message-ID: <bf59fc3e-f831-4a92-8007-8a8badb454b6@arm.com>
Date: Thu, 29 Oct 2026 16:53:03 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dts: add pvp multi paths vhost performance
 testsuite
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>, patrickrobb1997@gmail.com
Cc: dev@dpdk.org, dladd@iol.unh.edu, abailey@iol.unh.edu, lylavoie@iol.unh.edu
References: <20261008191139.1094155-1-knimoji@iol.unh.edu>
 <20261020173029.162255-1-knimoji@iol.unh.edu>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20261020173029.162255-1-knimoji@iol.unh.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Koushik,

thank you for the wait!

On 20/10/2026 18:30, Koushik Bhargav Nimoji wrote:
> This patch adds the pvp multi paths vhost single core forward
> performance testsuite, which launches testpmd using the vhost
> and virtio virtual devices with one and two cores respectively,
> and tests the vhost single core throughput performance.
> 
> Signed-off-by: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
> ---
>   ...pvp_multi_paths_vhost_single_core_perf.rst |   8 +
>   dts/configurations/tests_config.example.yaml  |  12 +
>   dts/framework/testbed_model/linux_session.py  |   4 +
>   dts/framework/testbed_model/os_session.py     |   4 +
>   ..._pvp_multi_paths_vhost_single_core_perf.py | 467 ++++++++++++++++++
>   5 files changed, 495 insertions(+)
>   create mode 100644 doc/api/dts/tests.TestSuite_pvp_multi_paths_vhost_single_core_perf.rst
>   create mode 100644 dts/tests/TestSuite_pvp_multi_paths_vhost_single_core_perf.py
> 
> diff --git a/doc/api/dts/tests.TestSuite_pvp_multi_paths_vhost_single_core_perf.rst b/doc/api/dts/tests.TestSuite_pvp_multi_paths_vhost_single_core_perf.rst
> new file mode 100644
> index 0000000000..4fcc6b6c91
> --- /dev/null
> +++ b/doc/api/dts/tests.TestSuite_pvp_multi_paths_vhost_single_core_perf.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: BSD-3-Clause
> +
> +pvp_multi_paths_vhost_single_core_perf Test Suite
> +=================================================
> +
> +.. automodule:: tests.TestSuite_pvp_multi_paths_vhost_single_core_perf
> +   :members:
> +   :show-inheritance:
> diff --git a/dts/configurations/tests_config.example.yaml b/dts/configurations/tests_config.example.yaml
> index ce67385b0b..f765526442 100644
> --- a/dts/configurations/tests_config.example.yaml
> +++ b/dts/configurations/tests_config.example.yaml
> @@ -18,6 +18,18 @@ hello_world:
>   #       num_descriptors: 1024
>   #       expected_mpps: 1.0
>   #   delta_tolerance: 0.05
> +# pvp_multi_paths_vhost_single_core_forward_perf:

Is this meant to be:

   pvp_multi_paths_vhost_single_core_perf

> +#   test_parameters: # Add frame size / descriptor count combinations as needed
> +#     - frame_size: 64
> +#       num_descriptors: 512
> +#       expected_mpps: 1.0 # Set millions of packets per second according to your devices expected throughput for this given frame size / descriptor count
> +#     - frame_size: 64
> +#       num_descriptors: 1024
> +#       expected_mpps: 1.0
> +#     - frame_size: 512
> +#       num_descriptors: 1024
> +#       expected_mpps: 1.0
> +#   delta_tolerance: 0.05
>   # pmd_rss:
>   #   NUM_QUEUES: 4
>   #   ACTUAL_KEY_SIZE: 52
> diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
> index 8cc0d09d01..b5cc0a78a9 100644
> --- a/dts/framework/testbed_model/linux_session.py
> +++ b/dts/framework/testbed_model/linux_session.py
> @@ -460,3 +460,7 @@ def configure_ipv4_forwarding(self, enable: bool) -> None:
>           """Overrides :meth:`~.os_session.OSSession.configure_ipv4_forwarding`."""
>           state = 1 if enable else 0
>           self.send_command(f"sysctl -w net.ipv4.ip_forward={state}", privileged=True)
> +
> +    def clean_up_vhost(self) -> None:
> +        """Overrides :meth:`~.os_session.OSSession.clean_up_vhost`."""
> +        self.send_command("rm -rf /tmp/vhost-net*", privileged=True)

I am not particularly pleased with the idea of deleting every 
vhost-net*, just thinking in case this would disrupt any other 
application. Would there be any better way of doing this?

> diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/testbed_model/os_session.py
> index 3f588acd44..a107bfdf1d 100644
> --- a/dts/framework/testbed_model/os_session.py
> +++ b/dts/framework/testbed_model/os_session.py
> @@ -719,3 +719,7 @@ def get_pci_addr_of_crypto_vfs(self, pf_port: Port) -> list[str]:
>               A list containing all of the PCI addresses of the VFs on the port. If the port has no
>               VFs then the list will be empty.
>           """
> +
> +    @abstractmethod
> +    def clean_up_vhost(self) -> None:
> +        """Deletes stale vhost-user Unix domain socket files."""
> diff --git a/dts/tests/TestSuite_pvp_multi_paths_vhost_single_core_perf.py b/dts/tests/TestSuite_pvp_multi_paths_vhost_single_core_perf.py
> new file mode 100644
> index 0000000000..bc220b34b9
> --- /dev/null
> +++ b/dts/tests/TestSuite_pvp_multi_paths_vhost_single_core_perf.py
> @@ -0,0 +1,467 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2026 University of New Hampshire
> +
> +"""Vhost-user single-core forwarding performance test suite.
> +
> +This suite measures the packet forwarding performance of DPDK's vhost-user PMD running on a
> +single CPU core in a Physical-Virtual-Physical (PVP) topology. Performance is evaluated across
> +multiple virtio-user backend options, including packed versus split ring formats, in-order packet
> +processing, mergeable buffers, and SIMD vectorization. Test cases are parameterized using
> +combinations of frame sizes, descriptor ring sizes, and target MPPS baselines specified in the
> +test configuration. High-speed traffic is injected from an external generator through SUT physical
> +interfaces, routed through Vhost and Virtio loops, and returned to the generator to measure
> +aggregate MPPS.
> +"""
> +
> +from typing import cast
> +
> +from scapy.layers.inet import IP
> +from scapy.layers.l2 import Ether
> +from scapy.packet import Raw
> +
> +from api.capabilities import (
> +    LinkTopology,
> +    requires_link_topology,
> +)
> +from api.packet import assess_performance_by_packet
> +from api.params.eal import VirtualDevice
> +from api.params.types import LogicalCoreList, RSSSetting, TestPmdParamsDict
> +from api.test import get_current_test_case_name, verify, write_performance_json
> +from api.test_suite import BaseConfig, TestSuite, perf_test
> +from api.testpmd import TestPmd
> +from api.testpmd.config import (
> +    Params,
> +    PortTopology,
> +    RXRingParams,
> +    SimpleForwardingModes,
> +    TXRingParams,
> +)
> +
> +
> +class Config(BaseConfig):
> +    """Performance test metrics."""
> +
> +    test_parameters: list[dict[str, int | float]] = [

dict[str, int | float] is too permissive.
/If you require the keys to be these ones then you need to explicitly 
specify them otherwise the parser will happily validate junk. Just a 
TypedDict will do the job here:

class TestParameter(TypedDict):
	frame_size: int
	...

> +        {"frame_size": 64, "num_descriptors": 1024, "expected_mpps": 1.00},
> +        {"frame_size": 128, "num_descriptors": 1024, "expected_mpps": 1.00},
> +        {"frame_size": 256, "num_descriptors": 1024, "expected_mpps": 1.00},
> +        {"frame_size": 512, "num_descriptors": 1024, "expected_mpps": 1.00},
> +        {"frame_size": 1024, "num_descriptors": 1024, "expected_mpps": 1.00},
> +        {"frame_size": 1518, "num_descriptors": 1024, "expected_mpps": 1.00},
> +    ]
> +    delta_tolerance: float = 0.05
> +
> +
> +@requires_link_topology(LinkTopology.TWO_LINKS)
> +class TestPvpMultiPathsVhostSingleCorePerf(TestSuite):
> +    """pvp multi paths vhost single core performance test suite."""
> +
> +    config: Config
> +
> +    def set_up_suite(self) -> None:
> +        """Assign test parameters."""
> +        self.test_parameters = self.config.test_parameters
> +        self.delta_tolerance = self.config.delta_tolerance
> +
> +    def set_up_test_case(self) -> None:
> +        """Delete stale vhost-user Unix domain socket files."""
> +        self._ctx.sut_node.main_session.clean_up_vhost()

A test suite should not access the context from _ctx. This is more like 
meant to be __ctx, but due to some old rules we agreed to only stick to 
_ctx. Basically anything private or protected shouldn't be used in test 
suites. TestSuite provides all helpers etc just for the actual test suite.

Finally, ideally main_session shouldn't be accessed by test suites 
either but interfaces that serve the test suites. So the API, as the 
internal specification is bound to change we need to have a consistent API.

> +    def _create_and_transmit(
> +        self,
> +        ring_format: int,
> +        in_order: int,
> +        buffers: int,
> +        vectorized: int,
> +        extra_args: TestPmdParamsDict,
> +    ) -> None:
> +        """Create testpmd instances with specified params and send traffic.
> +
> +        Args:
> +            ring_format: selects the virtio queue descriptor layout.
> +            in_order: toggles in-order packet processing.
> +            buffers: enables mergeable rx buffers.
> +            vectorized: enables SIMD vectorized rx/tx data paths.
> +            extra_args: extra/generic TestPmd arguments.
> +        """
> +        sut_dpdk_driver = self._ctx.sut_node.config.ports[0].os_driver_for_dpdk
> +        vhost_user_vdev = VirtualDevice("net_vhost0,iface=/tmp/vhost-net,queues=1")
> +        virtio_user_vdev = VirtualDevice(
> +            "net_virtio_user0,"
> +            "mac=00:11:22:33:44:10,"
> +            "path=/tmp/vhost-net,"
> +            "queues=1,"
> +            f"packed_vq={ring_format},"
> +            f"mrg_rxbuf={buffers},"
> +            f"in_order={in_order},"
> +            f"vectorized={vectorized}"
> +        )
> +
> +        for params in self.test_parameters:
> +            frame_size = params["frame_size"]
> +            num_descriptors = params["num_descriptors"]
> +
> +            default_args: TestPmdParamsDict = {
> +                "tx_ring": TXRingParams(descriptors=int(num_descriptors)),
> +                "rx_ring": RXRingParams(descriptors=int(num_descriptors)),
> +            }
> +
> +            if sut_dpdk_driver == "mlx5_core":
> +                default_args["burst"] = 64
> +                default_args["mbcache"] = 512
> +            elif sut_dpdk_driver == "i40e":
> +                default_args["rx_queues"] = 1
> +                default_args["tx_queues"] = 1

This could be a problematic bit as we tried our best in the past to make 
test suites as driver-agnostic as possible. Would these undermine that 
ability? Perhaps a comment is needed here.

> +
> +            vhost_params: TestPmdParamsDict = {
> +                "prefix": "vhost",
> +                "allowed_ports": [],
> +                "memory_channels": 4,
> +                "port_topology": PortTopology.chained,
> +                "vdevs": [vhost_user_vdev],
> +                "lcore_list": LogicalCoreList([1, 2]),
> +                "nb_cores": 1,
> +                **default_args,
> +            }
> +
> +            virtio_params: TestPmdParamsDict = {
> +                "prefix": "virtio",
> +                "no_pci": True,
> +                "memory_channels": 4,
> +                "allowed_ports": [],
> +                "vdevs": [virtio_user_vdev],
> +                "lcore_list": LogicalCoreList([3, 4, 5]),
> +                "nb_cores": 2,
> +                **extra_args,
> +                **default_args,
> +            }
> +
> +            with (
> +                TestPmd(**vhost_params) as vhost,
> +                TestPmd(**virtio_params) as virtio,
> +            ):
> +                vhost.set_forward_mode(SimpleForwardingModes.mac)
> +                virtio.set_forward_mode(SimpleForwardingModes.io)
> +                vhost.set_portlist([0, 2, 1])
> +
> +                assert params["expected_mpps"] > 0, "Invalid expected mpps, must be greater than 0."
> +                params["measured_mpps"] = round(
> +                    self._transmit(vhost, virtio, int(frame_size), repetitions=5), 3
> +                )
> +                params["performance_delta"] = round(
> +                    (float(params["measured_mpps"]) - float(params["expected_mpps"]))
> +                    / float(params["expected_mpps"]),
> +                    3,
> +                )
> +                params["pass"] = float(params["performance_delta"]) >= -self.delta_tolerance
> +
> +        self._produce_stats_table(self.test_parameters)
> +        for params in self.test_parameters:
> +            verify(
> +                params["pass"] is True,
> +                f"""Packets forwarded is less than {(1 - self.delta_tolerance) * 100}%
> +                of the expected baseline.
> +                Measured MPPS = {params["measured_mpps"]}
> +                Expected MPPS = {params["expected_mpps"]}""",
> +            )
