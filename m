Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA05C77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 14:52:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B458B402AE;
	Fri, 27 Jun 2025 16:52:30 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id 87DB6400D5
 for <dev@dpdk.org>; Fri, 27 Jun 2025 16:52:29 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b34a78bb6e7so1788310a12.3
 for <dev@dpdk.org>; Fri, 27 Jun 2025 07:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1751035948; x=1751640748; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cg9E0AXn/bR4O+AXWXkfGBs/PAvDZ8Lt9yaTCkkancQ=;
 b=YpCBv6IsqmE4rsfekQFaHd3DtNkWCjE6wFGcucmk95h8s3S8GPOoF79DNvxpR5Besy
 fimDGEgFBSlbJCmQ/L7jdl0qIsDq1k455HFi8F6RfoakGuATR+WgE2XBBDZbK6Of9+o5
 yPYLy+75kp5ELnR9WVwRIrS1lzpH3yFSnR2Lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751035948; x=1751640748;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cg9E0AXn/bR4O+AXWXkfGBs/PAvDZ8Lt9yaTCkkancQ=;
 b=bZiuyckRaRx02ZuMQY0N/IvKbQL5hAwARRHJm3ADrRXFXzFLWa1Gj1G5r+kEVBm9dv
 dzgP7klHA6HewzWqfNtFD71kwlxeB/fqH1rOHMtSrtm9ZyARjpzhFmWEyRTpQDcxJ7Y7
 DJ3CaGP80uNhT+cdY7eeJJD+n0B6EkILbf1ytswqOaan4QuoNpz61HsFkVH76kM2LJjN
 jKaFjbk2dV3/i4udLGdxnCgypAUdk2MlYJ0AnykTuh03LRCaFWLwxQg9bvcBVkon4lf2
 YIiE2Jox990OKdIIqNGPVI9AQd2d1KvilGu4cTVil40/FTe9kuqHPaidEEhklH685ToS
 TF2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI+L7ezGKkkW8PrGUcXpELfUzrgoKrrBYX3O4cwGbdSgG8C/WrJOgfyOAy3l8YPutAhlM=@dpdk.org
X-Gm-Message-State: AOJu0Yzi6XbhZwTg12xoyvl0P0TRWDu9YJiURFJJMKdLei8H2C1nFMLS
 WiLAEb/IGv8ONdKsrAXw6kWaqjPxzwbOSuh+tkn37NmvJIsbf/TLAsZmJr5EXlBG/kDH8WmD/zt
 4/SG9CMAoxR2e2GWFI8dHn/I5eGXXk7kw6WwLhWU3Pg==
X-Gm-Gg: ASbGncspXnK5qimh6bTy24fxxpMHMs7KWI+N1EmiuzxRi1lZWU2lP4GWgaPZbqlsr86
 eO4/WHQBp1e9prpkFePM7bKE1rM0+EazPNqqNTtuhsymUJu1/DKZYeAeR5e09rPQeA/PV2YF969
 lJYiNHxrnPuS62mSeYjk0s25+gbnvD1PRRbcsWXHnwRekAP1kFr0+yTJL9+vnzuhwX2xsc8nVHe
 Dl5
X-Google-Smtp-Source: AGHT+IEbUkNo/1bzkyXat32zlDDBCduBMMVM7IGI/kqkMq6F0qS5K+3LncuscWk9AMCWgjSfo1M15sBe8ehReCrkYo8=
X-Received: by 2002:a17:90b:5211:b0:311:b413:f5e1 with SMTP id
 98e67ed59e1d1-318c93145acmr4210345a91.32.1751035948400; Fri, 27 Jun 2025
 07:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250521192629.294265-3-dmarx@iol.unh.edu>
 <20250626195617.219395-1-dmarx@iol.unh.edu>
 <CAJvnSUD91p_7DYge3PCy5J3CNPEX3fjy6DD7xLH7inWWHRkCEQ@mail.gmail.com>
In-Reply-To: <CAJvnSUD91p_7DYge3PCy5J3CNPEX3fjy6DD7xLH7inWWHRkCEQ@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 27 Jun 2025 10:46:59 -0400
X-Gm-Features: Ac12FXyOH7Eqm8hSo20a_rpMiUdSpLImJ4oWhNZFcxOMZpY5eZ5oMxN6KmDuzEQ
Message-ID: <CAJvnSUBNRu-Deks-S-aG13r0ckwt5rA8hz90mKwej4fUqpMC3w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dts: add rte flow test suite
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org, 
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
Content-Type: multipart/alternative; boundary="000000000000b19a6806388ed343"
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

--000000000000b19a6806388ed343
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Resolved.

On Fri, Jun 27, 2025 at 10:20=E2=80=AFAM Patrick Robb <probb@iol.unh.edu> w=
rote:

