Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B66CCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 15:26:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B47DA4021F;
	Thu,  6 Nov 2025 16:26:01 +0100 (CET)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52]) by mails.dpdk.org (Postfix) with ESMTP id 3CD1F4013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 16:26:01 +0100 (CET)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-64088c6b309so1661561a12.0
 for <dev@dpdk.org>; Thu, 06 Nov 2025 07:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762442761; x=1763047561; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eZWVymXaoQhRYm6WkPBTgll31NPja7o6s7+a9+wlXig=;
 b=bYrThwIX3XTPkm0pD2hI0ZRbVdzmh6rRTxZqXB3Q9gEGJjVLUlBrN17En1bbSn2qgB
 ev5877x5IP/smyEnZumX7Bsn9e2+Oq2jwvCLIvBf1/t0AOiq0XJQOOpwvK48GYG0wpCE
 x5zT2/sJSgAUq0o/UT8yrefE0m1bIx396UrsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762442761; x=1763047561;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eZWVymXaoQhRYm6WkPBTgll31NPja7o6s7+a9+wlXig=;
 b=SQZ9OyKsDk08yCfbwWfGBRIBMwEQAXg+/IbEjqHUN90DjZOsYB0WUPW/0OMnWXcjoW
 O4uq3njlFejrXuav7PRVe9+eLq8uIkg+x9aibegqL6S45hcicMhnfEglsEJbNfbm0ChM
 kW1LSXIUFkqxz92qu/3d5F/k1ZdKXigAyJqY9M28TWzBB2SK0cKtnifRPWUTz+SAzgpP
 gc9srtd/s0YnW4KnMID2M8pUL3cpPaysKQLVsrZunzI58VNSExQHx6oZYGu6riszrvuf
 jFNORe70p/6SpmxQvJCoQa7mbus30w94lO5fWGanGa1vdAl+qi1nAAAA39W2gshfZ3vl
 rB/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW5sfvkOBIb4txm1GLddPYi/y1K+BMRZjSAuIRTgwJSvf0wBGVlmvZKGeLN04i+s52SIM=@dpdk.org
X-Gm-Message-State: AOJu0YyNvZTPpwI0M5ZvJjK/EF6p/TzOyZBq1Fp7/dIPJlLCMwje7r89
 rke12hxP+mM61ICl333s9ntSslokhZcTbMXcSpZitw4xhyWjt/nf6/fakMZpRcxRySJAUZ8+wXv
 6x1c0KzqAj6RPaXcaORcl880R0zpYzQbKX738k3EIZA==
X-Gm-Gg: ASbGncsWz/mKHAvvdgVt5OF9fnETVQ77uHuma8us8EoVBZxw4LzBsw11TBaBPQ+0Mso
 qVcH5qlQvxbA7q4vTukm6GL/y2JmNNTPPXqq26tdzAmHdBkhXED927Vnu+banJZ/tSzuSEg21P1
 NtHiWGF5a1DFJA/ZcszxVmlgLTT6T30BXFKgGf3v+BMvEbBbIKRJb/xKAAPKJFfgNj3nWA/41c8
 0JsBEArtlXnfphTE3OhswijekQlm6ElCI1bkCIWcfTbu3gtAJrKP+gywIaPaXKZmL4qH/wm9VT+
 1iF/zNN4Hzj1vhT8Yw==
X-Google-Smtp-Source: AGHT+IHoJjGo/DdCkUPeXGzgqa82pPaCVVFELlu/Oz6kQWzE4XqsFO20Ej/tQ0D8UYI05X9JplYjGm2n+a7+LbtUlBM=
X-Received: by 2002:a05:6402:5049:b0:640:80f4:3914 with SMTP id
 4fb4d7f45d1cf-64105a4f9b1mr6219557a12.19.1762442760788; Thu, 06 Nov 2025
 07:26:00 -0800 (PST)
MIME-Version: 1.0
References: <20251023013049.1368129-1-probb@iol.unh.edu>
 <20251105223628.1659390-1-probb@iol.unh.edu>
 <20251105223628.1659390-4-probb@iol.unh.edu>
 <CABJ3N2WsSuKhij2XtU1vo6E+dsuGyf9p0sQvaDM1hEhRcxU6eQ@mail.gmail.com>
In-Reply-To: <CABJ3N2WsSuKhij2XtU1vo6E+dsuGyf9p0sQvaDM1hEhRcxU6eQ@mail.gmail.com>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Thu, 6 Nov 2025 10:25:48 -0500
X-Gm-Features: AWmQ_bmzo401ecNCM4_KaraQR6M-p_LLERIOsjWaPGY5EXAs7UUcY36IoRgvt8E
Message-ID: <CABJ3N2XqjAjJxOqk_5ZTp8+sah+Si0mvRwPO+E0SL+YYP_HtJw@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] dts: add performance test functions to test suite
 API
To: Patrick Robb <probb@iol.unh.edu>
Cc: Luca.Vizzarro@arm.com, dev@dpdk.org, Paul.Szczepanek@arm.com, 
 dmarx@iol.unh.edu, Nicholas Pratte <npratte@iol.unh.edu>
Content-Type: multipart/alternative; boundary="000000000000b1adf90642eeae24"
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

--000000000000b1adf90642eeae24
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+class Config(BaseConfig):
+    """Performance test metrics."""
+
+    test_parameters: list[dict[str, int | float]] =3D [
+        {"frame_size": 64, "num_descriptors": 1024, "expected_mpps": 1.00}=
,
+        {"frame_size": 128, "num_descriptors": 1024, "expected_mpps":
1.00},
+        {"frame_size": 256, "num_descriptors": 1024, "expected_mpps":
1.00},
+        {"frame_size": 512, "num_descriptors": 1024, "expected_mpps":
1.00},
+        {"frame_size": 1024, "num_descriptors": 1024, "expected_mpps":
1.00},
+        {"frame_size": 1518, "num_descriptors": 1024, "expected_mpps":
1.00},
+    ]
+    delta_tolerance: float =3D 0.05

