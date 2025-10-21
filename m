Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9DECCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 15:13:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FC854067B;
	Tue, 21 Oct 2025 17:13:34 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id AC92A40677
 for <dev@dpdk.org>; Tue, 21 Oct 2025 17:13:32 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 048FE1063;
 Tue, 21 Oct 2025 08:13:24 -0700 (PDT)
Received: from arm.com (unknown [10.57.67.110])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C04D3F63F;
 Tue, 21 Oct 2025 08:13:30 -0700 (PDT)
Date: Tue, 21 Oct 2025 16:13:26 +0100
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: Dean Marx <dmarx@iol.unh.edu>
Cc: probb@iol.unh.edu, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Subject: Re: [PATCH v2 2/2] dts: add virtio forwarding test suite
Message-ID: <176105647358.88782.2909811739370348721.luca.vizzarro@arm.com>
References: <20250916200458.259376-1-dmarx@iol.unh.edu>
 <20251003192717.444490-1-dmarx@iol.unh.edu>
 <20251003192717.444490-2-dmarx@iol.unh.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003192717.444490-2-dmarx@iol.unh.edu>
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

On Fri, Oct 03, 2025 at 03:27:16PM +0000, Dean Marx wrote:
> Add test suite covering virtio-user and vhost
> server/client forwarding scenarios with
> testpmd packet validation.
> 
> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> ---
>  doc/api/tests.TestSuite_virtio_fwd.rst |   8 ++
>  dts/tests/TestSuite_virtio_fwd.py      | 180 +++++++++++++++++++++++++
>  2 files changed, 188 insertions(+)
>  create mode 100644 doc/api/tests.TestSuite_virtio_fwd.rst
>  create mode 100644 dts/tests/TestSuite_virtio_fwd.py
> 
> diff --git a/doc/api/tests.TestSuite_virtio_fwd.rst b/doc/api/tests.TestSuite_virtio_fwd.rst
> new file mode 100644
> index 0000000000..782eddad2d
> --- /dev/null
> +++ b/doc/api/tests.TestSuite_virtio_fwd.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: BSD-3-Clause
> +
> +virtio_fwd Test Suite
> +===========================
this is fine, but ideally should be aligned with the heading.
> +
> +.. automodule:: tests.TestSuite_virtio_fwd
> +   :members:
> +   :show-inheritance:
> \ No newline at end of file
> diff --git a/dts/tests/TestSuite_virtio_fwd.py b/dts/tests/TestSuite_virtio_fwd.py
> new file mode 100644
> index 0000000000..194bd24257
> --- /dev/null
> +++ b/dts/tests/TestSuite_virtio_fwd.py
> @@ -0,0 +1,180 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 University of New Hampshire
> +
> +"""Virtio forwarding test suite.
> +
> +Verify vhost/virtio pvp and loopback topology functionalities.
> +"""
> +
> +from scapy.layers.inet import IP
> +from scapy.layers.l2 import Ether
> +
> +from api.capabilities import LinkTopology
> +from api.testpmd import TestPmd
> +from api.testpmd.config import SimpleForwardingModes
> +from framework.parser import TextParser
> +from framework.test_suite import TestSuite, func_test
> +from framework.testbed_model.capability import requires
> +from framework.testbed_model.linux_session import LinuxSession
> +from framework.testbed_model.virtual_device import VirtualDevice
> +
> +
> +@requires(topology_type=LinkTopology.TWO_LINKS)
> +class TestVirtioFwd(TestSuite):
> +    """Virtio forwarding test suite."""
> +
> +    class ForwardingParsers:
> +        """Class for gathering Rx/Tx packets from testpmd stats."""
> +
> +        rx_packets = TextParser.find_int(r"RX-packets:\s*(\d+)")
> +        tx_packets = TextParser.find_int(r"TX-packets:\s*(\d+)")
> +
> +    class vdevs:
> +        """Class containing virtio-user and vhost-user virtual devices."""
is it actually vhost-user? or just vhost?
> +
> +        virtio_user = VirtualDevice(
> +            "net_virtio_user0,mac=00:01:02:03:04:05,path=/tmp/vhost-net,server=1"
> +        )
> +        vhost_user = VirtualDevice("eth_vhost0,iface=/tmp/vhost-net,client=1")

How come you put these properties under some internal classes? Not sure
how this helps. The vdevs class should technically be capitalised as
well. Either way if these are just class variables, they should be made
as such. Doing the following:

  parse_rx_packets: ClassVar[ParserFn] = TextParser...
  parse_tx_packets: ...
  virtio_user_vdev: ClassVar[VirtualDevice] = ...
  vhost_user_vdev: ...

is perfectly fine and acceptable.

I've changed the naming of the parser functions, because you are
effectively treating these as functions, then they should be named as
such.

> +
> +    @func_test
> +    def virtio_server(self) -> None:
> +        """Test virtio server packet transmission.
> +
> +        Steps:
> +            * Launch a testpmd session with a vhost-user virtual device (client side).
> +            * Launch a testpmd session with a virtio-user virtual device (server side).
> +            * Set the forwarding mode to mac in both sessions.
> +            * Start packet forwarding on vhost session.
> +            * Send a burst of packets from the virtio session.
> +            * Stop packet forwarding on vhost session and collect Rx packet stats.
> +
> +        Verify:
> +            * Vhost session receives packets from virtio session.
> +        """
> +        with (
> +            TestPmd(
> +                prefix="vhost",
> +                no_pci=True,
> +                memory_channels=4,
> +                vdevs=[self.vdevs.vhost_user],
> +            ) as vhost,
> +            TestPmd(
> +                prefix="virtio",
> +                no_pci=True,
> +                memory_channels=4,
> +                vdevs=[self.vdevs.virtio_user],
> +            ) as virtio,
> +        ):
> +            vhost.set_forward_mode(SimpleForwardingModes.mac)
> +            virtio.set_forward_mode(SimpleForwardingModes.mac)
> +
> +            vhost.start()
> +            virtio.start_tx_first(burst_num=32)
> +
> +            forwarding_stats = vhost.stop()
> +
> +            rx_packets = self.ForwardingParsers.rx_packets["TextParser_fn"](forwarding_stats) or 0
> +            tx_packets = self.ForwardingParsers.tx_packets["TextParser_fn"](forwarding_stats) or 0

