Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A83CA1005
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 14:28:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 777B24065A;
	Tue,  2 Sep 2025 16:28:08 +0200 (CEST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44]) by mails.dpdk.org (Postfix) with ESMTP id 2F6134064F
 for <dev@dpdk.org>; Tue,  2 Sep 2025 16:28:07 +0200 (CEST)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-70df91bdc53so45335986d6.3
 for <dev@dpdk.org>; Tue, 02 Sep 2025 07:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1756823286; x=1757428086; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hhjZTcXEVY73Z20FbDwCZERbkFZTOmY0sussZcSGeGg=;
 b=bC3P2NC9G59/+TwGMyUBadQJrspwoWrXhtcqDqpzfhn263RD4ZAQ025EoGP0W6mWUC
 SExUYoayPN8MJo0jeApo3rYWbqP4ju6IRDWx1FZY6pmxrkd5iUcaEyhJ67M9kVtMoVNG
 q66vEMT2hUPik7J8oN5e1gPw1OkeW28lrJ7IE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756823286; x=1757428086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hhjZTcXEVY73Z20FbDwCZERbkFZTOmY0sussZcSGeGg=;
 b=DrMG44QeV8CJ1jIXJ+OAt28KtXDOEgh6x8yWSSYi/EkPVdE7Xs9wyHg569DCOI3/1h
 oOX0HrOJDDcW6aRciSbxjC32q6N5ZxPmq2AWkfVFyLrqvwGzUFWh7Hzcb0FO63Cj+/vH
 UQ/zmgbD6aeBzlLHNJcDKgPE+nnkJhYP5dgMG3QQa2h8Ev6lkwOKjMtks11gLFywEMhc
 9zUdNeBIBUfYKXSzrPO6bkvw/YddaNmMVEsOJZFvLj66G5JPWhX7g1nuGLY9CgFsZiXf
 Kk4cm0AE2G82h/Zl24XBtNr09AygwCpDwA42IMrAO0SBsyRx+dgIXdEybu3SeVdAnaAr
 5Zsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDa6nC5jrD8bEW2b9Mo+Yz3q21eR4E2zZ3fF5z4skLdaE3o2Fd8kFjuaX3Pa1B44cKt4Q=@dpdk.org
X-Gm-Message-State: AOJu0YxJKrXhIAyd/QuMwBb+60eKq2mt7403qzPX618AOd6i1b7DrZVu
 6wMJclOwC5uFliaOy5jO6UxtrtVBrBdhL8yHKKRO3KXQiCgiI8ix75nVabx6oGNOD3I=
X-Gm-Gg: ASbGncsYS69+QxDuD4tGLWzm74LfKmKz2f3lyRayEFSRPkKKFpDtu4KMgjwC1UG/5ij
 Uy+/FoeN3oBlpmX2rgzIhWQ1GhwS1DCRkeYa87Jukfv7rcObsEXFUfhbnUdhrk9RHYpVGxGgH/7
 JzSmrENU4XsHc9feSzQiqxn53IqhFkXmQNjSjQdWXpYg4x0qLlnR29RjikF4fy/DK+Sj34q+729
 LUrbOGNlesX7OnrwWNcJZESX0gUy7iqomNi8aMKBmwBCf/sq52+v8ztCOZAMg/MEkqs2tidx0Zy
 8jbIZ1vzvFIpWoGOTAws6rU2hnL5OP/M/+HTsffaYt2sitEH/YSEGcY0OCRwoJ05D/gy+LfIcVl
 k3nHd9GIVlDeN1WEmcTduYEs0KKRGt1GxxZo=
X-Google-Smtp-Source: AGHT+IH1IqBmIkrRdnoA6bGeAqw0vyq+jexoKCUmevF7f/8GFxAXZoHJSoSSf0+RzpkR6SBH2JnZJA==
X-Received: by 2002:a05:6214:2a8b:b0:70d:c0fa:bc20 with SMTP id
 6a1803df08f44-70fac6fdcefmr126848966d6.12.1756823286359; 
 Tue, 02 Sep 2025 07:28:06 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-720b57c2893sm12346186d6.53.2025.09.02.07.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 07:28:05 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: [PATCH v1 1/3] dts: allow mbuf_fast_free to be set with testpmd shell
Date: Tue,  2 Sep 2025 10:27:23 -0400
Message-ID: <20250902142725.56736-2-abailey@iol.unh.edu>
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

Currently, there is no way in the testpmd shell class to set the mbuf
fast free offload configuration for RX or TX ports. This prohibits any
test suites to be written utilizing this offload configuration. Additionally,
the NIC capabilities for the TX offload are not gathered. This prevents future
test suites from being skipped if they do not support a TX offload capability.
Introduce methods that support calls to testpmd in order to allow the
configuration of mbuf fast free and to gather TX offload capabilities.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/framework/remote_session/testpmd_shell.py | 137 +++++++++++++++++-
 1 file changed, 136 insertions(+), 1 deletion(-)

diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index 786714d1c5..91642efec5 100644
--- a/dts/framework/remote_session/testpmd_shell.py
+++ b/dts/framework/remote_session/testpmd_shell.py
@@ -19,7 +19,7 @@
 import time
 from collections.abc import Callable, MutableSet
 from dataclasses import dataclass, field
-from enum import Flag, auto
+from enum import Enum, Flag, auto
 from os import environ
 from pathlib import PurePath
 from typing import TYPE_CHECKING, Any, ClassVar, Concatenate, Literal, ParamSpec, Tuple, TypeAlias
@@ -344,6 +344,13 @@ def make_parser(cls) -> ParserFn:
         )


+class RxTxArgFlag(Enum):
+    """Enum representing receiving or transmitting ports."""
+
+    TX = "tx"
+    RX = "rx"
+
+
 class DeviceCapabilitiesFlag(Flag):
     """Flag representing the device capabilities."""

