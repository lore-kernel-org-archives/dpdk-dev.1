Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47ADFCA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 12:30:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E8F740285;
	Wed, 10 Sep 2025 14:30:10 +0200 (CEST)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by mails.dpdk.org (Postfix) with ESMTP id AB12A40270
 for <dev@dpdk.org>; Wed, 10 Sep 2025 14:30:09 +0200 (CEST)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-4b38d47fa9dso57340081cf.0
 for <dev@dpdk.org>; Wed, 10 Sep 2025 05:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1757507409; x=1758112209; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uc74ipdnUa0RWy+V4I5O6qWrjg7V0e7ypO8iA1K4Uq8=;
 b=jaE15I1WH+5Ww13MN1PmSANmC1ZV9gFxYyXjpKj/Uwns61XQmJhPPI0va8gUjk2dpr
 qBOE7agcYJRmwns5d9yCSuVbXwbwwRyekvWwQJk02LHeMXcClCoEMtoqJtfnl8tSqKWg
 kV49CeN4AFpVhZlRIgE1e2J3p0hnKHigKvqFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757507409; x=1758112209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uc74ipdnUa0RWy+V4I5O6qWrjg7V0e7ypO8iA1K4Uq8=;
 b=wk8B6EzzlHR1P4+mxBqWk1k/gInajvs/7ABN4WNcmTqJe/wPvicjDgcbhScSRdIMFA
 jIzZ09MkQ5ekVv9H3C6ASfEonYk5XvOepclATBKABE2NIPHPQbKo+/qOr8ND3TuhEBb8
 VdffqR5gJJn2Ec/3+n0ErSvyZwOEHHb7I4eg6HOQr0nGhRCClJAgEDrPeVPck8OpY3v3
 hVSHyDhqPgXI8o/AOn7nTRLPhzTIr7JXFado5JHoTqmTF3fWbKzLjAEaM3YN3ywwtt2a
 h/dK0oGMBZbZYei5ohG9KLAzJducwDrrK4fYFP/gNI5mSMABwBQqQCx2HXRtAt4p+b/H
 GgZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcK7LdKtXr0SQ2N8BRZUzbMpMEFK71IvhT6cY2W4YuIzdAO3TNp1NlpN/dAf8yyJarhjE=@dpdk.org
X-Gm-Message-State: AOJu0YwKCB7yMYCn9xrEsZSJe2z91/VeQDqkt74SDDJVJ6UJaH0Bojai
 Lbde5QynmOKlo14aaCilc9P/nuqRhslSzMGnqyPcN4lNWk6xkoliyUl/XVrBQxogK+s=
X-Gm-Gg: ASbGncufwiwcFTP6dG4KgzXvgGMuRo2PYmiWBwe7YGGttsZksDtEpNabVg+5IzJBczI
 wj4sX7hd2iuc8yIlD0Fg/X/nTl7uVI257U1hyPPVSrevSPecWpqp3R28iKv7rFSkaerhKx9RZ0J
 FUp9HUDgPP8Usyu+kT0ZyTdgaubIHVzgmk7uu5NOLdqWlr2eU+O/tTxrSY+SxfHM603ZVT8r6bf
 HvTRlvZBcrG5dSmqMw0GPBsguXjub9gdq9BDt3suaFRY4x0S8PGvnvyvpM2l+N4mEAkDkLUt4FP
 N4OX29vpq1l30kP25eFW5YyK1AsP9bCqFhuLH8gyMCT/a/+VTkHeDo6n1exft5HGvE9GQJUfIeK
 rKr9rup8coS9T1wmR06ChWqaBH3GrKgWCxgOg1ocsT7H+2nknplQCqkg3BDbWA8Ix/TLffTjQOH
 ernOHkwTcAJxw=
