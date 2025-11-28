Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35439D116E2
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 22:44:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4CB9402ED;
	Fri, 28 Nov 2025 23:44:32 +0100 (CET)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53]) by mails.dpdk.org (Postfix) with ESMTP id 5D432402C5
 for <dev@dpdk.org>; Fri, 28 Nov 2025 23:44:29 +0100 (CET)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-88242fc32c9so26657256d6.1
 for <dev@dpdk.org>; Fri, 28 Nov 2025 14:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764369869;
 x=1764974669; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wPTbx4oyobx3Xj/wuyYUbnEt7FosXUH/v8+SDAct6VA=;
 b=Ns/b+uwOWqFB3wQrGQiVngXHwx5LDXuyLjHImD4pvRz0aGcz1YK+UnsOMqveAXOUua
 wgGRDCzOOqY2qVfopJREwHmskH8UnqyVb+ocUJdDbSBS3JbWqLq2w/9DIvaCTVfDOZnK
 HIDmWU2b7g28gtfvT8QjwBjLT5iwZrH3LNrEgdmeOXatWTb/clvmwY8ynU3N6iUAVIyC
 WBJ1sWGbrQW69MKs4Y5kp5rHJrM1yIM30+A19KHrmTyrGiLsq5IBEDPOnUM0SMogHoqD
 WS1/2AZGl81VSgsJRB2xVqcuZgi24w2Pt/OYkniTp+ZzdxoJ9quPHjJ8W9EpdPoOCBoM
 AU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764369869; x=1764974669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wPTbx4oyobx3Xj/wuyYUbnEt7FosXUH/v8+SDAct6VA=;
 b=LqNxntMJ9CSeRnuqRABKNtpnOiwCSmr3Cg0CI30VRhb8MjHBzzzpLQ4vDSIie93EMP
 5EMOVpR3mGlq2HUhBxIgJqH917y38xUufiUILnaOeeCJGXxfy5GqgwmBf72AbmbdrDXt
 fnw/ZmpQTmdcCXpmmE84Evvkb9Ce1stqNg0pC06n/vFp0hRr+6cJdX/fXD6LQhkD5dea
 8CbiCoy+SscsbwxtV/ZGVUr7qG4EmSzUsmI0YjcvinXVDldQQr/R2qZwWqkItLe0emqK
 yoYrTsaGmPgKs0PIfdPSi8ilOcwOXaDmeE+cUlvWU0LBKa50NYqUNE5ru7j3T0ddKWcb
 XKTg==
X-Gm-Message-State: AOJu0YwordNZOjL8Xk0+3U5ku4JRxxf7Tico0Z3iK/CHQrrD0CS7iQO0
 XnjufrI7FTepLeIYr6Fwa9gBeFb4oQkIwXyFpbi3MGtvs04pGU0Ykjw7ADV6lU/OKvVZo4rsqjo
 ktlvu
X-Gm-Gg: ASbGncsyH8KpZqMx7Ahv+md/weAbBUrLvxvQIXH0EQ4Egzq+Q99pdPXMAaUoMPIN9yC
 4W4tdgnBe9hCMVIfHuXa55DAW0kIf49CRUh1CAmyXfbKGGovSkCs0Y9gJX3IrXdn9JkPy3UXSl+
 f5x/W166ZgCkiLtBazKMH197Hhuwn0W8Nq6LGhfdnvWx0Giz1bjJlphrC6+WBqa6ltQNtoQrAek
 VzUwhNFkymFiRTz7qw2xP/r7d8bEai5R7ZszUVbXbHSLcxIxKxBTTvSFxXbMo8YoejGq10s7M2Q
 VVmZVhE9xAuPKVdnQNaF9nhzNxEtJeCIF5sl8XiHfjdM9kd9Tii2GbTQjC4XuSiMVGeWv/KAznR
 rMGMz8h8gzRFQlXESQuL3fZ2JCtBlIx3NGkTAJ7MXqAPqc4GTovNIFGnQwSy6SfP8jvVbOykIcD
 k4+ddu+P2/zxXfiHQ+jkKPWLU1BuuJlmPkeTkxef4NyAQYvEsBog==
X-Google-Smtp-Source: AGHT+IEX1zrJDOZN1gvexPsJyk8lvV2prJ3pP4iJIq6vZFNU0OdRbGmvzOiO19kErzXOIvguBmn6mw==
X-Received: by 2002:a05:6214:caa:b0:880:5636:6241 with SMTP id
 6a1803df08f44-8847c535a20mr428119556d6.65.1764369868716; 
 Fri, 28 Nov 2025 14:44:28 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-886524e2b8asm37022216d6.16.2025.11.28.14.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 14:44:28 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 03/10] test: refactor file prefix arg handling
Date: Fri, 28 Nov 2025 14:42:06 -0800
Message-ID: <20251128224420.195013-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251128224420.195013-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251128224420.195013-1-stephen@networkplumber.org>
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

Make setting up --file-prefix arg logic into a function,
and avoid impossible case of file prefix path causing overflow
of string.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_eal_flags.c | 107 ++++++++------------------------------
 1 file changed, 23 insertions(+), 84 deletions(-)

diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index e32f83d3c8..c3723ee0b8 100644
--- a/app/test/test_eal_flags.c
+++ b/app/test/test_eal_flags.c
@@ -121,6 +121,8 @@ test_misc_flags(void)
 #define no_shconf "--no-shconf"
 #define allow "--allow"
 #define vdev "--vdev"
