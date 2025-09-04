Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAF4CA1015
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 11:47:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C7E0410F9;
	Thu,  4 Sep 2025 13:47:17 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 644F5410DD
 for <dev@dpdk.org>; Thu,  4 Sep 2025 13:47:15 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54CB42E98;
 Thu,  4 Sep 2025 04:47:06 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.57.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 19A613F6A8;
 Thu,  4 Sep 2025 04:47:13 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v2 2/7] dts: add node retriever by identifier
Date: Thu,  4 Sep 2025 12:45:02 +0100
Message-ID: <20250904114653.199080-3-luca.vizzarro@arm.com>
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

Refactor the logic to identify nodes. Add facility to retrieve current
nodes from context.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 dts/framework/testbed_model/node.py     | 38 +++++++++++++++++++++++++
 dts/framework/testbed_model/topology.py |  8 ++----
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/dts/framework/testbed_model/node.py b/dts/framework/testbed_model/node.py
index 35cf6f1452..f6ff07898d 100644
--- a/dts/framework/testbed_model/node.py
+++ b/dts/framework/testbed_model/node.py
@@ -15,6 +15,7 @@
 
 from functools import cached_property
 from pathlib import PurePath
+from typing import Literal, TypeAlias
 
 from framework.config.node import (
     OS,
@@ -203,3 +204,40 @@ def create_session(node_config: NodeConfiguration, name: str, logger: DTSLogger)
             return LinuxSession(node_config, name, logger)
         case _:
             raise ConfigurationError(f"Unsupported OS {node_config.os}")
+
+
+LocalNodeIdentifier: TypeAlias = Literal["local"]
+"""Local node identifier for testbed model."""
+
+RemoteNodeIdentifier: TypeAlias = Literal["sut", "tg"]
+"""Remote node identifiers for testbed model."""
+
+NodeIdentifier: TypeAlias = Literal["local", "sut", "tg"]
+"""Node identifiers for testbed model."""
+
+
+def get_node(node_identifier: NodeIdentifier) -> Node | None:
+    """Get the node based on the identifier.
+
+    Args:
+        node_identifier: The identifier of the node.
+
+    Returns:
+        The node object corresponding to the identifier, or :data:`None` if the identifier is
+            "local".
+
+    Raises:
+        InternalError: If the node identifier is unknown.
+    """
+    if node_identifier == "local":
+        return None
+
+    from framework.context import get_ctx
+
+    ctx = get_ctx()
+    if node_identifier == "sut":
+        return ctx.sut_node
+    elif node_identifier == "tg":
+        return ctx.tg_node
+    else:
+        raise InternalError(f"Unknown node identifier: {node_identifier}")
diff --git a/dts/framework/testbed_model/topology.py b/dts/framework/testbed_model/topology.py
index 899ea0ad3a..9fc056b330 100644
--- a/dts/framework/testbed_model/topology.py
+++ b/dts/framework/testbed_model/topology.py
@@ -12,12 +12,12 @@
 from collections.abc import Iterator
 from dataclasses import dataclass
 from enum import Enum
-from typing import Literal, NamedTuple
+from typing import NamedTuple
 
 from typing_extensions import Self
 
 from framework.exception import ConfigurationError, InternalError
-from framework.testbed_model.node import Node
+from framework.testbed_model.node import Node, NodeIdentifier
 
 from .port import DriverKind, Port, PortConfig
 
@@ -47,10 +47,6 @@ class PortLink(NamedTuple):
     tg_port: Port
 
 
-NodeIdentifier = Literal["sut", "tg"]
-"""The node identifier."""
-
-
 @dataclass(frozen=True)
 class Topology:
     """Testbed topology.
-- 
2.43.0