>
>
> On Thu, Jun 26, 2025 at 3:56=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wro=
te:
>
>> Add an RTE Flow API testing suite, which covers some basic
>> synchronous Flow API rules that should be supported across PMDs.
>> This suite will be added to over time, as the Flow API is too large
>> to cover all in one suite, and sending one monolithic series
>> would be impossible.
>>
>> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
>> Reviewed-by: Patrick Robb <probb@iol.unh.edu>
>> ---
>>  doc/api/dts/tests.TestSuite_rte_flow.rst |   8 +
>>  dts/tests/TestSuite_rte_flow.py          | 790 +++++++++++++++++++++++
>>  2 files changed, 798 insertions(+)
>>  create mode 100644 doc/api/dts/tests.TestSuite_rte_flow.rst
>>  create mode 100644 dts/tests/TestSuite_rte_flow.py
>>
>> diff --git a/doc/api/dts/tests.TestSuite_rte_flow.rst
>> b/doc/api/dts/tests.TestSuite_rte_flow.rst
>> new file mode 100644
>> index 0000000000..cad96b2530
>> --- /dev/null
>> +++ b/doc/api/dts/tests.TestSuite_rte_flow.rst
>> @@ -0,0 +1,8 @@
>> +.. SPDX-License-Identifier: BSD-3-Clause
>> +
>> +checksum_offload Test Suite
>>
>
> I'm just seeing this rst misnaming of the testsuite with the docs build
> now. I'm going to update and force push to next-dts.
>
>
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>> +
>> +.. automodule:: tests.TestSuite_rte_flow
>> +   :members:
>> +   :show-inheritance:
>> \ No newline at end of file
>> diff --git a/dts/tests/TestSuite_rte_flow.py
>> b/dts/tests/TestSuite_rte_flow.py
>> new file mode 100644
>> index 0000000000..e70f7ea8d1
>> --- /dev/null
>> +++ b/dts/tests/TestSuite_rte_flow.py
>> @@ -0,0 +1,790 @@
>> +# SPDX-License-Identifier: BSD-3-Clause
>> +# Copyright(c) 2025 University of New Hampshire
>> +
>> +"""RTE Flow testing suite.
>> +
>> +This suite verifies a range of flow rules built using patterns
>> +and actions from the RTE Flow API. It would be impossible to cover
>> +every valid flow rule, but this suite aims to test the most
>> +important and common functionalities across PMDs.
>> +
>> +"""
>> +
>> +from collections.abc import Callable
>> +from itertools import zip_longest
>> +from typing import Any, Iterator, cast
>> +
>> +from scapy.layers.inet import IP, TCP, UDP
>> +from scapy.layers.inet6 import IPv6
>> +from scapy.layers.l2 import Dot1Q, Ether
>> +from scapy.packet import Packet, Raw
>> +
>> +from framework.exception import InteractiveCommandExecutionError
>> +from framework.remote_session.testpmd_shell import FlowRule, TestPmdShe=
ll
>> +from framework.test_suite import TestSuite, func_test
>> +from framework.testbed_model.capability import NicCapability, requires
>> +
>> +
>> +@requires(NicCapability.FLOW_CTRL)
>> +class TestRteFlow(TestSuite):
>> +    """RTE Flow test suite.
>> +
>> +    This suite consists of 12 test cases:
>> +    1. Queue Action Ethernet: Verifies queue actions with ethernet
>> patterns
>> +    2. Queue Action IP: Verifies queue actions with IPv4 and IPv6
>> patterns
>> +    3. Queue Action L4: Verifies queue actions with TCP and UDP pattern=
s
>> +    4. Queue Action VLAN: Verifies queue actions with VLAN patterns
>> +    5. Drop Action Eth: Verifies drop action with ethernet patterns
>> +    6. Drop Action IP: Verifies drop actions with IPV4 and IPv6 pattern=
s
>> +    7. Drop Action L4: Verifies drop actions with TCP and UDP patterns
>> +    8. Drop Action VLAN: Verifies drop actions with VLAN patterns
>> +    9. Modify Field Action: Verifies packet modification patterns
>> +    10. Egress Rules: Verifies previously covered rules are still valid
>> as egress
>> +    11. Jump Action: Verifies packet behavior given grouped flows
>> +    12. Priority Attribute: Verifies packet behavior given flows with
>> different priorities
>> +
>> +    """
>> +
>> +    def runner(
>> +        self,
>> +        verification_method: Callable[..., Any],
>> +        flows: list[FlowRule],
>> +        packets: list[Packet],
>> +        port_id: int,
>> +        expected_packets: list[Packet] | None =3D None,
>> +        *args: Any,
>> +        **kwargs: Any,
>> +    ) -> None:
>> +        """Runner method that validates each flow using the
>> corresponding verification method.
>> +
>> +        Args:
>> +            verification_method: Callable that performs verification
>> logic.
>> +            flows: List of flow rules to create and test.
>> +            packets: List of packets corresponding to each flow.
>> +            port_id: Number representing the port to create flows on.
>> +            expected_packets: List of packets to check sent packets
>> against in modification cases.
>> +            *args: Additional positional arguments to pass to the
>> verification method.
>> +            **kwargs: Additional keyword arguments to pass to the
>> verification method.
>> +        """
>> +
>> +        def zip_lists(
>> +            rules: list[FlowRule],
>> +            packets1: list[Packet],
>> +            packets2: list[Packet] | None,
>> +        ) -> Iterator[tuple[FlowRule, Packet, Packet | None]]:
>> +            """Method that creates an iterable zip containing lists use=
d
>> in runner.
>> +
>> +            Args:
>> +                rules: List of flow rules.
>> +                packets1: List of packets.
>> +                packets2: Optional list of packets, excluded from zip i=
f
>> not passed to runner.
>> +            """
>> +            return cast(
>> +                Iterator[tuple[FlowRule, Packet, Packet | None]],
>> +                zip_longest(rules, packets1, packets2 or [],
>> fillvalue=3DNone),
>> +            )
>> +
>> +        with TestPmdShell(rx_queues=3D4, tx_queues=3D4) as testpmd:
>> +            for flow, packet, expected_packet in zip_lists(flows,
>> packets, expected_packets):
>> +                is_valid =3D testpmd.flow_validate(flow_rule=3Dflow,
>> port_id=3Dport_id)
>> +                self.verify_else_skip(is_valid, "flow rule failed
>> validation.")
>> +
>> +                try:
>> +                    flow_id =3D testpmd.flow_create(flow_rule=3Dflow,
>> port_id=3Dport_id)
>> +                except InteractiveCommandExecutionError:
>> +                    self.log("Flow rule validation passed, but flow
>> creation failed.")
>> +                    self.verify(False, "Failed flow creation")
>> +
>> +                if verification_method =3D=3D self.send_packet_and_veri=
fy:
>> +                    verification_method(packet=3Dpacket, *args, **kwarg=
s)
>> +
>> +                elif verification_method =3D=3D
>> self.send_packet_and_verify_queue:
>> +                    verification_method(
>> +                        packet=3Dpacket, test_queue=3Dkwargs["test_queu=
e"],
>> testpmd=3Dtestpmd
>> +                    )
>> +
>> +                elif verification_method =3D=3D
>> self.send_packet_and_verify_modification:
>> +                    verification_method(packet=3Dpacket,
>> expected_packet=3Dexpected_packet)
>> +
>> +                testpmd.flow_delete(flow_id, port_id=3Dport_id)
>> +
>> +    def send_packet_and_verify(self, packet: Packet, should_receive:
>> bool =3D True) -> None:
>> +        """Generate a packet, send to the DUT, and verify it is
>> forwarded back.
>> +
>> +        Args:
>> +            packet: Scapy packet to send and verify.
>> +            should_receive: Indicate whether the packet should be
>> received.
>> +        """
>> +        received =3D self.send_packet_and_capture(packet)
>> +        contains_packet =3D any(
>> +            packet.haslayer(Raw) and b"xxxxx" in packet.load for packet
>> in received
>> +        )
>> +        self.verify(
>> +            should_receive =3D=3D contains_packet,
>> +            f"Packet was {'dropped' if should_receive else 'received'}"=
,
>> +        )
>> +
>> +    def send_packet_and_verify_queue(
>> +        self, packet: Packet, test_queue: int, testpmd: TestPmdShell
>> +    ) -> None:
>> +        """Send packet and verify queue stats show packet was received.
>> +
>> +        Args:
>> +            packet: Scapy packet to send to the SUT.
>> +            test_queue: Represents the queue the test packet is being
>> sent to.
>> +            testpmd: TestPmdShell instance being used to send test
>> packet.
>> +        """
>> +        testpmd.set_verbose(level=3D8)
>> +        testpmd.start()
>> +        self.send_packet_and_capture(packet=3Dpacket)
>> +        verbose_output =3D testpmd.extract_verbose_output(testpmd.stop(=
))
>> +        received =3D False
>> +        for testpmd_packet in verbose_output:
>> +            if testpmd_packet.queue_id =3D=3D test_queue:
>> +                received =3D True
>> +        self.verify(received, f"Expected packet was not received on
>> queue {test_queue}")
>> +
>> +    def send_packet_and_verify_modification(self, packet: Packet,
>> expected_packet: Packet) -> None:
>> +        """Send packet and verify the expected modifications are presen=
t
>> upon reception.
>> +
>> +        Args:
>> +            packet: Scapy packet to send to the SUT.
>> +            expected_packet: Scapy packet that should match the receive=
d
>> packet.
>> +        """
>> +        received =3D self.send_packet_and_capture(packet)
>> +
>> +        # verify reception
>> +        self.verify(received !=3D [], "Packet was never received.")
>> +
>> +        self.log(f"SENT PACKET:     {packet.summary()}")
>> +        self.log(f"EXPECTED PACKET: {expected_packet.summary()}")
>> +        for packet in received:
>> +            self.log(f"RECEIVED PACKET: {packet.summary()}")
>> +
>> +        expected_ip_dst =3D expected_packet[IP].dst if IP in
>> expected_packet else None
>> +        received_ip_dst =3D received[IP].dst if IP in received else Non=
e
>> +
>> +        expected_mac_dst =3D expected_packet[Ether].dst if Ether in
>> expected_packet else None
>> +        received_mac_dst =3D received[Ether].dst if Ether in received e=
lse
>> None
>> +
>> +        # verify modification
>> +        if expected_ip_dst is not None:
>> +            self.verify(
>> +                received_ip_dst =3D=3D expected_ip_dst,
>> +                f"IPv4 dst mismatch: expected {expected_ip_dst}, got
>> {received_ip_dst}",
>> +            )
>> +
>> +        if expected_mac_dst is not None:
>> +            self.verify(
>> +                received_mac_dst =3D=3D expected_mac_dst,
>> +                f"MAC dst mismatch: expected {expected_mac_dst}, got
>> {received_mac_dst}",
>> +            )
>> +
>> +    def send_packet_and_verify_jump(
>> +        self,
>> +        packets: list[Packet],
>> +        flow_rules: list[FlowRule],
>> +        test_queues: list[int],
>> +        testpmd: TestPmdShell,
>> +    ) -> None:
>> +        """Create a testpmd session with every rule in the given list,
>> verify jump behavior.
>> +
>> +        Args:
>> +            packets: List of packets to send.
>> +            flow_rules: List of flow rules to create in the same sessio=
n.
>> +            test_queues: List of Rx queue IDs each packet should be
>> received on.
>> +            testpmd: TestPmdShell instance to create flows on.
>> +        """
>> +        testpmd.set_verbose(level=3D8)
>> +        for flow in flow_rules:
>> +            is_valid =3D testpmd.flow_validate(flow_rule=3Dflow, port_i=
d=3D0)
>> +            self.verify_else_skip(is_valid, "flow rule failed
>> validation.")
>> +
>> +            try:
>> +                testpmd.flow_create(flow_rule=3Dflow, port_id=3D0)
>> +            except InteractiveCommandExecutionError:
>> +                self.log("Flow validation passed, but flow creation
>> failed.")
>> +                self.verify(False, "Failed flow creation")
>> +
>> +        for packet, test_queue in zip(packets, test_queues):
>> +            testpmd.start()
>> +            self.send_packet_and_capture(packet=3Dpacket)
>> +            verbose_output =3D
>> testpmd.extract_verbose_output(testpmd.stop())
>> +            received =3D False
>> +            for testpmd_packet in verbose_output:
>> +                if testpmd_packet.queue_id =3D=3D test_queue:
>> +                    received =3D True
>> +            self.verify(received, f"Expected packet was not received on
>> queue {test_queue}")
>> +
>> +    @func_test
>> +    def test_queue_action_ETH(self) -> None:
>> +        """Validate flow rules with queue actions and ethernet patterns=
.
>> +
>> +        Steps:
>> +            Create a list of packets to test, with a corresponding flow
>> list.
>> +            Launch testpmd.
>> +            Create first flow rule in flow list.
>> +            Send first packet in packet list, capture verbose output.
>> +            Delete flow rule, repeat for all flows/packets.
>> +
>> +        Verify:
>> +            Check that each packet is received on the appropriate queue=
.
>> +        """
>> +        packet_list =3D [
>> +            Ether(src=3D"02:00:00:00:00:00"),
>> +            Ether(dst=3D"02:00:00:00:00:00"),
>> +            Ether(type=3D0x0800) / IP(),
>> +        ]
>> +        flow_list =3D [
>> +            FlowRule(
>> +                direction=3D"ingress",
>> +                pattern=3D["eth src is 02:00:00:00:00:00"],
>> +                actions=3D["queue index 2"],
>> +            ),
>> +            FlowRule(
>> +                direction=3D"ingress",
>> +                pattern=3D["eth dst is 02:00:00:00:00:00"],
>> +                actions=3D["queue index 2"],
>> +            ),
>> +            FlowRule(
>> +                direction=3D"ingress", pattern=3D["eth type is 0x0800"]=
,
>> actions=3D["queue index 2"]
>> +            ),
>> +        ]
>> +        self.runner(
>> +            verification_method=3Dself.send_packet_and_verify_queue,
>> +            flows=3Dflow_list,
>> +            packets=3Dpacket_list,
>> +            port_id=3D0,
>> +            test_queue=3D2,
>> +        )
>> +
>> +    @func_test
>> +    def test_queue_action_IP(self) -> None:
>> +        """Validate flow rules with queue actions and IPv4/IPv6 pattern=
s.
>> +
>> +        Steps:
>> +            Create a list of packets to test, with a corresponding flow
>> list.
>> +            Launch testpmd.
>> +            Create first flow rule in flow list.
>> +            Send first packet in packet list, capture verbose output.
>> +            Delete flow rule, repeat for all flows/packets.
>> +
>> +        Verify:
>> +            Check that each packet is received on the appropriate queue=
.
>> +        """
>> +        packet_list =3D [
>> +            Ether() / IP(src=3D"192.168.1.1"),
>> +            Ether() / IP(dst=3D"192.168.1.1"),
>> +            Ether() / IP(ttl=3D64),
>> +            Ether() / IPv6(src=3D"2001:db8::1"),
>> +            Ether() / IPv6(dst=3D"2001:db8::2"),
>> +            Ether() / IPv6() / UDP(),
>> +        ]
>> +        flow_list =3D [
>> +            FlowRule(
>> +                direction=3D"ingress",
>> +                pattern=3D["eth / ipv4 src is 192.168.1.1"],
>> +                actions=3D["queue index 2"],
>> +            ),
>> +            FlowRule(
>> +                direction=3D"ingress",
>> +                pattern=3D["eth / ipv4 dst is 192.168.1.1"],
>> +                actions=3D["queue index 2"],
>> +            ),
>> +            FlowRule(
>> +                direction=3D"ingress", pattern=3D["eth / ipv4 ttl is 64=
"],
>> actions=3D["queue index 2"]
>> +            ),
>> +            FlowRule(
>> +                direction=3D"ingress",
>> +                pattern=3D["eth / ipv6 src is 2001:db8::1"],
>> +                actions=3D["queue index 2"],
>> +            ),
>> +            FlowRule(
>> +                direction=3D"ingress",
>> +                pattern=3D["eth / ipv6 dst is 2001:db8::2"],
>> +                actions=3D["queue index 2"],
>> +            ),
>> +            FlowRule(
>> +                direction=3D"ingress", pattern=3D["eth / ipv6 proto is =
17"],
>> actions=3D["queue index 2"]
>> +            ),
>> +        ]
>> +        self.runner(
>> +            verification_method=3Dself.send_packet_and_verify_queue,
>> +            flows=3Dflow_list,
>> +            packets=3Dpacket_list,
>> +            port_id=3D0,
>> +            test_queue=3D2,
>> +        )
>> +
>> +    @func_test
>> +    def test_queue_action_L4(self) -> None:
>> +        """Validate flow rules with queue actions and TCP/UDP patterns.
>> +
>> +        Steps:
>> +            Create a list of packets to test, with a corresponding flow
>> list.
>> +            Launch testpmd.
>> +            Create first flow rule in flow list.
>> +            Send first packet in packet list, capture verbose output.
>> +            Delete flow rule, repeat for all flows/packets.
>> +
>> +        Verify:
>> +            Check that each packet is received on the appropriate queue=
.
>> +        """
>> +        packet_list =3D [
>> +            Ether() / IP() / TCP(sport=3D1234),
>> +            Ether() / IP() / TCP(dport=3D80),
>> +            Ether() / IP() / TCP(flags=3D0x02),
>> +            Ether() / IP() / UDP(sport=3D5000),
>> +            Ether() / IP() / UDP(dport=3D53),
>> +        ]
>> +        flow_list =3D [
>> +            FlowRule(
>> +                direction=3D"ingress",
>> +                pattern=3D["eth / ipv4 / tcp src is 1234"],
>> +                actions=3D["queue index 2"],
>> +            ),
>> +            FlowRule(
>> +                direction=3D"ingress",
>> +                pattern=3D["eth / ipv4 / tcp dst is 80"],
>> +                actions=3D["queue index 2"],
>> +            ),
>> +            FlowRule(
>> +                direction=3D"ingress",
>> +                pattern=3D["eth / ipv4 / tcp flags is 0x02"],
>> +                actions=3D["queue index 2"],
>> +            ),
>> +            FlowRule(
>> +                direction=3D"ingress",
>> +                pattern=3D["eth / ipv4 / udp src is 5000"],
>> +                actions=3D["queue index 2"],
>> +            ),
>> +            FlowRule(
>> +                direction=3D"ingress",
>> +                pattern=3D["eth / ipv4 / udp dst is 53"],
>> +                actions=3D["queue index 2"],
>> +            ),
>> +        ]
>> +        self.runner(
>> +            verification_method=3Dself.send_packet_and_verify_queue,
>> +            flows=3Dflow_list,
>> +            packets=3Dpacket_list,
>> +            port_id=3D0,
>> +            test_queue=3D2,
>> +        )
>> +
>> +    @func_test
>> +    def test_queue_action_VLAN(self) -> None:
>> +        """Validate flow rules with queue actions and VLAN patterns.
>> +
>> +        Steps:
>> +            Create a list of packets to test, with a corresponding flow
>> list.
>> +            Launch testpmd.
>> +            Create first flow rule in flow list.
>> +            Send first packet in packet list, capture verbose output.
>> +            Delete flow rule, repeat for all flows/packets.
>> +
>> +        Verify:
>> +            Check that each packet is received on the appropriate queue=
.
>> +        """
>> +        packet_list =3D [Ether() / Dot1Q(vlan=3D100), Ether() /
>> Dot1Q(type=3D0x0800)]
>> +        flow_list =3D [
>> +            FlowRule(direction=3D"ingress", pattern=3D["eth / vlan"],
>> actions=3D["queue index 2"]),
>> +            FlowRule(direction=3D"ingress", pattern=3D["eth / vlan"],
>> actions=3D["queue index 2"]),
>> +        ]
>> +        self.runner(
>> +            verification_method=3Dself.send_packet_and_verify_queue,
>> +            flows=3Dflow_list,
>> +            packets=3Dpacket_list,
>> +            port_id=3D0,
>> +            test_queue=3D2,
>> +        )
>> +
>> +    @func_test
>> +    def test_drop_action_ETH(self) -> None:
>> +        """Validate flow rules with drop actions and ethernet patterns.
>> +
>> +        Steps:
>> +            Create a list of packets to test, with a corresponding flow
>> list.
>> +            Launch testpmd.
>> +            Create first flow rule in flow list.
>> +            Send first packet in packet list, capture verbose output.
>> +            Delete flow rule, repeat for all flows/packets.
>> +
>> +        Verify:
>> +            Check that each packet is dropped.
>> +
>> +        One packet will be sent as a confidence check, to ensure packet=
s
>> are being
>> +        received under normal circumstances.
>> +        """
>> +        packet_list =3D [
>> +            Ether(src=3D"02:00:00:00:00:00") / Raw(load=3D"xxxxx"),
>> +            Ether(dst=3D"02:00:00:00:00:00") / Raw(load=3D"xxxxx"),
>> +            Ether(type=3D0x0800) / Raw(load=3D"xxxxx"),
>> +        ]
>> +        flow_list =3D [
>> +            FlowRule(
>> +                direction=3D"ingress", pattern=3D["eth src is
>> 02:00:00:00:00:00"], actions=3D["drop"]
>> +            ),
>> +            FlowRule(
>> +                direction=3D"ingress", pattern=3D["eth dst is
>> 02:00:00:00:00:00"], actions=3D["drop"]
>> +            ),
>> +            FlowRule(direction=3D"ingress", pattern=3D["eth type is
>> 0x0800"], actions=3D["drop"]),
>> +        ]
>> +        # verify reception with test packet
>> +        packet =3D Ether() / IP() / Raw(load=3D"xxxxx")
>> +        with TestPmdShell() as testpmd:
>> +            testpmd.start()
>> +            received =3D self.send_packet_and_capture(packet)
>> +            self.verify(received !=3D [], "Test packet was never
>> received.")
>> +        self.runner(
>> +            verification_method=3Dself.send_packet_and_verify,
>> +            flows=3Dflow_list,
>> +            packets=3Dpacket_list,
>> +            port_id=3D0,
>> +            should_receive=3DFalse,
>> +        )
>> +
>> +    @func_test
>> +    def test_drop_action_IP(self) -> None:
>> +        """Validate flow rules with drop actions and ethernet patterns.
>> +
>> +        Steps:
>> +            Create a list of packets to test, with a corresponding flow
>> list.
>> +            Launch testpmd.
>> +            Create first flow rule in flow list.
>> +            Send first packet in packet list, capture verbose output.
>> +            Delete flow rule, repeat for all flows/packets.
>> +
>> +        Verify:
>> +            Check that each packet is dropped.
>> +
>> +        One packet will be sent as a confidence check, to ensure packet=
s
>> are being
>> +        received under normal circumstances.
>> +        """
>> +        packet_list =3D [
>> +            Ether() / IP(src=3D"192.168.1.1") / Raw(load=3D"xxxxx"),
>> +            Ether() / IP(dst=3D"192.168.1.1") / Raw(load=3D"xxxxx"),
>> +            Ether() / IP(ttl=3D64) / Raw(load=3D"xxxxx"),
>> +            Ether() / IPv6(src=3D"2001:db8::1") / Raw(load=3D"xxxxx"),
>> +            Ether() / IPv6(dst=3D"2001:db8::1") / Raw(load=3D"xxxxx"),
>> +            Ether() / IPv6() / UDP() / Raw(load=3D"xxxxx"),
>> +        ]
>> +        flow_list =3D [
>> +            FlowRule(
>> +                direction=3D"ingress", pattern=3D["eth / ipv4 src is
>> 192.168.1.1"], actions=3D["drop"]
>> +            ),
>> +            FlowRule(
>> +                direction=3D"ingress", pattern=3D["eth / ipv4 dst is
>> 192.168.1.1"], actions=3D["drop"]
>> +            ),
>> +            FlowRule(direction=3D"ingress", pattern=3D["eth / ipv4 ttl =
is
>> 64"], actions=3D["drop"]),
>> +            FlowRule(
>> +                direction=3D"ingress", pattern=3D["eth / ipv6 src is
>> 2001:db8::1"], actions=3D["drop"]
>> +            ),
>> +            FlowRule(
>> +                direction=3D"ingress", pattern=3D["eth / ipv6 dst is
>> 2001:db8::2"], actions=3D["drop"]
>> +            ),
>> +            FlowRule(direction=3D"ingress", pattern=3D["eth / ipv6 prot=
o is
>> 17"], actions=3D["drop"]),
>> +        ]
>> +        # verify reception with test packet
>> +        packet =3D Ether() / IP() / Raw(load=3D"xxxxx")
>> +        with TestPmdShell() as testpmd:
>> +            testpmd.start()
>> +            received =3D self.send_packet_and_capture(packet)
>> +            self.verify(received !=3D [], "Test packet was never
>> received.")
>> +        self.runner(
>> +            verification_method=3Dself.send_packet_and_verify,
>> +            flows=3Dflow_list,
>> +            packets=3Dpacket_list,
>> +            port_id=3D0,
>> +            should_receive=3DFalse,
>> +        )
>> +
>> +    @func_test
>> +    def test_drop_action_L4(self) -> None:
>> +        """Validate flow rules with drop actions and ethernet patterns.
>> +
>> +        Steps:
>> +            Create a list of packets to test, with a corresponding flow
>> list.
>> +            Launch testpmd.
>> +            Create first flow rule in flow list.
>> +            Send first packet in packet list, capture verbose output.
>> +            Delete flow rule, repeat for all flows/packets.
>> +
>> +        Verify:
>> +            Check that each packet is dropped.
>> +
>> +        One packet will be sent as a confidence check, to ensure packet=
s
>> are being
>> +        received under normal circumstances.
>> +        """
>> +        packet_list =3D [
>> +            Ether() / IP() / TCP(sport=3D1234) / Raw(load=3D"xxxxx"),
>> +            Ether() / IP() / TCP(dport=3D80) / Raw(load=3D"xxxxx"),
>> +            Ether() / IP() / TCP(flags=3D0x02) / Raw(load=3D"xxxxx"),
>> +            Ether() / IP() / UDP(sport=3D5000) / Raw(load=3D"xxxxx"),
>> +            Ether() / IP() / UDP(dport=3D53) / Raw(load=3D"xxxxx"),
>> +        ]
>> +        flow_list =3D [
>> +            FlowRule(
>> +                direction=3D"ingress", pattern=3D["eth / ipv4 / tcp src=
 is
>> 1234"], actions=3D["drop"]
>> +            ),
>> +            FlowRule(direction=3D"ingress", pattern=3D["eth / ipv4 / tc=
p dst
>> is 80"], actions=3D["drop"]),
>> +            FlowRule(
>> +                direction=3D"ingress", pattern=3D["eth / ipv4 / tcp fla=
gs is
>> 0x02"], actions=3D["drop"]
>> +            ),
>> +            FlowRule(
>> +                direction=3D"ingress", pattern=3D["eth / ipv4 / udp src=
 is
>> 5000"], actions=3D["drop"]
>> +            ),
>> +            FlowRule(direction=3D"ingress", pattern=3D["eth / ipv4 / ud=
p dst
>> is 53"], actions=3D["drop"]),
>> +        ]
>> +        # verify reception with test packet
>> +        packet =3D Ether() / IP() / Raw(load=3D"xxxxx")
>> +        with TestPmdShell() as testpmd:
>> +            testpmd.start()
>> +            received =3D self.send_packet_and_capture(packet)
>> +            self.verify(received !=3D [], "Test packet was never
>> received.")
>> +        self.runner(
>> +            verification_method=3Dself.send_packet_and_verify,
>> +            flows=3Dflow_list,
>> +            packets=3Dpacket_list,
>> +            port_id=3D0,
>> +            should_receive=3DFalse,
>> +        )
>> +
>> +    @func_test
>> +    def test_drop_action_VLAN(self) -> None:
>> +        """Validate flow rules with drop actions and ethernet patterns.
>> +
>> +        Steps:
>> +            Create a list of packets to test, with a corresponding flow
>> list.
>> +            Launch testpmd.
>> +            Create first flow rule in flow list.
>> +            Send first packet in packet list, capture verbose output.
>> +            Delete flow rule, repeat for all flows/packets.
>> +
>> +        Verify:
>> +            Check that each packet is dropped.
>> +
>> +        One packet will be sent as a confidence check, to ensure packet=
s
>> are being
>> +        received under normal circumstances.
>> +        """
>> +        packet_list =3D [
>> +            Ether() / Dot1Q(vlan=3D100) / Raw(load=3D"xxxxx"),
>> +            Ether() / Dot1Q(type=3D0x0800) / Raw(load=3D"xxxxx"),
>> +        ]
>> +        flow_list =3D [
>> +            FlowRule(direction=3D"ingress", pattern=3D["eth / vlan"],
>> actions=3D["drop"]),
>> +            FlowRule(direction=3D"ingress", pattern=3D["eth / vlan"],
>> actions=3D["drop"]),
>> +        ]
>> +        # verify reception with test packet
>> +        packet =3D Ether() / IP() / Raw(load=3D"xxxxx")
>> +        with TestPmdShell() as testpmd:
>> +            testpmd.start()
>> +            received =3D self.send_packet_and_capture(packet)
>> +            self.verify(received !=3D [], "Test packet was never
>> received.")
>> +        self.runner(
>> +            verification_method=3Dself.send_packet_and_verify,
>> +            flows=3Dflow_list,
>> +            packets=3Dpacket_list,
>> +            port_id=3D0,
>> +            should_receive=3DFalse,
>> +        )
>> +
>> +    @func_test
>> +    def test_modify_actions(self) -> None:
>> +        """Validate flow rules with actions that modify that packet
>> during transmission.
>> +
>> +        Steps:
>> +            Create a list of packets to test, with a corresponding flow
>> list.
>> +            Launch testpmd.
>> +            Create first flow rule in flow list.
>> +            Send first packet in packet list, capture verbose output.
>> +            Delete flow rule, repeat for all flows/packets.
>> +
>> +        Verify:
>> +            Verify packet is received with the new attributes.
>> +        """
>> +        packet_list =3D [Ether() / IP(src=3D"192.68.1.1"),
>> Ether(src=3D"02:00:00:00:00:00")]
>> +        flow_list =3D [
>> +            # rule to copy IPv4 src to IPv4 dst
>> +            FlowRule(
>> +                direction=3D"ingress",
>> +                group_id=3D1,
>> +                pattern=3D["eth"],
>> +                actions=3D[
>> +                    "modify_field op set dst_type ipv4_dst src_type
>> ipv4_src width 32"
>> +                    " / queue index 0"
>> +                ],
>> +            ),
>> +            # rule to copy src MAC to dst MAC
>> +            FlowRule(
>> +                direction=3D"ingress",
>> +                group_id=3D1,
>> +                pattern=3D["eth"],
>> +                actions=3D[
>> +                    "modify_field op set dst_type mac_dst src_type
>> mac_src width 48 / queue index 0"
>> +                ],
>> +            ),
>> +        ]
>> +        expected_packet_list =3D [Ether() / IP(dst=3D"192.68.1.1"),
>> Ether(dst=3D"02:00:00:00:00:00")]
>> +        self.runner(
>> +            verification_method=3Dself.send_packet_and_verify_modificat=
ion,
>> +            flows=3Dflow_list,
>> +            packets=3Dpacket_list,
>> +            port_id=3D0,
>> +            expected_packets=3Dexpected_packet_list,
>> +        )
>> +
>> +    @func_test
>> +    def test_egress_rules(self) -> None:
>> +        """Validate flow rules with egress directions.
>> +
>> +        Steps:
>> +            Create a list of packets to test, with a corresponding flow
>> list.
>> +            Launch testpmd.
>> +            Create first flow rule in flow list.
>> +            Send first packet in packet list, capture verbose output.
>> +            Delete flow rule, repeat for all flows/packets.
>> +
>> +        Verify:
>> +            Check that each packet is dropped.
>> +
>> +        One packet will be sent as a confidence check, to ensure packet=
s
>> are being
>> +        received under normal circumstances.
>> +        """
>> +        packet_list =3D [
>> +            Ether(src=3D"02:00:00:00:00:00"),
>> +            Ether() / IP(src=3D"192.168.1.1"),
>> +            IP() / TCP(sport=3D1234),
>> +            IP() / UDP(sport=3D5000),
>> +        ]
>> +        flow_list =3D [
>> +            FlowRule(
>> +                direction=3D"egress", pattern=3D["eth src is
>> 02:00:00:00:00:00"], actions=3D["drop"]
>> +            ),
>> +            FlowRule(direction=3D"egress", pattern=3D["ipv4 src is
>> 192.168.1.1"], actions=3D["drop"]),
>> +            FlowRule(direction=3D"egress", pattern=3D["tcp src is 1234"=
],
>> actions=3D["drop"]),
>> +            FlowRule(direction=3D"egress", pattern=3D["udp src is 5000"=
],
>> actions=3D["drop"]),
>> +        ]
>> +        # verify reception with test packet
>> +        packet =3D Ether() / IP() / Raw(load=3D"xxxxx")
>> +        with TestPmdShell() as testpmd:
>> +            testpmd.start()
>> +            received =3D self.send_packet_and_capture(packet)
>> +            self.verify(received !=3D [], "Test packet was never
>> received.")
>> +        self.runner(
>> +            verification_method=3Dself.send_packet_and_verify,
>> +            flows=3Dflow_list,
>> +            packets=3Dpacket_list,
>> +            port_id=3D1,
>> +            should_receive=3DFalse,
>> +        )
>> +
>> +    @func_test
>> +    def test_jump_action(self) -> None:
>> +        """Validate flow rules with different group levels and jump
>> actions.
>> +
>> +        Steps:
>> +            Create a list of packets to test, with a corresponding flow
>> list.
>> +            Launch testpmd with the necessary configuration.
>> +            Create each flow rule in testpmd.
>> +            Send each packet in the list, check Rx queue ID.
>> +
>> +        Verify:
>> +            Check that each packet is received on the appropriate Rx
>> queue.
>> +        """
>> +        packet_list =3D [Ether() / IP(), Ether() / IP() / TCP(), Ether(=
) /
>> IP() / UDP()]
>> +        flow_list =3D [
>> +            FlowRule(
>> +                direction=3D"ingress",
>> +                group_id=3D0,
>> +                pattern=3D["eth / ipv4 / tcp"],
>> +                actions=3D["jump group 1"],
>> +            ),
>> +            FlowRule(
>> +                direction=3D"ingress",
>> +                group_id=3D0,
>> +                pattern=3D["eth / ipv4 / udp"],
>> +                actions=3D["jump group 2"],
>> +            ),
>> +            FlowRule(
>> +                direction=3D"ingress",
>> +                group_id=3D1,
>> +                pattern=3D["eth / ipv4 / tcp"],
>> +                actions=3D["queue index 2"],
>> +            ),
>> +            FlowRule(
>> +                direction=3D"ingress",
>> +                group_id=3D2,
>> +                pattern=3D["eth / ipv4 / udp"],
>> +                actions=3D["queue index 3"],
>> +            ),
>> +            FlowRule(
>> +                direction=3D"ingress",
>> +                group_id=3D0,
>> +                pattern=3D["eth / ipv4"],
>> +                actions=3D["queue index 1"],
>> +            ),
>> +        ]
>> +        expected_queue_list =3D [1, 2, 3]
>> +        with TestPmdShell(rx_queues=3D4, tx_queues=3D4) as testpmd:
>> +            self.send_packet_and_verify_jump(
>> +                packets=3Dpacket_list,
>> +                flow_rules=3Dflow_list,
>> +                test_queues=3Dexpected_queue_list,
>> +                testpmd=3Dtestpmd,
>> +            )
>> +
>> +    @func_test
>> +    def test_priority_attribute(self) -> None:
>> +        """Validate flow rules with queue actions and ethernet patterns=
.
>> +
>> +        Steps:
>> +            Create a list of packets to test, with a corresponding flow
>> list.
>> +            Launch testpmd.
>> +            Create first flow rule in flow list.
>> +            Send first packet in packet list, capture verbose output.
>> +            Delete flow rule, repeat for all flows/packets.
>> +
>> +        Verify:
>> +            Check that each packet is received on the appropriate queue=
.
>> +        """
>> +        test_packet =3D Ether() / IP() / Raw()
>> +        flow_list =3D [
>> +            FlowRule(
>> +                direction=3D"ingress",
>> +                priority_level=3D3,
>> +                pattern=3D["eth / ipv4"],
>> +                actions=3D["queue index 1"],
>> +            ),
>> +            FlowRule(
>> +                direction=3D"ingress",
>> +                priority_level=3D2,
>> +                pattern=3D["eth / ipv4"],
>> +                actions=3D["queue index 2"],
>> +            ),
>> +            FlowRule(
>> +                direction=3D"ingress",
>> +                priority_level=3D1,
>> +                pattern=3D["eth / ipv4"],
>> +                actions=3D["queue index 3"],
>> +            ),
>> +        ]
>> +        expected_queue_list =3D [1, 2, 3]
>> +        with TestPmdShell(rx_queues=3D4, tx_queues=3D4) as testpmd:
>> +            testpmd.set_verbose(level=3D8)
>> +            for flow, expected_queue in zip(flow_list,
>> expected_queue_list):
>> +                is_valid =3D testpmd.flow_validate(flow_rule=3Dflow,
>> port_id=3D0)
>> +                self.verify_else_skip(is_valid, "flow rule failed
>> validation.")
>> +                try:
>> +                    testpmd.flow_create(flow_rule=3Dflow, port_id=3D0)
>> +                except InteractiveCommandExecutionError:
>> +                    self.log("Flow rule validation passed, but flow
>> creation failed.")
>> +                    self.verify(False, "Failed flow creation")
>> +                testpmd.start()
>> +                self.send_packet_and_capture(test_packet)
>> +                verbose_output =3D
>> testpmd.extract_verbose_output(testpmd.stop())
>> +                received =3D False
>> +                for testpmd_packet in verbose_output:
>> +                    if testpmd_packet.queue_id =3D=3D expected_queue:
>> +                        received =3D True
>> +                self.verify(received, f"Packet was not received on queu=
e
>> {expected_queue}")
>> --
>> 2.49.0
>>
>>

--000000000000b19a6806388ed343
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Resolved.</div><br><div class=3D"gmail_quote gmail_quote_c=
ontainer"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 27, 2025 at 10:=
20=E2=80=AFAM Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu">probb@i=
ol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 26, 2025 at 3:=
56=E2=80=AFPM Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" target=3D"=
_blank">dmarx@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Add an RTE Flow API testing suite, which covers so=
me basic<br>
synchronous Flow API rules that should be supported across PMDs.<br>
This suite will be added to over time, as the Flow API is too large<br>
to cover all in one suite, and sending one monolithic series<br>
would be impossible.<br>
<br>
Signed-off-by: Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" target=3D=
"_blank">dmarx@iol.unh.edu</a>&gt;<br>
Reviewed-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu" target=
=3D"_blank">probb@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0doc/api/dts/tests.TestSuite_rte_flow.rst |=C2=A0 =C2=A08 +<br>
=C2=A0dts/tests/TestSuite_rte_flow.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 7=
90 +++++++++++++++++++++++<br>
=C2=A02 files changed, 798 insertions(+)<br>
=C2=A0create mode 100644 doc/api/dts/tests.TestSuite_rte_flow.rst<br>
=C2=A0create mode 100644 dts/tests/TestSuite_rte_flow.py<br>
<br>
diff --git a/doc/api/dts/tests.TestSuite_rte_flow.rst b/doc/api/dts/tests.T=
estSuite_rte_flow.rst<br>
new file mode 100644<br>
index 0000000000..cad96b2530<br>
--- /dev/null<br>
+++ b/doc/api/dts/tests.TestSuite_rte_flow.rst<br>
@@ -0,0 +1,8 @@<br>
+.. SPDX-License-Identifier: BSD-3-Clause<br>
+<br>
+checksum_offload Test Suite<br></blockquote><div><br></div><div>I&#39;m ju=
st seeing this rst misnaming of the testsuite with the docs build now. I&#3=
9;m going to update and force push to next-dts.</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>
+<br>
+.. automodule:: tests.TestSuite_rte_flow<br>
+=C2=A0 =C2=A0:members:<br>
+=C2=A0 =C2=A0:show-inheritance:<br>
\ No newline at end of file<br>
diff --git a/dts/tests/TestSuite_rte_flow.py b/dts/tests/TestSuite_rte_flow=
.py<br>
new file mode 100644<br>
index 0000000000..e70f7ea8d1<br>
--- /dev/null<br>
+++ b/dts/tests/TestSuite_rte_flow.py<br>
@@ -0,0 +1,790 @@<br>
+# SPDX-License-Identifier: BSD-3-Clause<br>
+# Copyright(c) 2025 University of New Hampshire<br>
+<br>
+&quot;&quot;&quot;RTE Flow testing suite.<br>
+<br>
+This suite verifies a range of flow rules built using patterns<br>
+and actions from the RTE Flow API. It would be impossible to cover<br>
+every valid flow rule, but this suite aims to test the most<br>
+important and common functionalities across PMDs.<br>
+<br>
+&quot;&quot;&quot;<br>
+<br>
+from collections.abc import Callable<br>
+from itertools import zip_longest<br>
+from typing import Any, Iterator, cast<br>
+<br>
+from scapy.layers.inet import IP, TCP, UDP<br>
+from scapy.layers.inet6 import IPv6<br>
+from scapy.layers.l2 import Dot1Q, Ether<br>
+from scapy.packet import Packet, Raw<br>
+<br>
+from framework.exception import InteractiveCommandExecutionError<br>
+from framework.remote_session.testpmd_shell import FlowRule, TestPmdShell<=
br>
+from framework.test_suite import TestSuite, func_test<br>
+from framework.testbed_model.capability import NicCapability, requires<br>
+<br>
+<br>
+@requires(NicCapability.FLOW_CTRL)<br>
+class TestRteFlow(TestSuite):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;RTE Flow test suite.<br>
+<br>
+=C2=A0 =C2=A0 This suite consists of 12 test cases:<br>
+=C2=A0 =C2=A0 1. Queue Action Ethernet: Verifies queue actions with ethern=
et patterns<br>
+=C2=A0 =C2=A0 2. Queue Action IP: Verifies queue actions with IPv4 and IPv=
6 patterns<br>
+=C2=A0 =C2=A0 3. Queue Action L4: Verifies queue actions with TCP and UDP =
patterns<br>
+=C2=A0 =C2=A0 4. Queue Action VLAN: Verifies queue actions with VLAN patte=
rns<br>
+=C2=A0 =C2=A0 5. Drop Action Eth: Verifies drop action with ethernet patte=
rns<br>
+=C2=A0 =C2=A0 6. Drop Action IP: Verifies drop actions with IPV4 and IPv6 =
patterns<br>
+=C2=A0 =C2=A0 7. Drop Action L4: Verifies drop actions with TCP and UDP pa=
tterns<br>
+=C2=A0 =C2=A0 8. Drop Action VLAN: Verifies drop actions with VLAN pattern=
s<br>
+=C2=A0 =C2=A0 9. Modify Field Action: Verifies packet modification pattern=
s<br>
+=C2=A0 =C2=A0 10. Egress Rules: Verifies previously covered rules are stil=
l valid as egress<br>
+=C2=A0 =C2=A0 11. Jump Action: Verifies packet behavior given grouped flow=
s<br>
+=C2=A0 =C2=A0 12. Priority Attribute: Verifies packet behavior given flows=
 with different priorities<br>
+<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 def runner(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 verification_method: Callable[..., Any],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flows: list[FlowRule],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packets: list[Packet],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: int,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 expected_packets: list[Packet] | None =3D None=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *args: Any,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 **kwargs: Any,<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Runner method that validates=
 each flow using the corresponding verification method.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verification_method: Callable th=
at performs verification logic.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flows: List of flow rules to cre=
ate and test.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets: List of packets corresp=
onding to each flow.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: Number representing the=
 port to create flows on.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expected_packets: List of packet=
s to check sent packets against in modification cases.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *args: Additional positional arg=
uments to pass to the verification method.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 **kwargs: Additional keyword arg=
uments to pass to the verification method.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 def zip_lists(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rules: list[FlowRule],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets1: list[Packet],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets2: list[Packet] | None,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ) -&gt; Iterator[tuple[FlowRule, Packet, Packe=
t | None]]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Method that cr=
eates an iterable zip containing lists used in runner.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rules: List of flo=
w rules.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets1: List of =
packets.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets2: Optional=
 list of packets, excluded from zip if not passed to runner.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return cast(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Iterator[tuple[Flo=
wRule, Packet, Packet | None]],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 zip_longest(rules,=
 packets1, packets2 or [], fillvalue=3DNone),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmdShell(rx_queues=3D4, tx_queues=3D4=
) as testpmd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for flow, packet, expected_packe=
t in zip_lists(flows, packets, expected_packets):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_valid =3D testp=
md.flow_validate(flow_rule=3Dflow, port_id=3Dport_id)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify_else_s=
kip(is_valid, &quot;flow rule failed validation.&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flow=
_id =3D testpmd.flow_create(flow_rule=3Dflow, port_id=3Dport_id)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except Interactive=
CommandExecutionError:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
.log(&quot;Flow rule validation passed, but flow creation failed.&quot;)<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
.verify(False, &quot;Failed flow creation&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if verification_me=
thod =3D=3D self.send_packet_and_verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 veri=
fication_method(packet=3Dpacket, *args, **kwargs)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif verification_=
method =3D=3D self.send_packet_and_verify_queue:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 veri=
fication_method(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 packet=3Dpacket, test_queue=3Dkwargs[&quot;test_queue&quot;], te=
stpmd=3Dtestpmd<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif verification_=
method =3D=3D self.send_packet_and_verify_modification:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 veri=
fication_method(packet=3Dpacket, expected_packet=3Dexpected_packet)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.flow_delet=
e(flow_id, port_id=3Dport_id)<br>
+<br>
+=C2=A0 =C2=A0 def send_packet_and_verify(self, packet: Packet, should_rece=
ive: bool =3D True) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Generate a packet, send to t=
he DUT, and verify it is forwarded back.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet: Scapy packet to send and=
 verify.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 should_receive: Indicate whether=
 the packet should be received.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 received =3D self.send_packet_and_capture(pack=
et)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 contains_packet =3D any(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet.haslayer(Raw) and b&quot;=
xxxxx&quot; in packet.load for packet in received<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 should_receive =3D=3D contains_p=
acket,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;Packet was {&#39;dropped&=
#39; if should_receive else &#39;received&#39;}&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 def send_packet_and_verify_queue(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, packet: Packet, test_queue: int, testpmd=
: TestPmdShell<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Send packet and verify queue=
 stats show packet was received.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet: Scapy packet to send to =
the SUT.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_queue: Represents the queue=
 the test packet is being sent to.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd: TestPmdShell instance b=
eing used to send test packet.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.set_verbose(level=3D8)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.start()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_packet_and_capture(packet=3Dpacket)<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 verbose_output =3D testpmd.extract_verbose_out=
put(testpmd.stop())<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 received =3D False<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for testpmd_packet in verbose_output:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if testpmd_packet.queue_id =3D=
=3D test_queue:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 received =3D True<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify(received, f&quot;Expected packet w=
as not received on queue {test_queue}&quot;)<br>
+<br>
+=C2=A0 =C2=A0 def send_packet_and_verify_modification(self, packet: Packet=
, expected_packet: Packet) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Send packet and verify the e=
xpected modifications are present upon reception.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet: Scapy packet to send to =
the SUT.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expected_packet: Scapy packet th=
at should match the received packet.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 received =3D self.send_packet_and_capture(pack=
et)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # verify reception<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify(received !=3D [], &quot;Packet was=
 never received.&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.log(f&quot;SENT PACKET:=C2=A0 =C2=A0 =C2=
=A0{packet.summary()}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.log(f&quot;EXPECTED PACKET: {expected_pac=
ket.summary()}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for packet in received:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.log(f&quot;RECEIVED PACKET:=
 {packet.summary()}&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 expected_ip_dst =3D expected_packet[IP].dst if=
 IP in expected_packet else None<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 received_ip_dst =3D received[IP].dst if IP in =
received else None<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 expected_mac_dst =3D expected_packet[Ether].ds=
t if Ether in expected_packet else None<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 received_mac_dst =3D received[Ether].dst if Et=
her in received else None<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # verify modification<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if expected_ip_dst is not None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_ip_dst =
=3D=3D expected_ip_dst,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;IPv4 dst mi=
smatch: expected {expected_ip_dst}, got {received_ip_dst}&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if expected_mac_dst is not None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_mac_dst =
=3D=3D expected_mac_dst,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;MAC dst mis=
match: expected {expected_mac_dst}, got {received_mac_dst}&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 def send_packet_and_verify_jump(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packets: list[Packet],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_rules: list[FlowRule],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_queues: list[int],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd: TestPmdShell,<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Create a testpmd session wit=
h every rule in the given list, verify jump behavior.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets: List of packets to send=
.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_rules: List of flow rules t=
o create in the same session.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_queues: List of Rx queue ID=
s each packet should be received on.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd: TestPmdShell instance t=
o create flows on.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.set_verbose(level=3D8)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for flow in flow_rules:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_valid =3D testpmd.flow_valida=
te(flow_rule=3Dflow, port_id=3D0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify_else_skip(is_valid, =
&quot;flow rule failed validation.&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.flow_creat=
e(flow_rule=3Dflow, port_id=3D0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except InteractiveCommandExecuti=
onError:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.log(&quot;Flo=
w validation passed, but flow creation failed.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify(False,=
 &quot;Failed flow creation&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for packet, test_queue in zip(packets, test_qu=
eues):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.start()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_packet_and_capture(pac=
ket=3Dpacket)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verbose_output =3D testpmd.extra=
ct_verbose_output(testpmd.stop())<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 received =3D False<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for testpmd_packet in verbose_ou=
tput:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if testpmd_packet.=
queue_id =3D=3D test_queue:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rece=
ived =3D True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify(received, f&quot;Exp=
ected packet was not received on queue {test_queue}&quot;)<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def test_queue_action_ETH(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validate flow rules with que=
ue actions and ethernet patterns.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create a list of packets to test=
, with a corresponding flow list.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Launch testpmd.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create first flow rule in flow l=
ist.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Send first packet in packet list=
, capture verbose output.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Delete flow rule, repeat for all=
 flows/packets.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Check that each packet is receiv=
ed on the appropriate queue.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet_list =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether(src=3D&quot;02:00:00:00:00=
:00&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether(dst=3D&quot;02:00:00:00:00=
:00&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether(type=3D0x0800) / IP(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_list =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern=3D[&quot;e=
th src is 02:00:00:00:00:00&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions=3D[&quot;q=
ueue index 2&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern=3D[&quot;e=
th dst is 02:00:00:00:00:00&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions=3D[&quot;q=
ueue index 2&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;, pattern=3D[&quot;eth type is 0x0800&quot;], actions=3D[&quot=
;queue index 2&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.runner(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verification_method=3Dself.send_=
packet_and_verify_queue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flows=3Dflow_list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets=3Dpacket_list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id=3D0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_queue=3D2,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def test_queue_action_IP(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validate flow rules with que=
ue actions and IPv4/IPv6 patterns.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create a list of packets to test=
, with a corresponding flow list.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Launch testpmd.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create first flow rule in flow l=
ist.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Send first packet in packet list=
, capture verbose output.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Delete flow rule, repeat for all=
 flows/packets.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Check that each packet is receiv=
ed on the appropriate queue.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet_list =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether() / IP(src=3D&quot;192.168=
.1.1&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether() / IP(dst=3D&quot;192.168=
.1.1&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether() / IP(ttl=3D64),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether() / IPv6(src=3D&quot;2001:=
db8::1&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether() / IPv6(dst=3D&quot;2001:=
db8::2&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether() / IPv6() / UDP(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_list =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern=3D[&quot;e=
th / ipv4 src is 192.168.1.1&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions=3D[&quot;q=
ueue index 2&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern=3D[&quot;e=
th / ipv4 dst is 192.168.1.1&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions=3D[&quot;q=
ueue index 2&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;, pattern=3D[&quot;eth / ipv4 ttl is 64&quot;], actions=3D[&qu=
ot;queue index 2&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern=3D[&quot;e=
th / ipv6 src is 2001:db8::1&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions=3D[&quot;q=
ueue index 2&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern=3D[&quot;e=
th / ipv6 dst is 2001:db8::2&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions=3D[&quot;q=
ueue index 2&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;, pattern=3D[&quot;eth / ipv6 proto is 17&quot;], actions=3D[&=
quot;queue index 2&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.runner(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verification_method=3Dself.send_=
packet_and_verify_queue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flows=3Dflow_list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets=3Dpacket_list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id=3D0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_queue=3D2,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def test_queue_action_L4(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validate flow rules with que=
ue actions and TCP/UDP patterns.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create a list of packets to test=
, with a corresponding flow list.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Launch testpmd.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create first flow rule in flow l=
ist.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Send first packet in packet list=
, capture verbose output.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Delete flow rule, repeat for all=
 flows/packets.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Check that each packet is receiv=
ed on the appropriate queue.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet_list =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether() / IP() / TCP(sport=3D123=
4),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether() / IP() / TCP(dport=3D80)=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether() / IP() / TCP(flags=3D0x0=
2),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether() / IP() / UDP(sport=3D500=
0),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether() / IP() / UDP(dport=3D53)=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_list =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern=3D[&quot;e=
th / ipv4 / tcp src is 1234&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions=3D[&quot;q=
ueue index 2&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern=3D[&quot;e=
th / ipv4 / tcp dst is 80&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions=3D[&quot;q=
ueue index 2&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern=3D[&quot;e=
th / ipv4 / tcp flags is 0x02&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions=3D[&quot;q=
ueue index 2&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern=3D[&quot;e=
th / ipv4 / udp src is 5000&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions=3D[&quot;q=
ueue index 2&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern=3D[&quot;e=
th / ipv4 / udp dst is 53&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions=3D[&quot;q=
ueue index 2&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.runner(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verification_method=3Dself.send_=
packet_and_verify_queue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flows=3Dflow_list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets=3Dpacket_list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id=3D0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_queue=3D2,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def test_queue_action_VLAN(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validate flow rules with que=
ue actions and VLAN patterns.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create a list of packets to test=
, with a corresponding flow list.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Launch testpmd.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create first flow rule in flow l=
ist.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Send first packet in packet list=
, capture verbose output.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Delete flow rule, repeat for all=
 flows/packets.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Check that each packet is receiv=
ed on the appropriate queue.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet_list =3D [Ether() / Dot1Q(vlan=3D100), =
Ether() / Dot1Q(type=3D0x0800)]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_list =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(direction=3D&quot;ingre=
ss&quot;, pattern=3D[&quot;eth / vlan&quot;], actions=3D[&quot;queue index =
2&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(direction=3D&quot;ingre=
ss&quot;, pattern=3D[&quot;eth / vlan&quot;], actions=3D[&quot;queue index =
2&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.runner(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verification_method=3Dself.send_=
packet_and_verify_queue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flows=3Dflow_list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets=3Dpacket_list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id=3D0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_queue=3D2,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def test_drop_action_ETH(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validate flow rules with dro=
p actions and ethernet patterns.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create a list of packets to test=
, with a corresponding flow list.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Launch testpmd.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create first flow rule in flow l=
ist.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Send first packet in packet list=
, capture verbose output.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Delete flow rule, repeat for all=
 flows/packets.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Check that each packet is droppe=
d.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 One packet will be sent as a confidence check,=
 to ensure packets are being<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 received under normal circumstances.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet_list =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether(src=3D&quot;02:00:00:00:00=
:00&quot;) / Raw(load=3D&quot;xxxxx&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether(dst=3D&quot;02:00:00:00:00=
:00&quot;) / Raw(load=3D&quot;xxxxx&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether(type=3D0x0800) / Raw(load=
=3D&quot;xxxxx&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_list =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;, pattern=3D[&quot;eth src is 02:00:00:00:00:00&quot;], action=
s=3D[&quot;drop&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;, pattern=3D[&quot;eth dst is 02:00:00:00:00:00&quot;], action=
s=3D[&quot;drop&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(direction=3D&quot;ingre=
ss&quot;, pattern=3D[&quot;eth type is 0x0800&quot;], actions=3D[&quot;drop=
&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # verify reception with test packet<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet =3D Ether() / IP() / Raw(load=3D&quot;x=
xxxx&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmdShell() as testpmd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.start()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 received =3D self.send_packet_an=
d_capture(packet)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify(received !=3D [], &q=
uot;Test packet was never received.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.runner(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verification_method=3Dself.send_=
packet_and_verify,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flows=3Dflow_list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets=3Dpacket_list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id=3D0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 should_receive=3DFalse,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def test_drop_action_IP(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validate flow rules with dro=
p actions and ethernet patterns.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create a list of packets to test=
, with a corresponding flow list.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Launch testpmd.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create first flow rule in flow l=
ist.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Send first packet in packet list=
, capture verbose output.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Delete flow rule, repeat for all=
 flows/packets.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Check that each packet is droppe=
d.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 One packet will be sent as a confidence check,=
 to ensure packets are being<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 received under normal circumstances.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet_list =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether() / IP(src=3D&quot;192.168=
.1.1&quot;) / Raw(load=3D&quot;xxxxx&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether() / IP(dst=3D&quot;192.168=
.1.1&quot;) / Raw(load=3D&quot;xxxxx&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether() / IP(ttl=3D64) / Raw(loa=
d=3D&quot;xxxxx&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether() / IPv6(src=3D&quot;2001:=
db8::1&quot;) / Raw(load=3D&quot;xxxxx&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether() / IPv6(dst=3D&quot;2001:=
db8::1&quot;) / Raw(load=3D&quot;xxxxx&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether() / IPv6() / UDP() / Raw(l=
oad=3D&quot;xxxxx&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_list =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;, pattern=3D[&quot;eth / ipv4 src is 192.168.1.1&quot;], actio=
ns=3D[&quot;drop&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;, pattern=3D[&quot;eth / ipv4 dst is 192.168.1.1&quot;], actio=
ns=3D[&quot;drop&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(direction=3D&quot;ingre=
ss&quot;, pattern=3D[&quot;eth / ipv4 ttl is 64&quot;], actions=3D[&quot;dr=
op&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;, pattern=3D[&quot;eth / ipv6 src is 2001:db8::1&quot;], actio=
ns=3D[&quot;drop&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;, pattern=3D[&quot;eth / ipv6 dst is 2001:db8::2&quot;], actio=
ns=3D[&quot;drop&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(direction=3D&quot;ingre=
ss&quot;, pattern=3D[&quot;eth / ipv6 proto is 17&quot;], actions=3D[&quot;=
drop&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # verify reception with test packet<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet =3D Ether() / IP() / Raw(load=3D&quot;x=
xxxx&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmdShell() as testpmd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.start()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 received =3D self.send_packet_an=
d_capture(packet)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify(received !=3D [], &q=
uot;Test packet was never received.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.runner(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verification_method=3Dself.send_=
packet_and_verify,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flows=3Dflow_list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets=3Dpacket_list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id=3D0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 should_receive=3DFalse,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def test_drop_action_L4(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validate flow rules with dro=
p actions and ethernet patterns.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create a list of packets to test=
, with a corresponding flow list.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Launch testpmd.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create first flow rule in flow l=
ist.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Send first packet in packet list=
, capture verbose output.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Delete flow rule, repeat for all=
 flows/packets.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Check that each packet is droppe=
d.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 One packet will be sent as a confidence check,=
 to ensure packets are being<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 received under normal circumstances.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet_list =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether() / IP() / TCP(sport=3D123=
4) / Raw(load=3D&quot;xxxxx&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether() / IP() / TCP(dport=3D80)=
 / Raw(load=3D&quot;xxxxx&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether() / IP() / TCP(flags=3D0x0=
2) / Raw(load=3D&quot;xxxxx&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether() / IP() / UDP(sport=3D500=
0) / Raw(load=3D&quot;xxxxx&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether() / IP() / UDP(dport=3D53)=
 / Raw(load=3D&quot;xxxxx&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_list =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;, pattern=3D[&quot;eth / ipv4 / tcp src is 1234&quot;], action=
s=3D[&quot;drop&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(direction=3D&quot;ingre=
ss&quot;, pattern=3D[&quot;eth / ipv4 / tcp dst is 80&quot;], actions=3D[&q=
uot;drop&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;, pattern=3D[&quot;eth / ipv4 / tcp flags is 0x02&quot;], acti=
ons=3D[&quot;drop&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;, pattern=3D[&quot;eth / ipv4 / udp src is 5000&quot;], action=
s=3D[&quot;drop&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(direction=3D&quot;ingre=
ss&quot;, pattern=3D[&quot;eth / ipv4 / udp dst is 53&quot;], actions=3D[&q=
uot;drop&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # verify reception with test packet<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet =3D Ether() / IP() / Raw(load=3D&quot;x=
xxxx&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmdShell() as testpmd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.start()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 received =3D self.send_packet_an=
d_capture(packet)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify(received !=3D [], &q=
uot;Test packet was never received.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.runner(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verification_method=3Dself.send_=
packet_and_verify,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flows=3Dflow_list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets=3Dpacket_list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id=3D0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 should_receive=3DFalse,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def test_drop_action_VLAN(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validate flow rules with dro=
p actions and ethernet patterns.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create a list of packets to test=
, with a corresponding flow list.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Launch testpmd.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create first flow rule in flow l=
ist.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Send first packet in packet list=
, capture verbose output.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Delete flow rule, repeat for all=
 flows/packets.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Check that each packet is droppe=
d.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 One packet will be sent as a confidence check,=
 to ensure packets are being<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 received under normal circumstances.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet_list =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether() / Dot1Q(vlan=3D100) / Ra=
w(load=3D&quot;xxxxx&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether() / Dot1Q(type=3D0x0800) /=
 Raw(load=3D&quot;xxxxx&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_list =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(direction=3D&quot;ingre=
ss&quot;, pattern=3D[&quot;eth / vlan&quot;], actions=3D[&quot;drop&quot;])=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(direction=3D&quot;ingre=
ss&quot;, pattern=3D[&quot;eth / vlan&quot;], actions=3D[&quot;drop&quot;])=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # verify reception with test packet<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet =3D Ether() / IP() / Raw(load=3D&quot;x=
xxxx&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmdShell() as testpmd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.start()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 received =3D self.send_packet_an=
d_capture(packet)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify(received !=3D [], &q=
uot;Test packet was never received.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.runner(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verification_method=3Dself.send_=
packet_and_verify,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flows=3Dflow_list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets=3Dpacket_list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id=3D0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 should_receive=3DFalse,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def test_modify_actions(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validate flow rules with act=
ions that modify that packet during transmission.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create a list of packets to test=
, with a corresponding flow list.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Launch testpmd.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create first flow rule in flow l=
ist.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Send first packet in packet list=
, capture verbose output.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Delete flow rule, repeat for all=
 flows/packets.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify packet is received with t=
he new attributes.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet_list =3D [Ether() / IP(src=3D&quot;192.=
68.1.1&quot;), Ether(src=3D&quot;02:00:00:00:00:00&quot;)]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_list =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # rule to copy IPv4 src to IPv4 =
dst<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 group_id=3D1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern=3D[&quot;e=
th&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions=3D[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;modify_field op set dst_type ipv4_dst src_type ipv4_src width 32&quot;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t; / queue index 0&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # rule to copy src MAC to dst MA=
C<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 group_id=3D1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern=3D[&quot;e=
th&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions=3D[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;modify_field op set dst_type mac_dst src_type mac_src width 48 / queue in=
dex 0&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 expected_packet_list =3D [Ether() / IP(dst=3D&=
quot;192.68.1.1&quot;), Ether(dst=3D&quot;02:00:00:00:00:00&quot;)]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.runner(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verification_method=3Dself.send_=
packet_and_verify_modification,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flows=3Dflow_list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets=3Dpacket_list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id=3D0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expected_packets=3Dexpected_pack=
et_list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def test_egress_rules(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validate flow rules with egr=
ess directions.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create a list of packets to test=
, with a corresponding flow list.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Launch testpmd.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create first flow rule in flow l=
ist.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Send first packet in packet list=
, capture verbose output.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Delete flow rule, repeat for all=
 flows/packets.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Check that each packet is droppe=
d.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 One packet will be sent as a confidence check,=
 to ensure packets are being<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 received under normal circumstances.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet_list =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether(src=3D&quot;02:00:00:00:00=
:00&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether() / IP(src=3D&quot;192.168=
.1.1&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IP() / TCP(sport=3D1234),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IP() / UDP(sport=3D5000),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_list =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
egress&quot;, pattern=3D[&quot;eth src is 02:00:00:00:00:00&quot;], actions=
=3D[&quot;drop&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(direction=3D&quot;egres=
s&quot;, pattern=3D[&quot;ipv4 src is 192.168.1.1&quot;], actions=3D[&quot;=
drop&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(direction=3D&quot;egres=
s&quot;, pattern=3D[&quot;tcp src is 1234&quot;], actions=3D[&quot;drop&quo=
t;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(direction=3D&quot;egres=
s&quot;, pattern=3D[&quot;udp src is 5000&quot;], actions=3D[&quot;drop&quo=
t;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # verify reception with test packet<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet =3D Ether() / IP() / Raw(load=3D&quot;x=
xxxx&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmdShell() as testpmd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.start()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 received =3D self.send_packet_an=
d_capture(packet)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify(received !=3D [], &q=
uot;Test packet was never received.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.runner(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verification_method=3Dself.send_=
packet_and_verify,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flows=3Dflow_list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets=3Dpacket_list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id=3D1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 should_receive=3DFalse,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def test_jump_action(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validate flow rules with dif=
ferent group levels and jump actions.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create a list of packets to test=
, with a corresponding flow list.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Launch testpmd with the necessar=
y configuration.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create each flow rule in testpmd=
.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Send each packet in the list, ch=
eck Rx queue ID.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Check that each packet is receiv=
ed on the appropriate Rx queue.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet_list =3D [Ether() / IP(), Ether() / IP(=
) / TCP(), Ether() / IP() / UDP()]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_list =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 group_id=3D0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern=3D[&quot;e=
th / ipv4 / tcp&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions=3D[&quot;j=
ump group 1&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 group_id=3D0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern=3D[&quot;e=
th / ipv4 / udp&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions=3D[&quot;j=
ump group 2&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 group_id=3D1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern=3D[&quot;e=
th / ipv4 / tcp&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions=3D[&quot;q=
ueue index 2&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 group_id=3D2,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern=3D[&quot;e=
th / ipv4 / udp&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions=3D[&quot;q=
ueue index 3&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 group_id=3D0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern=3D[&quot;e=
th / ipv4&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions=3D[&quot;q=
ueue index 1&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 expected_queue_list =3D [1, 2, 3]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmdShell(rx_queues=3D4, tx_queues=3D4=
) as testpmd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_packet_and_verify_jump=
(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets=3Dpacket_l=
ist,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_rules=3Dflow_=
list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_queues=3Dexpe=
cted_queue_list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd=3Dtestpmd,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def test_priority_attribute(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validate flow rules with que=
ue actions and ethernet patterns.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create a list of packets to test=
, with a corresponding flow list.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Launch testpmd.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create first flow rule in flow l=
ist.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Send first packet in packet list=
, capture verbose output.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Delete flow rule, repeat for all=
 flows/packets.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Check that each packet is receiv=
ed on the appropriate queue.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_packet =3D Ether() / IP() / Raw()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_list =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 priority_level=3D3=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern=3D[&quot;e=
th / ipv4&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions=3D[&quot;q=
ueue index 1&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 priority_level=3D2=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern=3D[&quot;e=
th / ipv4&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions=3D[&quot;q=
ueue index 2&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 priority_level=3D1=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern=3D[&quot;e=
th / ipv4&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions=3D[&quot;q=
ueue index 3&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 expected_queue_list =3D [1, 2, 3]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmdShell(rx_queues=3D4, tx_queues=3D4=
) as testpmd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.set_verbose(level=3D8)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for flow, expected_queue in zip(=
flow_list, expected_queue_list):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_valid =3D testp=
md.flow_validate(flow_rule=3Dflow, port_id=3D0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify_else_s=
kip(is_valid, &quot;flow rule failed validation.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test=
pmd.flow_create(flow_rule=3Dflow, port_id=3D0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except Interactive=
CommandExecutionError:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
.log(&quot;Flow rule validation passed, but flow creation failed.&quot;)<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
.verify(False, &quot;Failed flow creation&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.start()<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_packet_a=
nd_capture(test_packet)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verbose_output =3D=
 testpmd.extract_verbose_output(testpmd.stop())<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 received =3D False=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for testpmd_packet=
 in verbose_output:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if t=
estpmd_packet.queue_id =3D=3D expected_queue:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 received =3D True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify(receiv=
ed, f&quot;Packet was not received on queue {expected_queue}&quot;)<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div></div>
</blockquote></div>

--000000000000b19a6806388ed343--
