Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20987CA0FF2
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 18:04:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E73040DCD;
	Wed,  3 Sep 2025 20:04:34 +0200 (CEST)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by mails.dpdk.org (Postfix) with ESMTP id 1431F40150
 for <dev@dpdk.org>; Wed,  3 Sep 2025 20:04:33 +0200 (CEST)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-4b30f73ca19so1826651cf.0
 for <dev@dpdk.org>; Wed, 03 Sep 2025 11:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1756922672; x=1757527472; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DyGsct/uqWoX8vcxf5wkY9BpPaMBI2vdoSOXIFcgSOk=;
 b=a9A0wA73zMLydoLq5aCiKxAOA7FBFqlQIt6iO0bP5EKHUCYzesW6FU1DYL02W/Gw51
 QAbct3VMaPldrmvEP6f3aGcskG6WvW5Ir91JtlH2YVeFX0bedj41VjeMRZunHcBDzK1f
 DnWTeXHWv4+PMncBri6prX2njrW2eHf0f0RX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756922672; x=1757527472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DyGsct/uqWoX8vcxf5wkY9BpPaMBI2vdoSOXIFcgSOk=;
 b=etnxXGd9YJyFXdNEG/BWB+BGwB1edejQjvTOey1PAV8KPkPtBDFNLvWJzqiAPGaPEJ
 kz2A4Bnaqg/n39zGU9dOuwvQ9Rgrkzqzwb73j0bFNrm0MT9iJMWi0SBCHYg0sIP0dsKr
 e5/XIkCE/Tmx77fMEKNYlY0x97g9BJ5PF5f3Wl6FupZA44KoJI02SjFOFIPO/d11qW9/
 ZFXzDtE1Ph4IytgtK7GN62D+92U+mmFMdrWHwo/YIfar4ERUlHLpSE3XWT5kXGD7vQgu
 iUc58bgNRtgj0WO/0F9XN3Oorwk4V6UXWDe9dkTOQ24WEQMtHGAqV3qxBQuA2PF+wqfS
 ZQKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWn8xcDkc6WwlT50CES2TxBADcH4otw9aXCDNrwpSGCS/TxCyKiJWW1TRyGo9pVq2rbRYo=@dpdk.org
X-Gm-Message-State: AOJu0YwYt/uZdig8e5sv7D3lG1Ieq42OI7iW2oqL1xklDgbySUT4iJld
 EC253sSi8aR0S3NzWXFBaKj16H+6euuL4ha2XmPzqS7A8dJQ6DAveQht5XgGOZtdZBE=
X-Gm-Gg: ASbGnctNc0N475dqugfuaPKk1XLK8Pz3SlJslIBMcv62RkEsK+aBMH8JuznEsSyXQOL
 moQSzhMipSbz0mwVDq3PximBfDs55ySVqdTxc34UvUVCT3zzXXhOa+PpG/+0zJNQc6wCffL2u8w
 1Tn5SWWu7F/w7Nh4xNcgWz6AWy8nbywvbNBP9yRgFNmCyM0smTPbxJjU/9BDqAdClFKYSF01tQX
 L/2wrOJVbMOeTYwBXB6+zYvc+wz/Rfq1nq/+1u2Jvl7Rt4a2koKNXaaVxSfBfPXh/ecaHPR3a0Q
 uPfyZlJfkR1rmcozCeIEX6eNVXspFu+3RjxMXMS8hdhk37oPpLDl1hSVRcNCEvUotQWxKXLdJCf
 dqgf9Pow2UOdoSwJ5j6rLcuehBQDZTfntsaZ2wFw+fkBdNi8A8hPRVcA=
X-Google-Smtp-Source: AGHT+IGOtsmtOez/p7GWuzwkuSh4V55VnFd7Q2kU4lYjJXfzLubm6WOJsbw8lYyRWl2K1/qKzmlU0w==
X-Received: by 2002:a05:622a:994:b0:4b5:781c:8831 with SMTP id
 d75a77b69052e-4b5781c8e14mr17361001cf.71.1756922671950; 
 Wed, 03 Sep 2025 11:04:31 -0700 (PDT)
Received: from dhcp-10-21-133-214.unh.edu
 ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b48f62a861sm15073121cf.8.2025.09.03.11.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 11:04:31 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu,
 ivan.malov@arknetworks.am, probb@iol.unh.edu
Subject: [PATCH v2 1/3] dts: allow mbuf_fast_free to be set with testpmd shell
Date: Wed,  3 Sep 2025 14:04:12 -0400
Message-ID: <20250903180414.83001-2-abailey@iol.unh.edu>
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

