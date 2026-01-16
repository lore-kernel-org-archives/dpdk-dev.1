Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99ADBC982C0
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 21:17:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3ADA42EA8;
	Fri, 16 Jan 2026 22:17:06 +0100 (CET)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45]) by mails.dpdk.org (Postfix) with ESMTP id 32CFC42E65
 for <dev@dpdk.org>; Fri, 16 Jan 2026 22:17:05 +0100 (CET)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6505cac9879so4009443a12.1
 for <dev@dpdk.org>; Fri, 16 Jan 2026 13:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768598225;
 x=1769203025; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X2XtiwM0G0Xv2bO6gZsOo2UvfSQuQHYpGwjYee87MGE=;
 b=HSfq8Pct0taXtyPzZZC88eqWrU1IDseQtTBShD5rIU6RRv+VUHwLIRnLKD/KpR2tzj
 HiwrQVgfIKayOIHdGuniW+1dm4RbAPvW07jFvKVehueqkNShI1RKec/RsvwTkFkB35lA
 CAZmV1+b8SYDfvyuhhsGwGiDjv1x+/yobk1g/TfGZcHEe6RaY/KZaxcNy48Tcggb5tDh
 scE9V5di/1NPvQsgdMryTmlLdGgW/9gIL5E9D9jntTUmr7i0xL9aF5Bxb1uVY1oyvLx1
 ayNlpX2l9HBIP/+GinPCY8eQKyU7xpy4jY1/CWrou0O2kKdIvplHGprrBkFzGqvCFOST
 p8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768598225; x=1769203025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X2XtiwM0G0Xv2bO6gZsOo2UvfSQuQHYpGwjYee87MGE=;
 b=SBMWgdecpN2z9RUGkDtdypztoNfJ9d2KKGv5gh+kAG3Z/KNRrjpdcuVNJpBcOsCKY3
 QELgs+JM5Ye0tNsr+7r7BK4rDokioigCjJNNQLnhqFs1NCiYM0qhPsIm99ksig1teWXE
 cX/QuaqeTTUUXT6eTMteExMAlwSeFRdwiVHchIUWxkWDcFHvmGaL4rXF+ze3zHqb2aNv
 4CVimYIoqvHquSLBMaoxg+pAn0ESIr2CRctBeLfX5JtUQ9ee3aiqj8nxeXLnrj76C/3c
 j7R4MA32qzVj8dua/xl64GPwvBJjrUeSqDKQLofzYhvwSmn7gYk96P0pnGMhjeu/TQ+D
 j/nw==
X-Gm-Message-State: AOJu0YwCqv5FWos05aXY6k1PyZDOzEkEbZ7qREbeJC8H6dv0qgKqQLLA
 XO5C9TDdEzDUerBIm/w4vcxbnWCtgMbHz7INRNVZC6pWiWlkUL1/0Q4flTABovOkNsAGjMvEfKn
 dNU7n
X-Gm-Gg: AY/fxX7EK2/KrzklW5tf10T5llmPO5b/uttIcvDE7cB/CSIftXPzaf9EvkmKRGhDAjM
 STHluSONaNUXnDeKGqwFVDSi2orzTMcsVAd2oitVNkedBPP7HkiWIPV46pqc9mUI71trUAlPHpz
 H1AHU9Xr5Y7erVa8XXce7yGl6X/KfEruaN1I8GEin+QD35BIbQ51Ht55+4ntWal4UM37eck4JzI
 bc9v1GTrJgFBsZDd5QmK0fpHRgheQmW9WPNkrN6wiew9B1qpCoXlz5CXaVUN/WOcjUgdN2q7njg
 AF4QGG3PqtsZcN+wJZumR302CdnOKpsATBAvKCuNatUhX0XPDGtnQVp/JJdVeee0CFkEcBhnFWA
 Rmym+YBD19Ydtu2liidf1CVutes4l0WASKw46ZHC7Hnbp0LZKdESACljlC5VE5xmUbx3tR1NwAS
 arMmk197kvL7rxAAsVufO+nqBKQ0akrXYEIWsBxh7ArQ0eb5fV7A==
X-Received: by 2002:a17:907:1b08:b0:b87:2b69:89ce with SMTP id
 a640c23a62f3a-b8793024235mr368398966b.63.1768598224736; 
 Fri, 16 Jan 2026 13:17:04 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795168ca9sm336649066b.15.2026.01.16.13.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 13:17:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 04/11] doc: correct grammar in sample applications guide
Date: Fri, 16 Jan 2026 13:06:20 -0800
Message-ID: <20260116211649.104776-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116211649.104776-1-stephen@networkplumber.org>
References: <20260116211649.104776-1-stephen@networkplumber.org>
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

Change "detail" to "details" for plural form.
Capitalize sentence-initial "refer" to "Refer".
Change "by be" to "may be" (typo).
Clarify coredump_filter default value notation as "0x33".

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/linux_gsg/build_sample_apps.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/guides/linux_gsg/build_sample_apps.rst b/doc/guides/linux_gsg/build_sample_apps.rst
index cae17f0e33..5195af67ad 100644
--- a/doc/guides/linux_gsg/build_sample_apps.rst
+++ b/doc/guides/linux_gsg/build_sample_apps.rst
@@ -10,7 +10,7 @@ It also provides a pointer to where sample applications are stored.
 Compiling a Sample Application
 ------------------------------
 
-Please refer to :ref:`building_app_using_installed_dpdk` for detail on compiling sample apps.
+Please refer to :ref:`building_app_using_installed_dpdk` for details on compiling sample apps.
 
 Running a Sample Application
 ----------------------------
@@ -24,7 +24,7 @@ Running a Sample Application
     - In case needed, ports being used by the application should be
       bound to the corresponding kernel driver.
 
-    refer to :ref:`linux_gsg_linux_drivers` for more details.
+    Refer to :ref:`linux_gsg_linux_drivers` for more details.
 
 The application is linked with the DPDK target environment's Environmental Abstraction Layer (EAL) library,
 which provides some options that are generic to every DPDK application.
@@ -85,7 +85,7 @@ The reason is as follows.
 Suppose the system has 1024 reserved 2 MB pages in socket 0 and 1024 in socket 1.
 If the user requests 128 MB of memory, the 64 pages may not match the constraints:
 
-*   The hugepage memory by be given to the application by the kernel in socket 1 only.
+*   The hugepage memory may be given to the application by the kernel in socket 1 only.
     In this case, if the application attempts to create an object, such as a ring or memory pool in socket 0, it fails.
     To avoid this issue, it is recommended that the ``--numa-mem`` option be used instead of the ``-m`` option.
 
@@ -100,7 +100,7 @@ No memory will be reserved on any CPU socket that is not explicitly referenced,
 If the DPDK cannot allocate enough memory on each socket, the EAL initialization fails.
 
 Whether hugepages are included in core dump is controlled by ``/proc/<pid>/coredump_filter``.
-It is ``33`` (hexadecimal) by default, which means that hugepages are excluded from core dump.
+The default value is ``0x33``, which means that hugepages are excluded from core dump.
 This setting is per-process and is inherited.
 Refer to ``core(5)`` for details.
 To include mapped hugepages in core dump, set bit 6 (``0x40``) in the parent process
-- 
2.51.0