+#define file_prefix "--file-prefix"
+
 #define memtest "memtest"
 #define memtest1 "memtest1"
 #define memtest2 "memtest2"
@@ -320,18 +322,10 @@ get_number_of_sockets(void)
 static int
 test_allow_flag(void)
 {
-	unsigned i;
-#ifdef RTE_EXEC_ENV_FREEBSD
-	/* BSD target doesn't support prefixes at this point */
-	const char * prefix = "";
-#else
-	char prefix[PATH_MAX], tmp[PATH_MAX];
-	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
+	unsigned int i;
+	const char *prefix = file_prefix_arg();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	const char *wlinval[][7] = {
 		{prgname, prefix, mp_flag,
@@ -387,17 +381,9 @@ test_allow_flag(void)
 static int
 test_invalid_b_flag(void)
 {
-#ifdef RTE_EXEC_ENV_FREEBSD
-	/* BSD target doesn't support prefixes at this point */
-	const char * prefix = "";
-#else
-	char prefix[PATH_MAX], tmp[PATH_MAX];
-	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
+	const char *prefix = file_prefix_arg();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	const char *blinval[][5] = {
 		{prgname, prefix, mp_flag, "-b", "error"},
@@ -491,17 +477,9 @@ test_invalid_vdev_flag(void)
 static int
 test_invalid_r_flag(void)
 {
-#ifdef RTE_EXEC_ENV_FREEBSD
-	/* BSD target doesn't support prefixes at this point */
-	const char * prefix = "";
-#else
-	char prefix[PATH_MAX], tmp[PATH_MAX];
-	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
+	const char *prefix = file_prefix_arg();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	const char *rinval[][5] = {
 			{prgname, prefix, mp_flag, "-r", "error"},
@@ -535,17 +513,9 @@ test_invalid_r_flag(void)
 static int
 test_missing_c_flag(void)
 {
-#ifdef RTE_EXEC_ENV_FREEBSD
-	/* BSD target doesn't support prefixes at this point */
-	const char * prefix = "";
-#else
-	char prefix[PATH_MAX], tmp[PATH_MAX];
-	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
+	const char *prefix = file_prefix_arg();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	/* -c flag but no coremask value */
 	const char *argv1[] = { prgname, prefix, mp_flag, "-c"};
@@ -694,17 +664,9 @@ test_missing_c_flag(void)
 static int
 test_main_lcore_flag(void)
 {
-#ifdef RTE_EXEC_ENV_FREEBSD
-	/* BSD target doesn't support prefixes at this point */
-	const char *prefix = "";
-#else
-	char prefix[PATH_MAX], tmp[PATH_MAX];
-	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
+	const char *prefix = file_prefix_arg();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	if (!rte_lcore_is_enabled(0) || !rte_lcore_is_enabled(1))
 		return TEST_SKIPPED;
@@ -751,17 +713,9 @@ test_main_lcore_flag(void)
 static int
 test_invalid_n_flag(void)
 {
-#ifdef RTE_EXEC_ENV_FREEBSD
-	/* BSD target doesn't support prefixes at this point */
-	const char * prefix = "";
-#else
-	char prefix[PATH_MAX], tmp[PATH_MAX];
-	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
+	const char *prefix = file_prefix_arg();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	/* -n flag but no value */
 	const char *argv1[] = { prgname, prefix, no_huge, no_shconf,
@@ -803,18 +757,12 @@ test_invalid_n_flag(void)
 static int
 test_no_hpet_flag(void)
 {
-	char prefix[PATH_MAX] = "";
-
 #ifdef RTE_EXEC_ENV_FREEBSD
 	return 0;
 #else
-	char tmp[PATH_MAX];
-	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
+	const char *prefix = file_prefix_arg();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	/* With --no-hpet */
 	const char *argv1[] = {prgname, prefix, mp_flag, no_hpet};
@@ -829,6 +777,7 @@ test_no_hpet_flag(void)
 		printf("Error - process did not run ok without --no-hpet flag\n");
 		return -1;
 	}
+#
 	return 0;
 }
 
@@ -898,6 +847,7 @@ test_no_huge_flag(void)
 		printf("Error - process run ok with --no-huge and --huge-worker-stack=size flags");
 		return -1;
 	}
+#endif
 	return 0;
 }
 
@@ -913,17 +863,14 @@ test_misc_flags(void)
 	const char * prefix = "";
 	const char * nosh_prefix = "";
 #else
-	char prefix[PATH_MAX], tmp[PATH_MAX];
+	const char *prefix = file_prefix_arg();
 	const char * nosh_prefix = "--file-prefix=noshconf";
 	FILE * hugedir_handle = NULL;
 	char line[PATH_MAX] = {0};
 	unsigned i, isempty = 1;
 
-	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
 
 	/*
 	 * get first valid hugepage path
@@ -1525,17 +1472,9 @@ populate_socket_mem_param(int num_sockets, const char *mem,
 static int
 test_memory_flags(void)
 {
-#ifdef RTE_EXEC_ENV_FREEBSD
-	/* BSD target doesn't support prefixes at this point */
-	const char * prefix = "";
-#else
-	char prefix[PATH_MAX], tmp[PATH_MAX];
-	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
+	const char *prefix = file_prefix_arg();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	/* valid -m flag and mp flag */
 	const char *argv0[] = {prgname, prefix, mp_flag,
-- 
2.51.0

