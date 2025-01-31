Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77652C0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 19:19:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76B014026F;
	Fri, 31 Jan 2025 20:19:38 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 2F7C7400D7
 for <dev@dpdk.org>; Fri, 31 Jan 2025 20:19:36 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9DC9FEC;
 Fri, 31 Jan 2025 11:20:00 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.75.129])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 651A93F694;
 Fri, 31 Jan 2025 11:19:34 -0800 (PST)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, Akhil Goyal <gakhil@marvell.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Paul Szczepanek <paul.szczepanek@arm.com>
Subject: [PATCH 1/3] dts: remove use of field validators
Date: Fri, 31 Jan 2025 19:19:22 +0000
Message-ID: <20250131191924.1936157-2-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250131191924.1936157-1-luca.vizzarro@arm.com>
References: <20250131191924.1936157-1-luca.vizzarro@arm.com>
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

When autodoc-pydantic is not installed in the system, autodoc has some
trouble parsing Pydantic's field_validator decorators. As a consequence
some unwanted warnings are printed when building the docs.

This commit removes any use of field validators in favour of "after"
model validators. Therefore eliminating autodoc's warnings, making it no
longer needed to warn the user about the possible warnings.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
---
 doc/guides/conf.py                             |  9 ++-------
 dts/framework/config/__init__.py               | 18 ++++++++----------
 dts/framework/remote_session/__init__.py       |  2 +-
 .../interactive_remote_session.py              |  2 +-
 dts/framework/remote_session/remote_session.py |  2 +-
 5 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/doc/guides/conf.py b/doc/guides/conf.py
index e7508ea1d5..50cbc7f612 100644
--- a/doc/guides/conf.py
+++ b/doc/guides/conf.py
@@ -61,17 +61,12 @@
 if environ.get('DTS_DOC_BUILD'):
     extensions = ['sphinx.ext.napoleon', 'sphinx.ext.autodoc']
 
-    # Pydantic models require autodoc_pydantic for the right formatting
+    # Pydantic models require autodoc_pydantic for the right formatting. Add if installed.
     try:
         import sphinxcontrib.autodoc_pydantic
         extensions.append("sphinxcontrib.autodoc_pydantic")
     except ImportError:
-        print(
-            "The DTS API doc dependencies are missing. "
-            "The generated output won't be as intended, "
-            "and autodoc may throw unexpected warnings.",
-            file=stderr,
-        )
+        pass
 
     # Napoleon enables the Google format of Python doscstrings.
     napoleon_numpy_docstring = False
diff --git a/dts/framework/config/__init__.py b/dts/framework/config/__init__.py
index adbd4e952d..08712d2384 100644
--- a/dts/framework/config/__init__.py
+++ b/dts/framework/config/__init__.py
@@ -32,14 +32,13 @@
 from typing import Annotated, Any, Literal, NamedTuple, TypeVar, cast
 
 import yaml
-from pydantic import Field, TypeAdapter, ValidationError, field_validator, model_validator
+from pydantic import Field, TypeAdapter, ValidationError, model_validator
 from typing_extensions import Self
 
 from framework.exception import ConfigurationError
 
 from .common import FrozenModel, ValidationContext
 from .node import (
-    NodeConfiguration,
     NodeConfigurationTypes,
     SutNodeConfiguration,
     TGNodeConfiguration,
@@ -105,19 +104,18 @@ def test_runs_with_nodes(self) -> list[TestRunWithNodesConfiguration]:
 
         return test_runs_with_nodes
 
-    @field_validator("nodes")
-    @classmethod
-    def validate_node_names(cls, nodes: list[NodeConfiguration]) -> list[NodeConfiguration]:
+    @model_validator(mode="after")
+    def validate_node_names(self) -> Self:
         """Validate that the node names are unique."""
         nodes_by_name: dict[str, int] = {}
-        for node_no, node in enumerate(nodes):
+        for node_no, node in enumerate(self.nodes):
             assert node.name not in nodes_by_name, (
                 f"node {node_no} cannot have the same name as node {nodes_by_name[node.name]} "
                 f"({node.name})"
             )
             nodes_by_name[node.name] = node_no
 
-        return nodes
+        return self
 
     @model_validator(mode="after")
     def validate_ports(self) -> Self:
@@ -130,9 +128,9 @@ def validate_ports(self) -> Self:
             for port_no, port in enumerate(node.ports):
                 peer_port_identifier = (port.peer_node, port.peer_pci)
                 peer_port = port_links.get(peer_port_identifier, None)
-                assert peer_port is not None, (
-                    "invalid peer port specified for " f"nodes.{node_no}.ports.{port_no}"
-                )
+                assert (
+                    peer_port is not None
+                ), f"invalid peer port specified for nodes.{node_no}.ports.{port_no}"
                 assert peer_port is False, (
                     f"the peer port specified for nodes.{node_no}.ports.{port_no} "
                     f"is already linked to nodes.{peer_port[0]}.ports.{peer_port[1]}"
diff --git a/dts/framework/remote_session/__init__.py b/dts/framework/remote_session/__init__.py
index 0668e9c884..1a5cf6abd3 100644
--- a/dts/framework/remote_session/__init__.py
+++ b/dts/framework/remote_session/__init__.py
@@ -12,7 +12,7 @@
 allowing it to send and receive data within that particular shell.
 """
 
-from framework.config import NodeConfiguration
+from framework.config.node import NodeConfiguration
 from framework.logger import DTSLogger
 
 from .interactive_remote_session import InteractiveRemoteSession
diff --git a/dts/framework/remote_session/interactive_remote_session.py b/dts/framework/remote_session/interactive_remote_session.py
index 509a284aaf..c8156b4345 100644
--- a/dts/framework/remote_session/interactive_remote_session.py
+++ b/dts/framework/remote_session/interactive_remote_session.py
@@ -15,7 +15,7 @@
     SSHException,
 )
 
-from framework.config import NodeConfiguration
+from framework.config.node import NodeConfiguration
 from framework.exception import SSHConnectionError
 from framework.logger import DTSLogger
 
diff --git a/dts/framework/remote_session/remote_session.py b/dts/framework/remote_session/remote_session.py
index ab83f5b266..89d4618c41 100644
--- a/dts/framework/remote_session/remote_session.py
+++ b/dts/framework/remote_session/remote_session.py
@@ -14,7 +14,7 @@
 from dataclasses import InitVar, dataclass, field
 from pathlib import Path, PurePath
 
-from framework.config import NodeConfiguration
+from framework.config.node import NodeConfiguration
 from framework.exception import RemoteCommandExecutionError
 from framework.logger import DTSLogger
 from framework.settings import SETTINGS
-- 
2.43.0

