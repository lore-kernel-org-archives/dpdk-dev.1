Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FD8C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 21:24:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E42A540608;
	Thu, 20 Feb 2025 22:24:52 +0100 (CET)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id C889D40395
 for <dev@dpdk.org>; Thu, 20 Feb 2025 22:24:50 +0100 (CET)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-7c0a3d6a6e4so130451985a.1
 for <dev@dpdk.org>; Thu, 20 Feb 2025 13:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1740086690; x=1740691490; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JyErsASKCOUl4cqa52uKAbrwtxuETRTRLdcHT6Hs46g=;
 b=abRPAHqJQ6SLEWrPkdq+phpLwh3AoMSKzkBxFFlXu07Abc1bg2VRbyTNmvA0Ybu0ix
 UrQLMEws1nVYjZUjscNnPg6TRd5OOzrNK7rDTzUIfv8I9DQX2mzIlyGbTucb8k0X0J6P
 x1knVSbFcwPlOgla3KZS8WsdUdhP3/ncgkneY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740086690; x=1740691490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JyErsASKCOUl4cqa52uKAbrwtxuETRTRLdcHT6Hs46g=;
 b=mGVfOO3/XAAD0JxhFPwBRdhArbHNL9Ez+eApiFEArMh9SI6EHROHSZdhaVAqk9cX0k
 ubKhX3e3x7syPcyK3cm+0FiqR1bOwzFoEWmbYAS52xPxOZBu1WpmlF+rZzR1rqCgefyF
 8AuNsD3YuHQrXfylbhN1LxtgVUAm8XxlJn4t1ooHOfEqPYxIKkFP+xQoDgReXfDmXsG6
 fxzCuvJ1S/4HY5BCxsT1pmhS1KM90/74akUpOGvMmmkn6ac8L46qOR5dJcgh681kP978
 JcBH3tQVdOF3vNSJn+UtfAcKOHYaVqch2VV1fAOrlluBFb/OsQwZHiVn+cICflzjeoEg
 kVUA==
X-Gm-Message-State: AOJu0Yx344NMPHmvB/IVZYuTNc8z8H9RopJKeTtLP38dty4AW2i7yO2q
 F5yi+j00gscfYpfq6+omEwZ9OcGOqrM3SM64E2pjLtwcyHAXZWsOmwei5fmkg4U=
X-Gm-Gg: ASbGncsM+Pvna1YhbVkICCVe4Mstal4T5AXH+5rloJgkemqVqZmW59ydJQRzNoik33Z
 dnsSc5ZQox1vxSaNy367QuYIxS7vUGDYtuBPOSU8zIKmqgp43eLSeFBi5xGW9YP0Mkkydq3qTI3
 kJg5Q+1X5RuTygbSlXtbqbXEKDDeMSR88eZrbZqnzsKpw8+j2b31oqK6FXHVjD2eH9wCOAG+f7m
 Q5lv+lbawdReu222Bg/D3vYoDwkkMTRNpXlwm4epwsMhHBvCjBWPXfbffaxcQkXCaT9LDHCRCI7
 o4ubLsN66S1DXOBSuuwuHsZJIRP2eK292lhZdBLhG58odPOCOnHqdkQ=
X-Google-Smtp-Source: AGHT+IHiiquzzhLrG3C8qXDU4JkHk+Fv2RvlMjPIKc7IoK2BvLvwU0ltqqO5fsGrL6u3V28k4HQZGA==
X-Received: by 2002:a05:620a:2987:b0:7c0:c046:7c62 with SMTP id
 af79cd13be357-7c0cef0f33cmr115460985a.29.1740086690092; 
 Thu, 20 Feb 2025 13:24:50 -0800 (PST)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c0b16072b7sm313030885a.98.2025.02.20.13.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 13:24:49 -0800 (PST)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, npratte@iol.unh.edu, luca.vizzarro@arm.com,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org, Dean Marx <dmarx@iol.unh.edu>,
 Jeremy Spewock <jspewock@iol.unh.edu>
Subject: [PATCH v4 1/2] dts: add clearing port stats to testpmd shell
Date: Thu, 20 Feb 2025 16:24:42 -0500
Message-ID: <20250220212443.66483-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220212443.66483-1-dmarx@iol.unh.edu>
References: <20240923154936.15952-1-jspewock@iol.unh.edu>
 <20250220212443.66483-1-dmarx@iol.unh.edu>
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

Methods currently exist for querying the statistics of a port in
testpmd, but there weren't methods added for clearing the current
statistics on a port. This patch adds methods that allow you to clear
the statistics of a single port or all ports to account for situations
where the user only wants the port statistics after a certain point and
does not care about any existing prior values.

