Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3B4D3CC82
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:56:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E8A5427A4;
	Wed, 14 Jan 2026 23:56:10 +0100 (CET)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65]) by mails.dpdk.org (Postfix) with ESMTP id 7077042790
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:56:08 +0100 (CET)
Received: by mail-wm1-f65.google.com with SMTP id
 5b1f17b1804b1-47d5e021a53so2479295e9.3
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768431368;
 x=1769036168; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V4JEKXsJnsuvF4wlCgf6UWFFm7emZn6xqs58faKAvqI=;
 b=fcDyNx5awHoYaCsX6uXU2MYOSc3QxK5V4XJ7bbh9uJNg1SVnB9k/ffb3UhEzD5jcBr
 77PDcQWBwqF5VneytQD1QmqBJqlB2zd+1iaYBkIn/5JzDi/BRyFcXUJhKUeeJk7YyA42
 vSDWe6tLIMPBiYBWtpjunOJo0SjxgJWb0OCwWKLegA54C/qTcOiVypPfxQBK9QGtrg6W
 2CO6OqUGfNTHmAI6FJw8BLxPxvPUN5wmsTTxacGA0AIxqnw/n7HYA2pSfMeLf0CECAa4
 AzLoj3ENCzy4V+y9+opABWu7ORni1GKJwzEnmni8/eHH8vuII7clxuOlqQIk+e03Q18C
 Cxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768431368; x=1769036168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V4JEKXsJnsuvF4wlCgf6UWFFm7emZn6xqs58faKAvqI=;
 b=UDkXlK/vr5ck4NIvhRD6co2l4Ob7VUSoP73vK5eN73xtzr4zm8EIwsjAhiS3RrmqrB
 ov6cGl55UG3EvVCNCjQB/YmkxIX/0/LKHRl/mAOaFsl6TJMhxbWOXk1KNjlArswXmcRF
 Va0l+77D8n3Nz31W+Y5G5fJ2v8fKK6xtuA1JqmzXtpjYMou946umg+8xnyA51jACFca3
 zeLCDfVVFQNA+iCvcVO3JVtvjJ+57rmuuSJZRpap+fYWCZ8toc+QqGJYTvHtSQPVucmr
 hjsZ4wqig9X+QwZbMAjznZBLTPIf0AlWrF87qSrDEcrtFmGeRglPS/4w+yRmyzBIfjJ7
 yqBQ==
X-Gm-Message-State: AOJu0Yy4iKKRtS4+toCuNFZw0osV7H2BV/juDYb64QErpWwksPz0aE29
 er4aXLKxl0y9KGyDiMoZ4Qgq0PlJsKix5ftKlF8potFDeUQspwu/uSwpElWXmpgpVl3+0vqrHKd
 YbTgSMIw=
X-Gm-Gg: AY/fxX6ULp8PBH2UkuoNTugRX+9F9OmxMLw5K8yZbBQXey8paG+BcdtT9gLeib8Mflf
 c9g63hmEkpi3iLpR9yJFkYsns9Cga0GEqz+nPLS4WbeLc56cFwZr0X1zPv4+YHyXAQcO6C6e/C0
 AS2H0VPIw0womf50UxvNagEez6U1O9t1U7/fb1jLQzQoyyVlCP6kLs5waPDaDvAGJAPeGI6Ns0g
 dK0Nbl4h3i5twivSchpq19FVljLykwkT3SvCS1EqO3XAmDzTU/fVoyMBrqjtOocJdzPpzjyMk/A
 r68rrLdLOsTwkj2Fad+LJ9CAtNUyoIewKjFANRHJRlA6SIFf5u3cqvNtDG0bf5NlT78hK2DC0XG
 FlTZTZhxWUMaU4fuvtmRO2rBWp/nS9AIDl0bC+cajQXLsWKRqxWYJtCrBPi7JiOH9rQzU2d3O2p
 nc5ztkNYfvNPZeZUKs3nBK2IAezjOiZDCbdRQVVNYFVuxMgY8yhg==
X-Received: by 2002:a05:600c:8b2f:b0:479:3a86:dc1e with SMTP id
 5b1f17b1804b1-47ee4840941mr45309385e9.36.1768431368056; 
 Wed, 14 Jan 2026 14:56:08 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428af0c7sm12999125e9.4.2026.01.14.14.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:56:07 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH 05/11] doc: improve Linux uAPI header documentation
