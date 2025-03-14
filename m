Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C99C282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 13:19:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F2C140616;
	Fri, 14 Mar 2025 14:19:26 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id C4547402EB
 for <dev@dpdk.org>; Fri, 14 Mar 2025 14:19:23 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DC251424;
 Fri, 14 Mar 2025 06:19:33 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.40.184])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8A1763F673;
 Fri, 14 Mar 2025 06:19:22 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v2 4/7] dts: revert back to a single InteractiveShell
Date: Fri, 14 Mar 2025 15:18:54 +0200
Message-ID: <20250314131857.1298247-5-luca.vizzarro@arm.com>
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

Previously InteractiveShell was split into two classes to differentiate
a shell which execution must be controlled in a tight scope through a
context manager, from a more looser approach. With the addition of the
shell pool this is no longer needed as the management of shells is now
delegated to the test run instead of the test suites.

Revert back to a single InteractiveShell to simplify the code. Keep the
context manager implementation but also render start_application and
close public methods again.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 dts/framework/remote_session/dpdk_app.py      |   4 +-
 dts/framework/remote_session/dpdk_shell.py    |   6 +-
 .../remote_session/interactive_shell.py       | 289 ++++++++++++++++--
 dts/framework/remote_session/python_shell.py  |   4 +
 dts/framework/remote_session/shell_pool.py    |   2 +-
 .../single_active_interactive_shell.py        | 275 -----------------
 dts/framework/remote_session/testpmd_shell.py |   4 +-
 7 files changed, 275 insertions(+), 309 deletions(-)
 delete mode 100644 dts/framework/remote_session/single_active_interactive_shell.py

diff --git a/dts/framework/remote_session/dpdk_app.py b/dts/framework/remote_session/dpdk_app.py
index c9945f302d..c5aae05e02 100644
--- a/dts/framework/remote_session/dpdk_app.py
+++ b/dts/framework/remote_session/dpdk_app.py
@@ -62,7 +62,7 @@ def wait_until_ready(self, end_token: str) -> None:
         Args:
             end_token: The string at the end of a line that indicates the app is ready.
         """
-        self._start_application(end_token)
+        self.start_application(end_token)
 
     def close(self) -> None:
         """Close the application.
@@ -70,4 +70,4 @@ def close(self) -> None:
         Sends a SIGINT to close the application.
         """
         self.send_command("\x03")
-        self._close()
+        super().close()
diff --git a/dts/framework/remote_session/dpdk_shell.py b/dts/framework/remote_session/dpdk_shell.py
index f7ea2588ca..24a39482ce 100644
--- a/dts/framework/remote_session/dpdk_shell.py
+++ b/dts/framework/remote_session/dpdk_shell.py
@@ -11,8 +11,8 @@
 
 from framework.context import get_ctx
 from framework.params.eal import EalParams
-from framework.remote_session.single_active_interactive_shell import (
-    SingleActiveInteractiveShell,
+from framework.remote_session.interactive_shell import (
+    InteractiveShell,
 )
 from framework.testbed_model.cpu import LogicalCoreList
 
@@ -51,7 +51,7 @@ def compute_eal_params(
     return params
 
 
-class DPDKShell(SingleActiveInteractiveShell, ABC):
+class DPDKShell(InteractiveShell, ABC):
     """The base class for managing DPDK-based interactive shells.
 
     This class shouldn't be instantiated directly, but instead be extended.
diff --git a/dts/framework/remote_session/interactive_shell.py b/dts/framework/remote_session/interactive_shell.py
index 9ca285b604..62f9984d3b 100644
--- a/dts/framework/remote_session/interactive_shell.py
+++ b/dts/framework/remote_session/interactive_shell.py
@@ -1,44 +1,281 @@
 # SPDX-License-Identifier: BSD-3-Clause
-# Copyright(c) 2023 University of New Hampshire
+# Copyright(c) 2024 University of New Hampshire
 # Copyright(c) 2024 Arm Limited
 
-"""Interactive shell with manual stop/start functionality.
+"""Common functionality for interactive shell handling.
 