Disregard the last comment, I had assumed that the delta_tolerance was in
mpps
not percentage of expected_mpps.

nit: It may be helpful to declare this distinction in a comment above the
delta_tolerance
variable or perhaps use percent_tolerance instead.

Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>

On Thu, Nov 6, 2025 at 8:30=E2=80=AFAM Andrew Bailey <abailey@iol.unh.edu> =
wrote:

> +                params["measured_mpps"] =3D self._transmit(testpmd,
> frame_size)
> +                params["performance_delta"] =3D (
> +                    float(params["measured_mpps"]) -
> float(params["expected_mpps"])
> +                ) / float(params["expected_mpps"])
> +                params["pass"] =3D float(params["performance_delta"]) >=
=3D
> -self.delta_tolerance
>
> This code seems like it can produce false positives. If we are checking i=
f
> a measured mpps is within dela_tolerance of the expected, (pass =3D
> measured_mpps >=3D expected_mpps - delta_tolerance) may be more effective=
. As
> an example of a false positive, use measured_mpps =3D 1.0, expected_mpps =
=3D
> 2.0, and delta_tolerance =3D 0.51. This should be a fail since 1.0 is not
> within 0.51 of 2.0 but equates to (-.50) >=3D (-.51) =3D=3D true.
>
> On Wed, Nov 5, 2025 at 5:37=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> w=
rote:
>
>> From: Nicholas Pratte <npratte@iol.unh.edu>
>>
>> Provide packet transmission function to support performance tests using =
a
>> user-supplied performance traffic generator. The single core performance
>> test is included. It allows the user to define a matrix of frame size,
>> descriptor count, and expected mpps, and fails if any combination does
>> not forward a mpps count within 5% of the given baseline.
>>
>> Bugzilla ID: 1697
>> Signed-off-by: Nicholas Pratte <npratte@iol.unh.edu>
>> Signed-off-by: Patrick Robb <probb@iol.unh.edu>
>> Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
>> Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>
>> ---
>>  ...sts.TestSuite_single_core_forward_perf.rst |   8 +
>>  dts/api/packet.py                             |  35 +++-
>>  dts/api/test.py                               |  32 ++++
>>  dts/configurations/tests_config.example.yaml  |  12 ++
>>  .../TestSuite_single_core_forward_perf.py     | 149 ++++++++++++++++++
>>  5 files changed, 235 insertions(+), 1 deletion(-)
>>  create mode 100644
>> doc/api/dts/tests.TestSuite_single_core_forward_perf.rst
>>  create mode 100644 dts/tests/TestSuite_single_core_forward_perf.py
>>
>> diff --git a/doc/api/dts/tests.TestSuite_single_core_forward_perf.rst
>> b/doc/api/dts/tests.TestSuite_single_core_forward_perf.rst
>> new file mode 100644
>> index 0000000000..3651b0b041
>> --- /dev/null
>> +++ b/doc/api/dts/tests.TestSuite_single_core_forward_perf.rst
>> @@ -0,0 +1,8 @@
>> +.. SPDX-License-Identifier: BSD-3-Clause
>> +
>> +single_core_forward_perf Test Suite
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +.. automodule:: tests.TestSuite_single_core_forward_perf
>> +   :members:
>> +   :show-inheritance:
>> diff --git a/dts/api/packet.py b/dts/api/packet.py
>> index ac7f64dd17..094a1b7a9d 100644
>> --- a/dts/api/packet.py
>> +++ b/dts/api/packet.py
>> @@ -33,6 +33,9 @@
>>  from
>> framework.testbed_model.traffic_generator.capturing_traffic_generator
>> import (
>>      PacketFilteringConfig,
>>  )
>> +from
>> framework.testbed_model.traffic_generator.performance_traffic_generator
>> import (
>> +    PerformanceTrafficStats,
>> +)
>>  from framework.utils import get_packet_summaries
>>
>>
>> @@ -108,7 +111,9 @@ def send_packets(
>>          packets: Packets to send.
>>      """
>>      packets =3D adjust_addresses(packets)
>> -    get_ctx().func_tg.send_packets(packets,
>> get_ctx().topology.tg_port_egress)
>> +    tg =3D get_ctx().func_tg
>> +    if tg:
>> +        tg.send_packets(packets, get_ctx().topology.tg_port_egress)
>>
>>
>>  def get_expected_packets(
>> @@ -317,3 +322,31 @@ def _verify_l3_packet(received_packet: IP,
>> expected_packet: IP) -> bool:
>>      if received_packet.src !=3D expected_packet.src or received_packet.=
dst
>> !=3D expected_packet.dst:
>>          return False
>>      return True
>> +
>> +
>> +def assess_performance_by_packet(
>> +    packet: Packet, duration: float, send_mpps: int | None =3D None
>> +) -> PerformanceTrafficStats:
>> +    """Send a given packet for a given duration and assess basic
>> performance statistics.
>> +
>> +    Send `packet` and assess NIC performance for a given duration,
>> corresponding to the test
>> +    suite's given topology.
>> +
>> +    Args:
>> +        packet: The packet to send.
>> +        duration: Performance test duration (in seconds).
>> +        send_mpps: The millions packets per second send rate.
>> +
>> +    Returns:
>> +        Performance statistics of the generated test.
>> +    """
>> +    from
>> framework.testbed_model.traffic_generator.performance_traffic_generator
>> import (
>> +        PerformanceTrafficGenerator,
>> +    )
>> +
>> +    assert isinstance(
>> +        get_ctx().perf_tg, PerformanceTrafficGenerator
>> +    ), "Cannot send performance traffic with non-performance traffic
>> generator"
>> +    tg: PerformanceTrafficGenerator =3D cast(PerformanceTrafficGenerato=
r,
>> get_ctx().perf_tg)
>> +    # TODO: implement @requires for types of traffic generator
>> +    return tg.calculate_traffic_and_stats(packet, duration, send_mpps)
>> diff --git a/dts/api/test.py b/dts/api/test.py
>> index f58c82715d..11265ee2c1 100644
>> --- a/dts/api/test.py
>> +++ b/dts/api/test.py
>> @@ -6,9 +6,13 @@
>>  This module provides utility functions for test cases, including
>> logging, verification.
>>  """
>>
>> +import json
>> +from datetime import datetime
>> +
>>  from framework.context import get_ctx
>>  from framework.exception import InternalError, SkippedTestException,
>> TestCaseVerifyError
>>  from framework.logger import DTSLogger
>> +from framework.testbed_model.artifact import Artifact
>>
>>
>>  def get_current_test_case_name() -> str:
>> @@ -124,3 +128,31 @@ def get_logger() -> DTSLogger:
>>      if current_test_suite is None:
>>          raise InternalError("No current test suite")
>>      return current_test_suite._logger
>> +
>> +
>> +def write_performance_json(
>> +    performance_data: dict, filename: str =3D "performance_metrics.json=
"
>> +) -> None:
>> +    """Write performance test results to a JSON file in the test suite'=
s
>> output directory.
>> +
>> +    This method creates a JSON file containing performance metrics in
>> the test suite's
>> +    output directory. The data can be a dictionary of any structure. No
>> specific format
>> +    is required.
>> +
>> +    Args:
>> +        performance_data: Dictionary containing performance metrics and
>> results.
>> +        filename: Name of the JSON file to create.
>> +
>> +    Raises:
>> +        InternalError: If performance data is not provided.
>> +    """
>> +    if not performance_data:
>> +        raise InternalError("No performance data to write")
>> +
>> +    perf_data =3D {"timestamp": datetime.now().isoformat(),
>> **performance_data}
>> +    perf_json_artifact =3D Artifact("local", filename)
>> +
>> +    with perf_json_artifact.open("w") as json_file:
>> +        json.dump(perf_data, json_file, indent=3D2)
>> +
>> +    get_logger().info(f"Performance results written to:
>> {perf_json_artifact.local_path}")
>> diff --git a/dts/configurations/tests_config.example.yaml
>> b/dts/configurations/tests_config.example.yaml
>> index c011ac0588..167bc91a35 100644
>> --- a/dts/configurations/tests_config.example.yaml
>> +++ b/dts/configurations/tests_config.example.yaml
>> @@ -3,3 +3,15 @@
>>  # Define the custom test suite configurations
>>  hello_world:
>>    msg: A custom hello world to you!
>> +single_core_forward_perf:
>> +  test_parameters: # Add frame size / descriptor count combinations as
>> needed
>> +    - frame_size: 64
>> +      num_descriptors: 512
>> +      expected_mpps: 1.0 # Set millions of packets per second according
>> to your devices expected throughput for this given frame size / descript=
or
>> count
>> +    - frame_size: 64
>> +      num_descriptors: 1024
>> +      expected_mpps: 1.0
>> +    - frame_size: 512
>> +      num_descriptors: 1024
>> +      expected_mpps: 1.0
>> +  delta_tolerance: 0.05
>> \ No newline at end of file
>> diff --git a/dts/tests/TestSuite_single_core_forward_perf.py
>> b/dts/tests/TestSuite_single_core_forward_perf.py
>> new file mode 100644
>> index 0000000000..8a92ba39b5
>> --- /dev/null
>> +++ b/dts/tests/TestSuite_single_core_forward_perf.py
>> @@ -0,0 +1,149 @@
>> +# SPDX-License-Identifier: BSD-3-Clause
>> +# Copyright(c) 2025 University of New Hampshire
>> +
>> +"""Single core forwarding performance test suite.
>> +
>> +This suite measures the amount of packets which can be forwarded by DPD=
K
>> using a single core.
>> +The testsuites takes in as parameters a set of parameters, each
>> consisting of a frame size,
>> +Tx/Rx descriptor count, and the expected MPPS to be forwarded by the
>> DPDK application. The
>> +test leverages a performance traffic generator to send traffic at two
>> paired TestPMD interfaces
>> +on the SUT system, which forward to one another and then back to the
>> traffic generator's ports.
>> +The aggregate packets forwarded by the two TestPMD ports are compared
>> against the expected MPPS
>> +baseline which is given in the test config, in order to determine the
>> test result.
>> +"""
>> +
>> +from scapy.layers.inet import IP
>> +from scapy.layers.l2 import Ether
>> +from scapy.packet import Raw
>> +
>> +from api.capabilities import (
>> +    LinkTopology,
>> +    requires_link_topology,
>> +)
>> +from api.packet import assess_performance_by_packet
>> +from api.test import verify, write_performance_json
>> +from api.testpmd import TestPmd
>> +from api.testpmd.config import RXRingParams, TXRingParams
>> +from framework.params.types import TestPmdParamsDict
>> +from framework.test_suite import BaseConfig, TestSuite, perf_test
>> +
>> +
>> +class Config(BaseConfig):
>> +    """Performance test metrics."""
>> +
>> +    test_parameters: list[dict[str, int | float]] =3D [
>> +        {"frame_size": 64, "num_descriptors": 1024, "expected_mpps":
>> 1.00},
>> +        {"frame_size": 128, "num_descriptors": 1024, "expected_mpps":
>> 1.00},
>> +        {"frame_size": 256, "num_descriptors": 1024, "expected_mpps":
>> 1.00},
>> +        {"frame_size": 512, "num_descriptors": 1024, "expected_mpps":
>> 1.00},
>> +        {"frame_size": 1024, "num_descriptors": 1024, "expected_mpps":
>> 1.00},
>> +        {"frame_size": 1518, "num_descriptors": 1024, "expected_mpps":
>> 1.00},
>> +    ]
>> +    delta_tolerance: float =3D 0.05
>> +
>> +
>> +@requires_link_topology(LinkTopology.TWO_LINKS)
>> +class TestSingleCoreForwardPerf(TestSuite):
>> +    """Single core forwarding performance test suite."""
>> +
>> +    config: Config
>> +
>> +    def set_up_suite(self):
>> +        """Set up the test suite."""
>> +        self.test_parameters =3D self.config.test_parameters
>> +        self.delta_tolerance =3D self.config.delta_tolerance
>> +
>> +    def _transmit(self, testpmd: TestPmd, frame_size: int) -> float:
>> +        """Create a testpmd session with every rule in the given list,
>> verify jump behavior.
>> +
>> +        Args:
>> +            testpmd: The testpmd shell to use for forwarding packets.
>> +            frame_size: The size of the frame to transmit.
>> +
>> +        Returns:
>> +            The MPPS (millions of packets per second) forwarded by the
>> SUT.
>> +        """
>> +        # Build packet with dummy values, and account for the 14B and
>> 20B Ether and IP headers
>> +        packet =3D (
>> +            Ether(src=3D"52:00:00:00:00:00")
>> +            / IP(src=3D"1.2.3.4", dst=3D"192.18.1.0")
>> +            / Raw(load=3D"x" * (frame_size - 14 - 20))
>> +        )
>> +
>> +        testpmd.start()
>> +
>> +        # Transmit for 30 seconds.
>> +        stats =3D assess_performance_by_packet(packet=3Dpacket, duratio=
n=3D30)
>> +
>> +        rx_mpps =3D stats.rx_pps / 1_000_000
>> +
>> +        return rx_mpps
>> +
>> +    def _produce_stats_table(self, test_parameters: list[dict[str, int =
|
>> float]]) -> None:
>> +        """Display performance results in table format and write to
>> structured JSON file.
>> +
>> +        Args:
>> +            test_parameters: The expected and real stats per set of tes=
t
>> parameters.
>> +        """
>> +        header =3D f"{'Frame Size':>12} | {'TXD/RXD':>12} | {'Real
>> MPPS':>12} | {'Expected MPPS':>14}"
>> +        print("-" * len(header))
>> +        print(header)
>> +        print("-" * len(header))
>> +        for params in test_parameters:
>> +            print(f"{params['frame_size']:>12} |
>> {params['num_descriptors']:>12} | ", end=3D"")
>> +            print(f"{params['measured_mpps']:>12.2f} |
>> {params['expected_mpps']:>14.2f}")
>> +            print("-" * len(header))
>> +
>> +        write_performance_json({"results": test_parameters})
>> +
>> +    @perf_test
>> +    def single_core_forward_perf(self) -> None:
>> +        """Validate expected single core forwarding performance.
>> +
>> +        Steps:
>> +            * Create a packet according to the frame size specified in
>> the test config.
>> +            * Transmit from the traffic generator's ports 0 and 1 at
>> above the expect.
>> +            * Forward on TestPMD's interfaces 0 and 1 with 1 core.
>> +
>> +        Verify:
>> +            * The resulting MPPS forwarded is greater than
>> expected_mpps*(1-delta_tolerance).
>> +        """
>> +        # Find SUT DPDK driver to determine driver specific performance
>> optimization flags
>> +        sut_dpdk_driver =3D
>> self._ctx.sut_node.config.ports[0].os_driver_for_dpdk
>> +
>> +        for params in self.test_parameters:
>> +            frame_size =3D params["frame_size"]
>> +            num_descriptors =3D params["num_descriptors"]
>> +
>> +            driver_specific_testpmd_args: TestPmdParamsDict =3D {
>> +                "tx_ring": TXRingParams(descriptors=3Dnum_descriptors),
>> +                "rx_ring": RXRingParams(descriptors=3Dnum_descriptors),
>> +                "nb_cores": 1,
>> +            }
>> +
>> +            if sut_dpdk_driver =3D=3D "mlx5_core":
>> +                driver_specific_testpmd_args["burst"] =3D 64
>> +                driver_specific_testpmd_args["mbcache"] =3D 512
>> +            elif sut_dpdk_driver =3D=3D "i40e":
>> +                driver_specific_testpmd_args["rx_queues"] =3D 2
>> +                driver_specific_testpmd_args["tx_queues"] =3D 2
>> +
>> +            with TestPmd(
>> +                **driver_specific_testpmd_args,
>> +            ) as testpmd:
>> +                params["measured_mpps"] =3D self._transmit(testpmd,
>> frame_size)
>> +                params["performance_delta"] =3D (
>> +                    float(params["measured_mpps"]) -
>> float(params["expected_mpps"])
>> +                ) / float(params["expected_mpps"])
>> +                params["pass"] =3D float(params["performance_delta"]) >=
=3D
>> -self.delta_tolerance
>> +
>> +        self._produce_stats_table(self.test_parameters)
>> +
>> +        for params in self.test_parameters:
>> +            verify(
>> +                params["pass"] is True,
>> +                f"""Packets forwarded is less than {(1
>> -self.delta_tolerance)*100}%
>> +                of the expected baseline.
>> +                Measured MPPS =3D {params["measured_mpps"]}
>> +                Expected MPPS =3D {params["expected_mpps"]}""",
>> +            )
>> --
>> 2.49.0
>>
>>

--000000000000b1adf90642eeae24
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">+class Config(BaseConfig):<br>+=C2=A0 =C2=A0 &quot;&quot;&=
quot;Performance test metrics.&quot;&quot;&quot;<br>+<br>+=C2=A0 =C2=A0 tes=
t_parameters: list[dict[str, int | float]] =3D [<br>+=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 {&quot;frame_size&quot;: 64, &quot;num_descriptors&quot;: 1024, &quo=
t;expected_mpps&quot;: 1.00},<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;frame_=
size&quot;: 128, &quot;num_descriptors&quot;: 1024, &quot;expected_mpps&quo=
t;: 1.00},<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;frame_size&quot;: 256, &q=
uot;num_descriptors&quot;: 1024, &quot;expected_mpps&quot;: 1.00},<br>+=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;frame_size&quot;: 512, &quot;num_descriptor=
s&quot;: 1024, &quot;expected_mpps&quot;: 1.00},<br>+=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 {&quot;frame_size&quot;: 1024, &quot;num_descriptors&quot;: 1024, &q=
uot;expected_mpps&quot;: 1.00},<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;fram=
e_size&quot;: 1518, &quot;num_descriptors&quot;: 1024, &quot;expected_mpps&=
quot;: 1.00},<br>+=C2=A0 =C2=A0 ]<br>+=C2=A0 =C2=A0 delta_tolerance: float =
=3D 0.05<br><br>Disregard the last comment, I had assumed that the delta_to=
lerance was in mpps<br>not percentage of expected_mpps.<div>=C2=A0 <br>nit:=
 It may be helpful to declare this distinction in a comment above the delta=
