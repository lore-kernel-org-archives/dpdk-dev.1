Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B2CFCC9AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 02:51:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA54A40E17;
	Tue, 10 Mar 2026 03:49:54 +0100 (CET)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
 [209.85.210.51]) by mails.dpdk.org (Postfix) with ESMTP id A04214014F
 for <dev@dpdk.org>; Tue, 10 Mar 2026 03:49:49 +0100 (CET)
Received: by mail-ot1-f51.google.com with SMTP id
 46e09a7af769-7d741f61ee5so1705223a34.1
 for <dev@dpdk.org>; Mon, 09 Mar 2026 19:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773110989;
 x=1773715789; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7IkUl/0NLxrFpIz53KeZT2r+t1cZtUzoYXS3/PCXg6I=;
 b=JE6QpSb8w39+sSG22XuxDzVO6QVVRfrakUktBENEpqwRf1OnZERtyVYkCDvcNIXH4P
 0ENAFePnmyniXi9IHcTCjNyGGqArCjyUDr4vXcjrlxCIYc1rGXvHn0zsuUN/adXpO646
 QivjJFHrz4Jn0rp8+4NyfjKErZGFwaWq+zBk2F38xqMpFFKtxkoPE6YWrhMEHiMmW7yd
 FFk/VWncvUt6Ol/2YdUVbT3jct+gR5X/A2W3Hqh1Vf+t46hYHpzEc0JDms8QectxbZhp
 qly++H/JQCbjHtDoEoEF1J5TNkQnfWtnUU1a5tH4yR12L69YCCcmp4DwpoCzLi0+zSa3
 1v/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773110989; x=1773715789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7IkUl/0NLxrFpIz53KeZT2r+t1cZtUzoYXS3/PCXg6I=;
 b=HboYDjcVjGnlQSbT3+zDL00rsF13c9YK0W0lCnuRL4XJIuOY7l5PL70dpj5/5nVd+V
 qjZ10ayW9dX7cJQCSH2Dwc9ZkBdohqRPDePFnUfNCzgRNPTi3An2T4Jl3zLKXiucOsWj
 WI3YZTKVzE5SJmvGNA/QWL466XQfXhZgIC4gP//UieLYU+9uqer94A5T/FxBMflR/yq8
 JXs8hyUn1xHMxCY+stUMTRP9R0kG+OpA9rcEiOGDU/ZFZpPMu7K17Qd8+Ch+1DWFJw3L
 XZJl0vCQEGASu/Y3Mal1JrZOWYX6ZlxBbVzhq3fAPmWfaHRdsvzeHx/8DtpfHh/q4ABz
 tHnw==
X-Gm-Message-State: AOJu0YxQIrvwR+Ja2ujHHSTxmFLERzQdsTCpkOIffqBm3kiKCwgB175M
 +9DNyQcvSoLu6d5H6SaoO3wD2rZOKd6a9wuPdupgR3/8M6ZMzcnOJNhI001t88VE2QYBdPS8j4D
 s5/iiQyU=
X-Gm-Gg: ATEYQzzJKU1k1bJlnc6KZGE4ARWkTCy8n+cXKYSWRSIdSDsR2ykaLpOUPgAyXhs7W+c
 jMJoIE/YVvwDYXPjS3++59MLPY0RAHB8+A/vE0VyszN15O/P9udte5wiXce0wl7ZaIztYn1Vagl
 JsdIduvEMbLCKpvvEnE92znX1ycgLgV9C57hhOpoXngqXFQ++ezziZ4oa7Fr5UNDuvnkz3QPVoq
 vrdMrTfIQimW3ZE5DnhyhPPsgqHj9jDpDX3W503wlhPlC9HNv/jnSbBKT1eQlq2ZC78izlqwWSo
 /332PiGyyqP/WzhMcqvkpCCmymQzJqpm94gUCLc8ZHKKMiwSEUYeNm40ndW/PhkZil75MRYFUp7
 G/8N5cLB5kAjT+jO2knzkCC05jLX/Oj6km3JzEzX4f3i3OtSE75KRIf67RWjHQzp4NWlO/xdNw3
 bt/ltEzTfItfD7M/DKjykHglANrT7wiVBD
X-Received: by 2002:a05:6830:2091:b0:7d7:39a9:4c32 with SMTP id
 46e09a7af769-7d739a94ef1mr4362604a34.3.1773110988933; 
 Mon, 09 Mar 2026 19:49:48 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728d1238csm7808572a34.15.2026.03.09.19.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 19:49:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v19 19/25] eal/windows: add wrapper for access function
Date: Mon,  9 Mar 2026 19:47:54 -0700
Message-ID: <20260310024925.476543-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310024925.476543-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310024925.476543-1-stephen@networkplumber.org>
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

Like other Posix functions in unistd.h add wrapper
using the Windows equivalent.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/windows/include/rte_os_shim.h | 1 +
 lib/eal/windows/include/unistd.h      | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/lib/eal/windows/include/rte_os_shim.h b/lib/eal/windows/include/rte_os_shim.h
index f16b2230c8..44664a5062 100644
--- a/lib/eal/windows/include/rte_os_shim.h
+++ b/lib/eal/windows/include/rte_os_shim.h
@@ -33,6 +33,7 @@
 #define unlink(path) _unlink(path)
 #define fileno(f) _fileno(f)
 #define isatty(fd) _isatty(fd)
+#define access(path, mode) _access(path, mode)
 
 #define IPVERSION	4
 
diff --git a/lib/eal/windows/include/unistd.h b/lib/eal/windows/include/unistd.h
index 78150c6480..f95888f4e1 100644
--- a/lib/eal/windows/include/unistd.h
+++ b/lib/eal/windows/include/unistd.h
@@ -23,4 +23,11 @@
 #define STDERR_FILENO _fileno(stderr)
 #endif
 
+/* Mode values for the _access() function.  */
+#ifndef F_OK
+#define	F_OK		0	/* test for existence of file */
+#define	W_OK		0x02	/* test for write permission */
+#define	R_OK		0x04	/* test for read permission */
+#endif
+
 #endif /* _UNISTD_H_ */
-- 
2.51.0

