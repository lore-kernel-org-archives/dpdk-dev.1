Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6660C7EE31
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 04:34:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA26640283;
	Fri, 27 Jun 2025 06:34:36 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id BABB840277
 for <dev@dpdk.org>; Fri, 27 Jun 2025 06:34:34 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b2c4331c50eso1509867a12.3
 for <dev@dpdk.org>; Thu, 26 Jun 2025 21:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1750998874; x=1751603674; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=szN16z4kF363PBMlszr4gRAao6Yp5LC5pLTXp8E+9/k=;
 b=eCIsMTvhkmgQT/382Fmazb+yXe8Es/44i0WkBjoJi4bL4v/Mw9iRDIeOAHpJ3BVtCY
 Kf2gNlNeCJfucBx1oJ5IBmpUU9ZOsbohP+GJrJPLFSTSYPUbhulipEE6wrokkzikK44z
 NK604gYj/ugv/W9R32/AeElxJ4GjYXxvpGmds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750998874; x=1751603674;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=szN16z4kF363PBMlszr4gRAao6Yp5LC5pLTXp8E+9/k=;
 b=LrGYtHmgp6fNKZ2ZS6DduZ3zWMql3HPk2nK8psEc03TkEG9mBZoWl8FjiCD2zSmf1b
 spo50BCFmn/zIW6g4rG2XH7qzK/O9e4jO099OhHWabC/6M33jzyO0SR2I7SSkHGLPtmq
 XgXkEWnYwzh1EP8p+9s1Pkc2ASaQswfXXrpv+HdCh6ewfusYYX3Hp5O0fj0rui40ZdXc
 tW7TyCrNcLe9Z97y7XRVK+bcqsBusHtTadtLoBiZFR4NN8pXbti5StUUU6Ttu2YL3yD6
 C8OOwAbU4E3SXX8RbqkwEAtx6AlXaupbkjhujQjz/iJv/fzyQHyU5iRfM1tkocNlJ0qS
 9kpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgzXnw23jo1ezO2K2ajQqAP6VrZcKOfyzw7CeXVk5Yt86/H6E3gf+H4UfluHneMbqVml0=@dpdk.org
X-Gm-Message-State: AOJu0YzGcin/U9CC7/YjKTwao8XSwlBby4u4cGex+eYExssNmi+rrNAJ
 nMOPAu5kMPXnSe3/IFzaBQNkTQtqPOxezH+GVvlSGwl5GQS9sK7NTU5XXsOFedOkCz/TsFLkGXx
 Oa6AePVozNZlQE1/Hpr5FZk5njrFJQxWoAeR7WU5FEg==
X-Gm-Gg: ASbGncswLRTCWx3xrRwBzDsCUHhMDIvMbyOr2nP8ZzRw/yYtXtTLNwloZudwmFxuCzv
 ECVwZqJBzTvNFzsZbnlWBjshx1LEjKCkAKXZXd6ej2kPV5ZPPU/unWZnfE8Sv+ubJ5FyBgbbVq2
 ONGfCTTntvF40ZsILNnYq3vfzEVaFeSIqgI8q6633R3pJm55Mm7xX64ToVqMk=
X-Google-Smtp-Source: AGHT+IG0RCWFQ7wonIRjQWISk9lepkbGx/CQSM2LNzL8lIaRhQSVyMZZJiqVMxqQh68Lfonv0GbeyTNewUgLSvdeq5g=
X-Received: by 2002:a17:90b:528a:b0:311:d3a5:572a with SMTP id
 98e67ed59e1d1-318c9225e52mr2663221a91.8.1750998873447; Thu, 26 Jun 2025
 21:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250521192629.294265-3-dmarx@iol.unh.edu>
 <20250626195617.219395-1-dmarx@iol.unh.edu>
In-Reply-To: <20250626195617.219395-1-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 27 Jun 2025 00:29:05 -0400
X-Gm-Features: Ac12FXzgmBArj5OJpr5P-RWxHSdjVLDW77Q0IOU_2NYVr2ffU3IxOVPUvHOLKA4
Message-ID: <CAJvnSUBxc1jwZkkPYz+s2HJv8dxmCp3zCkCbu6u3KQqBfYcDmg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dts: add rte flow test suite
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000daba1b0638863165"
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

--000000000000daba1b0638863165
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied to next-dts, thanks.

On Thu, Jun 26, 2025 at 3:56=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote=
:

