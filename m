Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89315606A336
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XEVr6whM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31A0040285;
	Tue, 10 Nov 2026 13:50:15 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id C42E840281
 for <dev@dpdk.org>; Tue, 10 Nov 2026 13:50:13 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1491A14BF;
 Tue, 10 Nov 2026 04:50:10 -0800 (PST)
Received: from [10.57.17.170] (unknown [10.57.17.170])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33FA33F85F;
 Tue, 10 Nov 2026 04:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794315013; bh=k5NKiSyhhbwJ5sq6Usll/XDPyi487PYTDAIjn8Hm3/M=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=XEVr6whM/XPNLD9GWhAwfoh3SHZon47IpYtG8UANW6OMtWd4XsamOaMToMNjczcti
 JEbUostUIPRkRhu4uO8b8mdEbof8UbORUwQyKf0x3pei9ZAxKfMAHTt13HCYUaW2vU
 cx8RdUC2UgrHUMVT4KmQfLgULU3Eq+bkLM8SyidA=
Message-ID: <9e507b8c-b106-4177-8ce2-e09fc630e4d4@arm.com>
Date: Tue, 10 Nov 2026 12:50:10 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dts: add pvp multi paths vhost performance
 testsuite
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>, patrickrobb1997@gmail.com
Cc: dev@dpdk.org, dladd@iol.unh.edu, abailey@iol.unh.edu, lylavoie@iol.unh.edu
References: <20261008191139.1094155-1-knimoji@iol.unh.edu>
 <20261103220218.902765-1-knimoji@iol.unh.edu>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20261103220218.902765-1-knimoji@iol.unh.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 03/11/2026 22:02, Koushik Bhargav Nimoji wrote:
> diff --git a/dts/api/testbed_model/virtual_device.py b/dts/api/testbed_model/virtual_device.py
> index 1a4794e695..8ac9a625f5 100644
> --- a/dts/api/testbed_model/virtual_device.py
> +++ b/dts/api/testbed_model/virtual_device.py
> @@ -6,6 +6,8 @@
>   Alongside support for physical hardware, DPDK can create various virtual devices.
>   """
>   
> +from api.context import get_ctx
> +
>   
>   class VirtualDevice:
>       """Base class for virtual devices used by DPDK.
> @@ -27,3 +29,9 @@ def __init__(self, name: str) -> None:
>       def __str__(self) -> str:
>           """This corresponds to the name used for DPDK devices."""
>           return self.name
> +
> +
> +def clean_up_vhost() -> None:
> +    """Deletes stale vhost-user Unix domain socket files."""
> +    ctx = get_ctx()
> +    ctx.sut_node.main_session.send_command("rm -rf /tmp/vhost-net*", privileged=True)
I welcome this change but send_command is still something that should be 
called by the relevant OSSession class. In theory main_session can be a 
session for a host of any OS, be Linux, FreeBSD, Windows etc. Therefore 
the changes should be OS-independent.

I've reviewed the usage better and the test suite shouldn't be able to 
arbitrarily create files out of arbitrary paths. We have the class 
Artifact to help abstract the remote filesystem away. On remote session 
this also takes care of cleanup.

Instead of introducing this change which has no real ownership in the 
framework and api packages, I'd suggest letting the test suite create 
the vhost-net using the Artifact class instead.
> diff --git a/dts/configurations/tests_config.example.yaml b/dts/configurations/tests_config.example.yaml
> index ce67385b0b..36a0e7c2f1 100644
> --- a/dts/configurations/tests_config.example.yaml
> +++ b/dts/configurations/tests_config.example.yaml
> @@ -18,6 +18,30 @@ hello_world:
>   #       num_descriptors: 1024
>   #       expected_mpps: 1.0
>   #   delta_tolerance: 0.05
> +# pvp_multi_paths_vhost_single_core_perf:
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
> +# pvp_multi_paths_virtio_single_core_perf:
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
> diff --git a/dts/tests/TestSuite_pvp_multi_paths_vhost_single_core_perf.py b/dts/tests/TestSuite_pvp_multi_paths_vhost_single_core_perf.py
> new file mode 100644
> index 0000000000..269fad1782
> --- /dev/null
> +++ b/dts/tests/TestSuite_pvp_multi_paths_vhost_single_core_perf.py
> @@ -0,0 +1,523 @@
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
> +from typing import TypedDict, cast
> +
> +from scapy.layers.inet import IP
> +from scapy.layers.l2 import Ether
> +from scapy.packet import Raw
> +from typing_extensions import NotRequired
> +
> +from api.capabilities import (
> +    LinkTopology,
> +    requires_link_topology,
> +)
> +from api.packet import assess_performance_by_packet
> +from api.params.eal import VirtualDevice
> +from api.params.types import LogicalCoreList, RSSSetting, TestPmdParamsDict
> +from api.test import get_current_test_case_name, verify, write_performance_json
> +from api.test_suite import BaseConfig, TestSuite, perf_suite, perf_test
> +from api.testbed_model.virtual_device import clean_up_vhost
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
> +class TestParameter(TypedDict):
> +    """Performance test metrics."""
> +
> +    frame_size: int
> +    num_descriptors: int
> +    expected_mpps: float
> +    performance_delta: NotRequired[float | None]
> +    measured_mpps: NotRequired[float | None]
> +    passing: NotRequired[float | None]
I've noticed that this kind of configuration is ubiquitous across 
performance test suites. I'd propose to abstract the Config and this 
away as a generic PerfSuiteConfig and re-use it accordingly. In that 
case you can move away from using a TypedDict and use a Pydantic 
BaseConfig instead which will allow you to use more powerful constructs.

