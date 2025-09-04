Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2EDCA1015
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 11:47:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBF69410E8;
	Thu,  4 Sep 2025 13:47:15 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 80C05410DD
 for <dev@dpdk.org>; Thu,  4 Sep 2025 13:47:14 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78E2E1756;
 Thu,  4 Sep 2025 04:47:05 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.57.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 37DAD3F6A8;
 Thu,  4 Sep 2025 04:47:13 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v2 1/7] dts: merge RemoteSession class
Date: Thu,  4 Sep 2025 12:45:01 +0100
Message-ID: <20250904114653.199080-2-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904114653.199080-1-luca.vizzarro@arm.com>
References: <20250725151503.87374-1-luca.vizzarro@arm.com>
 <20250904114653.199080-1-luca.vizzarro@arm.com>
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

Merge the RemoteSession class with SSHSession as there is no current use
of a separate channel other than SSH.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 doc/api/dts/framework.remote_session.rst      |   1 -
 .../framework.remote_session.ssh_session.rst  |   8 --
 dts/framework/remote_session/__init__.py      |   3 +-
 .../remote_session/remote_session.py          | 110 ++++++++++++-----
 dts/framework/remote_session/ssh_session.py   | 116 ------------------
 5 files changed, 79 insertions(+), 159 deletions(-)
 delete mode 100644 doc/api/dts/framework.remote_session.ssh_session.rst
 delete mode 100644 dts/framework/remote_session/ssh_session.py

diff --git a/doc/api/dts/framework.remote_session.rst b/doc/api/dts/framework.remote_session.rst
index 27c9153e64..e4ebd21ab9 100644
--- a/doc/api/dts/framework.remote_session.rst
+++ b/doc/api/dts/framework.remote_session.rst
@@ -12,7 +12,6 @@ remote\_session - Node Connections Package
    :maxdepth: 1
 
    framework.remote_session.remote_session
-   framework.remote_session.ssh_session
    framework.remote_session.interactive_remote_session
    framework.remote_session.interactive_shell
    framework.remote_session.shell_pool
diff --git a/doc/api/dts/framework.remote_session.ssh_session.rst b/doc/api/dts/framework.remote_session.ssh_session.rst
deleted file mode 100644
index 4bb51d7db2..0000000000
--- a/doc/api/dts/framework.remote_session.ssh_session.rst
+++ /dev/null
@@ -1,8 +0,0 @@
-.. SPDX-License-Identifier: BSD-3-Clause
-
-ssh\_session - SSH Remote Session
-=================================
-
-.. automodule:: framework.remote_session.ssh_session
-   :members:
-   :show-inheritance:
diff --git a/dts/framework/remote_session/__init__.py b/dts/framework/remote_session/__init__.py
index 1a5cf6abd3..2c0922acd2 100644
--- a/dts/framework/remote_session/__init__.py
+++ b/dts/framework/remote_session/__init__.py
@@ -17,7 +17,6 @@
 
 from .interactive_remote_session import InteractiveRemoteSession
 from .remote_session import RemoteSession
