Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111C3CD4F3E
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Nov 2025 19:00:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8CF44278F;
	Sun, 16 Nov 2025 20:00:44 +0100 (CET)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id DF9604278D
 for <dev@dpdk.org>; Sun, 16 Nov 2025 20:00:42 +0100 (CET)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-bc0e89640b9so2508190a12.1
 for <dev@dpdk.org>; Sun, 16 Nov 2025 11:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763319642;
 x=1763924442; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=geNB80bwPZKwod0ZvzJJiEPWjrC8Gr8Jh0d9jHdGOsY=;
 b=QC/ysVOYTMQ8m9d3xdzSMXPTDlF1lAH3fHDsD8uLTLMjjt1SiBOKbZ3rjHeN9wCqnS
 F5e5LqCmfRA8vCzESqXNGS4ViN5UuKPAizSsCtaQ3DQQ1qQPHiQ9TcMvN2+beKf5V3g3
 6GvGXKlHsvhUxA84emyr16ABO6k74dtLVx+9/dczGlzIr8oJWeKFr/7jqP9HhkUHn/fF
 9n47yXf8SIOAgL9H+frIvtYmRddVnCTJ71lI8SFFUzFHBw9y8c/7oe542DPWQvdxioUL
 KH2pJvL5w2jtrV+62eND5fB9DpSGYZglWy/X69hGaaF7LFvMcmCDUv7lnvme56Z9NZpj
 100w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763319642; x=1763924442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=geNB80bwPZKwod0ZvzJJiEPWjrC8Gr8Jh0d9jHdGOsY=;
 b=cMXOcwDLQIZiAGGUVqYC/kAMmHbi0GA4YrwAEzfFpY07SIqgIKsXe3y1PNOGn0IA9q
 KC2wN0P2YBfRS/XklLze/uaszy4reWdg5K+UGiBA6zLqUetrBsXApoiBY4m47/jELDYN
 u0WOWD12//cFhBk0tpxvtF3zB3Pot1De9UOMASL3oSkYRihpHp88MvNlyTHvqRyUQNeI
 nL6zML/3zBQ/rfMKreKWmLv4vvk8oyAnPZEiZ2iaSQq1WjVGoyvq7VNR2n5y7YVQFKEk
 DFNvd3XhZCcTkJ/b2cHDX46RFSbpT40MVG0NCWl1zpWUM8zrKor9P+WQGl1Pbpy1Of29
 iPHQ==
X-Gm-Message-State: AOJu0YwY/le1d7f73WLV4T3g80zNgLMirKrQ2psKtJgPQlBl1CaLQYi3
 kwbt8Dk1x4kW3o43EWWSerVLNw+Bxsdp2eFiHaD/fe5nQa6qDXC21Chh44HXza+bCJmwuZXydzE
 KMqXB
X-Gm-Gg: ASbGncs9Y2X9BSDdDikFA4KEO9lzII0wIOGdR71MdWFYaI4ubWpEcLrVxYjIHp4yS1B
 Gt25AVcL6GxIeDKA+a/NB7+6RBNljvnxRWFmUg0bqyodROouFY9zVsFBtwDTcDsET+q8A4poBGv
 r5WbfVxdLWvGZrHXZyh2KQ1205G0m7m/rA/lVkfWVgEMGFy8VH7eaptomZ88Ogv2477zjyiLlhm
 nW7DlHHr7duV0nmAja80rsfnI/Md5KQYuAEW5adBSqVuX1lODZXsAQ6RGUh8b0LFi4QwQWaWYmy
 2PvcU/8HUDh7SIagLNsN6qmw2ngSWEXEDKnCtDc8v6unVSxz3NZmK2wuV0w9IeLAWQHqa0KTnTc
 l6GI60E/aEX+3URtBI5PFbAxjLxtuTaZ+GtCCauK35OZbYp4kRt/kf2ChkbIKP/2mXyLwi8ehMY
 XgEBzEJ5XX5BMF6Q8TGMmoEmpfeuwIyOy0CBDctxmhJLS4ogjAf8NDqI+3UenU
