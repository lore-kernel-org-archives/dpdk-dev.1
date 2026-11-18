Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D88606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 00:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Puvl97ry
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5332940612;
	Wed, 18 Nov 2026 01:19:50 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by mails.dpdk.org (Postfix) with ESMTPS id EAF6A402DD
 for <dev@dpdk.org>; Wed, 18 Nov 2026 01:19:48 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so4468755e9.2
 for <dev@dpdk.org>; Tue, 17 Nov 2026 16:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794961188; x=1795565988; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vVKRWdOpnu5nNniaiJ9PJvs+IADmQyemAxoMBXa5O+o=;
 b=Puvl97ryN54rLtIuV4b24wkOtRxGhbLes/bOqgiTL3t0TbzXwLkx2i6YouYW53fE5G
 Dn8iVYkeYMEgQrSUr5VeuKPdJnbiJIvbN5eptCCDlhgE3PK+/ZkwIvzVlX/c6pM3GYK2
 nMHF9kAvtdch+DwV9IglCaP7btOuxRhkH47uW4OFBzDEaNTCG0t22JSTVN9TbozUf6l5
 I3j4zZALIbNSW8lYydPhQob6dNAWcBKCTM6q91YEbW4GPWFYX7xEzu6MvWkwdjLIcikL
 nR4gpaAn5ugjI3D7+786XhEfRJmhXESMKC+eJF+raolehJjxyhe2rq7MYofxfrzqZ8aA
 f9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794961188; x=1795565988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vVKRWdOpnu5nNniaiJ9PJvs+IADmQyemAxoMBXa5O+o=;
 b=m41+G+QkRIUvNVaeKI7bsZAby4w9uR7N/G6S29H+BvcjF9LiH/OvkXDqib5F3C0jj3
 SyeqAxsFyiCvcnosFDYrPcf6zRiIUcKxjrpiHtnFSh/DWk9+qY5ujJkoojxxK5o2ffjB
 T+viKrz/QLxl1YStK6RWCOfHJYlcJyQLr2mI1e/J8gaxx8s9HWpo6tRJIvY4wtaTNS5H
 UksXKW8RpvKoTk96ExuOaPBnk6Pc0mdIkh4YVeS9OBPa15wPXA/jLftrFzKwj8+6pfLm
 mHTrgqqClsDZRAtgpqx10Ty1JhmZeke+O7llxRrORvqVsyXytGCkbFXX7I/R2tm1KVJb
 v0zw==
X-Gm-Message-State: APuU4Z/UHwCWCtxAajKnpFGTeC6aTRT62WFRnQ8I2ZQCHVsh5AlcWinr
 XfJb4RDrnm9KrkrCSUoOdP8U35W0YxOQE3fPzOQjCMb40DA5sH5gEKDL
X-Gm-Gg: AYBFou3zYKpq2Jo19ZHAANNxtZHu+lz451l0+kjckwX6J3/+zkF2JT4gTpABAK5ML8p
 tHoU5ZcnXsuwA6AaMNMbxtBM4nH5kTC/xLIS6cvBpgUpMRxupd69DKu/NWz2L5ATSXd9lCDa31T
 X3ujMzNFom71j7KE1lO0JsafkBUh1eFu52srsuhYDq3GsfFQIwxNxsiLkR6qZCWa1ePF4KZWLwF
 0d/5cj5bU8tBEr+zAghMI8rbIG+uTFNRHkJkmtLVqIhUKqEQvP3SZ8x1DnXC/nYN0AHKwUZRAWY
 XB1VpkJDikyOjvSrLhDdCrDF1a6honfF+WP6fpVhudPV1wZ9GMbnbE242oSj679tYLP9u/NZvxw
 ALn297k/QNnkyytDuSVWDT67uA78D0jyXRaO0To++nrneOsqxq4MhqqCTTX6BZ/q8N/3PbSTKIH
 cLclaalyj60qqI5bQUsUIj722tzVQn/RDYMclPg0E3ZY0xZlSb3jMWEcrCsdNwXKTUSrCkFNrZH
 d8dcdfC+kSDJLtgF+6An/0M+D1QUjKIZy5d/NE7Rs/gAyClR7U8ka8nQfqKvUVX4tDzGXfzf5Fp
 q+xMzIFKjZbbcXGKcpsJbG+3hH0sroHzNXAihp6XjxE=
X-Received: by 2002:a05:600c:34d2:b0:4a2:1867:10e8 with SMTP id
 5b1f17b1804b1-4bb7da4c952mr14718305e9.25.1794961188419; 
 Tue, 17 Nov 2026 16:19:48 -0800 (PST)
