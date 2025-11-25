Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCEBD0E6F8
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 15:22:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1038040DCE;
	Tue, 25 Nov 2025 16:22:45 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 03D5040BA4
 for <dev@dpdk.org>; Tue, 25 Nov 2025 16:22:40 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-29558061c68so75989525ad.0
 for <dev@dpdk.org>; Tue, 25 Nov 2025 07:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764084159;
 x=1764688959; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wPTbx4oyobx3Xj/wuyYUbnEt7FosXUH/v8+SDAct6VA=;
 b=uH4RvB/fET67B18Epvv6LtPfvpdNfXF7driFXbTH7JN8X2RNb8lc0KXi8pyD02/BoX
 i1OyjL6grO0WK6beqPWoo8lQRHcBQedwmKJl7Fcn5QDbOHpYZYDAF+hkDUl/Kb5Z+wFB
 /kI0FR5h4BtDBtj6Fyoto1MBmqNkoBtwc30gYWoJ0mv3n8Xw0kYH/fvruzhdZGUTAjLb
 IFWPsm67W4TYa58oYjqYnWU7doXqs326+dFKQ68jFfb2N3IhBVQTAK70XXnAlWK4bwHu
 z932Y1KQ32XVhFRUW1hHLzoMZvlSTleZUjRYsBi2+tTAa+rimQ6wxgMsu6xRjKDS507a
 1Q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764084159; x=1764688959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wPTbx4oyobx3Xj/wuyYUbnEt7FosXUH/v8+SDAct6VA=;
 b=NL9mrVR/EGjlJdMU+xSK+P6zPFLLNMfh0eZxaheIAn03i3gf3gyiGz/jiOGYXkvMbw
 g51LKhhLR4eZhmdXpmS65/EWPBOKhufY+SFIUXnS0IRuKA3lGSqa4tVJdNjIHpZM7wfU
 fNPDYglUf0Ng+xwGreaxCuuFaFPSvXFr0m/MJP3RvPqmuH7WTLm3EXI2JRORyYtw5okg
 Ux5bcHc8nY+PfeELMg8sCqdFsRcGCtfCEjoNyI5qZl88E2m9O6AS+KpN4H8pc6NfBJeH
 Q/QjsHKdQrByppYSdg1+vaYTatGcamswCdAT6mPnjSpsQo1VBZgDsFz37uwveicxaD0r
 8a/Q==
X-Gm-Message-State: AOJu0YyRYTlZePMWNCvy/wcifdqcxR4ROfOweUKG3yz0uGyDWo+kHm0F
 OEi/R/mLFIBxVJZ/AW8S0rhdJkUIsC2kXfZiyFA8NnvOBApRuYNc2rn8MZnC1ooiYrpk4BPapV9
 dsXlr
X-Gm-Gg: ASbGncu5sF32zvKnfRQcL65fJ3lpv9JTH7ngsGXlI3PnLzJj0cXXHMjSuDdj9+cth/k
 Wl9gPMD2DC6jE3R7hm2OiyiIRaoNQ3t5Hd42iRktGIwbmshMy44EDaH0HBICdFxy/cgCcjoNGZQ
 O+fgfOxc84bLblA84o1k481C7P4V//NcYCTi1DAd38qJPmQDOFlnqgP3BIT+ZKGtef46/ix/VJf
 yZCZxod0f75am42SGKxVAtbbuigwZPaahFBTkF5elTfJgU3ZAvDUIr8E+9jaNMCAtWXjqQIoq9T
 WdOU1srbMDWPR+yv2lGtOq12xVEYKnyRpkJT07Ct5eO+bjPy+XlLXsLghnzymGYBo7DfPVDG/BP
 pizku/EhRdjI9tkN1Ain6t0Wr1OyuTwL6oO7LKMfpXqbKCYjo6ntd4uqNinWiQKSBFgKf1ybTJM
 ovsYCqv6Z7Ikc5fvdaU6/td23L9HGKkQ3/cV4qvcahTCeY+s/gvw==
X-Google-Smtp-Source: AGHT+IG9HMVMPQzyok3+lH02TN5TvQADbgguD8fY8nibCSmkdeDauDgQ7UPsbSEfCYWnMasicaaLxg==
X-Received: by 2002:a17:903:947:b0:28e:a70f:e879 with SMTP id
 d9443c01a7336-29b6be8cb2dmr170162985ad.1.1764084159028; 
 Tue, 25 Nov 2025 07:22:39 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b111acfsm172573345ad.19.2025.11.25.07.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 07:22:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 03/10] test: refactor file prefix arg handling
Date: Tue, 25 Nov 2025 07:20:53 -0800
Message-ID: <20251125152232.73528-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125152232.73528-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251125152232.73528-1-stephen@networkplumber.org>
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