You won't need to use NotRequired – which I am assuming makes doing `| 
None` redundant, in that case. Moreover the fields should be documented 
appropriately similarly to what was done in the config package.> +
> +
> +class Config(BaseConfig):
> +    """Test configuration for pvp_multi_paths_vhost_single_core_perf test suite."""
> +
> +    test_parameters: list[TestParameter] = [
> +        {
> +            "frame_size": 64,
> +            "num_descriptors": 1024,
> +            "expected_mpps": 1.00,
> +            "performance_delta": None,
> +            "measured_mpps": None,
> +            "passing": None,
> +        },
> +        {
> +            "frame_size": 128,
> +            "num_descriptors": 1024,
> +            "expected_mpps": 1.00,
> +            "performance_delta": None,
> +            "measured_mpps": None,
> +            "passing": None,
> +        },
> +        {
> +            "frame_size": 256,
> +            "num_descriptors": 1024,
> +            "expected_mpps": 1.00,
> +            "performance_delta": None,
> +            "measured_mpps": None,
> +            "passing": None,
> +        },
> +        {
> +            "frame_size": 512,
> +            "num_descriptors": 1024,
> +            "expected_mpps": 1.00,
> +            "performance_delta": None,
> +            "measured_mpps": None,
> +            "passing": None,
> +        },
> +        {
> +            "frame_size": 1024,
> +            "num_descriptors": 1024,
> +            "expected_mpps": 1.00,
> +            "performance_delta": None,
> +            "measured_mpps": None,
> +            "passing": None,
> +        },
> +        {
> +            "frame_size": 1518,
> +            "num_descriptors": 1024,
> +            "expected_mpps": 1.00,
> +            "performance_delta": None,
> +            "measured_mpps": None,
> +            "passing": None,
> +        },
> +    ]
> +    delta_tolerance: float = 0.05
So all of the above could be a common Config class that can be re-used 
across perf test suites.> +
> +
> +@perf_suite
> +@requires_link_topology(LinkTopology.TWO_LINKS)
> +class TestPvpMultiPathsVhostSingleCorePerf(TestSuite):
> +    """pvp multi paths vhost single core performance test suite."""
> +
> +    config: Config
> +
> +    def set_up_test_case(self) -> None:
> +        """Delete stale vhost-user Unix domain socket files."""
> +        clean_up_vhost()
> +
> +    def _transmit(
> +        self, vhost: TestPmd, virtio: TestPmd, frame_size: int, repetitions: int = 1
> +    ) -> float:
> +        """Transmit packets using testpmd instances and compute average MPPS.
> +
> +        Args:
> +            vhost: the running vhost testpmd shell.
> +            virtio: the running virtio testpmd shell.
> +            frame_size: The size of the frame to transmit.
> +            repetitions: The number of times to rerun the transmission.
> +
> +        Returns:
> +            The MPPS (millions of packets per second) forwarded by the SUT.
> +        """
> +        assert repetitions > 0, "Invalid number of repetitions given, must be greater than 0."
> +        # Build packet with dummy values, and account for the 14B and 20B Ether and IP headers
> +        packet = (
> +            Ether(src="52:00:00:00:00:00")
> +            / IP(src="1.2.3.4", dst="192.18.1.0")
> +            / Raw(load="x" * (frame_size - 14 - 20))
> +        )
> +
> +        vhost.start()
> +        virtio.start()
> +        rx_avg = 0.0
> +
> +        for _ in range(repetitions):
> +            # Transmit for 5 seconds.
> +            stats = assess_performance_by_packet(packet=packet, duration=5)
> +            rx_avg += stats.rx_pps
> +        return rx_avg / (repetitions * 1_000_000)
> +
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
Here you should be able to do:

   vhost_iface = Artifact("sut", "vhost-net", save_local_copy=False)> + 
       vhost_user_vdev = 
VirtualDevice("net_vhost0,iface=/tmp/vhost-net,queues=1")
   VirtualDevice(f"net_vhost0,iface={vhost_iface.path},queues=1")

etc.
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
> +        for params in self.config.test_parameters:
> +            frame_size = params.get("frame_size")
> +            num_descriptors = params.get("num_descriptors") or 1024
> +            expected_mpps = params.get("expected_mpps") or 1.00
Wouldn't using the default field more appropriate here? What if the 
param is 0? Thinking of:

   num_descriptors = params.get("num_descriptors", 1024)
   expected_mpps = params.get("expected_mpps", 1.00)> +
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
> +                assert expected_mpps > 0, "Invalid expected mpps, must be greater than 0."

Is this assertion a check for a test suite bug or an actual testing 
detail? If the latter then verify should be used here.

> +
> +                measured_mpps = round(
> +                    self._transmit(vhost, virtio, int(frame_size), repetitions=5), 3
> +                )
> +
> +                performance_delta = round(
> +                    (float(measured_mpps) - float(expected_mpps)) / float(expected_mpps),
> +                    3,
> +                )
> +
> +                params["measured_mpps"] = measured_mpps
> +                params["performance_delta"] = performance_delta
> +                params["passing"] = float(performance_delta) >= -self.config.delta_tolerance
> +
> +        self._produce_stats_table(self.config.test_parameters)
> +        for params in self.config.test_parameters:
> +            verify(
> +                params["passing"] is True,
> +                f"""Packets forwarded is less than {(1 - self.config.delta_tolerance) * 100}%
> +                of the expected baseline.
> +                Measured MPPS = {params["measured_mpps"]}
> +                Expected MPPS = {params["expected_mpps"]}""",
> +            )