X-Google-Smtp-Source: AGHT+IHBTrc8h6QMjbSwSSMB9RiNx/XhengtH63OJr88WLP2iqE/fD1dvzrjx2+hIvAzBs9uvEY5/Q==
X-Received: by 2002:ac8:590b:0:b0:4b5:eab3:66cf with SMTP id
 d75a77b69052e-4b5f83c9100mr139950531cf.30.1757507408480; 
 Wed, 10 Sep 2025 05:30:08 -0700 (PDT)
Received: from dhcp-10-21-133-214.iol.unh.edu (targon.iol.unh.edu.
 [132.177.125.242]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b61bbbc3a3sm22807591cf.24.2025.09.10.05.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 05:30:07 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: [PATCH v5] dts: enable port binding on the TG
Date: Wed, 10 Sep 2025 08:27:49 -0400
Message-ID: <20250910122749.8277-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250808182152.356879-2-abailey@iol.unh.edu>
References: <20250808182152.356879-2-abailey@iol.unh.edu>
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

Currently, ports on the TG are not bound to the correct drivers prior to
running DTS. This causes DTS to crash if they are not initially bound to
the intended drivers. Binding the TG ports to the proper driver caused
DTS to fail when the OS and DPDK drivers were the same, due to the port
link not being up. Changing the bound_for_dpdk method for a port to
return false when the OS driver and DPDK driver were shared on a TG
node allowed the TG ports to enter the logic to be brought up in the
configure_ports method within the topology class.

Leverage TG runtime environment to bind TG ports to correct drivers
before and after running DTS.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---

v4: Relocated logic for bringing up ports using mellanox drivers. This
moved from the ports class to the configure_ports method in the
topology class.

v5: Added a bound for kernel property in port class. Simplified logic
for gathering ports to bring the link up on, in the configure ports
method of the topology class.

 dts/framework/remote_session/dpdk.py    | 36 +----------------------
 dts/framework/testbed_model/port.py     |  5 ++++
 dts/framework/testbed_model/topology.py | 39 ++++++++++++++++++++++++-
 3 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index 606d6e22fe..d1ab3ae50d 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -24,12 +24,11 @@
     RemoteDPDKTarballLocation,
     RemoteDPDKTreeLocation,
 )
-from framework.exception import ConfigurationError, InternalError, RemoteFileNotFoundError
+from framework.exception import ConfigurationError, RemoteFileNotFoundError
 from framework.logger import DTSLogger, get_dts_logger
 from framework.params.eal import EalParams
 from framework.remote_session.remote_session import CommandResult
 from framework.testbed_model.cpu import LogicalCore, LogicalCoreCount, LogicalCoreList, lcore_filter
-from framework.testbed_model.linux_session import LinuxSession
 from framework.testbed_model.node import Node
 from framework.testbed_model.os_session import OSSession
 from framework.testbed_model.virtual_device import VirtualDevice
@@ -358,7 +357,6 @@ def setup(self):
         """Set up the DPDK runtime on the target node."""
         if self.build:
             self.build.setup()
-        self._prepare_devbind_script()

     def teardown(self) -> None:
         """Reset DPDK variables and bind port driver to the OS driver."""
@@ -385,38 +383,6 @@ def run_dpdk_app(
             f"{app_path} {eal_params}", timeout, privileged=True, verify=True
         )

