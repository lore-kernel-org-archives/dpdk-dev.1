Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049ADC28B30
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 13:19:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D47DD402F2;
	Fri, 14 Mar 2025 14:19:23 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id B195A400D5
 for <dev@dpdk.org>; Fri, 14 Mar 2025 14:19:21 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CF671424;
 Fri, 14 Mar 2025 06:19:31 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.40.184])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5AD3D3F673;
 Fri, 14 Mar 2025 06:19:20 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v2 2/7] dts: add blocking dpdk app class
Date: Fri, 14 Mar 2025 15:18:52 +0200
Message-ID: <20250314131857.1298247-3-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314131857.1298247-1-luca.vizzarro@arm.com>
References: <20241220172337.2194523-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-1-luca.vizzarro@arm.com>
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

Add BlockingDPDKApp class. Some non-interactive applications are
blocking and run until the user interrupts them. As their main intended
usage is to be kept running in the background, this class exploits
InteractiveShell to spawn a dedicated shell to keep the blocking
application running, while detaching from it.

This class works by providing the `wait_until_ready` and `close`
methods. The former starts up the application and returns only when the
application readiness output ends in the string provided as an argument
to the same method. Whereas the latter works by simulating a Ctrl+C
keystroke, therefore sending a SIGINT to the app.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 dts/framework/remote_session/dpdk_app.py      | 73 +++++++++++++++++++
 dts/framework/remote_session/dpdk_shell.py    |  3 +-
 .../single_active_interactive_shell.py        | 12 ++-
 dts/framework/remote_session/testpmd_shell.py |  2 +-
 4 files changed, 85 insertions(+), 5 deletions(-)
 create mode 100644 dts/framework/remote_session/dpdk_app.py

diff --git a/dts/framework/remote_session/dpdk_app.py b/dts/framework/remote_session/dpdk_app.py
new file mode 100644
index 0000000000..c9945f302d
--- /dev/null
+++ b/dts/framework/remote_session/dpdk_app.py
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 Arm Limited
+
+"""Class to run blocking DPDK apps in the background.
+
+The class won't automatically start the app. The start-up is done as part of the
+:meth:`BlockingDPDKApp.wait_until_ready` method, which will return execution to the caller only
+when the desired stdout has been returned by the app. Usually this is used to detect when the app
+has been loaded and ready to be used.
+
+Example:
+    ..code:: python
+
+        pdump = BlockingDPDKApp(
+            PurePath("app/dpdk-pdump"),
+            app_params="--pdump 'port=0,queue=*,rx-dev=/tmp/rx-dev.pcap'"
+        )
+        pdump.wait_until_ready("65535") # start app
+
+        # pdump is now ready to capture
+
+        pdump.close() # stop/close app
+"""
+
+from pathlib import PurePath
+
+from framework.params.eal import EalParams
+from framework.remote_session.dpdk_shell import DPDKShell
+
+
+class BlockingDPDKApp(DPDKShell):
+    """Class to manage blocking DPDK apps."""
+
+    def __init__(
+        self,
+        path: PurePath,
+        name: str | None = None,
+        privileged: bool = True,
+        app_params: EalParams | str = "",
+    ) -> None:
+        """Constructor.
+
+        Overrides :meth:`~.dpdk_shell.DPDKShell.__init__`.
+
+        Args:
+            path: Path relative to the DPDK build to the executable.
+            name: Name to identify this application.
+            privileged: Run as privileged user.
+            app_params: The application parameters. If a string or an incomplete :class:`EalParams`
+                object are passed, the EAL params are computed based on the current context.
+        """
+        if isinstance(app_params, str):
+            eal_params = EalParams()
+            eal_params.append_str(app_params)
+            app_params = eal_params
+
+        super().__init__(name, privileged, path, app_params)
+
+    def wait_until_ready(self, end_token: str) -> None:
+        """Start app and wait until ready.
+
+        Args:
+            end_token: The string at the end of a line that indicates the app is ready.
+        """
+        self._start_application(end_token)
+
+    def close(self) -> None:
+        """Close the application.
+
+        Sends a SIGINT to close the application.
+        """
+        self.send_command("\x03")
+        self._close()
diff --git a/dts/framework/remote_session/dpdk_shell.py b/dts/framework/remote_session/dpdk_shell.py
index 0962414876..f7ea2588ca 100644
--- a/dts/framework/remote_session/dpdk_shell.py
+++ b/dts/framework/remote_session/dpdk_shell.py
@@ -65,13 +65,14 @@ def __init__(
         self,
         name: str | None = None,
         privileged: bool = True,
+        path: PurePath | None = None,
         app_params: EalParams = EalParams(),
     ) -> None:
         """Extends :meth:`~.interactive_shell.InteractiveShell.__init__`."""
         app_params = compute_eal_params(app_params)
         node = get_ctx().sut_node
 
