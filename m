Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0430BCAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 11:45:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30532402A0;
	Wed,  8 Oct 2025 13:45:43 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id E5B4940297
 for <dev@dpdk.org>; Wed,  8 Oct 2025 13:45:41 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FBDA22FC;
 Wed,  8 Oct 2025 04:45:33 -0700 (PDT)
Received: from arm.com (unknown [10.57.68.134])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D05F3F66E;
 Wed,  8 Oct 2025 04:45:39 -0700 (PDT)
Date: Wed, 8 Oct 2025 12:45:35 +0100
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: Patrick Robb <probb@iol.unh.edu>
Cc: dev@dpdk.org, Paul.Szczepanek@arm.com, dmarx@iol.unh.edu, 
 abailey@iol.unh.edu, Nicholas Pratte <npratte@iol.unh.edu>
Subject: Re: [PATCH v4 1/3] dts: rework traffic generator inheritance structure
Message-ID: <175992171905.88979.8170698746444654418.luca.vizzarro@arm.com>
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20251001231659.2297751-1-probb@iol.unh.edu>
 <20251001231659.2297751-2-probb@iol.unh.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001231659.2297751-2-probb@iol.unh.edu>
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

Hi Patrick,

I am assuming the move of send_packets is because we can't send
arbitrary packets with a perf generator. I believe this should be
explained as it's not clear why the move and it feels counterintuitive
at first.

On Wed, Oct 01, 2025 at 07:16:57PM +0000, Patrick Robb wrote:
> diff --git a/dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py b/dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py
> new file mode 100644
> index 0000000000..6b23faa1a5
> --- /dev/null
> +++ b/dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py
> @@ -0,0 +1,63 @@
> +"""Traffic generators for performance tests which can generate a high number of packets."""
> +
> +from abc import abstractmethod
> +from dataclasses import dataclass
> +
> +from scapy.packet import Packet
> +
> +from framework.testbed_model.topology import Topology
> +
> +from .traffic_generator import TrafficGenerator
> +
> +
> +@dataclass(slots=True)
> +class PerformanceTrafficStats:
> +    """Data structure to store performance statistics for a given test run.
> +
> +    Attributes:
> +        tx_pps: Recorded tx packets per second
> +        tx_bps: Recorded tx bytes per second
> +        rx_pps: Recorded rx packets per second
> +        rx_bps: Recorded rx bytes per second
> +        frame_size: The total length of the frame
nit: missing full stops at the end of each attribute.
> +    """
> +
> +    tx_pps: float
> +    tx_bps: float
> +    rx_pps: float
> +    rx_bps: float
> +
> +    frame_size: int | None = None
> +
> +
> +class PerformanceTrafficGenerator(TrafficGenerator):
> +    """An abstract base class for all performance-oriented traffic generators.
> +
> +    Provides an intermediary interface for performance-based traffic generator.
> +    """
> +
> +    @abstractmethod
> +    def calculate_traffic_and_stats(
> +        self,
> +        packet: Packet,
> +        duration: float,
> +        send_mpps: int | None = None,
> +    ) -> PerformanceTrafficStats:
> +        """Send packet traffic and acquire associated statistics.
> +
> +        If `send_mpps` is provided, attempt to transmit traffic at the `send_mpps` rate.
> +        Otherwise, attempt to transmit at line rate.
> +
> +        Args:
> +            packet: The packet to send.
> +            duration: Performance test duration (in seconds).
> +            send_mpps: The millions packets per second send rate.
> +
> +        Returns:
> +            Performance statistics of the generated test.
> +        """
> +
> +    def setup(self, topology: Topology) -> None:
> +        """Overrides :meth:`.traffic_generator.TrafficGenerator.setup`."""
> +        for port in self._tg_node.ports:
> +            self._tg_node.main_session.configure_port_mtu(2000, port)

should do:
  port.configure_mtu(2000)
