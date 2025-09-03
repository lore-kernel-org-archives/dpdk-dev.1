Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D26CCA1009
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 18:04:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6807B40E96;
	Wed,  3 Sep 2025 20:04:37 +0200 (CEST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id F224C40E35
 for <dev@dpdk.org>; Wed,  3 Sep 2025 20:04:34 +0200 (CEST)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-4b5d5b1bfa3so1741441cf.1
 for <dev@dpdk.org>; Wed, 03 Sep 2025 11:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1756922674; x=1757527474; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q5z4d0kzrryVPAtwzDulT4/Wcak6lEkqSVHd9r9q104=;
 b=jC1LwEko2dF70x7Ms5RWzvmY9Gns8VlqtRDoucbEUVNL1pUH3jPLxzDdSvmMEBf3SB
 FkTBqe65x3W3E5JbNnVQT8NNxGevOqTy2NSuWyZ/LAnyx70LEvnevOhOoCG5zDsKuA04
 AsyFpvQWR+Z7iDcSA1DVFRpOsW6XS1ZRO5yig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756922674; x=1757527474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q5z4d0kzrryVPAtwzDulT4/Wcak6lEkqSVHd9r9q104=;
 b=RFCbBtvjR+SoWqrWZnT3vLzWLYp/uBMFVUeGTAUto3aRsivHbE/r2uPq50IRwA5wMK
 AH7I98TNVj7FcaL7yMsZZOGCkQTBehycEJ/5axmHAIEus3WjI/tyx2kHg1UPGYuMfrjk
 F9at01YXExOlcn3I0TxaM1ZeDa/NP2Q87r+TOl8H+24zuCNYrDtfpNsfciQ3ewdPhIRI
 AQt9jcAG92We/4klHcIkuSxVZmyH6kPRGUiJCBsdbtDG/cW2PP1DUFzSnLF2tvTau583
 SymdU1S3uGoy7qxMHLeEM/VqEDCrusewSZSJUUYQqs3btUPHNxLjnuvjWt9s97++r89k
 CxeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYIbQMNfPCuHPXSpPZOeNDMo7uCXIcplDUaI8l0ZBgS1bob0uz9QTiCSRjOWL9iCT1/50=@dpdk.org
X-Gm-Message-State: AOJu0Yx74tfPE7I6BGxeuq/uja+9+am6+b9Mdmm2z7HHdOBFHuVfxZrp
 EEeuYZqFYpacVrltWqf/iRvgcTJSiCZHv/8a9WAIS/NVjkeBhVt5iff20NvGtK4oY2hJ4n5KD9Z
 Lgbln
X-Gm-Gg: ASbGncsFqT6Zqm3o1WNs26MIfIOhMx8cRlPohVa+HD/ItmWKEqlan4EoY8N9gkEMBib
 j5RqnCfZWx+hq5wou1y0Hi3BktYaShaLzxrcKtrwJMWNOkLyoBN4TMKZ/xvUUyekvn5jPOgLCCK
 6IP2tzq+y2z6xViN4zZS3LjbUOJIG4i56sWwjsJOQVbYLdwa/OkOcrWsAOlIGBhzxDzSKCwPULE
 ORkTNIKW1yFXXQa7wJupAWNA6hPivog3vAx+CmR5dLs1txzS0oGhKI6yt6UnVAz8CHNJcfOqYms
 +53WaCYKFSieUnTFYMhzcUennVKJEpVXgC0xz1JbBIDih8I7uBoZG/lqlcvsY2okrNcZJGVxoei
 pNya9ymFuxExdy/g0DIXxiZi+sYj3ucvyfrbA8NCnxI2j
X-Google-Smtp-Source: AGHT+IEAhHDe5UI6e4DJAFWBHQl1b8SVNraaPktq6z+r5ZwjRo7zo6eW/OKoajkMzftQG6CDNvk1aQ==
X-Received: by 2002:a05:622a:5c6:b0:4b2:dee2:6498 with SMTP id
 d75a77b69052e-4b31d8607eamr180273181cf.28.1756922673944; 
 Wed, 03 Sep 2025 11:04:33 -0700 (PDT)
Received: from dhcp-10-21-133-214.unh.edu
 ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b48f62a861sm15073121cf.8.2025.09.03.11.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 11:04:33 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu,
 ivan.malov@arknetworks.am, probb@iol.unh.edu
Subject: [PATCH v2 3/3] dts: update tx_offload test from old dts
Date: Wed,  3 Sep 2025 14:04:14 -0400
Message-ID: <20250903180414.83001-4-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250903180414.83001-1-abailey@iol.unh.edu>
References: <20250902142725.56736-1-abailey@iol.unh.edu>
 <20250903180414.83001-1-abailey@iol.unh.edu>
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

Currently, the Rx/Tx offload test in old DTS expects the Tx ports to be
initially configured to use mbuf fast free. This is no longer the case
and must be updated to assume mbuf fast free is not initially utilized
by capable NICs. Add updated test suite to test mbuf fast free
configuration.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/tests/TestSuite_rxtx_offload.py | 148 ++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)
 create mode 100644 dts/tests/TestSuite_rxtx_offload.py