So I understand you are basically reusing the functionality of the
TextParser functions here. I guess it's not a bad shout but I would not
expose the internals which are only meant to be used within the
TextParser class for handling with generic dataclass metadata.

Ideally we want this:

  rx_packets = self.parse_rx_packets(forwarding_stats) or 0

You can implement __call__ in ParserFn to make this happen. In the best
scenario we'd want the return type to be correct as well instead of just
Any. If you want to, you can play around and implement a Generic[T] in
ParserFn to replace Any with T. This will probably require you to make
changes elsewhere though. It may get tricky easily, so it's not really
mandatory.

> +
> +            self.verify(
> +                rx_packets != 0 and tx_packets != 0,
> +                "Vhost session failed to receive packets from virtio session.",
> +            )
> +
> +    @func_test
> +    def virtio_server_reconnect(self) -> None:
> +        """Test virtio server reconnection.
> +
> +        Steps:
> +            * Launch a testpmd session with a vhost-user virtual device (client side).
> +            * Launch a testpmd session with a virtio-user virtual device (server side).
> +            * Close the virtio session and relaunch it.
> +            * Start packet forwarding on vhost session.
> +            * Send a burst of packets from the virtio session.
> +            * Stop packet forwarding on vhost session and collect Rx packet stats.
> +
> +        Verify:
> +            * Vhost session receives packets from relaunched virtio session.
> +        """
> +        with TestPmd(
> +            prefix="vhost",
> +            no_pci=True,
> +            memory_channels=4,
> +            vdevs=[self.vdevs.vhost_user],
> +        ) as vhost:
> +            with TestPmd(
> +                prefix="virtio",
> +                no_pci=True,
> +                memory_channels=4,
> +                vdevs=[self.vdevs.virtio_user],
> +            ) as virtio:
> +                pass
> +            # end session and reconnect
> +            with TestPmd(
> +                prefix="virtio",
> +                no_pci=True,
> +                memory_channels=4,
> +                vdevs=[self.vdevs.virtio_user],
> +            ) as virtio:
> +                virtio.set_forward_mode(SimpleForwardingModes.mac)
> +                vhost.set_forward_mode(SimpleForwardingModes.mac)
> +
> +                vhost.start()
> +                virtio.start_tx_first(burst_num=32)
> +
> +                forwarding_stats = vhost.stop()
> +
> +                rx_packets = (
> +                    self.ForwardingParsers.rx_packets["TextParser_fn"](forwarding_stats) or 0
> +                )
> +                tx_packets = (
> +                    self.ForwardingParsers.tx_packets["TextParser_fn"](forwarding_stats) or 0
> +                )
> +
> +                self.verify(
> +                    rx_packets != 0 and tx_packets != 0,
> +                    "Vhost session failed to receive packets from virtio session.",
> +                )
> +
> +    @func_test
> +    def pvp_loop(self) -> None:
> +        """Test vhost/virtio physical-virtual-physical loop topology.
> +
> +        Steps:
> +            * Launch testpmd session with a physical NIC and virtio-user vdev
> +                connected to a vhost-net socket.
> +            * Configure the tap interface that is created with IP address and
> +                set link state to UP.
> +            * Launch second testpmd session with af_packet vdev connected to
> +                the tap interface.
> +            * Start packet forwarding on both testpmd sessions.
> +            * Send 100 packets to the physical interface from external tester.
> +            * Capture packets on the same physical interface.
> +
> +        Verify:
> +            * Physical interface receives all 100 sent packets.
> +        """
> +        self.sut_node = self._ctx.sut_node
> +        if not isinstance(self.sut_node.main_session, LinuxSession):
> +            self.verify(False, "Must be running on a Linux environment.")
> +        with TestPmd(
> +            prefix="virtio",
> +            vdevs=[VirtualDevice("virtio_user0,path=/dev/vhost-net,queues=1,queue_size=1024")],
> +        ) as virtio:
> +            self.sut_node.main_session.send_command("ip link set dev tap0 up", privileged=True)

This should have been implemented as part of main_session. If it's not,
it should. Shouldn't call send_command directly like this.

> +            with TestPmd(
> +                prefix="vhost", no_pci=True, vdevs=[VirtualDevice("net_af_packet0,iface=tap0")]
> +            ) as vhost:
> +                virtio.set_forward_mode(SimpleForwardingModes.mac)
> +                vhost.set_forward_mode(SimpleForwardingModes.mac)
> +                vhost.start()
> +                virtio.start()
> +
> +                packet = Ether() / IP()
> +                packets = [packet] * 100
> +                captured_packets = self.send_packets_and_capture(packets)
> +
> +                self.verify(
> +                    len(captured_packets) >= 100, "Sent packets not received on physical interface."
> +                )
> -- 
> 2.51.0
> 