-Provides a class that doesn't require being started/stopped using a context manager and can instead
-be started and stopped manually, or have the stopping process be handled at the time of garbage
-collection.
+The base class, :class:`InteractiveShell`, is meant to be extended by subclasses that
+contain functionality specific to that shell type. These subclasses will often modify things like
+the prompt to expect or the arguments to pass into the application, but still utilize
+the same method for sending a command and collecting output. How this output is handled however
+is often application specific. If an application needs elevated privileges to start it is expected
+that the method for gaining those privileges is provided when initializing the class.
+
+This class is designed for applications like primary applications in DPDK where only one instance
+of the application can be running at a given time and, for this reason, is managed using a context
+manager. This context manager starts the application when you enter the context and cleans up the
+application when you exit. Using a context manager for this is useful since it allows us to ensure
+the application is cleaned up as soon as you leave the block regardless of the reason.
+
+The :option:`--timeout` command line argument and the :envvar:`DTS_TIMEOUT`
+environment variable configure the timeout of getting the output from command execution.
 """
 
-import weakref
+from abc import ABC
+from pathlib import PurePath
 from typing import ClassVar
 
-from .single_active_interactive_shell import SingleActiveInteractiveShell
+from paramiko import Channel, channel
+from typing_extensions import Self
+
+from framework.exception import (
+    InteractiveCommandExecutionError,
+    InteractiveSSHSessionDeadError,
+    InteractiveSSHTimeoutError,
+)
+from framework.logger import DTSLogger, get_dts_logger
+from framework.params import Params
+from framework.settings import SETTINGS
+from framework.testbed_model.node import Node
+from framework.utils import MultiInheritanceBaseClass
+
+
+class InteractiveShell(MultiInheritanceBaseClass, ABC):
+    """The base class for managing interactive shells.
 
+    This class shouldn't be instantiated directly, but instead be extended. It contains
+    methods for starting interactive shells as well as sending commands to these shells
+    and collecting input until reaching a certain prompt. All interactive applications
+    will use the same SSH connection, but each will create their own channel on that
+    session.
 
-class InteractiveShell(SingleActiveInteractiveShell):
-    """Adds manual start and stop functionality to interactive shells.
+    Interactive shells are started and stopped using a context manager. This allows for the start
+    and cleanup of the application to happen at predictable times regardless of exceptions or
+    interrupts.
 
-    Like its super-class, this class should not be instantiated directly and should instead be
-    extended. This class also provides an option for automated cleanup of the application using a
-    weakref and a finalize class. This finalize class allows for cleanup of the class at the time
-    of garbage collection and also ensures that cleanup only happens once. This way if a user
-    initiates the closing of the shell manually it is not repeated at the time of garbage
-    collection.
+    Attributes:
+        is_alive: :data:`True` if the application has started successfully, :data:`False`
+            otherwise.
     """
 
