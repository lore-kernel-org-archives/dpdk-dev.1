Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8C5CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 12:23:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E52F34069F;
	Tue, 28 Oct 2025 13:22:56 +0100 (CET)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id 8BEB64042E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 13:22:54 +0100 (CET)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-4e896e91368so66213861cf.0
 for <dev@dpdk.org>; Tue, 28 Oct 2025 05:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761654174; x=1762258974; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BdhTlAVMzHyZyUg8l6FxqF0n4VWF++DJsOI6N2dd8L4=;
 b=EGmQKLZt79wtZzhK0tTO8yaM7fbWohRa44z4pL2isZ8SXX3t2E7eIOt50mtFw1B9s0
 ock84mXoRbvGyeKdyMdbdWLvL7nw06WiqgS2oiNCJq1gpmzYGRz6ZLGpr6kigJH1rX1W
 Ad8koqDckT7n/R11qhtlehKfofuSO4hR23ElU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761654174; x=1762258974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BdhTlAVMzHyZyUg8l6FxqF0n4VWF++DJsOI6N2dd8L4=;
 b=LxWqsljXQRWNLPo5t3rQKZJDPx/OG0SYJI1+Q5fnpZUWwTUNb7p3x5fHVE/7dH+9PN
 UESfr/dN5iALXl8BgqvdBrQ68qQnpgUGNfQulThmIv6UVlWPqx4CKy/pxDy4+H/wNVK1
 srrhk8f2OtlE3pysZD5J3cD58uxfUrSDwpJ3Nefhham+OlKZTCel1+7NNsnM12YeMKJw
 UWZ5U62mIlczyslgXV+2wHe7V1xAKhzZj+s4hgRM7wH871gu9FeRqDykLdGjk4Jw5D0s
 1TrdaZehFAKl6ptmcgYvE5tfcEtElQ9WrgSWQG0NLv+8NxzbM2laSzTqN+l7W56h7oIl
 bGrw==
X-Gm-Message-State: AOJu0Yy9946lhRetKuiIp+H3RwehBvzxmJLKVJoBNa04c9qjGkOIXTBp
 XVqdAtBTPt11vYlycFljaCeHtuK1gobx2mR1n85YxmHnwGpyAMk0S7y2lWZ3RCt/AF0=
X-Gm-Gg: ASbGncsB+flV3ZqhK+UdA45BJlouOuci1pd8ryGjfRJut8kC0j6k0/oZFmLPqLTrh1e
 8U0IfrVIboAPn/jD/4MNRDiNlwPjOQVVh+NZfhfPKg7XshT9SH61DrVmiied+h/e6FxiEmOPHr6
 ocV5CR3Qji9saN1H4JvNxrH7xtN0uUA9g7d3yiaXLHUYmugUeeCmKTRi637ESibjoZ50cQjGOW1
 Rc79IyC2rjzzmU+ezO7se8vJ4so8vrNWlH0B2q2LM2/AakIzelg9PoBwzpaj5SzF0GaQHU2FN9L
 jxP6uWGjpc9TCPEdGltm9bO5uWYSeYKigz/7rUJVxwwioEHDLyo2ASAVxac+K2dKbtMq6d6wmbp
 AGyYcHYlvUDaRTk7ZoS0C8Ew83I6polWEIgEX6MD/DlRzvczq4qbWI7SGIc+i7bGtEoNHk1T1FM
 qI5pQ9finBSa7B
X-Google-Smtp-Source: AGHT+IE3odBmplrppQ/yyS4a1RGVG8KSKlq8eykS3xwdFimb0JsUl0vU4snT8fZXd+KogNdeFAGVQw==
X-Received: by 2002:a05:622a:11d4:b0:4e8:a2aa:77c9 with SMTP id
 d75a77b69052e-4ed07479898mr40023601cf.1.1761654173775; 
 Tue, 28 Oct 2025 05:22:53 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87fc4969008sm75450306d6.42.2025.10.28.05.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 05:22:53 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: dev@dpdk.org, luca.vizzarro@arm.com, dmarx@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v11 3/3] dts: add Rx Tx offload test suite
Date: Tue, 28 Oct 2025 08:22:40 -0400
Message-ID: <20251028122240.112773-4-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251028122240.112773-1-abailey@iol.unh.edu>
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20251028122240.112773-1-abailey@iol.unh.edu>
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

Add mbuf_fast_free portion of rxtx offload testsuite from legacy dts
to next dts. The testsuite expects mbuf fast free to be enabled by
default and verifies configuration of this Tx offload capability.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 doc/api/dts/tests.TestSuite_rx_tx_offload.rst |   8 ++
 dts/tests/TestSuite_rx_tx_offload.py          | 134 ++++++++++++++++++
 2 files changed, 142 insertions(+)
 create mode 100644 doc/api/dts/tests.TestSuite_rx_tx_offload.rst
 create mode 100644 dts/tests/TestSuite_rx_tx_offload.py

