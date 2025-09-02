Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66081CA1005
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 14:28:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D982D40678;
	Tue,  2 Sep 2025 16:28:12 +0200 (CEST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id 8A1B840670
 for <dev@dpdk.org>; Tue,  2 Sep 2025 16:28:11 +0200 (CEST)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-70deaa19d5aso31502966d6.1
 for <dev@dpdk.org>; Tue, 02 Sep 2025 07:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1756823291; x=1757428091; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ujuE1tkW+uC9UHbawblAz1oCtLM9Oyu3l/dvkagPmQ=;
 b=bY9fUF7FSjoxOOjMkMdRVSI/UHn0x2UwOyjWyUr/Jw+R6i0lMKA/e6gZ4ECkepmw5+
 bn3I5GGrdMR178Nv8A1ZeIYSm5c0ipWPyZ53BONJjL+4Y4pVmRjAEUNtETPcDaMemNH/
 mPuBbGtpCs3Ka/AMXx+ThGQYHuqskQxRM2fWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756823291; x=1757428091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ujuE1tkW+uC9UHbawblAz1oCtLM9Oyu3l/dvkagPmQ=;
 b=aGpP2DWr5MV0H9n4N+4GSQyhdlvAmAQdkC59MYjI4PzskdAGPAejFRZJnjeMklxHVE
 /nAIXT1s/XOjz4TPVt6tvQarK1wSYXOOOURu6X2R3Qs9+Q00TpYhVrfwxSWYsDpiu+Ki
 aVy+VdH56P0LFoK57EfwYDU80nHoubzTSs2h4REezVH6M/9rX8c3ICecn4nqaVCuwAI7
 wgd6MDp74mWbZpnOCVmXRqDcZI09tWKslGL9KEaxV/rZngN7wkbLtay813PepTo732Fw
 HQ0BGZe2WeMOpulccbnR6TYhbb/sV/4UF4dDsST4C6NJo+ThIx9o3Zso+4Eb5hjKEWr7
 KM6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKI7tQ7h4tTHJxuWEMNB410vByEIfezx1bzDS5/tkmLy1/Q8CfyFdRXq6/t74LwRtxHPU=@dpdk.org
X-Gm-Message-State: AOJu0YxXOx016KpP7I5VF6bPE7PFJIeR5vFrd2BiuuIq6/iA53UM83Xq
 8BdhZ++WGKy0b1u7bMxI1bv1ksrmDPP+GpbRCw+cnaUfUdZ/4bIRitmcTf0dA/5h0ek=
X-Gm-Gg: ASbGncu7oZK5eBtqb86QjaufHLZBPSdKp2p8sRWC7kZRDEzAASiddt1TejtImnkSPva
 vDuh7VsRv75GoRt9dTliaG44NF8MHN2Fx0KzjgM4nnCRrN6E0ivltbANlbt8wSyEpDMejQ98euP
 b8MUOCHwjaAcIGtDbvUeG3I0sI16U/wdKCwcSbLxOuhxLeWvsAW+4di9yyXTzkpYiOlahlLoYnp
 L/hZM8P8x3dvlEFvD0QKOYgHEk7ryz5M1Ir10sJvWPGPIu8PMDPxgfgEq2g+8VylMZH0YOvHX7X
 P6sZNDMtgZR+nkCUQbsP4/DhntX33am34o6oKDXQm4CfpAbS3WztDMEPSLXg2uD+Kl0x5G5+Djh
 U8ZeyUejZprigiVdQ2e6K6fiJ0u+iPNfMFinK9iN8nKGpyQ==
X-Google-Smtp-Source: AGHT+IGaLYjPBgS+MiyQL/w0clZVBzANBlsbiYuwlGEYLSCeFEHqpVYGIhkN4430TWsnmXVHU6RAEA==
X-Received: by 2002:a05:6214:262e:b0:70d:a2f9:396a with SMTP id
 6a1803df08f44-70fac6ea05fmr119038486d6.11.1756823290509; 
 Tue, 02 Sep 2025 07:28:10 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-720b57c2893sm12346186d6.53.2025.09.02.07.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 07:28:09 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: [PATCH v1 3/3] dts: update tx_offload test from old dts
Date: Tue,  2 Sep 2025 10:27:25 -0400
Message-ID: <20250902142725.56736-4-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250902142725.56736-1-abailey@iol.unh.edu>
References: <20250902142725.56736-1-abailey@iol.unh.edu>
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
 dts/tests/TestSuite_rxtx_offload.py | 153 ++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)
 create mode 100644 dts/tests/TestSuite_rxtx_offload.py

