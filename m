Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13682C61DD6
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 18:14:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A87C441132;
	Wed,  2 Sep 2026 20:13:57 +0200 (CEST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by mails.dpdk.org (Postfix) with ESMTP id 5DD30410FC
 for <dev@dpdk.org>; Wed,  2 Sep 2026 20:13:56 +0200 (CEST)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-530420edf1bso3643571cf.1
 for <dev@dpdk.org>; Wed, 02 Sep 2026 11:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1788372836; x=1788977636; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zlDf2zxI6UvRbq6THkSfrX/5oi7lyNemfBqCE6uFjWQ=;
 b=ZuDJV8Ety9PLwzgID9F8SBnui/GcUziqNK3cikq8iL4VtKAHXro7NBEzLA76I4zcQf
 mdy6G32xkgafsitQkR5H81pNwxZvUuWcq1qAK0VcI9NfZ3SbpdGIk94oSLJbzo3mThpF
 TeZAzVHyfjE2xHB41T30ZKzuQfCWLjZHGSSDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788372836; x=1788977636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zlDf2zxI6UvRbq6THkSfrX/5oi7lyNemfBqCE6uFjWQ=;
 b=BuUxEUygSoMCbBaAZN3D1DgHIJ7q1hUABbeu7mGVWZS3/FNsgnWBK2dLzaxrPTjgXd
 AvPilfVzfwT5ZBzsARhIPPkxd9k0+VcBznxSbwYbEUcnxIbSS04fLjNMW2IUq0MdsPeK
 JqUY22Ht/w1qjaz80xhvnun9dBLKDLHuXOiIiyXeuvZ0ZfdprIcilnz4zIciyZcjL8f5
 552Yo6jUZkvYuwcbw8rxlbLKoPuluoHn61Lat1QanIKSUJN2M9KccOohbqiaRirOIRpm
 CtIDLZIgf00NnPObsrwMo4J+83cAvanI+dTbvy6+lCEqoje6oEf1bly1aCrhjEFWZUQM
 +fEQ==
X-Gm-Message-State: AFuF++l/MGpSM2kuPPk2Rq9qjAbhFCykZsz0o7x5RctvmvPHYVn9M/8p
 7W5Tcn045tbA4s8nzORHWX6+3T9knz9xw5/d+bqJP+ax303NPyWje/QwuuYeGz9U1EiLw/Rsg+m
 c899mjkUmLlzF1QoLcLrgQLthuCe5nUrgNiv6VQhaOHUXeelnGO6YwkBsrCvnWYjpcXqoYuXs9c
 Hb7YtU8VrMjdfXv1ODSXH2JBHnwNM=
X-Gm-Gg: AYBFou2Pn+uSQ7NeKhMpoqvNmnIckKmJrMMwsozBH6In4bqBppWtZMs2XD3bZl40sI5
 zHbQxilrdgJaugOzjZhQZdUTQbilRtQrAJw3QFnBlfumOj5/Zd8rDobVbYDrQPfU62rs7hE4AEB
 68kdEMUCy5u8CjAc6Zt7f9qQ6WFUYHS99yK3/rqFLJVkif0WGCwlS364BSYttUxyPB234LteW4N
 iESAErC5Adgyw2ttXEdFhwWS3bohPXRQxzRTAS814qpU8bTIBqvOaeDUyhGOXfd9g7mbYuIqZCT
 A8OROcHu9FGcELmV+Z1o2IgZhtDkUX+XeXmYY/sTDgebCcBTZPUFuNt6I8ewW/f/abIiXdVc/Gi
 p5i+w3pQ3lT62ExuLHeammXYo8pYnwkUI1Jinw/46sGBdXPWNnHkxW588W50jvta6h+qSWpiDiw
 XMEIJj9YhSQCjQC0OZLlBAe6/KytR24BwB7bL14l8MDYiEjAv2Efxd2VjXnE/1V/BdTWsJ03VNr
 y78aHWKpGKWMLacr+5Ftw==
X-Received: by 2002:a05:622a:4812:b0:52d:7b1a:d7e0 with SMTP id
 d75a77b69052e-53036d183a4mr88855341cf.32.1788372835535; 
 Wed, 02 Sep 2026 11:13:55 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-530331d9cbcsm24660101cf.16.2026.09.02.11.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 11:13:55 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v6 4/8] dts: separate Linux session into interface and logic
Date: Wed,  2 Sep 2026 14:13:28 -0400
Message-ID: <20260902181333.461556-5-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902181333.461556-1-abailey@iol.unh.edu>
References: <20260806135346.568766-1-abailey@iol.unh.edu>
 <20260902181333.461556-1-abailey@iol.unh.edu>
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

