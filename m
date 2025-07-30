Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B49C83F26
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Jul 2025 13:19:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CA9F40E41;
	Wed, 30 Jul 2025 15:19:16 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 85C31402C3
 for <dev@dpdk.org>; Wed, 30 Jul 2025 15:19:14 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4D9F1E5E;
 Wed, 30 Jul 2025 06:19:05 -0700 (PDT)
Received: from [192.168.50.107] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 899E83F66E; Wed, 30 Jul 2025 06:19:12 -0700 (PDT)
Message-ID: <938781a3-b6b1-484d-ab8a-18a048870938@arm.com>
Date: Wed, 30 Jul 2025 14:19:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] dts: add qinq test suite
Content-Language: en-GB
To: Dean Marx <dmarx@iol.unh.edu>, probb@iol.unh.edu,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org
References: <20250605184143.498892-2-dmarx@iol.unh.edu>
 <20250717205718.108826-1-dmarx@iol.unh.edu>
 <20250717205718.108826-2-dmarx@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250717205718.108826-2-dmarx@iol.unh.edu>
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

Hi Dean,

thank you so much for your patch. Looks mostly correct, just lots of 
polishing suggestions for a more readable code.

On 17/07/2025 21:57, Dean Marx wrote:
> +"""QinQ (802.1ad) Test Suite.
> +
> +This test suite verifies the correctness and capability of DPDK Poll Mode Drivers (PMDs)
> +in handling QinQ-tagged Ethernet frames, which contain a pair of stacked VLAN headers
> +(outer S-VLAN and inner C-VLAN). These tests ensure that both software and hardware offloads
> +related to QinQ behave as expected across different NIC vendors and PMD implementations.
> +
extra new line not needed.
> +"""

> +class TestQinq(TestSuite):
> <snip>
> +    def send_packet_and_verify(
> +        self, packet: Packet, testpmd: TestPmdShell, should_receive: bool
> +    ) -> None:
> <snip>
> +        if should_receive:
> +            self.verify(received != [], "Packet was dropped when it should have been received.")
> +        else:
> +            self.verify(received == [], "Packet was received when it should have been dropped.")
Quite an unusual way to check if a list is (not) empty. I'd just exploit 
the boolean check on lists in this case. Also send_packet_and_capture 
returns a list of packets, received is a misleading name as it indicates 
it returns a boolean instead. For clarity, you could do:

   packets = send_packet_and_capture(..)
   not_received = not packets

> +    @requires(NicCapability.RX_OFFLOAD_VLAN_EXTEND)
> +    @func_test
> +    def test_qinq_filter(self) -> None:
> <snip>
> +        with TestPmdShell() as testpmd:
> +            testpmd.stop_all_ports()
> +            testpmd.set_vlan_filter(0, True)
> +            testpmd.set_vlan_extend(0, True)
> +            testpmd.start_all_ports()
> +            testpmd.rx_vlan(100, 0, True)
> +            self.send_packet_and_verify(packets[0], testpmd, should_receive=True)
> +            self.send_packet_and_verify(packets[1], testpmd, should_receive=False)

Help me understand what's happening here. set_vlan_filter and 
set_vlan_extend are decorated with @requires_stopped_ports. That means 
that stop_all_ports will be called automatically, so that removes the 
need for it.

What confuses me is that rx_vlan is also decorated with 
@requires_stopped_ports, which makes the preceding start_all_ports a 
redundant action.

The underlying testpmd.start() in send_packet_and_verify is decorated 
with @requires_started_ports, so it'd also make calling start_all_ports 
redundant even if it were placed in the correct order.

My current understanding is that both stop_all_ports and start_all_ports 
are redundant, and the latter is a potential bug (due to its bad 
placement) and the test case only works thanks to the decorators. If 
this is the case then both stop_all_ports and start_all_ports should go.

