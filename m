Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D06CAC59A
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 12:43:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6A664066E;
	Wed, 17 Sep 2025 14:43:04 +0200 (CEST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id 051DB402DA
 for <dev@dpdk.org>; Wed, 17 Sep 2025 14:43:00 +0200 (CEST)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-827ec18434aso428527585a.0
 for <dev@dpdk.org>; Wed, 17 Sep 2025 05:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1758112979; x=1758717779; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zvGj+X/jvn2E82tj2eAkUHI+6oRkHKDxEsy9HOAMVO4=;
 b=MEtUddJIbYyKtzbvS2586D5KZcbch3gRgh3M2qJR7N/I2FzD51eYMXix+6XjyD/quE
 rBInXbjTdUPHNXxu6Pz2gvB0DpFHlMcFJ2Ej21YPFwhCUJdYgSl8GH+3qEJgFhBehulV
 BNu/Yij0xNLbMGFr/U3h0B0set6fWJt5oK3qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758112979; x=1758717779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zvGj+X/jvn2E82tj2eAkUHI+6oRkHKDxEsy9HOAMVO4=;
 b=oPxCW2h5I8X1S0MAZoLpU0ZVSVv6ictuZoVb9SJE5SpVYFLaRyFEqlv3YZILzA/9jZ
 awdkKbN3vtH6BjM0v5CiYheDtZeIQTrW3GNfC77ne6ml5dz0YQJRCTtS3x33yrpAsDCO
 P2NYPfOhdGRGU8eXmWR5BM5Dh+Fz5HMse0ztL7HDrT3ytI7ql7ydb3Xlt3TFvrQSt00R
 3NGlhTm6gnqKFh+rM3r/tl42NnyuN9nqNvfeAEfZjGpEiqAnNr4BsBarkoPGrDoeC9BV
 2picE1aELpyVfmCsJkWSvJ7A+JrlgKgYTDnJbKH/9H7pZLrMfFSMsWWevYiJ18YFr+Va
 Y7/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW3ReU6gVAe3oIvIsJyhTIYlJhs1QtYByQ8h8B+2iGGcwi5uvIf+20ECm+hZsDTzOWZYc=@dpdk.org
X-Gm-Message-State: AOJu0YzWA14IW1cmSTX1SVl4TzfvdZ00+mBPrTUPtcfk9vsyKky2ewh+
 a5a5OPtRYo+C6+GZpg7sh9szaVXTMwSQLM57jasi/AMJeGlMfoGKWufJspbjMEkSydqWIcYPdik
 Exzev
X-Gm-Gg: ASbGnctJS4nUDZIJOJoCLChI7F9VgzN4OJCRH3h+LCjOckhvApS3aty+nlK0WuMMqtI
 QTuY689BqdRzbcZ28PsT4/Q3v9j/FnzZCmvtyaS81KvLQZjz6bYtY1k6Afid8DVtbG8aLH+XzUu
 7uP2dNqOw0qB1oOjyLL3mI8XZkLjbBTx1R8CVyqSr9zqGQa5BOTZETxc3ScshHNS8U+bPfnMjd8
 DLV+tWX82kWCQtx1JDpIwLaBHP9AIT2r+Q+Oq8Mw7ebZcvAuIZd8OUEf9wQ+Nzq1iEe6IQl7tgv
 X4aLHeHqIMFq+ScLShbMxw7OO7PTKwg0eQ+xgAqNSctPwA5MA2CiA9fD+V8KB0H/E5EzLg+VwhG
 F+1+1o5IVWnAGf5Io33N45qRd2LBO6t+pL04=
X-Google-Smtp-Source: AGHT+IF1gsgsrP8wQ6W62/6OBMWHTDZHsL21jqPiryy5Z8Luzckme2JE77Iyj42730H8JAuT02K89A==
X-Received: by 2002:a05:620a:468f:b0:829:4b29:19d0 with SMTP id
 af79cd13be357-83109e98432mr201681485a.7.1758112979150; 
 Wed, 17 Sep 2025 05:42:59 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-825abc11db2sm908046285a.45.2025.09.17.05.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 05:42:58 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu,
 ivan.malov@arknetworks.am
Subject: [PATCH v3 3/3] dts: update tx_offload test from old dts
Date: Wed, 17 Sep 2025 08:42:43 -0400
Message-ID: <20250917124243.31567-4-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250917124243.31567-1-abailey@iol.unh.edu>
References: <20250902142725.56736-1-abailey@iol.unh.edu>
 <20250917124243.31567-1-abailey@iol.unh.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Currently, the RX/TX offload test in old DTS expects the TX ports to be
initially configured to use mbuf fast free. This is no longer the case
and must be updated to assume mbuf fast free is not initially utilized
by capable NICs. Add updated test suite to test mbuf fast free
configuration.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/tests/TestSuite_rx_tx_offload.py | 130 +++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 dts/tests/TestSuite_rx_tx_offload.py

diff --git a/dts/tests/TestSuite_rx_tx_offload.py b/dts/tests/TestSuite_rx_tx_offload.py
new file mode 100644
index 0000000000..f97bb4978a
--- /dev/null
+++ b/dts/tests/TestSuite_rx_tx_offload.py
@@ -0,0 +1,130 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 University of New Hampshire
+
+"""RX TX offload test suite.
+
+Test the testpmd feature of configuring RX and TX offloads.
+"""
+
+from typing import Optional
+
+from framework.remote_session.testpmd_shell import (
+    OffloadConfiguration,
+    RxTxLiteralSwitch,
+    TestPmdShell,
+)
+from framework.test_suite import TestSuite, func_test
+from framework.testbed_model.capability import NicCapability, requires
+
+
+class TestRxTxOffload(TestSuite):
+    """RX/TX offload test suite."""
+
+    def _check_config(
+        self,
+        testpmd: TestPmdShell,
+        port_offload: str | None,
+        rxtx: RxTxLiteralSwitch,
+        port_id: int,
+        /,
+        queue_offload: Optional[list[str | None]] = None,
+        verify: bool = True,
+    ) -> bool:
+        config: OffloadConfiguration = testpmd.get_offload_config(rxtx, port_id, verify)
+        if config.port.name != port_offload:
+            return False
+
+        if queue_offload:
+            for i, q in enumerate(config.queues):
+                if q.name != queue_offload[i]:
+                    return False
+        return True
+
+    def _set_all_queues_mbuf_fast_free(
+        self, testpmd: TestPmdShell, on: bool, port_id: int, num_queues: int, /, verify: bool = True
+    ) -> None:
+        for i in range(num_queues):
+            testpmd.set_queue_mbuf_fast_free(on, port_id, i, verify)
+
+    @requires(NicCapability.PORT_TX_OFFLOAD_MBUF_FAST_FREE)
+    @func_test
+    def test_mbuf_fast_free_configuration_per_port(self) -> None:
+        """Ensure mbuf_fast_free can be configured with testpmd per port.
+
+        Steps:
+            * Start up testpmd shell.
+            * Toggle mbuf_fast_free on per port.
+            * Toggle mbuf_fast_free off per port.
+
+        Verify:
+            * Mbuf_fast_free starts disabled.
+            * Mbuf_fast_free can be configured on per port.
+            * Mbuf_fast_free can be configured off per port.
+        """
+        with TestPmdShell() as testpmd:
+            verify = True
+            port_id = 0
+            testpmd.start_all_ports()
+
+            # Ensure MBUF_FAST_FREE is disabled by default and verify
+            self.verify(
+                self._check_config(testpmd, None, "tx", port_id, verify=verify),
+                "MBUF_FAST_FREE enabled on port start.",
+            )
+            # Enable MBUF_FAST_FREE per port and verify
+            testpmd.set_port_mbuf_fast_free(True, port_id, verify)
+            self.verify(
+                self._check_config(
+                    testpmd, "TX_OFFLOAD_MBUF_FAST_FREE", "tx", port_id, verify=verify
+                ),
+                "Failed to enable MBUF_FAST_FREE on port.",
+            )
+            # Disable MBUF_FAST_FREE per port and verify
+            testpmd.set_port_mbuf_fast_free(False, port_id, verify)
+            self.verify(
+                self._check_config(testpmd, None, "tx", port_id, verify=verify),
+                "Failed to disable MBUF_FAST_FREE on port.",
+            )
+
+    @requires(NicCapability.QUEUE_TX_OFFLOAD_MBUF_FAST_FREE)
+    @func_test
+    def test_mbuf_fast_free_configuration_per_queue(self) -> None:
+        """Ensure mbuf_fast_free can be configured with testpmd.
+
+        Steps:
+            * Start up testpmd shell.
+            * Toggle mbuf_fast_free on per queue.
+            * Toggle mbuf_fast_free off per queue.
+
+        Verify:
+            * Mbuf_fast_free starts disabled.
+            * Mbuf_fast_free can be configured on per queue.
+            * Mbuf_fast_free can be configured off per queue.
+        """
+        with TestPmdShell() as testpmd:
+            verify = True
+            port_id = 0
+            num_queues = 4
+            queue_off: Optional[list[str | None]] = [None] * num_queues
+            queue_on: Optional[list[str | None]] = ["TX_OFFLOAD_MBUF_FAST_FREE"] * num_queues
+
+            testpmd.set_ports_queues(num_queues)
+            testpmd.start_all_ports()
+
+            # Ensure mbuf_fast_free is disabled by default on port and queues
+            self.verify(
+                self._check_config(testpmd, None, "tx", port_id, queue_off, verify=verify),
+                "MBUF_FAST_FREE enabled on queue start.",
+            )
+            # Enable mbuf_fast_free per queue and verify
+            self._set_all_queues_mbuf_fast_free(testpmd, True, port_id, num_queues, verify)
+            self.verify(
+                self._check_config(testpmd, None, "tx", port_id, queue_on, verify),
+                "Failed to enable MBUF_FAST_FREE on all queues.",
+            )
+            # Disable mbuf_fast_free per queue and verify
+            self._set_all_queues_mbuf_fast_free(testpmd, False, port_id, num_queues, verify)
+            self.verify(
+                self._check_config(testpmd, None, "tx", port_id, queue_off, verify),
+                "Failed to disable MBUF_FAST_FREE on all queues.",
+            )
-- 
2.50.1

