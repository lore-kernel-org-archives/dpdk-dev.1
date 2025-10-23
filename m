Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCD4CCD1BC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 12:32:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6F3E402C1;
	Thu, 23 Oct 2025 14:32:36 +0200 (CEST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id 6902940151
 for <dev@dpdk.org>; Thu, 23 Oct 2025 14:32:35 +0200 (CEST)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-88f2aebce7fso81322685a.3
 for <dev@dpdk.org>; Thu, 23 Oct 2025 05:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761222755; x=1761827555; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ykU/R6SLW95UD8/yVItiYa9bVbfjhovYfC0AJPlXX0=;
 b=cmvjOckFDQYChatGJuRn7NUrgX7RFRM0mwOQ6fHgpQD+xen0qTHPnk2+6chNBnKcSU
 2b2zD3ki6p8mQt+kHfPbOmF1BuH9WJWVMrIK0FCULZmcQ3qT0AGkYoOztoRIaaUcm6uE
 drJQgvOrcOhcu+u4/Mt4qTvhB4p9ECyMTKsS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761222755; x=1761827555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ykU/R6SLW95UD8/yVItiYa9bVbfjhovYfC0AJPlXX0=;
 b=oF+Jr08tbH8RDypPcPe5byv4h8ndA2CFQ/G3AV3SJasZwy6Lt7cBWAhKX/n3oBxXy7
 /TVK4Hy9e8KvF8DnA2AvBulLvPCn1lDi0kQOSPQ2oaLo1G2tFyYIVBzaf9l6G6isfgTS
 oUUX7tnON3vKR6plMRmwDjhC1aibhM4Rb/HeGkfYExqVQW4DrSrnY3frnd2QFXGJayr/
 SlbNtZdbE3xlgnC1e49T6Oq6VVSPoNmYEtpJ4CeUi9lVVN0IsAb+7jeUadPXLZVU4GEC
 yHuDDDiK3TZuvT8jb4rfDVNyLFVVcoPYJmX8l8HS4qn2vUNK8tXJ/7NiOdIh/W/HljN5
 HgyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiGgzz2R3GQUbb4FJ8b0SHQbfq/19oR61uWsqaW6d1+nz/tffEPKYhBKYvXzJwAq8ig2U=@dpdk.org
X-Gm-Message-State: AOJu0YyeM+88eTD/h7+pujPc/inULdlvzVzh2Vbm68Fm2NLUi51Ox1rD
 4cJGrAuvNkP+6HPhZDGWXe7gHspWTvo3UKG0t9koCZeOV4n7svO2WoJtK0GG4xMIgBU=
X-Gm-Gg: ASbGncuRqXV2tg5z49nJ88Cty5LDS8fRFVtxVZTP829AVmBjkyBOIuAIJRifdm3lyyW
 vfQmt6uqAnNsQGaM4ALUKTKdH97zr5SRY+Yd6n0n3Dhd7/mUuo4S2kflLVRDpjHdafZcQkYQvUm
 QNObIoJdwMECuZftltNIM24JdxA0UlUuX+wG3ZoCfvqBi+YYF5uy+jPWeVbX+WFWtkqbx8s1bkB
 Sv5kj55T2yhrwt9nZYK3SWNVG3Q0gtn1rzYRzNeSXH4t/aPgpI0PdGRLb6+jOUlVErWtP1CYWKw
 f7X9KTJL0n+kyj7WcMABe2vgPsSjczCVvORM6Cyunw5G6dNcscZXZOhG8Nto0vJSVBOTo1Pk8nP
 Zz+KMnUOFh25wPbn8sK/TRFHxC94FrrQBlQzv23j3FZ4G5ru7EkLscLdewmXFEJvPTajKDaRMfc
 XcEK0+dE977GVC
X-Google-Smtp-Source: AGHT+IEFA7yxQ/UiKtYqtwjL7M8ulaCUg6yItNzyk8hlmdSdhTeML9q4FI11ByyC948w1vUVmFK8cQ==
X-Received: by 2002:a05:620a:4621:b0:88f:228c:c6a0 with SMTP id
 af79cd13be357-8906e8af048mr2625649385a.24.1761222751642; 
 Thu, 23 Oct 2025 05:32:31 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4eb805cdd6csm13137021cf.6.2025.10.23.05.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 05:32:30 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: [PATCH v9 1/3] dts: allow mbuf fast free to be set with testpmd shell
Date: Thu, 23 Oct 2025 08:32:21 -0400
Message-ID: <20251023123223.56924-2-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251023123223.56924-1-abailey@iol.unh.edu>
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20251023123223.56924-1-abailey@iol.unh.edu>
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

Currently, there is no way in the testpmd shell class to set the mbuf
fast free offload configuration for queues or ports. This prohibits any
test suites to be written utilizing this offload configuration.
Introduce methods that support calls to testpmd in order to allow
the configuration of mbuf fast free.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/api/testpmd/__init__.py          |  60 +++++++++++++
 dts/tests/TestSuite_rx_tx_offload.py | 129 +++++++++++++++++++++++++++
 2 files changed, 189 insertions(+)
 create mode 100644 dts/tests/TestSuite_rx_tx_offload.py

diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
index a060ab5639..9e9cbaf495 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -1292,3 +1292,63 @@ def get_capabilities_physical_function(
             supported_capabilities.add(NicCapability.PHYSICAL_FUNCTION)
         else:
             unsupported_capabilities.add(NicCapability.PHYSICAL_FUNCTION)
+
+    @_requires_stopped_ports
+    def set_port_mbuf_fast_free(
+        self,
+        port_id: int,
+        on: bool,
+        /,
+        verify: bool = True,
+    ) -> None:
+        """Sets the mbuf_fast_free configuration for the Tx offload of a given port.
+
+        Args:
+            port_id: The ID of the port to configure mbuf_fast_free on.
+            on: If :data:`True` mbuf_fast_free will be enabled, disable it otherwise.
+            verify: If :data:`True` the output of the command will be scanned in an attempt to
+                verify that the mbuf_fast_free was set successfully.
+
+        Raises:
+            InteractiveCommandExecutionError: If mbuf_fast_free could not be set successfully.
+        """
+        mbuf_output = self.send_command(
+            f"port config {port_id} tx_offload mbuf_fast_free {"on" if on else "off"}"
+        )
+
+        if verify and "Error" in mbuf_output:
+            raise InteractiveCommandExecutionError(
+                f"Unable to set mbuf_fast_free config on port {port_id}:\n{mbuf_output}"
+            )
+
+    @_requires_stopped_ports
+    def set_queue_mbuf_fast_free(
+        self,
+        port_id: int,
+        on: bool,
+        /,
+        queue_id: int = 0,
+        verify: bool = True,
+    ) -> None:
+        """Sets the Tx mbuf_fast_free configuration of the specified queue on a given port.
+
+        Args:
+            port_id: The ID of the port containing the queues.
+            on: If :data:`True` the mbuf_fast_free configuration will be enabled, otherwise
+                disabled.
+            queue_id: The ID of the queue to configure mbuf_fast_free on.
+            verify: If :data:`True` the output of the command will be scanned in an attempt to
+                verify that mbuf_fast_free was set successfully on all ports.
+
+        Raises:
+            InteractiveCommandExecutionError: If all queues could not be set successfully.
+        """
+        toggle = "on" if on else "off"
+        output = self.send_command(
+            f"port {port_id} txq {queue_id} tx_offload mbuf_fast_free {toggle}"
+        )
+        if verify and "Error" in output:
+            self._logger.debug(f"Set queue offload config error\n{output}")
+            raise InteractiveCommandExecutionError(
+                f"Failed to get offload config on port {port_id}, queue {queue_id}:\n{output}"
+            )
diff --git a/dts/tests/TestSuite_rx_tx_offload.py b/dts/tests/TestSuite_rx_tx_offload.py
new file mode 100644
index 0000000000..16e1b8cf93
--- /dev/null
+++ b/dts/tests/TestSuite_rx_tx_offload.py
@@ -0,0 +1,129 @@
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
+            to_verify = True
+            port_id = 0
+            testpmd.start_all_ports()
+
+            # Ensure MBUF_FAST_FREE is enabled by default and verify
+            verify(
+                self._check_config(testpmd, port_id, "MBUF_FAST_FREE", "tx", verify=to_verify),
+                "MBUF_FAST_FREE disabled on port start.",
+            )
+            # disable MBUF_FAST_FREE per port and verify
+            testpmd.set_port_mbuf_fast_free(port_id, False, to_verify)
+            verify(
+                self._check_config(testpmd, port_id, None, "tx", verify=to_verify),
+                "Failed to enable MBUF_FAST_FREE on port.",
+            )
+            # Enable MBUF_FAST_FREE per port and verify
+            testpmd.set_port_mbuf_fast_free(port_id, True, to_verify)
+            verify(
+                self._check_config(testpmd, port_id, "MBUF_FAST_FREE", "tx", verify=to_verify),
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
+            to_verify = True
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
+                self._check_config(
+                    testpmd, port_id, "MBUF_FAST_FREE", "tx", queue_on, verify=to_verify
+                ),
+                "MBUF_FAST_FREE disabled on queue start.",
+            )
+            # Disable mbuf_fast_free per queue and verify
+            self._set_all_queues_mbuf_fast_free(testpmd, port_id, False, num_queues, to_verify)
+            verify(
+                self._check_config(testpmd, port_id, "MBUF_FAST_FREE", "tx", queue_off, to_verify),
+                "Failed to disable MBUF_FAST_FREE on all queues.",
+            )
+            # Disable mbuf_fast_free per queue and verify
+            self._set_all_queues_mbuf_fast_free(testpmd, port_id, True, num_queues, to_verify)
+            verify(
+                self._check_config(testpmd, port_id, "MBUF_FAST_FREE", "tx", queue_on, to_verify),
+                "Failed to enable MBUF_FAST_FREE on all queues.",
+            )
-- 
2.50.1

