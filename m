Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57146FD45F1
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 22:59:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AFAD40616;
	Wed, 25 Feb 2026 23:59:23 +0100 (CET)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 631A6402EE
 for <dev@dpdk.org>; Wed, 25 Feb 2026 23:59:21 +0100 (CET)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2bd3b0bc201so473691eec.1
 for <dev@dpdk.org>; Wed, 25 Feb 2026 14:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772060360;
 x=1772665160; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8i3R3t5iwtr9mNKgacA6fLmtsITMV5Cz5R0LrqR2h8A=;
 b=DG/if9TMuR8fjIEj7TaAUXbE+zSbyXD6n9i7M33jSEvuvgWc9pn5W/JStmQFzRmP5u
 AQUTrdj9awak9du/HZ2srOoGAmgHb0mjYYCCWd47T7RXbEv/pLRR5xTdCd6lYEFqGXmO
 5/M/yzvh+o/hdxqEkxXQ44nU3H+CLpk5wWAKMLP7pbaSwoeA4B039YUQ6LQVh3qqhjoX
 m3DydZQkKEEl8ofyN4x6h6Sl7kAjq/MY+v+dAlulVYoCK0uzIGRU6+qdZ4G4wOAffjqW
 ktculanXvM4PGVvCHfLFWzgGV0NercW89xAtzuvsqZQQG/GuQ1vY2sDBdQPvhXnTFdks
 j4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772060360; x=1772665160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8i3R3t5iwtr9mNKgacA6fLmtsITMV5Cz5R0LrqR2h8A=;
 b=smYMpW0HlrfJQD37SWb6Tn1D7H2d9es9yiUIf/v6TJH7vHIfgRM9uC74UV60DX3yK6
 ZwK8wYeHt9F71O90L/etonF22qVSk4FBrYRivNTPNEWIS7A2okYiUrYXQ8spdm1d32Np
 RGy6Onck3SjuyLjFzHivORZHyceuKkjjXUwYGH0DNN4K/36eK+tRFokSlrxzZaMCjYbv
 z6D/IFmgJbbJTd1qqS9FgUKi+FsAJ/lToM6X94EOI1t8UxnXzSK6su9fE7IGmeQ85KWm
 IIkGRd//m5u3RDFu50fjeRDeXhQ6JISlapmyd7oCnqV/Bos8xolQLD+dyilZ+M4IbXrY
 rzQA==
X-Gm-Message-State: AOJu0YzEfMi1jaTMIqN+/wmHGfselvWEnE3yy8oIjT9HJ/3k+LZQKfhS
 5aGPBPhVFyDFWq5WZbxIwfSGXKDIbW/gHjKmn/gQn9TVJ1m0Vy3DQAXBUu0+sS3/KkRSx/SCHre
 ywk1WQZ4=
X-Gm-Gg: ATEYQzwjP4G3buIzVETfm3fiNVTQQ+oDcJ0j9Kr8TgJirABDWZFWvEfN63EUKwmukuc
 QMJ5C8sbivU1PLbVetdMRkvntHBWVMUS68vCS/ri+wEEPBqAdP3GeyNALRY7dwQDAYXJU5dTkvB
 3yCD1dKgRsZRLgZ1ifIHzJjWHUmzJ6ZGFFnpymuF6IqnuxTE9npqvdz4jL3kkD4Y1YcBci0kHnK
 4ObqjFceTJtLyMs0W1Accqvgkw1a+Vz+fuJ1L9dFBJiBfFzsbcr28oyFmKnUgXG4nm+1RftUVaS
 OQiMD/l3FNe3EfE5fmmqlfZGGUR3kSvyBkHR0nAECHniz8SmUZV5ufI5KDALa1KcqLCtV8DFWAp
 23k/z4VFexWxofb6BUKqrUPmTIZJ+m/j9tkclOlxksiLQamHs/zQ9c+xKQ/IWNOn3xqc8UhTdrE
 Inv3533KaSaV/YtbZHDdLitoUVRvnxqcJBlb7CoQ0hwpHk9J/IdFcJpIRD8Gq8Xw==
X-Received: by 2002:a05:7301:3886:b0:2b0:52ac:92fe with SMTP id
 5a478bee46e88-2bd7bd58ca5mr8784151eec.21.1772060360401; 
 Wed, 25 Feb 2026 14:59:20 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdd1f23c47sm411104eec.19.2026.02.25.14.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 14:59:20 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 2/4] test: use fixed time length for write packet test
Date: Wed, 25 Feb 2026 14:57:17 -0800
Message-ID: <20260225225916.518790-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225225916.518790-1-stephen@networkplumber.org>
References: <20260220184255.306368-1-stephen@networkplumber.org>
 <20260225225916.518790-1-stephen@networkplumber.org>
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