Received: from fedora ([46.210.208.90]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7e50e992sm4655025e9.0.2026.11.17.16.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 16:19:48 -0800 (PST)
From: Isaac Boukris <iboukris@gmail.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>,
 Isaac Boukris <iboukris@gmail.com>
Subject: [PATCH v3 7/7] dts: add Rx interrupt test suite
Date: Wed, 18 Nov 2026 02:19:18 +0200
Message-ID: <20261118001918.990884-8-iboukris@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118001918.990884-1-iboukris@gmail.com>
References: <20261117124303.717447-1-iboukris@gmail.com>
 <20261118001918.990884-1-iboukris@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Test that packets received on a port wake up a testpmd lcore that
sleeps on the Rx queues' interrupts (testpmd's --rxq-interrupt).

The first test case also tests it after the ports are configured a
second time, with the same number of queues.

The second test case tests it after the number of queues changed. It
configures the ports with two queues, then with one queue. The packets
differ in their source address, to spread over the queues, and with
two queues both must receive packets. The test case is skipped if a
port cannot have two queues, or if the packets do not reach both
queues.

The test cases run on the ingress port of the test run, so they test
the driver of that port. For the virtio PCI driver, the SUT is a VM
and its port a virtio-net device.

Signed-off-by: Isaac Boukris <iboukris@gmail.com>
---
 doc/api/dts/tests.TestSuite_rx_interrupt.rst |   8 ++
 dts/api/params/types.py                      |   1 +
 dts/api/testpmd/config.py                    |   2 +
 dts/tests/TestSuite_rx_interrupt.py          | 122 +++++++++++++++++++
 4 files changed, 133 insertions(+)
 create mode 100644 doc/api/dts/tests.TestSuite_rx_interrupt.rst
 create mode 100644 dts/tests/TestSuite_rx_interrupt.py

diff --git a/doc/api/dts/tests.TestSuite_rx_interrupt.rst b/doc/api/dts/tests.TestSuite_rx_interrupt.rst
new file mode 100644
index 0000000000..ff65daf78c
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_rx_interrupt.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+rx_interrupt Test Suite
+=======================
+
+.. automodule:: tests.TestSuite_rx_interrupt
+   :members:
+   :show-inheritance:
diff --git a/dts/api/params/types.py b/dts/api/params/types.py
index c4b718eebe..3d852cf1fb 100644
--- a/dts/api/params/types.py
+++ b/dts/api/params/types.py
@@ -190,6 +190,7 @@ class TestPmdParamsDict(EalParamsDict, total=False):
     disable_device_start: Switch
     no_lsc_interrupt: Switch
     no_rmv_interrupt: Switch
+    rxq_interrupt: Switch
     bitrate_stats: int | None
     latencystats: int | None
     print_events: list[Event] | None
diff --git a/dts/api/testpmd/config.py b/dts/api/testpmd/config.py
index c72c1b2c90..92b5a23862 100644
--- a/dts/api/testpmd/config.py
+++ b/dts/api/testpmd/config.py
@@ -491,6 +491,7 @@ class TestPmdParams(EalParams):
                               for the first time.
         no_lsc_interrupt: Disable LSC interrupts for all ports, even those supporting it.
         no_rmv_interrupt: Disable RMV interrupts for all ports, even those supporting it.
+        rxq_interrupt: Enable Rx queue interrupts for all ports. Idle forwarding lcores sleep.
         bitrate_stats: Set the logical core N to perform bitrate calculation.
         latencystats: Set the logical core N to perform latency and jitter calculations.
         print_events: Enable printing the occurrence of the designated events.
@@ -596,6 +597,7 @@ class TestPmdParams(EalParams):
     disable_device_start: Switch = None
     no_lsc_interrupt: Switch = None
     no_rmv_interrupt: Switch = None