-    _finalizer: weakref.finalize
-    #: One attempt should be enough for shells which don't have to worry about other instances
-    #: closing before starting a new one.
-    _init_attempts: ClassVar[int] = 1
+    _node: Node
+    _stdin: channel.ChannelStdinFile
+    _stdout: channel.ChannelFile
+    _ssh_channel: Channel
+    _logger: DTSLogger
+    _timeout: float
+    _app_params: Params
+    _privileged: bool
+    _real_path: PurePath
+
+    #: The number of times to try starting the application before considering it a failure.
+    _init_attempts: ClassVar[int] = 5
+
+    #: Prompt to expect at the end of output when sending a command.
+    #: This is often overridden by subclasses.
+    _default_prompt: ClassVar[str] = ""
+
+    #: Extra characters to add to the end of every command
+    #: before sending them. This is often overridden by subclasses and is
+    #: most commonly an additional newline character. This additional newline
+    #: character is used to force the line that is currently awaiting input
+    #: into the stdout buffer so that it can be consumed and checked against
+    #: the expected prompt.
+    _command_extra_chars: ClassVar[str] = ""
+
+    #: Path to the executable to start the interactive application.
+    path: ClassVar[PurePath]
+
+    is_alive: bool = False
+
+    def __init__(
+        self,
+        node: Node,
+        name: str | None = None,
+        privileged: bool = False,
+        path: PurePath | None = None,
+        app_params: Params = Params(),
+        **kwargs,
+    ) -> None:
+        """Create an SSH channel during initialization.
+
+        Additional keyword arguments can be passed through `kwargs` if needed for fulfilling other
+        constructors in the case of multiple inheritance.
+
+        Args:
+            node: The node on which to run start the interactive shell.
+            name: Name for the interactive shell to use for logging. This name will be appended to
+                the name of the underlying node which it is running on.
+            privileged: Enables the shell to run as superuser.
+            path: Path to the executable. If :data:`None`, then the class' path attribute is used.
+            app_params: The command line parameters to be passed to the application on startup.
+            **kwargs: Any additional arguments if any.
+        """
+        self._node = node
+        if name is None:
+            name = type(self).__name__
+        self._logger = get_dts_logger(f"{node.name}.{name}")
+        self._app_params = app_params
+        self._privileged = privileged
+        self._timeout = SETTINGS.timeout
+        # Ensure path is properly formatted for the host
+        self._update_real_path(path or self.path)
+        super().__init__(**kwargs)
+
+    def _setup_ssh_channel(self):
+        self._ssh_channel = self._node.main_session.interactive_session.session.invoke_shell()
+        self._stdin = self._ssh_channel.makefile_stdin("w")
+        self._stdout = self._ssh_channel.makefile("r")
+        self._ssh_channel.settimeout(self._timeout)
+        self._ssh_channel.set_combine_stderr(True)  # combines stdout and stderr streams
+
+    def _make_start_command(self) -> str:
+        """Makes the command that starts the interactive shell."""
+        start_command = f"{self._real_path} {self._app_params or ''}"
+        if self._privileged:
+            start_command = self._node.main_session._get_privileged_command(start_command)
+        return start_command
+
+    def start_application(self, prompt: str | None = None) -> None:
+        """Starts a new interactive application based on the path to the app.
+
+        This method is often overridden by subclasses as their process for starting may look
+        different. Initialization of the shell on the host can be retried up to
+        `self._init_attempts` - 1 times. This is done because some DPDK applications need slightly
+        more time after exiting their script to clean up EAL before others can start.
 
-    def start_application(self) -> None:
-        """Start the application.
+        Args:
+            prompt: When starting up the application, expect this string at the end of stdout when
+                the application is ready. If :data:`None`, the class' default prompt will be used.
 