Separate Linux session into an interface for the API,
and a logical module in the framework.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/api/testbed_model/linux_session.py       | 42 ++++++++++++++++++++
 dts/framework/testbed_model/linux_session.py |  3 +-
 dts/tests/TestSuite_smoke_tests.py           |  2 +-
 dts/tests/TestSuite_virtio_forward.py        |  3 +-
 4 files changed, 47 insertions(+), 3 deletions(-)
 create mode 100644 dts/api/testbed_model/linux_session.py

diff --git a/dts/api/testbed_model/linux_session.py b/dts/api/testbed_model/linux_session.py
new file mode 100644
index 0000000000..1b9f6d8339
--- /dev/null
+++ b/dts/api/testbed_model/linux_session.py
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 University of New Hampshire
+
+"""Linux OS translator.
+
+Translate OS-unaware calls into Linux calls/utilities. Most of Linux distributions are mostly
+compliant with POSIX standards, so this module only implements the parts that aren't.
+This intermediate module implements the common parts of mostly POSIX compliant distributions.
+"""
+
+from abc import ABC, abstractmethod
+from pathlib import PurePath
+
+
+class LinuxSession(ABC):
+    """The implementation of non-Posix compliant parts of Linux."""
+
+    @abstractmethod
+    def set_interface_link_up(self, name: str) -> None:
+        """Set the link status of an interface to up.
+
+        Args:
+            name: the name of the interface
+        """
+
+    @abstractmethod
+    def delete_interface(self, name: str) -> None:
+        """Delete a virtual interface.
+
+        Args:
+            name: the name of the interface to delete.
+        """
+
+    @property
+    @abstractmethod
+    def devbind_script_path(self) -> PurePath:
+        """The path to the dpdk-devbind.py script on the node."""
+
+    @devbind_script_path.setter
+    @abstractmethod
+    def devbind_script_path(self, value: PurePath) -> None:
+        """The path to the dpdk-devbind.py script on the node."""
diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index 26c53f069c..13dce6455d 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -23,6 +23,7 @@
     InternalError,
     RemoteCommandExecutionError,
 )
+from api.testbed_model.linux_session import LinuxSession as LinuxSessionBase
 from api.utils import expand_range
 from framework.testbed_model.port import PortInfo
 
@@ -79,7 +80,7 @@ class LshwOutput(TypedDict):
     configuration: LshwConfigurationOutput
 
 
-class LinuxSession(PosixSession):
+class LinuxSession(PosixSession, LinuxSessionBase):
     """The implementation of non-Posix compliant parts of Linux."""
 
     @staticmethod
diff --git a/dts/tests/TestSuite_smoke_tests.py b/dts/tests/TestSuite_smoke_tests.py
index fce83604a6..656e2e4bb7 100644
--- a/dts/tests/TestSuite_smoke_tests.py
+++ b/dts/tests/TestSuite_smoke_tests.py
@@ -19,12 +19,12 @@
     requires_link_topology,
 )
 from api.test import verify
+from api.testbed_model.linux_session import LinuxSession
 from api.testpmd import TestPmd
 from api.utils import REGEX_FOR_PCI_ADDRESS
 from framework.config.node import PortConfig
 from framework.settings import SETTINGS
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.linux_session import LinuxSession
 
 
 @requires_link_topology(LinkTopology.NO_LINK)
diff --git a/dts/tests/TestSuite_virtio_forward.py b/dts/tests/TestSuite_virtio_forward.py
index 6efaa4e156..6c4d7532c7 100644
--- a/dts/tests/TestSuite_virtio_forward.py
+++ b/dts/tests/TestSuite_virtio_forward.py
@@ -12,11 +12,11 @@
 from api.capabilities import LinkTopology
 from api.packet import send_packets_and_capture
 from api.test import log, verify
+from api.testbed_model.linux_session import LinuxSession
 from api.testpmd import TestPmd
 from api.testpmd.config import PortTopology, SimpleForwardingModes
 from framework.test_suite import TestSuite, func_test
 from framework.testbed_model.capability import requires
-from framework.testbed_model.linux_session import LinuxSession
 from framework.testbed_model.virtual_device import VirtualDevice
 
 
@@ -152,6 +152,7 @@ def pvp_loop(self) -> None:
         """
         self.sut_node = self._ctx.sut_node
         if not isinstance(self.sut_node.main_session, LinuxSession):
+            print(f"\n\nSESSION: {self.sut_node.main_session}")
             verify(False, "Must be running on a Linux environment.")
         # delete tap0 interface if it exists
         self.sut_node.main_session.delete_interface(name="tap0")
-- 
2.55.0

