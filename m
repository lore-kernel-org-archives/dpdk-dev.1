Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9249BC36002
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Apr 2025 03:54:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E63C402EF;
	Wed,  9 Apr 2025 05:54:21 +0200 (CEST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id 491A3402EF
 for <dev@dpdk.org>; Wed,  9 Apr 2025 05:54:20 +0200 (CEST)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-7340e6f3ce1so4954362b3a.0
 for <dev@dpdk.org>; Tue, 08 Apr 2025 20:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744170859;
 x=1744775659; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wKaJbR9uz2L7s1QBfIHx6bOgFoMx1nvhdKsDqO/EA2s=;
 b=TtydMc20AAElCClrePpWC6bkAiUXHC/1FIJ3kVPtvV1ku6Q60roYO4hmejbHBxJGP0
 ak9tUjBhJw9wdIy7sIhQ+e7lKEL55nr00kiTW5MoyVSUdGm7/ATS55QUmaws5VZeevQh
 niV1Bcp387nkrryLT8rRdvFqtlESiSS+2YiuDko/JG+/oHJphrIjUP+2j8cCNXqeD4QP
 fTFUZd1Pd0ERx8DY6jmEUjz4u+ikYpvjuZOdN495EEKDOxJxHBQCduE5QL7CIOwJlNqf
 vQJA20FaQE6KzWmJ/djKY9k321VkpXh5BXCisPEpBJ52msEq/GkhSxaVluyCQe7bdb/C
 f+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744170859; x=1744775659;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wKaJbR9uz2L7s1QBfIHx6bOgFoMx1nvhdKsDqO/EA2s=;
 b=f/gZZF8n+s+g+x1TpWMz7kNtRt/EfDdSo+W1c8pnUpKw7piuaeNSM/vb6JGO7rcFM4
 10UeTMdBnuE1NGXWLhzZBZaGqNjdGb7v3Pi3yDAVtEioHl5l6ue2gZVDdOzo4d/dn/rQ
 CTOqA6UqmVD2OcX/0C6D0qvtJD/GeMYOWM5n8R27YOeXn1zyXkhriH++KYtReKmY3HwU
 HzhGtYIynRO80eh3g7N9ishjEEfrH5J7Tq3pbjAzB4K8o7FWTtAqQ0EHNnH2aEZ/zzwP
 zKmP+XQK5tfS9XMgLvPksV+/eOml6yJDfsz0TWq4B6SpmNpUw5HUSvaW6hDiso6+zfgx
 ebPw==
X-Gm-Message-State: AOJu0Yyftof/5p2PdvjMQ4Zp7K3AvPozPau/jGosJOyjM0/b6vj5Ml/M
 3J6XIFhW2UK8GtwoZB8FXReGyheqhh7HPFHc+MkyGOfpnGo3s7BiR5WenyfqqTmOHvIlML6yK+f
 6
X-Gm-Gg: ASbGncvqgcF0ORtC2/O6PbJQqtpNKEYZ9TXzJMsMbJH/HS3k/5hE70zZdUy+7C2QRNf
 LaFuHN61+/fEa6hG5ukhEWqUxTsA889SINWKvE52gdxRFWPFjh4wl4qZHussiMMnpehVMwHJsys
 IWUwSIH2Xg9UYBM5FmAo3uHVRonJuWujrt/trea02vNPkml2PagLh27O3h1hiAdjH1dUNgvJns+
 pZ0ErutUez/rA2PJ6D1bZkCn4u4nBkho+NcPnS+o5k/M612ejSuPFJsPpwlODI/fnF44LgdMitY
 0SSDVuBykybN/Eip6U4nyOwOnhKZf1PJ4mYOqQ2MRIiCFVV1oW531bAtH0GxOnSN13fbjhCs15H
 VJk0zHe5b2KUV1pnMAo9O
X-Google-Smtp-Source: AGHT+IFWR82C6YmiBHHdLCo3NUR2cXxlvh9GYElxR3Dd2QN9MavKk2tby2F9z9UM/o5KYnkOt2ikJw==
X-Received: by 2002:a05:6a00:230d:b0:736:54c9:df2c with SMTP id
 d2e1a72fcca58-73bafd44c55mr909268b3a.15.1744170859233; 
 Tue, 08 Apr 2025 20:54:19 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bb1e4f85csm205221b3a.132.2025.04.08.20.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 20:54:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH] doc: update kernel version requirement
Date: Tue,  8 Apr 2025 20:50:07 -0700
Message-ID: <20250409035408.199320-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The 4.19 kernel version was end of life in December 2024.
Update to 5.4 and also add better description of what "not supported"
means in this case.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 doc/guides/linux_gsg/sys_reqs.rst | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/doc/guides/linux_gsg/sys_reqs.rst b/doc/guides/linux_gsg/sys_reqs.rst
index 5a7d9e4a43..cab198134b 100644
--- a/doc/guides/linux_gsg/sys_reqs.rst
+++ b/doc/guides/linux_gsg/sys_reqs.rst
@@ -105,11 +105,18 @@ System Software
 
 **Required:**
 
-*   Kernel version >= 4.19
-
-    The kernel version required is based on the oldest long term stable kernel available
-    at kernel.org when the DPDK version is in development.
-    Compatibility for recent distribution kernels will be kept, notably RHEL/CentOS 7.
+*   Kernel version >= 5.4
+
+    The Linux userspace API is compatible across releases but there are some
+    restrictions. The oldest kernel tested by the DPDK testing infrastructure
+    is the oldest maintained Long Term Stable (LTS) at time of release.
+    The DPDK is likely to still work with older releases but it is not guaranteed.
+    Compatibility for recent distribution kernels will be kept, notably RHEL, and Ubuntu.
+    It may work on older distributions, past End Of Life (EOL) like RHEL7
+    but this is no longer tested or guaranteed to work.
+
+    Some drivers and hardware support may require more recent kernels, check the
+    documentation (e.g. :doc:`../nics/index`)
 
     The kernel version in use can be checked using the command::
 
-- 
2.47.2