@@ -2787,6 +2794,134 @@ def get_capabilities_physical_function(
         else:
             unsupported_capabilities.add(NicCapability.PHYSICAL_FUNCTION)

+    @requires_started_ports
+    def get_rxtx_offload_config(
+        self,
+        rxtx: RxTxArgFlag,
+        verify: bool,
+        port_id: int = 0,
+        num_queues: int = 0,
+    ) -> dict[int | str, str]:
+        """Get the RX or TX offload configuration of the queues from the given port.
+
+        Args:
+            rxtx: Whether to get the RX or TX configuration of the given queues.
+            verify: If :data:'True' the output of the command will be scanned in an attempt to
+                verify that the offload configuration was retrieved successfully on all queues.
+            num_queues: The number of queues to get the offload configuration for.
+            port_id: The port ID that contains the desired queues.
+
+        Returns:
+            A dict containing port info at key 'port' and queue info keyed by the appropriate queue
+                id.
+
+        Raises:
+            InteractiveCommandExecutionError: If all queue offload configurations could not be
+                retrieved.
+
+        """
+        returnDict: dict[int | str, str] = {}
+
+        config_output = self.send_command(f"show port {port_id} {rxtx.value}_offload configuration")
+        if verify:
+            if (
+                f"Rx Offloading Configuration of port {port_id}" not in config_output
+                and f"Tx Offloading Configuration of port {port_id}" not in config_output
+            ):
+                self._logger.debug(f"Get port offload config error\n{config_output}")
+                raise InteractiveCommandExecutionError(
+                    f"""Failed to get offload config on port {port_id}:\n{config_output}"""
+                )
+        # Actual output data starts on the thrid line
+        tempList: list[str] = config_output.splitlines()[3::]
+        returnDict["port"] = tempList[0]
+        for i in range(0, num_queues):
+            returnDict[i] = tempList[i + 1]
+        return returnDict
+
+    @requires_stopped_ports
+    def set_port_rxtx_mbuf_fast_free(
+        self, rxtx: RxTxArgFlag, on: bool, verify: bool, port_id: int = 0
+    ) -> None:
+        """Sets the mbuf_fast_free configuration for the RX or TX offload for a given port.
+
+        Args:
+            rxtx: Whether to set the mbuf_fast_free on the RX or TX port.
+            on: If :data:'True' mbuf_fast_free will be enabled, disable it otherwise.
+            verify: If :data:'True' the output of the command will be scanned in an attempt to
+                verify that the mbuf_fast_free was set successfully.
+            port_id: The port number to enable or disable mbuf_fast_free on.
+
+        Raises:
+            InteractiveCommandExecutionError: If mbuf_fast_free could not be set successfully
+        """
+        mbuf_output = self.send_command(
+            f"port config {port_id} {rxtx.value}_offload mbuf_fast_free {"on" if on else "off"}"
+        )
+
+        if "error" in mbuf_output and verify:
+            raise InteractiveCommandExecutionError(
+                f"""Unable to set mbuf_fast_free config on port {port_id}:\n{mbuf_output}"""
+            )
+
+    @requires_stopped_ports
+    def set_queue_rxtx_mbuf_fast_free(
+        self,
+        rxtx: RxTxArgFlag,
+        on: bool,
+        verify: bool,
+        port_id: int = 0,
+        queue_id: int = 0,
+    ) -> None:
+        """Sets RX or TX mbuf_fast_free configuration of the specified queue on a given port.
+
+        Args:
+            rxtx: Whether to set mbuf_fast_free for the RX or TX offload configuration on the
+                given queues.
+            on: If :data:'True' the mbuf_fast_free configuration will be enabled, otherwise
+                disabled.
+            verify: If :data:'True' the output of the command will be scanned in an attempt to
+                verify that mbuf_fast_free was set successfully on all ports.
+            queue_id: The queue to disable mbuf_fast_free on.
+            port_id: The ID of the port containing the queues.
+
+        Raises:
+            InteractiveCommandExecutionError: If all queues could not be set successfully.
+        """
+        toggle = "on" if on else "off"
+        output = self.send_command(
+            f"port {port_id} {rxtx.value}q {queue_id} {rxtx.value}_offload mbuf_fast_free {toggle}"
+        )
+        if verify:
+            if "Error" in output:
+                self._logger.debug(f"Set queue offload config error\n{output}")
+                raise InteractiveCommandExecutionError(
+                    f"Failed to get offload config on port {port_id}, queue {queue_id}:\n{output}"
+                )
+
+    def set_all_queues_rxtx_mbuf_fast_free(
+        self,
+        rxtx: RxTxArgFlag,
+        on: bool,
+        verify: bool,
+        port_id=0,
+        num_queues: int = 0,
+    ) -> None:
+        """Sets mbuf_fast_free configuration for the RX or TX offload of all queues on a given port.
+
+        Args:
+            rxtx: Whether to set mbuf_fast_free for the RX or TX offload configuration on the
+                given queues.
+            on: If :data:'True' the mbuf fast_free_configuration will be enabled, otherwise
+                disabled.
+            verify: If :data:'True' the output of the command will be scanned in an attempt to
+                verify that mbuf_fast_free was set successfully on all ports.
+            port_id: The ID of the port containing the queues.
+            num_queues: The queue to disable mbuf_fast_free on.
+        """
+        for i in range(0, num_queues):
+            self.set_queue_rxtx_mbuf_fast_free(rxtx, on, verify, port_id=port_id, queue_id=i)
+

 class NicCapability(NoAliasEnum):
     """A mapping between capability names and the associated :class:`TestPmdShell` methods.
--
2.50.1