-from .ssh_session import SSHSession
 
 
 def create_remote_session(
@@ -36,7 +35,7 @@ def create_remote_session(
     Returns:
         The SSH remote session.
     """
-    return SSHSession(node_config, name, logger)
+    return RemoteSession(node_config, name, logger)
 
 
 def create_interactive_session(
diff --git a/dts/framework/remote_session/remote_session.py b/dts/framework/remote_session/remote_session.py
index 89d4618c41..cdb2dc1ed5 100644
--- a/dts/framework/remote_session/remote_session.py
+++ b/dts/framework/remote_session/remote_session.py
@@ -4,18 +4,33 @@
 # Copyright(c) 2022-2023 University of New Hampshire
 # Copyright(c) 2024 Arm Limited
 
-"""Base remote session.
+"""SSH remote session."""
 
-This module contains the abstract base class for remote sessions and defines
-the structure of the result of a command execution.
-"""
-
-from abc import ABC, abstractmethod
+import socket
+import traceback
 from dataclasses import InitVar, dataclass, field
 from pathlib import Path, PurePath
 
+from fabric import Connection  # type: ignore[import-untyped]
+from invoke.exceptions import (
+    CommandTimedOut,
+    ThreadException,
+    UnexpectedExit,
+)
+from paramiko.ssh_exception import (
+    AuthenticationException,
+    BadHostKeyException,
+    NoValidConnectionsError,
+    SSHException,
+)
+
 from framework.config.node import NodeConfiguration
-from framework.exception import RemoteCommandExecutionError
+from framework.exception import (
+    RemoteCommandExecutionError,
+    SSHConnectionError,
+    SSHSessionDeadError,
+    SSHTimeoutError,
+)
 from framework.logger import DTSLogger
 from framework.settings import SETTINGS
 
@@ -63,14 +78,11 @@ def __str__(self) -> str:
         )
 
 
-class RemoteSession(ABC):
+class RemoteSession:
     """Non-interactive remote session.
 
-    The abstract methods must be implemented in order to connect to a remote host (node)
-    and maintain a remote session.
-    The subclasses must use (or implement) some underlying transport protocol (e.g. SSH)
-    to implement the methods. On top of that, it provides some basic services common to all
-    subclasses, such as keeping history and logging what's being executed on the remote node.
+    The connection is implemented with
+    `the Fabric Python library <https://docs.fabfile.org/en/latest/>`_.
 
     Attributes:
         name: The name of the session.
@@ -82,6 +94,7 @@ class RemoteSession(ABC):
         password: The password used in the connection. Most frequently empty,
             as the use of passwords is discouraged.
         history: The executed commands during this session.
+        session: The underlying Fabric SSH session.
     """
 
     name: str
@@ -91,6 +104,7 @@ class RemoteSession(ABC):
     username: str
     password: str
     history: list[CommandResult]
+    session: Connection
     _logger: DTSLogger
     _node_config: NodeConfiguration
 
@@ -128,7 +142,6 @@ def __init__(
         self._connect()
         self._logger.info(f"Connection to {self.username}@{self.hostname} successful.")
 
-    @abstractmethod
     def _connect(self) -> None:
         """Create a connection to the node.
 
@@ -137,7 +150,42 @@ def _connect(self) -> None:
         The implementation must except all exceptions and convert them to an SSHConnectionError.
 
         The implementation may optionally implement retry attempts.
+
+        Raises:
+            SSHConnectionError: If the connection to the node was not successful.
         """
+        errors = []
+        retry_attempts = 10
+        login_timeout = 20 if self.port else 10
+        for retry_attempt in range(retry_attempts):
+            try:
+                self.session = Connection(
+                    self.ip,
+                    user=self.username,
+                    port=self.port,
+                    connect_kwargs={"password": self.password},
+                    connect_timeout=login_timeout,
+                )
+                self.session.open()
+
+            except (ValueError, BadHostKeyException, AuthenticationException) as e:
+                self._logger.exception(e)
+                raise SSHConnectionError(self.hostname) from e
+
+            except (NoValidConnectionsError, socket.error, SSHException) as e:
+                self._logger.debug(traceback.format_exc())
+                self._logger.warning(e)
+
+                error = repr(e)
+                if error not in errors:
+                    errors.append(error)
+
+                self._logger.info(f"Retrying connection: retry number {retry_attempt + 1}.")
+
+            else:
+                break
+        else:
+            raise SSHConnectionError(self.hostname, errors)
 
     def send_command(
         self,
@@ -166,7 +214,18 @@ def send_command(
             The output of the command along with the return code.
         """
         self._logger.info(f"Sending: '{command}'" + (f" with env vars: '{env}'" if env else ""))
-        result = self._send_command(command, timeout, env)
+
+        try:
+            output = self.session.run(command, env=env, warn=True, hide=True, timeout=timeout)
+        except (UnexpectedExit, ThreadException) as e:
+            self._logger.exception(e)
+            raise SSHSessionDeadError(self.hostname) from e
+        except CommandTimedOut as e:
+            self._logger.exception(e)
+            raise SSHTimeoutError(command) from e
+
+        result = CommandResult(self.name, command, output.stdout, output.stderr, output.return_code)
+
         if verify and result.return_code:
             self._logger.debug(
                 f"Command '{command}' failed with return code '{result.return_code}'"
@@ -178,24 +237,10 @@ def send_command(
         self.history.append(result)
         return result
 
-    @abstractmethod
-    def _send_command(self, command: str, timeout: float, env: dict | None) -> CommandResult:
-        """Send a command to the connected node.
-
-        The implementation must execute the command remotely with `env` environment variables
-        and return the result.
-
-        The implementation must except all exceptions and raise:
-
-            * SSHSessionDeadError if the session is not alive,
-            * SSHTimeoutError if the command execution times out.
-        """
-
-    @abstractmethod
     def is_alive(self) -> bool:
         """Check whether the remote session is still responding."""
+        return self.session.is_connected
 
-    @abstractmethod
     def copy_from(self, source_file: str | PurePath, destination_dir: str | Path) -> None:
         """Copy a file from the remote Node to the local filesystem.
 
@@ -207,8 +252,8 @@ def copy_from(self, source_file: str | PurePath, destination_dir: str | Path) ->
             destination_dir: The directory path on the local filesystem where the `source_file`
                 will be saved.
         """
+        self.session.get(str(source_file), str(destination_dir))
 
-    @abstractmethod
     def copy_to(self, source_file: str | Path, destination_dir: str | PurePath) -> None:
         """Copy a file from local filesystem to the remote Node.
 
@@ -220,7 +265,8 @@ def copy_to(self, source_file: str | Path, destination_dir: str | PurePath) -> N
             destination_dir: The directory path on the remote Node where the `source_file`
                 will be saved.
         """
+        self.session.put(str(source_file), str(destination_dir))
 
-    @abstractmethod
     def close(self) -> None:
         """Close the remote session and free all used resources."""
+        self.session.close()
diff --git a/dts/framework/remote_session/ssh_session.py b/dts/framework/remote_session/ssh_session.py
deleted file mode 100644
index e6e4704bc2..0000000000
--- a/dts/framework/remote_session/ssh_session.py
+++ /dev/null
@@ -1,116 +0,0 @@
-# SPDX-License-Identifier: BSD-3-Clause
-# Copyright(c) 2023 PANTHEON.tech s.r.o.
-
-"""SSH remote session."""
-
-import socket
-import traceback
-from pathlib import Path, PurePath
-
-from fabric import Connection  # type: ignore[import-untyped]
-from invoke.exceptions import (
-    CommandTimedOut,
-    ThreadException,
-    UnexpectedExit,
-)
-from paramiko.ssh_exception import (
-    AuthenticationException,
-    BadHostKeyException,
-    NoValidConnectionsError,
-    SSHException,
-)
-
-from framework.exception import SSHConnectionError, SSHSessionDeadError, SSHTimeoutError
-
-from .remote_session import CommandResult, RemoteSession
-
-
-class SSHSession(RemoteSession):
-    """A persistent SSH connection to a remote Node.
-
-    The connection is implemented with
-    `the Fabric Python library <https://docs.fabfile.org/en/latest/>`_.
-
-    Attributes:
-        session: The underlying Fabric SSH connection.
-
-    Raises:
-        SSHConnectionError: The connection cannot be established.
-    """
-
-    session: Connection
-
-    def _connect(self) -> None:
-        errors = []
-        retry_attempts = 10
-        login_timeout = 20 if self.port else 10
-        for retry_attempt in range(retry_attempts):
-            try:
-                self.session = Connection(
-                    self.ip,
-                    user=self.username,
-                    port=self.port,
-                    connect_kwargs={"password": self.password},
-                    connect_timeout=login_timeout,
-                )
-                self.session.open()
-
-            except (ValueError, BadHostKeyException, AuthenticationException) as e:
-                self._logger.exception(e)
-                raise SSHConnectionError(self.hostname) from e
-
-            except (NoValidConnectionsError, socket.error, SSHException) as e:
-                self._logger.debug(traceback.format_exc())
-                self._logger.warning(e)
-
-                error = repr(e)
-                if error not in errors:
-                    errors.append(error)
-
-                self._logger.info(f"Retrying connection: retry number {retry_attempt + 1}.")
-
-            else:
-                break
-        else:
-            raise SSHConnectionError(self.hostname, errors)
-
-    def _send_command(self, command: str, timeout: float, env: dict | None) -> CommandResult:
-        """Send a command and return the result of the execution.
-
-        Args:
-            command: The command to execute.
-            timeout: Wait at most this long in seconds for the command execution to complete.
-            env: Extra environment variables that will be used in command execution.
-
-        Raises:
-            SSHSessionDeadError: The session died while executing the command.
-            SSHTimeoutError: The command execution timed out.
-        """
-        try:
-            output = self.session.run(command, env=env, warn=True, hide=True, timeout=timeout)
-
-        except (UnexpectedExit, ThreadException) as e:
-            self._logger.exception(e)
-            raise SSHSessionDeadError(self.hostname) from e
-
-        except CommandTimedOut as e:
-            self._logger.exception(e)
-            raise SSHTimeoutError(command) from e
-
-        return CommandResult(self.name, command, output.stdout, output.stderr, output.return_code)
-
-    def is_alive(self) -> bool:
-        """Overrides :meth:`~.remote_session.RemoteSession.is_alive`."""
-        return self.session.is_connected
-
-    def copy_from(self, source_file: str | PurePath, destination_dir: str | Path) -> None:
-        """Overrides :meth:`~.remote_session.RemoteSession.copy_from`."""
-        self.session.get(str(source_file), str(destination_dir))
-
-    def copy_to(self, source_file: str | Path, destination_dir: str | PurePath) -> None:
-        """Overrides :meth:`~.remote_session.RemoteSession.copy_to`."""
-        self.session.put(str(source_file), str(destination_dir))
-
-    def close(self) -> None:
-        """Overrides :meth:`~.remote_session.RemoteSession.close`."""
-        self.session.close()
-- 
2.43.0