Date: Wed, 14 Jan 2026 14:54:09 -0800
Message-ID: <20260114225555.127448-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114225555.127448-1-stephen@networkplumber.org>
References: <20260114225555.127448-1-stephen@networkplumber.org>
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

Improve clarity of the Linux uAPI header documentation
- Converting passive voice to active voice
- Simplifying sentence structure
- Making instructions more direct
- Removing redundant wording

No technical content changes.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/contributing/linux_uapi.rst | 40 ++++++++++++--------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/doc/guides/contributing/linux_uapi.rst b/doc/guides/contributing/linux_uapi.rst
index a1bc0ba604..b28ebc4663 100644
--- a/doc/guides/contributing/linux_uapi.rst
+++ b/doc/guides/contributing/linux_uapi.rst
@@ -7,36 +7,34 @@ Linux uAPI header files
 Rationale
 ---------
 
-The system a DPDK library or driver is built on is not necessarily running the
-same Kernel version than the system that will run it.
-Importing Linux Kernel uAPI headers enable to build features that are not
-supported yet by the build system.
+The build system may run a different kernel version than the deployment target.
+To support features unavailable in the build system's kernel, import Linux kernel uAPI headers.
 
-For example, the build system runs upstream Kernel v5.19 and we would like to
-build a VDUSE application that will use VDUSE_IOTLB_GET_INFO ioctl() introduced
-in Linux Kernel v6.0.
+For example, if the build system runs upstream Kernel v5.19, but you need to build a VDUSE application
+that uses the VDUSE_IOTLB_GET_INFO ioctl introduced in Kernel v6.0, importing the relevant uAPI headers enables this.
+
+The Linux kernel's syscall license exception permits the inclusion of unmodified uAPI header files in such cases.
 
 `Linux Kernel licence exception regarding syscalls
 <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/LICENSES/exceptions/Linux-syscall-note>`_
-enable importing unmodified Linux Kernel uAPI header files.
+enables importing unmodified Linux Kernel uAPI header files.
 
 Importing or updating an uAPI header file
 -----------------------------------------
 
-In order to ensure the imported uAPI headers are both unmodified and from a
-released version of the linux Kernel, a helper script is made available and
-MUST be used.
+To ensure that imported uAPI headers are unmodified and sourced from an official Linux
+kernel release, a helper script is provided and must be used.
 Below is an example to import ``linux/vduse.h`` file from Linux ``v6.10``:
 
 .. code-block:: console
 
    devtools/linux-uapi.sh -i linux/vduse.h -u v6.10
 
-Once imported, the header files should be committed without any other change.
-Note that all the imported headers will be updated to the requested version.
+Once imported, commit header files without any modifications. Note that all imported
+headers are updated to match the specified kernel version.
 
-Updating imported headers to a newer released version should only be done on
-a need basis, it can be achieved using the same script:
+Perform updates to a newer released version only when necessary, using
+the same helper script.
 
 .. code-block:: console
 
@@ -44,8 +42,8 @@ a need basis, it can be achieved using the same script:
 
 The commit message should reflect why updating the headers is necessary.
 
-Once committed, user can check headers are valid by using the same Linux
-uAPI script using the check option:
+Once committed, check that headers are valid using the same Linux
+uAPI script with the check option:
 
 .. code-block:: console
 
@@ -60,13 +58,13 @@ Note that all the linux-uapi.sh script options can be combined. For example:
 Header inclusion into library or driver
 ---------------------------------------
 
-The library or driver willing to make use of imported uAPI headers needs to
-explicitly include the header file with ``uapi/`` prefix in C files.
+Libraries or drivers that rely on imported uAPI headers must explicitly include
+the relevant header using the ``uapi/`` prefix in their C source files.
 
 This inclusion must be done before any header external to DPDK is included,
-to prevent inclusion of this system uAPI header in any of those external headers.
+to prevent inclusion of the system uAPI header in any of those external headers.
 
-For example to include VDUSE uAPI:
+For example, to include VDUSE uAPI:
 
 .. code-block:: c
 
-- 
2.51.0

