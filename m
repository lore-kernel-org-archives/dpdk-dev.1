Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88903D116E2
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 22:45:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56687402EF;
	Fri, 28 Nov 2025 23:44:44 +0100 (CET)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id AA04940430
 for <dev@dpdk.org>; Fri, 28 Nov 2025 23:44:36 +0100 (CET)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-882451b353fso13722816d6.1
 for <dev@dpdk.org>; Fri, 28 Nov 2025 14:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764369876;
 x=1764974676; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rCMP9CwmkGTvpL2x7J2B/y0Rk6+GArDIs8Bn9++G6XI=;
 b=VEP82/rPxVYrKNCYJ8at2o4wfJ9mWqmPVHfQhUKM15uuDmyZxwsTmhUU4CsOdWbAz/
 0P1FJJj+2X87U0hpLrSwyo6s/MdIhNOz7rSjFwO8ueKel7+QZQfZz3p4g6VdltUIwZyc
 PIlRk/taducRfD++4F8FaC5grhX1fvqGMDVXd3FKg/VqUo+RI5NgQ2TLj1PyWvzR1U0X
 RW2OaRmlJdr4FPtYAFjOA2zh9MaE0aTR14J0+7zYmaO9m8cmN1Y3lphYh6Gyl+bSG0JF
 j6bdBBkUE2EfevPXZ34wE6eHCjZCl0Wlr+itQkMuWCCYUenVTo4gBgHs032R3F/RPbvi
 NqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764369876; x=1764974676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rCMP9CwmkGTvpL2x7J2B/y0Rk6+GArDIs8Bn9++G6XI=;
 b=bxp8ufJT0z9SV/M1Ro+4lCb+oXl9DBwFWkfhyCB3NIpLHhzJ7E+D7eASm4dfKUYVvt
 3eptVFvEyDqDk89QTl6iLaUDjYlwASLMYxXxc/4pR6SE4+PDXojvTU4cilwlD0P4WQwA
 zKoBmhsC07wt8/pCyk2R6MNkcKbTBiJtMSa0fZFu3tBbyZ1EN2UwAuVf2HcOOqhqAniY
 RgTSWjPZLXC1zHK7liO2QRItjzBH6r699YbSZsQcBS71joC6bwtfIgQpvB8j0DbuOmJ/
 fRfbal4Zs1dJCCaBPYCwJB/Y3iINog9SZEWOTx318XWTe5aWiJ4VlzQXGpo/yQdMM3D2
 BP+Q==
X-Gm-Message-State: AOJu0Yy/CEZP/cKsz4/Y6rxHf+kuIQxT+AZSyMwoI3X3ipmFct55du+w
 NbsUQ4tuNqVaYf02uhjDgT72GLSKWFpPgB1SHx1da7EXWFPTfnbey376fshjtnNSh7aYenb70tG
 cD5R/
X-Gm-Gg: ASbGncszGhCzgmmXrxQoFayBtH/GgBTWkMXWWPzc0kjiXOxtyyLcSapPCh3M5v1ZoTD
 6Nhmfn3UsyZCENR5pmI+CIA62sYuSImHx2dUWzBcT8eSOPwMw5iapbD3nNAin5D6zbDMIJhu+H/
 088GnN5deMR/HgH7oRNaq1RPv5/81NtzMpy/wAJEZsB1V643ZEOysWdEeTh0I1SjFh9gbzd2ZFu
 AUm1XPqe7G7pRNqghnwtRsDMpS2+79W02QdbOiEdp0PdSj/CEQZYTITvDg+k9tXomzdCojOhNJD
 mAdHYbc9+WDoWJlg47BegMpbr4c3oCltKydUIlvlYWbRqc6KsTcTRN59HTThevOHEh7gOtvzX/P
 gjAdxaiJlKJkfN1oLkkEu1JRwopsUGDjYimDiMl0CBDIGCegQYUHgANwVKckbSibz+i7cEkGs9k
 aBPIERScG+q0U4Dki1THr6FxPXbs7+edcBjM3tYJBzyaFlLis02byoNrze+TFx
X-Google-Smtp-Source: AGHT+IHBXC4/+Z7TFtNhMia0r76uFJETAe4IvrieUSFbiydp2z6VUlHOMOxjqRRkzGuYDDWo7XGi8g==
X-Received: by 2002:a05:622a:109:b0:4ed:e4d6:c5ed with SMTP id
 d75a77b69052e-4efbda9078emr237130481cf.45.1764369876017; 
 Fri, 28 Nov 2025 14:44:36 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-886524e2b8asm37022216d6.16.2025.11.28.14.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 14:44:35 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>
Subject: [PATCH v8 08/10] test: fix overflow warnings in several places by
 using common code
Date: Fri, 28 Nov 2025 14:42:11 -0800
Message-ID: <20251128224420.195013-9-stephen@networkplumber.org>
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

