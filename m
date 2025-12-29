Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784F4E92FE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 22:01:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D926E40664;
	Mon, 29 Dec 2025 23:01:15 +0100 (CET)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46]) by mails.dpdk.org (Postfix) with ESMTP id 826B140664
 for <dev@dpdk.org>; Mon, 29 Dec 2025 23:01:14 +0100 (CET)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-64b7318f1b0so11152256a12.2
 for <dev@dpdk.org>; Mon, 29 Dec 2025 14:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767045674;
 x=1767650474; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rCMP9CwmkGTvpL2x7J2B/y0Rk6+GArDIs8Bn9++G6XI=;
 b=RPcg7jtlLeh7HxoD4MqqSvC6qKcCIxMFFhimLf725QXwOTm7kJ1rpvmcbf72k4GYJr
 b3YoHv3j605l1xLs79LxpyAdm3S4a7fwavgiVNNks1oaldNibf9elmo7Apu8R+FFH4+6
 7WPxvr9i5MQJchz8z3t+CPxawvsNKTwRwpCM1+KNO8r4tKDofNUktp+x2gUFRQoTMux9
 oqSuvunaHiM4GdZt+5I4++/DOiRv702IctD+mbwt/TdhxeCh27qKskwxDRLlhUOoTk/s
 SKqbNCZ6YUzW54xCxVy8e5zOk5vgl3eTFa+zGSDzuxmysHnLTE9VZMwRsYqfCb+fI54I
 P7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767045674; x=1767650474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rCMP9CwmkGTvpL2x7J2B/y0Rk6+GArDIs8Bn9++G6XI=;
 b=MkqxLtiCbKuvyObjM/j7BqQYmp9o+r3SkVgbTySYPLIXsZV+7qbqC69rvl8wv/crsW
 Pu7DrFXJC39bpFaLU5irs1MytcAINEuGdQYK6iLAVGmP3vDQEKyPGzC+PzivkH2nFoV/
 6Z8jPaQiyiD4S9gA8GloGZl6u2Yqre9ePkY4eb9KMrxpCLOgIHYNaj4oyU/oaD83QU2d
 70ZOoTaarD9waMOwOtijeX+TsFw+rmSCQETqeUVxjt3GiCklwWAeJInXWhgp2FB4FcxG
 L/KdmmRnGmVSEETjro6keRKCMNiAgLq0HdIN6BRXaJsGh5UByC0KoH/2UN3Ag6d4u876
 JOZQ==
X-Gm-Message-State: AOJu0Yya7e+voNcLZN86+qW2xo0NM/kg3XuUldpsZRdP91IFEHuqQUew
 +ivM/zWai5g7wBJ1AC13vZE6w9zoX/ODncx5JWFzeQsZJYcHdTKrYUAdsSDU1iLTaxBg8bZXKWe
 Zl5X3gd8=
X-Gm-Gg: AY/fxX5xIGTYOrlT0wqd4U+/W/uEHH4RlbcdplOaEso/nxVBctK9USgtiv/9RicJj7n
 QvQBABWOJZnTLVHQSFfLciQDn0I3qf8V5Nvk5/6m3IHA5NTCjo3CCGpkgBn107vuGURnxHURvGM
 n39mR8tMFyGKW/5gmNG5E/ZmLnV+PVV8yOD7YloXj9KHhAYA+ygYAxWUk1Y2B6J6BDEUpBE5pIZ
 JD8nfpOdrUbarRT8a7M7InAfo5xpQtcy9tuTZc3cvuhZkGUdM9XWmw+SydbV14yEj7nZtG6+HsT
 KmiJYoVSXkDw099StVPpqU8zrIURlL8r0jnrKR/Ipq4Ndz5A3lU0EFh0VDlzy5bg8BXk5gT/HAU
 J/5m4Txj/1MRx+ZAY+RFKIt/wcqZYkdalX3Vk0qq1i7F+6sNbxef/rMTGsSP27bNY1ZKMyzYIEH
 MzRV253snT4N9cy+pXqaA0DN3uQ7Nk0r7bFpORzB+WkSJMM5J28g==