> +
> +    @func_test
> +    def test_qinq_forwarding(self) -> None:
> +        """QinQ Rx filter test case.
> +
> +        Steps:
> +            Launch testpmd with mac forwarding mode.
> +            Disable VLAN filter mode on port 0.
> +            Send test packet and capture verbose output.
> +
> +        Verify:
> +            Check that the received packet has two separate VLAN layers in proper QinQ fashion.
> +            Check that the received packet outer and inner VLAN layer has the appropriate ID.
> +        """
> +        test_packet = (
> +            Ether(dst="ff:ff:ff:ff:ff:ff")
> +            / Dot1AD(vlan=100)
> +            / Dot1Q(vlan=200)
> +            / IP(dst="1.2.3.4")
> +            / UDP(dport=1234, sport=4321)
> +        )
> +        with TestPmdShell() as testpmd:
> +            testpmd.stop_all_ports()
not needed
> +            testpmd.set_vlan_filter(0, False)
> +            testpmd.start_all_ports()
not needed
> +            testpmd.start()
> +            received_packet = self.send_packet_and_capture(test_packet)
received_packets
> +
> +            self.verify(
> +                received_packet != [], "Packet was dropped when it should have been received."
> +            )
not received_packets
> +
> +            for packet in received_packet:
> +                vlan_tags = packet.getlayer(Dot1AD), packet.getlayer(Dot1Q)
> +                self.verify(len(vlan_tags) == 2, f"Expected 2 VLAN tags, found {len(vlan_tags)}")
I am expecting this will always be True. You are creating a fixed-size 
tuple[Dot1AD | None, Dot1Q | None]. So even if both are None vlan_tags 
will still be (None, None) which is 2 None items. Since you don't 
actually use vlan_tags, it may easier to verify the presence of the 
layer of directly, but for Dot1Q it already happens herebelow. So I'd 
just check Dot1AD:

   self.verify(packet.haslayer(Dot1AD), ...)

> +
> +                if packet.haslayer(Dot1Q):
> +                    outer_vlan_id = packet[Dot1Q].vlan
It may be more readable to take advantage of getlayer in the if:

   if outer_vlan := packet.getlayer(Dot1Q):
       outer_vlan_id = outer_vlan.vlan
> +                    self.verify(
> +                        outer_vlan_id == 100,
> +                        f"Outer VLAN ID was {outer_vlan_id} when it should have been 100.",
> +                    )
> +                else:
> +                    self.verify(False, "VLAN layer not found in received packet.")
> +
> +                if packet[Dot1Q].haslayer(Dot1Q):
> +                    inner_vlan_id = packet[Dot1Q].payload[Dot1Q].vlan
the above approach helps to avoid this chain:

     if inner_vlan := outer_vlan.getlayer(Dot1Q):
         inner_vlan_id = inner_vlan.vlan
> +                    self.verify(
> +                        inner_vlan_id == 200,
> +                        f"Inner VLAN ID was {inner_vlan_id} when it should have been 200",
> +                    )
> +
> +    @func_test
> +    def test_mismatched_tpid(self) -> None:
> +        """Test behavior when outer VLAN tag has a non-standard TPID (not 0x8100 or 0x88a8).
> +
> +        Steps:
> +            Launch testpmd in mac forward mode.
> +            Set verbose level to 1.
> +            Disable VLAN filtering on port 0.
> +            Send and capture test packet.
> +
> +        Verify:
> +            Only 1 VLAN tag is in received packet.
> +            Inner VLAN ID matches the original packet.
> +        """
> +        with TestPmdShell() as testpmd:
> +            testpmd.set_verbose(level=1)
> +            testpmd.stop_all_ports()
not needed
> +            testpmd.set_vlan_filter(0, False)
> +            testpmd.start_all_ports()
not needed
> +            testpmd.start()
> +
> +            mismatched_packet = (
> +                Ether(dst="ff:ff:ff:ff:ff:ff")
> +                / Dot1Q(vlan=100, type=0x1234)
> +                / Dot1Q(vlan=200)
> +                / IP(dst="1.2.3.4")
> +                / UDP(dport=1234, sport=4321)
> +            )
> +
> +            received_packet = self.send_packet_and_capture(mismatched_packet)
reiceved_packets
> +
> +            self.verify(
> +                received_packet != [], "Packet was dropped when it should have been received."
> +            )
not received_packets
> +
> +            for packet in received_packet:
> +                vlan_tags = [layer for layer in packet.layers() if layer == Dot1Q]
> +                self.verify(
> +                    len(vlan_tags) == 1,
> +                    f"Expected 1 VLAN tag due to mismatched TPID, found {len(vlan_tags)}",
> +                )
> +
> +                vlan_id = packet[Dot1Q].vlan
you already collected the layer in vlan_tags, and the above verify 
guarantees we have one tag. This should just be:
   vlan_tags[0].vlan

