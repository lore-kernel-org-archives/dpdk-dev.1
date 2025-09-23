Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B394DCAC5B0
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 11:38:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEE6F402EB;
	Tue, 23 Sep 2025 13:38:08 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id A1038402CB
 for <dev@dpdk.org>; Tue, 23 Sep 2025 13:38:06 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B616B2F;
 Tue, 23 Sep 2025 04:37:57 -0700 (PDT)
Received: from arm.com (unknown [10.57.63.189])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCE8B3F66E;
 Tue, 23 Sep 2025 04:38:04 -0700 (PDT)
Date: Tue, 23 Sep 2025 12:38:00 +0100
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: Dean Marx <dmarx@iol.unh.edu>
Cc: probb@iol.unh.edu, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Subject: Re: [PATCH v1 2/2] dts: add virtio forwarding test suite
Message-ID: <175862694193.36951.18019709083217178912.luca.vizzarro@arm.com>
References: <20250916200458.259376-1-dmarx@iol.unh.edu>
 <20250916200458.259376-2-dmarx@iol.unh.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916200458.259376-2-dmarx@iol.unh.edu>
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

On Tue, Sep 16, 2025 at 04:04:58PM +0000, Dean Marx wrote:
> diff --git a/dts/tests/TestSuite_virtio_fwd.py b/dts/tests/TestSuite_virtio_fwd.py
> new file mode 100644
> index 0000000000..3521fdfc08
> --- /dev/null
> +++ b/dts/tests/TestSuite_virtio_fwd.py
> @@ -0,0 +1,179 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 University of New Hampshire
> +
> +"""Virtio forwarding test suite.
> +
> +Verify vhost/virtio pvp and loopback topology functionalities.
> +"""
> +
> +import re
> +
> +from scapy.layers.inet import IP
> +from scapy.layers.l2 import Ether
> +
> +from framework.params.testpmd import SimpleForwardingModes
> +from framework.remote_session.testpmd_shell import TestPmdShell
> +from framework.test_suite import TestSuite, func_test
> +from framework.testbed_model.capability import requires
> +from framework.testbed_model.linux_session import LinuxSession
> +from framework.testbed_model.topology import TopologyType
> +from framework.testbed_model.virtual_device import VirtualDevice
> +
> +
> +@requires(topology_type=TopologyType.two_links)
> +class TestVirtioFwd(TestSuite):
> +    """Virtio forwarding test suite."""
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
> +            TestPmdShell(
> +                prefix="vhost",
> +                no_pci=True,
> +                memory_channels=4,
> +                vdevs=[VirtualDevice("eth_vhost0,iface=/tmp/vhost-net,client=1")],
> +            ) as vhost,
> +            TestPmdShell(
> +                prefix="virtio",
> +                no_pci=True,
> +                memory_channels=4,
> +                vdevs=[
> +                    VirtualDevice(
> +                        "net_virtio_user0,mac=00:01:02:03:04:05,path=/tmp/vhost-net,server=1"
> +                    )
> +                ],
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
> +            match_rx = re.search(r"RX-packets:\s*(\d+)", forwarding_stats)
> +            match_tx = re.search(r"TX-packets:\s*(\d+)", forwarding_stats)
> +            rx_packets = int(match_rx[1]) if match_rx else 0
> +            tx_packets = int(match_tx[1]) if match_tx else 0

Would it be worth introducing a TextParser class that will actually
parse the forwarding stats and present them properly to the test?

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
> +        with TestPmdShell(
> +            prefix="vhost",
> +            no_pci=True,
> +            memory_channels=4,
> +            vdevs=[VirtualDevice("eth_vhost0,iface=/tmp/vhost-net,client=1")],
> +        ) as vhost:
> +            with TestPmdShell(
> +                prefix="virtio",
> +                no_pci=True,
> +                memory_channels=4,
> +                vdevs=[
> +                    VirtualDevice(
> +                        "net_virtio_user0,mac=00:01:02:03:04:05,path=/tmp/vhost-net,server=1"
> +                    )
> +                ],
> +            ) as virtio:
> +                pass
> +            # end session and reconnect
how could this is launched twice? Could use some explanation here.
> +            with TestPmdShell(
> +                prefix="virtio",
> +                no_pci=True,
> +                memory_channels=4,
> +                vdevs=[
> +                    VirtualDevice(
> +                        "net_virtio_user0,mac=00:01:02:03:04:05,path=/tmp/vhost-net,server=1"
> +                    )
Wouldn't it make more sense to store the vdev in a variable and re-use
it?
> +                ],
> +            ) as virtio:
> +                virtio.set_forward_mode(SimpleForwardingModes.mac)
> +                vhost.set_forward_mode(SimpleForwardingModes.mac)
> +
> +                vhost.start()
> +                virtio.start_tx_first(burst_num=32)
> +
> +                forwarding_stats = vhost.stop()
> +
> +                match_rx = re.search(r"RX-packets:\s*(\d+)", forwarding_stats)
> +                match_tx = re.search(r"TX-packets:\s*(\d+)", forwarding_stats)
> +                rx_packets = int(match_rx[1]) if match_rx else 0
> +                tx_packets = int(match_tx[1]) if match_tx else 0
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
> +        if not isinstance(self._ctx.sut_node.main_session, LinuxSession):
surely you could just use the `self.sut_node` you've just created :D
> +            self.verify(False, "Must be running on a Linux environment.")
> +        with TestPmdShell(
> +            prefix="virtio",
> +            vdevs=[VirtualDevice("virtio_user0,path=/dev/vhost-net,queues=1,queue_size=1024")],
> +        ) as virtio:
> +            self.sut_node.main_session.send_command("ip link set dev tap0 up", privileged=True)
> +            with TestPmdShell(
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
