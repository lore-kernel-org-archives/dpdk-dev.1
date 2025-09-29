Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82506CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 17:06:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B822C4069F;
	Mon, 29 Sep 2025 19:06:36 +0200 (CEST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id A39BE40698
 for <dev@dpdk.org>; Mon, 29 Sep 2025 19:06:34 +0200 (CEST)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-855d525cd00so662326185a.2
 for <dev@dpdk.org>; Mon, 29 Sep 2025 10:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1759165594; x=1759770394; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2cOK+0RtypsAjU5MVeE1I8RiIbI2Im/9xWcNJSV8x4=;
 b=LUPJ4V3lvH2gV7byGBP/LgSQU9BoS6aJOvKhCiJBs/cNn3Y2RCYVk58gUvnUC9pLWn
 yAkEVZG3Ym6RN7NRoT/oV3tY/u3xfiBhcRuBRJP0YVObEAJiCx267jV4r3v5KWDfd/ki
 rMHzjCSt5inBWE1z5G1ZscGGv14dLC/zpySAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759165594; x=1759770394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G2cOK+0RtypsAjU5MVeE1I8RiIbI2Im/9xWcNJSV8x4=;
 b=MquAfV9NXzsWiTvFb0xmdTsM7gZwc4o/XnaPiCnblc3VVb+8Dn1KC9FwkZIELySBcS
 ZPyCCvP8YH4z/paEB6NIULa8v6ocQcx93Em3WGMyjp84fgwgDqQu3r1P+U8uva+0X4I7
 hkYdfQ87FyAvkI28RIjv8l/PHZtVBIfyGcN7v+XjBugCHVSuOwMJkHETkHImyGtJ63gB
 jAf6h7IZxpUINZV09PPaulz+6VqUCnBwnYdYNNArIDRjlkT3avXSMf4AMlHsbGnl2i46
 qjYQu7yTZKHMDhpbeDvuPeHiuXjKakyhCr2hpL2UR40JhJ6QEHQ9OgSSPSuBK66SxCpq
 wPLw==
X-Gm-Message-State: AOJu0Yxc+X704CDoemopZh+E6+o8M0HqcnevgTWCNtGDxIg88+BGJ4lp
 7Y3K+pg2g+bl4uKkIRAKQbVk0FqBcL/L3AWObMVJM5iHfaHXp3mRbo6YYZEBn5rItfw=
X-Gm-Gg: ASbGncvKevSjX9dgZY5PTB0mN3BRCZwVNbV01EB7uoLWEwzeqRPNZy1ge9pt1m7r+2Y
 746q+LiWd1Yu0KNYeBhdqTSg4rYjpi5lIZAsz82j8EqwAqsc3Ry+MVOPU2P+IAEtL4MHUVi0pnl
 iZf9L++sBCdkvaGv33gHxmtS3Aabp1jipsg/kI0fL1mlaSgcGaFWO+KX8eXY2K5fk3vG18g2O3D
 Pfd/0XfFzazp2bk8EKnzIaZ7QZQ44EmCoqFdJorvZ/3r+1mL9Yasr8+zT+bhx1E5qf4Z6hcnPTJ
 bXGkfepAgIf5O+FPoGKZzKVur+eekQHG478de6sywwMEYAK+SeUzbHupV4EBOfJCtKW8M9uZ1zw
 bIVlLawtkmdpr7iaBAowyD7+9/BvJsxZW1UA=
X-Google-Smtp-Source: AGHT+IGWv0ZUy2jJRCmfkCwdudp7T83v9r1KWbZjvWh+fSTD3lT6WWpqUW/cGpKfSYarwrJBqDW7iA==
X-Received: by 2002:a05:620a:1a90:b0:848:6b67:ea57 with SMTP id
 af79cd13be357-85ae48281c4mr2108127985a.16.1759165593691; 
 Mon, 29 Sep 2025 10:06:33 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-85c28c76f69sm869843885a.27.2025.09.29.10.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 10:06:33 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, ivan.malov@arknetworks.am,
 probb@iol.unh.edu, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v5 3/3] dts: update tx_offload test from old dts
Date: Mon, 29 Sep 2025 13:06:05 -0400
Message-ID: <20250929170606.216623-4-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250929170606.216623-1-abailey@iol.unh.edu>
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20250929170606.216623-1-abailey@iol.unh.edu>
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
 doc/api/dts/tests.TestSuite_rx_tx_offload.rst |   8 ++
 dts/tests/TestSuite_rx_tx_offload.py          | 126 ++++++++++++++++++
 2 files changed, 134 insertions(+)
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
index 0000000000..19a8e507f2
--- /dev/null
+++ b/dts/tests/TestSuite_rx_tx_offload.py
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 University of New Hampshire
+
+"""RX TX offload test suite.
+
+Test the testpmd feature of configuring RX and TX offloads.
+"""
+
+from api.capabilities import NicCapability, requires_nic_capability
+from api.testpmd import TestPmd
+from api.testpmd.types import (
+    OffloadConfiguration,
+    RxTxLiteralSwitch,
+)
+from framework.test_suite import TestSuite, func_test
+
+
+class TestRxTxOffload(TestSuite):
+    """RX/TX offload test suite."""
+
+    def _check_config(
+        self,
+        testpmd: TestPmd,
+        port_offload: str | None,
+        rxtx: RxTxLiteralSwitch,
+        port_id: int,
+        /,
+        queue_offload: list[str | None] | None = None,
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
+        self, testpmd: TestPmd, on: bool, port_id: int, num_queues: int, /, verify: bool = True
+    ) -> None:
+        for i in range(num_queues):
+            testpmd.set_queue_mbuf_fast_free(on, port_id, i, verify)
+
+    @requires_nic_capability(NicCapability.PORT_TX_OFFLOAD_MBUF_FAST_FREE)
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
+        with TestPmd() as testpmd:
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
+                self._check_config(testpmd, "MBUF_FAST_FREE", "tx", port_id, verify=verify),
+                "Failed to enable MBUF_FAST_FREE on port.",
+            )
+            # Disable MBUF_FAST_FREE per port and verify
+            testpmd.set_port_mbuf_fast_free(False, port_id, verify)
+            self.verify(
+                self._check_config(testpmd, None, "tx", port_id, verify=verify),
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
+            * Toggle mbuf_fast_free on per queue.
+            * Toggle mbuf_fast_free off per queue.
+
+        Verify:
+            * Mbuf_fast_free starts disabled.
+            * Mbuf_fast_free can be configured on per queue.
+            * Mbuf_fast_free can be configured off per queue.
+        """
+        with TestPmd() as testpmd:
+            verify = True
+            port_id = 0
+            num_queues = 4
+            queue_off: list[str | None] | None = [None] * num_queues
+            queue_on: list[str | None] | None = ["MBUF_FAST_FREE"] * num_queues
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