X-Google-Smtp-Source: AGHT+IGzUD6zv2TydT+CZCUsjOLwalI0sauNboQZVQIl4PtgrOvtor6Tk1f2WtV2I+qp/VhGYxnHCg==
X-Received: by 2002:a05:7022:7e88:b0:11b:9386:a37e with SMTP id
 a92af1059eb24-11b9386a51bmr1488067c88.45.1763319640422; 
 Sun, 16 Nov 2025 11:00:40 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49dad0aefsm28215946eec.3.2025.11.16.11.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Nov 2025 11:00:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v2 2/5] test: refactor file prefix arg handling
Date: Sun, 16 Nov 2025 10:59:30 -0800
Message-ID: <20251116190035.76123-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251116190035.76123-1-stephen@networkplumber.org>
References: <20251115193409.99740-1-stephen@networkplumber.org>
 <20251116190035.76123-1-stephen@networkplumber.org>
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
 app/test/test_eal_flags.c | 123 +++++++++++++-------------------------
 1 file changed, 40 insertions(+), 83 deletions(-)

diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index e32f83d3c8..0eead2a422 100644
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
@@ -312,6 +314,25 @@ get_number_of_sockets(void)
 }
 #endif
 
+static const char *
+get_file_prefix(void)
+{
+#ifdef RTE_EXEC_ENV_FREEBSD
+	/* BSD target doesn't support prefixes at this point */
+	return "";
+#else
+	static char prefix[PATH_MAX + sizeof(file_prefix)];
+	char tmp[PATH_MAX];
+
+	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
+		printf("Error - unable to get current prefix!\n");
+		return NULL;
+	}
+	snprintf(prefix, sizeof(prefix), file_prefix "=%s", tmp);
+	return prefix;
+#endif
+}
+
 /*
  * Test that the app doesn't run with invalid allow option.
  * Final tests ensures it does run with valid options as sanity check (one
@@ -320,18 +341,10 @@ get_number_of_sockets(void)
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
+	const char *prefix = get_file_prefix();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	const char *wlinval[][7] = {
 		{prgname, prefix, mp_flag,
@@ -387,17 +400,9 @@ test_allow_flag(void)
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
+	const char *prefix = get_file_prefix();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	const char *blinval[][5] = {
 		{prgname, prefix, mp_flag, "-b", "error"},
@@ -491,17 +496,9 @@ test_invalid_vdev_flag(void)
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
+	const char *prefix = get_file_prefix();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	const char *rinval[][5] = {
 			{prgname, prefix, mp_flag, "-r", "error"},
@@ -535,17 +532,9 @@ test_invalid_r_flag(void)
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
+	const char *prefix = get_file_prefix();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	/* -c flag but no coremask value */
 	const char *argv1[] = { prgname, prefix, mp_flag, "-c"};
@@ -694,17 +683,9 @@ test_missing_c_flag(void)
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
+	const char *prefix = get_file_prefix();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	if (!rte_lcore_is_enabled(0) || !rte_lcore_is_enabled(1))
 		return TEST_SKIPPED;
@@ -751,17 +732,9 @@ test_main_lcore_flag(void)
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
+	const char *prefix = get_file_prefix();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	/* -n flag but no value */
 	const char *argv1[] = { prgname, prefix, no_huge, no_shconf,
@@ -803,17 +776,12 @@ test_invalid_n_flag(void)
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
+	const char *prefix = get_file_prefix();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
 #endif
 
 	/* With --no-hpet */
@@ -913,17 +881,14 @@ test_misc_flags(void)
 	const char * prefix = "";
 	const char * nosh_prefix = "";
 #else
-	char prefix[PATH_MAX], tmp[PATH_MAX];
+	const char *prefix = get_file_prefix();
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
@@ -1525,17 +1490,9 @@ populate_socket_mem_param(int num_sockets, const char *mem,
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
+	const char *prefix = get_file_prefix();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	/* valid -m flag and mp flag */
 	const char *argv0[] = {prgname, prefix, mp_flag,
-- 
2.51.0

