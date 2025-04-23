Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADA8C369D5
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 19:41:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CE844060F;
	Wed, 23 Apr 2025 21:40:53 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 0F519402C8
 for <dev@dpdk.org>; Wed, 23 Apr 2025 21:40:50 +0200 (CEST)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7c549d9ecc6so2734585a.1
 for <dev@dpdk.org>; Wed, 23 Apr 2025 12:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745437249; x=1746042049; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hX/zkwUIi+o5VdyOXg5WJ/tLF/kD0P3k8l0yBGi4yOU=;
 b=EL7fwkyMtVTyeAcPtRL/rl74lXSthH+yd1xS/jSWM+yVBxtyxgEvX76OxkbvDCX/Nc
 dAAgm93GecAlMk7Ubezfiq9CKLXFjP4ql2NquBGcv4EXXwPaiFO3iQ1DgpIWS4GxvM24
 SWSVXPyl986RSNoWsHOfzEazdJeZrvcBN13es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745437249; x=1746042049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hX/zkwUIi+o5VdyOXg5WJ/tLF/kD0P3k8l0yBGi4yOU=;
 b=SHLaZuqIhz7aZjY4tGo1GnkieyUy4Y+ZeKuRZaD3MiBeI51DgFgVBmSO69TpG3a7CR
 HsgWKuja5kLdg1OFe7yw2Bmc6kzxOk3UNG3yFO0pwRaydgnI90ca8gSl+aTeI5GmnFKD
 n/wN0ZVYoDYgOGQS5/5ubbXGsDUk0FzkiV2L5vNOUbiJG5R3kPfB9xkOXShbeseoN+n2
 9W6GtabDS8lgiEHa5re4nv5TI6HvyDzStDRKT/QzT4hIog6Eesb5nPc1yP8+5X+KD99M
 lQJ2kXclx7EWw+55z2Q2AdrPDqoE/XPFQSDNi4QE6Z2aAAvOlGvTIk26ky577Lil5gSz
 zcvw==
X-Gm-Message-State: AOJu0YwmN/VD9YW3CGJCBu2OGwjeCbQrm/dO44hDqxnsak6RjwdNpdf5
 rLrANf5KqQvXjBI4ljhMFvZnpyM13axNlUcw9WYPKJJslktfSXH4FYlJfIny9zk=
X-Gm-Gg: ASbGnct3L/BMu0iLeuXWXDLqZS1lBdY7O88p/qtRD7sf6jlOWFVuMlcziQg1LaCKfnH
 0i89rtMF/nMa33pQ5rm258sOw116bWaR9qHfvC95wsqn1M/3FSWvStybxAEv4oFZoeV16b1d5Kf
 ya/iEY2IFBC6KTmOR74EG5w0yne3AgIB8PC1SkECakfPGsbJRz+ujHv6M6F9to8nTq1SotO+jX0
 hnd/BDejWVDS+10wxvTZ4TJIylN7JwczG27PFbp88bkAqhHp0K3eglk+VRI05NVGwx+stmHnrAb
 XChxoifkAtWd/XUu6efA3I2HIt+TD7PNAdD4qt90OES/RNIdz9dIVSsDTjGS3mfF4vTyyq+0L81
 naXcmWw==
X-Google-Smtp-Source: AGHT+IF20eoZ6sJNlE3L7Ai66xTNssMlfy/IeKnq0rsbV4xgkjGcEajU2d5jgEyW4wBqFo7aPZasmw==
X-Received: by 2002:ac8:578b:0:b0:471:f08e:d65d with SMTP id
 d75a77b69052e-47d1bd83ccdmr24830581cf.6.1745437249386; 
 Wed, 23 Apr 2025 12:40:49 -0700 (PDT)
Received: from localhost.unh.edu ([2606:4100:3880:1271:e2f8:4ec3:8bf3:864c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47ae9cf9f7dsm71635691cf.74.2025.04.23.12.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 12:40:49 -0700 (PDT)
From: Nicholas Pratte <npratte@iol.unh.edu>
To: ian.stokes@intel.com, yoan.picchi@foss.arm.com, probb@iol.unh.edu,
 paul.szczepanek@arm.com, Honnappa.Nagarahalli@arm.com, thomas@monjalon.net,
 luca.vizzarro@arm.com, thomas.wilks@arm.com, dmarx@iol.unh.edu,
 stephen@networkplumber.org
Cc: dev@dpdk.org,
	Nicholas Pratte <npratte@iol.unh.edu>
Subject: [RFC Patch v1 3/5] dts: add asychronous support to ssh sessions.
Date: Wed, 23 Apr 2025 15:40:09 -0400
Message-ID: <20250423194011.1447679-4-npratte@iol.unh.edu>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250423194011.1447679-1-npratte@iol.unh.edu>
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
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

Execution of the TREX server process requires an SSH session rework to
support asynchronous process management. Allowing access to asynchronous
functionality allows developers to execute processes without hijacking
the SSH session being used. In doing so, both timeout and runtime errors
may be avoided. This functionality leverages Fabric's Promise class,
which provides a join method to terminate the process when the process
is done being used, providing more secure process control.

Bugzilla ID: 1697
Signed-off-by: Nicholas Pratte <npratte@iol.unh.edu>
---
 dts/framework/remote_session/ssh_session.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/dts/framework/remote_session/ssh_session.py b/dts/framework/remote_session/ssh_session.py
index e6e4704bc2..185905f701 100644
--- a/dts/framework/remote_session/ssh_session.py
+++ b/dts/framework/remote_session/ssh_session.py
@@ -13,6 +13,7 @@
     ThreadException,
     UnexpectedExit,
 )
+from invoke.runners import Promise
 from paramiko.ssh_exception import (
     AuthenticationException,
     BadHostKeyException,
@@ -99,6 +100,22 @@ def _send_command(self, command: str, timeout: float, env: dict | None) -> Comma
 
         return CommandResult(self.name, command, output.stdout, output.stderr, output.return_code)
 
+    def _send_async_command(self, command: str, timeout: float, env: dict | None) -> Promise:
+        try:
+            promise = self.session.run(
+                command, env=env, warn=True, hide=True, timeout=timeout, asynchronous=True
+            )
+
+        except (UnexpectedExit, ThreadException) as e:
+            self._logger.exception(e)
+            raise SSHSessionDeadError(self.hostname) from e
+
+        except CommandTimedOut as e:
+            self._logger.exception(e)
+            raise SSHTimeoutError(command) from e
+
+        return promise
+
     def is_alive(self) -> bool:
         """Overrides :meth:`~.remote_session.RemoteSession.is_alive`."""
         return self.session.is_connected
-- 
2.47.1