_tolerance<div>variable or perhaps use percent_tolerance instead.=C2=A0<div=
><br>Reviewed-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu">=
abailey@iol.unh.edu</a>&gt;</div></div></div></div><br><div class=3D"gmail_=
quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, =
Nov 6, 2025 at 8:30=E2=80=AFAM Andrew Bailey &lt;<a href=3D"mailto:abailey@=
iol.unh.edu">abailey@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div><div style=3D"color:=
inherit">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 params[&q=
uot;measured_mpps&quot;] =3D self._transmit(testpmd, frame_size)<br>+=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 params[&quot;performance_=
delta&quot;] =3D (<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 float(params[&quot;measured_mpps&quot;]) - float(params[&=
quot;expected_mpps&quot;])<br></div></div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ) / float(params[&quot;expected_mpps&quot;])<br>+=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 params[&quot;pass&q=
uot;] =3D float(params[&quot;performance_delta&quot;]) &gt;=3D -self.delta_=
tolerance<br><br>This code seems like it can produce false positives. If we=
 are checking if a measured mpps is within dela_tolerance of the expected, =
(pass =3D measured_mpps &gt;=3D expected_mpps - delta_tolerance) may be mor=
e effective. As an example of a false positive, use measured_mpps =3D 1.0, =
expected_mpps =3D 2.0, and delta_tolerance =3D 0.51. This should be a fail =
since 1.0 is not within 0.51 of 2.0 but equates to (-.50) &gt;=3D (-.51) =
=3D=3D true.=C2=A0 =C2=A0</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Wed, Nov 5, 2025 at 5:37=E2=80=AFPM Patrick Rob=
b &lt;<a href=3D"mailto:probb@iol.unh.edu" target=3D"_blank">probb@iol.unh.=
edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">From: Nicholas Pratte &lt;<a href=3D"mailto:npratte@iol.unh.edu" target=
=3D"_blank">npratte@iol.unh.edu</a>&gt;<br>
<br>
Provide packet transmission function to support performance tests using a<b=
r>
user-supplied performance traffic generator. The single core performance<br=
>
test is included. It allows the user to define a matrix of frame size,<br>
descriptor count, and expected mpps, and fails if any combination does<br>
not forward a mpps count within 5% of the given baseline.<br>
<br>
Bugzilla ID: 1697<br>
Signed-off-by: Nicholas Pratte &lt;<a href=3D"mailto:npratte@iol.unh.edu" t=
arget=3D"_blank">npratte@iol.unh.edu</a>&gt;<br>
Signed-off-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu" target=
=3D"_blank">probb@iol.unh.edu</a>&gt;<br>
Reviewed-by: Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" target=3D"_=
blank">dmarx@iol.unh.edu</a>&gt;<br>
Reviewed-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu" targe=
t=3D"_blank">abailey@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0...sts.TestSuite_single_core_forward_perf.rst |=C2=A0 =C2=A08 +<br>
=C2=A0dts/api/packet.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 35 +++-<br>
=C2=A0dts/api/test.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 32 ++++<=
br>
=C2=A0dts/configurations/tests_config.example.yaml=C2=A0 |=C2=A0 12 ++<br>
=C2=A0.../TestSuite_single_core_forward_perf.py=C2=A0 =C2=A0 =C2=A0| 149 ++=
++++++++++++++++<br>
=C2=A05 files changed, 235 insertions(+), 1 deletion(-)<br>
=C2=A0create mode 100644 doc/api/dts/tests.TestSuite_single_core_forward_pe=
rf.rst<br>
=C2=A0create mode 100644 dts/tests/TestSuite_single_core_forward_perf.py<br=
>
<br>
diff --git a/doc/api/dts/tests.TestSuite_single_core_forward_perf.rst b/doc=
/api/dts/tests.TestSuite_single_core_forward_perf.rst<br>
new file mode 100644<br>
index 0000000000..3651b0b041<br>
--- /dev/null<br>
+++ b/doc/api/dts/tests.TestSuite_single_core_forward_perf.rst<br>
@@ -0,0 +1,8 @@<br>
+.. SPDX-License-Identifier: BSD-3-Clause<br>
+<br>
+single_core_forward_perf Test Suite<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
+<br>
+.. automodule:: tests.TestSuite_single_core_forward_perf<br>
+=C2=A0 =C2=A0:members:<br>
+=C2=A0 =C2=A0:show-inheritance:<br>
diff --git a/dts/api/packet.py b/dts/api/packet.py<br>
index ac7f64dd17..094a1b7a9d 100644<br>
--- a/dts/api/packet.py<br>
+++ b/dts/api/packet.py<br>
@@ -33,6 +33,9 @@<br>
=C2=A0from framework.testbed_model.traffic_generator.capturing_traffic_gene=
rator import (<br>
=C2=A0 =C2=A0 =C2=A0PacketFilteringConfig,<br>
=C2=A0)<br>
+from framework.testbed_model.traffic_generator.performance_traffic_generat=
or import (<br>
+=C2=A0 =C2=A0 PerformanceTrafficStats,<br>
+)<br>
=C2=A0from framework.utils import get_packet_summaries<br>
<br>
<br>
@@ -108,7 +111,9 @@ def send_packets(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0packets: Packets to send.<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0packets =3D adjust_addresses(packets)<br>
-=C2=A0 =C2=A0 get_ctx().func_tg.send_packets(packets, get_ctx().topology.t=
g_port_egress)<br>
+=C2=A0 =C2=A0 tg =3D get_ctx().func_tg<br>
+=C2=A0 =C2=A0 if tg:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tg.send_packets(packets, get_ctx().topology.tg=
_port_egress)<br>
<br>
<br>
=C2=A0def get_expected_packets(<br>
@@ -317,3 +322,31 @@ def _verify_l3_packet(received_packet: IP, expected_pa=
cket: IP) -&gt; bool:<br>
=C2=A0 =C2=A0 =C2=A0if received_packet.src !=3D expected_packet.src or rece=
ived_packet.dst !=3D expected_packet.dst:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return False<br>
=C2=A0 =C2=A0 =C2=A0return True<br>
+<br>
+<br>
+def assess_performance_by_packet(<br>
+=C2=A0 =C2=A0 packet: Packet, duration: float, send_mpps: int | None =3D N=
one<br>
+) -&gt; PerformanceTrafficStats:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Send a given packet for a given duration a=
nd assess basic performance statistics.<br>
+<br>
+=C2=A0 =C2=A0 Send `packet` and assess NIC performance for a given duratio=
n, corresponding to the test<br>
+=C2=A0 =C2=A0 suite&#39;s given topology.<br>
+<br>
+=C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet: The packet to send.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 duration: Performance test duration (in second=
s).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 send_mpps: The millions packets per second sen=
d rate.<br>
+<br>
+=C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Performance statistics of the generated test.<=
br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 from framework.testbed_model.traffic_generator.performance_t=
raffic_generator import (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 PerformanceTrafficGenerator,<br>
+=C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 assert isinstance(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_ctx().perf_tg, PerformanceTrafficGenerator=
<br>
+=C2=A0 =C2=A0 ), &quot;Cannot send performance traffic with non-performanc=
e traffic generator&quot;<br>
+=C2=A0 =C2=A0 tg: PerformanceTrafficGenerator =3D cast(PerformanceTrafficG=
enerator, get_ctx().perf_tg)<br>
+=C2=A0 =C2=A0 # TODO: implement @requires for types of traffic generator<b=
r>
+=C2=A0 =C2=A0 return tg.calculate_traffic_and_stats(packet, duration, send=
_mpps)<br>
diff --git a/dts/api/test.py b/dts/api/test.py<br>
index f58c82715d..11265ee2c1 100644<br>
--- a/dts/api/test.py<br>
+++ b/dts/api/test.py<br>
@@ -6,9 +6,13 @@<br>
=C2=A0This module provides utility functions for test cases, including logg=
ing, verification.<br>
=C2=A0&quot;&quot;&quot;<br>
<br>
+import json<br>
+from datetime import datetime<br>
+<br>
=C2=A0from framework.context import get_ctx<br>
=C2=A0from framework.exception import InternalError, SkippedTestException, =
TestCaseVerifyError<br>
=C2=A0from framework.logger import DTSLogger<br>
+from framework.testbed_model.artifact import Artifact<br>
<br>
<br>
=C2=A0def get_current_test_case_name() -&gt; str:<br>
@@ -124,3 +128,31 @@ def get_logger() -&gt; DTSLogger:<br>
=C2=A0 =C2=A0 =C2=A0if current_test_suite is None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise InternalError(&quot;No current test=
 suite&quot;)<br>
=C2=A0 =C2=A0 =C2=A0return current_test_suite._logger<br>
+<br>
+<br>
+def write_performance_json(<br>
+=C2=A0 =C2=A0 performance_data: dict, filename: str =3D &quot;performance_=
metrics.json&quot;<br>
+) -&gt; None:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Write performance test results to a JSON f=
ile in the test suite&#39;s output directory.<br>
+<br>
+=C2=A0 =C2=A0 This method creates a JSON file containing performance metri=
cs in the test suite&#39;s<br>
+=C2=A0 =C2=A0 output directory. The data can be a dictionary of any struct=
ure. No specific format<br>
+=C2=A0 =C2=A0 is required.<br>
+<br>
+=C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 performance_data: Dictionary containing perfor=
mance metrics and results.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 filename: Name of the JSON file to create.<br>
+<br>
+=C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 InternalError: If performance data is not prov=
ided.<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 if not performance_data:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InternalError(&quot;No performance data =
to write&quot;)<br>
+<br>
+=C2=A0 =C2=A0 perf_data =3D {&quot;timestamp&quot;: datetime.now().isoform=
at(), **performance_data}<br>
+=C2=A0 =C2=A0 perf_json_artifact =3D Artifact(&quot;local&quot;, filename)=
<br>
+<br>
+=C2=A0 =C2=A0 with perf_json_artifact.open(&quot;w&quot;) as json_file:<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 json.dump(perf_data, json_file, indent=3D2)<br=
>
+<br>
+=C2=A0 =C2=A0 get_logger().info(f&quot;Performance results written to: {pe=
rf_json_artifact.local_path}&quot;)<br>
diff --git a/dts/configurations/tests_config.example.yaml b/dts/configurati=
ons/tests_config.example.yaml<br>
index c011ac0588..167bc91a35 100644<br>
--- a/dts/configurations/tests_config.example.yaml<br>
+++ b/dts/configurations/tests_config.example.yaml<br>
@@ -3,3 +3,15 @@<br>
=C2=A0# Define the custom test suite configurations<br>
=C2=A0hello_world:<br>
=C2=A0 =C2=A0msg: A custom hello world to you!<br>
+single_core_forward_perf:<br>
+=C2=A0 test_parameters: # Add frame size / descriptor count combinations a=
s needed<br>
+=C2=A0 =C2=A0 - frame_size: 64<br>
+=C2=A0 =C2=A0 =C2=A0 num_descriptors: 512<br>
+=C2=A0 =C2=A0 =C2=A0 expected_mpps: 1.0 # Set millions of packets per seco=
nd according to your devices expected throughput for this given frame size =
/ descriptor count<br>
+=C2=A0 =C2=A0 - frame_size: 64<br>
+=C2=A0 =C2=A0 =C2=A0 num_descriptors: 1024<br>
+=C2=A0 =C2=A0 =C2=A0 expected_mpps: 1.0<br>
+=C2=A0 =C2=A0 - frame_size: 512<br>
+=C2=A0 =C2=A0 =C2=A0 num_descriptors: 1024<br>
+=C2=A0 =C2=A0 =C2=A0 expected_mpps: 1.0<br>
+=C2=A0 delta_tolerance: 0.05<br>
\ No newline at end of file<br>
diff --git a/dts/tests/TestSuite_single_core_forward_perf.py b/dts/tests/Te=
stSuite_single_core_forward_perf.py<br>
new file mode 100644<br>
index 0000000000..8a92ba39b5<br>
--- /dev/null<br>
+++ b/dts/tests/TestSuite_single_core_forward_perf.py<br>
@@ -0,0 +1,149 @@<br>
+# SPDX-License-Identifier: BSD-3-Clause<br>
+# Copyright(c) 2025 University of New Hampshire<br>
+<br>
+&quot;&quot;&quot;Single core forwarding performance test suite.<br>
+<br>
+This suite measures the amount of packets which can be forwarded by DPDK u=
sing a single core.<br>
+The testsuites takes in as parameters a set of parameters, each consisting=
 of a frame size,<br>
+Tx/Rx descriptor count, and the expected MPPS to be forwarded by the DPDK =
application. The<br>
+test leverages a performance traffic generator to send traffic at two pair=
ed TestPMD interfaces<br>
+on the SUT system, which forward to one another and then back to the traff=
ic generator&#39;s ports.<br>
+The aggregate packets forwarded by the two TestPMD ports are compared agai=
nst the expected MPPS<br>
+baseline which is given in the test config, in order to determine the test=
 result.<br>
+&quot;&quot;&quot;<br>
+<br>
+from scapy.layers.inet import IP<br>
+from scapy.layers.l2 import Ether<br>
+from scapy.packet import Raw<br>
+<br>
+from api.capabilities import (<br>
+=C2=A0 =C2=A0 LinkTopology,<br>
+=C2=A0 =C2=A0 requires_link_topology,<br>
+)<br>
+from api.packet import assess_performance_by_packet<br>
+from api.test import verify, write_performance_json<br>
+from api.testpmd import TestPmd<br>
+from api.testpmd.config import RXRingParams, TXRingParams<br>
+from framework.params.types import TestPmdParamsDict<br>
+from framework.test_suite import BaseConfig, TestSuite, perf_test<br>
+<br>
+<br>
+class Config(BaseConfig):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Performance test metrics.&quot;&quot;&quot=
;<br>
+<br>
+=C2=A0 =C2=A0 test_parameters: list[dict[str, int | float]] =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;frame_size&quot;: 64, &quot;num_descrip=
tors&quot;: 1024, &quot;expected_mpps&quot;: 1.00},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;frame_size&quot;: 128, &quot;num_descri=
ptors&quot;: 1024, &quot;expected_mpps&quot;: 1.00},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;frame_size&quot;: 256, &quot;num_descri=
ptors&quot;: 1024, &quot;expected_mpps&quot;: 1.00},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;frame_size&quot;: 512, &quot;num_descri=
ptors&quot;: 1024, &quot;expected_mpps&quot;: 1.00},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;frame_size&quot;: 1024, &quot;num_descr=
iptors&quot;: 1024, &quot;expected_mpps&quot;: 1.00},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;frame_size&quot;: 1518, &quot;num_descr=
iptors&quot;: 1024, &quot;expected_mpps&quot;: 1.00},<br>
+=C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 delta_tolerance: float =3D 0.05<br>
+<br>
+<br>
+@requires_link_topology(LinkTopology.TWO_LINKS)<br>
+class TestSingleCoreForwardPerf(TestSuite):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Single core forwarding performance test su=
ite.&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 config: Config<br>
+<br>
+=C2=A0 =C2=A0 def set_up_suite(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Set up the test suite.&quot;=
&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.test_parameters =3D self.config.test_para=
meters<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.delta_tolerance =3D self.config.delta_tol=
erance<br>
+<br>
+=C2=A0 =C2=A0 def _transmit(self, testpmd: TestPmd, frame_size: int) -&gt;=
 float:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Create a testpmd session wit=
h every rule in the given list, verify jump behavior.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd: The testpmd shell to us=
e for forwarding packets.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 frame_size: The size of the fram=
e to transmit.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The MPPS (millions of packets pe=
r second) forwarded by the SUT.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Build packet with dummy values, and account =
for the 14B and 20B Ether and IP headers<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether(src=3D&quot;52:00:00:00:00=
:00&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / IP(src=3D&quot;1.2.3.4&quot;, =
dst=3D&quot;192.18.1.0&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / Raw(load=3D&quot;x&quot; * (fr=
ame_size - 14 - 20))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.start()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Transmit for 30 seconds.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 stats =3D assess_performance_by_packet(packet=
=3Dpacket, duration=3D30)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_mpps =3D stats.rx_pps / 1_000_000<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return rx_mpps<br>
+<br>
+=C2=A0 =C2=A0 def _produce_stats_table(self, test_parameters: list[dict[st=
r, int | float]]) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Display performance results =
in table format and write to structured JSON file.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_parameters: The expected an=
d real stats per set of test parameters.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 header =3D f&quot;{&#39;Frame Size&#39;:&gt;12=
} | {&#39;TXD/RXD&#39;:&gt;12} | {&#39;Real MPPS&#39;:&gt;12} | {&#39;Expec=
ted MPPS&#39;:&gt;14}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;-&quot; * len(header))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(header)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;-&quot; * len(header))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for params in test_parameters:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&quot;{params[&#39;frame_=
size&#39;]:&gt;12} | {params[&#39;num_descriptors&#39;]:&gt;12} | &quot;, e=
nd=3D&quot;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&quot;{params[&#39;measur=
ed_mpps&#39;]:&gt;12.2f} | {params[&#39;expected_mpps&#39;]:&gt;14.2f}&quot=
;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;-&quot; * len(header=
))<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 write_performance_json({&quot;results&quot;: t=
est_parameters})<br>
+<br>
+=C2=A0 =C2=A0 @perf_test<br>
+=C2=A0 =C2=A0 def single_core_forward_perf(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validate expected single cor=
e forwarding performance.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a packet according to t=
he frame size specified in the test config.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Transmit from the traffic gene=
rator&#39;s ports 0 and 1 at above the expect.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Forward on TestPMD&#39;s inter=
faces 0 and 1 with 1 core.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The resulting MPPS forwarded i=
s greater than expected_mpps*(1-delta_tolerance).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Find SUT DPDK driver to determine driver spe=
cific performance optimization flags<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sut_dpdk_driver =3D self._ctx.sut_node.config.=
ports[0].os_driver_for_dpdk<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for params in self.test_parameters:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 frame_size =3D params[&quot;fram=
e_size&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 num_descriptors =3D params[&quot=
;num_descriptors&quot;]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 driver_specific_testpmd_args: Te=
stPmdParamsDict =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;tx_ring&quot=
;: TXRingParams(descriptors=3Dnum_descriptors),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;rx_ring&quot=
;: RXRingParams(descriptors=3Dnum_descriptors),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;nb_cores&quo=
t;: 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if sut_dpdk_driver =3D=3D &quot;=
mlx5_core&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 driver_specific_te=
stpmd_args[&quot;burst&quot;] =3D 64<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 driver_specific_te=
stpmd_args[&quot;mbcache&quot;] =3D 512<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif sut_dpdk_driver =3D=3D &quo=
t;i40e&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 driver_specific_te=
stpmd_args[&quot;rx_queues&quot;] =3D 2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 driver_specific_te=
stpmd_args[&quot;tx_queues&quot;] =3D 2<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmd(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 **driver_specific_=
testpmd_args,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ) as testpmd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 params[&quot;measu=
red_mpps&quot;] =3D self._transmit(testpmd, frame_size)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 params[&quot;perfo=
rmance_delta&quot;] =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 floa=
t(params[&quot;measured_mpps&quot;]) - float(params[&quot;expected_mpps&quo=
t;])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ) / float(params[&=
quot;expected_mpps&quot;])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 params[&quot;pass&=
quot;] =3D float(params[&quot;performance_delta&quot;]) &gt;=3D -self.delta=
_tolerance<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._produce_stats_table(self.test_parameters=
)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for params in self.test_parameters:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 params[&quot;pass&=
quot;] is True,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;&quot;&quot=
;Packets forwarded is less than {(1 -self.delta_tolerance)*100}%<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 of the expected ba=
seline.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Measured MPPS =3D =
{params[&quot;measured_mpps&quot;]}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Expected MPPS =3D =
{params[&quot;expected_mpps&quot;]}&quot;&quot;&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div>
</blockquote></div>

--000000000000b1adf90642eeae24--
