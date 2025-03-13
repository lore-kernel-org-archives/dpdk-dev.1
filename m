Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7FCC282EC
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 03:40:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90EDC40E1E;
	Thu, 13 Mar 2025 04:40:11 +0100 (CET)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 330DA40B94
 for <dev@dpdk.org>; Thu, 13 Mar 2025 04:40:10 +0100 (CET)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7be49f6b331so45223585a.1
 for <dev@dpdk.org>; Wed, 12 Mar 2025 20:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741837209; x=1742442009; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CSDHauNR9Nq0A5d4t814+SCQuJ7pQ1IaPMLQ/fm2stU=;
 b=WQwGmy1R5PCp3ra+Xt8+EyLtVxNeRpxeXVnvHUPXOou4Lh5vY84Nqw2/I7mzqfRZp8
 o9FyOHKrJnaHh78AcCWG/BA0oE4MgQSm4bApbLlCbi7gLCKLKaCf45U7JK5DJmOTTBK1
 kB6OTtKB3zcqGyU/n0qtkhXUiu4Zm1oVY56GU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837209; x=1742442009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CSDHauNR9Nq0A5d4t814+SCQuJ7pQ1IaPMLQ/fm2stU=;
 b=oY92N0X9tU8eA9Vmq4krX5e4fyxGZhtU/eMCk5vMpg+TwZsVV2oMjSvPPYZLoK2+VJ
 Kr1ukP3kqQi/UXdjOElfyfpuY8MGk7lItaQ69DO4km6vreI4EZwaNJglkC9T7uzcl/5v
 Cy8JeODCErOrC8C+G5FPKIcQwEgqh6p/uiVjdC6Ieb+VjTyqIK/cUY3zkbMD1vJT10Go
 WYmoNQw+MMG1CphAVco2gilOOtlGJN+3inGGvobqWHTUMFuhlySW5a1ZaQq7W4Qo58r4
 fXd1ZSvkV7xt0UeUwEnENS6t6sQ09okU5g1CTvgwHjIokawRLuoa/GyvmMfNMHm+N8E4
 iRLQ==
X-Gm-Message-State: AOJu0YyHm+BkevB7Dy9fYZQ2S+wDrjj3XMjM4YsmJ2WwiG771GYyW5Yq
 fSMS+ii7yMscIMo7u6RVx+gsnPmFQP7xi8JG0iux0ErtoCmc3gXBkgk+nDICqzc=
X-Gm-Gg: ASbGncsvDLeQrcdQl7mRs9cRRC9UNcjK9WSCio38o3SmPFJzjz3mNgEuv5KTwrtzWVI
 rO+ZesHSQmKoQXI+UnOystc2ETUXfWz960cvIlQ0rYCje5977bg5BEsmzgaksiE8+CRax36VIeI
 VGlgslnESvUQ2+rMvKsmpWbGiEUByJoucFmdRZ3wnAFGZ/5lcuowYGAuaY5olUwshuLU1gzTq73
 26228bPGG+1UwsWbsvw8X+0ylpJZIVXKZERYCBjxi4ItoCc6AFu1TVVX9Vf0b4GM6pfaWdManTt
 I57kQ7I1C8Bh0HrH9stqA9BFU26tPSMF62A3t7pH1CSYg2YF/pNDVrsGZQOPQyHR91FYG8k3DJo
 =
X-Google-Smtp-Source: AGHT+IGhSGCMcBcJNfVdHJzCfxiQBs01z5t/pjB+uIf9SnBGA89aKd6PU//9z0Gq57TyTrCj50IKWA==
X-Received: by 2002:ad4:5b84:0:b0:6e6:698f:cafd with SMTP id
 6a1803df08f44-6e900681c65mr408854526d6.37.1741837209481; 
 Wed, 12 Mar 2025 20:40:09 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade257112sm4119716d6.61.2025.03.12.20.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:40:08 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: Paul.Szczepanek@arm.com
Cc: dev@dpdk.org, Luca.Vizzarro@arm.com, npratte@iol.unh.edu,
 dmarx@iol.unh.edu, Patrick Robb <probb@iol.unh.edu>,
 Jeremy Spewock <jspewock@iol.unh.edu>
Subject: [PATCH v5 1/2] dts: add OS abstractions for creating virtual functions
Date: Wed, 12 Mar 2025 23:36:10 -0400
Message-ID: <20250313033611.1896695-2-probb@iol.unh.edu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313033611.1896695-1-probb@iol.unh.edu>
References: <20240821191557.18744-1-jspewock@iol.unh.edu>
 <20250313033611.1896695-1-probb@iol.unh.edu>
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