-        super().__init__(node, name, privileged, app_params)
+        super().__init__(node, name, privileged, path, app_params)
 
     def _update_real_path(self, path: PurePath) -> None:
         """Extends :meth:`~.interactive_shell.InteractiveShell._update_real_path`.
diff --git a/dts/framework/remote_session/single_active_interactive_shell.py b/dts/framework/remote_session/single_active_interactive_shell.py
index c1369ef77e..2257b6156b 100644
--- a/dts/framework/remote_session/single_active_interactive_shell.py
+++ b/dts/framework/remote_session/single_active_interactive_shell.py
@@ -92,6 +92,7 @@ def __init__(
         node: Node,
         name: str | None = None,
         privileged: bool = False,
+        path: PurePath | None = None,
         app_params: Params = Params(),
         **kwargs,
     ) -> None:
@@ -105,6 +106,7 @@ def __init__(
             name: Name for the interactive shell to use for logging. This name will be appended to
                 the name of the underlying node which it is running on.
             privileged: Enables the shell to run as superuser.
+            path: Path to the executable. If :data:`None`, then the class' path attribute is used.
             app_params: The command line parameters to be passed to the application on startup.
             **kwargs: Any additional arguments if any.
         """
@@ -116,7 +118,7 @@ def __init__(
         self._privileged = privileged
         self._timeout = SETTINGS.timeout
         # Ensure path is properly formatted for the host
-        self._update_real_path(self.path)
+        self._update_real_path(path or self.path)
         super().__init__(**kwargs)
 
     def _setup_ssh_channel(self):
@@ -133,7 +135,7 @@ def _make_start_command(self) -> str:
             start_command = self._node.main_session._get_privileged_command(start_command)
         return start_command
 
-    def _start_application(self) -> None:
+    def _start_application(self, prompt: str | None = None) -> None:
         """Starts a new interactive application based on the path to the app.
 
         This method is often overridden by subclasses as their process for starting may look
@@ -141,6 +143,10 @@ def _start_application(self) -> None:
         `self._init_attempts` - 1 times. This is done because some DPDK applications need slightly
         more time after exiting their script to clean up EAL before others can start.
 
+        Args:
+            prompt: When starting up the application, expect this string at the end of stdout when
+                the application is ready. If :data:`None`, the class' default prompt will be used.
+
         Raises:
             InteractiveCommandExecutionError: If the application fails to start within the allotted
                 number of retries.
@@ -151,7 +157,7 @@ def _start_application(self) -> None:
         self.is_alive = True
         for attempt in range(self._init_attempts):
             try:
-                self.send_command(start_command)
+                self.send_command(start_command, prompt)
                 break
             except InteractiveSSHTimeoutError:
                 self._logger.info(
diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index 1f291fcb68..db1bfaa9d1 100644
--- a/dts/framework/remote_session/testpmd_shell.py
+++ b/dts/framework/remote_session/testpmd_shell.py
@@ -1540,7 +1540,7 @@ def __init__(
         """Overrides :meth:`~.dpdk_shell.DPDKShell.__init__`. Changes app_params to kwargs."""
         if "port_topology" not in app_params and get_ctx().topology.type is TopologyType.one_link:
             app_params["port_topology"] = PortTopology.loop
-        super().__init__(name, privileged, TestPmdParams(**app_params))
+        super().__init__(name, privileged, app_params=TestPmdParams(**app_params))
         self.ports_started = not self._app_params.disable_device_start
         self._ports = None
 
-- 
2.43.0