> Add an RTE Flow API testing suite, which covers some basic
> synchronous Flow API rules that should be supported across PMDs.
> This suite will be added to over time, as the Flow API is too large
> to cover all in one suite, and sending one monolithic series
> would be impossible.
>
> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> Reviewed-by: Patrick Robb <probb@iol.unh.edu>
> ---
>  doc/api/dts/tests.TestSuite_rte_flow.rst |   8 +
>  dts/tests/TestSuite_rte_flow.py          | 790 +++++++++++++++++++++++
>  2 files changed, 798 insertions(+)
>  create mode 100644 doc/api/dts/tests.TestSuite_rte_flow.rst
>  create mode 100644 dts/tests/TestSuite_rte_flow.py
>
> diff --git a/doc/api/dts/tests.TestSuite_rte_flow.rst
> b/doc/api/dts/tests.TestSuite_rte_flow.rst
> new file mode 100644
> index 0000000000..cad96b2530
> --- /dev/null
> +++ b/doc/api/dts/tests.TestSuite_rte_flow.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: BSD-3-Clause
> +
> +checksum_offload Test Suite
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +.. automodule:: tests.TestSuite_rte_flow
> +   :members:
> +   :show-inheritance:
> \ No newline at end of file
> diff --git a/dts/tests/TestSuite_rte_flow.py
> b/dts/tests/TestSuite_rte_flow.py
> new file mode 100644
> index 0000000000..e70f7ea8d1
> --- /dev/null
> +++ b/dts/tests/TestSuite_rte_flow.py
> @@ -0,0 +1,790 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 University of New Hampshire
> +
> +"""RTE Flow testing suite.
> +
> +This suite verifies a range of flow rules built using patterns
> +and actions from the RTE Flow API. It would be impossible to cover
> +every valid flow rule, but this suite aims to test the most
> +important and common functionalities across PMDs.
> +
> +"""
> +
> +from collections.abc import Callable
> +from itertools import zip_longest
> +from typing import Any, Iterator, cast
> +
> +from scapy.layers.inet import IP, TCP, UDP
> +from scapy.layers.inet6 import IPv6
> +from scapy.layers.l2 import Dot1Q, Ether
> +from scapy.packet import Packet, Raw
> +
> +from framework.exception import InteractiveCommandExecutionError
> +from framework.remote_session.testpmd_shell import FlowRule, TestPmdShel=
l
> +from framework.test_suite import TestSuite, func_test
> +from framework.testbed_model.capability import NicCapability, requires
> +
> +
> +@requires(NicCapability.FLOW_CTRL)
> +class TestRteFlow(TestSuite):
> +    """RTE Flow test suite.
> +
> +    This suite consists of 12 test cases:
> +    1. Queue Action Ethernet: Verifies queue actions with ethernet
> patterns
> +    2. Queue Action IP: Verifies queue actions with IPv4 and IPv6 patter=
ns
> +    3. Queue Action L4: Verifies queue actions with TCP and UDP patterns
> +    4. Queue Action VLAN: Verifies queue actions with VLAN patterns
> +    5. Drop Action Eth: Verifies drop action with ethernet patterns
> +    6. Drop Action IP: Verifies drop actions with IPV4 and IPv6 patterns
> +    7. Drop Action L4: Verifies drop actions with TCP and UDP patterns
> +    8. Drop Action VLAN: Verifies drop actions with VLAN patterns
> +    9. Modify Field Action: Verifies packet modification patterns
> +    10. Egress Rules: Verifies previously covered rules are still valid
> as egress
> +    11. Jump Action: Verifies packet behavior given grouped flows
> +    12. Priority Attribute: Verifies packet behavior given flows with
> different priorities
> +
> +    """
> +
> +    def runner(
> +        self,
> +        verification_method: Callable[..., Any],
> +        flows: list[FlowRule],
> +        packets: list[Packet],
> +        port_id: int,
> +        expected_packets: list[Packet] | None =3D None,
> +        *args: Any,
> +        **kwargs: Any,
> +    ) -> None:
> +        """Runner method that validates each flow using the correspondin=
g
> verification method.
> +
> +        Args:
> +            verification_method: Callable that performs verification
> logic.
> +            flows: List of flow rules to create and test.
> +            packets: List of packets corresponding to each flow.
> +            port_id: Number representing the port to create flows on.
> +            expected_packets: List of packets to check sent packets
> against in modification cases.
> +            *args: Additional positional arguments to pass to the
> verification method.
> +            **kwargs: Additional keyword arguments to pass to the
> verification method.
> +        """
> +
> +        def zip_lists(
> +            rules: list[FlowRule],
> +            packets1: list[Packet],
> +            packets2: list[Packet] | None,
> +        ) -> Iterator[tuple[FlowRule, Packet, Packet | None]]:
> +            """Method that creates an iterable zip containing lists used
> in runner.
> +
> +            Args:
> +                rules: List of flow rules.
> +                packets1: List of packets.
> +                packets2: Optional list of packets, excluded from zip if
> not passed to runner.
> +            """
> +            return cast(
> +                Iterator[tuple[FlowRule, Packet, Packet | None]],
> +                zip_longest(rules, packets1, packets2 or [],
> fillvalue=3DNone),
> +            )
> +
> +        with TestPmdShell(rx_queues=3D4, tx_queues=3D4) as testpmd:
> +            for flow, packet, expected_packet in zip_lists(flows,
> packets, expected_packets):
> +                is_valid =3D testpmd.flow_validate(flow_rule=3Dflow,
> port_id=3Dport_id)
> +                self.verify_else_skip(is_valid, "flow rule failed
> validation.")
> +
> +                try:
> +                    flow_id =3D testpmd.flow_create(flow_rule=3Dflow,
> port_id=3Dport_id)
> +                except InteractiveCommandExecutionError:
> +                    self.log("Flow rule validation passed, but flow
> creation failed.")
> +                    self.verify(False, "Failed flow creation")
> +
> +                if verification_method =3D=3D self.send_packet_and_verif=
y:
> +                    verification_method(packet=3Dpacket, *args, **kwargs=
)
> +
> +                elif verification_method =3D=3D
> self.send_packet_and_verify_queue:
> +                    verification_method(
> +                        packet=3Dpacket, test_queue=3Dkwargs["test_queue=
"],
> testpmd=3Dtestpmd
> +                    )
> +
> +                elif verification_method =3D=3D
> self.send_packet_and_verify_modification:
> +                    verification_method(packet=3Dpacket,
> expected_packet=3Dexpected_packet)
> +
> +                testpmd.flow_delete(flow_id, port_id=3Dport_id)
> +
> +    def send_packet_and_verify(self, packet: Packet, should_receive: boo=
l
> =3D True) -> None:
> +        """Generate a packet, send to the DUT, and verify it is forwarde=
d
> back.
> +
> +        Args:
> +            packet: Scapy packet to send and verify.
> +            should_receive: Indicate whether the packet should be
> received.
> +        """
> +        received =3D self.send_packet_and_capture(packet)
> +        contains_packet =3D any(
> +            packet.haslayer(Raw) and b"xxxxx" in packet.load for packet
> in received
> +        )
> +        self.verify(
> +            should_receive =3D=3D contains_packet,
> +            f"Packet was {'dropped' if should_receive else 'received'}",
> +        )
> +
> +    def send_packet_and_verify_queue(
> +        self, packet: Packet, test_queue: int, testpmd: TestPmdShell
> +    ) -> None:
> +        """Send packet and verify queue stats show packet was received.
> +
> +        Args:
> +            packet: Scapy packet to send to the SUT.
> +            test_queue: Represents the queue the test packet is being
> sent to.
> +            testpmd: TestPmdShell instance being used to send test packe=
t.
> +        """
> +        testpmd.set_verbose(level=3D8)
> +        testpmd.start()
> +        self.send_packet_and_capture(packet=3Dpacket)
> +        verbose_output =3D testpmd.extract_verbose_output(testpmd.stop()=
)
> +        received =3D False
> +        for testpmd_packet in verbose_output:
> +            if testpmd_packet.queue_id =3D=3D test_queue:
> +                received =3D True
> +        self.verify(received, f"Expected packet was not received on queu=
e
> {test_queue}")
> +
> +    def send_packet_and_verify_modification(self, packet: Packet,
> expected_packet: Packet) -> None:
> +        """Send packet and verify the expected modifications are present
> upon reception.
> +
> +        Args:
> +            packet: Scapy packet to send to the SUT.
> +            expected_packet: Scapy packet that should match the received
> packet.
> +        """
> +        received =3D self.send_packet_and_capture(packet)
> +
> +        # verify reception
> +        self.verify(received !=3D [], "Packet was never received.")
> +
> +        self.log(f"SENT PACKET:     {packet.summary()}")
> +        self.log(f"EXPECTED PACKET: {expected_packet.summary()}")
> +        for packet in received:
> +            self.log(f"RECEIVED PACKET: {packet.summary()}")
> +
> +        expected_ip_dst =3D expected_packet[IP].dst if IP in
> expected_packet else None
> +        received_ip_dst =3D received[IP].dst if IP in received else None
> +
> +        expected_mac_dst =3D expected_packet[Ether].dst if Ether in
> expected_packet else None
> +        received_mac_dst =3D received[Ether].dst if Ether in received el=
se
> None
> +
> +        # verify modification
> +        if expected_ip_dst is not None:
> +            self.verify(
> +                received_ip_dst =3D=3D expected_ip_dst,
> +                f"IPv4 dst mismatch: expected {expected_ip_dst}, got
> {received_ip_dst}",
> +            )
> +
> +        if expected_mac_dst is not None:
> +            self.verify(
> +                received_mac_dst =3D=3D expected_mac_dst,
> +                f"MAC dst mismatch: expected {expected_mac_dst}, got
> {received_mac_dst}",
> +            )
> +
> +    def send_packet_and_verify_jump(
> +        self,
> +        packets: list[Packet],
> +        flow_rules: list[FlowRule],
> +        test_queues: list[int],
> +        testpmd: TestPmdShell,
> +    ) -> None:
> +        """Create a testpmd session with every rule in the given list,
> verify jump behavior.
> +
> +        Args:
> +            packets: List of packets to send.
> +            flow_rules: List of flow rules to create in the same session=
.
> +            test_queues: List of Rx queue IDs each packet should be
> received on.
> +            testpmd: TestPmdShell instance to create flows on.
> +        """
> +        testpmd.set_verbose(level=3D8)
> +        for flow in flow_rules:
> +            is_valid =3D testpmd.flow_validate(flow_rule=3Dflow, port_id=
=3D0)
> +            self.verify_else_skip(is_valid, "flow rule failed
> validation.")
> +
> +            try:
> +                testpmd.flow_create(flow_rule=3Dflow, port_id=3D0)
> +            except InteractiveCommandExecutionError:
> +                self.log("Flow validation passed, but flow creation
> failed.")
> +                self.verify(False, "Failed flow creation")
> +
> +        for packet, test_queue in zip(packets, test_queues):
> +            testpmd.start()
> +            self.send_packet_and_capture(packet=3Dpacket)
> +            verbose_output =3D
> testpmd.extract_verbose_output(testpmd.stop())
> +            received =3D False
> +            for testpmd_packet in verbose_output:
> +                if testpmd_packet.queue_id =3D=3D test_queue:
> +                    received =3D True
> +            self.verify(received, f"Expected packet was not received on
> queue {test_queue}")
> +
> +    @func_test
> +    def test_queue_action_ETH(self) -> None:
> +        """Validate flow rules with queue actions and ethernet patterns.
> +
> +        Steps:
> +            Create a list of packets to test, with a corresponding flow
> list.
> +            Launch testpmd.
> +            Create first flow rule in flow list.
> +            Send first packet in packet list, capture verbose output.
> +            Delete flow rule, repeat for all flows/packets.
> +
> +        Verify:
> +            Check that each packet is received on the appropriate queue.
> +        """
> +        packet_list =3D [
> +            Ether(src=3D"02:00:00:00:00:00"),
> +            Ether(dst=3D"02:00:00:00:00:00"),
> +            Ether(type=3D0x0800) / IP(),
> +        ]
> +        flow_list =3D [
> +            FlowRule(
> +                direction=3D"ingress",
> +                pattern=3D["eth src is 02:00:00:00:00:00"],
> +                actions=3D["queue index 2"],
> +            ),
> +            FlowRule(
> +                direction=3D"ingress",
> +                pattern=3D["eth dst is 02:00:00:00:00:00"],
> +                actions=3D["queue index 2"],
> +            ),
> +            FlowRule(
> +                direction=3D"ingress", pattern=3D["eth type is 0x0800"],
> actions=3D["queue index 2"]
> +            ),
> +        ]
> +        self.runner(
> +            verification_method=3Dself.send_packet_and_verify_queue,
> +            flows=3Dflow_list,
> +            packets=3Dpacket_list,
> +            port_id=3D0,
> +            test_queue=3D2,
> +        )
> +
> +    @func_test
> +    def test_queue_action_IP(self) -> None:
> +        """Validate flow rules with queue actions and IPv4/IPv6 patterns=
.
> +
> +        Steps:
> +            Create a list of packets to test, with a corresponding flow
> list.
> +            Launch testpmd.
> +            Create first flow rule in flow list.
> +            Send first packet in packet list, capture verbose output.
> +            Delete flow rule, repeat for all flows/packets.
> +
> +        Verify:
> +            Check that each packet is received on the appropriate queue.
> +        """
> +        packet_list =3D [
> +            Ether() / IP(src=3D"192.168.1.1"),
> +            Ether() / IP(dst=3D"192.168.1.1"),
> +            Ether() / IP(ttl=3D64),
> +            Ether() / IPv6(src=3D"2001:db8::1"),
> +            Ether() / IPv6(dst=3D"2001:db8::2"),
> +            Ether() / IPv6() / UDP(),
> +        ]
> +        flow_list =3D [
> +            FlowRule(
> +                direction=3D"ingress",
> +                pattern=3D["eth / ipv4 src is 192.168.1.1"],
> +                actions=3D["queue index 2"],
> +            ),
> +            FlowRule(
> +                direction=3D"ingress",
> +                pattern=3D["eth / ipv4 dst is 192.168.1.1"],
> +                actions=3D["queue index 2"],
> +            ),
> +            FlowRule(
> +                direction=3D"ingress", pattern=3D["eth / ipv4 ttl is 64"=
],
> actions=3D["queue index 2"]
> +            ),
> +            FlowRule(
> +                direction=3D"ingress",
> +                pattern=3D["eth / ipv6 src is 2001:db8::1"],
> +                actions=3D["queue index 2"],
> +            ),
> +            FlowRule(
> +                direction=3D"ingress",
> +                pattern=3D["eth / ipv6 dst is 2001:db8::2"],
> +                actions=3D["queue index 2"],
> +            ),
> +            FlowRule(
> +                direction=3D"ingress", pattern=3D["eth / ipv6 proto is 1=
7"],
> actions=3D["queue index 2"]
> +            ),
> +        ]
> +        self.runner(
> +            verification_method=3Dself.send_packet_and_verify_queue,
> +            flows=3Dflow_list,
> +            packets=3Dpacket_list,
> +            port_id=3D0,
> +            test_queue=3D2,
> +        )
> +
> +    @func_test
> +    def test_queue_action_L4(self) -> None:
> +        """Validate flow rules with queue actions and TCP/UDP patterns.
> +
> +        Steps:
> +            Create a list of packets to test, with a corresponding flow
> list.
> +            Launch testpmd.
> +            Create first flow rule in flow list.
> +            Send first packet in packet list, capture verbose output.
> +            Delete flow rule, repeat for all flows/packets.
> +
> +        Verify:
> +            Check that each packet is received on the appropriate queue.
> +        """
> +        packet_list =3D [
> +            Ether() / IP() / TCP(sport=3D1234),
> +            Ether() / IP() / TCP(dport=3D80),
> +            Ether() / IP() / TCP(flags=3D0x02),
> +            Ether() / IP() / UDP(sport=3D5000),
> +            Ether() / IP() / UDP(dport=3D53),
> +        ]
> +        flow_list =3D [
> +            FlowRule(
> +                direction=3D"ingress",
> +                pattern=3D["eth / ipv4 / tcp src is 1234"],
> +                actions=3D["queue index 2"],
> +            ),
> +            FlowRule(
> +                direction=3D"ingress",
> +                pattern=3D["eth / ipv4 / tcp dst is 80"],
> +                actions=3D["queue index 2"],
> +            ),
> +            FlowRule(
> +                direction=3D"ingress",
> +                pattern=3D["eth / ipv4 / tcp flags is 0x02"],
> +                actions=3D["queue index 2"],
> +            ),
> +            FlowRule(
> +                direction=3D"ingress",
> +                pattern=3D["eth / ipv4 / udp src is 5000"],
> +                actions=3D["queue index 2"],
> +            ),
> +            FlowRule(
> +                direction=3D"ingress",
> +                pattern=3D["eth / ipv4 / udp dst is 53"],
> +                actions=3D["queue index 2"],
> +            ),
> +        ]
> +        self.runner(
> +            verification_method=3Dself.send_packet_and_verify_queue,
> +            flows=3Dflow_list,
> +            packets=3Dpacket_list,
> +            port_id=3D0,
> +            test_queue=3D2,
> +        )
> +
> +    @func_test
> +    def test_queue_action_VLAN(self) -> None:
> +        """Validate flow rules with queue actions and VLAN patterns.
> +
> +        Steps:
> +            Create a list of packets to test, with a corresponding flow
> list.
> +            Launch testpmd.
> +            Create first flow rule in flow list.
> +            Send first packet in packet list, capture verbose output.
> +            Delete flow rule, repeat for all flows/packets.
> +
> +        Verify:
> +            Check that each packet is received on the appropriate queue.
> +        """
> +        packet_list =3D [Ether() / Dot1Q(vlan=3D100), Ether() /
> Dot1Q(type=3D0x0800)]
> +        flow_list =3D [
> +            FlowRule(direction=3D"ingress", pattern=3D["eth / vlan"],
> actions=3D["queue index 2"]),
> +            FlowRule(direction=3D"ingress", pattern=3D["eth / vlan"],
> actions=3D["queue index 2"]),
> +        ]
> +        self.runner(
> +            verification_method=3Dself.send_packet_and_verify_queue,
> +            flows=3Dflow_list,
> +            packets=3Dpacket_list,
> +            port_id=3D0,
> +            test_queue=3D2,
> +        )
> +
> +    @func_test
> +    def test_drop_action_ETH(self) -> None:
> +        """Validate flow rules with drop actions and ethernet patterns.
> +
> +        Steps:
> +            Create a list of packets to test, with a corresponding flow
> list.
> +            Launch testpmd.
> +            Create first flow rule in flow list.
> +            Send first packet in packet list, capture verbose output.
> +            Delete flow rule, repeat for all flows/packets.
> +
> +        Verify:
> +            Check that each packet is dropped.
> +
> +        One packet will be sent as a confidence check, to ensure packets
> are being
> +        received under normal circumstances.
> +        """
> +        packet_list =3D [
> +            Ether(src=3D"02:00:00:00:00:00") / Raw(load=3D"xxxxx"),
> +            Ether(dst=3D"02:00:00:00:00:00") / Raw(load=3D"xxxxx"),
> +            Ether(type=3D0x0800) / Raw(load=3D"xxxxx"),
> +        ]
> +        flow_list =3D [
> +            FlowRule(
> +                direction=3D"ingress", pattern=3D["eth src is
> 02:00:00:00:00:00"], actions=3D["drop"]
> +            ),
> +            FlowRule(
> +                direction=3D"ingress", pattern=3D["eth dst is
> 02:00:00:00:00:00"], actions=3D["drop"]
> +            ),
> +            FlowRule(direction=3D"ingress", pattern=3D["eth type is 0x08=
00"],
> actions=3D["drop"]),
> +        ]
> +        # verify reception with test packet
> +        packet =3D Ether() / IP() / Raw(load=3D"xxxxx")
> +        with TestPmdShell() as testpmd:
> +            testpmd.start()
> +            received =3D self.send_packet_and_capture(packet)
> +            self.verify(received !=3D [], "Test packet was never receive=
d.")
> +        self.runner(
> +            verification_method=3Dself.send_packet_and_verify,
> +            flows=3Dflow_list,
> +            packets=3Dpacket_list,
> +            port_id=3D0,
> +            should_receive=3DFalse,
> +        )
> +
> +    @func_test
> +    def test_drop_action_IP(self) -> None:
> +        """Validate flow rules with drop actions and ethernet patterns.
> +
> +        Steps:
> +            Create a list of packets to test, with a corresponding flow
> list.
> +            Launch testpmd.
> +            Create first flow rule in flow list.
> +            Send first packet in packet list, capture verbose output.
> +            Delete flow rule, repeat for all flows/packets.
> +
> +        Verify:
> +            Check that each packet is dropped.
> +
> +        One packet will be sent as a confidence check, to ensure packets
> are being
> +        received under normal circumstances.
> +        """
> +        packet_list =3D [
> +            Ether() / IP(src=3D"192.168.1.1") / Raw(load=3D"xxxxx"),
> +            Ether() / IP(dst=3D"192.168.1.1") / Raw(load=3D"xxxxx"),
> +            Ether() / IP(ttl=3D64) / Raw(load=3D"xxxxx"),
> +            Ether() / IPv6(src=3D"2001:db8::1") / Raw(load=3D"xxxxx"),
> +            Ether() / IPv6(dst=3D"2001:db8::1") / Raw(load=3D"xxxxx"),
> +            Ether() / IPv6() / UDP() / Raw(load=3D"xxxxx"),
> +        ]
> +        flow_list =3D [
> +            FlowRule(
> +                direction=3D"ingress", pattern=3D["eth / ipv4 src is
> 192.168.1.1"], actions=3D["drop"]
> +            ),
> +            FlowRule(
> +                direction=3D"ingress", pattern=3D["eth / ipv4 dst is
> 192.168.1.1"], actions=3D["drop"]
> +            ),
> +            FlowRule(direction=3D"ingress", pattern=3D["eth / ipv4 ttl i=
s
> 64"], actions=3D["drop"]),
> +            FlowRule(
> +                direction=3D"ingress", pattern=3D["eth / ipv6 src is
> 2001:db8::1"], actions=3D["drop"]
> +            ),
> +            FlowRule(
> +                direction=3D"ingress", pattern=3D["eth / ipv6 dst is
> 2001:db8::2"], actions=3D["drop"]
> +            ),
> +            FlowRule(direction=3D"ingress", pattern=3D["eth / ipv6 proto=
 is
> 17"], actions=3D["drop"]),
> +        ]
> +        # verify reception with test packet
> +        packet =3D Ether() / IP() / Raw(load=3D"xxxxx")
> +        with TestPmdShell() as testpmd:
> +            testpmd.start()
> +            received =3D self.send_packet_and_capture(packet)
> +            self.verify(received !=3D [], "Test packet was never receive=
d.")
> +        self.runner(
> +            verification_method=3Dself.send_packet_and_verify,
> +            flows=3Dflow_list,
> +            packets=3Dpacket_list,
> +            port_id=3D0,
> +            should_receive=3DFalse,
> +        )
> +
> +    @func_test
> +    def test_drop_action_L4(self) -> None:
> +        """Validate flow rules with drop actions and ethernet patterns.
> +
> +        Steps:
> +            Create a list of packets to test, with a corresponding flow
> list.
> +            Launch testpmd.
> +            Create first flow rule in flow list.
> +            Send first packet in packet list, capture verbose output.
> +            Delete flow rule, repeat for all flows/packets.
> +
> +        Verify:
> +            Check that each packet is dropped.
> +
> +        One packet will be sent as a confidence check, to ensure packets
> are being
> +        received under normal circumstances.
> +        """
> +        packet_list =3D [
> +            Ether() / IP() / TCP(sport=3D1234) / Raw(load=3D"xxxxx"),
> +            Ether() / IP() / TCP(dport=3D80) / Raw(load=3D"xxxxx"),
> +            Ether() / IP() / TCP(flags=3D0x02) / Raw(load=3D"xxxxx"),
> +            Ether() / IP() / UDP(sport=3D5000) / Raw(load=3D"xxxxx"),
> +            Ether() / IP() / UDP(dport=3D53) / Raw(load=3D"xxxxx"),
> +        ]
> +        flow_list =3D [
> +            FlowRule(
> +                direction=3D"ingress", pattern=3D["eth / ipv4 / tcp src =
is
> 1234"], actions=3D["drop"]
> +            ),
> +            FlowRule(direction=3D"ingress", pattern=3D["eth / ipv4 / tcp=
 dst
> is 80"], actions=3D["drop"]),
> +            FlowRule(
> +                direction=3D"ingress", pattern=3D["eth / ipv4 / tcp flag=
s is
> 0x02"], actions=3D["drop"]
> +            ),
> +            FlowRule(
> +                direction=3D"ingress", pattern=3D["eth / ipv4 / udp src =
is
> 5000"], actions=3D["drop"]
> +            ),
> +            FlowRule(direction=3D"ingress", pattern=3D["eth / ipv4 / udp=
 dst
> is 53"], actions=3D["drop"]),
> +        ]
> +        # verify reception with test packet
> +        packet =3D Ether() / IP() / Raw(load=3D"xxxxx")
> +        with TestPmdShell() as testpmd:
> +            testpmd.start()
> +            received =3D self.send_packet_and_capture(packet)
> +            self.verify(received !=3D [], "Test packet was never receive=
d.")
> +        self.runner(
> +            verification_method=3Dself.send_packet_and_verify,
> +            flows=3Dflow_list,
> +            packets=3Dpacket_list,
> +            port_id=3D0,
> +            should_receive=3DFalse,
> +        )
> +
> +    @func_test
> +    def test_drop_action_VLAN(self) -> None:
> +        """Validate flow rules with drop actions and ethernet patterns.
> +
> +        Steps:
> +            Create a list of packets to test, with a corresponding flow
> list.
> +            Launch testpmd.
> +            Create first flow rule in flow list.
> +            Send first packet in packet list, capture verbose output.
> +            Delete flow rule, repeat for all flows/packets.
> +
> +        Verify:
> +            Check that each packet is dropped.
> +
> +        One packet will be sent as a confidence check, to ensure packets
> are being
> +        received under normal circumstances.
> +        """
> +        packet_list =3D [
> +            Ether() / Dot1Q(vlan=3D100) / Raw(load=3D"xxxxx"),
> +            Ether() / Dot1Q(type=3D0x0800) / Raw(load=3D"xxxxx"),
> +        ]
> +        flow_list =3D [
> +            FlowRule(direction=3D"ingress", pattern=3D["eth / vlan"],
> actions=3D["drop"]),
> +            FlowRule(direction=3D"ingress", pattern=3D["eth / vlan"],
> actions=3D["drop"]),
> +        ]
> +        # verify reception with test packet
> +        packet =3D Ether() / IP() / Raw(load=3D"xxxxx")
> +        with TestPmdShell() as testpmd:
> +            testpmd.start()
> +            received =3D self.send_packet_and_capture(packet)
> +            self.verify(received !=3D [], "Test packet was never receive=
d.")
> +        self.runner(
> +            verification_method=3Dself.send_packet_and_verify,
> +            flows=3Dflow_list,
> +            packets=3Dpacket_list,
> +            port_id=3D0,
> +            should_receive=3DFalse,
> +        )
> +
> +    @func_test
> +    def test_modify_actions(self) -> None:
> +        """Validate flow rules with actions that modify that packet
> during transmission.
> +
> +        Steps:
> +            Create a list of packets to test, with a corresponding flow
> list.
> +            Launch testpmd.
> +            Create first flow rule in flow list.
> +            Send first packet in packet list, capture verbose output.
> +            Delete flow rule, repeat for all flows/packets.
> +
> +        Verify:
> +            Verify packet is received with the new attributes.
> +        """
> +        packet_list =3D [Ether() / IP(src=3D"192.68.1.1"),
> Ether(src=3D"02:00:00:00:00:00")]
> +        flow_list =3D [
> +            # rule to copy IPv4 src to IPv4 dst
> +            FlowRule(
> +                direction=3D"ingress",
> +                group_id=3D1,
> +                pattern=3D["eth"],
> +                actions=3D[
> +                    "modify_field op set dst_type ipv4_dst src_type
> ipv4_src width 32"
> +                    " / queue index 0"
> +                ],
> +            ),
> +            # rule to copy src MAC to dst MAC
> +            FlowRule(
> +                direction=3D"ingress",
> +                group_id=3D1,
> +                pattern=3D["eth"],
> +                actions=3D[
> +                    "modify_field op set dst_type mac_dst src_type
> mac_src width 48 / queue index 0"
> +                ],
> +            ),
> +        ]
> +        expected_packet_list =3D [Ether() / IP(dst=3D"192.68.1.1"),
> Ether(dst=3D"02:00:00:00:00:00")]
> +        self.runner(
> +            verification_method=3Dself.send_packet_and_verify_modificati=
on,
> +            flows=3Dflow_list,
> +            packets=3Dpacket_list,
> +            port_id=3D0,
> +            expected_packets=3Dexpected_packet_list,
> +        )
> +
> +    @func_test
> +    def test_egress_rules(self) -> None:
> +        """Validate flow rules with egress directions.
> +
> +        Steps:
> +            Create a list of packets to test, with a corresponding flow
> list.
> +            Launch testpmd.
> +            Create first flow rule in flow list.
> +            Send first packet in packet list, capture verbose output.
> +            Delete flow rule, repeat for all flows/packets.
> +
> +        Verify:
> +            Check that each packet is dropped.
> +
> +        One packet will be sent as a confidence check, to ensure packets
> are being
> +        received under normal circumstances.
> +        """
> +        packet_list =3D [
> +            Ether(src=3D"02:00:00:00:00:00"),
> +            Ether() / IP(src=3D"192.168.1.1"),
> +            IP() / TCP(sport=3D1234),
> +            IP() / UDP(sport=3D5000),
> +        ]
> +        flow_list =3D [
> +            FlowRule(
> +                direction=3D"egress", pattern=3D["eth src is
> 02:00:00:00:00:00"], actions=3D["drop"]
> +            ),
> +            FlowRule(direction=3D"egress", pattern=3D["ipv4 src is
> 192.168.1.1"], actions=3D["drop"]),
> +            FlowRule(direction=3D"egress", pattern=3D["tcp src is 1234"]=
,
> actions=3D["drop"]),
> +            FlowRule(direction=3D"egress", pattern=3D["udp src is 5000"]=
,
> actions=3D["drop"]),
> +        ]
> +        # verify reception with test packet
> +        packet =3D Ether() / IP() / Raw(load=3D"xxxxx")
> +        with TestPmdShell() as testpmd:
> +            testpmd.start()
> +            received =3D self.send_packet_and_capture(packet)
> +            self.verify(received !=3D [], "Test packet was never receive=
d.")
> +        self.runner(
> +            verification_method=3Dself.send_packet_and_verify,
> +            flows=3Dflow_list,
> +            packets=3Dpacket_list,
> +            port_id=3D1,
> +            should_receive=3DFalse,
> +        )
> +
> +    @func_test
> +    def test_jump_action(self) -> None:
> +        """Validate flow rules with different group levels and jump
> actions.
> +
> +        Steps:
> +            Create a list of packets to test, with a corresponding flow
> list.
> +            Launch testpmd with the necessary configuration.
> +            Create each flow rule in testpmd.
> +            Send each packet in the list, check Rx queue ID.
> +
> +        Verify:
> +            Check that each packet is received on the appropriate Rx
> queue.
> +        """
> +        packet_list =3D [Ether() / IP(), Ether() / IP() / TCP(), Ether()=
 /
> IP() / UDP()]
> +        flow_list =3D [
> +            FlowRule(
> +                direction=3D"ingress",
> +                group_id=3D0,
> +                pattern=3D["eth / ipv4 / tcp"],
> +                actions=3D["jump group 1"],
> +            ),
> +            FlowRule(
> +                direction=3D"ingress",
> +                group_id=3D0,
> +                pattern=3D["eth / ipv4 / udp"],
> +                actions=3D["jump group 2"],
> +            ),
> +            FlowRule(
> +                direction=3D"ingress",
> +                group_id=3D1,
> +                pattern=3D["eth / ipv4 / tcp"],
> +                actions=3D["queue index 2"],
> +            ),
> +            FlowRule(
> +                direction=3D"ingress",
> +                group_id=3D2,
> +                pattern=3D["eth / ipv4 / udp"],
> +                actions=3D["queue index 3"],
> +            ),
> +            FlowRule(
> +                direction=3D"ingress",
> +                group_id=3D0,
> +                pattern=3D["eth / ipv4"],
> +                actions=3D["queue index 1"],
> +            ),
> +        ]
> +        expected_queue_list =3D [1, 2, 3]
> +        with TestPmdShell(rx_queues=3D4, tx_queues=3D4) as testpmd:
> +            self.send_packet_and_verify_jump(
> +                packets=3Dpacket_list,
> +                flow_rules=3Dflow_list,
> +                test_queues=3Dexpected_queue_list,
> +                testpmd=3Dtestpmd,
> +            )
> +
> +    @func_test
> +    def test_priority_attribute(self) -> None:
> +        """Validate flow rules with queue actions and ethernet patterns.
> +
> +        Steps:
> +            Create a list of packets to test, with a corresponding flow
> list.
> +            Launch testpmd.
> +            Create first flow rule in flow list.
> +            Send first packet in packet list, capture verbose output.
> +            Delete flow rule, repeat for all flows/packets.
> +
> +        Verify:
> +            Check that each packet is received on the appropriate queue.
> +        """
> +        test_packet =3D Ether() / IP() / Raw()
> +        flow_list =3D [
> +            FlowRule(
> +                direction=3D"ingress",
> +                priority_level=3D3,
> +                pattern=3D["eth / ipv4"],
> +                actions=3D["queue index 1"],
> +            ),
> +            FlowRule(
> +                direction=3D"ingress",
> +                priority_level=3D2,
> +                pattern=3D["eth / ipv4"],
> +                actions=3D["queue index 2"],
> +            ),
> +            FlowRule(
> +                direction=3D"ingress",
> +                priority_level=3D1,
> +                pattern=3D["eth / ipv4"],
> +                actions=3D["queue index 3"],
> +            ),
> +        ]
> +        expected_queue_list =3D [1, 2, 3]
> +        with TestPmdShell(rx_queues=3D4, tx_queues=3D4) as testpmd:
> +            testpmd.set_verbose(level=3D8)
> +            for flow, expected_queue in zip(flow_list,
> expected_queue_list):
> +                is_valid =3D testpmd.flow_validate(flow_rule=3Dflow,
> port_id=3D0)
> +                self.verify_else_skip(is_valid, "flow rule failed
> validation.")
> +                try:
> +                    testpmd.flow_create(flow_rule=3Dflow, port_id=3D0)
> +                except InteractiveCommandExecutionError:
> +                    self.log("Flow rule validation passed, but flow
> creation failed.")
> +                    self.verify(False, "Failed flow creation")
> +                testpmd.start()
> +                self.send_packet_and_capture(test_packet)
> +                verbose_output =3D
> testpmd.extract_verbose_output(testpmd.stop())
> +                received =3D False
> +                for testpmd_packet in verbose_output:
> +                    if testpmd_packet.queue_id =3D=3D expected_queue:
> +                        received =3D True
> +                self.verify(received, f"Packet was not received on queue
> {expected_queue}")
> --
> 2.49.0
>
>

--000000000000daba1b0638863165
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+QXBwbGllZCB0byBuZXh0LWR0cywgdGhhbmtzLjwvZGl2Pjxicj48ZGl2
IGNsYXNzPSJnbWFpbF9xdW90ZSBnbWFpbF9xdW90ZV9jb250YWluZXIiPjxkaXYgZGlyPSJsdHIi
IGNsYXNzPSJnbWFpbF9hdHRyIj5PbiBUaHUsIEp1biAyNiwgMjAyNSBhdCAzOjU24oCvUE0gRGVh
biBNYXJ4ICZsdDs8YSBocmVmPSJtYWlsdG86ZG1hcnhAaW9sLnVuaC5lZHUiPmRtYXJ4QGlvbC51
bmguZWR1PC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9x
dW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29s
aWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5BZGQgYW4gUlRFIEZsb3cgQVBJ
IHRlc3Rpbmcgc3VpdGUsIHdoaWNoIGNvdmVycyBzb21lIGJhc2ljPGJyPg0Kc3luY2hyb25vdXMg
RmxvdyBBUEkgcnVsZXMgdGhhdCBzaG91bGQgYmUgc3VwcG9ydGVkIGFjcm9zcyBQTURzLjxicj4N
ClRoaXMgc3VpdGUgd2lsbCBiZSBhZGRlZCB0byBvdmVyIHRpbWUsIGFzIHRoZSBGbG93IEFQSSBp
cyB0b28gbGFyZ2U8YnI+DQp0byBjb3ZlciBhbGwgaW4gb25lIHN1aXRlLCBhbmQgc2VuZGluZyBv
bmUgbW9ub2xpdGhpYyBzZXJpZXM8YnI+DQp3b3VsZCBiZSBpbXBvc3NpYmxlLjxicj4NCjxicj4N
ClNpZ25lZC1vZmYtYnk6IERlYW4gTWFyeCAmbHQ7PGEgaHJlZj0ibWFpbHRvOmRtYXJ4QGlvbC51
bmguZWR1IiB0YXJnZXQ9Il9ibGFuayI+ZG1hcnhAaW9sLnVuaC5lZHU8L2E+Jmd0Ozxicj4NClJl
dmlld2VkLWJ5OiBQYXRyaWNrIFJvYmIgJmx0OzxhIGhyZWY9Im1haWx0bzpwcm9iYkBpb2wudW5o
LmVkdSIgdGFyZ2V0PSJfYmxhbmsiPnByb2JiQGlvbC51bmguZWR1PC9hPiZndDs8YnI+DQotLS08
YnI+DQrCoGRvYy9hcGkvZHRzL3Rlc3RzLlRlc3RTdWl0ZV9ydGVfZmxvdy5yc3QgfMKgIMKgOCAr
PGJyPg0KwqBkdHMvdGVzdHMvVGVzdFN1aXRlX3J0ZV9mbG93LnB5wqAgwqAgwqAgwqAgwqAgfCA3
OTAgKysrKysrKysrKysrKysrKysrKysrKys8YnI+DQrCoDIgZmlsZXMgY2hhbmdlZCwgNzk4IGlu
c2VydGlvbnMoKyk8YnI+DQrCoGNyZWF0ZSBtb2RlIDEwMDY0NCBkb2MvYXBpL2R0cy90ZXN0cy5U
ZXN0U3VpdGVfcnRlX2Zsb3cucnN0PGJyPg0KwqBjcmVhdGUgbW9kZSAxMDA2NDQgZHRzL3Rlc3Rz
L1Rlc3RTdWl0ZV9ydGVfZmxvdy5weTxicj4NCjxicj4NCmRpZmYgLS1naXQgYS9kb2MvYXBpL2R0
cy90ZXN0cy5UZXN0U3VpdGVfcnRlX2Zsb3cucnN0IGIvZG9jL2FwaS9kdHMvdGVzdHMuVGVzdFN1
aXRlX3J0ZV9mbG93LnJzdDxicj4NCm5ldyBmaWxlIG1vZGUgMTAwNjQ0PGJyPg0KaW5kZXggMDAw
MDAwMDAwMC4uY2FkOTZiMjUzMDxicj4NCi0tLSAvZGV2L251bGw8YnI+DQorKysgYi9kb2MvYXBp
L2R0cy90ZXN0cy5UZXN0U3VpdGVfcnRlX2Zsb3cucnN0PGJyPg0KQEAgLTAsMCArMSw4IEBAPGJy
Pg0KKy4uIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBCU0QtMy1DbGF1c2U8YnI+DQorPGJyPg0K
K2NoZWNrc3VtX29mZmxvYWQgVGVzdCBTdWl0ZTxicj4NCis9PT09PT09PT09PT09PT09PT09PT09
PT09PT08YnI+DQorPGJyPg0KKy4uIGF1dG9tb2R1bGU6OiB0ZXN0cy5UZXN0U3VpdGVfcnRlX2Zs
b3c8YnI+DQorwqAgwqA6bWVtYmVyczo8YnI+DQorwqAgwqA6c2hvdy1pbmhlcml0YW5jZTo8YnI+
DQpcIE5vIG5ld2xpbmUgYXQgZW5kIG9mIGZpbGU8YnI+DQpkaWZmIC0tZ2l0IGEvZHRzL3Rlc3Rz
L1Rlc3RTdWl0ZV9ydGVfZmxvdy5weSBiL2R0cy90ZXN0cy9UZXN0U3VpdGVfcnRlX2Zsb3cucHk8
YnI+DQpuZXcgZmlsZSBtb2RlIDEwMDY0NDxicj4NCmluZGV4IDAwMDAwMDAwMDAuLmU3MGY3ZWE4
ZDE8YnI+DQotLS0gL2Rldi9udWxsPGJyPg0KKysrIGIvZHRzL3Rlc3RzL1Rlc3RTdWl0ZV9ydGVf
Zmxvdy5weTxicj4NCkBAIC0wLDAgKzEsNzkwIEBAPGJyPg0KKyMgU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEJTRC0zLUNsYXVzZTxicj4NCisjIENvcHlyaWdodChjKSAyMDI1IFVuaXZlcnNpdHkg
b2YgTmV3IEhhbXBzaGlyZTxicj4NCis8YnI+DQorJnF1b3Q7JnF1b3Q7JnF1b3Q7UlRFIEZsb3cg
dGVzdGluZyBzdWl0ZS48YnI+DQorPGJyPg0KK1RoaXMgc3VpdGUgdmVyaWZpZXMgYSByYW5nZSBv
ZiBmbG93IHJ1bGVzIGJ1aWx0IHVzaW5nIHBhdHRlcm5zPGJyPg0KK2FuZCBhY3Rpb25zIGZyb20g
dGhlIFJURSBGbG93IEFQSS4gSXQgd291bGQgYmUgaW1wb3NzaWJsZSB0byBjb3Zlcjxicj4NCitl
dmVyeSB2YWxpZCBmbG93IHJ1bGUsIGJ1dCB0aGlzIHN1aXRlIGFpbXMgdG8gdGVzdCB0aGUgbW9z
dDxicj4NCitpbXBvcnRhbnQgYW5kIGNvbW1vbiBmdW5jdGlvbmFsaXRpZXMgYWNyb3NzIFBNRHMu
PGJyPg0KKzxicj4NCismcXVvdDsmcXVvdDsmcXVvdDs8YnI+DQorPGJyPg0KK2Zyb20gY29sbGVj
dGlvbnMuYWJjIGltcG9ydCBDYWxsYWJsZTxicj4NCitmcm9tIGl0ZXJ0b29scyBpbXBvcnQgemlw
X2xvbmdlc3Q8YnI+DQorZnJvbSB0eXBpbmcgaW1wb3J0IEFueSwgSXRlcmF0b3IsIGNhc3Q8YnI+
DQorPGJyPg0KK2Zyb20gc2NhcHkubGF5ZXJzLmluZXQgaW1wb3J0IElQLCBUQ1AsIFVEUDxicj4N
Citmcm9tIHNjYXB5LmxheWVycy5pbmV0NiBpbXBvcnQgSVB2Njxicj4NCitmcm9tIHNjYXB5Lmxh
eWVycy5sMiBpbXBvcnQgRG90MVEsIEV0aGVyPGJyPg0KK2Zyb20gc2NhcHkucGFja2V0IGltcG9y
dCBQYWNrZXQsIFJhdzxicj4NCis8YnI+DQorZnJvbSBmcmFtZXdvcmsuZXhjZXB0aW9uIGltcG9y
dCBJbnRlcmFjdGl2ZUNvbW1hbmRFeGVjdXRpb25FcnJvcjxicj4NCitmcm9tIGZyYW1ld29yay5y
ZW1vdGVfc2Vzc2lvbi50ZXN0cG1kX3NoZWxsIGltcG9ydCBGbG93UnVsZSwgVGVzdFBtZFNoZWxs
PGJyPg0KK2Zyb20gZnJhbWV3b3JrLnRlc3Rfc3VpdGUgaW1wb3J0IFRlc3RTdWl0ZSwgZnVuY190
ZXN0PGJyPg0KK2Zyb20gZnJhbWV3b3JrLnRlc3RiZWRfbW9kZWwuY2FwYWJpbGl0eSBpbXBvcnQg
TmljQ2FwYWJpbGl0eSwgcmVxdWlyZXM8YnI+DQorPGJyPg0KKzxicj4NCitAcmVxdWlyZXMoTmlj
Q2FwYWJpbGl0eS5GTE9XX0NUUkwpPGJyPg0KK2NsYXNzIFRlc3RSdGVGbG93KFRlc3RTdWl0ZSk6
PGJyPg0KK8KgIMKgICZxdW90OyZxdW90OyZxdW90O1JURSBGbG93IHRlc3Qgc3VpdGUuPGJyPg0K
Kzxicj4NCivCoCDCoCBUaGlzIHN1aXRlIGNvbnNpc3RzIG9mIDEyIHRlc3QgY2FzZXM6PGJyPg0K
K8KgIMKgIDEuIFF1ZXVlIEFjdGlvbiBFdGhlcm5ldDogVmVyaWZpZXMgcXVldWUgYWN0aW9ucyB3
aXRoIGV0aGVybmV0IHBhdHRlcm5zPGJyPg0KK8KgIMKgIDIuIFF1ZXVlIEFjdGlvbiBJUDogVmVy
aWZpZXMgcXVldWUgYWN0aW9ucyB3aXRoIElQdjQgYW5kIElQdjYgcGF0dGVybnM8YnI+DQorwqAg
wqAgMy4gUXVldWUgQWN0aW9uIEw0OiBWZXJpZmllcyBxdWV1ZSBhY3Rpb25zIHdpdGggVENQIGFu
ZCBVRFAgcGF0dGVybnM8YnI+DQorwqAgwqAgNC4gUXVldWUgQWN0aW9uIFZMQU46IFZlcmlmaWVz
IHF1ZXVlIGFjdGlvbnMgd2l0aCBWTEFOIHBhdHRlcm5zPGJyPg0KK8KgIMKgIDUuIERyb3AgQWN0
aW9uIEV0aDogVmVyaWZpZXMgZHJvcCBhY3Rpb24gd2l0aCBldGhlcm5ldCBwYXR0ZXJuczxicj4N
CivCoCDCoCA2LiBEcm9wIEFjdGlvbiBJUDogVmVyaWZpZXMgZHJvcCBhY3Rpb25zIHdpdGggSVBW
NCBhbmQgSVB2NiBwYXR0ZXJuczxicj4NCivCoCDCoCA3LiBEcm9wIEFjdGlvbiBMNDogVmVyaWZp
ZXMgZHJvcCBhY3Rpb25zIHdpdGggVENQIGFuZCBVRFAgcGF0dGVybnM8YnI+DQorwqAgwqAgOC4g
RHJvcCBBY3Rpb24gVkxBTjogVmVyaWZpZXMgZHJvcCBhY3Rpb25zIHdpdGggVkxBTiBwYXR0ZXJu
czxicj4NCivCoCDCoCA5LiBNb2RpZnkgRmllbGQgQWN0aW9uOiBWZXJpZmllcyBwYWNrZXQgbW9k
aWZpY2F0aW9uIHBhdHRlcm5zPGJyPg0KK8KgIMKgIDEwLiBFZ3Jlc3MgUnVsZXM6IFZlcmlmaWVz
IHByZXZpb3VzbHkgY292ZXJlZCBydWxlcyBhcmUgc3RpbGwgdmFsaWQgYXMgZWdyZXNzPGJyPg0K
K8KgIMKgIDExLiBKdW1wIEFjdGlvbjogVmVyaWZpZXMgcGFja2V0IGJlaGF2aW9yIGdpdmVuIGdy
b3VwZWQgZmxvd3M8YnI+DQorwqAgwqAgMTIuIFByaW9yaXR5IEF0dHJpYnV0ZTogVmVyaWZpZXMg
cGFja2V0IGJlaGF2aW9yIGdpdmVuIGZsb3dzIHdpdGggZGlmZmVyZW50IHByaW9yaXRpZXM8YnI+
DQorPGJyPg0KK8KgIMKgICZxdW90OyZxdW90OyZxdW90Ozxicj4NCis8YnI+DQorwqAgwqAgZGVm
IHJ1bm5lcig8YnI+DQorwqAgwqAgwqAgwqAgc2VsZiw8YnI+DQorwqAgwqAgwqAgwqAgdmVyaWZp
Y2F0aW9uX21ldGhvZDogQ2FsbGFibGVbLi4uLCBBbnldLDxicj4NCivCoCDCoCDCoCDCoCBmbG93
czogbGlzdFtGbG93UnVsZV0sPGJyPg0KK8KgIMKgIMKgIMKgIHBhY2tldHM6IGxpc3RbUGFja2V0
XSw8YnI+DQorwqAgwqAgwqAgwqAgcG9ydF9pZDogaW50LDxicj4NCivCoCDCoCDCoCDCoCBleHBl
Y3RlZF9wYWNrZXRzOiBsaXN0W1BhY2tldF0gfCBOb25lID0gTm9uZSw8YnI+DQorwqAgwqAgwqAg
wqAgKmFyZ3M6IEFueSw8YnI+DQorwqAgwqAgwqAgwqAgKiprd2FyZ3M6IEFueSw8YnI+DQorwqAg
wqAgKSAtJmd0OyBOb25lOjxicj4NCivCoCDCoCDCoCDCoCAmcXVvdDsmcXVvdDsmcXVvdDtSdW5u
ZXIgbWV0aG9kIHRoYXQgdmFsaWRhdGVzIGVhY2ggZmxvdyB1c2luZyB0aGUgY29ycmVzcG9uZGlu
ZyB2ZXJpZmljYXRpb24gbWV0aG9kLjxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgQXJnczo8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgdmVyaWZpY2F0aW9uX21ldGhvZDogQ2FsbGFibGUgdGhhdCBw
ZXJmb3JtcyB2ZXJpZmljYXRpb24gbG9naWMuPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIGZsb3dz
OiBMaXN0IG9mIGZsb3cgcnVsZXMgdG8gY3JlYXRlIGFuZCB0ZXN0Ljxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCBwYWNrZXRzOiBMaXN0IG9mIHBhY2tldHMgY29ycmVzcG9uZGluZyB0byBlYWNoIGZs
b3cuPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHBvcnRfaWQ6IE51bWJlciByZXByZXNlbnRpbmcg
dGhlIHBvcnQgdG8gY3JlYXRlIGZsb3dzIG9uLjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBleHBl
Y3RlZF9wYWNrZXRzOiBMaXN0IG9mIHBhY2tldHMgdG8gY2hlY2sgc2VudCBwYWNrZXRzIGFnYWlu
c3QgaW4gbW9kaWZpY2F0aW9uIGNhc2VzLjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCAqYXJnczog
QWRkaXRpb25hbCBwb3NpdGlvbmFsIGFyZ3VtZW50cyB0byBwYXNzIHRvIHRoZSB2ZXJpZmljYXRp
b24gbWV0aG9kLjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCAqKmt3YXJnczogQWRkaXRpb25hbCBr
ZXl3b3JkIGFyZ3VtZW50cyB0byBwYXNzIHRvIHRoZSB2ZXJpZmljYXRpb24gbWV0aG9kLjxicj4N
CivCoCDCoCDCoCDCoCAmcXVvdDsmcXVvdDsmcXVvdDs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKg
IGRlZiB6aXBfbGlzdHMoPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJ1bGVzOiBsaXN0W0Zsb3dS
dWxlXSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcGFja2V0czE6IGxpc3RbUGFja2V0XSw8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgcGFja2V0czI6IGxpc3RbUGFja2V0XSB8IE5vbmUsPGJyPg0K
K8KgIMKgIMKgIMKgICkgLSZndDsgSXRlcmF0b3JbdHVwbGVbRmxvd1J1bGUsIFBhY2tldCwgUGFj
a2V0IHwgTm9uZV1dOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDsmcXVvdDsmcXVvdDtN
ZXRob2QgdGhhdCBjcmVhdGVzIGFuIGl0ZXJhYmxlIHppcCBjb250YWluaW5nIGxpc3RzIHVzZWQg
aW4gcnVubmVyLjxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgQXJnczo8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgcnVsZXM6IExpc3Qgb2YgZmxvdyBydWxlcy48YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgcGFja2V0czE6IExpc3Qgb2YgcGFja2V0cy48YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgcGFja2V0czI6IE9wdGlvbmFsIGxpc3Qgb2YgcGFja2V0cywg
ZXhjbHVkZWQgZnJvbSB6aXAgaWYgbm90IHBhc3NlZCB0byBydW5uZXIuPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgICZxdW90OyZxdW90OyZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCByZXR1
cm4gY2FzdCg8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgSXRlcmF0b3JbdHVwbGVbRmxv
d1J1bGUsIFBhY2tldCwgUGFja2V0IHwgTm9uZV1dLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCB6aXBfbG9uZ2VzdChydWxlcywgcGFja2V0czEsIHBhY2tldHMyIG9yIFtdLCBmaWxsdmFs
dWU9Tm9uZSksPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgICk8YnI+DQorPGJyPg0KK8KgIMKgIMKg
IMKgIHdpdGggVGVzdFBtZFNoZWxsKHJ4X3F1ZXVlcz00LCB0eF9xdWV1ZXM9NCkgYXMgdGVzdHBt
ZDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgZm9yIGZsb3csIHBhY2tldCwgZXhwZWN0ZWRfcGFj
a2V0IGluIHppcF9saXN0cyhmbG93cywgcGFja2V0cywgZXhwZWN0ZWRfcGFja2V0cyk6PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlzX3ZhbGlkID0gdGVzdHBtZC5mbG93X3ZhbGlkYXRl
KGZsb3dfcnVsZT1mbG93LCBwb3J0X2lkPXBvcnRfaWQpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHNlbGYudmVyaWZ5X2Vsc2Vfc2tpcChpc192YWxpZCwgJnF1b3Q7ZmxvdyBydWxlIGZh
aWxlZCB2YWxpZGF0aW9uLiZxdW90Oyk8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHRyeTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZmxvd19pZCA9IHRl
c3RwbWQuZmxvd19jcmVhdGUoZmxvd19ydWxlPWZsb3csIHBvcnRfaWQ9cG9ydF9pZCk8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZXhjZXB0IEludGVyYWN0aXZlQ29tbWFuZEV4ZWN1dGlv
bkVycm9yOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzZWxmLmxvZygmcXVv
dDtGbG93IHJ1bGUgdmFsaWRhdGlvbiBwYXNzZWQsIGJ1dCBmbG93IGNyZWF0aW9uIGZhaWxlZC4m
cXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNlbGYudmVyaWZ5KEZh
bHNlLCAmcXVvdDtGYWlsZWQgZmxvdyBjcmVhdGlvbiZxdW90Oyk8YnI+DQorPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGlmIHZlcmlmaWNhdGlvbl9tZXRob2QgPT0gc2VsZi5zZW5kX3Bh
Y2tldF9hbmRfdmVyaWZ5Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB2ZXJp
ZmljYXRpb25fbWV0aG9kKHBhY2tldD1wYWNrZXQsICphcmdzLCAqKmt3YXJncyk8YnI+DQorPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGVsaWYgdmVyaWZpY2F0aW9uX21ldGhvZCA9PSBz
ZWxmLnNlbmRfcGFja2V0X2FuZF92ZXJpZnlfcXVldWU6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHZlcmlmaWNhdGlvbl9tZXRob2QoPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHBhY2tldD1wYWNrZXQsIHRlc3RfcXVldWU9a3dhcmdzWyZxdW90
O3Rlc3RfcXVldWUmcXVvdDtdLCB0ZXN0cG1kPXRlc3RwbWQ8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgKTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZWxp
ZiB2ZXJpZmljYXRpb25fbWV0aG9kID09IHNlbGYuc2VuZF9wYWNrZXRfYW5kX3ZlcmlmeV9tb2Rp
ZmljYXRpb246PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHZlcmlmaWNhdGlv
bl9tZXRob2QocGFja2V0PXBhY2tldCwgZXhwZWN0ZWRfcGFja2V0PWV4cGVjdGVkX3BhY2tldCk8
YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRlc3RwbWQuZmxvd19kZWxldGUo
Zmxvd19pZCwgcG9ydF9pZD1wb3J0X2lkKTxicj4NCis8YnI+DQorwqAgwqAgZGVmIHNlbmRfcGFj
a2V0X2FuZF92ZXJpZnkoc2VsZiwgcGFja2V0OiBQYWNrZXQsIHNob3VsZF9yZWNlaXZlOiBib29s
ID0gVHJ1ZSkgLSZndDsgTm9uZTo8YnI+DQorwqAgwqAgwqAgwqAgJnF1b3Q7JnF1b3Q7JnF1b3Q7
R2VuZXJhdGUgYSBwYWNrZXQsIHNlbmQgdG8gdGhlIERVVCwgYW5kIHZlcmlmeSBpdCBpcyBmb3J3
YXJkZWQgYmFjay48YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIEFyZ3M6PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIHBhY2tldDogU2NhcHkgcGFja2V0IHRvIHNlbmQgYW5kIHZlcmlmeS48YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgc2hvdWxkX3JlY2VpdmU6IEluZGljYXRlIHdoZXRoZXIgdGhlIHBh
Y2tldCBzaG91bGQgYmUgcmVjZWl2ZWQuPGJyPg0KK8KgIMKgIMKgIMKgICZxdW90OyZxdW90OyZx
dW90Ozxicj4NCivCoCDCoCDCoCDCoCByZWNlaXZlZCA9IHNlbGYuc2VuZF9wYWNrZXRfYW5kX2Nh
cHR1cmUocGFja2V0KTxicj4NCivCoCDCoCDCoCDCoCBjb250YWluc19wYWNrZXQgPSBhbnkoPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIHBhY2tldC5oYXNsYXllcihSYXcpIGFuZCBiJnF1b3Q7eHh4
eHgmcXVvdDsgaW4gcGFja2V0LmxvYWQgZm9yIHBhY2tldCBpbiByZWNlaXZlZDxicj4NCivCoCDC
oCDCoCDCoCApPGJyPg0KK8KgIMKgIMKgIMKgIHNlbGYudmVyaWZ5KDxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCBzaG91bGRfcmVjZWl2ZSA9PSBjb250YWluc19wYWNrZXQsPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIGYmcXVvdDtQYWNrZXQgd2FzIHsmIzM5O2Ryb3BwZWQmIzM5OyBpZiBzaG91bGRf
cmVjZWl2ZSBlbHNlICYjMzk7cmVjZWl2ZWQmIzM5O30mcXVvdDssPGJyPg0KK8KgIMKgIMKgIMKg
ICk8YnI+DQorPGJyPg0KK8KgIMKgIGRlZiBzZW5kX3BhY2tldF9hbmRfdmVyaWZ5X3F1ZXVlKDxi
cj4NCivCoCDCoCDCoCDCoCBzZWxmLCBwYWNrZXQ6IFBhY2tldCwgdGVzdF9xdWV1ZTogaW50LCB0
ZXN0cG1kOiBUZXN0UG1kU2hlbGw8YnI+DQorwqAgwqAgKSAtJmd0OyBOb25lOjxicj4NCivCoCDC
oCDCoCDCoCAmcXVvdDsmcXVvdDsmcXVvdDtTZW5kIHBhY2tldCBhbmQgdmVyaWZ5IHF1ZXVlIHN0
YXRzIHNob3cgcGFja2V0IHdhcyByZWNlaXZlZC48YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIEFy
Z3M6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHBhY2tldDogU2NhcHkgcGFja2V0IHRvIHNlbmQg
dG8gdGhlIFNVVC48YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgdGVzdF9xdWV1ZTogUmVwcmVzZW50
cyB0aGUgcXVldWUgdGhlIHRlc3QgcGFja2V0IGlzIGJlaW5nIHNlbnQgdG8uPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIHRlc3RwbWQ6IFRlc3RQbWRTaGVsbCBpbnN0YW5jZSBiZWluZyB1c2VkIHRv
IHNlbmQgdGVzdCBwYWNrZXQuPGJyPg0KK8KgIMKgIMKgIMKgICZxdW90OyZxdW90OyZxdW90Ozxi
cj4NCivCoCDCoCDCoCDCoCB0ZXN0cG1kLnNldF92ZXJib3NlKGxldmVsPTgpPGJyPg0KK8KgIMKg
IMKgIMKgIHRlc3RwbWQuc3RhcnQoKTxicj4NCivCoCDCoCDCoCDCoCBzZWxmLnNlbmRfcGFja2V0
X2FuZF9jYXB0dXJlKHBhY2tldD1wYWNrZXQpPGJyPg0KK8KgIMKgIMKgIMKgIHZlcmJvc2Vfb3V0
cHV0ID0gdGVzdHBtZC5leHRyYWN0X3ZlcmJvc2Vfb3V0cHV0KHRlc3RwbWQuc3RvcCgpKTxicj4N
CivCoCDCoCDCoCDCoCByZWNlaXZlZCA9IEZhbHNlPGJyPg0KK8KgIMKgIMKgIMKgIGZvciB0ZXN0
cG1kX3BhY2tldCBpbiB2ZXJib3NlX291dHB1dDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgaWYg
dGVzdHBtZF9wYWNrZXQucXVldWVfaWQgPT0gdGVzdF9xdWV1ZTo8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgcmVjZWl2ZWQgPSBUcnVlPGJyPg0KK8KgIMKgIMKgIMKgIHNlbGYudmVyaWZ5
KHJlY2VpdmVkLCBmJnF1b3Q7RXhwZWN0ZWQgcGFja2V0IHdhcyBub3QgcmVjZWl2ZWQgb24gcXVl
dWUge3Rlc3RfcXVldWV9JnF1b3Q7KTxicj4NCis8YnI+DQorwqAgwqAgZGVmIHNlbmRfcGFja2V0
X2FuZF92ZXJpZnlfbW9kaWZpY2F0aW9uKHNlbGYsIHBhY2tldDogUGFja2V0LCBleHBlY3RlZF9w
YWNrZXQ6IFBhY2tldCkgLSZndDsgTm9uZTo8YnI+DQorwqAgwqAgwqAgwqAgJnF1b3Q7JnF1b3Q7
JnF1b3Q7U2VuZCBwYWNrZXQgYW5kIHZlcmlmeSB0aGUgZXhwZWN0ZWQgbW9kaWZpY2F0aW9ucyBh
cmUgcHJlc2VudCB1cG9uIHJlY2VwdGlvbi48YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIEFyZ3M6
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHBhY2tldDogU2NhcHkgcGFja2V0IHRvIHNlbmQgdG8g
dGhlIFNVVC48YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgZXhwZWN0ZWRfcGFja2V0OiBTY2FweSBw
YWNrZXQgdGhhdCBzaG91bGQgbWF0Y2ggdGhlIHJlY2VpdmVkIHBhY2tldC48YnI+DQorwqAgwqAg
wqAgwqAgJnF1b3Q7JnF1b3Q7JnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKgIHJlY2VpdmVkID0gc2Vs
Zi5zZW5kX3BhY2tldF9hbmRfY2FwdHVyZShwYWNrZXQpPGJyPg0KKzxicj4NCivCoCDCoCDCoCDC
oCAjIHZlcmlmeSByZWNlcHRpb248YnI+DQorwqAgwqAgwqAgwqAgc2VsZi52ZXJpZnkocmVjZWl2
ZWQgIT0gW10sICZxdW90O1BhY2tldCB3YXMgbmV2ZXIgcmVjZWl2ZWQuJnF1b3Q7KTxicj4NCis8
YnI+DQorwqAgwqAgwqAgwqAgc2VsZi5sb2coZiZxdW90O1NFTlQgUEFDS0VUOsKgIMKgIMKge3Bh
Y2tldC5zdW1tYXJ5KCl9JnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCBzZWxmLmxvZyhmJnF1b3Q7
RVhQRUNURUQgUEFDS0VUOiB7ZXhwZWN0ZWRfcGFja2V0LnN1bW1hcnkoKX0mcXVvdDspPGJyPg0K
K8KgIMKgIMKgIMKgIGZvciBwYWNrZXQgaW4gcmVjZWl2ZWQ6PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIHNlbGYubG9nKGYmcXVvdDtSRUNFSVZFRCBQQUNLRVQ6IHtwYWNrZXQuc3VtbWFyeSgpfSZx
dW90Oyk8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIGV4cGVjdGVkX2lwX2RzdCA9IGV4cGVjdGVk
X3BhY2tldFtJUF0uZHN0IGlmIElQIGluIGV4cGVjdGVkX3BhY2tldCBlbHNlIE5vbmU8YnI+DQor
wqAgwqAgwqAgwqAgcmVjZWl2ZWRfaXBfZHN0ID0gcmVjZWl2ZWRbSVBdLmRzdCBpZiBJUCBpbiBy
ZWNlaXZlZCBlbHNlIE5vbmU8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIGV4cGVjdGVkX21hY19k
c3QgPSBleHBlY3RlZF9wYWNrZXRbRXRoZXJdLmRzdCBpZiBFdGhlciBpbiBleHBlY3RlZF9wYWNr
ZXQgZWxzZSBOb25lPGJyPg0KK8KgIMKgIMKgIMKgIHJlY2VpdmVkX21hY19kc3QgPSByZWNlaXZl
ZFtFdGhlcl0uZHN0IGlmIEV0aGVyIGluIHJlY2VpdmVkIGVsc2UgTm9uZTxicj4NCis8YnI+DQor
wqAgwqAgwqAgwqAgIyB2ZXJpZnkgbW9kaWZpY2F0aW9uPGJyPg0KK8KgIMKgIMKgIMKgIGlmIGV4
cGVjdGVkX2lwX2RzdCBpcyBub3QgTm9uZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgc2VsZi52
ZXJpZnkoPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJlY2VpdmVkX2lwX2RzdCA9PSBl
eHBlY3RlZF9pcF9kc3QsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGYmcXVvdDtJUHY0
IGRzdCBtaXNtYXRjaDogZXhwZWN0ZWQge2V4cGVjdGVkX2lwX2RzdH0sIGdvdCB7cmVjZWl2ZWRf
aXBfZHN0fSZxdW90Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgKTxicj4NCis8YnI+DQorwqAg
wqAgwqAgwqAgaWYgZXhwZWN0ZWRfbWFjX2RzdCBpcyBub3QgTm9uZTo8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgc2VsZi52ZXJpZnkoPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJlY2Vp
dmVkX21hY19kc3QgPT0gZXhwZWN0ZWRfbWFjX2RzdCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgZiZxdW90O01BQyBkc3QgbWlzbWF0Y2g6IGV4cGVjdGVkIHtleHBlY3RlZF9tYWNfZHN0
fSwgZ290IHtyZWNlaXZlZF9tYWNfZHN0fSZxdW90Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
KTxicj4NCis8YnI+DQorwqAgwqAgZGVmIHNlbmRfcGFja2V0X2FuZF92ZXJpZnlfanVtcCg8YnI+
DQorwqAgwqAgwqAgwqAgc2VsZiw8YnI+DQorwqAgwqAgwqAgwqAgcGFja2V0czogbGlzdFtQYWNr
ZXRdLDxicj4NCivCoCDCoCDCoCDCoCBmbG93X3J1bGVzOiBsaXN0W0Zsb3dSdWxlXSw8YnI+DQor
wqAgwqAgwqAgwqAgdGVzdF9xdWV1ZXM6IGxpc3RbaW50XSw8YnI+DQorwqAgwqAgwqAgwqAgdGVz
dHBtZDogVGVzdFBtZFNoZWxsLDxicj4NCivCoCDCoCApIC0mZ3Q7IE5vbmU6PGJyPg0KK8KgIMKg
IMKgIMKgICZxdW90OyZxdW90OyZxdW90O0NyZWF0ZSBhIHRlc3RwbWQgc2Vzc2lvbiB3aXRoIGV2
ZXJ5IHJ1bGUgaW4gdGhlIGdpdmVuIGxpc3QsIHZlcmlmeSBqdW1wIGJlaGF2aW9yLjxicj4NCis8
YnI+DQorwqAgwqAgwqAgwqAgQXJnczo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcGFja2V0czog
TGlzdCBvZiBwYWNrZXRzIHRvIHNlbmQuPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIGZsb3dfcnVs
ZXM6IExpc3Qgb2YgZmxvdyBydWxlcyB0byBjcmVhdGUgaW4gdGhlIHNhbWUgc2Vzc2lvbi48YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgdGVzdF9xdWV1ZXM6IExpc3Qgb2YgUnggcXVldWUgSURzIGVh
Y2ggcGFja2V0IHNob3VsZCBiZSByZWNlaXZlZCBvbi48YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
dGVzdHBtZDogVGVzdFBtZFNoZWxsIGluc3RhbmNlIHRvIGNyZWF0ZSBmbG93cyBvbi48YnI+DQor
wqAgwqAgwqAgwqAgJnF1b3Q7JnF1b3Q7JnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKgIHRlc3RwbWQu
c2V0X3ZlcmJvc2UobGV2ZWw9OCk8YnI+DQorwqAgwqAgwqAgwqAgZm9yIGZsb3cgaW4gZmxvd19y
dWxlczo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgaXNfdmFsaWQgPSB0ZXN0cG1kLmZsb3dfdmFs
aWRhdGUoZmxvd19ydWxlPWZsb3csIHBvcnRfaWQ9MCk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
c2VsZi52ZXJpZnlfZWxzZV9za2lwKGlzX3ZhbGlkLCAmcXVvdDtmbG93IHJ1bGUgZmFpbGVkIHZh
bGlkYXRpb24uJnF1b3Q7KTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgdHJ5Ojxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0ZXN0cG1kLmZsb3dfY3JlYXRlKGZsb3dfcnVsZT1m
bG93LCBwb3J0X2lkPTApPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIGV4Y2VwdCBJbnRlcmFjdGl2
ZUNvbW1hbmRFeGVjdXRpb25FcnJvcjo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc2Vs
Zi5sb2coJnF1b3Q7RmxvdyB2YWxpZGF0aW9uIHBhc3NlZCwgYnV0IGZsb3cgY3JlYXRpb24gZmFp
bGVkLiZxdW90Oyk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc2VsZi52ZXJpZnkoRmFs
c2UsICZxdW90O0ZhaWxlZCBmbG93IGNyZWF0aW9uJnF1b3Q7KTxicj4NCis8YnI+DQorwqAgwqAg
wqAgwqAgZm9yIHBhY2tldCwgdGVzdF9xdWV1ZSBpbiB6aXAocGFja2V0cywgdGVzdF9xdWV1ZXMp
Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCB0ZXN0cG1kLnN0YXJ0KCk8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgc2VsZi5zZW5kX3BhY2tldF9hbmRfY2FwdHVyZShwYWNrZXQ9cGFja2V0KTxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCB2ZXJib3NlX291dHB1dCA9IHRlc3RwbWQuZXh0cmFjdF92ZXJi
b3NlX291dHB1dCh0ZXN0cG1kLnN0b3AoKSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcmVjZWl2
ZWQgPSBGYWxzZTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBmb3IgdGVzdHBtZF9wYWNrZXQgaW4g
dmVyYm9zZV9vdXRwdXQ6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIHRlc3RwbWRf
cGFja2V0LnF1ZXVlX2lkID09IHRlc3RfcXVldWU6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHJlY2VpdmVkID0gVHJ1ZTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBzZWxmLnZl
cmlmeShyZWNlaXZlZCwgZiZxdW90O0V4cGVjdGVkIHBhY2tldCB3YXMgbm90IHJlY2VpdmVkIG9u
IHF1ZXVlIHt0ZXN0X3F1ZXVlfSZxdW90Oyk8YnI+DQorPGJyPg0KK8KgIMKgIEBmdW5jX3Rlc3Q8
YnI+DQorwqAgwqAgZGVmIHRlc3RfcXVldWVfYWN0aW9uX0VUSChzZWxmKSAtJmd0OyBOb25lOjxi
cj4NCivCoCDCoCDCoCDCoCAmcXVvdDsmcXVvdDsmcXVvdDtWYWxpZGF0ZSBmbG93IHJ1bGVzIHdp
dGggcXVldWUgYWN0aW9ucyBhbmQgZXRoZXJuZXQgcGF0dGVybnMuPGJyPg0KKzxicj4NCivCoCDC
oCDCoCDCoCBTdGVwczo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgQ3JlYXRlIGEgbGlzdCBvZiBw
YWNrZXRzIHRvIHRlc3QsIHdpdGggYSBjb3JyZXNwb25kaW5nIGZsb3cgbGlzdC48YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgTGF1bmNoIHRlc3RwbWQuPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIENy
ZWF0ZSBmaXJzdCBmbG93IHJ1bGUgaW4gZmxvdyBsaXN0Ljxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCBTZW5kIGZpcnN0IHBhY2tldCBpbiBwYWNrZXQgbGlzdCwgY2FwdHVyZSB2ZXJib3NlIG91dHB1
dC48YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgRGVsZXRlIGZsb3cgcnVsZSwgcmVwZWF0IGZvciBh
bGwgZmxvd3MvcGFja2V0cy48YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIFZlcmlmeTo8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgQ2hlY2sgdGhhdCBlYWNoIHBhY2tldCBpcyByZWNlaXZlZCBvbiB0
aGUgYXBwcm9wcmlhdGUgcXVldWUuPGJyPg0KK8KgIMKgIMKgIMKgICZxdW90OyZxdW90OyZxdW90
Ozxicj4NCivCoCDCoCDCoCDCoCBwYWNrZXRfbGlzdCA9IFs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgRXRoZXIoc3JjPSZxdW90OzAyOjAwOjAwOjAwOjAwOjAwJnF1b3Q7KSw8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgRXRoZXIoZHN0PSZxdW90OzAyOjAwOjAwOjAwOjAwOjAwJnF1b3Q7KSw8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgRXRoZXIodHlwZT0weDA4MDApIC8gSVAoKSw8YnI+DQorwqAg
wqAgwqAgwqAgXTxicj4NCivCoCDCoCDCoCDCoCBmbG93X2xpc3QgPSBbPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIEZsb3dSdWxlKDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkaXJlY3Rp
b249JnF1b3Q7aW5ncmVzcyZxdW90Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcGF0
dGVybj1bJnF1b3Q7ZXRoIHNyYyBpcyAwMjowMDowMDowMDowMDowMCZxdW90O10sPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGFjdGlvbnM9WyZxdW90O3F1ZXVlIGluZGV4IDImcXVvdDtd
LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCApLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBGbG93
UnVsZSg8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGlyZWN0aW9uPSZxdW90O2luZ3Jl
c3MmcXVvdDssPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHBhdHRlcm49WyZxdW90O2V0
aCBkc3QgaXMgMDI6MDA6MDA6MDA6MDA6MDAmcXVvdDtdLDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBhY3Rpb25zPVsmcXVvdDtxdWV1ZSBpbmRleCAyJnF1b3Q7XSw8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgRmxvd1J1bGUoPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRpcmVjdGlvbj0mcXVvdDtpbmdyZXNzJnF1b3Q7LCBwYXR0
ZXJuPVsmcXVvdDtldGggdHlwZSBpcyAweDA4MDAmcXVvdDtdLCBhY3Rpb25zPVsmcXVvdDtxdWV1
ZSBpbmRleCAyJnF1b3Q7XTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCApLDxicj4NCivCoCDCoCDC
oCDCoCBdPGJyPg0KK8KgIMKgIMKgIMKgIHNlbGYucnVubmVyKDxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCB2ZXJpZmljYXRpb25fbWV0aG9kPXNlbGYuc2VuZF9wYWNrZXRfYW5kX3ZlcmlmeV9xdWV1
ZSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgZmxvd3M9Zmxvd19saXN0LDxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCBwYWNrZXRzPXBhY2tldF9saXN0LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBw
b3J0X2lkPTAsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHRlc3RfcXVldWU9Miw8YnI+DQorwqAg
wqAgwqAgwqAgKTxicj4NCis8YnI+DQorwqAgwqAgQGZ1bmNfdGVzdDxicj4NCivCoCDCoCBkZWYg
dGVzdF9xdWV1ZV9hY3Rpb25fSVAoc2VsZikgLSZndDsgTm9uZTo8YnI+DQorwqAgwqAgwqAgwqAg
JnF1b3Q7JnF1b3Q7JnF1b3Q7VmFsaWRhdGUgZmxvdyBydWxlcyB3aXRoIHF1ZXVlIGFjdGlvbnMg
YW5kIElQdjQvSVB2NiBwYXR0ZXJucy48YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIFN0ZXBzOjxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCBDcmVhdGUgYSBsaXN0IG9mIHBhY2tldHMgdG8gdGVzdCwg
d2l0aCBhIGNvcnJlc3BvbmRpbmcgZmxvdyBsaXN0Ljxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBM
YXVuY2ggdGVzdHBtZC48YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgQ3JlYXRlIGZpcnN0IGZsb3cg
cnVsZSBpbiBmbG93IGxpc3QuPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIFNlbmQgZmlyc3QgcGFj
a2V0IGluIHBhY2tldCBsaXN0LCBjYXB0dXJlIHZlcmJvc2Ugb3V0cHV0Ljxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCBEZWxldGUgZmxvdyBydWxlLCByZXBlYXQgZm9yIGFsbCBmbG93cy9wYWNrZXRz
Ljxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgVmVyaWZ5Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCBDaGVjayB0aGF0IGVhY2ggcGFja2V0IGlzIHJlY2VpdmVkIG9uIHRoZSBhcHByb3ByaWF0ZSBx
dWV1ZS48YnI+DQorwqAgwqAgwqAgwqAgJnF1b3Q7JnF1b3Q7JnF1b3Q7PGJyPg0KK8KgIMKgIMKg
IMKgIHBhY2tldF9saXN0ID0gWzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBFdGhlcigpIC8gSVAo
c3JjPSZxdW90OzE5Mi4xNjguMS4xJnF1b3Q7KSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgRXRo
ZXIoKSAvIElQKGRzdD0mcXVvdDsxOTIuMTY4LjEuMSZxdW90OyksPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIEV0aGVyKCkgLyBJUCh0dGw9NjQpLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBFdGhl
cigpIC8gSVB2NihzcmM9JnF1b3Q7MjAwMTpkYjg6OjEmcXVvdDspLDxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCBFdGhlcigpIC8gSVB2Nihkc3Q9JnF1b3Q7MjAwMTpkYjg6OjImcXVvdDspLDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCBFdGhlcigpIC8gSVB2NigpIC8gVURQKCksPGJyPg0KK8KgIMKg
IMKgIMKgIF08YnI+DQorwqAgwqAgwqAgwqAgZmxvd19saXN0ID0gWzxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCBGbG93UnVsZSg8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGlyZWN0aW9u
PSZxdW90O2luZ3Jlc3MmcXVvdDssPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHBhdHRl
cm49WyZxdW90O2V0aCAvIGlwdjQgc3JjIGlzIDE5Mi4xNjguMS4xJnF1b3Q7XSw8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgYWN0aW9ucz1bJnF1b3Q7cXVldWUgaW5kZXggMiZxdW90O10s
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgICksPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIEZsb3dS
dWxlKDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkaXJlY3Rpb249JnF1b3Q7aW5ncmVz
cyZxdW90Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcGF0dGVybj1bJnF1b3Q7ZXRo
IC8gaXB2NCBkc3QgaXMgMTkyLjE2OC4xLjEmcXVvdDtdLDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBhY3Rpb25zPVsmcXVvdDtxdWV1ZSBpbmRleCAyJnF1b3Q7XSw8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgRmxvd1J1bGUoPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRpcmVjdGlvbj0mcXVvdDtpbmdyZXNzJnF1b3Q7LCBwYXR0
ZXJuPVsmcXVvdDtldGggLyBpcHY0IHR0bCBpcyA2NCZxdW90O10sIGFjdGlvbnM9WyZxdW90O3F1
ZXVlIGluZGV4IDImcXVvdDtdPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgICksPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIEZsb3dSdWxlKDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkaXJl
Y3Rpb249JnF1b3Q7aW5ncmVzcyZxdW90Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
cGF0dGVybj1bJnF1b3Q7ZXRoIC8gaXB2NiBzcmMgaXMgMjAwMTpkYjg6OjEmcXVvdDtdLDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBhY3Rpb25zPVsmcXVvdDtxdWV1ZSBpbmRleCAyJnF1
b3Q7XSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
Rmxvd1J1bGUoPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRpcmVjdGlvbj0mcXVvdDtp
bmdyZXNzJnF1b3Q7LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwYXR0ZXJuPVsmcXVv
dDtldGggLyBpcHY2IGRzdCBpcyAyMDAxOmRiODo6MiZxdW90O10sPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGFjdGlvbnM9WyZxdW90O3F1ZXVlIGluZGV4IDImcXVvdDtdLDxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCApLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBGbG93UnVsZSg8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGlyZWN0aW9uPSZxdW90O2luZ3Jlc3MmcXVvdDss
IHBhdHRlcm49WyZxdW90O2V0aCAvIGlwdjYgcHJvdG8gaXMgMTcmcXVvdDtdLCBhY3Rpb25zPVsm
cXVvdDtxdWV1ZSBpbmRleCAyJnF1b3Q7XTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCApLDxicj4N
CivCoCDCoCDCoCDCoCBdPGJyPg0KK8KgIMKgIMKgIMKgIHNlbGYucnVubmVyKDxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCB2ZXJpZmljYXRpb25fbWV0aG9kPXNlbGYuc2VuZF9wYWNrZXRfYW5kX3Zl
cmlmeV9xdWV1ZSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgZmxvd3M9Zmxvd19saXN0LDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCBwYWNrZXRzPXBhY2tldF9saXN0LDxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCBwb3J0X2lkPTAsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHRlc3RfcXVldWU9Miw8
YnI+DQorwqAgwqAgwqAgwqAgKTxicj4NCis8YnI+DQorwqAgwqAgQGZ1bmNfdGVzdDxicj4NCivC
oCDCoCBkZWYgdGVzdF9xdWV1ZV9hY3Rpb25fTDQoc2VsZikgLSZndDsgTm9uZTo8YnI+DQorwqAg
wqAgwqAgwqAgJnF1b3Q7JnF1b3Q7JnF1b3Q7VmFsaWRhdGUgZmxvdyBydWxlcyB3aXRoIHF1ZXVl
IGFjdGlvbnMgYW5kIFRDUC9VRFAgcGF0dGVybnMuPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCBT
dGVwczo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgQ3JlYXRlIGEgbGlzdCBvZiBwYWNrZXRzIHRv
IHRlc3QsIHdpdGggYSBjb3JyZXNwb25kaW5nIGZsb3cgbGlzdC48YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgTGF1bmNoIHRlc3RwbWQuPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIENyZWF0ZSBmaXJz
dCBmbG93IHJ1bGUgaW4gZmxvdyBsaXN0Ljxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBTZW5kIGZp
cnN0IHBhY2tldCBpbiBwYWNrZXQgbGlzdCwgY2FwdHVyZSB2ZXJib3NlIG91dHB1dC48YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgRGVsZXRlIGZsb3cgcnVsZSwgcmVwZWF0IGZvciBhbGwgZmxvd3Mv
cGFja2V0cy48YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIFZlcmlmeTo8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgQ2hlY2sgdGhhdCBlYWNoIHBhY2tldCBpcyByZWNlaXZlZCBvbiB0aGUgYXBwcm9w
cmlhdGUgcXVldWUuPGJyPg0KK8KgIMKgIMKgIMKgICZxdW90OyZxdW90OyZxdW90Ozxicj4NCivC
oCDCoCDCoCDCoCBwYWNrZXRfbGlzdCA9IFs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgRXRoZXIo
KSAvIElQKCkgLyBUQ1Aoc3BvcnQ9MTIzNCksPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIEV0aGVy
KCkgLyBJUCgpIC8gVENQKGRwb3J0PTgwKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgRXRoZXIo
KSAvIElQKCkgLyBUQ1AoZmxhZ3M9MHgwMiksPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIEV0aGVy
KCkgLyBJUCgpIC8gVURQKHNwb3J0PTUwMDApLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBFdGhl
cigpIC8gSVAoKSAvIFVEUChkcG9ydD01MyksPGJyPg0KK8KgIMKgIMKgIMKgIF08YnI+DQorwqAg
wqAgwqAgwqAgZmxvd19saXN0ID0gWzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBGbG93UnVsZSg8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGlyZWN0aW9uPSZxdW90O2luZ3Jlc3MmcXVv
dDssPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHBhdHRlcm49WyZxdW90O2V0aCAvIGlw
djQgLyB0Y3Agc3JjIGlzIDEyMzQmcXVvdDtdLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBhY3Rpb25zPVsmcXVvdDtxdWV1ZSBpbmRleCAyJnF1b3Q7XSw8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgRmxvd1J1bGUoPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGRpcmVjdGlvbj0mcXVvdDtpbmdyZXNzJnF1b3Q7LDxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBwYXR0ZXJuPVsmcXVvdDtldGggLyBpcHY0IC8gdGNwIGRzdCBp
cyA4MCZxdW90O10sPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGFjdGlvbnM9WyZxdW90
O3F1ZXVlIGluZGV4IDImcXVvdDtdLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCApLDxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCBGbG93UnVsZSg8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
ZGlyZWN0aW9uPSZxdW90O2luZ3Jlc3MmcXVvdDssPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHBhdHRlcm49WyZxdW90O2V0aCAvIGlwdjQgLyB0Y3AgZmxhZ3MgaXMgMHgwMiZxdW90O10s
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGFjdGlvbnM9WyZxdW90O3F1ZXVlIGluZGV4
IDImcXVvdDtdLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCApLDxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCBGbG93UnVsZSg8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGlyZWN0aW9uPSZx
dW90O2luZ3Jlc3MmcXVvdDssPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHBhdHRlcm49
WyZxdW90O2V0aCAvIGlwdjQgLyB1ZHAgc3JjIGlzIDUwMDAmcXVvdDtdLDxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBhY3Rpb25zPVsmcXVvdDtxdWV1ZSBpbmRleCAyJnF1b3Q7XSw8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgRmxvd1J1bGUo
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRpcmVjdGlvbj0mcXVvdDtpbmdyZXNzJnF1
b3Q7LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwYXR0ZXJuPVsmcXVvdDtldGggLyBp
cHY0IC8gdWRwIGRzdCBpcyA1MyZxdW90O10sPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGFjdGlvbnM9WyZxdW90O3F1ZXVlIGluZGV4IDImcXVvdDtdLDxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCApLDxicj4NCivCoCDCoCDCoCDCoCBdPGJyPg0KK8KgIMKgIMKgIMKgIHNlbGYucnVubmVy
KDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCB2ZXJpZmljYXRpb25fbWV0aG9kPXNlbGYuc2VuZF9w
YWNrZXRfYW5kX3ZlcmlmeV9xdWV1ZSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgZmxvd3M9Zmxv
d19saXN0LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBwYWNrZXRzPXBhY2tldF9saXN0LDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCBwb3J0X2lkPTAsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHRl
c3RfcXVldWU9Miw8YnI+DQorwqAgwqAgwqAgwqAgKTxicj4NCis8YnI+DQorwqAgwqAgQGZ1bmNf
dGVzdDxicj4NCivCoCDCoCBkZWYgdGVzdF9xdWV1ZV9hY3Rpb25fVkxBTihzZWxmKSAtJmd0OyBO
b25lOjxicj4NCivCoCDCoCDCoCDCoCAmcXVvdDsmcXVvdDsmcXVvdDtWYWxpZGF0ZSBmbG93IHJ1
bGVzIHdpdGggcXVldWUgYWN0aW9ucyBhbmQgVkxBTiBwYXR0ZXJucy48YnI+DQorPGJyPg0KK8Kg
IMKgIMKgIMKgIFN0ZXBzOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBDcmVhdGUgYSBsaXN0IG9m
IHBhY2tldHMgdG8gdGVzdCwgd2l0aCBhIGNvcnJlc3BvbmRpbmcgZmxvdyBsaXN0Ljxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCBMYXVuY2ggdGVzdHBtZC48YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
Q3JlYXRlIGZpcnN0IGZsb3cgcnVsZSBpbiBmbG93IGxpc3QuPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIFNlbmQgZmlyc3QgcGFja2V0IGluIHBhY2tldCBsaXN0LCBjYXB0dXJlIHZlcmJvc2Ugb3V0
cHV0Ljxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBEZWxldGUgZmxvdyBydWxlLCByZXBlYXQgZm9y
IGFsbCBmbG93cy9wYWNrZXRzLjxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgVmVyaWZ5Ojxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCBDaGVjayB0aGF0IGVhY2ggcGFja2V0IGlzIHJlY2VpdmVkIG9u
IHRoZSBhcHByb3ByaWF0ZSBxdWV1ZS48YnI+DQorwqAgwqAgwqAgwqAgJnF1b3Q7JnF1b3Q7JnF1
b3Q7PGJyPg0KK8KgIMKgIMKgIMKgIHBhY2tldF9saXN0ID0gW0V0aGVyKCkgLyBEb3QxUSh2bGFu
PTEwMCksIEV0aGVyKCkgLyBEb3QxUSh0eXBlPTB4MDgwMCldPGJyPg0KK8KgIMKgIMKgIMKgIGZs
b3dfbGlzdCA9IFs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgRmxvd1J1bGUoZGlyZWN0aW9uPSZx
dW90O2luZ3Jlc3MmcXVvdDssIHBhdHRlcm49WyZxdW90O2V0aCAvIHZsYW4mcXVvdDtdLCBhY3Rp
b25zPVsmcXVvdDtxdWV1ZSBpbmRleCAyJnF1b3Q7XSksPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IEZsb3dSdWxlKGRpcmVjdGlvbj0mcXVvdDtpbmdyZXNzJnF1b3Q7LCBwYXR0ZXJuPVsmcXVvdDtl
dGggLyB2bGFuJnF1b3Q7XSwgYWN0aW9ucz1bJnF1b3Q7cXVldWUgaW5kZXggMiZxdW90O10pLDxi
cj4NCivCoCDCoCDCoCDCoCBdPGJyPg0KK8KgIMKgIMKgIMKgIHNlbGYucnVubmVyKDxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCB2ZXJpZmljYXRpb25fbWV0aG9kPXNlbGYuc2VuZF9wYWNrZXRfYW5k
X3ZlcmlmeV9xdWV1ZSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgZmxvd3M9Zmxvd19saXN0LDxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCBwYWNrZXRzPXBhY2tldF9saXN0LDxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCBwb3J0X2lkPTAsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHRlc3RfcXVldWU9
Miw8YnI+DQorwqAgwqAgwqAgwqAgKTxicj4NCis8YnI+DQorwqAgwqAgQGZ1bmNfdGVzdDxicj4N
CivCoCDCoCBkZWYgdGVzdF9kcm9wX2FjdGlvbl9FVEgoc2VsZikgLSZndDsgTm9uZTo8YnI+DQor
wqAgwqAgwqAgwqAgJnF1b3Q7JnF1b3Q7JnF1b3Q7VmFsaWRhdGUgZmxvdyBydWxlcyB3aXRoIGRy
b3AgYWN0aW9ucyBhbmQgZXRoZXJuZXQgcGF0dGVybnMuPGJyPg0KKzxicj4NCivCoCDCoCDCoCDC
oCBTdGVwczo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgQ3JlYXRlIGEgbGlzdCBvZiBwYWNrZXRz
IHRvIHRlc3QsIHdpdGggYSBjb3JyZXNwb25kaW5nIGZsb3cgbGlzdC48YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgTGF1bmNoIHRlc3RwbWQuPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIENyZWF0ZSBm
aXJzdCBmbG93IHJ1bGUgaW4gZmxvdyBsaXN0Ljxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBTZW5k
IGZpcnN0IHBhY2tldCBpbiBwYWNrZXQgbGlzdCwgY2FwdHVyZSB2ZXJib3NlIG91dHB1dC48YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgRGVsZXRlIGZsb3cgcnVsZSwgcmVwZWF0IGZvciBhbGwgZmxv
d3MvcGFja2V0cy48YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIFZlcmlmeTo8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgQ2hlY2sgdGhhdCBlYWNoIHBhY2tldCBpcyBkcm9wcGVkLjxicj4NCis8YnI+
DQorwqAgwqAgwqAgwqAgT25lIHBhY2tldCB3aWxsIGJlIHNlbnQgYXMgYSBjb25maWRlbmNlIGNo
ZWNrLCB0byBlbnN1cmUgcGFja2V0cyBhcmUgYmVpbmc8YnI+DQorwqAgwqAgwqAgwqAgcmVjZWl2
ZWQgdW5kZXIgbm9ybWFsIGNpcmN1bXN0YW5jZXMuPGJyPg0KK8KgIMKgIMKgIMKgICZxdW90OyZx
dW90OyZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCBwYWNrZXRfbGlzdCA9IFs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgRXRoZXIoc3JjPSZxdW90OzAyOjAwOjAwOjAwOjAwOjAwJnF1b3Q7KSAvIFJh
dyhsb2FkPSZxdW90O3h4eHh4JnF1b3Q7KSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgRXRoZXIo
ZHN0PSZxdW90OzAyOjAwOjAwOjAwOjAwOjAwJnF1b3Q7KSAvIFJhdyhsb2FkPSZxdW90O3h4eHh4
JnF1b3Q7KSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgRXRoZXIodHlwZT0weDA4MDApIC8gUmF3
KGxvYWQ9JnF1b3Q7eHh4eHgmcXVvdDspLDxicj4NCivCoCDCoCDCoCDCoCBdPGJyPg0KK8KgIMKg
IMKgIMKgIGZsb3dfbGlzdCA9IFs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgRmxvd1J1bGUoPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRpcmVjdGlvbj0mcXVvdDtpbmdyZXNzJnF1b3Q7
LCBwYXR0ZXJuPVsmcXVvdDtldGggc3JjIGlzIDAyOjAwOjAwOjAwOjAwOjAwJnF1b3Q7XSwgYWN0
aW9ucz1bJnF1b3Q7ZHJvcCZxdW90O108YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgKSw8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgRmxvd1J1bGUoPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGRpcmVjdGlvbj0mcXVvdDtpbmdyZXNzJnF1b3Q7LCBwYXR0ZXJuPVsmcXVvdDtldGggZHN0IGlz
IDAyOjAwOjAwOjAwOjAwOjAwJnF1b3Q7XSwgYWN0aW9ucz1bJnF1b3Q7ZHJvcCZxdW90O108YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgRmxvd1J1bGUo
ZGlyZWN0aW9uPSZxdW90O2luZ3Jlc3MmcXVvdDssIHBhdHRlcm49WyZxdW90O2V0aCB0eXBlIGlz
IDB4MDgwMCZxdW90O10sIGFjdGlvbnM9WyZxdW90O2Ryb3AmcXVvdDtdKSw8YnI+DQorwqAgwqAg
wqAgwqAgXTxicj4NCivCoCDCoCDCoCDCoCAjIHZlcmlmeSByZWNlcHRpb24gd2l0aCB0ZXN0IHBh
Y2tldDxicj4NCivCoCDCoCDCoCDCoCBwYWNrZXQgPSBFdGhlcigpIC8gSVAoKSAvIFJhdyhsb2Fk
PSZxdW90O3h4eHh4JnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCB3aXRoIFRlc3RQbWRTaGVsbCgp
IGFzIHRlc3RwbWQ6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHRlc3RwbWQuc3RhcnQoKTxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCByZWNlaXZlZCA9IHNlbGYuc2VuZF9wYWNrZXRfYW5kX2NhcHR1
cmUocGFja2V0KTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBzZWxmLnZlcmlmeShyZWNlaXZlZCAh
PSBbXSwgJnF1b3Q7VGVzdCBwYWNrZXQgd2FzIG5ldmVyIHJlY2VpdmVkLiZxdW90Oyk8YnI+DQor
wqAgwqAgwqAgwqAgc2VsZi5ydW5uZXIoPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHZlcmlmaWNh
dGlvbl9tZXRob2Q9c2VsZi5zZW5kX3BhY2tldF9hbmRfdmVyaWZ5LDxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCBmbG93cz1mbG93X2xpc3QsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHBhY2tldHM9
cGFja2V0X2xpc3QsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHBvcnRfaWQ9MCw8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgc2hvdWxkX3JlY2VpdmU9RmFsc2UsPGJyPg0KK8KgIMKgIMKgIMKgICk8
YnI+DQorPGJyPg0KK8KgIMKgIEBmdW5jX3Rlc3Q8YnI+DQorwqAgwqAgZGVmIHRlc3RfZHJvcF9h
Y3Rpb25fSVAoc2VsZikgLSZndDsgTm9uZTo8YnI+DQorwqAgwqAgwqAgwqAgJnF1b3Q7JnF1b3Q7
JnF1b3Q7VmFsaWRhdGUgZmxvdyBydWxlcyB3aXRoIGRyb3AgYWN0aW9ucyBhbmQgZXRoZXJuZXQg
cGF0dGVybnMuPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCBTdGVwczo8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgQ3JlYXRlIGEgbGlzdCBvZiBwYWNrZXRzIHRvIHRlc3QsIHdpdGggYSBjb3JyZXNw
b25kaW5nIGZsb3cgbGlzdC48YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgTGF1bmNoIHRlc3RwbWQu
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIENyZWF0ZSBmaXJzdCBmbG93IHJ1bGUgaW4gZmxvdyBs
aXN0Ljxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBTZW5kIGZpcnN0IHBhY2tldCBpbiBwYWNrZXQg
bGlzdCwgY2FwdHVyZSB2ZXJib3NlIG91dHB1dC48YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgRGVs
ZXRlIGZsb3cgcnVsZSwgcmVwZWF0IGZvciBhbGwgZmxvd3MvcGFja2V0cy48YnI+DQorPGJyPg0K
K8KgIMKgIMKgIMKgIFZlcmlmeTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgQ2hlY2sgdGhhdCBl
YWNoIHBhY2tldCBpcyBkcm9wcGVkLjxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgT25lIHBhY2tl
dCB3aWxsIGJlIHNlbnQgYXMgYSBjb25maWRlbmNlIGNoZWNrLCB0byBlbnN1cmUgcGFja2V0cyBh
cmUgYmVpbmc8YnI+DQorwqAgwqAgwqAgwqAgcmVjZWl2ZWQgdW5kZXIgbm9ybWFsIGNpcmN1bXN0
YW5jZXMuPGJyPg0KK8KgIMKgIMKgIMKgICZxdW90OyZxdW90OyZxdW90Ozxicj4NCivCoCDCoCDC
oCDCoCBwYWNrZXRfbGlzdCA9IFs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgRXRoZXIoKSAvIElQ
KHNyYz0mcXVvdDsxOTIuMTY4LjEuMSZxdW90OykgLyBSYXcobG9hZD0mcXVvdDt4eHh4eCZxdW90
OyksPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIEV0aGVyKCkgLyBJUChkc3Q9JnF1b3Q7MTkyLjE2
OC4xLjEmcXVvdDspIC8gUmF3KGxvYWQ9JnF1b3Q7eHh4eHgmcXVvdDspLDxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCBFdGhlcigpIC8gSVAodHRsPTY0KSAvIFJhdyhsb2FkPSZxdW90O3h4eHh4JnF1
b3Q7KSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgRXRoZXIoKSAvIElQdjYoc3JjPSZxdW90OzIw
MDE6ZGI4OjoxJnF1b3Q7KSAvIFJhdyhsb2FkPSZxdW90O3h4eHh4JnF1b3Q7KSw8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgRXRoZXIoKSAvIElQdjYoZHN0PSZxdW90OzIwMDE6ZGI4OjoxJnF1b3Q7
KSAvIFJhdyhsb2FkPSZxdW90O3h4eHh4JnF1b3Q7KSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
RXRoZXIoKSAvIElQdjYoKSAvIFVEUCgpIC8gUmF3KGxvYWQ9JnF1b3Q7eHh4eHgmcXVvdDspLDxi
cj4NCivCoCDCoCDCoCDCoCBdPGJyPg0KK8KgIMKgIMKgIMKgIGZsb3dfbGlzdCA9IFs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgRmxvd1J1bGUoPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGRpcmVjdGlvbj0mcXVvdDtpbmdyZXNzJnF1b3Q7LCBwYXR0ZXJuPVsmcXVvdDtldGggLyBpcHY0
IHNyYyBpcyAxOTIuMTY4LjEuMSZxdW90O10sIGFjdGlvbnM9WyZxdW90O2Ryb3AmcXVvdDtdPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgICksPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIEZsb3dSdWxl
KDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkaXJlY3Rpb249JnF1b3Q7aW5ncmVzcyZx
dW90OywgcGF0dGVybj1bJnF1b3Q7ZXRoIC8gaXB2NCBkc3QgaXMgMTkyLjE2OC4xLjEmcXVvdDtd
LCBhY3Rpb25zPVsmcXVvdDtkcm9wJnF1b3Q7XTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCApLDxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCBGbG93UnVsZShkaXJlY3Rpb249JnF1b3Q7aW5ncmVzcyZx
dW90OywgcGF0dGVybj1bJnF1b3Q7ZXRoIC8gaXB2NCB0dGwgaXMgNjQmcXVvdDtdLCBhY3Rpb25z
PVsmcXVvdDtkcm9wJnF1b3Q7XSksPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIEZsb3dSdWxlKDxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkaXJlY3Rpb249JnF1b3Q7aW5ncmVzcyZxdW90
OywgcGF0dGVybj1bJnF1b3Q7ZXRoIC8gaXB2NiBzcmMgaXMgMjAwMTpkYjg6OjEmcXVvdDtdLCBh
Y3Rpb25zPVsmcXVvdDtkcm9wJnF1b3Q7XTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCApLDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCBGbG93UnVsZSg8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgZGlyZWN0aW9uPSZxdW90O2luZ3Jlc3MmcXVvdDssIHBhdHRlcm49WyZxdW90O2V0aCAvIGlw
djYgZHN0IGlzIDIwMDE6ZGI4OjoyJnF1b3Q7XSwgYWN0aW9ucz1bJnF1b3Q7ZHJvcCZxdW90O108
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgRmxvd1J1
bGUoZGlyZWN0aW9uPSZxdW90O2luZ3Jlc3MmcXVvdDssIHBhdHRlcm49WyZxdW90O2V0aCAvIGlw
djYgcHJvdG8gaXMgMTcmcXVvdDtdLCBhY3Rpb25zPVsmcXVvdDtkcm9wJnF1b3Q7XSksPGJyPg0K
K8KgIMKgIMKgIMKgIF08YnI+DQorwqAgwqAgwqAgwqAgIyB2ZXJpZnkgcmVjZXB0aW9uIHdpdGgg
dGVzdCBwYWNrZXQ8YnI+DQorwqAgwqAgwqAgwqAgcGFja2V0ID0gRXRoZXIoKSAvIElQKCkgLyBS
YXcobG9hZD0mcXVvdDt4eHh4eCZxdW90Oyk8YnI+DQorwqAgwqAgwqAgwqAgd2l0aCBUZXN0UG1k
U2hlbGwoKSBhcyB0ZXN0cG1kOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCB0ZXN0cG1kLnN0YXJ0
KCk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcmVjZWl2ZWQgPSBzZWxmLnNlbmRfcGFja2V0X2Fu
ZF9jYXB0dXJlKHBhY2tldCk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgc2VsZi52ZXJpZnkocmVj
ZWl2ZWQgIT0gW10sICZxdW90O1Rlc3QgcGFja2V0IHdhcyBuZXZlciByZWNlaXZlZC4mcXVvdDsp
PGJyPg0KK8KgIMKgIMKgIMKgIHNlbGYucnVubmVyKDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCB2
ZXJpZmljYXRpb25fbWV0aG9kPXNlbGYuc2VuZF9wYWNrZXRfYW5kX3ZlcmlmeSw8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgZmxvd3M9Zmxvd19saXN0LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBw
YWNrZXRzPXBhY2tldF9saXN0LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBwb3J0X2lkPTAsPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIHNob3VsZF9yZWNlaXZlPUZhbHNlLDxicj4NCivCoCDCoCDC
oCDCoCApPGJyPg0KKzxicj4NCivCoCDCoCBAZnVuY190ZXN0PGJyPg0KK8KgIMKgIGRlZiB0ZXN0
X2Ryb3BfYWN0aW9uX0w0KHNlbGYpIC0mZ3Q7IE5vbmU6PGJyPg0KK8KgIMKgIMKgIMKgICZxdW90
OyZxdW90OyZxdW90O1ZhbGlkYXRlIGZsb3cgcnVsZXMgd2l0aCBkcm9wIGFjdGlvbnMgYW5kIGV0
aGVybmV0IHBhdHRlcm5zLjxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgU3RlcHM6PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIENyZWF0ZSBhIGxpc3Qgb2YgcGFja2V0cyB0byB0ZXN0LCB3aXRoIGEg
Y29ycmVzcG9uZGluZyBmbG93IGxpc3QuPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIExhdW5jaCB0
ZXN0cG1kLjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBDcmVhdGUgZmlyc3QgZmxvdyBydWxlIGlu
IGZsb3cgbGlzdC48YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgU2VuZCBmaXJzdCBwYWNrZXQgaW4g
cGFja2V0IGxpc3QsIGNhcHR1cmUgdmVyYm9zZSBvdXRwdXQuPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIERlbGV0ZSBmbG93IHJ1bGUsIHJlcGVhdCBmb3IgYWxsIGZsb3dzL3BhY2tldHMuPGJyPg0K
Kzxicj4NCivCoCDCoCDCoCDCoCBWZXJpZnk6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIENoZWNr
IHRoYXQgZWFjaCBwYWNrZXQgaXMgZHJvcHBlZC48YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIE9u
ZSBwYWNrZXQgd2lsbCBiZSBzZW50IGFzIGEgY29uZmlkZW5jZSBjaGVjaywgdG8gZW5zdXJlIHBh
Y2tldHMgYXJlIGJlaW5nPGJyPg0KK8KgIMKgIMKgIMKgIHJlY2VpdmVkIHVuZGVyIG5vcm1hbCBj
aXJjdW1zdGFuY2VzLjxicj4NCivCoCDCoCDCoCDCoCAmcXVvdDsmcXVvdDsmcXVvdDs8YnI+DQor
wqAgwqAgwqAgwqAgcGFja2V0X2xpc3QgPSBbPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIEV0aGVy
KCkgLyBJUCgpIC8gVENQKHNwb3J0PTEyMzQpIC8gUmF3KGxvYWQ9JnF1b3Q7eHh4eHgmcXVvdDsp
LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBFdGhlcigpIC8gSVAoKSAvIFRDUChkcG9ydD04MCkg
LyBSYXcobG9hZD0mcXVvdDt4eHh4eCZxdW90OyksPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIEV0
aGVyKCkgLyBJUCgpIC8gVENQKGZsYWdzPTB4MDIpIC8gUmF3KGxvYWQ9JnF1b3Q7eHh4eHgmcXVv
dDspLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBFdGhlcigpIC8gSVAoKSAvIFVEUChzcG9ydD01
MDAwKSAvIFJhdyhsb2FkPSZxdW90O3h4eHh4JnF1b3Q7KSw8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgRXRoZXIoKSAvIElQKCkgLyBVRFAoZHBvcnQ9NTMpIC8gUmF3KGxvYWQ9JnF1b3Q7eHh4eHgm
cXVvdDspLDxicj4NCivCoCDCoCDCoCDCoCBdPGJyPg0KK8KgIMKgIMKgIMKgIGZsb3dfbGlzdCA9
IFs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgRmxvd1J1bGUoPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIGRpcmVjdGlvbj0mcXVvdDtpbmdyZXNzJnF1b3Q7LCBwYXR0ZXJuPVsmcXVvdDtl
dGggLyBpcHY0IC8gdGNwIHNyYyBpcyAxMjM0JnF1b3Q7XSwgYWN0aW9ucz1bJnF1b3Q7ZHJvcCZx
dW90O108YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
Rmxvd1J1bGUoZGlyZWN0aW9uPSZxdW90O2luZ3Jlc3MmcXVvdDssIHBhdHRlcm49WyZxdW90O2V0
aCAvIGlwdjQgLyB0Y3AgZHN0IGlzIDgwJnF1b3Q7XSwgYWN0aW9ucz1bJnF1b3Q7ZHJvcCZxdW90
O10pLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBGbG93UnVsZSg8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgZGlyZWN0aW9uPSZxdW90O2luZ3Jlc3MmcXVvdDssIHBhdHRlcm49WyZxdW90
O2V0aCAvIGlwdjQgLyB0Y3AgZmxhZ3MgaXMgMHgwMiZxdW90O10sIGFjdGlvbnM9WyZxdW90O2Ry
b3AmcXVvdDtdPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgICksPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIEZsb3dSdWxlKDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkaXJlY3Rpb249JnF1
b3Q7aW5ncmVzcyZxdW90OywgcGF0dGVybj1bJnF1b3Q7ZXRoIC8gaXB2NCAvIHVkcCBzcmMgaXMg
NTAwMCZxdW90O10sIGFjdGlvbnM9WyZxdW90O2Ryb3AmcXVvdDtdPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgICksPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIEZsb3dSdWxlKGRpcmVjdGlvbj0mcXVv
dDtpbmdyZXNzJnF1b3Q7LCBwYXR0ZXJuPVsmcXVvdDtldGggLyBpcHY0IC8gdWRwIGRzdCBpcyA1
MyZxdW90O10sIGFjdGlvbnM9WyZxdW90O2Ryb3AmcXVvdDtdKSw8YnI+DQorwqAgwqAgwqAgwqAg
XTxicj4NCivCoCDCoCDCoCDCoCAjIHZlcmlmeSByZWNlcHRpb24gd2l0aCB0ZXN0IHBhY2tldDxi
cj4NCivCoCDCoCDCoCDCoCBwYWNrZXQgPSBFdGhlcigpIC8gSVAoKSAvIFJhdyhsb2FkPSZxdW90
O3h4eHh4JnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCB3aXRoIFRlc3RQbWRTaGVsbCgpIGFzIHRl
c3RwbWQ6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHRlc3RwbWQuc3RhcnQoKTxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCByZWNlaXZlZCA9IHNlbGYuc2VuZF9wYWNrZXRfYW5kX2NhcHR1cmUocGFj
a2V0KTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBzZWxmLnZlcmlmeShyZWNlaXZlZCAhPSBbXSwg
JnF1b3Q7VGVzdCBwYWNrZXQgd2FzIG5ldmVyIHJlY2VpdmVkLiZxdW90Oyk8YnI+DQorwqAgwqAg
wqAgwqAgc2VsZi5ydW5uZXIoPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHZlcmlmaWNhdGlvbl9t
ZXRob2Q9c2VsZi5zZW5kX3BhY2tldF9hbmRfdmVyaWZ5LDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCBmbG93cz1mbG93X2xpc3QsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHBhY2tldHM9cGFja2V0
X2xpc3QsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHBvcnRfaWQ9MCw8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgc2hvdWxkX3JlY2VpdmU9RmFsc2UsPGJyPg0KK8KgIMKgIMKgIMKgICk8YnI+DQor
PGJyPg0KK8KgIMKgIEBmdW5jX3Rlc3Q8YnI+DQorwqAgwqAgZGVmIHRlc3RfZHJvcF9hY3Rpb25f
VkxBTihzZWxmKSAtJmd0OyBOb25lOjxicj4NCivCoCDCoCDCoCDCoCAmcXVvdDsmcXVvdDsmcXVv
dDtWYWxpZGF0ZSBmbG93IHJ1bGVzIHdpdGggZHJvcCBhY3Rpb25zIGFuZCBldGhlcm5ldCBwYXR0
ZXJucy48YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIFN0ZXBzOjxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCBDcmVhdGUgYSBsaXN0IG9mIHBhY2tldHMgdG8gdGVzdCwgd2l0aCBhIGNvcnJlc3BvbmRp
bmcgZmxvdyBsaXN0Ljxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBMYXVuY2ggdGVzdHBtZC48YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgQ3JlYXRlIGZpcnN0IGZsb3cgcnVsZSBpbiBmbG93IGxpc3Qu
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIFNlbmQgZmlyc3QgcGFja2V0IGluIHBhY2tldCBsaXN0
LCBjYXB0dXJlIHZlcmJvc2Ugb3V0cHV0Ljxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBEZWxldGUg
ZmxvdyBydWxlLCByZXBlYXQgZm9yIGFsbCBmbG93cy9wYWNrZXRzLjxicj4NCis8YnI+DQorwqAg
wqAgwqAgwqAgVmVyaWZ5Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBDaGVjayB0aGF0IGVhY2gg
cGFja2V0IGlzIGRyb3BwZWQuPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCBPbmUgcGFja2V0IHdp
bGwgYmUgc2VudCBhcyBhIGNvbmZpZGVuY2UgY2hlY2ssIHRvIGVuc3VyZSBwYWNrZXRzIGFyZSBi
ZWluZzxicj4NCivCoCDCoCDCoCDCoCByZWNlaXZlZCB1bmRlciBub3JtYWwgY2lyY3Vtc3RhbmNl
cy48YnI+DQorwqAgwqAgwqAgwqAgJnF1b3Q7JnF1b3Q7JnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKg
IHBhY2tldF9saXN0ID0gWzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBFdGhlcigpIC8gRG90MVEo
dmxhbj0xMDApIC8gUmF3KGxvYWQ9JnF1b3Q7eHh4eHgmcXVvdDspLDxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCBFdGhlcigpIC8gRG90MVEodHlwZT0weDA4MDApIC8gUmF3KGxvYWQ9JnF1b3Q7eHh4
eHgmcXVvdDspLDxicj4NCivCoCDCoCDCoCDCoCBdPGJyPg0KK8KgIMKgIMKgIMKgIGZsb3dfbGlz
dCA9IFs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgRmxvd1J1bGUoZGlyZWN0aW9uPSZxdW90O2lu
Z3Jlc3MmcXVvdDssIHBhdHRlcm49WyZxdW90O2V0aCAvIHZsYW4mcXVvdDtdLCBhY3Rpb25zPVsm
cXVvdDtkcm9wJnF1b3Q7XSksPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIEZsb3dSdWxlKGRpcmVj
dGlvbj0mcXVvdDtpbmdyZXNzJnF1b3Q7LCBwYXR0ZXJuPVsmcXVvdDtldGggLyB2bGFuJnF1b3Q7
XSwgYWN0aW9ucz1bJnF1b3Q7ZHJvcCZxdW90O10pLDxicj4NCivCoCDCoCDCoCDCoCBdPGJyPg0K
K8KgIMKgIMKgIMKgICMgdmVyaWZ5IHJlY2VwdGlvbiB3aXRoIHRlc3QgcGFja2V0PGJyPg0KK8Kg
IMKgIMKgIMKgIHBhY2tldCA9IEV0aGVyKCkgLyBJUCgpIC8gUmF3KGxvYWQ9JnF1b3Q7eHh4eHgm
cXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIHdpdGggVGVzdFBtZFNoZWxsKCkgYXMgdGVzdHBtZDo8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgdGVzdHBtZC5zdGFydCgpPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIHJlY2VpdmVkID0gc2VsZi5zZW5kX3BhY2tldF9hbmRfY2FwdHVyZShwYWNrZXQpPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIHNlbGYudmVyaWZ5KHJlY2VpdmVkICE9IFtdLCAmcXVvdDtU
ZXN0IHBhY2tldCB3YXMgbmV2ZXIgcmVjZWl2ZWQuJnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCBz
ZWxmLnJ1bm5lcig8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgdmVyaWZpY2F0aW9uX21ldGhvZD1z
ZWxmLnNlbmRfcGFja2V0X2FuZF92ZXJpZnksPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIGZsb3dz
PWZsb3dfbGlzdCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcGFja2V0cz1wYWNrZXRfbGlzdCw8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcG9ydF9pZD0wLDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCBzaG91bGRfcmVjZWl2ZT1GYWxzZSw8YnI+DQorwqAgwqAgwqAgwqAgKTxicj4NCis8YnI+DQor
wqAgwqAgQGZ1bmNfdGVzdDxicj4NCivCoCDCoCBkZWYgdGVzdF9tb2RpZnlfYWN0aW9ucyhzZWxm
KSAtJmd0OyBOb25lOjxicj4NCivCoCDCoCDCoCDCoCAmcXVvdDsmcXVvdDsmcXVvdDtWYWxpZGF0
ZSBmbG93IHJ1bGVzIHdpdGggYWN0aW9ucyB0aGF0IG1vZGlmeSB0aGF0IHBhY2tldCBkdXJpbmcg
dHJhbnNtaXNzaW9uLjxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgU3RlcHM6PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIENyZWF0ZSBhIGxpc3Qgb2YgcGFja2V0cyB0byB0ZXN0LCB3aXRoIGEgY29y
cmVzcG9uZGluZyBmbG93IGxpc3QuPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIExhdW5jaCB0ZXN0
cG1kLjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBDcmVhdGUgZmlyc3QgZmxvdyBydWxlIGluIGZs
b3cgbGlzdC48YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgU2VuZCBmaXJzdCBwYWNrZXQgaW4gcGFj
a2V0IGxpc3QsIGNhcHR1cmUgdmVyYm9zZSBvdXRwdXQuPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IERlbGV0ZSBmbG93IHJ1bGUsIHJlcGVhdCBmb3IgYWxsIGZsb3dzL3BhY2tldHMuPGJyPg0KKzxi
cj4NCivCoCDCoCDCoCDCoCBWZXJpZnk6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIFZlcmlmeSBw
YWNrZXQgaXMgcmVjZWl2ZWQgd2l0aCB0aGUgbmV3IGF0dHJpYnV0ZXMuPGJyPg0KK8KgIMKgIMKg
IMKgICZxdW90OyZxdW90OyZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCBwYWNrZXRfbGlzdCA9IFtF
dGhlcigpIC8gSVAoc3JjPSZxdW90OzE5Mi42OC4xLjEmcXVvdDspLCBFdGhlcihzcmM9JnF1b3Q7
MDI6MDA6MDA6MDA6MDA6MDAmcXVvdDspXTxicj4NCivCoCDCoCDCoCDCoCBmbG93X2xpc3QgPSBb
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgICMgcnVsZSB0byBjb3B5IElQdjQgc3JjIHRvIElQdjQg
ZHN0PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIEZsb3dSdWxlKDxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBkaXJlY3Rpb249JnF1b3Q7aW5ncmVzcyZxdW90Oyw8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgZ3JvdXBfaWQ9MSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
cGF0dGVybj1bJnF1b3Q7ZXRoJnF1b3Q7XSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
YWN0aW9ucz1bPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZxdW90O21vZGlm
eV9maWVsZCBvcCBzZXQgZHN0X3R5cGUgaXB2NF9kc3Qgc3JjX3R5cGUgaXB2NF9zcmMgd2lkdGgg
MzImcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7IC8gcXVl
dWUgaW5kZXggMCZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBdLDxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCApLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCAjIHJ1bGUgdG8gY29w
eSBzcmMgTUFDIHRvIGRzdCBNQUM8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgRmxvd1J1bGUoPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRpcmVjdGlvbj0mcXVvdDtpbmdyZXNzJnF1b3Q7
LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBncm91cF9pZD0xLDxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBwYXR0ZXJuPVsmcXVvdDtldGgmcXVvdDtdLDxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBhY3Rpb25zPVs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgJnF1b3Q7bW9kaWZ5X2ZpZWxkIG9wIHNldCBkc3RfdHlwZSBtYWNfZHN0IHNyY190eXBl
IG1hY19zcmMgd2lkdGggNDggLyBxdWV1ZSBpbmRleCAwJnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIF0sPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgICksPGJyPg0KK8KgIMKgIMKg
IMKgIF08YnI+DQorwqAgwqAgwqAgwqAgZXhwZWN0ZWRfcGFja2V0X2xpc3QgPSBbRXRoZXIoKSAv
IElQKGRzdD0mcXVvdDsxOTIuNjguMS4xJnF1b3Q7KSwgRXRoZXIoZHN0PSZxdW90OzAyOjAwOjAw
OjAwOjAwOjAwJnF1b3Q7KV08YnI+DQorwqAgwqAgwqAgwqAgc2VsZi5ydW5uZXIoPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIHZlcmlmaWNhdGlvbl9tZXRob2Q9c2VsZi5zZW5kX3BhY2tldF9hbmRf
dmVyaWZ5X21vZGlmaWNhdGlvbiw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgZmxvd3M9Zmxvd19s
aXN0LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBwYWNrZXRzPXBhY2tldF9saXN0LDxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCBwb3J0X2lkPTAsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIGV4cGVj
dGVkX3BhY2tldHM9ZXhwZWN0ZWRfcGFja2V0X2xpc3QsPGJyPg0KK8KgIMKgIMKgIMKgICk8YnI+
DQorPGJyPg0KK8KgIMKgIEBmdW5jX3Rlc3Q8YnI+DQorwqAgwqAgZGVmIHRlc3RfZWdyZXNzX3J1
bGVzKHNlbGYpIC0mZ3Q7IE5vbmU6PGJyPg0KK8KgIMKgIMKgIMKgICZxdW90OyZxdW90OyZxdW90
O1ZhbGlkYXRlIGZsb3cgcnVsZXMgd2l0aCBlZ3Jlc3MgZGlyZWN0aW9ucy48YnI+DQorPGJyPg0K
K8KgIMKgIMKgIMKgIFN0ZXBzOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBDcmVhdGUgYSBsaXN0
IG9mIHBhY2tldHMgdG8gdGVzdCwgd2l0aCBhIGNvcnJlc3BvbmRpbmcgZmxvdyBsaXN0Ljxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCBMYXVuY2ggdGVzdHBtZC48YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgQ3JlYXRlIGZpcnN0IGZsb3cgcnVsZSBpbiBmbG93IGxpc3QuPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIFNlbmQgZmlyc3QgcGFja2V0IGluIHBhY2tldCBsaXN0LCBjYXB0dXJlIHZlcmJvc2Ug
b3V0cHV0Ljxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBEZWxldGUgZmxvdyBydWxlLCByZXBlYXQg
Zm9yIGFsbCBmbG93cy9wYWNrZXRzLjxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgVmVyaWZ5Ojxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCBDaGVjayB0aGF0IGVhY2ggcGFja2V0IGlzIGRyb3BwZWQu
PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCBPbmUgcGFja2V0IHdpbGwgYmUgc2VudCBhcyBhIGNv
bmZpZGVuY2UgY2hlY2ssIHRvIGVuc3VyZSBwYWNrZXRzIGFyZSBiZWluZzxicj4NCivCoCDCoCDC
oCDCoCByZWNlaXZlZCB1bmRlciBub3JtYWwgY2lyY3Vtc3RhbmNlcy48YnI+DQorwqAgwqAgwqAg
wqAgJnF1b3Q7JnF1b3Q7JnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKgIHBhY2tldF9saXN0ID0gWzxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCBFdGhlcihzcmM9JnF1b3Q7MDI6MDA6MDA6MDA6MDA6MDAm
cXVvdDspLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBFdGhlcigpIC8gSVAoc3JjPSZxdW90OzE5
Mi4xNjguMS4xJnF1b3Q7KSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgSVAoKSAvIFRDUChzcG9y
dD0xMjM0KSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgSVAoKSAvIFVEUChzcG9ydD01MDAwKSw8
YnI+DQorwqAgwqAgwqAgwqAgXTxicj4NCivCoCDCoCDCoCDCoCBmbG93X2xpc3QgPSBbPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIEZsb3dSdWxlKDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBkaXJlY3Rpb249JnF1b3Q7ZWdyZXNzJnF1b3Q7LCBwYXR0ZXJuPVsmcXVvdDtldGggc3JjIGlz
IDAyOjAwOjAwOjAwOjAwOjAwJnF1b3Q7XSwgYWN0aW9ucz1bJnF1b3Q7ZHJvcCZxdW90O108YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgRmxvd1J1bGUo
ZGlyZWN0aW9uPSZxdW90O2VncmVzcyZxdW90OywgcGF0dGVybj1bJnF1b3Q7aXB2NCBzcmMgaXMg
MTkyLjE2OC4xLjEmcXVvdDtdLCBhY3Rpb25zPVsmcXVvdDtkcm9wJnF1b3Q7XSksPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIEZsb3dSdWxlKGRpcmVjdGlvbj0mcXVvdDtlZ3Jlc3MmcXVvdDssIHBh
dHRlcm49WyZxdW90O3RjcCBzcmMgaXMgMTIzNCZxdW90O10sIGFjdGlvbnM9WyZxdW90O2Ryb3Am
cXVvdDtdKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgRmxvd1J1bGUoZGlyZWN0aW9uPSZxdW90
O2VncmVzcyZxdW90OywgcGF0dGVybj1bJnF1b3Q7dWRwIHNyYyBpcyA1MDAwJnF1b3Q7XSwgYWN0
aW9ucz1bJnF1b3Q7ZHJvcCZxdW90O10pLDxicj4NCivCoCDCoCDCoCDCoCBdPGJyPg0KK8KgIMKg
IMKgIMKgICMgdmVyaWZ5IHJlY2VwdGlvbiB3aXRoIHRlc3QgcGFja2V0PGJyPg0KK8KgIMKgIMKg
IMKgIHBhY2tldCA9IEV0aGVyKCkgLyBJUCgpIC8gUmF3KGxvYWQ9JnF1b3Q7eHh4eHgmcXVvdDsp
PGJyPg0KK8KgIMKgIMKgIMKgIHdpdGggVGVzdFBtZFNoZWxsKCkgYXMgdGVzdHBtZDo8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgdGVzdHBtZC5zdGFydCgpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IHJlY2VpdmVkID0gc2VsZi5zZW5kX3BhY2tldF9hbmRfY2FwdHVyZShwYWNrZXQpPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIHNlbGYudmVyaWZ5KHJlY2VpdmVkICE9IFtdLCAmcXVvdDtUZXN0IHBh
Y2tldCB3YXMgbmV2ZXIgcmVjZWl2ZWQuJnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCBzZWxmLnJ1
bm5lcig8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgdmVyaWZpY2F0aW9uX21ldGhvZD1zZWxmLnNl
bmRfcGFja2V0X2FuZF92ZXJpZnksPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIGZsb3dzPWZsb3df
bGlzdCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcGFja2V0cz1wYWNrZXRfbGlzdCw8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgcG9ydF9pZD0xLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBzaG91
bGRfcmVjZWl2ZT1GYWxzZSw8YnI+DQorwqAgwqAgwqAgwqAgKTxicj4NCis8YnI+DQorwqAgwqAg
QGZ1bmNfdGVzdDxicj4NCivCoCDCoCBkZWYgdGVzdF9qdW1wX2FjdGlvbihzZWxmKSAtJmd0OyBO
b25lOjxicj4NCivCoCDCoCDCoCDCoCAmcXVvdDsmcXVvdDsmcXVvdDtWYWxpZGF0ZSBmbG93IHJ1
bGVzIHdpdGggZGlmZmVyZW50IGdyb3VwIGxldmVscyBhbmQganVtcCBhY3Rpb25zLjxicj4NCis8
YnI+DQorwqAgwqAgwqAgwqAgU3RlcHM6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIENyZWF0ZSBh
IGxpc3Qgb2YgcGFja2V0cyB0byB0ZXN0LCB3aXRoIGEgY29ycmVzcG9uZGluZyBmbG93IGxpc3Qu
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIExhdW5jaCB0ZXN0cG1kIHdpdGggdGhlIG5lY2Vzc2Fy
eSBjb25maWd1cmF0aW9uLjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBDcmVhdGUgZWFjaCBmbG93
IHJ1bGUgaW4gdGVzdHBtZC48YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgU2VuZCBlYWNoIHBhY2tl
dCBpbiB0aGUgbGlzdCwgY2hlY2sgUnggcXVldWUgSUQuPGJyPg0KKzxicj4NCivCoCDCoCDCoCDC
oCBWZXJpZnk6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIENoZWNrIHRoYXQgZWFjaCBwYWNrZXQg
aXMgcmVjZWl2ZWQgb24gdGhlIGFwcHJvcHJpYXRlIFJ4IHF1ZXVlLjxicj4NCivCoCDCoCDCoCDC
oCAmcXVvdDsmcXVvdDsmcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgcGFja2V0X2xpc3QgPSBbRXRo
ZXIoKSAvIElQKCksIEV0aGVyKCkgLyBJUCgpIC8gVENQKCksIEV0aGVyKCkgLyBJUCgpIC8gVURQ
KCldPGJyPg0KK8KgIMKgIMKgIMKgIGZsb3dfbGlzdCA9IFs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgRmxvd1J1bGUoPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRpcmVjdGlvbj0mcXVv
dDtpbmdyZXNzJnF1b3Q7LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBncm91cF9pZD0w
LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwYXR0ZXJuPVsmcXVvdDtldGggLyBpcHY0
IC8gdGNwJnF1b3Q7XSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYWN0aW9ucz1bJnF1
b3Q7anVtcCBncm91cCAxJnF1b3Q7XSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgKSw8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgRmxvd1J1bGUoPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGRpcmVjdGlvbj0mcXVvdDtpbmdyZXNzJnF1b3Q7LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBncm91cF9pZD0wLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwYXR0ZXJuPVsm
cXVvdDtldGggLyBpcHY0IC8gdWRwJnF1b3Q7XSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgYWN0aW9ucz1bJnF1b3Q7anVtcCBncm91cCAyJnF1b3Q7XSw8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgRmxvd1J1bGUoPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGRpcmVjdGlvbj0mcXVvdDtpbmdyZXNzJnF1b3Q7LDxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBncm91cF9pZD0xLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBwYXR0ZXJuPVsmcXVvdDtldGggLyBpcHY0IC8gdGNwJnF1b3Q7XSw8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgYWN0aW9ucz1bJnF1b3Q7cXVldWUgaW5kZXggMiZxdW90O10sPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgICksPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIEZsb3dSdWxl
KDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkaXJlY3Rpb249JnF1b3Q7aW5ncmVzcyZx
dW90Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ3JvdXBfaWQ9Miw8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgcGF0dGVybj1bJnF1b3Q7ZXRoIC8gaXB2NCAvIHVkcCZxdW90
O10sPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGFjdGlvbnM9WyZxdW90O3F1ZXVlIGlu
ZGV4IDMmcXVvdDtdLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCApLDxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCBGbG93UnVsZSg8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGlyZWN0aW9u
PSZxdW90O2luZ3Jlc3MmcXVvdDssPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdyb3Vw
X2lkPTAsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHBhdHRlcm49WyZxdW90O2V0aCAv
IGlwdjQmcXVvdDtdLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBhY3Rpb25zPVsmcXVv
dDtxdWV1ZSBpbmRleCAxJnF1b3Q7XSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgKSw8YnI+DQor
wqAgwqAgwqAgwqAgXTxicj4NCivCoCDCoCDCoCDCoCBleHBlY3RlZF9xdWV1ZV9saXN0ID0gWzEs
IDIsIDNdPGJyPg0KK8KgIMKgIMKgIMKgIHdpdGggVGVzdFBtZFNoZWxsKHJ4X3F1ZXVlcz00LCB0
eF9xdWV1ZXM9NCkgYXMgdGVzdHBtZDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgc2VsZi5zZW5k
X3BhY2tldF9hbmRfdmVyaWZ5X2p1bXAoPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHBh
Y2tldHM9cGFja2V0X2xpc3QsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZsb3dfcnVs
ZXM9Zmxvd19saXN0LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0ZXN0X3F1ZXVlcz1l
eHBlY3RlZF9xdWV1ZV9saXN0LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0ZXN0cG1k
PXRlc3RwbWQsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgICk8YnI+DQorPGJyPg0KK8KgIMKgIEBm
dW5jX3Rlc3Q8YnI+DQorwqAgwqAgZGVmIHRlc3RfcHJpb3JpdHlfYXR0cmlidXRlKHNlbGYpIC0m
Z3Q7IE5vbmU6PGJyPg0KK8KgIMKgIMKgIMKgICZxdW90OyZxdW90OyZxdW90O1ZhbGlkYXRlIGZs
b3cgcnVsZXMgd2l0aCBxdWV1ZSBhY3Rpb25zIGFuZCBldGhlcm5ldCBwYXR0ZXJucy48YnI+DQor
PGJyPg0KK8KgIMKgIMKgIMKgIFN0ZXBzOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBDcmVhdGUg
YSBsaXN0IG9mIHBhY2tldHMgdG8gdGVzdCwgd2l0aCBhIGNvcnJlc3BvbmRpbmcgZmxvdyBsaXN0
Ljxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBMYXVuY2ggdGVzdHBtZC48YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgQ3JlYXRlIGZpcnN0IGZsb3cgcnVsZSBpbiBmbG93IGxpc3QuPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIFNlbmQgZmlyc3QgcGFja2V0IGluIHBhY2tldCBsaXN0LCBjYXB0dXJlIHZl
cmJvc2Ugb3V0cHV0Ljxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBEZWxldGUgZmxvdyBydWxlLCBy
ZXBlYXQgZm9yIGFsbCBmbG93cy9wYWNrZXRzLjxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgVmVy
aWZ5Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBDaGVjayB0aGF0IGVhY2ggcGFja2V0IGlzIHJl
Y2VpdmVkIG9uIHRoZSBhcHByb3ByaWF0ZSBxdWV1ZS48YnI+DQorwqAgwqAgwqAgwqAgJnF1b3Q7
JnF1b3Q7JnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKgIHRlc3RfcGFja2V0ID0gRXRoZXIoKSAvIElQ
KCkgLyBSYXcoKTxicj4NCivCoCDCoCDCoCDCoCBmbG93X2xpc3QgPSBbPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIEZsb3dSdWxlKDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkaXJlY3Rp
b249JnF1b3Q7aW5ncmVzcyZxdW90Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcHJp
b3JpdHlfbGV2ZWw9Myw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcGF0dGVybj1bJnF1
b3Q7ZXRoIC8gaXB2NCZxdW90O10sPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGFjdGlv
bnM9WyZxdW90O3F1ZXVlIGluZGV4IDEmcXVvdDtdLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCAp
LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBGbG93UnVsZSg8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgZGlyZWN0aW9uPSZxdW90O2luZ3Jlc3MmcXVvdDssPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHByaW9yaXR5X2xldmVsPTIsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHBhdHRlcm49WyZxdW90O2V0aCAvIGlwdjQmcXVvdDtdLDxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBhY3Rpb25zPVsmcXVvdDtxdWV1ZSBpbmRleCAyJnF1b3Q7XSw8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgRmxvd1J1bGUoPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRpcmVjdGlvbj0mcXVvdDtpbmdyZXNzJnF1b3Q7LDxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwcmlvcml0eV9sZXZlbD0xLDxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBwYXR0ZXJuPVsmcXVvdDtldGggLyBpcHY0JnF1b3Q7XSw8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYWN0aW9ucz1bJnF1b3Q7cXVldWUgaW5kZXggMyZx
dW90O10sPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgICksPGJyPg0KK8KgIMKgIMKgIMKgIF08YnI+
DQorwqAgwqAgwqAgwqAgZXhwZWN0ZWRfcXVldWVfbGlzdCA9IFsxLCAyLCAzXTxicj4NCivCoCDC
oCDCoCDCoCB3aXRoIFRlc3RQbWRTaGVsbChyeF9xdWV1ZXM9NCwgdHhfcXVldWVzPTQpIGFzIHRl
c3RwbWQ6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHRlc3RwbWQuc2V0X3ZlcmJvc2UobGV2ZWw9
OCk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgZm9yIGZsb3csIGV4cGVjdGVkX3F1ZXVlIGluIHpp
cChmbG93X2xpc3QsIGV4cGVjdGVkX3F1ZXVlX2xpc3QpOjxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBpc192YWxpZCA9IHRlc3RwbWQuZmxvd192YWxpZGF0ZShmbG93X3J1bGU9Zmxvdywg
cG9ydF9pZD0wKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzZWxmLnZlcmlmeV9lbHNl
X3NraXAoaXNfdmFsaWQsICZxdW90O2Zsb3cgcnVsZSBmYWlsZWQgdmFsaWRhdGlvbi4mcXVvdDsp
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRyeTo8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgdGVzdHBtZC5mbG93X2NyZWF0ZShmbG93X3J1bGU9ZmxvdywgcG9ydF9p
ZD0wKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBleGNlcHQgSW50ZXJhY3RpdmVDb21t
YW5kRXhlY3V0aW9uRXJyb3I6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNl
bGYubG9nKCZxdW90O0Zsb3cgcnVsZSB2YWxpZGF0aW9uIHBhc3NlZCwgYnV0IGZsb3cgY3JlYXRp
b24gZmFpbGVkLiZxdW90Oyk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc2Vs
Zi52ZXJpZnkoRmFsc2UsICZxdW90O0ZhaWxlZCBmbG93IGNyZWF0aW9uJnF1b3Q7KTxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0ZXN0cG1kLnN0YXJ0KCk8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgc2VsZi5zZW5kX3BhY2tldF9hbmRfY2FwdHVyZSh0ZXN0X3BhY2tldCk8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdmVyYm9zZV9vdXRwdXQgPSB0ZXN0cG1kLmV4dHJh
Y3RfdmVyYm9zZV9vdXRwdXQodGVzdHBtZC5zdG9wKCkpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHJlY2VpdmVkID0gRmFsc2U8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZm9y
IHRlc3RwbWRfcGFja2V0IGluIHZlcmJvc2Vfb3V0cHV0Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBpZiB0ZXN0cG1kX3BhY2tldC5xdWV1ZV9pZCA9PSBleHBlY3RlZF9xdWV1
ZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmVjZWl2ZWQgPSBU
cnVlPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNlbGYudmVyaWZ5KHJlY2VpdmVkLCBm
JnF1b3Q7UGFja2V0IHdhcyBub3QgcmVjZWl2ZWQgb24gcXVldWUge2V4cGVjdGVkX3F1ZXVlfSZx
dW90Oyk8YnI+DQotLSA8YnI+DQoyLjQ5LjA8YnI+DQo8YnI+DQo8L2Jsb2NrcXVvdGU+PC9kaXY+
DQo=
--000000000000daba1b0638863165--
