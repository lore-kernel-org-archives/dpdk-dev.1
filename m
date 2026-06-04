Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDCBCD6E4A
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 16:12:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D1E7402E3;
	Thu,  4 Jun 2026 18:12:30 +0200 (CEST)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mails.dpdk.org (Postfix) with ESMTP id CEB7D402CC
 for <dev@dpdk.org>; Thu,  4 Jun 2026 18:12:28 +0200 (CEST)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-137bd9ed2b1so2036531c88.1
 for <dev@dpdk.org>; Thu, 04 Jun 2026 09:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780589547;
 x=1781194347; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Bvk0lbMEfdLQX1eFIz8pIRFu0+abJ1H6lcJqmlnwW/Y=;
 b=rhzcPPLI4oANZMEaVaqhh9Cf8g510onN8Swe20XIYJ7JkhAXgMGd2keaXYeLNQg4Sz
 IPV278/f0Ten7trGs6qTWt/VwmpXLSW9GpqMYaNAeW0oHOzNq0Xv1XKb7OY1X4rMCNzJ
 jLJNtGwZfhU3UV1D1NNmpgkkpwwPe4JxYKhnRbLlZipZSnPLnP7k+BwZlxHurGj2r9Yx
 NuRUM30+x/nXPsFwycRMjvhzAlUrjCo01XlM5iTl0pvyJCIUVcc5louHXGj1ujgKGg2P
 g2g+sRhKSrN0fHRYoyiyqgAdcM3wi0A2z/CgbLNfnSAuiX5zVbCHe0OCjG/FPGu2u+ju
 /a6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780589547; x=1781194347;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bvk0lbMEfdLQX1eFIz8pIRFu0+abJ1H6lcJqmlnwW/Y=;
 b=nmRn8wQFq8js3tJT9KC2jtqhS7yVb82EMBVDf3YWw+ihSVp6g+YZn+lIdGCRh3TubN
 toOWKXLIERXZqXjZgMk/0EKov5WpTUPAINfiTtbJqvHyavGruAdysPECe5GBraIZbhN4
 Yywn5cGu1GCxeGwbyF8It+2pviSiRGauFArvmON9SsYRTx3vsU3wcF6Is4kBF+TSEFhU
 inWYwA2TwKeqfF8xQ1m1hX2kO9aKaXUDl1kzjowPNwUAmIIewpJkefRR718ypYE3vIEc
 eXqusLEPREsUIFvdfBL1SUPfW8qv87dr6wxg7FGXcWQSn0fnEiJ9xSFcIUsU6E3DrwwV
 eENg==
X-Gm-Message-State: AOJu0Yz8D0zJwYtqqa6pu6BJyciJF1lN+upe4ctsPryxARsY2Npr9aX4
 1MSHsJxbU7n7lNMIV/1AYJoFknb6wv+hLDtkIKEmQZRozY2tLAzakX/j+RToYkBjUEYNZCopvCE
 inFY7
X-Gm-Gg: Acq92OHk8j9vVpQQ1d1NnkPo+4+07YSkqnbG36ICnD6NzjaK01985TNR2nBBNaNxJ23
 rwDyGtYES6EuAZS77Amxp+C7rcjqX7FW+rHExxAbuMcjZsY9v+Y7uFvYmgv/aZYQlrDOcccprZ/
 cMlrWit2X3R9YHlMZyM46/jj7285hVV6LqhhEYp+4qoawcYzWiWZN2e8M6xnUsi0TtPvxWmX2eF
 OZIPdR5cIuW/nT60yefGGyThVsGFehRNd53krSuhneFAaJ7KCKvxuP6meoWKVLu5FiWxheBO1wS
 dR4z/ePd0y8TFUYarphmBYlwVvVL2Uz37CR+sipSfJYjNaVSZO7d0UbZxdoPoWwby3h2ojJOgoH
 SnrZmZkhh6/iFHs1AHuqpwMfFEBa5dTc+I0IqCO4XeoIBbOlsuHO1SUPEO+SLTaQ78d3ZveGLiS
 WPJJ3eXPID48qHJ4YQw1UtzONvJIBjcghlr8f7Qp9TNOzlEaIb1noflQP3aUR1Hk+ultmOLISo
X-Received: by 2002:a05:7300:dc8c:b0:2df:7fe3:96a with SMTP id
 5a478bee46e88-3074f843547mr4387790eec.0.1780589547425; 
 Thu, 04 Jun 2026 09:12:27 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dcad34esm7497968eec.11.2026.06.04.09.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 09:12:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] eal: check for invalid memory parameters
Date: Thu,  4 Jun 2026 09:12:24 -0700
Message-ID: <20260604161224.1090419-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

The code to parse arguments like memory size, channels and rank
was using atoi() which has no check for garbage after the number.
Switch to using a helper that uses strtoull().

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_options.c | 44 +++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 1049838d73..49151c0a16 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -2062,6 +2062,29 @@ eal_parse_huge_worker_stack(const char *arg)
 	return 0;
 }
 
+static int
+eal_parse_num(const char *str, unsigned int *val)
+{
+	char *endptr;
+	unsigned long long n;
+
+	while (isspace((unsigned char)*str))
+		str++;
+
+	if (*str == '-')
+		return -1;
+
+	errno = 0;
+	n = strtoull(str, &endptr, 10);
+
+	/* Error if string is empty or has trailing characters */
+	if (*str == '\0' || *endptr != '\0' || errno != 0 || n > UINT_MAX)
+		return -1;
+
+	*val = n;
+	return 0;
+}
+
 /* Parse the arguments given in the command line of the application */
 int
 eal_parse_args(void)
@@ -2205,23 +2228,34 @@ eal_parse_args(void)
 
 	/* memory options */
 	if (args.memory_size != NULL) {
-		int_cfg->memory = atoi(args.memory_size);
+		unsigned int mb;
+		if (eal_parse_num(args.memory_size, &mb) < 0) {
+			EAL_LOG(ERR, "invalid memory size parameter");
+			return -1;
+		}
+
+		int_cfg->memory = mb;
 		int_cfg->memory *= 1024ULL;
 		int_cfg->memory *= 1024ULL;
 	}
 	if (args.memory_channels != NULL) {
-		int_cfg->force_nchannel = atoi(args.memory_channels);
-		if (int_cfg->force_nchannel == 0) {
+		unsigned int n;
+		if (eal_parse_num(args.memory_channels, &n) < 0 ||
+			n == 0 || n > 32) {
 			EAL_LOG(ERR, "invalid memory channel parameter");
 			return -1;
 		}
+		int_cfg->force_nchannel = n;
 	}
 	if (args.memory_ranks != NULL) {
-		int_cfg->force_nrank = atoi(args.memory_ranks);
-		if (int_cfg->force_nrank == 0 || int_cfg->force_nrank > 16) {
+		unsigned int n;
+
+		if (eal_parse_num(args.memory_ranks, &n) < 0 ||
+			n == 0 || n > 16) {
 			EAL_LOG(ERR, "invalid memory rank parameter");
 			return -1;
 		}
+		int_cfg->force_nrank = n;
 	}
 	if (args.no_huge) {
 		int_cfg->no_hugetlbfs = 1;
-- 
2.53.0