> +                self.verify(vlan_id == 200, f"Expected inner VLAN ID 200, got {vlan_id}")
> +
> +    def strip_verify(
> +        self, packet: Packet, expected_num_tags: int, context: str, check_id: bool = False
since expected_num_tags can be only 0 or 1, I'd make this a bool, since 
this function doesn't handle any other number (and could become a problem).
> +    ) -> None:
> +        """Helper method for verifying packet stripping functionality."""
> +        if expected_num_tags == 0:
> +            has_vlan = bool(packet.haslayer(Dot1Q))
> +            if not has_vlan:
> +                self.verify(True, "Packet contained VLAN layer")
this verify will never trigger, meant to be False? Although I think this 
whole block is redundant.
> +            else:
> +                vlan_layer = packet.getlayer(Dot1Q)
> +                self.verify(
> +                    vlan_layer is not None
all of the above could be greatly simplified with the approach suggested 
so far:

     if vlan_layer := packet.getlayer(Dot1Q):
         self.verify(vlan_layer.type != ...)
         ...

No `else` needed.
> +                    and vlan_layer.type != 0x8100
> +                    and vlan_layer.type != 0x88A8,
> +                    f"""VLAN tags found in packet when should have been stripped: {packet.summary()}
> +                    sent packet: {context}""",
> +                )
> +        if expected_num_tags == 1:
> +
> +            def count_vlan_tags(packet: Packet) -> int:
> +                """Method for counting the number of VLAN layers in a packet."""
> +                count = 0
> +                layer = packet.getlayer(Dot1Q)
> +                while layer:
> +                    if layer.type == 0x8100:
> +                        count += 1
> +                    layer = layer.payload.getlayer(Dot1Q)
> +                return count
Unless I am misunderstanding this could be greater simplified with:

     tag_count = [
         type(layer) is Dot1Q and layer.type == 0x8100
         for layer in packet.layers()
     ].count(True)

> +
> +            tag_count = count_vlan_tags(packet)
You are calling this only once as far as I can see. So why make it a 
local function (not a method)?
> +            self.verify(
> +                tag_count == 1,
> +                f"""Expected one 0x8100 VLAN tag but found {tag_count}: {packet.summary()}
> +                sent packet: {context}""",
please no triple quotes
> +            )
> +            first_dot1q = packet.getlayer(Dot1Q)
since you actually want the first layer, I'd then change the list 
comprehension above so that you can avoid checking for None again:

    dot1q_layers = [
        layer
        for layer in packet.layers()
        if type(layer) is Dot1Q and layer.type == 0x8100
    ]

    self.verify(len(dot1q_layers) == 1, ...)

    ...

    first_dot1q = dot1q_layers[0]
