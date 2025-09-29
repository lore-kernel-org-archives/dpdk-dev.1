Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE574CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 17:28:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89D8C40B94;
	Mon, 29 Sep 2025 19:27:50 +0200 (CEST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id D7C9D4067B
 for <dev@dpdk.org>; Mon, 29 Sep 2025 19:27:42 +0200 (CEST)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-85c66a8a462so619487385a.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 10:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1759166862; x=1759771662; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2cOK+0RtypsAjU5MVeE1I8RiIbI2Im/9xWcNJSV8x4=;
 b=Izy5iaK1Y873hANNT0Sa55mGreYC7iMZ8/mYA/3ApUP26eV0AUBJ+zGr0W6Sn515+6
 1n09XwlDZ+JOBmQrb0Po0pmo08pf2C/QJfNteaOLFHFL4vsyxNGuxc1KzgYP3MkTyvcB
 JQCofnMCQiWRt0qEd8bGV5cESzRKWyj7WlFwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759166862; x=1759771662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G2cOK+0RtypsAjU5MVeE1I8RiIbI2Im/9xWcNJSV8x4=;
 b=IwBU/vTOzKPLQgFTohrQCkhSno3NYgA6+YD6ZBbzhTi1IHrco+t1fJZ/mPTGsLblWw
 j4TsBEUGwlh340FBewgz7wf8ByttkkHGyufd6m80FT4m6WF8hFPMGcI0WlOLmNG7PRwL
 gE/VR5y/Xl6cWLBbb3ObHHw0SmrilmOEHWVlQ6s4gc9bVsZVzQZHyLVojNT1oWok2stD
 n9CcHX4ANx2HaHGxQbt8E3hM16uJerTKuLhE7EczsbFJLLENOOz2AROk7ni5T/ny1Hpx
 D1IIFrhtn8OfaC6MYC0Wdxi6VKUCxYo3CLxum5SMDxZ6nGAP3KG3QHuU66KndV8nr5YT
 SJRA==
X-Gm-Message-State: AOJu0YzbUqYClFq7QL4yh70gNuwdXWVhmJYDKoc0CEjIAZrkUU/VmlHv
 y+UD2T9m+NLIvYtzpmvZFEhwwTDWS0hmRkbWjFUACVPt2IhB95k41Jx7EWZb+wc6jio=
X-Gm-Gg: ASbGncvq/9FgGoC2J0Ywr7Mtr2Ch7zuNrHUNUgepqkfr5nhq+gA5BdCJpQP1T2/5II3
 IAdtpQtK4CtgdeHV0GcQpZsu/0fSzgZ0uT154HgYBLpZqQkIzMZx0KXe8wvO+DHiHHuANC4pjko
 SF6ntBlsorkp1wbyHJT7KDc+6xrzf5U1gWHMEQ0y+18efpFdpF5iRqSocnzIkPGHYxKWCYiraNA
 h+Y38olfKnrLwkbAsdKZgwnnJuJc4goqo1K/GaO70Hfcj/Q+7NPgGvSXnMQH9Hn5UNwaTPvpbMA
 bmQBUxdULSMLQOFMnfDyUf0rxmuT7osqnW/trkLtifmhLrTCnUzi0qkaNmQ89DskOu/Zwer4tdp
 fGyvTE91mPlM468BBhAE3VETMthhjorfVEFGK9vw4FHzYkw==
X-Google-Smtp-Source: AGHT+IH/AdbLnC5S5skXYuMSNYGdAIL8Sz5LWBDY+9npIMsNjr9IUifhHdZmzl1HGONTUYdfRxZKJA==
X-Received: by 2002:a05:620a:4096:b0:84d:e17a:6f with SMTP id
 af79cd13be357-85aed4018eamr2137874485a.77.1759166862096; 
 Mon, 29 Sep 2025 10:27:42 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-85c337a1c97sm838586585a.55.2025.09.29.10.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 10:27:41 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, ivan.malov@arknetworks.am,
 probb@iol.unh.edu, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v6 3/3] dts: update tx_offload test from old dts
Date: Mon, 29 Sep 2025 13:27:34 -0400
Message-ID: <20250929172734.218467-4-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250929172734.218467-1-abailey@iol.unh.edu>
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20250929172734.218467-1-abailey@iol.unh.edu>
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