diff --git a/dts/tests/TestSuite_rxtx_offload.py b/dts/tests/TestSuite_rxtx_offload.py
new file mode 100644
index 0000000000..f4a51a5eed
--- /dev/null
+++ b/dts/tests/TestSuite_rxtx_offload.py
@@ -0,0 +1,153 @@
+# Copyright(c) 2025 University of New Hampshire
+
+"""RX TX offload test suite.
+
+Test the testpmd feature of configuring RX and TX offloads
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
+        rxtx: RxTxArgFlag,
+        verify: bool,
+        port_id: int = 0,
+    ) -> bool:
+        """Checks that the current port configuration matches the given offload.
+
+        Args:
+            testpmd: The currrent testpmd shell session to send commands to.
+            offload: The expected configuration of the given port.
+            rxtx: Whether to check the RX or TX configuration of the given port.
+            verify: Whether to verify the result of call to testpmd.
+            port_id: Id of the port to check.
+
+        Returns:
+            Whether current configuration matches given offload.
+        """
+        output = testpmd.get_rxtx_offload_config(rxtx, verify, port_id, 0)
+        return offload in output["port"] or (
+            offload == "NULL" and "MBUF_FAST_FREE" not in output["port"]
+        )
+
+    def check_queue_config(
+        self,
+        testpmd: TestPmdShell,
+        offload: list[str],
+        rxtx: RxTxArgFlag,
+        verify: bool,
+        port_id: int = 0,
+        num_queues: int = 0,
+    ) -> bool:
+        """Checks that the queue configuration matches the given offload.
+
+        Args:
+            testpmd: The currrent testpmd shell session to send commands to.
+            offload: The expected configuration of the queues, each index corresponds
+                to the queue id.
+            rxtx: Whether to check the RX or TX configuration of the given queues.
+            verify: Whether to verify commands sent to testpmd.
+            port_id: The port of which the queues reside.
+            num_queues: The number of queues to check.
+
+        Returns:
+            Whether current configuration matches given offload
+        """
+        output = testpmd.get_rxtx_offload_config(rxtx, verify, port_id, num_queues)
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
+            tx = RxTxArgFlag.TX
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
+                self.check_port_config(testpmd, mbuf_off, tx, verify, port_id),
+                "Mbuf_fast_free enabled on port start",
+            )
+            self.verify(
+                self.check_queue_config(testpmd, queue_off, tx, verify, port_id, num_queues),
+                "Mbuf_fast_free enabled on queue start",
+            )
+
+            # Enable mbuf_fast_free per queue and verify
+            testpmd.set_all_queues_rxtx_mbuf_fast_free(tx, True, verify, port_id, num_queues)
+            self.verify(
+                self.check_port_config(testpmd, mbuf_off, tx, verify, port_id),
+                "Port configuration changed without call",
+            )
+            self.verify(
+                self.check_queue_config(testpmd, queue_on, tx, verify, port_id, num_queues),
+                "Queues failed to enable mbuf_fast_free",
+            )
+
+            # Enable mbuf_fast_free per port and verify
+            testpmd.set_port_rxtx_mbuf_fast_free(tx, True, verify, port_id)
+            self.verify(
+                self.check_port_config(testpmd, mbuf_on, tx, verify, port_id),
+                "Port failed to enable mbuf_fast_free",
+            )
+
+            # Disable mbuf_fast_free per queue and verify
+            testpmd.set_all_queues_rxtx_mbuf_fast_free(tx, False, verify, port_id, num_queues)
+            self.verify(
+                self.check_port_config(testpmd, mbuf_on, tx, verify, port_id),
+                "Port configuration changed without call",
+            )
+            self.verify(
+                self.check_queue_config(testpmd, queue_off, tx, verify, port_id, num_queues),
+                "Queues failed to disable mbuf_fast_free",
+            )
+
+            # Disable mbuf_fast_free per port and verify
+            testpmd.set_port_rxtx_mbuf_fast_free(tx, False, verify, port_id)
+            self.verify(
+                self.check_port_config(testpmd, mbuf_off, tx, verify, port_id),
+                "Port failed to disable mbuf_fast_free",
+            )
--
2.50.1

