Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DE6CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 12:26:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EE01402EB;
	Tue, 23 Sep 2025 14:26:18 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 1541D402CB
 for <dev@dpdk.org>; Tue, 23 Sep 2025 14:26:17 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6358AFEC;
 Tue, 23 Sep 2025 05:26:08 -0700 (PDT)
Received: from arm.com (unknown [10.57.63.189])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A64263F694;
 Tue, 23 Sep 2025 05:26:15 -0700 (PDT)
Date: Tue, 23 Sep 2025 13:26:12 +0100
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu, 
 ivan.malov@arknetworks.am
Subject: Re: [PATCH v3 3/3] dts: update tx_offload test from old dts
Message-ID: <175863028955.40368.11422459804064526246.luca.vizzarro@arm.com>
References: <20250902142725.56736-1-abailey@iol.unh.edu>
 <20250917124243.31567-1-abailey@iol.unh.edu>
 <20250917124243.31567-4-abailey@iol.unh.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917124243.31567-4-abailey@iol.unh.edu>
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

Hi Andrew,

Thank you for this. You should also add a documentation page for the new
test.

On Wed, Sep 17, 2025 at 08:42:43AM +0000, Andrew Bailey wrote:
> Currently, the RX/TX offload test in old DTS expects the TX ports to be
> initially configured to use mbuf fast free. This is no longer the case
> and must be updated to assume mbuf fast free is not initially utilized
> by capable NICs. Add updated test suite to test mbuf fast free
> configuration.
> 
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
>  dts/tests/TestSuite_rx_tx_offload.py | 130 +++++++++++++++++++++++++++
>  1 file changed, 130 insertions(+)
>  create mode 100644 dts/tests/TestSuite_rx_tx_offload.py
> 
> diff --git a/dts/tests/TestSuite_rx_tx_offload.py b/dts/tests/TestSuite_rx_tx_offload.py
> new file mode 100644
> index 0000000000..f97bb4978a
> --- /dev/null
> +++ b/dts/tests/TestSuite_rx_tx_offload.py
> @@ -0,0 +1,130 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 University of New Hampshire
> +
> +"""RX TX offload test suite.
> +
> +Test the testpmd feature of configuring RX and TX offloads.
> +"""
> +
> +from typing import Optional
> +
> +from framework.remote_session.testpmd_shell import (
> +    OffloadConfiguration,
> +    RxTxLiteralSwitch,
> +    TestPmdShell,
> +)
> +from framework.test_suite import TestSuite, func_test
> +from framework.testbed_model.capability import NicCapability, requires
> +
> +
> +class TestRxTxOffload(TestSuite):
> +    """RX/TX offload test suite."""
> +
> +    def _check_config(
> +        self,
> +        testpmd: TestPmdShell,
> +        port_offload: str | None,
> +        rxtx: RxTxLiteralSwitch,
> +        port_id: int,
> +        /,
> +        queue_offload: Optional[list[str | None]] = None,
> +        verify: bool = True,
> +    ) -> bool:
> +        config: OffloadConfiguration = testpmd.get_offload_config(rxtx, port_id, verify)
> +        if config.port.name != port_offload:
> +            return False
> +
> +        if queue_offload:
> +            for i, q in enumerate(config.queues):
> +                if q.name != queue_offload[i]:
> +                    return False
> +        return True
> +
> +    def _set_all_queues_mbuf_fast_free(
> +        self, testpmd: TestPmdShell, on: bool, port_id: int, num_queues: int, /, verify: bool = True
> +    ) -> None:
> +        for i in range(num_queues):
> +            testpmd.set_queue_mbuf_fast_free(on, port_id, i, verify)
> +
> +    @requires(NicCapability.PORT_TX_OFFLOAD_MBUF_FAST_FREE)
> +    @func_test
> +    def test_mbuf_fast_free_configuration_per_port(self) -> None:
> +        """Ensure mbuf_fast_free can be configured with testpmd per port.
> +
> +        Steps:
> +            * Start up testpmd shell.
> +            * Toggle mbuf_fast_free on per port.
> +            * Toggle mbuf_fast_free off per port.
> +
> +        Verify:
> +            * Mbuf_fast_free starts disabled.
> +            * Mbuf_fast_free can be configured on per port.
> +            * Mbuf_fast_free can be configured off per port.
> +        """
> +        with TestPmdShell() as testpmd:
> +            verify = True
> +            port_id = 0
> +            testpmd.start_all_ports()
> +
> +            # Ensure MBUF_FAST_FREE is disabled by default and verify
> +            self.verify(
> +                self._check_config(testpmd, None, "tx", port_id, verify=verify),
> +                "MBUF_FAST_FREE enabled on port start.",
> +            )
> +            # Enable MBUF_FAST_FREE per port and verify
> +            testpmd.set_port_mbuf_fast_free(True, port_id, verify)
> +            self.verify(
> +                self._check_config(
> +                    testpmd, "TX_OFFLOAD_MBUF_FAST_FREE", "tx", port_id, verify=verify
> +                ),
> +                "Failed to enable MBUF_FAST_FREE on port.",
> +            )
> +            # Disable MBUF_FAST_FREE per port and verify
> +            testpmd.set_port_mbuf_fast_free(False, port_id, verify)
> +            self.verify(
> +                self._check_config(testpmd, None, "tx", port_id, verify=verify),
> +                "Failed to disable MBUF_FAST_FREE on port.",
> +            )
> +
> +    @requires(NicCapability.QUEUE_TX_OFFLOAD_MBUF_FAST_FREE)
> +    @func_test
> +    def test_mbuf_fast_free_configuration_per_queue(self) -> None:
> +        """Ensure mbuf_fast_free can be configured with testpmd.
> +
> +        Steps:
> +            * Start up testpmd shell.
> +            * Toggle mbuf_fast_free on per queue.
> +            * Toggle mbuf_fast_free off per queue.
> +
> +        Verify:
> +            * Mbuf_fast_free starts disabled.
> +            * Mbuf_fast_free can be configured on per queue.
> +            * Mbuf_fast_free can be configured off per queue.
> +        """
> +        with TestPmdShell() as testpmd:
> +            verify = True
> +            port_id = 0
> +            num_queues = 4
> +            queue_off: Optional[list[str | None]] = [None] * num_queues
> +            queue_on: Optional[list[str | None]] = ["TX_OFFLOAD_MBUF_FAST_FREE"] * num_queues
Optional is deprecated in the version of Python we are using in favour
of `| None`
> +
> +            testpmd.set_ports_queues(num_queues)
> +            testpmd.start_all_ports()
> +
> +            # Ensure mbuf_fast_free is disabled by default on port and queues
> +            self.verify(
> +                self._check_config(testpmd, None, "tx", port_id, queue_off, verify=verify),
> +                "MBUF_FAST_FREE enabled on queue start.",
> +            )
> +            # Enable mbuf_fast_free per queue and verify
> +            self._set_all_queues_mbuf_fast_free(testpmd, True, port_id, num_queues, verify)
> +            self.verify(
> +                self._check_config(testpmd, None, "tx", port_id, queue_on, verify),
> +                "Failed to enable MBUF_FAST_FREE on all queues.",
> +            )
> +            # Disable mbuf_fast_free per queue and verify
> +            self._set_all_queues_mbuf_fast_free(testpmd, False, port_id, num_queues, verify)
> +            self.verify(
> +                self._check_config(testpmd, None, "tx", port_id, queue_off, verify),
> +                "Failed to disable MBUF_FAST_FREE on all queues.",
> +            )
> -- 
> 2.50.1
> 