> +            self.verify(
> +                first_dot1q is not None and first_dot1q.type == 0x8100,
> +                f"""VLAN tag 0x8100 not found in packet: {packet.summary()}
> +                sent packet: {context}""",
no triple quotes
> +            )
> +            if check_id:
> +                self.verify(
> +                    packet[Dot1Q].vlan == 200,
is this just meant to be first_dot1q?
> +                    f"""VLAN ID 200 not found in received packet: {packet.summary()}
> +                    sent packet: {context}""",
no triple quotes
> +                )
> +
> +    @requires(NicCapability.RX_OFFLOAD_VLAN_STRIP)
> +    @func_test
> +    def test_vlan_strip(self) -> None:
> +        """Test combinations of VLAN/QinQ strip settings with various QinQ packets.
> +
> +        Steps:
> +            Launch testpmd with VLAN strip enabled.
> +            Send four VLAN/QinQ related test packets.
> +
> +        Verify:
> +            Check received packets have the expected VLAN/QinQ layers/tags.
> +        """
> +        test_packets = [
> +            Ether() / Dot1Q(type=0x8100) / IP() / UDP(dport=1234, sport=4321),
> +            Ether()
> +            / Dot1Q(vlan=100, type=0x8100)
> +            / Dot1Q(vlan=200, type=0x8100)
> +            / IP()
> +            / UDP(dport=1234, sport=4321),
> +            Ether() / Dot1Q(type=0x88A8) / IP() / UDP(dport=1234, sport=4321),
> +            Ether() / Dot1Q(type=0x88A8) / Dot1Q(type=0x8100) / IP() / UDP(dport=1234, sport=4321),
> +        ]
> +        with TestPmdShell() as testpmd:
> +            testpmd.stop_all_ports()
not needed
> +            testpmd.set_vlan_strip(0, True)
> +            testpmd.start_all_ports()
not needed
> +            testpmd.start()
> +
> +            rec1 = self.send_packet_and_capture(test_packets[0])
> +            rec2 = self.send_packet_and_capture(test_packets[1])
> +            rec3 = self.send_packet_and_capture(test_packets[2])
> +            rec4 = self.send_packet_and_capture(test_packets[3])
> +
> +            testpmd.stop()
> +
> +            try:
> +                context = "Single VLAN"
> +                self.strip_verify(rec1[0], 0, context)
> +                context = "Stacked VLAN"
> +                self.strip_verify(rec2[0], 1, context, check_id=True)
> +                context = "Single S-VLAN"
> +                self.strip_verify(rec3[0], 0, context)
> +                context = "QinQ"
> +                self.strip_verify(rec4[0], 1, context)
> +            except IndexError:
> +                self.verify(
> +                    False, f"{context} packet was dropped when it should have been received."
> +                )
what guarantees us that the packet we sent is the first one to be received?
> +
> +    @requires(NicCapability.RX_OFFLOAD_QINQ_STRIP)
> +    @func_test
> +    def test_qinq_strip(self) -> None:
> +        """Test combinations of VLAN/QinQ strip settings with various QinQ packets.
> +
> +        Steps:
> +            Launch testpmd with QinQ and VLAN strip enabled.
> +            Send four VLAN/QinQ related test packets.
> +
> +        Verify:
> +            Check received packets have the expected VLAN/QinQ layers/tags.
> +        """
> +        test_packets = [
> +            Ether() / Dot1Q(type=0x8100) / IP() / UDP(dport=1234, sport=4321),
> +            Ether()
> +            / Dot1Q(vlan=100, type=0x8100)
> +            / Dot1Q(vlan=200, type=0x8100)
> +            / IP()
> +            / UDP(dport=1234, sport=4321),
> +            Ether() / Dot1Q(type=0x88A8) / IP() / UDP(dport=1234, sport=4321),
> +            Ether() / Dot1Q(type=0x88A8) / Dot1Q(type=0x8100) / IP() / UDP(dport=1234, sport=4321),
> +        ]
> +        with TestPmdShell() as testpmd:
> +            testpmd.stop_all_ports()
not needed
> +            testpmd.set_qinq_strip(0, True)
> +            testpmd.start_all_ports()
not needed
> +            testpmd.start()
> +
> +            rec1 = self.send_packet_and_capture(test_packets[0])
> +            rec2 = self.send_packet_and_capture(test_packets[1])
> +            rec3 = self.send_packet_and_capture(test_packets[2])
> +            rec4 = self.send_packet_and_capture(test_packets[3])
> +
> +            testpmd.stop()
> +
> +            try:
> +                context = "Single VLAN"
> +                self.strip_verify(rec1[0], 0, context)
> +                context = "Stacked VLAN"
> +                self.strip_verify(rec2[0], 1, context, check_id=True)
> +                context = "Single S-VLAN"
> +                self.strip_verify(rec3[0], 0, context)
> +                context = "QinQ"
> +                self.strip_verify(rec4[0], 0, context)
> +            except IndexError:
> +                self.log(f"{context} packet was dropped when it should have been received.")
this is actually virtually identical (with only one line of difference) 
to test_vlan_strip. Could we remove this duplication?

Luca

