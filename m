Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EC7FEE4F2
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Feb 2026 17:56:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DA0440DCE;
	Sat, 28 Feb 2026 18:56:08 +0100 (CET)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id 84C9340A80
 for <dev@dpdk.org>; Sat, 28 Feb 2026 18:56:06 +0100 (CET)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2ba895adfeaso2790103eec.0
 for <dev@dpdk.org>; Sat, 28 Feb 2026 09:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772301366;
 x=1772906166; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8i3R3t5iwtr9mNKgacA6fLmtsITMV5Cz5R0LrqR2h8A=;
 b=IpwLjgjOmKQhY83fOM0f8mpyfZS98eT2nHrUoYkO76bRANjqL63s2tAPwgXwOQqM7D
 BTSl3fs2rGuPgIrYOb7k9k93ZBYDq/eA351cyZfAnxdtU3lToZpWnV96sdBB86Ducbrc
 NlBtB4ga5EFOVWb6E54BglZR9RAToL+s4CoF2Eq2Y9Edk0+Ku5hG+fP1Q+rDIS7iXNXs
 SEbF1z214N6WcX1ct7Yn0q2Gh2YTUeczKK6R+tu3pxXC/e09784jOdCayzvYyVxcVb1Z
 eHSI+ohPIQXeUM6NWCZqvvuk2twkEqb3MTtjh76MASkXxEvGdForeV5S3ZC1+L70XYGa
 91jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772301366; x=1772906166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8i3R3t5iwtr9mNKgacA6fLmtsITMV5Cz5R0LrqR2h8A=;
 b=mjzZe8KLR7OU/wzyqEURL1QT1Lf4ir9ZtF8tpthKNgYqqIUJ8qTodlF/w6mIYa0v86
 Vxdys3Xd0mlYmMRhAy0SquHIg2cSGDlVMri11RjMampsR0pEG6SvAstRXgkbAfl/ZFHy
 GCrfm3jtswA8YCsdIjZMSW8SNs/PYhtOzmHeLFvX4zLFhP/oTSVl4upSvoAFdRFX68NL
 gT4WZYcOogMqoalWSrCgBfD3hRh5FwrMhtmk1sXidn42Plc0+tZjOVUluE+GlNCiyARf
 uBU+/JFYk8jwH5jWZdHZ3ZwqRjP12biOTszb9TP5sjcPgetmpb7+cFh8R4CJfY/KUhQW
 duMQ==
X-Gm-Message-State: AOJu0YwYmf2AgjFpb+U4c7Z1lOgPzUbrcYMUOf3IpmwvSWPB7pLy/ikK
 e6QXPc2VElYOEBgRaLuTbdFSYZLqQohLA5fh941PMrspQwbwVjW0KiwxpRUi5Ly5AQnWtSFtm9A
 UsO76
X-Gm-Gg: ATEYQzwI13ZCZUkSHRQpuuN6sQQahBwoaV32zAmXwwIlFzCOC2EAiFEXBlguHCpdNEu
 e39biTdooOcaMb4UfcaeT98+jo5DPQSxwI+PS2a33DhuLFKeFEBXdmG8L54/P7eiAfKw5lNjQzh
 zy7Pqz7r+r80P1FGoD7Aae7oBoV1j/NIAgYaP1R5em6GAXku1ik3vIdVuX5Y2qP7y+VlYJjtPQj
 f9pQdmOd/gXw6WiXQeY7lsm03+ROqQalk9216UnSK+cQbBW/F+TI6c8q3XkiH6HTi8Jz7b0icpC
 ADFIhbjyNzdTC/ltRP+qamqUxB+vTpAOXbhNZOzUIskO7cuVl6XijSosK1/0pmQjxs60aXS2Fg/
 R55DCY/erkSCn+Ski2zuiL8A787FjwsUFVwmJmvcUPF937BtFwmnvEPSrOY3ZF2sTVdNQMrE5Ww
 4baML2QWpmkkqyL1IiS+bgBPeDUfFGC69bignIxBbKyYO7UfaKFfs+AaiSQvfO3A==
