Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E35C021A0
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Feb 2025 19:06:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CAB040A72;
	Sat, 15 Feb 2025 20:05:58 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 0534A40041
 for <dev@dpdk.org>; Sat, 15 Feb 2025 20:05:56 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-22104c4de96so11683165ad.3
 for <dev@dpdk.org>; Sat, 15 Feb 2025 11:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739646356;
 x=1740251156; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ffKczJG6hKpCHkTw06hZA2REmjkVAttDOD3/hrk5+GU=;
 b=wonq1WknwMvD4suro2u5OAOSGCTs5J+xMeV5JwW6TE9kUlXNTluRceRO+hOrgWlx+K
 Qaxk+dVlUbPS8Wn8qVV75/1kDOgO7QvYu7ZbaVSN2wpTvOa3vTSeNMfjJtyv3FHDYfhd
 BSKFXeykwaM3B9/jPS3tYW6mPPc+VSk17IAQK86TYnQJlIPyxKN3xjK9H7g11SEKA5AD
 mxGWtsTpZ56qTVAN8RpVsBEPFy+cf4zGz2OCR55In0dwzBBmBVcIC1mzyLK1mH4NjLwa
 X9t7bSVtjoVU4aOwP+eiAFsFmqHQIaAOF1ia8sOR61NrCZM4YCVQgz2GCKXgDbGjNCKa
 nJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739646356; x=1740251156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ffKczJG6hKpCHkTw06hZA2REmjkVAttDOD3/hrk5+GU=;
 b=P+WH2rA/dMg2r+HieZe9+ErnQeZxtp/HwhnVgTJ+2lDfvH294tJfogkLtBhHB6Yx6P
 TZYXlpsK33DVjkwBw0gRFruN/NlxNKUA7v+2WKsMsthBhsBSLFnz2CGr6AjbfL7h9kxv
 4qkfy8a5YempC+O0Fhz9B+L2iZq25Y4efVpUhW1w3NPTWjpkmXF5z/H8SxLDvSbLSF26
 LkC6cW0QblIiJhW70L3aOB4tywvCvFFS/Iy7zURLw13grCKz+TTKHyPUdO5v37CWGdQw
 9WruLIdKH/uewybDNnxcgBs9pevn6aYeN4HW/Dnk+i1DYYLapp9YcLJnHQVtwYaxC6Hp
 dC4w==
X-Gm-Message-State: AOJu0YxrNxxAd00YUQY2cpE+lnHBtkfZ2b8vkhJs4BVp/z3T/NW0nlf3
 hFbsy6N9936cTsUwkYLxaAsDYoJSqKU3sGJigl60PML9s/DuZdTy2LsWY3YJsLNbCLnPflnvrCf
 I
X-Gm-Gg: ASbGncu1mdODvFC5U3RJaR0NfuqFoMYuG1HitG6OT7mP+VMec+/St/B6fWH35C3s/U7
 oYZ6SQ/TYfIHhXileOORsHfAGa6AQQV0jnWkJoi3Ywp4aaFI24z64ZMy+7PEPKv1jzE3JQivbZJ
 hJPMQT47fjR/mJ7JSVc/hGgUAsok5ffhI6QXf4U9mvTvZlPwDVS+A7WAJkPv+q6RmU+d87pI3H1
 U9lW613PXHPB37eJC9VvJ0DWkGRTpFnRsmtif/Zu4jXH+uRIddYmUY17vYN1JnCM3jGYUIW1WxN
 zmb5THfYKhwyi67045GxM1Ps8qmBdd4rZTBo21YMlEs4ZWEnWjnQDMr+A0s6w6D5nmet
X-Google-Smtp-Source: AGHT+IEeVHcIdJ82/uwsL5sUPIKjhFpz6XmeU6BJkqPXKMVxj/aiT+bUepiT80w706qvZ4oHFSvn0w==
X-Received: by 2002:a05:6a00:8686:b0:732:622e:d444 with SMTP id
 d2e1a72fcca58-732622ee41cmr5102355b3a.2.1739646356138; 
 Sat, 15 Feb 2025 11:05:56 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324254685csm5080179b3a.4.2025.02.15.11.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 11:05:55 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v7 01/16] eal: introduce new secure memory zero
Date: Sat, 15 Feb 2025 11:04:29 -0800
Message-ID: <20250215190544.988310-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250215190544.988310-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250215190544.988310-1-stephen@networkplumber.org>
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

When memset() is used before a release function such as free,
the compiler if allowed to optimize the memset away under
the as-if rules. This is normally ok, but in certain cases such
as passwords or security keys it is problematic.

Introduce a DPDK wrapper which uses the bzero_explicit function
or SecureZeroMemory on Windows.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_string_fns.c | 15 +++++++++++++++
 lib/eal/include/rte_string_fns.h       | 19 +++++++++++++++++++
 lib/eal/version.map                    |  3 +++
 3 files changed, 37 insertions(+)

diff --git a/lib/eal/common/eal_common_string_fns.c b/lib/eal/common/eal_common_string_fns.c
index 9ca2045b18..af9efc1bf2 100644
--- a/lib/eal/common/eal_common_string_fns.c
+++ b/lib/eal/common/eal_common_string_fns.c
@@ -7,9 +7,14 @@
 #include <stdio.h>
 #include <stdlib.h>
 
+
 #include <rte_string_fns.h>
 #include <rte_errno.h>
 
+#ifdef RTE_EXEC_ENV_WINDOWS
+#include <rte_windows.h>
+#endif
+
 /* split string into tokens */
 int
 rte_strsplit(char *string, int stringlen,
@@ -98,3 +103,13 @@ rte_str_to_size(const char *str)
 	}
 	return size;
 }
+
+void
+rte_memzero_explicit(void *dst, size_t sz)
+{
+#ifdef RTE_EXEC_ENV_WINDOWS
+	SecureZeroMemory(dst, sz);
+#else
+	explicit_bzero(dst, sz);
+#endif
+}
diff --git a/lib/eal/include/rte_string_fns.h b/lib/eal/include/rte_string_fns.h
index 702bd81251..d83b346158 100644
--- a/lib/eal/include/rte_string_fns.h
+++ b/lib/eal/include/rte_string_fns.h
@@ -15,6 +15,7 @@
 #include <stdio.h>
 #include <string.h>
 
+#include <rte_atomic.h>
 #include <rte_common.h>
 #include <rte_compat.h>
 
@@ -149,6 +150,24 @@ rte_str_skip_leading_spaces(const char *src)
 	return p;
 }
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Fill memory with zero's (e.g. sensitive keys).
+ * Normally using memset() is fine, but in cases where clearing out local data
+ * before going out of scope is required, use rte_memzero_explicit() instead
+ * to prevent the compiler from optimizing away the zeroing operation.
+ *
+ * @param dst
+ *   target buffer
+ * @param sz
+ *   number of bytes to fill
+ */
+__rte_experimental
+void
+rte_memzero_explicit(void *dst, size_t sz);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/eal/version.map b/lib/eal/version.map
index a20c713eb1..82a3e91c97 100644
--- a/lib/eal/version.map
+++ b/lib/eal/version.map
@@ -398,6 +398,9 @@ EXPERIMENTAL {
 	# added in 24.11
 	rte_bitset_to_str;
 	rte_lcore_var_alloc;
+
+	# added in 25.03
+	rte_memzero_explicit;
 };
 
 INTERNAL {
-- 
2.47.2