Currently, there is no way in the testpmd shell class to set the mbuf
fast free offload configuration for queues or ports. This prohibits any
test suites to be written utilizing this offload configuration.
Additionally, the NIC capabilities for the Tx offload are not gathered.
This prevents future test suites from being skipped if they do not
support a Tx offload capability. Introduce methods that support calls
to testpmd in order to allow the configuration of mbuf fast free and to
gather Tx offload capabilities.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/framework/remote_session/testpmd_shell.py | 128 +++++++++++++++++-
 1 file changed, 127 insertions(+), 1 deletion(-)

diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index ad8cb273dc..4d9caceb37 100644
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
 
@@ -2672,6 +2679,125 @@ def get_capabilities_physical_function(
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
+        """Get the Rx or Tx offload configuration of the queues from the given port.
+
+        Args:
+            rxtx: Whether to get the Rx or Tx configuration of the given queues.
+            verify: If :data:'True' the output of the command will be scanned in an attempt to
+                verify that the offload configuration was retrieved successfully on all queues.
+            port_id: The port ID that contains the desired queues.
+            num_queues: The number of queues to get the offload configuration for.
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
+        # Actual output data starts on the third line
+        tempList: list[str] = config_output.splitlines()[3::]
+        returnDict["port"] = tempList[0]
+        for i in range(0, num_queues):
+            returnDict[i] = tempList[i + 1]
+        return returnDict
+
+    @requires_stopped_ports
+    def set_port_mbuf_fast_free(self, on: bool, verify: bool, port_id: int = 0) -> None:
+        """Sets the mbuf_fast_free configuration for the Tx offload for a given port.
+
+        Args:
+            on: If :data:'True' mbuf_fast_free will be enabled, disable it otherwise.
+            verify: If :data:'True' the output of the command will be scanned in an attempt to
+                verify that the mbuf_fast_free was set successfully.
+            port_id: The port number to enable or disable mbuf_fast_free on.
+
+        Raises:
+            InteractiveCommandExecutionError: If mbuf_fast_free could not be set successfully
+        """
+        mbuf_output = self.send_command(
+            f"port config {port_id} tx_offload mbuf_fast_free {"on" if on else "off"}"
+        )
+
+        if "error" in mbuf_output and verify:
+            raise InteractiveCommandExecutionError(
+                f"""Unable to set mbuf_fast_free config on port {port_id}:\n{mbuf_output}"""
+            )
+
+    @requires_stopped_ports
+    def set_queue_mbuf_fast_free(
+        self,
+        on: bool,
+        verify: bool,
+        port_id: int = 0,
+        queue_id: int = 0,
+    ) -> None:
+        """Sets the Tx mbuf_fast_free configuration of the specified queue on a given port.
+
+        Args:
+            on: If :data:'True' the mbuf_fast_free configuration will be enabled, otherwise
+                disabled.
+            verify: If :data:'True' the output of the command will be scanned in an attempt to
+                verify that mbuf_fast_free was set successfully on all ports.
+            port_id: The ID of the port containing the queues.
+            queue_id: The queue to disable mbuf_fast_free on.
+
+        Raises:
+            InteractiveCommandExecutionError: If all queues could not be set successfully.
+        """
+        toggle = "on" if on else "off"
+        output = self.send_command(
+            f"port {port_id} txq {queue_id} tx_offload mbuf_fast_free {toggle}"
+        )
+        if verify:
+            if "Error" in output:
+                self._logger.debug(f"Set queue offload config error\n{output}")
+                raise InteractiveCommandExecutionError(
+                    f"Failed to get offload config on port {port_id}, queue {queue_id}:\n{output}"
+                )
+
+    def set_all_queues_mbuf_fast_free(
+        self,
+        on: bool,
+        verify: bool,
+        port_id=0,
+        num_queues: int = 0,
+    ) -> None:
+        """Sets mbuf_fast_free configuration for the Tx offload of all queues on a given port.
+
+        Args:
+            on: If :data:'True' the mbuf_fast_free configuration will be enabled, otherwise
+                disabled.
+            verify: If :data:'True' the output of the command will be scanned in an attempt to
+                verify that mbuf_fast_free was set successfully on all ports.
+            port_id: The ID of the port containing the queues.
+            num_queues: The amount of queues to disable mbuf_fast_free on.
+        """
+        for i in range(0, num_queues):
+            self.set_queue_mbuf_fast_free(on, verify, port_id=port_id, queue_id=i)
+
 
 class NicCapability(NoAliasEnum):
     """A mapping between capability names and the associated :class:`TestPmdShell` methods.
-- 
2.50.1

