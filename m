Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E66AF532C7
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 00:55:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 007EA40609;
	Tue, 24 Mar 2026 01:55:56 +0100 (CET)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTP id 043A140431
 for <dev@dpdk.org>; Tue, 24 Mar 2026 01:55:55 +0100 (CET)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-50b268fba9aso6255151cf.3
 for <dev@dpdk.org>; Mon, 23 Mar 2026 17:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1774313754; x=1774918554; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NxxfK46q0e+0sj2aih2qSaGYEbPGWwSFGYJQtfDuxvk=;
 b=PV0lZHZVskisFGpbGayTBGf2h9YU3i2L9fgLmvp+V5xeV/+BzrJ4Y2/EVqI9RuRrW7
 3InOROCjxoU9WrucLzh5y2ALS80BlIUKLsVdeyX++5K53aMGUauJ+OUCyW7QspUVdjU/
 T+Q4dUdF/qwHHqRR3117fwgXs+x/r/btb3cKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774313754; x=1774918554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NxxfK46q0e+0sj2aih2qSaGYEbPGWwSFGYJQtfDuxvk=;
 b=OoDfAK2hILGHGGpqq83SzYa0qTJ2WO0e8cOextJk2hut3cdrEi1kQmCvxfu7PchgvR
 TWlT7B4Yzfs6nOUec3r92vgCZA0M4lqBzIn9h0/quiFZhGSWEX/ZEMVnBmuWDunUx9bX
 ODtgSwopMRwuG2cq7xJ0j0VynOfD4E5Ru5yB0+aEzC7MJ3eojPoCGl1vVRgdWF0SBIL2
 PUgtcjXuymwH/2PdX03/rlkYmZBBQ0MsEq7CBtPjijfX7PkQln7sCXdiSzPFutBp/j6H
 hDqv00q8ciVjS1G0MK1cLe3iPZmnjVfgw3YYC621GvEjZY/xdS9rU2TbX+pO20nJkMTG
 /r8w==
X-Gm-Message-State: AOJu0YyGAVdgVYM8QbTbHVnoo17h2mWdIEvx1l9C7wWgF3MmMCFcWle3
 vOayKE+1CZxIdXsm3UMDfrGp+G3eRMxiX2mMXfS+NSZP773+E3TpasrGkseycdo8IxE=
X-Gm-Gg: ATEYQzznjXXOSu8TmMI93lrN2+rPaVwu7kVaUwVEcRGneXuA1faEIzT2du6D3ayHQr6
 oqyWhtrRU7aj5ZxnoxLycDAkyoV3aU3K3qdreAQtjUdy6uCvyC89TYIFUlT24bR/JO/NayGd4Nl
 evTFnCKPQ98Ek+BsYYahJO1i1Ekoke0J+V6wdkmcjZJ+KGMcWAnTTSUf6ylc7CuqQA/8EsUfobL
 /gAQUHL3vdl3EvYmhGZBm6ubG/XGb68XyRGv9z4YnF3BnWR7qwhPcuulG1lkYLh5ZAwLM2l640w
 zbCQL/Gd7hrPT12DzsIPQQFvhjSymgJvTlEysc4s5VEyG+dRz0XbshLSwMSRGczW7KDx6hJ7AIs
 oQ86ahKITYxO12x80IKoid1iqz2Hr+ALJizQrThVMmvAJuTxb4lQuMNdrKmiXD6MjvFDa3ZklCl
 iihHEvJwNaUblFs73kUq0QVejsEUAcNX4DSSfTiEFFT0NznuuhNnb39LjtwsmtYny1Artronuhv
 MCC5nL6Le8=
X-Received: by 2002:ac8:5a91:0:b0:506:8738:651d with SMTP id
 d75a77b69052e-50b37599714mr221808541cf.62.1774313754309; 
 Mon, 23 Mar 2026 17:55:54 -0700 (PDT)
Received: from patrick-laptop.hsd1.nh.comcast.net
 ([2601:188:c083:cd0:e674:3b6b:125b:ed1e])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b36e3d85bsm91913721cf.17.2026.03.23.17.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 17:55:53 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, dmarx@iol.unh.edu,
 Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v3 2/2] dts: avoid dpdk resources conflict
Date: Mon, 23 Mar 2026 20:52:41 -0400
Message-ID: <20260324005241.761124-2-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260324005241.761124-1-probb@iol.unh.edu>
References: <20260323180818.674041-1-probb@iol.unh.edu>
 <20260324005241.761124-1-probb@iol.unh.edu>
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
Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>
Tested-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/api/testpmd/__init__.py                |  2 +-
 dts/framework/remote_session/dpdk_shell.py | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

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
index 51b97d4ff6..269c2cada4 100644
--- a/dts/framework/remote_session/dpdk_shell.py
+++ b/dts/framework/remote_session/dpdk_shell.py
@@ -6,6 +6,7 @@
 Provides a base class to create interactive shells based on DPDK.
 """
 
+import time
 from abc import ABC, abstractmethod
 from pathlib import PurePath
 
@@ -13,6 +14,7 @@
 from framework.params.eal import EalParams
 from framework.remote_session.interactive_shell import (
     InteractiveShell,
+    only_active,
 )
 from framework.testbed_model.cpu import LogicalCoreList
 
@@ -84,3 +86,12 @@ def _make_real_path(self) -> PurePath:
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

