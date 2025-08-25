Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159EECA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:42:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEBF140608;
	Mon, 25 Aug 2025 05:41:53 +0200 (CEST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id D42B5402E7
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:41:45 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-45a1b04f8b5so23956195e9.1
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093305;
 x=1756698105; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KfleNHUAX9uYm3Z2nidrTZyWX8Cjkbds8wosyzkFBLE=;
 b=ZgbAlv1k7NusNEuJ3r0/dwseQ9//lQ5p/r11tJZ66YiBkTpKlNPR6Hbwyw/WQ3HXq4
 /tbyCAjX3PbpjrSST4h4EGAgNL+fBBCTQ5ZWvfvLjLj6H4j+XbsUbm7NkqhQYtV+nkSJ
 NL35gkKYl0jYcfXihSMDeVK5D6X5WI3+YY+F2pAFRvMv5vylZOYSl1w5nDu23S9BR2Yn
 b9GdRTUKFC/4N/42sByMG8eH6pKHSKQuIRU8C90F9n74W9SAQUNVafHrqy3bA3v3shCh
 GkUAI4VHGGuTX6cmgluvAF+hfMye9cm2R5J7AUGXYb0sSlTIOvotGlMJUR2H7BnJ8Vve
 nbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093305; x=1756698105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KfleNHUAX9uYm3Z2nidrTZyWX8Cjkbds8wosyzkFBLE=;
 b=YC7OHqvcyrTXmqcSycafZIWai0BwxX12Ijs40rFCQJZwVixHd4WKUpzSpZ79X7O/T4
 Q/WqAes9X6obi7Hh2dXvX6BKwJ9GsKMRksq+gVV4M69T4U3jDDwjTBXIp3G9d1UlGWJG
 rbmTxnxhiNkuAYxDrceTElkU8KaUctI3s+TAO53cLQPLifNGqqNz9qNdxm6tW2o5RBhi
 p+2Zy5LXB6clQ97uyb5rjg0m+JiCC8Xq8ypoSg0AxrSmo6gr4Za4fTpJGC7hqbNpl/5A
 kZAUqmgiogLwgswyQcOKb6Yf4H4Sze2MSpmHgshbEsjt4g7v7RC/2nuTmg5B+V2z77wj
 qPUQ==
X-Gm-Message-State: AOJu0Yy6sKnkZX8SzlhkW/nZuxGzPHy0I009aAiu8wvlVODkvt2wOdPL
 cSf7AjjIrznHIDiWa/cqkVRssXhrIXsxB0q1daDj5qcWNUwMfHXw7+TkxkKsljQXMVei9sAxDMd
 o5aWE
X-Gm-Gg: ASbGnctmZe9PlTmzPIjQPxmjAx54NMBbtV1dx/BIwNJNQmTv3XKBsgOK2+lWGgPS1ba
 m/zRd/lmfdvF8WllhR1WumCaky9YoDzIYUzdQQxKKYtO3g3zu3zfY6HNgwxE4g9NAFda6Z5PVwa
 Ya+mXgU7ew+ALNLdMsnG7SzLT9Dhg54szqr/i7PBh2IREVycPvzUtWk7QC4Dt/VElkJ2MvgQ06x
 /SpRNQcYCgkBzblVYupXrEZgAilnuoyjCmorQwHIUfRKbBv5Kwzqg5ojn9Qj/Ykln6uIaea0YlU
 t+F4ISnqfJsI62YczbRh3X6c8+tRE5ufPAAuUHQQCuJTTLcobCgc1VxFAZVT6/OCaPzItpOZrb4
 V7ij4POi8HiJUte3k8peNY4rBhpVQdVITEUuPoOHnEHkW13iy8pd0hvBY2gWu2fmO/T30XZM6
X-Google-Smtp-Source: AGHT+IG/+fkzcBvsBQygKei8Nl55B6ky6HwXDRYdI2Qnz5cPjzb0lIo8U/lw8EhjKHdV+c5/3OkRxg==
X-Received: by 2002:a05:600c:45d0:b0:442:e9eb:1b48 with SMTP id
 5b1f17b1804b1-45b517ca4camr107872515e9.24.1756093305411; 
 Sun, 24 Aug 2025 20:41:45 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:41:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH v2 04/43] test-pipeline: remove unnecessary use of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:17 -0700
Message-ID: <20250825034126.12046-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825034126.12046-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250825034126.12046-1-stephen@networkplumber.org>
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

Not used directly here

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pipeline/config.c  | 1 -
 app/test-pipeline/init.c    | 1 -
 app/test-pipeline/main.c    | 1 -
 app/test-pipeline/runtime.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/app/test-pipeline/config.c b/app/test-pipeline/config.c
index daf838948b..61cf3a195c 100644
--- a/app/test-pipeline/config.c
+++ b/app/test-pipeline/config.c
@@ -8,7 +8,6 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
diff --git a/app/test-pipeline/init.c b/app/test-pipeline/init.c
index 558f0e428d..2ca32db39d 100644
--- a/app/test-pipeline/init.c
+++ b/app/test-pipeline/init.c
@@ -8,7 +8,6 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
diff --git a/app/test-pipeline/main.c b/app/test-pipeline/main.c
index 4cc098d7ac..dbc1e0d92d 100644
--- a/app/test-pipeline/main.c
+++ b/app/test-pipeline/main.c
@@ -8,7 +8,6 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
 #include <stdarg.h>
 #include <signal.h>
 #include <errno.h>
diff --git a/app/test-pipeline/runtime.c b/app/test-pipeline/runtime.c
index 752f783370..e1d9f8174e 100644
--- a/app/test-pipeline/runtime.c
+++ b/app/test-pipeline/runtime.c
@@ -8,7 +8,6 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
-- 
2.47.2