-        After the application has started, use :class:`weakref.finalize` to manage cleanup.
+        Raises:
+            InteractiveCommandExecutionError: If the application fails to start within the allotted
+                number of retries.
         """
-        self._start_application()
-        self._finalizer = weakref.finalize(self, self._close)
+        self._setup_ssh_channel()
+        self._ssh_channel.settimeout(5)
+        start_command = self._make_start_command()
+        self.is_alive = True
+        for attempt in range(self._init_attempts):
+            try:
+                self.send_command(start_command, prompt)
+                break
+            except InteractiveSSHTimeoutError:
+                self._logger.info(
+                    f"Interactive shell failed to start (attempt {attempt+1} out of "
+                    f"{self._init_attempts})"
+                )
+        else:
+            self._ssh_channel.settimeout(self._timeout)
+            self.is_alive = False  # update state on failure to start
+            raise InteractiveCommandExecutionError("Failed to start application.")
+        self._ssh_channel.settimeout(self._timeout)
+
+    def send_command(
+        self, command: str, prompt: str | None = None, skip_first_line: bool = False
+    ) -> str:
+        """Send `command` and get all output before the expected ending string.
+
+        Lines that expect input are not included in the stdout buffer, so they cannot
+        be used for expect.
+
+        Example:
+            If you were prompted to log into something with a username and password,
+            you cannot expect ``username:`` because it won't yet be in the stdout buffer.
+            A workaround for this could be consuming an extra newline character to force
+            the current `prompt` into the stdout buffer.
+
+        Args:
+            command: The command to send.
+            prompt: After sending the command, `send_command` will be expecting this string.
+                If :data:`None`, will use the class's default prompt.
+            skip_first_line: Skip the first line when capturing the output.
+
+        Returns:
+            All output in the buffer before expected string.
+
+        Raises:
+            InteractiveCommandExecutionError: If attempting to send a command to a shell that is
+                not currently running.
+            InteractiveSSHSessionDeadError: The session died while executing the command.
+            InteractiveSSHTimeoutError: If command was sent but prompt could not be found in
+                the output before the timeout.
+        """
+        if not self.is_alive:
+            raise InteractiveCommandExecutionError(
+                f"Cannot send command {command} to application because the shell is not running."
+            )
+        self._logger.info(f"Sending: '{command}'")
+        if prompt is None:
+            prompt = self._default_prompt
+        out: str = ""
+        try:
+            self._stdin.write(f"{command}{self._command_extra_chars}\n")
+            self._stdin.flush()
+            for line in self._stdout:
+                if skip_first_line:
+                    skip_first_line = False
+                    continue
+                if line.rstrip().endswith(prompt):
+                    break
+                out += line
+        except TimeoutError as e:
+            self._logger.exception(e)
+            self._logger.debug(
+                f"Prompt ({prompt}) was not found in output from command before timeout."
+            )
+            raise InteractiveSSHTimeoutError(command) from e
+        except OSError as e:
+            self._logger.exception(e)
+            raise InteractiveSSHSessionDeadError(
+                self._node.main_session.interactive_session.hostname
+            ) from e
+        finally:
+            self._logger.debug(f"Got output: {out}")
+        return out
 
     def close(self) -> None:
-        """Free all resources using :class:`weakref.finalize`."""
-        self._finalizer()
+        """Close the shell.
+
+        Raises:
+            InteractiveSSHTimeoutError: If the shell failed to exit within the set timeout.
+        """
+        try:
+            # Ensure the primary application has terminated via readiness of 'stdout'.
+            if self._ssh_channel.recv_ready():
+                self._ssh_channel.recv(1)  # 'Waits' for a single byte to enter 'stdout' buffer.
+        except TimeoutError as e:
+            self._logger.exception(e)
+            self._logger.debug("Application failed to exit before set timeout.")
+            raise InteractiveSSHTimeoutError("Application 'exit' command") from e
+        self._ssh_channel.close()
+
+    def _update_real_path(self, path: PurePath) -> None:
+        """Updates the interactive shell's real path used at command line."""
+        self._real_path = self._node.main_session.join_remote_path(path)
+
+    def __enter__(self) -> Self:
+        """Enter the context block.
+
+        Upon entering a context block with this class, the desired behavior is to create the
+        channel for the application to use, and then start the application.
+
+        Returns:
+            Reference to the object for the application after it has been started.
+        """
+        self.start_application()
+        return self
+
+    def __exit__(self, *_) -> None:
+        """Exit the context block.
+
+        Upon exiting a context block with this class, we want to ensure that the instance of the
+        application is explicitly closed and properly cleaned up using its close method. Note that
+        because this method returns :data:`None` if an exception was raised within the block, it is
+        not handled and will be re-raised after the application is closed.
+
+        The desired behavior is to close the application regardless of the reason for exiting the
+        context and then recreate that reason afterwards. All method arguments are ignored for
+        this reason.
+        """
+        self.close()
diff --git a/dts/framework/remote_session/python_shell.py b/dts/framework/remote_session/python_shell.py
index 9d4abab12c..17e6c2559d 100644
--- a/dts/framework/remote_session/python_shell.py
+++ b/dts/framework/remote_session/python_shell.py
@@ -29,3 +29,7 @@ class PythonShell(InteractiveShell):
 
     #: The Python executable.
     path: ClassVar[PurePath] = PurePath("python3")
