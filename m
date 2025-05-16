Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D04C3ABD8
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 20:19:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D564E40662;
	Fri, 16 May 2025 22:19:06 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 4A07F4065E
 for <dev@dpdk.org>; Fri, 16 May 2025 22:19:05 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7caeeef9629so34154985a.3
 for <dev@dpdk.org>; Fri, 16 May 2025 13:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747426744; x=1748031544; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+5tQn6sMTEt2GGwqCaa4SUL68ZxR0/VXNTpCu8+Vdng=;
 b=WQTNdFQDmuoLfh2yMyApoxA/ePrYWttUCsulYfceEL14zCP8AVmYlSITFIAEdzBy3s
 E1NPgLr48ZfjKpEkaixnwgaGiQ69QwfqukewS5lYahI/nUJo19ZtF5QjSATHsOlKxqgG
 Mum+73xHISL4qBvxP8uDsEa0uEwGyDqJ1uYAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747426744; x=1748031544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+5tQn6sMTEt2GGwqCaa4SUL68ZxR0/VXNTpCu8+Vdng=;
 b=Cs/ZBkhKce71JfU8UJ9HKLWNGyjZkBST4L65ROHUN3TEIFSWdlTrfyNcq/mWIHpxLu
 nmTb0TuhpYg+v6Xe0RV+0zMM3Opi+psw7yYgnL3YTeS8trYf+FKOFj/luBr0cAqGbXlp
 jsWJidcuiFj2ykdB/XQPsI6sHXens2BeLpEmc8p7yD1XOqhzUtLj3cA2ohUBdE9z3wII
 qVY2QtkgGvp4FQsIwDf1KQVMAF9x4Jv259IL/p6K+/DgW2qAyHiOnaCNyKE4tAvMaO2G
 jopeCFvJckeQDQJis9GIeay5bWdcScipVeaj/bhgCmlPp5t0P6EXX4GsZ2mWtd4tN7H8
 Ftqw==
X-Gm-Message-State: AOJu0YzlCqI2t8xyP/IdU6uQiiwF4L8J9h234BZLAQdK1TChvGUKLz1Z
 7GKpiZVqEviy0dhtXLnx0DzSh/i5FO4WZ8q4WmApaZ/2DqUy5c3tHbBno06aQ8fBVd8=
X-Gm-Gg: ASbGnct0R6MgqW7IimM/99BFO6cCMXyi636hFG6PPZOSCwlk29GpX5V2xM1m0Wa+MEh
 QiDuhko/cyLKJ+RgW0+Q0s89yJoAW2HLRyKhueMkeVi/EmCr12s7r4oULfwiq/k9/aBZmDQidfy
 ROK5WzdRQTtQKJcQSC3ixPIxDaEtZ6gR2eLOiDoyxI3XUgUzOLZz6jTTlthi/DsZruwRp+kY0Bd
 XeG5xYxqWONLDmyeyES4q4ovapIO7aJbf+UY+JhornS03dR56J+tDQ1lBaM0rek/3fEaD3VhzSY
 zHH9XG+P8URVwKvPsKi6Ul/XttrWqryydPbGilQFekG+RtXM7AQFJL/FRhsPbpI=
X-Google-Smtp-Source: AGHT+IHrT3ukRtwwsENtscbj4rHU5IZQnyJ0sLWmvh2ub5t9vsmLvMngN2Db0arm4Ovb0vkpET59Sw==
X-Received: by 2002:a05:620a:6609:b0:7c9:2465:8731 with SMTP id
 af79cd13be357-7cd4608d11emr311295485a.0.1747426744654; 
 Fri, 16 May 2025 13:19:04 -0700 (PDT)
Received: from localhost.unh.edu ([2606:4100:3880:1271:e2f8:4ec3:8bf3:864c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467d93d5sm159673685a.31.2025.05.16.13.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 13:19:04 -0700 (PDT)
From: Nicholas Pratte <npratte@iol.unh.edu>
To: stephen@networkplumber.org, dmarx@iol.unh.edu, luca.vizzarro@arm.com,
 paul.szczepanek@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, thomas@monjalon.net, thomas.wilks@arm.com,
 probb@iol.unh.edu
Cc: dev@dpdk.org,
	Nicholas Pratte <npratte@iol.unh.edu>
Subject: [RFC v2 3/6] dts: add asynchronous support to ssh sessions.
Date: Fri, 16 May 2025 16:18:31 -0400
Message-ID: <20250516201834.626206-4-npratte@iol.unh.edu>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250516201834.626206-1-npratte@iol.unh.edu>
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20250516201834.626206-1-npratte@iol.unh.edu>
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
 dts/framework/remote_session/ssh_session.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/dts/framework/remote_session/ssh_session.py b/dts/framework/remote_session/ssh_session.py
index e6e4704bc2..e7d8b9cf53 100644
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
@@ -99,6 +100,19 @@ def _send_command(self, command: str, timeout: float, env: dict | None) -> Comma
 
         return CommandResult(self.name, command, output.stdout, output.stderr, output.return_code)
 
+    def _send_async_command(self, command: str, timeout: float, env: dict | None) -> Promise:
+        try:
+            promise = self.session.run(
+                command, env=env, warn=True, hide=True, timeout=timeout, asynchronous=True
+            )
+            return promise
+        except (UnexpectedExit, ThreadException) as e:
+            self._logger.exception(e)
+            raise SSHSessionDeadError(self.hostname) from e
+        except CommandTimedOut as e:
+            self._logger.exception(e)
+            raise SSHTimeoutError(command) from e
+
     def is_alive(self) -> bool:
         """Overrides :meth:`~.remote_session.RemoteSession.is_alive`."""
         return self.session.is_connected
-- 
2.47.1

