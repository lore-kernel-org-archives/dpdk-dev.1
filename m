Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384C0606A32E
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=IRSiEh1Q
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BA15402CE;
	Tue, 20 Oct 2026 20:21:18 +0200 (CEST)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by mails.dpdk.org (Postfix) with ESMTP id 35DF540151
 for <dev@dpdk.org>; Tue, 20 Oct 2026 20:21:16 +0200 (CEST)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-5365f9bef55so8975331cf.0
 for <dev@dpdk.org>; Tue, 20 Oct 2026 11:21:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792520475; cv=none;
 d=google.com; s=arc-20260327;
 b=IGb5qQT92dIeVd9xQnPRJJK1SFXprtDEkE/zwqQafyg4wYc30ISLcMo9ZTj00hBt1m
 O+1aaYwpnlVGdD38pjkhMqF04bo0FVwJcUPmXOXCOhMUMsGgxTZ38VsQhj+zIP1n7Pot
 NPxgfwO3sQd5JvxWvxUiw9MSjQvJBKSpd5M6Xit5Q3kjVuwKWyHtR/Q0mSgJS7IWDA5C
 P9ALJgyNj/DFeWJM7nk+hhbdeL96hyKFihgZT45XzGRpdKFAIjiTTu+eZUeAxclyD3iF
 3cR/ZHQ3kk/LqsrEjnlGKS+0Nabj7jnHwqn0N9oZ+aOBpxlQe4/MzXXym1HjjIsjgwHF
 1F3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ajDh4QOpfqGCFdXQ6dXA9yZnYqON09krf1jJC0ul9SU=;
 fh=ZTe2WMj6ccsSWgYStiXZEWKapR8VYmHJMtYeBEBzNTo=;
 b=WQyJjqxKDtMOck/tPKG4llf7ZPjHsuYXQ+67jU2ihiSqUbxeyuq9dVvz8P/NG2Yv5t
 3yFULppU3ZjYwOF4Va9YLa36XgRrP2tZ4zlzvUDFZwZSAodb3Pe/2NqOPFNs/FY+AeNl
 UNtnrRjXm5Mx5F5FVOcfPdqDzbPaW4qMICB+IxenQfFn799VAaJi6qLtyITWk6chc3NV
 wZWnNYSK48BYTp++aLqdSK33O75309ucIlbCt8fpdUG91/SQBidwIM9z33rSLZuDJkBb
 3gW922r4e3vkGjmGveiNx+J318QGU+inQLm+Pf0xNCCAggFsY/+0RK1iao3xTR7zjZxB
 DvTQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1792520475; x=1793125275; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ajDh4QOpfqGCFdXQ6dXA9yZnYqON09krf1jJC0ul9SU=;
 b=IRSiEh1Qv0LvG/dpsv3Iuy+fUXD/AuwAq5aSyUyLZ30oHR7rFvCBjB8ZdJ2uBJIBCn
 c6JhDjM6jRpZ1QBPSGawMEgw2brBYoyf6q61hOkRd5WhRjkrLu+0uVChqXYiIN34rvi1
 CR/yCjB12jUfpo+Ew5amHqpzNN1gtHeeavOMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792520475; x=1793125275;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ajDh4QOpfqGCFdXQ6dXA9yZnYqON09krf1jJC0ul9SU=;
 b=aPJrihFUax7m3LzbirtX3PqAWqK1uRFug3H2nsjRpoNf8zl9WaL3ZBqLSt1vTF0Xwe
 UmF1jC5R+HRkeJNAEjT1ra9MT+mpUugR5Ir3Ps/34EJoxAej4IMgXfniD5FSaPvjngYO
 03L64EAmiYiizT78c+GlYMcJICXcPHlBULAL5BWmEUQ38SoAV6UPFrs+e85mzdQdRy2I
 X6h5QCcatZ6h9lChusoD37Bq4ATu+JLk3UjtPjA/Wt6WWxWezwxtR8CFlwlo5fsQqPuH
 CUvQQR74CGC/8YdyNN3fGfNAPwP2toTpLft2YvmyAKk9ZMFhm9uLFOzPd02sLyp66vDI
 jcsg==
X-Forwarded-Encrypted: i=1;
 AKwUvByBU5/6GhHwNqicIa3Z4Y+0OJEyYarXNTTVXyeK+rCMb4A7R2ykQLhNC8alXGt+JqKAr5w=@dpdk.org
X-Gm-Message-State: AFq9FYIq6X0xGeNtOLF6euAzc+XKKpnATzZzvgzfX9l3mtTa3yGcuC8w
 CFvWI7IbGR0BSIYtEO/zP0wdBf7PtU7mwx/oImnheHRJT1htyBSF4qnc/vyMKJBhozJHAlaYPaz
 cuFdTm73qqXnwXWOuanHDLPz3lshKw8Ve1YLhGUdP1Q==
