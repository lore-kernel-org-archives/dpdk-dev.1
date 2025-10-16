Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28280CCD199
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 13:27:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EF6A4279D;
	Thu, 16 Oct 2025 15:26:47 +0200 (CEST)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id B530C41153
 for <dev@dpdk.org>; Thu, 16 Oct 2025 15:26:44 +0200 (CEST)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-88f239686f2so96929085a.0
 for <dev@dpdk.org>; Thu, 16 Oct 2025 06:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1760621204; x=1761226004; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iEDx3sgFGgn1Jp1oegNkpFbPEcCGQw5MjWKYfaAnIPM=;
 b=TgnKnbvMiGEXCymisK9OwwNLQbRBJfSlFmddV2oFcSDopAg/NBcCXjXZ3gb9AmED5j
 Ruz4BbKasfUfHAOZjBJa6PBr3LqnTGL87dQcFQIz4y0OYaUbP04PQNV77c8KcyyjbHyF
 7Al031P22aY4GeUGllHJ0wHXENvKVynSrG/fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760621204; x=1761226004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iEDx3sgFGgn1Jp1oegNkpFbPEcCGQw5MjWKYfaAnIPM=;
 b=nncLDBjppq8UtznlnTFNLlAbDG6ePZ6rTT8rjb8ojQuFTszJeVn0xco3Zjj+1R1MVJ
 L58HETt+v8F1Di8pZObxWSlA+fNRw0vSedPBD/hzTczub81D/1XLKaqHDwjMIn0IhYUO
 Nd4zx10fqfhv2+B04ur3kJHgkngCCd1nGqih6k38uazZpNeYoiowvMXCzVQC60/lY+F5
 Y5Oxbr8NUcmKxhsPQnwq1v1yX3kri4rhzXhUINs8eFioDGHH0guxC4IBUlJiPz/Q97xC
 /b5MLZLxGc17Ppl3w6G48e5PNz7z/5TGtJGT0AlcXw83WONymaL5aYSA3KPZGzgtb6jR
 Ibww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhet79wgUdqrQgkyJCHmuueSvUrPt8r8dhtMSGMLJ8grJKJl9YYKTzKZ1qX7MT8xSTy/s=@dpdk.org
X-Gm-Message-State: AOJu0Yyj2z/WWOPRP3mKcENi7V+UeZIQ84kOeiecQuGXIJvZY0a57BFn
 IDNn+vnT8CjE4mKlC5g2kNB2CGPf3Jkbo267krBRHnJ3JXo2StlhEZuZivFWEex+oaoUJE1ENQT
 F19F9
X-Gm-Gg: ASbGnctQtYm5rKsWrNWzI8QHQPx/9A/ToJXtD/nJ1J4OSaGZTWt2WQmuoAukxTMcfAg
 8Wfe6OKTh42ZAPVr/gBTI0YWj58dtKoSTtZKtttUElui7RtQlQlNnuRWZtMBwt8QDOWme4bMNeu
 k+gY3tSlzc0eJkTso+2TB+9epiIX99fVBPhCsURA/ofVGIPJopmaRHCMOPpxhp+5R83e4WtCEGX
 5AQmOJJqmbTBsJ2x8LbGpBzlgL0n58D0UVZpoY3B2YovroJ2qI8LkNfVst+c84oHM0ZznbeAztZ
 4bOsRRM8sNrg/skDK6fBj/29HmeiqEzIgNoAU919FCg3N3APJbiMi2rUoSwmUChfVwYz3x2Wsou
 KTg0Tc7joWDyo6xyCVjPhrgyx+0Zy8WghCmjBNRy6m5oT5SXCjAvaObAsBAuy0/2k6vWMrRqwRX
 OMBewNaiI4X462AKBUIuxlexfDcWW0UXga8oTEQdbP/vSe+gDNyug=
X-Google-Smtp-Source: AGHT+IF3jZefZnP6crrnDKiIWTonsUu4zCt4vZCZwvntg7r/2+i9FCQqeKxqnAbPuVrBXigLInpYCA==
X-Received: by 2002:a05:622a:1895:b0:4e8:8b6e:7827 with SMTP id
 d75a77b69052e-4e89d3a480emr1367821cf.66.1760621204016; 
 Thu, 16 Oct 2025 06:26:44 -0700 (PDT)
Received: from d122205.iol.unh.edu (d122205.iol.unh.edu. [132.177.122.205])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e89aedad52sm4015661cf.30.2025.10.16.06.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 06:26:43 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: [PATCH v7 3/3] dts: update tx_offload test from legacy dts to next dts
Date: Thu, 16 Oct 2025 09:24:21 -0400
Message-ID: <20251016132421.12176-4-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016132421.12176-1-abailey@iol.unh.edu>
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20251016132421.12176-1-abailey@iol.unh.edu>
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
index 0000000000..f1610e9170
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
+                self._check_config(testpmd, "MBUF_FAST_FREE", "tx", port_id, verify=verify),
+                "MBUF_FAST_FREE disabled on port start.",
+            )
+            # disable MBUF_FAST_FREE per port and verify
+            testpmd.set_port_mbuf_fast_free(False, port_id, verify)
+            self.verify(
+                self._check_config(testpmd, None, "tx", port_id, verify=verify),
+                "Failed to enable MBUF_FAST_FREE on port.",
+            )
+            # Enable MBUF_FAST_FREE per port and verify
+            testpmd.set_port_mbuf_fast_free(True, port_id, verify)
+            self.verify(
+                self._check_config(testpmd, "MBUF_FAST_FREE", "tx", port_id, verify=verify),
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
+                    testpmd, "MBUF_FAST_FREE", "tx", port_id, queue_on, verify=verify
+                ),
+                "MBUF_FAST_FREE disabled on queue start.",
+            )
+            # Disable mbuf_fast_free per queue and verify
+            self._set_all_queues_mbuf_fast_free(testpmd, False, port_id, num_queues, verify)
+            self.verify(
+                self._check_config(testpmd, "MBUF_FAST_FREE", "tx", port_id, queue_off, verify),
+                "Failed to disable MBUF_FAST_FREE on all queues.",
+            )
+            # Disable mbuf_fast_free per queue and verify
+            self._set_all_queues_mbuf_fast_free(testpmd, True, port_id, num_queues, verify)
+            self.verify(
+                self._check_config(testpmd, "MBUF_FAST_FREE", "tx", port_id, queue_on, verify),
+                "Failed to enable MBUF_FAST_FREE on all queues.",
+            )
-- 
2.50.1