X-Google-Smtp-Source: AGHT+IFD+vptBCMpOIkHyARtWGzAUhfmAfNaxRnI98c8vpvxLzQ6OJHl5b+2inI4pvu1MWNJzUk0hA==
X-Received: by 2002:a17:906:f598:b0:b1d:285c:e0ef with SMTP id
 a640c23a62f3a-b8036f2fac6mr2846675366b.26.1767045674046; 
 Mon, 29 Dec 2025 14:01:14 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037a62973sm3496359366b.6.2025.12.29.14.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 14:01:13 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>
Subject: [PATCH v10 8/9] test: fix overflow warnings in common code
Date: Mon, 29 Dec 2025 13:59:08 -0800
Message-ID: <20251229220053.21981-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229220053.21981-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251229220053.21981-1-stephen@networkplumber.org>
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

Several tests lookup the current file prefix and
format up a filename argument. Avoid any possible format
overflows by allowing for bigger string.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_mp_secondary.c    | 14 ++++----------
 app/test/test_pdump.c           | 13 ++++---------
 app/test/test_timer_secondary.c | 12 ++++--------
 3 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/app/test/test_mp_secondary.c b/app/test/test_mp_secondary.c
index f3694530a8..fc295323f2 100644
--- a/app/test/test_mp_secondary.c
+++ b/app/test/test_mp_secondary.c
@@ -67,17 +67,11 @@ run_secondary_instances(void)
 {
 	int ret = 0;
 	char coremask[10];
+	const char *prefix;
 
-#ifdef RTE_EXEC_ENV_LINUX
-	char tmp[PATH_MAX] = {0};
-	char prefix[PATH_MAX] = {0};
-
-	get_current_prefix(tmp, sizeof(tmp));
-
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#else
-	const char *prefix = "";
-#endif
+	prefix = file_prefix_arg();
+	if (prefix == NULL)
+		return -1;
 
 	/* good case, using secondary */
 	const char *argv1[] = {
diff --git a/app/test/test_pdump.c b/app/test/test_pdump.c
index 9f7769707e..cd044f0f69 100644
--- a/app/test/test_pdump.c
+++ b/app/test/test_pdump.c
@@ -174,16 +174,11 @@ run_pdump_server_tests(void)
 {
 	int ret = 0;
 	char coremask[10];
+	const char *prefix;
 
-#ifdef RTE_EXEC_ENV_LINUX
-	char tmp[PATH_MAX] = { 0 };
-	char prefix[PATH_MAX] = { 0 };
-
-	get_current_prefix(tmp, sizeof(tmp));
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#else
-	const char *prefix = "";
-#endif
+	prefix = file_prefix_arg();
+	if (prefix == NULL)
+		return -1;
 
 	/* good case, using secondary */
 	const char *const argv1[] = {
diff --git a/app/test/test_timer_secondary.c b/app/test/test_timer_secondary.c
index 4e220559b4..bd618b3cfc 100644
--- a/app/test/test_timer_secondary.c
+++ b/app/test/test_timer_secondary.c
@@ -51,16 +51,12 @@ static int
 timer_secondary_spawn_wait(unsigned int lcore)
 {
 	char coremask[10];
-#ifdef RTE_EXEC_ENV_LINUXAPP
-	char tmp[PATH_MAX] = {0};
-	char prefix[PATH_MAX] = {0};
+	const char *prefix;
 
-	get_current_prefix(tmp, sizeof(tmp));
+	prefix = file_prefix_arg();
+	if (prefix == NULL)
+		return -1;
 
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#else
-	const char *prefix = "";
-#endif
 	char const *argv[] = {
 		prgname,
 		"-c", coremask,
-- 
2.51.0

