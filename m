Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87220CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 14:46:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE35E4069F;
	Tue, 21 Oct 2025 16:45:53 +0200 (CEST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id 851704066D
 for <dev@dpdk.org>; Tue, 21 Oct 2025 16:45:50 +0200 (CEST)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-88f2b29b651so820317585a.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 07:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761057950; x=1761662750; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DvAtLcWd3wx2aAhpNTkZq2T0c9LscxL4ogioH/AQ+30=;
 b=bUZA3Bwekjk2xAtr1QPUCnfRaukO6bcQTBt4la/uKRHo5ejYn4D597vGsbXfaQlIVf
 NeF+tizDTSeZul+UMT92y4JtVa2dtDQGMHXtSE5ibHPHWqU0M81DzRps+p8rPKHLT+ul
 s9w867svHF4Rglo6RwU8Z5pvhzZekdwgRPtVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761057950; x=1761662750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DvAtLcWd3wx2aAhpNTkZq2T0c9LscxL4ogioH/AQ+30=;
 b=W0MoPr79qMzx5ZUbMVtpHXaBg4tmwjpQlvGQlgK1ubDysoPzIJhYNFR6Y8ovhvML8R
 ArhLWOspofzEGVGdiKQW74r/BTmmQGiDmh8OGnXM1ag5+bC7dYTqkuqHmPIhUFzINctg
 Ebg0SNfqpXQD5K5diROIk55+EcahmOqG3LOj0yN3t/NkQTFmU1KTwqTTLUukXVLtxk7u
 6q09v305zzDpbX2Wp81w2cgaAUi55MYScvw9ZXvsRwDKlkNBj+Riky6+Jnb84WBlk+HA
 QW47JiVwH5JYf8EZgYgCpD4t3FxtrbRyK156nbIUFo6YjtNOmlvqbL1XMaAUl940g7AZ
 fHQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzBdBVw9QTmTy+B1zf+PrND16DEG8LAdJYdjH+c5fgnFwt4stiyqcP3FqcawNgIN3fRKU=@dpdk.org
X-Gm-Message-State: AOJu0YwT89NMwkEauqWoj/tiOfgkRrtS14DaSUrGT+zMI6hbIfVBJSfv
 n5bPr+mB8JjrTMy7GYUSUcd7xVy67ehosdXxO1lqwXBA/Dv8+hF0rOuWhENouGvYteU=
X-Gm-Gg: ASbGncsN4i1WihSqklwGB683IrVW1kGJJKmfTO/FXrAeiTefotKBJqtQJMdVwHyOn3l
 fFkyCI5Vk3ZHRVR6gkDK4tIzSlmYusLiMmRVhkDd8Oqzp0YT1xRGxDas+856c6zByOn4XJaik/X
 akA1jQAYpPmInX7AvgYP2BFGNQbYiRLZH8mOtSUkcZ5wTUoahDeL6pXRfx/lxw3vwXd8e1u6xHw
 lktTzIFBgUZIbrdgqPfleIUSJPiW3leDdvuovF31F37W0OS35C2IOBiQKryiICTBOllzz9wv7Dh
 IJFO6VkspA7c5Ry80lj7huydZeKlPuQwMLH9k67I2OgzRYVdpsO4zUt4DI5z0r9Vus9vf/voUkF
 +GIc2WHbYiH63y7I+gqdk4Zuga0xSYXtPv/ByuevVAjvU3pfTg1vMnEwiqd5uG4sohtDJhnkGqa
 kiE1Qg/SnvalRWyqWc7sDqhrw=
X-Google-Smtp-Source: AGHT+IHNZ1t1cply5NPCLoqu0j1HeIQdNdlb6avG4IT78aCPpAcm+dkciV8oCEmKiVqYfrBwT+scLg==
X-Received: by 2002:a05:620a:408d:b0:861:5b8c:3c14 with SMTP id
 af79cd13be357-890708f27f9mr1970996185a.46.1761057949770; 
 Tue, 21 Oct 2025 07:45:49 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-891cd57b780sm770350385a.24.2025.10.21.07.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 07:45:49 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: [PATCH v8 3/3] dts: update tx_offload test from legacy dts to next dts
Date: Tue, 21 Oct 2025 10:45:28 -0400
Message-ID: <20251021144528.39748-4-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251021144528.39748-1-abailey@iol.unh.edu>
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20251021144528.39748-1-abailey@iol.unh.edu>
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
 dts/tests/TestSuite_rx_tx_offload.py          | 128 ++++++++++++++++++
 2 files changed, 136 insertions(+)
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
index 0000000000..ab34e95c44
--- /dev/null
+++ b/dts/tests/TestSuite_rx_tx_offload.py
@@ -0,0 +1,128 @@
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
+        port_id: int,
+        port_offload: str | None,
+        rxtx: RxTxLiteralSwitch,
+        /,
+        queue_offload: list[str | None] | None = None,
+        verify: bool = True,
+    ) -> bool:
+        config: OffloadConfiguration = testpmd.get_offload_config(port_id, rxtx, verify)
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
+        self, testpmd: TestPmd, port_id: int, on: bool, num_queues: int, /, verify: bool = True
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
+            * Toggle mbuf_fast_free off per port.
+            * Toggle mbuf_fast_free on per port.
+
+        Verify:
+            * Mbuf_fast_free starts enabled.
+            * Mbuf_fast_free can be configured off per port.
+            * Mbuf_fast_free can be configured on per port.
+        """
+        with TestPmd() as testpmd:
+            verify = True
+            port_id = 0
+            testpmd.start_all_ports()
+
+            # Ensure MBUF_FAST_FREE is enabled by default and verify
+            self.verify(
+                self._check_config(testpmd, port_id, "MBUF_FAST_FREE", "tx", verify=verify),
+                "MBUF_FAST_FREE disabled on port start.",
+            )
+            # disable MBUF_FAST_FREE per port and verify
+            testpmd.set_port_mbuf_fast_free(port_id, False, verify)
+            self.verify(
+                self._check_config(testpmd, port_id, None, "tx", verify=verify),
+                "Failed to enable MBUF_FAST_FREE on port.",
+            )
+            # Enable MBUF_FAST_FREE per port and verify
+            testpmd.set_port_mbuf_fast_free(port_id, True, verify)
+            self.verify(
+                self._check_config(testpmd, port_id, "MBUF_FAST_FREE", "tx", verify=verify),
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
+            verify = True
+            port_id = 0
+            num_queues = 4
+            queue_off: list[str | None] | None = [None] * num_queues
+            queue_on: list[str | None] | None = ["MBUF_FAST_FREE"] * num_queues
+
+            testpmd.set_ports_queues(num_queues)
+            testpmd.start_all_ports()
+
+            # Ensure mbuf_fast_free is enabled by default on port and queues
+            self.verify(
+                self._check_config(
+                    testpmd, port_id, "MBUF_FAST_FREE", "tx", queue_on, verify=verify
+                ),
+                "MBUF_FAST_FREE disabled on queue start.",
+            )
+            # Disable mbuf_fast_free per queue and verify
+            self._set_all_queues_mbuf_fast_free(testpmd, port_id, False, num_queues, verify)
+            self.verify(
+                self._check_config(testpmd, port_id, "MBUF_FAST_FREE", "tx", queue_off, verify),
+                "Failed to disable MBUF_FAST_FREE on all queues.",
+            )
+            # Disable mbuf_fast_free per queue and verify
+            self._set_all_queues_mbuf_fast_free(testpmd, port_id, True, num_queues, verify)
+            self.verify(
+                self._check_config(testpmd, port_id, "MBUF_FAST_FREE", "tx", queue_on, verify),
+                "Failed to enable MBUF_FAST_FREE on all queues.",
+            )
-- 
2.50.1