This patch also modifies the show_port_stats_all method to allow for it
to return the raw testpmd output gathered from sending the command as
well as the parsed output. This allows users to access and examine
additional information provided by the raw output if needed.

Signed-off-by: Jeremy Spewock <jspewock@iol.unh.edu>
Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/framework/remote_session/testpmd_shell.py | 57 +++++++++++++++----
 1 file changed, 45 insertions(+), 12 deletions(-)

diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index 672ecd970f..b8e37434ab 100644
--- a/dts/framework/remote_session/testpmd_shell.py
+++ b/dts/framework/remote_session/testpmd_shell.py
@@ -22,15 +22,7 @@
 from enum import Flag, auto
 from os import environ
 from pathlib import PurePath
-from typing import (
-    TYPE_CHECKING,
-    Any,
-    ClassVar,
-    Concatenate,
-    Literal,
-    ParamSpec,
-    TypeAlias,
-)
+from typing import TYPE_CHECKING, Any, ClassVar, Concatenate, Literal, ParamSpec, Tuple, TypeAlias
 
 from framework.context import get_ctx
 from framework.testbed_model.topology import TopologyType
@@ -1836,11 +1828,13 @@ def set_multicast_mac_addr(
                     f"Failed to {mcast_cmd} {multi_addr} on port {port_id} \n{output}"
                 )
 
-    def show_port_stats_all(self) -> list[TestPmdPortStats]:
+    def show_port_stats_all(self) -> Tuple[list[TestPmdPortStats], str]:
         """Returns the statistics of all the ports.
 
         Returns:
-            list[TestPmdPortStats]: A list containing all the ports stats as `TestPmdPortStats`.
+            Tuple[str, list[TestPmdPortStats]]: A tuple where the first element is the stats of all
+            ports as `TestPmdPortStats` and second is the raw testpmd output that was collected
+            from the sent command.
         """
         output = self.send_command("show port stats all")
 
@@ -1855,7 +1849,7 @@ def show_port_stats_all(self) -> list[TestPmdPortStats]:
         #   #################################################
         #
         iter = re.finditer(r"(^  #*.+#*$[^#]+)^  #*\r$", output, re.MULTILINE)
-        return [TestPmdPortStats.parse(block.group(1)) for block in iter]
+        return ([TestPmdPortStats.parse(block.group(1)) for block in iter], output)
 
     def show_port_stats(self, port_id: int) -> TestPmdPortStats:
         """Returns the given port statistics.
@@ -2312,6 +2306,45 @@ def rx_vxlan(self, vxlan_id: int, port_id: int, enable: bool, verify: bool = Tru
                 self._logger.debug(f"Failed to set VXLAN:\n{vxlan_output}")
                 raise InteractiveCommandExecutionError(f"Failed to set VXLAN:\n{vxlan_output}")
 
+    def clear_port_stats(self, port_id: int, verify: bool = True) -> None:
+        """Clear statistics of a given port.
+
+        Args:
+            port_id: ID of the port to clear the statistics on.
+            verify: If :data:`True` the output of the command will be scanned to verify that it was
+                successful, otherwise failures will be ignored. Defaults to :data:`True`.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and testpmd fails to
+                clear the statistics of the given port.
+        """
+        clear_output = self.send_command(f"clear port stats {port_id}")
+        if verify and f"NIC statistics for port {port_id} cleared" not in clear_output:
+            raise InteractiveCommandExecutionError(
+                f"Test pmd failed to set clear forwarding stats on port {port_id}"
+            )
+
+    def clear_port_stats_all(self, verify: bool = True) -> None:
+        """Clear the statistics of all ports that testpmd is aware of.
+
+        Args:
+            verify: If :data:`True` the output of the command will be scanned to verify that all
+                ports had their statistics cleared, otherwise failures will be ignored. Defaults to
+                :data:`True`.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and testpmd fails to
+                clear the statistics of any of its ports.
+        """
+        clear_output = self.send_command("clear port stats all")
+        if verify:
+            if type(self._app_params.port_numa_config) is list:
+                for port_id in range(len(self._app_params.port_numa_config)):
+                    if f"NIC statistics for port {port_id} cleared" not in clear_output:
+                        raise InteractiveCommandExecutionError(
+                            f"Test pmd failed to set clear forwarding stats on port {port_id}"
+                        )
+
     def _close(self) -> None:
         """Overrides :meth:`~.interactive_shell.close`."""
         self.stop()
-- 
2.47.0