diff --git a/doc/api/dts/tests.TestSuite_rx_tx_offload.rst b/doc/api/dts/tests.TestSuite_rx_tx_offload.rst
new file mode 100644
index 0000000000..27834a74da
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_rx_tx_offload.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+rx_tx_offload Test Suite
+========================
+
+.. automodule:: tests.TestSuite_rx_tx_offload
+   :members:
+   :show-inheritance:
diff --git a/dts/tests/TestSuite_rx_tx_offload.py b/dts/tests/TestSuite_rx_tx_offload.py
new file mode 100644
index 0000000000..b0da627d3c
--- /dev/null
+++ b/dts/tests/TestSuite_rx_tx_offload.py
@@ -0,0 +1,134 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 University of New Hampshire
+
+"""RX TX offload test suite.
+
+Test the testpmd feature of configuring RX and TX offloads.
+"""
+
+from api.capabilities import (
+    LinkTopology,
+    NicCapability,
+    requires_link_topology,
+    requires_nic_capability,
+)
+from api.test import verify
+from api.testpmd import TestPmd
+from api.testpmd.types import (
+    OffloadConfiguration,
+    RxTxLiteralSwitch,
+)
+from framework.test_suite import TestSuite, func_test
+
+
+@requires_link_topology(LinkTopology.ONE_LINK)
+class TestRxTxOffload(TestSuite):
+    """RX/TX offload test suite."""
+
+    def _check_config(
+        self,
+        testpmd: TestPmd,
+        port_id: int,
+        port_offload: str | None,
+        rxtx: RxTxLiteralSwitch,
+        /,
+        queue_offload: list[str | None] | None = None,
+    ) -> bool:
+        config: OffloadConfiguration = testpmd.get_offload_config(port_id, rxtx)
+        if config.port_config.name != port_offload:
+            return False
+
+        if queue_offload:
+            for i, q in enumerate(config.queue_configs):
+                if q.name != queue_offload[i]:
+                    return False
+        return True
+
+    def _set_all_queues_mbuf_fast_free(
+        self,
+        testpmd: TestPmd,
+        port_id: int,
+        on: bool,
+        num_queues: int,
+    ) -> None:
+        for i in range(num_queues):
+            testpmd.set_queue_mbuf_fast_free(port_id, on, i)
+
+    @requires_nic_capability(NicCapability.PORT_TX_OFFLOAD_MBUF_FAST_FREE)
+    @func_test
+    def test_mbuf_fast_free_configuration_per_port(self) -> None:
+        """Ensure mbuf_fast_free can be configured with testpmd per port.
+
+        Steps:
+            * Start up testpmd shell.
+            * Toggle mbuf_fast_free off per port.
+            * Toggle mbuf_fast_free on per port.
+
+        Verify:
+            * Mbuf_fast_free starts enabled.
+            * Mbuf_fast_free can be configured off per port.
+            * Mbuf_fast_free can be configured on per port.
+        """
+        with TestPmd() as testpmd:
+            port_id = 0
+            testpmd.start_all_ports()
+
+            # Ensure MBUF_FAST_FREE is enabled by default and verify
+            verify(
+                self._check_config(testpmd, port_id, "MBUF_FAST_FREE", "tx"),
+                "MBUF_FAST_FREE disabled on port start.",
+            )
+            # disable MBUF_FAST_FREE per port and verify
+            testpmd.set_port_mbuf_fast_free(port_id, False)
+            verify(
+                self._check_config(testpmd, port_id, None, "tx"),
+                "Failed to enable MBUF_FAST_FREE on port.",
+            )
+            # Enable MBUF_FAST_FREE per port and verify
+            testpmd.set_port_mbuf_fast_free(port_id, True)
+            verify(
+                self._check_config(testpmd, port_id, "MBUF_FAST_FREE", "tx"),
+                "Failed to disable MBUF_FAST_FREE on port.",
+            )
+
+    @requires_nic_capability(NicCapability.QUEUE_TX_OFFLOAD_MBUF_FAST_FREE)
+    @func_test
+    def test_mbuf_fast_free_configuration_per_queue(self) -> None:
+        """Ensure mbuf_fast_free can be configured with testpmd.
+
+        Steps:
+            * Start up testpmd shell.
+            * Toggle mbuf_fast_free off per queue.
+            * Toggle mbuf_fast_free on per queue.
+
+        Verify:
+            * Mbuf_fast_free starts disabled.
+            * Mbuf_fast_free can be configured off per queue.
+            * Mbuf_fast_free can be configured on per queue.
+        """
+        with TestPmd() as testpmd:
+            port_id = 0
+            num_queues = 4
+            queue_off: list[str | None] | None = [None] * num_queues
+            queue_on: list[str | None] | None = ["MBUF_FAST_FREE"] * num_queues
+
+            testpmd.set_ports_queues(num_queues)
+            testpmd.start_all_ports()
+
+            # Ensure mbuf_fast_free is enabled by default on port and queues
+            verify(
+                self._check_config(testpmd, port_id, "MBUF_FAST_FREE", "tx", queue_on),
+                "MBUF_FAST_FREE disabled on queue start.",
+            )
+            # Disable mbuf_fast_free per queue and verify
+            self._set_all_queues_mbuf_fast_free(testpmd, port_id, False, num_queues)
+            verify(
+                self._check_config(testpmd, port_id, "MBUF_FAST_FREE", "tx", queue_off),
+                "Failed to disable MBUF_FAST_FREE on all queues.",
+            )
+            # Disable mbuf_fast_free per queue and verify
+            self._set_all_queues_mbuf_fast_free(testpmd, port_id, True, num_queues)
+            verify(
+                self._check_config(testpmd, port_id, "MBUF_FAST_FREE", "tx", queue_on),
+                "Failed to enable MBUF_FAST_FREE on all queues.",
+            )
-- 
2.50.1

