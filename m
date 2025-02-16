Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E9DC021A6
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 17:01:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FDFC40E1D;
	Sun, 16 Feb 2025 18:01:27 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 99BDA40DD8
 for <dev@dpdk.org>; Sun, 16 Feb 2025 18:01:23 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-221206dbd7eso6874405ad.2
 for <dev@dpdk.org>; Sun, 16 Feb 2025 09:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739725283;
 x=1740330083; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rAR4ZctvgYZrv+iP1slYJzFPiuMnmFTGiePO9PNu9qQ=;
 b=MozkFSaF434G+IRzT4m41AJfG2JoWy/XUWhu0kvPjervNZ9qy6+/+NGJUtlhfyTstk
 k+J1tPIkf0SA6dAX6gg5rdGetF1ANsDGRyAr2v0AOcREOx/IFwbCKne9cxXUCbNluakg
 24L+1+DPfabgsY2F8qqgnts5Pq+muw+AQaGiSxRd0cUzzv52Ze5Eb31d8vxdraPuCcvR
 2ZDRxACOkMAI2KOs/ozAxXtXzYmYAwhUXBrPpAm03p9gOr3Mzsga+nz2upuqD0mupAfg
 FMadMp7QsbCvFmwqBhswONY+dJpwWXPeODbw+un6t1Y0kpvkcv81OSv2PpiY8f94gIzb
 9Szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739725283; x=1740330083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rAR4ZctvgYZrv+iP1slYJzFPiuMnmFTGiePO9PNu9qQ=;
 b=NMrn+sV7YGIltqYwg/kxuSq/3FBnAuq4iVBVOtVI9BqW2q4fGKEefMnpCsWNPACwcg
 R2oSOC+Lfh8u/9g/9eNGdtY717Zwq7ubzWgZG1FgINdw1rBBL1L8Z5BhRqJfMceEDOp+
 ZkfgWLNek9ACvBhXmFdO+bgNwdsgwVBfnxMa7KNNlhdrb2LBH/aODjl1BxSJRKRImuj1
 OMbDLgzYadqJu4Fk1I0O6Gjoa6JY+8vHaokY0VzH2H8t5EvG+SPWT4XHaHMQevjbiAUU
 CzFbdFyae66OB7Txh3BMClOu1Rh8ZbXutSISCdMSh4SG8eD550tQy+rnae3LMpEm9AHK
 KFGw==
X-Gm-Message-State: AOJu0Yws7UEEfRhEJ1w/jJqwt4gsCmsQLi7C81EDFYIGS4jF6u+A1O1V
 o5XHdccmzVpn/JtfVpldSOKYtfr1RfT95cyK6BKlHJhsTWj6jtpuSKXhG7Nw8p89Tu7RFw3syYg
 8
X-Gm-Gg: ASbGncvFkMns5bprlQFvjse7MNq/li0moTHWF0A0dIEsCmJ970s126WeniIgoDoMb/z
 Wl8yQhEXrSX7yHWWCIGA7NzyueXLrozd4EnXuj3hsPBxPbxGBm/GhhIwjwHqzODLicJHQjOvddt
 pVB8uoSO/D85di0LErUcll4GEi0eKSPn3GSaYHs3+f9MW1TE9sNfZf3sxYzZyKUIxHtMjkAzsV5
 Urx6DjYDh3/Nb+iPuaUpcXFhJInzxZhysFWoAfp1E6IZOGKZRpmFCDgnRbJZM+VPvgIU8H1b6GO
 s4TzoYraltENCZ4jClTIyNVMl3Ym/yfMpKax72wpsyrWE34AaT+0LNwR0DhFsW9VXcEV
X-Google-Smtp-Source: AGHT+IHIKxsmD5gUDOeHsFXfj8+CTuG2R2HMB3Ip3F4cgdknIWnzFg383yKWKqXUhzcKQ5gYNPpziQ==
X-Received: by 2002:a17:902:d58b:b0:220:c813:dfcb with SMTP id
 d9443c01a7336-2210408d75emr118805745ad.39.1739725282709; 
 Sun, 16 Feb 2025 09:01:22 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2211eafd20dsm11196805ad.182.2025.02.16.09.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 09:01:22 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v8 03/17] app/test: add test for rte_memzero_explicit
Date: Sun, 16 Feb 2025 08:53:02 -0800
Message-ID: <20250216170110.7230-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250216170110.7230-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250216170110.7230-1-stephen@networkplumber.org>
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

Add a new test for rte_memzero_explicit.
Test strategy is based of glibc bzero_explicit test which
is based off a test in the OpenBSD regression test suite.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_string_fns.c | 56 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/app/test/test_string_fns.c b/app/test/test_string_fns.c
index ce07c17228..b4fe3a7c30 100644
--- a/app/test/test_string_fns.c
+++ b/app/test/test_string_fns.c
@@ -8,6 +8,10 @@
 #include <errno.h>
 #include <string.h>
 
+#include <rte_debug.h>
+#include <rte_launch.h>
+#include <rte_lcore.h>
+#include <rte_random.h>
 #include <rte_string_fns.h>
 
 #include "test.h"
@@ -205,12 +209,64 @@ test_rte_str_skip_leading_spaces(void)
 	return 0;
 }
 
+/*
+ * This test does a variation of what OpenBSD regression suite does to test explicit bzero.
+ * One thread creates a buffer then zeros it but does not touch after that.
+ * Other thread checks that buffer has been cleared.
+ * A broken implementation would get optimized away.
+ */
+#define TEST_DATA_SIZE	123
+static int
+run_memzero_explicit(void *arg)
+{
+	uint8_t *data = arg;
+
+	for (unsigned int i = 0; i < TEST_DATA_SIZE; i++)
+		data[i] = rte_rand_max(256);
+
+	rte_memzero_explicit(data, TEST_DATA_SIZE);
+	return 0;
+}
+
+static unsigned int
+get_worker_lcore(void)
+{
+	unsigned int lcore_id = rte_get_next_lcore(-1, 1, 0);
+
+	/* avoid checkers (like Coverity) false positives */
+	RTE_VERIFY(lcore_id < RTE_MAX_LCORE);
+
+	return lcore_id;
+}
+
+static int
+test_rte_memzero_explicit(void)
+{
+	if (rte_lcore_count() < 2) {
+		printf("Need multiple cores to run memzero explicit test.\n");
+		return TEST_SKIPPED;
+	}
+
+	uint8_t test_data[TEST_DATA_SIZE] = { 1 };
+	unsigned int worker_lcore_id = get_worker_lcore();
+	int rc = rte_eal_remote_launch(run_memzero_explicit, test_data, worker_lcore_id);
+	TEST_ASSERT(rc == 0, "Worker thread launch failed");
+
+	rte_eal_mp_wait_lcore();
+
+	for (unsigned int i = 0; i < TEST_DATA_SIZE; i++)
+		TEST_ASSERT(test_data[i] == 0, "rte_memset_explicit did not zero");
+
+	return TEST_SUCCESS;
+}
+
 static struct unit_test_suite test_suite = {
 	.suite_name = "String functions tests",
 	.unit_test_cases = {
 		TEST_CASE(test_rte_strsplit),
 		TEST_CASE(test_rte_strlcat),
 		TEST_CASE(test_rte_str_skip_leading_spaces),
+		TEST_CASE(test_rte_memzero_explicit),
 		TEST_CASES_END()
 	}
 };
-- 
2.47.2