+
+    def close(self):
+        """Close Python shell."""
+        return super().close()
diff --git a/dts/framework/remote_session/shell_pool.py b/dts/framework/remote_session/shell_pool.py
index 173aa8fd36..da956950d5 100644
--- a/dts/framework/remote_session/shell_pool.py
+++ b/dts/framework/remote_session/shell_pool.py
@@ -90,7 +90,7 @@ def terminate_current_pool(self):
         for shell in self._pools.pop():
             self._logger.debug(f"Closing shell {shell} in shell pool level {current_pool_level}.")
             try:
-                shell._close()
+                shell.close()
             except Exception as e:
                 self._logger.error(f"An exception has occurred while closing shell {shell}:")
                 self._logger.exception(e)
diff --git a/dts/framework/remote_session/single_active_interactive_shell.py b/dts/framework/remote_session/single_active_interactive_shell.py
deleted file mode 100644
index 2257b6156b..0000000000
--- a/dts/framework/remote_session/single_active_interactive_shell.py
+++ /dev/null
@@ -1,275 +0,0 @@
-# SPDX-License-Identifier: BSD-3-Clause
-# Copyright(c) 2024 University of New Hampshire
-
-"""Common functionality for interactive shell handling.
-
-The base class, :class:`SingleActiveInteractiveShell`, is meant to be extended by subclasses that
-contain functionality specific to that shell type. These subclasses will often modify things like
-the prompt to expect or the arguments to pass into the application, but still utilize
-the same method for sending a command and collecting output. How this output is handled however
-is often application specific. If an application needs elevated privileges to start it is expected
-that the method for gaining those privileges is provided when initializing the class.
-
-This class is designed for applications like primary applications in DPDK where only one instance
-of the application can be running at a given time and, for this reason, is managed using a context
-manager. This context manager starts the application when you enter the context and cleans up the
-application when you exit. Using a context manager for this is useful since it allows us to ensure
-the application is cleaned up as soon as you leave the block regardless of the reason.
-
-The :option:`--timeout` command line argument and the :envvar:`DTS_TIMEOUT`
-environment variable configure the timeout of getting the output from command execution.
-"""
-
-from abc import ABC
-from pathlib import PurePath
-from typing import ClassVar
-
-from paramiko import Channel, channel
-from typing_extensions import Self
-
-from framework.exception import (
-    InteractiveCommandExecutionError,
-    InteractiveSSHSessionDeadError,
-    InteractiveSSHTimeoutError,
-)
-from framework.logger import DTSLogger, get_dts_logger
-from framework.params import Params
-from framework.settings import SETTINGS
-from framework.testbed_model.node import Node
-from framework.utils import MultiInheritanceBaseClass
-
-
-class SingleActiveInteractiveShell(MultiInheritanceBaseClass, ABC):
-    """The base class for managing interactive shells.
-
-    This class shouldn't be instantiated directly, but instead be extended. It contains
-    methods for starting interactive shells as well as sending commands to these shells
-    and collecting input until reaching a certain prompt. All interactive applications
-    will use the same SSH connection, but each will create their own channel on that
-    session.
-
-    Interactive shells are started and stopped using a context manager. This allows for the start
-    and cleanup of the application to happen at predictable times regardless of exceptions or
-    interrupts.
-
-    Attributes:
-        is_alive: :data:`True` if the application has started successfully, :data:`False`
-            otherwise.
-    """
-
-    _node: Node
-    _stdin: channel.ChannelStdinFile
-    _stdout: channel.ChannelFile
-    _ssh_channel: Channel
-    _logger: DTSLogger
-    _timeout: float
-    _app_params: Params
-    _privileged: bool
-    _real_path: PurePath
-
-    #: The number of times to try starting the application before considering it a failure.
-    _init_attempts: ClassVar[int] = 5
-
-    #: Prompt to expect at the end of output when sending a command.
-    #: This is often overridden by subclasses.
-    _default_prompt: ClassVar[str] = ""
-
-    #: Extra characters to add to the end of every command
-    #: before sending them. This is often overridden by subclasses and is
-    #: most commonly an additional newline character. This additional newline
-    #: character is used to force the line that is currently awaiting input
-    #: into the stdout buffer so that it can be consumed and checked against
-    #: the expected prompt.
-    _command_extra_chars: ClassVar[str] = ""
-
-    #: Path to the executable to start the interactive application.
-    path: ClassVar[PurePath]
-
-    is_alive: bool = False
-
-    def __init__(
-        self,
-        node: Node,
-        name: str | None = None,
-        privileged: bool = False,
-        path: PurePath | None = None,
-        app_params: Params = Params(),
-        **kwargs,
-    ) -> None:
-        """Create an SSH channel during initialization.
-
-        Additional keyword arguments can be passed through `kwargs` if needed for fulfilling other
-        constructors in the case of multiple inheritance.
-
-        Args:
-            node: The node on which to run start the interactive shell.
-            name: Name for the interactive shell to use for logging. This name will be appended to
-                the name of the underlying node which it is running on.
-            privileged: Enables the shell to run as superuser.
-            path: Path to the executable. If :data:`None`, then the class' path attribute is used.
-            app_params: The command line parameters to be passed to the application on startup.
-            **kwargs: Any additional arguments if any.
-        """
-        self._node = node
-        if name is None:
-            name = type(self).__name__
-        self._logger = get_dts_logger(f"{node.name}.{name}")
-        self._app_params = app_params
-        self._privileged = privileged
-        self._timeout = SETTINGS.timeout
-        # Ensure path is properly formatted for the host
-        self._update_real_path(path or self.path)
-        super().__init__(**kwargs)
-
-    def _setup_ssh_channel(self):
-        self._ssh_channel = self._node.main_session.interactive_session.session.invoke_shell()
-        self._stdin = self._ssh_channel.makefile_stdin("w")
-        self._stdout = self._ssh_channel.makefile("r")
-        self._ssh_channel.settimeout(self._timeout)
-        self._ssh_channel.set_combine_stderr(True)  # combines stdout and stderr streams
-
-    def _make_start_command(self) -> str:
-        """Makes the command that starts the interactive shell."""
-        start_command = f"{self._real_path} {self._app_params or ''}"
-        if self._privileged:
-            start_command = self._node.main_session._get_privileged_command(start_command)
-        return start_command
-
-    def _start_application(self, prompt: str | None = None) -> None:
-        """Starts a new interactive application based on the path to the app.
-
-        This method is often overridden by subclasses as their process for starting may look
-        different. Initialization of the shell on the host can be retried up to
-        `self._init_attempts` - 1 times. This is done because some DPDK applications need slightly
-        more time after exiting their script to clean up EAL before others can start.
-
-        Args:
-            prompt: When starting up the application, expect this string at the end of stdout when
-                the application is ready. If :data:`None`, the class' default prompt will be used.
-
-        Raises:
-            InteractiveCommandExecutionError: If the application fails to start within the allotted
-                number of retries.
-        """
-        self._setup_ssh_channel()
-        self._ssh_channel.settimeout(5)
-        start_command = self._make_start_command()
-        self.is_alive = True
-        for attempt in range(self._init_attempts):
-            try:
-                self.send_command(start_command, prompt)
-                break
-            except InteractiveSSHTimeoutError:
-                self._logger.info(
-                    f"Interactive shell failed to start (attempt {attempt+1} out of "
-                    f"{self._init_attempts})"
-                )
-        else:
-            self._ssh_channel.settimeout(self._timeout)
-            self.is_alive = False  # update state on failure to start
-            raise InteractiveCommandExecutionError("Failed to start application.")
-        self._ssh_channel.settimeout(self._timeout)
-
-    def send_command(
-        self, command: str, prompt: str | None = None, skip_first_line: bool = False
-    ) -> str:
-        """Send `command` and get all output before the expected ending string.
-
-        Lines that expect input are not included in the stdout buffer, so they cannot
-        be used for expect.
-
-        Example:
-            If you were prompted to log into something with a username and password,
-            you cannot expect ``username:`` because it won't yet be in the stdout buffer.
-            A workaround for this could be consuming an extra newline character to force
-            the current `prompt` into the stdout buffer.
-
-        Args:
-            command: The command to send.
-            prompt: After sending the command, `send_command` will be expecting this string.
-                If :data:`None`, will use the class's default prompt.
-            skip_first_line: Skip the first line when capturing the output.
-
-        Returns:
-            All output in the buffer before expected string.
-
-        Raises:
-            InteractiveCommandExecutionError: If attempting to send a command to a shell that is
-                not currently running.
-            InteractiveSSHSessionDeadError: The session died while executing the command.
-            InteractiveSSHTimeoutError: If command was sent but prompt could not be found in
-                the output before the timeout.
-        """
-        if not self.is_alive:
-            raise InteractiveCommandExecutionError(
-                f"Cannot send command {command} to application because the shell is not running."
-            )
-        self._logger.info(f"Sending: '{command}'")
-        if prompt is None:
-            prompt = self._default_prompt
-        out: str = ""
-        try:
-            self._stdin.write(f"{command}{self._command_extra_chars}\n")
-            self._stdin.flush()
-            for line in self._stdout:
-                if skip_first_line:
-                    skip_first_line = False
-                    continue
-                if line.rstrip().endswith(prompt):
-                    break
-                out += line
-        except TimeoutError as e:
-            self._logger.exception(e)
-            self._logger.debug(
-                f"Prompt ({prompt}) was not found in output from command before timeout."
-            )
-            raise InteractiveSSHTimeoutError(command) from e
-        except OSError as e:
-            self._logger.exception(e)
-            raise InteractiveSSHSessionDeadError(
-                self._node.main_session.interactive_session.hostname
-            ) from e
-        finally:
-            self._logger.debug(f"Got output: {out}")
-        return out
-
-    def _close(self) -> None:
-        try:
-            # Ensure the primary application has terminated via readiness of 'stdout'.
-            if self._ssh_channel.recv_ready():
-                self._ssh_channel.recv(1)  # 'Waits' for a single byte to enter 'stdout' buffer.
-        except TimeoutError as e:
-            self._logger.exception(e)
-            self._logger.debug("Application failed to exit before set timeout.")
-            raise InteractiveSSHTimeoutError("Application 'exit' command") from e
-        self._ssh_channel.close()
-
-    def _update_real_path(self, path: PurePath) -> None:
-        """Updates the interactive shell's real path used at command line."""
-        self._real_path = self._node.main_session.join_remote_path(path)
-
-    def __enter__(self) -> Self:
-        """Enter the context block.
-
-        Upon entering a context block with this class, the desired behavior is to create the
-        channel for the application to use, and then start the application.
-
-        Returns:
-            Reference to the object for the application after it has been started.
-        """
-        self._start_application()
-        return self
-
-    def __exit__(self, *_) -> None:
-        """Exit the context block.
-
-        Upon exiting a context block with this class, we want to ensure that the instance of the
-        application is explicitly closed and properly cleaned up using its close method. Note that
-        because this method returns :data:`None` if an exception was raised within the block, it is
-        not handled and will be re-raised after the application is closed.
-
-        The desired behavior is to close the application regardless of the reason for exiting the
-        context and then recreate that reason afterwards. All method arguments are ignored for
-        this reason.
-        """
-        self._close()
diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index db1bfaa9d1..b83b0c82a0 100644
--- a/dts/framework/remote_session/testpmd_shell.py
+++ b/dts/framework/remote_session/testpmd_shell.py
@@ -2312,11 +2312,11 @@ def rx_vxlan(self, vxlan_id: int, port_id: int, enable: bool, verify: bool = Tru
                 self._logger.debug(f"Failed to set VXLAN:\n{vxlan_output}")
                 raise InteractiveCommandExecutionError(f"Failed to set VXLAN:\n{vxlan_output}")
 
-    def _close(self) -> None:
+    def close(self) -> None:
         """Overrides :meth:`~.interactive_shell.close`."""
         self.stop()
         self.send_command("quit", "Bye...")
-        return super()._close()
+        return super().close()
 
     """
     ====== Capability retrieval methods ======
-- 
2.43.0