+    rxq_interrupt: Switch = None
     bitrate_stats: int | None = None
     latencystats: int | None = None
     print_events: list[Event] | None = field(
diff --git a/dts/tests/TestSuite_rx_interrupt.py b/dts/tests/TestSuite_rx_interrupt.py
new file mode 100644
index 0000000000..05d82487d5
--- /dev/null
+++ b/dts/tests/TestSuite_rx_interrupt.py
@@ -0,0 +1,122 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Isaac Boukris
+
+"""Rx interrupt test suite.
+
+Test that packets received on a port wake up a testpmd lcore that sleeps on the Rx queues'
+interrupts. Test it again after the ports are configured again, with the same number of queues
+and with another number.
+"""
+
+import re
+
+from scapy.layers.inet import IP, UDP
+from scapy.layers.l2 import Ether
+from scapy.packet import Raw
+
+from api.exception import InteractiveCommandExecutionError
+from api.packet import send_packets
+from api.test import fail, verify_else_skip
+from api.test_suite import TestSuite, func_suite, func_test
+from api.testpmd import TestPmd
+from api.testpmd.config import SimpleForwardingModes
+
+
+@func_suite
+class TestRxInterrupt(TestSuite):
+    """Rx interrupt test suite."""
+
+    #: The number of packets to send. Each of them must wake the lcore up.
+    NUMBER_OF_WAKE_UPS = 8
+
+    def _wake_ups(self, testpmd: TestPmd) -> int:
+        match = re.search(r"RX-wakeups:\s+(\d+)", testpmd.send_command("show fwd stats all"))
+        return int(match.group(1)) if match else 0
+
+    def _verify_wake_ups(self, testpmd: TestPmd) -> str:
+        """Verify that packets wake up the lcore of `testpmd`, `NUMBER_OF_WAKE_UPS` times.
+
+        The packets differ in their source address, to spread over the Rx queues.
+
+        A packet is sent only after the previous one woke the lcore up. The lcore is awake for
+        a short time every 10 ms, to look at its queues. A packet that arrives then is received
+        without a wake-up, so send each packet up to three times.
+
+        Returns:
+            The forward statistics that testpmd shows when it stops.
+        """
+        testpmd.start()
+        for number in range(1, self.NUMBER_OF_WAKE_UPS + 1):
+            packet = Ether() / IP(src=f"192.168.0.{number}") / UDP() / Raw(b"\0" * 32)
+            wake_ups = self._wake_ups(testpmd)
+            for _ in range(3):
+                send_packets([packet])
+                if self._wake_ups(testpmd) > wake_ups:
+                    break
+            else:
+                fail(f"Packet {number} did not wake up the lcore.")
+        return testpmd.stop()
+
+    def _configure_again(self, testpmd: TestPmd, number_of_queues: int) -> None:
+        """Stop the ports of `testpmd`, configure them with `number_of_queues` and start them."""
+        testpmd.set_ports_queues(number_of_queues)
+        try:
+            testpmd.start_all_ports()
+        except InteractiveCommandExecutionError:
+            fail(f"The ports did not start, configured with {number_of_queues} queue(s).")
+
+    @func_test
+    def wake_up_on_packet(self) -> None:
+        """Wake up a sleeping lcore with packets, also after a second configuration.
+
+        Steps:
+            * Start testpmd with Rx queue interrupts, receiving.
+            * Send packets to the ingress port, one at a time.
+            * Stop the ports, configure them again with the same number of queues, start them
+              and send again.
+
+        Verify:
+            * Each packet wakes up the lcore from the queue's interrupt.
+            * The ports start after the second configuration.
+        """
+        with TestPmd(rxq_interrupt=True, forward_mode=SimpleForwardingModes.rxonly) as testpmd:
+            self._verify_wake_ups(testpmd)
+            self._configure_again(testpmd, 1)
+            self._verify_wake_ups(testpmd)
+
+    @func_test
+    def wake_up_on_packet_after_queue_number_change(self) -> None:
+        """Wake up a sleeping lcore with packets after the number of queues changed.
+
+        The test case is skipped if a port cannot have two queues, or if the packets do not
+        reach both queues.
+
+        Steps:
+            * Start testpmd with Rx queue interrupts, receiving, with one queue.
+            * Stop the ports, configure them with two queues, start them and send packets to
+              the ingress port, one at a time.
+            * Do the same with one queue.
+
+        Verify:
+            * Each packet wakes up the lcore from a queue's interrupt.
+            * With two queues, both queues receive packets.
+            * The ports start after each configuration.
+        """
+        with TestPmd(rxq_interrupt=True, forward_mode=SimpleForwardingModes.rxonly) as testpmd:
+            max_queues = min(
+                min(port.max_rx_queues_num, port.max_tx_queues_num)
+                for port in testpmd.show_port_info_all()
+            )
+            verify_else_skip(
+                max_queues >= 2, f"The test needs 2 queues, and a port has {max_queues} at most."
+            )
+            self._configure_again(testpmd, 2)
+            statistics = self._verify_wake_ups(testpmd)
+            # Each packet woke the lcore up. So a queue that received packets woke it up.
+            for queue in (0, 1):
+                verify_else_skip(
+                    f"RX Port= 0/Queue= {queue}" in statistics,
+                    f"No packet reached Rx queue {queue} of the ingress port.",
+                )
+            self._configure_again(testpmd, 1)
+            self._verify_wake_ups(testpmd)
-- 
2.56.1

