Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A26FF483F8
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 20:24:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 256994066F;
	Mon, 23 Mar 2026 21:24:16 +0100 (CET)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by mails.dpdk.org (Postfix) with ESMTP id EE2384066D
 for <dev@dpdk.org>; Mon, 23 Mar 2026 21:24:14 +0100 (CET)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-506bcb23a78so35533751cf.3
 for <dev@dpdk.org>; Mon, 23 Mar 2026 13:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1774297454; x=1774902254; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JsehasbPrdgsrw9W7+uDeltSyX+3gXIbxoFdAv0pJrI=;
 b=cy0qAiiwz+b+arjS9FkcIYEo62EYWrmWP2GU+LNgVn0wTlCrwaNGAUyLelCb3IjOTr
 w8298tgnRYlVRUEotmDPHY5UAGRoXQvWgOJP2FyNQQCYyeVVR2RBGEaFUwZAGJH8f5Lg
 eXFNa2Q2nu1Oqu0GDHHJ7jpfGHTiYiLgQ7h+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774297454; x=1774902254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JsehasbPrdgsrw9W7+uDeltSyX+3gXIbxoFdAv0pJrI=;
 b=dAn6u0ZPF1WB3eTiWTukoE3w0wV2wbat1rd1VrwvqPxQblParFIDuybUZPDyDT+VWn
 t9uPUizEFyYHIqWwRTaaDYI0Vg7vK/a5QaD/fH2NBDsKU1iL9N99BP5N459EhEQu5x3T
 pi9ZY4Ie9bZF61aAl9uzGq0a6T7PXlIBvvd/3dZ+fdAoHpZfAOtcJeaeYJEJa7WCFHvM
 fVw3lI3/zndLEsrp0Mc6O0Sigboz9HzkqthIW/VEIKtAk1oTW9Xzwn9yAW5bEDqwHBT4
 kPkcf0Xr3NwQUPV1DZYkuzycmhOA7vL1widbA9HOrA1iUGmRYMCcw/Zux3aFdzFVKG0B
 XFng==
X-Gm-Message-State: AOJu0Yybf7pUPphjOcSlqic1r0f9BY+60delGVUMbiCZ7po+LzSByYp4
 xLd+nASvdHpUej1qrtZ47Y8nocbfLbRcNkwaohklwJJamPLpSDKxcPybtOxpk5psBkg=
X-Gm-Gg: ATEYQzwGBNVlCTqgWlpPn35Juf1wD1P0RpFKIHX7z3yUbv8qGoG68zoI2wVO5esb9L+
 eMNcKmV4w6GeIPh1oG4kPV1l6jJN3WKTSvmZ7Or7RGrcfqC6d0XG+Ye37yiPgVIWFQVLgmvGMgM
 E9//FJPK9L/o4JSfl6w6wanO39ttMk37e1Nyx1GXVHhjQmn1PPPVBaKg5Z1KIncCw9kbvRskrYq
 qhCOotWkB/19/W7Expe9dEr+huboDVRkXfgFogzgL+kVIxMB0OcCfrXUZ+JUzjWUX9mbV5xAfmS
 gRsHCtZTQnYSBdN8fAUb7BuGuUqJjjmNPKAiSMimhhAJSaX41P09KqOaNxQd/UxMlIxqEuKsMsF
 8av4CyBEMeWnSfR6Fzu7yuBKVAx5NJluyR02EO/Bs9VTAfvqJFm4PPS/JX9V8B85FkAwYyieK4y
 wURbgbiujirEpNJhgk0Pb97i5Ij26A7dMVgZnq8U6EK+ibOEtoVVEt+xjTXLRBs0694lterp9ZO
 Quj+Ltw0MFeMCfNnlgrWwQ=
X-Received: by 2002:a05:622a:49:b0:509:e48:f8cb with SMTP id
 d75a77b69052e-50b375b714fmr216581481cf.70.1774297454251; 
 Mon, 23 Mar 2026 13:24:14 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1210::224])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b702b85d2sm2966811cf.25.2026.03.23.13.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:24:13 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, dmarx@iol.unh.edu,
 Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v2 2/2] dts: avoid dpdk resources conflict
Date: Mon, 23 Mar 2026 16:20:53 -0400
Message-ID: <20260323202053.740203-3-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260323202053.740203-1-probb@iol.unh.edu>
References: <20260323180818.674041-1-probb@iol.unh.edu>
 <20260323202053.740203-1-probb@iol.unh.edu>
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

When starting and stopping DPDK applications in rapid succession,
there may be a resource conflicts on ports, memory, VFIO, etc.
Even after we send "quit" to the testpmd CLI, some resource
cleanup will happen asynchronously in the background. To avoid a
resource conflict upon starting a subsequent DPDK application,
add a very brief sleep after quitting DPDK applications.

Fixes: bfad0948df75 ("dts: rework interactive shells")

Signed-off-by: Patrick Robb <probb@iol.unh.edu>
Tested-by: Patrick Robb <probb@iol.unh.edu>
---
 dts/api/testpmd/__init__.py                |  2 +-
 dts/framework/remote_session/dpdk_shell.py | 12 +++++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
index 703cae487e..e9187440bb 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -1174,7 +1174,7 @@ def clear_port_stats_all(self, verify: bool = True) -> None:
 
     @only_active
     def close(self) -> None:
-        """Overrides :meth:`~.interactive_shell.close`."""
+        """Overrides :meth:`~.dpdk_shell.close`."""
         self.stop()
         self.send_command("quit", "Bye...")
         return super().close()
diff --git a/dts/framework/remote_session/dpdk_shell.py b/dts/framework/remote_session/dpdk_shell.py
index 51b97d4ff6..f926c3fa4d 100644
--- a/dts/framework/remote_session/dpdk_shell.py
+++ b/dts/framework/remote_session/dpdk_shell.py
@@ -6,13 +6,14 @@
 Provides a base class to create interactive shells based on DPDK.
 """
 
+import time
 from abc import ABC, abstractmethod
 from pathlib import PurePath
 
 from framework.context import get_ctx
 from framework.params.eal import EalParams
 from framework.remote_session.interactive_shell import (
-    InteractiveShell,
+    InteractiveShell, only_active,
 )
 from framework.testbed_model.cpu import LogicalCoreList
 
@@ -84,3 +85,12 @@ def _make_real_path(self) -> PurePath:
         Adds the remote DPDK build directory to the path.
         """
         return get_ctx().dpdk_build.remote_dpdk_build_dir.joinpath(self.path)
+
+    @only_active
+    def close(self) -> None:
+        """Overrides :meth:`~.interactive_shell.close`."""
+        # Allow time for VFIO and hardware resources to be released by the kernel after the
+        # DPDK process exits. Without this delay, sequential testpmd instances may have EAL
+        # errors when trying to acquire the same devices.
+        time.sleep(1)
+        return super().close()
-- 
2.49.0

