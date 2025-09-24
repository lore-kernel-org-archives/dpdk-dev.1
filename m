Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0210CCAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 16:47:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E73E040BA0;
	Wed, 24 Sep 2025 18:47:42 +0200 (CEST)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id 1F40C4065C
 for <dev@dpdk.org>; Wed, 24 Sep 2025 18:47:39 +0200 (CEST)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-792f273fbe4so38445816d6.3
 for <dev@dpdk.org>; Wed, 24 Sep 2025 09:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1758732458; x=1759337258; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rP/k+79MQDjVscRmR9hlCnTKsxwmVrEVUCwo7iB8niY=;
 b=WQY98b58cMU0oOnKPBc5Tj3sNclQXdP4KM+Xxwv1/7weIqYqlywr0JvWREVZshoD9o
 mAKBfJywlbrp8FdBAdJSWcF+4xhApwGKfNfR2Olom/iF3Dt4zoY62zt050cguCaXSIc9
 sQGPrykepXG70a3HqZAGrgh+zj9U9Se8dzEgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758732458; x=1759337258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rP/k+79MQDjVscRmR9hlCnTKsxwmVrEVUCwo7iB8niY=;
 b=LghVW8BkuLilegUWTYCrvp5st0DwsDSP9W9964982ViBjm0ngrRA4GkWsDzU+k0wiq
 z0eCxeDVTPl4X05PNAE5Xjxa/Co2G7ZVhm3Deq4kT+0Enypm8puHfhjGEQxa1GVL7r6G
 6s9cWGxBvGhnKkvmk29p22mhmywwmRNZL0K21iLiWg5kcT+oZn/iHrlb4pTDfRKPZQqY
 3XG4L5wjH6VC24L/3SJX+rKx+KTce6l90DzKTxk4Wau5kq9879CubggQ+YLVP4jS581j
 VsdAw1lWt23mg5utq13XXLx6Em7DpYUmSKjKuZuctZZ7z5QmrLYaqwEzPCrgESZ2vcOl
 6rbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXtrwIwyp7QEQNgdavnuku0PCssqNJnKMEiersEzQW1Q8LEun+7cWdDHiAF3O1b09iIEw=@dpdk.org
X-Gm-Message-State: AOJu0YxRsPabk5iVY7NigdE0S33VFqsbmVgh9YHKqyVn6BB8pxgqGO2A
 mHYPgrg8t13NSi69qKFSl9MkHhnsp1rpsH5a1W8Z2AhzIDk2tBB9pNwcsF6p22Zia7UkFBH7lKE
 KmZPm
X-Gm-Gg: ASbGncs9OFMu2Nv85oFLnoojUvIFYdK3QBW6QkxLjBVgbZyFJ7VjFAqJqQXb0avkFAE
 GUB54VMh3sBovrccjP1DTjxH8dKf/3t1mqVdUOrhhTDOzXYNmHtMaDB94yHfAkKhJTah3XxtPYp
 039coKJ/Tjn3G/RV6sLX995Gi24V78L+lKCFFwLLGw4zLlNUWIypYwKzt+UCG2XdpOfmWy0Xu1h
 ZEWG+yGPxkYZ1Z8L4vBk8g+rDgs+Xq7M+Env8Nf1i15vCkQheL0g/YUdUK+sqn5cuWQ5Kg/RTmD
 1926DagMuKlor9m39dwe0RlG6AIgiUzfQ1dLr+hIxktdegf/fhxEyFlGS8EeW8aPdaZWhr/GRVQ
 GgE9+jX1LDmDsW6uBXqYjK8nNsyDXcmtHiB4=
X-Google-Smtp-Source: AGHT+IHcv5E5GQN755t0ypH01x6DUXqjrA/kCPmW7mn/hR1cbUvkPKpUrx/KV3G03GHnPVAmU4rAkw==
X-Received: by 2002:a05:6214:1252:b0:7b4:d622:84d6 with SMTP id
 6a1803df08f44-7fc2d51d191mr9952966d6.22.1758732458277; 
 Wed, 24 Sep 2025 09:47:38 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7a4c5785d49sm76849996d6.63.2025.09.24.09.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 09:47:37 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu,
 ivan.malov@arknetworks.am, probb@iol.unh.edu
Subject: [PATCH v4 3/3] dts: update tx_offload test from old dts
Date: Wed, 24 Sep 2025 12:47:25 -0400
Message-ID: <20250924164725.168773-4-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250924164725.168773-1-abailey@iol.unh.edu>
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20250924164725.168773-1-abailey@iol.unh.edu>
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
 dts/tests/TestSuite_rx_tx_offload.py          | 128 ++++++++++++++++++
 2 files changed, 136 insertions(+)
 create mode 100644 doc/api/dts/tests.TestSuite_rx_tx_offload.rst
 create mode 100644 dts/tests/TestSuite_rx_tx_offload.py

diff --git a/doc/api/dts/tests.TestSuite_rx_tx_offload.rst b/doc/api/dts/tests.TestSuite_rx_tx_offload.rst
new file mode 100644
index 0000000000..225267a45f
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_rx_tx_offload.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+rx_tx_offload Test Suite
+=========================
+
+.. automodule:: tests.TestSuite_rx_tx_offload
+   :members:
+   :show-inheritance:
\ No newline at end of file
diff --git a/dts/tests/TestSuite_rx_tx_offload.py b/dts/tests/TestSuite_rx_tx_offload.py
new file mode 100644
index 0000000000..6ae98068e4
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
+            queue_off: list[str | None] | None = [None] * num_queues
+            queue_on: list[str | None] | None = ["TX_OFFLOAD_MBUF_FAST_FREE"] * num_queues
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