X-Gm-Gg: AYBFou1EFoi9nmPGsxyDE3eO9184JtPUJhdaPJXhc8LagMGhc7fMDGUpVxWVZwnSqz4
 eos0c/atQRGAcRVWcnPlj8rcUND1Z+suQy05KmU43GRMpOQ5hlPTMHg7a8Iiq1/3McDN5qcD9zc
 UwlTJr9jCYXkveWDNlz/iHtxJfwEaJUEl/Cm9uq4b48H8cKue3fmPYnLwSpCGuvTdrX8SL2PE7I
 Bgah/ntuitKfekvWopjjCuqBfXnJhEoWikfs2NGc29EppXM80xIdViScX7Cckz5iKPO0AUbCK3p
 SgjSNPPSHH2XCyjWPHStu+wQJ4sa9vJJ46c2byHxGjf2AwOIBJZjLg4KMfmescaFuix18cW3BJP
 pNjoWDNr4Cj0z0pZhBDMO+sCTrX04AxNsoZrxizRCs8KdYIxW1cDKyP8izasHKh3vkimtARMVvF
 gmaD53wZPmdJ29U9rhG9lFs0sSvNVGMnrHoLvOjEX4eW+i8XhWYTR0Rw==
X-Received: by 2002:a05:622a:1f9b:b0:536:5a2:76e6 with SMTP id
 d75a77b69052e-53686c6920amr42128271cf.7.1792520475234; Tue, 20 Oct 2026
 11:21:15 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260901183701.431831-1-knimoji@iol.unh.edu>
In-Reply-To: <20260901183701.431831-1-knimoji@iol.unh.edu>
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Date: Tue, 20 Oct 2026 14:20:39 -0400
X-Gm-Features: AclHuK9HBUVmmmSdtbnIKLctGdXquxDdgJjW_34txmqC3tvqyNetyR5JKpjLgXI
Message-ID: <CAKYPG+yjoqMC67H1NN2k=60sKknE2u-WOMq_LEo=Xo-PMvrndw@mail.gmail.com>
Subject: Re: [RFC PATCH] dts: add pvp multi paths virtio performance testsuite
To: luca.vizzarro@arm.com, patrickrobb1997@gmail.com, dev@dpdk.org
Cc: dladd@iol.unh.edu, abailey@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="0000000000002df279065e49b25f"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000002df279065e49b25f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Recheck-request:intel-Testing

On Tue, Sep 1, 2026 at 2:37=E2=80=AFPM Koushik Bhargav Nimoji <knimoji@iol.=
unh.edu>
wrote:

> This patch adds the pvp multi paths virtio single core forward
> performance testsuite, which launches testpmd using the vhost
> and virtio virtual devices with two and one core respectively,
> and tests the virtio single core throughputperformance.
>
> Signed-off-by: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
> ---
>  ...ti_paths_virtio_single_core_performance.py | 399 ++++++++++++++++++
>  1 file changed, 399 insertions(+)
>  create mode 100644
> dts/tests/TestSuite_pvp_multi_paths_virtio_single_core_performance.py
>
> diff --git
> a/dts/tests/TestSuite_pvp_multi_paths_virtio_single_core_performance.py
> b/dts/tests/TestSuite_pvp_multi_paths_virtio_single_core_performance.py
> new file mode 100644
> index 0000000000..aefc29facf
> --- /dev/null
> +++ b/dts/tests/TestSuite_pvp_multi_paths_virtio_single_core_performance.=
py
> @@ -0,0 +1,399 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 University of New Hampshire
> +
> +"""Virtio-user single-core forwarding performance test suite.
> +
> +This suite measures the packet forwarding throughput of DPDK's
> virtio-user PMD running on a
> +single CPU core. Performance is evaluated across multiple virtio path
> implementations, including
> +packed versus split rings, in-order delivery, mergeable buffers, and SIM=
D
> vectorization.
> +Test cases are parameterized using combinations of frame sizes, RX/TX
> descriptor ring counts,
> +and target MPPS baselines specified in the test configuration. High-spee=
d
> traffic is injected
> +from an external generator through the physical host ports into the
> virtio-user instance,
> +looped back, and returned to the generator. The aggregate MPPS processed
> by the single virtio
> +core is verified against configured expected performance baselines to
> determine the test result.
> +"""
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
> +from api.test import verify, write_performance_json
> +from api.testpmd import TestPmd
> +from api.testpmd.config import PortTopology, RXRingParams,
> SimpleForwardingModes, TXRingParams
> +from framework.params.eal import VirtualDevice
> +from framework.params.types import LogicalCoreList, RSSSetting,
> TestPmdParamsDict
> +from framework.test_suite import BaseConfig, TestSuite, perf_test
> +
> +
> +class Config(BaseConfig):
> +    """Performance test metrics."""
> +
> +    test_parameters: list[dict[str, int | float]] =3D [
> +        {"frame_size": 64, "num_descriptors": 1024, "expected_mpps":
> 1.00},
> +        {"frame_size": 128, "num_descriptors": 1024, "expected_mpps":
> 1.00},
> +        {"frame_size": 256, "num_descriptors": 1024, "expected_mpps":
> 1.00},
> +        {"frame_size": 512, "num_descriptors": 1024, "expected_mpps":
> 1.00},
> +        {"frame_size": 1024, "num_descriptors": 1024, "expected_mpps":
> 1.00},
> +        {"frame_size": 1518, "num_descriptors": 1024, "expected_mpps":
> 1.00},
> +    ]
> +    delta_tolerance: float =3D 0.05
> +
> +
> +@requires_link_topology(LinkTopology.TWO_LINKS)
> +class TestPvpMultiPathsVirtioSingleCorePerformance(TestSuite):
> +    """pvp multi paths virtio single core performance test suite."""
> +
> +    config: Config
> +
> +    def set_up_suite(self):
> +        """Assign test parameters."""
> +        self.test_parameters =3D self.config.test_parameters
> +        self.delta_tolerance =3D self.config.delta_tolerance
> +
> +    def set_up_test_case(self):
> +        """Delete stale vhost-user Unix domain socket files."""
> +        self._ctx.sut_node.main_session.send_command("rm -rf
> /tmp/vhost-net*", privileged=3DTrue)
> +
> +    def _transmit(
> +        self, vhost: TestPmd, virtio: TestPmd, frame_size: int,
> repetitions: int =3D 1
> +    ) -> float:
> +        """Create a testpmd session with every rule in the given list,
> verify jump behavior.
> +
> +        Args:
> +            vhost: the running vhost testpmd shell.
> +            virtio: the running virtio testpmd shell.
> +            frame_size: The size of the frame to transmit.
> +            repetitions: The number of times to rerun the transmission.
> +
> +        Returns:
> +            The MPPS (millions of packets per second) forwarded by the
> SUT.
> +        """
> +        assert repetitions > 0, "Invalid number of repetitions given."
> +        # Build packet with dummy values, and account for the 14B and 20=
B
> Ether and IP headers
> +        packet =3D (
> +            Ether(src=3D"52:00:00:00:00:00")
> +            / IP(src=3D"1.2.3.4", dst=3D"192.18.1.0")
> +            / Raw(load=3D"x" * (frame_size - 14 - 20))
> +        )
> +
> +        vhost.start()
> +        virtio.start()
> +        rx_avg =3D 0.0
> +
> +        for _ in range(repetitions):
> +            # Transmit for 5 seconds.
> +            stats =3D assess_performance_by_packet(packet=3Dpacket,
> duration=3D5)
> +            rx_avg +=3D stats.rx_pps
> +        return rx_avg / (repetitions * 1_000_000)
> +
> +    def _create_and_transmit(
> +        self,
> +        ring_format: int,
> +        in_order: int,
> +        buffers: int,
> +        vectorized: int,
> +        extra_args: TestPmdParamsDict,
> +    ):
> +        """Create testpmd instance with specified params and send
> traffic."""
> +        sut_dpdk_driver =3D
> self._ctx.sut_node.config.ports[0].os_driver_for_dpdk
> +        vhost_user_vdev =3D
> VirtualDevice("net_vhost0,iface=3D/tmp/vhost-net,queues=3D1")
> +        virtio_user_vdev =3D VirtualDevice(
> +            "net_virtio_user0,"
> +            "mac=3D00:11:22:33:44:10,"
> +            "path=3D/tmp/vhost-net,"
> +            "queues=3D1,"
> +            f"packed_vq=3D{ring_format},"
> +            f"mrg_rxbuf=3D{buffers},"
> +            f"in_order=3D{in_order},"
> +            f"vectorized=3D{vectorized}"
> +        )
> +
> +        for params in self.test_parameters:
> +            frame_size =3D params["frame_size"]
> +            num_descriptors =3D params["num_descriptors"]
> +
> +            default_args =3D {
> +                "tx_ring": TXRingParams(descriptors=3Dnum_descriptors),
> +                "rx_ring": RXRingParams(descriptors=3Dnum_descriptors),
> +            }
> +
> +            if sut_dpdk_driver =3D=3D "mlx5_core":
> +                default_args["burst"] =3D 64
> +                default_args["mbcache"] =3D 512
> +            elif sut_dpdk_driver =3D=3D "i40e":
> +                default_args["rx_queues"] =3D 1
> +                default_args["tx_queues"] =3D 1
> +
> +            with (
> +                TestPmd(
> +                    prefix=3D"vhost",
> +                    allowed_ports=3D[],
> +                    memory_channels=3D4,
> +                    port_topology=3DPortTopology.chained,
> +                    vdevs=3D[vhost_user_vdev],
> +                    lcore_list=3DLogicalCoreList([1, 2, 3]),
> +                    nb_cores=3D2,
> +                    **default_args,
> +                ) as vhost,
> +                TestPmd(
> +                    prefix=3D"virtio",
> +                    no_pci=3DTrue,
> +                    memory_channels=3D4,
> +                    allowed_ports=3D[],
> +                    vdevs=3D[virtio_user_vdev],
> +                    lcore_list=3DLogicalCoreList([4, 5]),
> +                    nb_cores=3D1,
> +                    **extra_args,
> +                    **default_args,
> +                ) as virtio,
> +            ):
> +                vhost.set_forward_mode(SimpleForwardingModes.io)
> +                virtio.set_forward_mode(SimpleForwardingModes.mac)
> +                vhost.set_portlist([0, 2, 1])
> +
> +                params["measured_mpps"] =3D round(
> +                    self._transmit(vhost, virtio, frame_size,
> repetitions=3D5), 3
> +                )
> +                params["performance_delta"] =3D round(
> +                    (float(params["measured_mpps"]) -
> float(params["expected_mpps"]))
> +                    / float(params["expected_mpps"]),
> +                    3,
> +                )
> +                params["pass"] =3D float(params["performance_delta"]) >=
=3D
> -self.delta_tolerance
> +
> +        self._produce_stats_table(self.test_parameters)
> +        for params in self.test_parameters:
> +            verify(
> +                params["pass"] is True,
> +                f"""Packets forwarded is less than {(1 -
> self.delta_tolerance) * 100}%
> +                of the expected baseline.
> +                Measured MPPS =3D {params["measured_mpps"]}
> +                Expected MPPS =3D {params["expected_mpps"]}""",
> +            )
> +
> +    def _produce_stats_table(self, test_parameters: list[dict[str, int |
> float]]) -> None:
> +        """Display performance results in table format and write to
> structured JSON file.
> +
> +        Args:
> +            test_parameters: The expected and real stats per set of test
> parameters.
> +        """
> +        header =3D f"{'Frame Size':>12} | {'TXD/RXD':>12} | {'Real
> MPPS':>12} | {'Expected MPPS':>14}"
> +        print("-" * len(header))
> +        print(header)
> +        print("-" * len(header))
> +        for params in test_parameters:
> +            print(f"{params['frame_size']:>12} |
> {params['num_descriptors']:>12} | ", end=3D"")
> +            print(f"{params['measured_mpps']:>12} |
> {params['expected_mpps']:>14}")
> +            print("-" * len(header))
> +
> +        write_performance_json({"results": test_parameters})
> +
> +    @perf_test
> +    def test_perf_vhost_single_core_virtio11_mergeable(self):
> +        """Validate expected single core forwarding performance.
> +
> +        Steps:
> +            * Set TestPMD virtio parameters: ring_format=3D1, buffers=3D=
1.
> +            * Create a packet according to the frame size specified in
> the test config.
> +            * Transmit from the traffic generator's ports 0 and 1 at
> above the expect.
> +            * Forward on TestPMD's interfaces 0 and 1 with 1 core.
> +
> +        Verify:
> +            * The resulting MPPS forwarded is greater than
> expected_mpps*(1-delta_tolerance).
> +        """
> +        extra_args: TestPmdParamsDict =3D {
> +            "tx_offloads": 0,
> +            "enable_hw_vlan_strip": True,
> +            "rss": RSSSetting.SetIPOnly(),
> +        }
> +        self._create_and_transmit(
> +            ring_format=3D1, buffers=3D1, in_order=3D0, vectorized=3D0,
> extra_args=3Dextra_args
> +        )
> +
> +    @perf_test
> +    def test_perf_vhost_single_core_virtio11_non_mergeable(self):
> +        """Validate expected single core forwarding performance.
> +
> +        Steps:
> +            * Set TestPMD virtio parameters: ring_format=3D1.
> +            * Create a packet according to the frame size specified in
> the test config.
> +            * Transmit from the traffic generator's ports 0 and 1 at
> above the expect.
> +            * Forward on TestPMD's interfaces 0 and 1 with 1 core.
> +
> +        Verify:
> +            * The resulting MPPS forwarded is greater than
> expected_mpps*(1-delta_tolerance).
> +        """
> +        extra_args: TestPmdParamsDict =3D {
> +            "tx_offloads": 0,
> +            "enable_hw_vlan_strip": True,
> +            "rss": RSSSetting.SetIPOnly(),
> +        }
> +        self._create_and_transmit(
> +            ring_format=3D1, buffers=3D0, in_order=3D0, vectorized=3D0,
> extra_args=3Dextra_args
> +        )
> +
> +    @perf_test
> +    def test_perf_vhost_single_core_virtio_inorder_mergeable(self):
> +        """Validate expected single core forwarding performance.
> +
> +        Steps:
> +            * Set TestPMD virtio parameters: buffers=3D1, in_order=3D1.
> +            * Create a packet according to the frame size specified in
> the test config.
> +            * Transmit from the traffic generator's ports 0 and 1 at
> above the expect.
> +            * Forward on TestPMD's interfaces 0 and 1 with 1 core.
> +
> +        Verify:
> +            * The resulting MPPS forwarded is greater than
> expected_mpps*(1-delta_tolerance).
> +        """
> +        extra_args: TestPmdParamsDict =3D {
> +            "tx_offloads": 0,
> +            "enable_hw_vlan_strip": True,
> +            "rss": RSSSetting.SetIPOnly(),
> +        }
> +        self._create_and_transmit(
> +            ring_format=3D0, buffers=3D1, in_order=3D1, vectorized=3D0,
> extra_args=3Dextra_args
> +        )
> +
> +    @perf_test
> +    def test_perf_vhost_single_core_virtio_inorder_nonmergeable(self):
> +        """Validate expected single core forwarding performance.
> +
> +        Steps:
> +            * Set TestPMD virtio parameters: in_order=3D1.
> +            * Create a packet according to the frame size specified in
> the test config.
> +            * Transmit from the traffic generator's ports 0 and 1 at
> above the expect.
> +            * Forward on TestPMD's interfaces 0 and 1 with 1 core.
> +
> +        Verify:
> +            * The resulting MPPS forwarded is greater than
> expected_mpps*(1-delta_tolerance).
> +        """
> +        extra_args: TestPmdParamsDict =3D {
> +            "tx_offloads": 0,
> +            "enable_hw_vlan_strip": True,
> +            "rss": RSSSetting.SetIPOnly(),
> +        }
> +        self._create_and_transmit(
> +            ring_format=3D0, buffers=3D0, in_order=3D1, vectorized=3D0,
> extra_args=3Dextra_args
> +        )
> +
> +    @perf_test
> +    def test_perf_vhost_single_core_virtio_mergeable(self):
> +        """Validate expected single core forwarding performance.
> +
> +        Steps:
> +            * Set TestPMD virtio parameters: buffers=3D1.
> +            * Create a packet according to the frame size specified in
> the test config.
> +            * Transmit from the traffic generator's ports 0 and 1 at
> above the expect.
> +            * Forward on TestPMD's interfaces 0 and 1 with 1 core.
> +
> +        Verify:
> +            * The resulting MPPS forwarded is greater than
> expected_mpps*(1-delta_tolerance).
> +        """
> +        extra_args: TestPmdParamsDict =3D {
> +            "tx_offloads": 0,
> +            "enable_hw_vlan_strip": True,
> +            "rss": RSSSetting.SetIPOnly(),
> +        }
> +        self._create_and_transmit(
> +            ring_format=3D0, buffers=3D1, in_order=3D0, vectorized=3D0,
> extra_args=3Dextra_args
> +        )
> +
> +    @perf_test
> +    def test_perf_vhost_single_core_virtio_nonmergeable(self):
> +        """Validate expected single core forwarding performance.
> +
> +        Steps:
> +            * Set TestPMD virtio parameters: vectorized=3D1.
> +            * Create a packet according to the frame size specified in
> the test config.
> +            * Transmit from the traffic generator's ports 0 and 1 at
> above the expect.
> +            * Forward on TestPMD's interfaces 0 and 1 with 1 core.
> +
> +        Verify:
> +            * The resulting MPPS forwarded is greater than
> expected_mpps*(1-delta_tolerance).
> +        """
> +        extra_args: TestPmdParamsDict =3D {
> +            "tx_offloads": 0,
> +            "enable_hw_vlan_strip": True,
> +            "rss": RSSSetting.SetIPOnly(),
> +        }
> +        self._create_and_transmit(
> +            ring_format=3D0, buffers=3D0, in_order=3D0, vectorized=3D1,
> extra_args=3Dextra_args
> +        )
> +
> +    @perf_test
> +    def test_perf_vhost_single_core_virtio_vectorized(self):
> +        """Validate expected single core forwarding performance.
> +
> +        Steps:
> +            * Set TestPMD virtio parameters: buffers=3D1.
> +            * Create a packet according to the frame size specified in
> the test config.
> +            * Transmit from the traffic generator's ports 0 and 1 at
> above the expect.
> +            * Forward on TestPMD's interfaces 0 and 1 with 1 core.
> +
> +        Verify:
> +            * The resulting MPPS forwarded is greater than
> expected_mpps*(1-delta_tolerance).
> +        """
> +        self._create_and_transmit(ring_format=3D0, buffers=3D1, in_order=
=3D0,
> vectorized=3D0, extra_args=3D{})
> +
> +    @perf_test
> +    def test_perf_vhost_single_core_virtio11_inorder_mergeable(self):
> +        """Validate expected single core forwarding performance.
> +
> +        Steps:
> +            * Set TestPMD virtio parameters: ring_format=3D1, buffers=3D=
1,
> in_order=3D1.
> +            * Create a packet according to the frame size specified in
> the test config.
> +            * Transmit from the traffic generator's ports 0 and 1 at
> above the expect.
> +            * Forward on TestPMD's interfaces 0 and 1 with 1 core.
> +
> +        Verify:
> +            * The resulting MPPS forwarded is greater than
> expected_mpps*(1-delta_tolerance).
> +        """
> +        extra_args: TestPmdParamsDict =3D {
> +            "tx_offloads": 0,
> +            "enable_hw_vlan_strip": True,
> +            "rss": RSSSetting.SetIPOnly(),
> +        }
> +        self._create_and_transmit(
> +            ring_format=3D1, buffers=3D1, in_order=3D1, vectorized=3D0,
> extra_args=3Dextra_args
> +        )
> +
> +    @perf_test
> +    def test_perf_vhost_single_core_virtio11_inorder_nonmergeable(self):
> +        """Validate expected single core forwarding performance.
> +
> +        Steps:
> +            * Set TestPMD virtio parameters: ring_format=3D1, in_order=
=3D1.
> +            * Create a packet according to the frame size specified in
> the test config.
> +            * Transmit from the traffic generator's ports 0 and 1 at
> above the expect.
> +            * Forward on TestPMD's interfaces 0 and 1 with 1 core.
> +
> +        Verify:
> +            * The resulting MPPS forwarded is greater than
> expected_mpps*(1-delta_tolerance).
> +        """
> +        extra_args: TestPmdParamsDict =3D {"rss": RSSSetting.SetIPOnly()=
}
> +        self._create_and_transmit(
> +            ring_format=3D1, buffers=3D0, in_order=3D1, vectorized=3D0,
> extra_args=3Dextra_args
> +        )
> +
> +    @perf_test
> +    def test_perf_vhost_single_core_virtio11_vectorized(self):
> +        """Validate expected single core forwarding performance.
> +
> +        Steps:
> +            * Set TestPMD virtio parameters: ring_format=3D1, in_order=
=3D1,
> vectorized=3D1.
> +            * Create a packet according to the frame size specified in
> the test config.
> +            * Transmit from the traffic generator's ports 0 and 1 at
> above the expect.
> +            * Forward on TestPMD's interfaces 0 and 1 with 1 core.
> +
> +        Verify:
> +            * The resulting MPPS forwarded is greater than
> expected_mpps*(1-delta_tolerance).
> +        """
> +        extra_args: TestPmdParamsDict =3D {"rss": RSSSetting.SetIPOnly()=
}
> +        self._create_and_transmit(
> +            ring_format=3D1, buffers=3D0, in_order=3D1, vectorized=3D1,
> extra_args=3Dextra_args
> +        )
> --
> 2.55.0
>
>

--0000000000002df279065e49b25f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span>Recheck</span>-<span>request</span>:intel-Testing</d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On =
Tue, Sep 1, 2026 at 2:37=E2=80=AFPM Koushik Bhargav Nimoji &lt;<a href=3D"m=
ailto:knimoji@iol.unh.edu" target=3D"_blank">knimoji@iol.unh.edu</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">This patch =
adds the pvp multi paths virtio single core forward<br>
performance testsuite, which launches testpmd using the vhost<br>
and virtio virtual devices with two and one core respectively,<br>
and tests the virtio single core throughputperformance.<br>
<br>
Signed-off-by: Koushik Bhargav Nimoji &lt;<a href=3D"mailto:knimoji@iol.unh=
.edu" target=3D"_blank">knimoji@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0...ti_paths_virtio_single_core_performance.py | 399 +++++++++++++++++=
+<br>
=C2=A01 file changed, 399 insertions(+)<br>
=C2=A0create mode 100644 dts/tests/TestSuite_pvp_multi_paths_virtio_single_=
core_performance.py<br>
<br>
diff --git a/dts/tests/TestSuite_pvp_multi_paths_virtio_single_core_perform=
ance.py b/dts/tests/TestSuite_pvp_multi_paths_virtio_single_core_performanc=
e.py<br>
new file mode 100644<br>
index 0000000000..aefc29facf<br>
--- /dev/null<br>
+++ b/dts/tests/TestSuite_pvp_multi_paths_virtio_single_core_performance.py=
<br>
@@ -0,0 +1,399 @@<br>
+# SPDX-License-Identifier: BSD-3-Clause<br>
+# Copyright(c) 2025 University of New Hampshire<br>
+<br>
+&quot;&quot;&quot;Virtio-user single-core forwarding performance test suit=
e.<br>
+<br>
+This suite measures the packet forwarding throughput of DPDK&#39;s virtio-=
user PMD running on a<br>
+single CPU core. Performance is evaluated across multiple virtio path impl=
ementations, including<br>
+packed versus split rings, in-order delivery, mergeable buffers, and SIMD =
vectorization.<br>
+Test cases are parameterized using combinations of frame sizes, RX/TX desc=
riptor ring counts,<br>
+and target MPPS baselines specified in the test configuration. High-speed =
traffic is injected<br>
+from an external generator through the physical host ports into the virtio=
-user instance,<br>
+looped back, and returned to the generator. The aggregate MPPS processed b=
y the single virtio<br>
+core is verified against configured expected performance baselines to dete=
rmine the test result.<br>
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
+from api.testpmd.config import PortTopology, RXRingParams, SimpleForwardin=
gModes, TXRingParams<br>
+from framework.params.eal import VirtualDevice<br>
+from framework.params.types import LogicalCoreList, RSSSetting, TestPmdPar=
amsDict<br>
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
+class TestPvpMultiPathsVirtioSingleCorePerformance(TestSuite):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;pvp multi paths virtio single core perform=
ance test suite.&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 config: Config<br>
+<br>
+=C2=A0 =C2=A0 def set_up_suite(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Assign test parameters.&quot=
;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.test_parameters =3D self.config.test_para=
meters<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.delta_tolerance =3D self.config.delta_tol=
erance<br>
+<br>
+=C2=A0 =C2=A0 def set_up_test_case(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Delete stale vhost-user Unix=
 domain socket files.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._ctx.sut_node.main_session.send_command(&=
quot;rm -rf /tmp/vhost-net*&quot;, privileged=3DTrue)<br>
+<br>
+=C2=A0 =C2=A0 def _transmit(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, vhost: TestPmd, virtio: TestPmd, frame_s=
ize: int, repetitions: int =3D 1<br>
+=C2=A0 =C2=A0 ) -&gt; float:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Create a testpmd session wit=
h every rule in the given list, verify jump behavior.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost: the running vhost testpmd=
 shell.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio: the running virtio testp=
md shell.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 frame_size: The size of the fram=
e to transmit.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 repetitions: The number of times=
 to rerun the transmission.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The MPPS (millions of packets pe=
r second) forwarded by the SUT.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert repetitions &gt; 0, &quot;Invalid numbe=
r of repetitions given.&quot;<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost.start()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio.start()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_avg =3D 0.0<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for _ in range(repetitions):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Transmit for 5 seconds.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stats =3D assess_performance_by_=
packet(packet=3Dpacket, duration=3D5)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_avg +=3D stats.rx_pps<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return rx_avg / (repetitions * 1_000_000)<br>
+<br>
+=C2=A0 =C2=A0 def _create_and_transmit(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ring_format: int,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 in_order: int,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 buffers: int,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vectorized: int,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 extra_args: TestPmdParamsDict,<br>
+=C2=A0 =C2=A0 ):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Create testpmd instance with=
 specified params and send traffic.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sut_dpdk_driver =3D self._ctx.sut_node.config.=
ports[0].os_driver_for_dpdk<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost_user_vdev =3D VirtualDevice(&quot;net_vh=
ost0,iface=3D/tmp/vhost-net,queues=3D1&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_user_vdev =3D VirtualDevice(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;net_virtio_user0,&quot;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;mac=3D00:11:22:33:44:10,&q=
uot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;path=3D/tmp/vhost-net,&quo=
t;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;queues=3D1,&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;packed_vq=3D{ring_format}=
,&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;mrg_rxbuf=3D{buffers},&qu=
ot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;in_order=3D{in_order},&qu=
ot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;vectorized=3D{vectorized}=
&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for params in self.test_parameters:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 frame_size =3D params[&quot;fram=
e_size&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 num_descriptors =3D params[&quot=
;num_descriptors&quot;]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default_args =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;tx_ring&quot=
;: TXRingParams(descriptors=3Dnum_descriptors),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;rx_ring&quot=
;: RXRingParams(descriptors=3Dnum_descriptors),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if sut_dpdk_driver =3D=3D &quot;=
mlx5_core&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default_args[&quot=
;burst&quot;] =3D 64<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default_args[&quot=
;mbcache&quot;] =3D 512<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif sut_dpdk_driver =3D=3D &quo=
t;i40e&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default_args[&quot=
;rx_queues&quot;] =3D 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default_args[&quot=
;tx_queues&quot;] =3D 1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmd(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pref=
ix=3D&quot;vhost&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 allo=
wed_ports=3D[],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memo=
ry_channels=3D4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port=
_topology=3DPortTopology.chained,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdev=
s=3D[vhost_user_vdev],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lcor=
e_list=3DLogicalCoreList([1, 2, 3]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nb_c=
ores=3D2,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 **de=
fault_args,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ) as vhost,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmd(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pref=
ix=3D&quot;virtio&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 no_p=
ci=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memo=
ry_channels=3D4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 allo=
wed_ports=3D[],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdev=
s=3D[virtio_user_vdev],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lcor=
e_list=3DLogicalCoreList([4, 5]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nb_c=
ores=3D1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 **ex=
tra_args,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 **de=
fault_args,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ) as virtio,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost.set_forward_=
mode(SimpleForwardingModes.io)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio.set_forward=
_mode(SimpleForwardingModes.mac)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost.set_portlist=
([0, 2, 1])<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 params[&quot;measu=
red_mpps&quot;] =3D round(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
._transmit(vhost, virtio, frame_size, repetitions=3D5), 3<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 params[&quot;perfo=
rmance_delta&quot;] =3D round(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (flo=
at(params[&quot;measured_mpps&quot;]) - float(params[&quot;expected_mpps&qu=
ot;]))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / fl=
oat(params[&quot;expected_mpps&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 params[&quot;pass&=
quot;] =3D float(params[&quot;performance_delta&quot;]) &gt;=3D -self.delta=
_tolerance<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._produce_stats_table(self.test_parameters=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for params in self.test_parameters:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 params[&quot;pass&=
quot;] is True,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;&quot;&quot=
;Packets forwarded is less than {(1 - self.delta_tolerance) * 100}%<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 of the expected ba=
seline.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Measured MPPS =3D =
{params[&quot;measured_mpps&quot;]}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Expected MPPS =3D =
{params[&quot;expected_mpps&quot;]}&quot;&quot;&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
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
ed_mpps&#39;]:&gt;12} | {params[&#39;expected_mpps&#39;]:&gt;14}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;-&quot; * len(header=
))<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 write_performance_json({&quot;results&quot;: t=
est_parameters})<br>
+<br>
+=C2=A0 =C2=A0 @perf_test<br>
+=C2=A0 =C2=A0 def test_perf_vhost_single_core_virtio11_mergeable(self):<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validate expected single cor=
e forwarding performance.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Set TestPMD virtio parameters:=
 ring_format=3D1, buffers=3D1.<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 extra_args: TestPmdParamsDict =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;tx_offloads&quot;: 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;enable_hw_vlan_strip&quot;=
: True,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;rss&quot;: RSSSetting.SetI=
POnly(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._create_and_transmit(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ring_format=3D1, buffers=3D1, in=
_order=3D0, vectorized=3D0, extra_args=3Dextra_args<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @perf_test<br>
+=C2=A0 =C2=A0 def test_perf_vhost_single_core_virtio11_non_mergeable(self)=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validate expected single cor=
e forwarding performance.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Set TestPMD virtio parameters:=
 ring_format=3D1.<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 extra_args: TestPmdParamsDict =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;tx_offloads&quot;: 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;enable_hw_vlan_strip&quot;=
: True,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;rss&quot;: RSSSetting.SetI=
POnly(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._create_and_transmit(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ring_format=3D1, buffers=3D0, in=
_order=3D0, vectorized=3D0, extra_args=3Dextra_args<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @perf_test<br>
+=C2=A0 =C2=A0 def test_perf_vhost_single_core_virtio_inorder_mergeable(sel=
f):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validate expected single cor=
e forwarding performance.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Set TestPMD virtio parameters:=
 buffers=3D1, in_order=3D1.<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 extra_args: TestPmdParamsDict =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;tx_offloads&quot;: 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;enable_hw_vlan_strip&quot;=
: True,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;rss&quot;: RSSSetting.SetI=
POnly(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._create_and_transmit(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ring_format=3D0, buffers=3D1, in=
_order=3D1, vectorized=3D0, extra_args=3Dextra_args<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @perf_test<br>
+=C2=A0 =C2=A0 def test_perf_vhost_single_core_virtio_inorder_nonmergeable(=
self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validate expected single cor=
e forwarding performance.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Set TestPMD virtio parameters:=
 in_order=3D1.<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 extra_args: TestPmdParamsDict =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;tx_offloads&quot;: 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;enable_hw_vlan_strip&quot;=
: True,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;rss&quot;: RSSSetting.SetI=
POnly(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._create_and_transmit(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ring_format=3D0, buffers=3D0, in=
_order=3D1, vectorized=3D0, extra_args=3Dextra_args<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @perf_test<br>
+=C2=A0 =C2=A0 def test_perf_vhost_single_core_virtio_mergeable(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validate expected single cor=
e forwarding performance.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Set TestPMD virtio parameters:=
 buffers=3D1.<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 extra_args: TestPmdParamsDict =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;tx_offloads&quot;: 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;enable_hw_vlan_strip&quot;=
: True,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;rss&quot;: RSSSetting.SetI=
POnly(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._create_and_transmit(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ring_format=3D0, buffers=3D1, in=
_order=3D0, vectorized=3D0, extra_args=3Dextra_args<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @perf_test<br>
+=C2=A0 =C2=A0 def test_perf_vhost_single_core_virtio_nonmergeable(self):<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validate expected single cor=
e forwarding performance.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Set TestPMD virtio parameters:=
 vectorized=3D1.<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 extra_args: TestPmdParamsDict =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;tx_offloads&quot;: 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;enable_hw_vlan_strip&quot;=
: True,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;rss&quot;: RSSSetting.SetI=
POnly(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._create_and_transmit(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ring_format=3D0, buffers=3D0, in=
_order=3D0, vectorized=3D1, extra_args=3Dextra_args<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @perf_test<br>
+=C2=A0 =C2=A0 def test_perf_vhost_single_core_virtio_vectorized(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validate expected single cor=
e forwarding performance.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Set TestPMD virtio parameters:=
 buffers=3D1.<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._create_and_transmit(ring_format=3D0, buf=
fers=3D1, in_order=3D0, vectorized=3D0, extra_args=3D{})<br>
+<br>
+=C2=A0 =C2=A0 @perf_test<br>
+=C2=A0 =C2=A0 def test_perf_vhost_single_core_virtio11_inorder_mergeable(s=
elf):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validate expected single cor=
e forwarding performance.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Set TestPMD virtio parameters:=
 ring_format=3D1, buffers=3D1, in_order=3D1.<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 extra_args: TestPmdParamsDict =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;tx_offloads&quot;: 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;enable_hw_vlan_strip&quot;=
: True,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;rss&quot;: RSSSetting.SetI=
POnly(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._create_and_transmit(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ring_format=3D1, buffers=3D1, in=
_order=3D1, vectorized=3D0, extra_args=3Dextra_args<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @perf_test<br>
+=C2=A0 =C2=A0 def test_perf_vhost_single_core_virtio11_inorder_nonmergeabl=
e(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validate expected single cor=
e forwarding performance.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Set TestPMD virtio parameters:=
 ring_format=3D1, in_order=3D1.<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 extra_args: TestPmdParamsDict =3D {&quot;rss&q=
uot;: RSSSetting.SetIPOnly()}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._create_and_transmit(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ring_format=3D1, buffers=3D0, in=
_order=3D1, vectorized=3D0, extra_args=3Dextra_args<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @perf_test<br>
+=C2=A0 =C2=A0 def test_perf_vhost_single_core_virtio11_vectorized(self):<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validate expected single cor=
e forwarding performance.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Set TestPMD virtio parameters:=
 ring_format=3D1, in_order=3D1, vectorized=3D1.<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 extra_args: TestPmdParamsDict =3D {&quot;rss&q=
uot;: RSSSetting.SetIPOnly()}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._create_and_transmit(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ring_format=3D1, buffers=3D0, in=
_order=3D1, vectorized=3D1, extra_args=3Dextra_args<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-- <br>
2.55.0<br>
<br>
</blockquote></div>

--0000000000002df279065e49b25f--
