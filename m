Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DB3CA1013
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 15:25:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBC1D4278F;
	Thu,  4 Sep 2025 17:25:29 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 8958E4275D
 for <dev@dpdk.org>; Thu,  4 Sep 2025 17:25:28 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C6D516F8;
 Thu,  4 Sep 2025 08:25:19 -0700 (PDT)
Received: from arm.com (unknown [10.57.57.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42AF33F6A8;
 Thu,  4 Sep 2025 08:25:26 -0700 (PDT)
Date: Thu, 4 Sep 2025 16:25:21 +0100
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, ivan.malov@arknetworks.am, 
 probb@iol.unh.edu
Subject: Re: [PATCH v2 3/3] dts: update tx_offload test from old dts
Message-ID: <175699899054.87523.533880005351593542.luca.vizzarro@arm.com>
References: <20250902142725.56736-1-abailey@iol.unh.edu>
 <20250903180414.83001-1-abailey@iol.unh.edu>
 <20250903180414.83001-4-abailey@iol.unh.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903180414.83001-4-abailey@iol.unh.edu>
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

On Wed, Sep 03, 2025 at 02:04:14PM +0000, Andrew Bailey wrote:
> Currently, the Rx/Tx offload test in old DTS expects the Tx ports to be
> initially configured to use mbuf fast free. This is no longer the case
> and must be updated to assume mbuf fast free is not initially utilized
> by capable NICs. Add updated test suite to test mbuf fast free
> configuration.
> 
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
>  dts/tests/TestSuite_rxtx_offload.py | 148 ++++++++++++++++++++++++++++
>  1 file changed, 148 insertions(+)
>  create mode 100644 dts/tests/TestSuite_rxtx_offload.py
> 
> diff --git a/dts/tests/TestSuite_rxtx_offload.py b/dts/tests/TestSuite_rxtx_offload.py
> new file mode 100644
> index 0000000000..133994d795
> --- /dev/null
> +++ b/dts/tests/TestSuite_rxtx_offload.py
> @@ -0,0 +1,148 @@
Missing SPDX License identifier
> +# Copyright(c) 2025 University of New Hampshire
> +
> +"""Rx Tx offload test suite.
> +
> +Test the testpmd feature of configuring Rx and Tx offloads
missed full stop at the end.
> +"""
> +
> +from framework.remote_session.testpmd_shell import (
> +    NicCapability,
> +    RxTxArgFlag,
> +    TestPmdShell,
> +)
> +from framework.test_suite import TestSuite, func_test
> +from framework.testbed_model.capability import requires
> +
> +
> +@requires(NicCapability.TX_OFFLOAD_MBUF_FAST_FREE)
> +class TestRxTxOffload(TestSuite):
Have you tested this test suite? From the looks of it, it doesn't seem
it was ever tested. The current test suite discovery logic matches the
file name to the class name, and they are currently mismatching.

  TestSuite_rxtx_offload -> TestRxtxOffload
  TestRxTxOffload -> TestSuite_rx_tx_offload

> +    """RX/TX offload test suite."""
> +
> +    def check_port_config(
Any method that is not a test case should be made private.
> +        self,
> +        testpmd: TestPmdShell,
> +        offload: str,
> +        verify: bool,
> +        port_id: int = 0,
> +    ) -> bool:
> +        """Checks that the current port configuration matches the given offload.
> +
> +        Args:
> +            testpmd: The current testpmd shell session to send commands to.
> +            offload: The expected configuration of the given port.
> +            verify: Whether to verify the result of call to testpmd.
> +            port_id: Id of the port to check.
> +
> +        Returns:
> +            Whether current configuration matches given offload.
> +        """
And docstrings shoud be reserved for test suite module and test case
methods only. This docstring won't be rendered as a private method.
> +        output = testpmd.get_rxtx_offload_config(RxTxArgFlag.TX, verify, port_id, 0)
> +        return offload in output["port"] or (
> +            offload == "NULL" and "MBUF_FAST_FREE" not in output["port"]
> +        )
> +
> +    def check_queue_config(
> +        self,
> +        testpmd: TestPmdShell,
> +        offload: list[str],
> +        verify: bool,
> +        port_id: int = 0,
> +        num_queues: int = 0,
> +    ) -> bool:
> +        """Checks that the queue configuration matches the given offload.
> +
> +        Args:
> +            testpmd: The current testpmd shell session to send commands to.
> +            offload: The expected configuration of the queues, each index corresponds
> +                to the queue id.
> +            verify: Whether to verify commands sent to testpmd.
> +            port_id: The port of which the queues reside.
> +            num_queues: The number of queues to check.
> +
> +        Returns:
> +            Whether current configuration matches given offload
> +        """
as above.
> +        output = testpmd.get_rxtx_offload_config(RxTxArgFlag.TX, verify, port_id, num_queues)
> +        for i in range(0, num_queues):
> +            if not (
> +                offload[i] in output[i]
> +                or (offload[i] == "NULL" and "MBUF_FAST_FREE" not in output[i])
> +            ):
> +                return False
> +        return True
> +
> +    @func_test
> +    def test_mbuf_fast_free_configurations(self) -> None:
> +        """Ensure mbuf_fast_free can be configured with testpmd.
> +
> +        Steps:
> +            Start up testpmd shell.
> +            Toggle mbuf_fast_free on.
> +            Toggle mbuf_fast_free off.
> +
> +        Verify:
> +            Mbuf_fast_free starts disabled.
> +            Mbuf_fast_free can be configured on.
> +            Mbuf_fast_free can be configured off.
Improperly formatted unordered lists. Should prefix the lines with *
> +        """
> +        with TestPmdShell() as testpmd:
> +            verify: bool = True
> +            port_id: int = 0
> +            num_queues: int = 4
The types are inferred from the assigned value, there is no need to
specify it explicitly.
> +            queue_off: list[str] = []
> +            queue_on: list[str] = []
> +            mbuf_on = "MBUF_FAST_FREE"
> +            mbuf_off = "NULL"
> +
> +            for _ in range(0, num_queues):
> +                queue_off.append(mbuf_off)
> +                queue_on.append(mbuf_on)
This should be rather written as a list comprehension.
> +
> +            testpmd.set_ports_queues(num_queues)
> +            testpmd.start_all_ports()
> +
> +            # Ensure mbuf_fast_free is disabled by default on port and queues
> +            self.verify(
> +                self.check_port_config(testpmd, mbuf_off, verify, port_id),
> +                "Mbuf_fast_free enabled on port start",
Full stop at the end of the sentence.
> +            )
> +            self.verify(
> +                self.check_queue_config(testpmd, queue_off, verify, port_id, num_queues),
> +                "Mbuf_fast_free enabled on queue start",
Full stop at the end of the sentence.
> +            )
> +
> +            # Enable mbuf_fast_free per queue and verify
> +            testpmd.set_all_queues_mbuf_fast_free(True, verify, port_id, num_queues)
> +            self.verify(
> +                self.check_port_config(testpmd, mbuf_off, verify, port_id),
> +                "Port configuration changed without call",
Full stop at the end of the sentence.
> +            )
> +            self.verify(
> +                self.check_queue_config(testpmd, queue_on, verify, port_id, num_queues),
> +                "Queues failed to enable mbuf_fast_free",
Full stop at the end of the sentence.
> +            )
> +
> +            # Enable mbuf_fast_free per port and verify
> +            testpmd.set_port_mbuf_fast_free(True, verify, port_id)
> +            self.verify(
> +                self.check_port_config(testpmd, mbuf_on, verify, port_id),
> +                "Port failed to enable mbuf_fast_free",
Full stop at the end of the sentence.
> +            )
> +
> +            # Disable mbuf_fast_free per queue and verify
> +            testpmd.set_all_queues_mbuf_fast_free(False, verify, port_id, num_queues)
> +            self.verify(
> +                self.check_port_config(testpmd, mbuf_on, verify, port_id),
> +                "Port configuration changed without call",
Full stop at the end of the sentence.
> +            )
> +            self.verify(
> +                self.check_queue_config(testpmd, queue_off, verify, port_id, num_queues),
> +                "Queues failed to disable mbuf_fast_free",
Full stop at the end of the sentence.
> +            )
> +
> +            # Disable mbuf_fast_free per port and verify
> +            testpmd.set_port_mbuf_fast_free(False, verify, port_id)
> +            self.verify(
> +                self.check_port_config(testpmd, mbuf_off, verify, port_id),
> +                "Port failed to disable mbuf_fast_free",
Full stop at the end of the sentence.
> +            )
> -- 
> 2.50.1
> 
It looks like mbuf_off and mbuf_on are the same throughout, is there a
need to make these a variable and pass it along the methods?