-    def _prepare_devbind_script(self) -> None:
-        """Prepare the devbind script.
-
-        If the environment has a build associated with it, then use the script within that build's
-        tree. Otherwise, copy the script from the local repository.
-
-        This script is only available for Linux, if the detected session is not Linux then do
-        nothing.
-
-        Raises:
-            InternalError: If dpdk-devbind.py could not be found.
-        """
-        if not isinstance(self._node.main_session, LinuxSession):
-            return
-
-        if self.build:
-            devbind_script_path = self._node.main_session.join_remote_path(
-                self.build.remote_dpdk_tree_path, "usertools", "dpdk-devbind.py"
-            )
-        else:
-            local_script_path = Path("..", "usertools", "dpdk-devbind.py").resolve()
-            if not local_script_path.exists():
-                raise InternalError("Could not find dpdk-devbind.py locally.")
-
-            devbind_script_path = self._node.main_session.join_remote_path(
-                self._node.tmp_dir, local_script_path.name
-            )
-
-            self._node.main_session.copy_to(local_script_path, devbind_script_path)
-
-        self._node.main_session.devbind_script_path = devbind_script_path
-
     def filter_lcores(
         self,
         filter_specifier: LogicalCoreCount | LogicalCoreList,
diff --git a/dts/framework/testbed_model/port.py b/dts/framework/testbed_model/port.py
index fc58e2b993..c5e7bbca57 100644
--- a/dts/framework/testbed_model/port.py
+++ b/dts/framework/testbed_model/port.py
@@ -128,6 +128,11 @@ def bound_for_dpdk(self) -> bool:
         """Is the port bound to the driver for DPDK?"""
         return self.current_driver == self.config.os_driver_for_dpdk

+    @property
+    def bound_for_kernel(self) -> bool:
+        """Is the port bound to the driver for the kernel?"""
+        return self.current_driver == self.config.os_driver
+
     def configure_mtu(self, mtu: int):
         """Configure the port's MTU value.

diff --git a/dts/framework/testbed_model/topology.py b/dts/framework/testbed_model/topology.py
index 899ea0ad3a..c2ba7799f4 100644
--- a/dts/framework/testbed_model/topology.py
+++ b/dts/framework/testbed_model/topology.py
@@ -12,11 +12,13 @@
 from collections.abc import Iterator
 from dataclasses import dataclass
 from enum import Enum
+from pathlib import Path
 from typing import Literal, NamedTuple

 from typing_extensions import Self

 from framework.exception import ConfigurationError, InternalError
+from framework.testbed_model.linux_session import LinuxSession
 from framework.testbed_model.node import Node

 from .port import DriverKind, Port, PortConfig
@@ -128,6 +130,7 @@ def setup(self) -> None:

         Binds all the ports to the right kernel driver to retrieve MAC addresses and logical names.
         """
+        self._prepare_devbind_script()
         self._setup_ports("sut")
         self._setup_ports("tg")

@@ -232,7 +235,7 @@ def configure_ports(

         self._bind_ports_to_drivers(node, ports, drivers)

-        ports_to_bring_up = [p for p in ports if not (p.bound_for_dpdk or p.is_link_up)]
+        ports_to_bring_up = [p for p in ports if p.bound_for_kernel and not p.is_link_up]
         if ports_to_bring_up:
             node.main_session.bring_up_link(ports_to_bring_up)

@@ -250,6 +253,40 @@ def _bind_ports_to_drivers(
         for driver_name, ports in driver_to_ports.items():
             node.main_session.bind_ports_to_driver(ports, driver_name)

+    def _prepare_devbind_script(self) -> None:
+        """Prepare the devbind script.
+
+        Copy devbind script from local repository.
+
+        This script is only available for Linux, if the detected session is not Linux then do
+        nothing.
+
+        Raises:
+            InternalError: If dpdk-devbind.py could not be found.
+        """
+        from framework.context import get_ctx
+
+        local_script_path = Path("..", "usertools", "dpdk-devbind.py").resolve()
+        valid_script_path = local_script_path.exists()
+
+        def prepare_node(node: Node) -> None:
+            if not isinstance(node.main_session, LinuxSession):
+                return
+
+            if not valid_script_path:
+                raise InternalError("Could not find dpdk-devbind.py locally.")
+
+            devbind_script_path = node.main_session.join_remote_path(
+                node.tmp_dir, local_script_path.name
+            )
+
+            node.main_session.copy_to(local_script_path, devbind_script_path)
+            node.main_session.devbind_script_path = devbind_script_path
+
+        ctx = get_ctx()
+        prepare_node(ctx.tg_node)
+        prepare_node(ctx.sut_node)
+
     @property
     def sut_dpdk_ports(self) -> list[Port]:
         """The DPDK ports for the SUT node."""
--
2.50.1