Virtual functions are created in different ways per operating system.
Accordingly, we have abstracted the functions for managing virtual
functions into different classes per OS. This patch adds stubs
for creating virtual functions and gathering virtual function info.

Bugzilla ID: 1500

Signed-off-by: Jeremy Spewock <jspewock@iol.unh.edu>
Signed-off-by: Patrick Robb <probb@iol.unh.edu>
---
 dts/framework/testbed_model/linux_session.py | 37 +++++++++++++++++++-
 dts/framework/testbed_model/os_session.py    | 27 ++++++++++++++
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index 7c2b110c99..35cc7f6852 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -16,7 +16,11 @@
 
 from typing_extensions import NotRequired
 
-from framework.exception import ConfigurationError, RemoteCommandExecutionError
+from framework.exception import (
+    ConfigurationError,
+    InternalError,
+    RemoteCommandExecutionError,
+)
 from framework.utils import expand_range
 
 from .cpu import LogicalCore
@@ -183,6 +187,37 @@ def bring_up_link(self, ports: Iterable[Port]) -> None:
                 f"ip link set dev {port.logical_name} up", privileged=True, verify=True
             )
 
+    def create_vfs(self, pf_port: Port) -> None:
+        """Overrides :meth:`~.os_session.OSSession.create_vfs`.
+
+        Raises:
+            InternalError: If the number of VFs is greater than 0 but less than the
+            maximum for `pf_port`.
+        """
+        sys_bus_path = f"/sys/bus/pci/devices/{pf_port.pci}".replace(":", "\\:")
+        curr_num_vfs = int(self.send_command(f"cat {sys_bus_path}/sriov_numvfs").stdout)
+        max_num_vfs = int(
+            self.send_command(f"cat {sys_bus_path}/sriov_totalvfs", privileged=True).stdout
+        )
+        if 0 < curr_num_vfs < max_num_vfs:
+            raise InternalError("There are existing VFs on the port which must be deleted.")
+        if curr_num_vfs == 0:
+            self.send_command(f"echo {max_num_vfs} > {sys_bus_path}/sriov_numvfs", privileged=True)
+
+    def get_pci_addr_of_vfs(self, pf_port: Port) -> list[str]:
+        """Overrides :meth:`~.os_session.OSSession.get_pci_addr_of_vfs`."""
+        sys_bus_path = f"/sys/bus/pci/devices/{pf_port.pci}".replace(":", "\\:")
+        curr_num_vfs = int(self.send_command(f"cat {sys_bus_path}/sriov_numvfs").stdout)
+        if curr_num_vfs > 0:
+            pci_addrs = self.send_command(
+                'awk -F "PCI_SLOT_NAME=" "/PCI_SLOT_NAME=/ {print \\$2}" '
+                + f"{sys_bus_path}/virtfn*/uevent",
+                privileged=True,
+            )
+            return pci_addrs.stdout.splitlines()
+        else:
+            return []
+
     @cached_property
     def _lshw_net_info(self) -> list[LshwOutput]:
         output = self.send_command("lshw -quiet -json -C network", verify=True)
diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/testbed_model/os_session.py
index 354c607357..a4ad9940b2 100644
--- a/dts/framework/testbed_model/os_session.py
+++ b/dts/framework/testbed_model/os_session.py
@@ -554,3 +554,30 @@ def configure_port_mtu(self, mtu: int, port: Port) -> None:
             mtu: Desired MTU value.
             port: Port to set `mtu` on.
         """
+
+    @abstractmethod
+    def create_vfs(self, pf_port: Port) -> None:
+        """Creates virtual functions for `pf_port`.
+
+        Checks how many virtual functions (VFs) `pf_port` supports, and creates that
+        number of VFs on the port.
+
+        Args:
+            pf_port: The port to create virtual functions on.
+
+        Raises:
+            InternalError: If the number of VFs is greater than 0 but less than the
+            maximum for `pf_port`.
+        """
+
+    @abstractmethod
+    def get_pci_addr_of_vfs(self, pf_port: Port) -> list[str]:
+        """Find the PCI addresses of all virtual functions (VFs) on the port `pf_port`.
+
+        Args:
+            pf_port: The port to find the VFs on.
+
+        Returns:
+            A list containing all of the PCI addresses of the VFs on the port. If the port has no
+            VFs then the list will be empty.
+        """
-- 
2.48.1