diff --git a/dts/tests/TestSuite_rxtx_offload.py b/dts/tests/TestSuite_rxtx_offload.py
new file mode 100644
index 0000000000..133994d795
--- /dev/null
+++ b/dts/tests/TestSuite_rxtx_offload.py
@@ -0,0 +1,148 @@
+# Copyright(c) 2025 University of New Hampshire
+
+"""Rx Tx offload test suite.
+
+Test the testpmd feature of configuring Rx and Tx offloads
+"""
+
+from framework.remote_session.testpmd_shell import (
+    NicCapability,
+    RxTxArgFlag,
+    TestPmdShell,
+)
+from framework.test_suite import TestSuite, func_test
+from framework.testbed_model.capability import requires
+
+
+@requires(NicCapability.TX_OFFLOAD_MBUF_FAST_FREE)
+class TestRxTxOffload(TestSuite):
+    """RX/TX offload test suite."""
+
+    def check_port_config(
+        self,
+        testpmd: TestPmdShell,
+        offload: str,
+        verify: bool,
+        port_id: int = 0,
+    ) -> bool:
+        """Checks that the current port configuration matches the given offload.
+
+        Args:
+            testpmd: The current testpmd shell session to send commands to.
+            offload: The expected configuration of the given port.
+            verify: Whether to verify the result of call to testpmd.
+            port_id: Id of the port to check.
+
+        Returns:
+            Whether current configuration matches given offload.
+        """
+        output = testpmd.get_rxtx_offload_config(RxTxArgFlag.TX, verify, port_id, 0)
+        return offload in output["port"] or (
+            offload == "NULL" and "MBUF_FAST_FREE" not in output["port"]
+        )
+
+    def check_queue_config(
+        self,
+        testpmd: TestPmdShell,
+        offload: list[str],
+        verify: bool,
+        port_id: int = 0,
+        num_queues: int = 0,
+    ) -> bool:
+        """Checks that the queue configuration matches the given offload.
+
+        Args:
+            testpmd: The current testpmd shell session to send commands to.
+            offload: The expected configuration of the queues, each index corresponds
+                to the queue id.
+            verify: Whether to verify commands sent to testpmd.
+            port_id: The port of which the queues reside.
+            num_queues: The number of queues to check.
+
+        Returns:
+            Whether current configuration matches given offload
+        """
+        output = testpmd.get_rxtx_offload_config(RxTxArgFlag.TX, verify, port_id, num_queues)
+        for i in range(0, num_queues):
+            if not (
+                offload[i] in output[i]
+                or (offload[i] == "NULL" and "MBUF_FAST_FREE" not in output[i])
+            ):
+                return False
+        return True
+
+    @func_test
+    def test_mbuf_fast_free_configurations(self) -> None:
+        """Ensure mbuf_fast_free can be configured with testpmd.
+
+        Steps:
+            Start up testpmd shell.
+            Toggle mbuf_fast_free on.
+            Toggle mbuf_fast_free off.
+
+        Verify:
+            Mbuf_fast_free starts disabled.
+            Mbuf_fast_free can be configured on.
+            Mbuf_fast_free can be configured off.
+        """
+        with TestPmdShell() as testpmd:
+            verify: bool = True
+            port_id: int = 0
+            num_queues: int = 4
+            queue_off: list[str] = []
+            queue_on: list[str] = []
+            mbuf_on = "MBUF_FAST_FREE"
+            mbuf_off = "NULL"
+
+            for _ in range(0, num_queues):
+                queue_off.append(mbuf_off)
+                queue_on.append(mbuf_on)
+
+            testpmd.set_ports_queues(num_queues)
+            testpmd.start_all_ports()
+
+            # Ensure mbuf_fast_free is disabled by default on port and queues
+            self.verify(
+                self.check_port_config(testpmd, mbuf_off, verify, port_id),
+                "Mbuf_fast_free enabled on port start",
+            )
+            self.verify(
+                self.check_queue_config(testpmd, queue_off, verify, port_id, num_queues),
+                "Mbuf_fast_free enabled on queue start",
+            )
+
+            # Enable mbuf_fast_free per queue and verify
+            testpmd.set_all_queues_mbuf_fast_free(True, verify, port_id, num_queues)
+            self.verify(
+                self.check_port_config(testpmd, mbuf_off, verify, port_id),
+                "Port configuration changed without call",
+            )
+            self.verify(
+                self.check_queue_config(testpmd, queue_on, verify, port_id, num_queues),
+                "Queues failed to enable mbuf_fast_free",
+            )
+
+            # Enable mbuf_fast_free per port and verify
+            testpmd.set_port_mbuf_fast_free(True, verify, port_id)
+            self.verify(
+                self.check_port_config(testpmd, mbuf_on, verify, port_id),
+                "Port failed to enable mbuf_fast_free",
+            )
+
+            # Disable mbuf_fast_free per queue and verify
+            testpmd.set_all_queues_mbuf_fast_free(False, verify, port_id, num_queues)
+            self.verify(
+                self.check_port_config(testpmd, mbuf_on, verify, port_id),
+                "Port configuration changed without call",
+            )
+            self.verify(
+                self.check_queue_config(testpmd, queue_off, verify, port_id, num_queues),
+                "Queues failed to disable mbuf_fast_free",
+            )
+
+            # Disable mbuf_fast_free per port and verify
+            testpmd.set_port_mbuf_fast_free(False, verify, port_id)
+            self.verify(
+                self.check_port_config(testpmd, mbuf_off, verify, port_id),
+                "Port failed to disable mbuf_fast_free",
+            )
-- 
2.50.1

