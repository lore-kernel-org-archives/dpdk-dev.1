Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EA6CCF9EA
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 13:03:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A764B40609;
	Mon, 27 Oct 2025 14:02:59 +0100 (CET)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTP id 166314028B
 for <dev@dpdk.org>; Mon, 27 Oct 2025 14:02:58 +0100 (CET)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-4e88cacc5d9so42427671cf.0
 for <dev@dpdk.org>; Mon, 27 Oct 2025 06:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761570177; x=1762174977; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LoeIamLm8DhZhrTfYDb+gb/tTXtbWpvafXwfKSCO6s0=;
 b=NsvObj9/1Kzfu+iC3KcGMNxzIeStUuV/9jtVMCGORq1PhOcghIVv5oh0uQ+gu99Sz2
 bOvnfjMIQ+xhZX1xy/HNh1YLd8IscqlWRm/7BY1bDW0HreikcC1ojFg7CB0hb1/b/Jxp
 puTyrMrG0dKVLZKWkvtBLkrmKKDj8QhmLeepQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761570177; x=1762174977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LoeIamLm8DhZhrTfYDb+gb/tTXtbWpvafXwfKSCO6s0=;
 b=Nl3WzqZcD/xn4EwLb+OMkeC6QMR+1sAYjHB3zkOaV3DeWxxssZpGW4czm2u5HqrUuS
 unRUhKia4FcZhrB4a+kTl0gqUAzKw01b9md+jAOE//NbMyxc6Gxes+9P4whadkjYJG5V
 2ECs+wJQLcVgFR9QLooMLuIsINvtoOGFFqGE9w/ijWvSXH4ln3ioOx783CWC0rlHEGmJ
 ssyG+ptMoSYYKyKJ7WNH+NqgLy2xNgt1ITZzjln4TG7ePauH0OMeYVtynWNJkG1NJ38T
 UbY1W+SM+RGo3xrZlh8WMDHF6dlZxkkrgpFSeM6A0x+ughCbujBov66lkHQ4+EvbzHJ/
 Dd1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXbxr5/mttJBWQ36CWe2TeNZH+T3gcE8+y3sj6YKmL/yvT2Sffg9j7kxRsZF57h9pCZjM=@dpdk.org
X-Gm-Message-State: AOJu0YzlBkSht3CqlGOv3+liwy/Lk8UWUDlHsuxQf0fxIp4zy9rUvtpx
 CFqFxnOJkFg7SDNs3arrpkcFryoZ5RaS1K8b6hnVru/x6qsWMR/Jr93ScUYZH8anWAg=
X-Gm-Gg: ASbGncscLhzWqcTB6TaYxKjJnSJVNY27CRYeHcz1yCVbY2vSV+B+Yjk/evaT16Ek2C6
 xD7TM+t4ImQVMynA92aMObW5BM16sWGP7iJg0u2HUSVO8LZX3QoCO7BojNcoXhCFeNfjGZq1vGj
 S7KXPGWAbX9TfEqVBckH+9HSiUm5czm/Nopx7+Dmv+RX9bs5rHLoqpQuRy2kA/nwZrQBglJuKzq
 ACUefcNvQlwP5pBx+RUxVwvKk2j77vNBZ8WiIx07TI3h/BtmI2Puo2s7ouyrbl9t/FWx0SZEZ9n
 TqFXC7qnIUrpTWJ5+zB9vocUbRuyy6PO8udJcepB5QJYhisy4eBnqZUcIBFRLTgrrnDCop7Meb7
 7JJ0UKC3WTtmyk4q5ZwwoqTJzjvmQhP7MIhsOiaOqY3gDqCFARtrtl8gPqex8h2lZuLs2nHASLF
 agIyN+ao/8zcQP
X-Google-Smtp-Source: AGHT+IGBt28c06RNQhoxUca37BaUeZc3DL54u9sjytegiVhFw0y1ibl09uLPjd5t0YXdV2ZVZjUJhQ==
X-Received: by 2002:a05:622a:4c1b:b0:4ec:eea3:41f7 with SMTP id
 d75a77b69052e-4eceea34826mr75852651cf.72.1761570166732; 
 Mon, 27 Oct 2025 06:02:46 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4eba37b96d0sm51104511cf.6.2025.10.27.06.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 06:02:46 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu, luca.vizzarro@arm.com
Subject: [PATCH v10 3/3] dts: add Rx Tx offload test suite
Date: Mon, 27 Oct 2025 09:02:15 -0400
Message-ID: <20251027130215.95444-4-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251027130215.95444-1-abailey@iol.unh.edu>
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20251027130215.95444-1-abailey@iol.unh.edu>
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
index 0000000000..1708c79c50
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
+from api.test import verify
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
+    ) -> bool:
+        config: OffloadConfiguration = testpmd.get_offload_config(port_id, rxtx)
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