X-Received: by 2002:a05:693c:2b08:b0:2ba:66fd:3705 with SMTP id
 5a478bee46e88-2bde1c3f0edmr2565746eec.1.1772301365409; 
 Sat, 28 Feb 2026 09:56:05 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdfb3f898asm824584eec.29.2026.02.28.09.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 09:56:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 2/5] test: use fixed time length for write packet test
Date: Sat, 28 Feb 2026 09:35:01 -0800
Message-ID: <20260228175601.585102-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228175601.585102-1-stephen@networkplumber.org>
References: <20260220184255.306368-1-stephen@networkplumber.org>
 <20260228175601.585102-1-stephen@networkplumber.org>
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

This test would take excessively long if the TSC frequency
was very low. Instead of scaling test by frequency, just
use a fixed time length for the test.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pcapng.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index f0faead728..af31e7d996 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -5,6 +5,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <time.h>
 
 #ifdef RTE_EXEC_ENV_WINDOWS
 #include <winsock2.h>
@@ -80,8 +81,16 @@ mkstemps(char *tmpl, int suffixlen)
 
 #define PCAPNG_TEST_DEBUG 0
 
+/*
+ * Want to write enough packets to exercise timestamp logic.
+ * On fast CPU's TSC wraps around 32 bits in 4 seconds.
+ */
 #define TOTAL_PACKETS	10000
-#define MAX_BURST	64
+#define MAX_BURST	32
+#define NUM_BURSTS	(TOTAL_PACKETS / MAX_BURST)
+#define TEST_TIME_SEC	4
+#define GAP_US		((TEST_TIME_SEC * US_PER_S) / NUM_BURSTS)
+
 #define DUMMY_MBUF_NUM	2
 
 static struct rte_mempool *mp;
@@ -242,6 +251,7 @@ fill_pcapng_file(rte_pcapng_t *pcapng)
 	struct rte_mbuf *orig;
 	unsigned int burst_size;
 	unsigned int count;
+	struct timespec start_time;
 	ssize_t len;
 	/*
 	 * These are some silly comments to test various lengths and alignments sprinkle
@@ -262,21 +272,22 @@ fill_pcapng_file(rte_pcapng_t *pcapng)
 		 "generations of example code. The magic number 32 is not documented because "
 		 "nobody remembers why. Trust the process."),
 	};
-	/* How many microseconds does it take TSC to wrap around 32 bits */
-	const unsigned wrap_us
-		= (US_PER_S * (uint64_t)UINT32_MAX) / rte_get_tsc_hz();
-
-	/* Want overall test to take to wraparound at least twice. */
-	const unsigned int avg_gap = (2 * wrap_us)
-		/ (TOTAL_PACKETS / (MAX_BURST / 2));
 
 	mbuf1_prepare(&mbfs);
 	orig  = &mbfs.mb[0];
 
+	clock_gettime(CLOCK_MONOTONIC, &start_time);
+
 	for (count = 0; count < TOTAL_PACKETS; count += burst_size) {
 		struct rte_mbuf *clones[MAX_BURST];
+		struct timespec now;
 		unsigned int i;
 
+		/* break off writing if test is taking too long */
+		clock_gettime(CLOCK_MONOTONIC, &now);
+		if (now.tv_sec >= start_time.tv_sec + TEST_TIME_SEC)
+			break;
+
 		/* put 1 .. MAX_BURST packets in one write call */
 		burst_size = rte_rand_max(MAX_BURST) + 1;
 		for (i = 0; i < burst_size; i++) {
@@ -309,7 +320,7 @@ fill_pcapng_file(rte_pcapng_t *pcapng)
 			return -1;
 		}
 
-		rte_delay_us_block(rte_rand_max(2 * avg_gap));
+		rte_delay_us_block(rte_rand_max(2 * GAP_US));
 	}
 
 	return count;
-- 
2.51.0

