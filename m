Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FBBC02198
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 17:01:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 339CC40E11;
	Sun, 16 Feb 2025 18:01:26 +0100 (CET)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id CCDB44065F
 for <dev@dpdk.org>; Sun, 16 Feb 2025 18:01:22 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2fc20e0f0ceso4283584a91.3
 for <dev@dpdk.org>; Sun, 16 Feb 2025 09:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739725282;
 x=1740330082; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHYdq434PJealTXPJqVJdnEDtH8hAF0XExmSu/YBuaY=;
 b=PadNLAShTxV4WTzfl6zpRLh++g1zAPXFSE2X3RCQGT2qZP68SvIzt6u89Dut5Zrrc6
 jo/biZT2K+B9sknbxzyHtaZzCD1Xs4Fx7I/jXMb2EPMxyQzkmGd5sCLPNVEln0iy04WS
 9qycXYef5LcSQT74034LLSX8hHj4TQziZZweRNYuONx8v2HgxOf33HxsF+LdwNaFiqyU
 wePDHiGj9KTDhOOarpvKQUCi3XbU0jaZfz6+SCSjn6DU6TwGRH2kbVVJr0PfIGeG7zoH
 y6lSgGTlvkK2Bx8IiKt/gBOjhabzqEZm0OIEdnbz5/erbQ6sYPWDf8c6vEyi/lWsN7R/
 heqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739725282; x=1740330082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XHYdq434PJealTXPJqVJdnEDtH8hAF0XExmSu/YBuaY=;
 b=gK5GD6SRQjzeaF4SJYRuaGH4t9XfgmYQ/reoWIxh73yqi0Chhm3wfD1v19y6IWwRqc
 eHZMEhLFo0IQ5ZScaqrpyfjN54gJworaj4hO/wsQXtZrLgpzQNg/ekhAX4ZfO05XC4L0
 vAyDAdgch+p62eaAp/g2F9B9F2QCvlShc86qzDldBTEMFjU6w9c7Z1esxToeTK3IeZNl
 sGEYc2w7tCK6OcY68OnFxN0drIXwTEBF8/7NFfI2Oz7Js/LSg5S0cfqKb1BG60O3rqEZ
 sD1FCMmdAQMc8S0WUjlN4HDdKaXMg78+OTJloTl9amcYLOFnkDzfCIScGBtaEDFtche9
 fu7Q==
X-Gm-Message-State: AOJu0YzZBYSHNYsIN065yilocL1SiZUzw0e4MNX4oeqmDGEg59SPiixf
 jUhjsXnJQM39SBTURljpqaCyuG+VwkI6Cniq5TCjwYeQ9FYWsTvOZCobbazH/qNXNRaI4PNIB3p
 m
X-Gm-Gg: ASbGnctohfjw3K3L4PnQQ3YDKLRw7PQ3Zdo1m/CyRhAjphwVaXs2SnQbdBo6+yWwLLy
 kSZBMyiDtB1BF4kJasfmQbzJqJqtWNdRuKRocw0MQwxCfSbWOkl3TIFkjQtiq5Ezoyrl+0xTlmH
 cmEoyQ1Vz/O8l0GppGCge0iIq9imNlsGueYMiIVozYOa6QaEWD9N4zr2iH/0kdiyh8JfMN/ydxq
 EcCi8XQhpI28SRgzW26FunYu2Fwfkho7moBu3/tHi8dX3GGbKq6YpI8RFvcE/5qrnO9ASLPle7Q
 s+ouGmytXclLVcUy9AU7RskpdK7/zM9XizyYcnQywj1FgVwA9rnkDrT0rRqseKYhJE+J
X-Google-Smtp-Source: AGHT+IE/QljnUSSJ+2onFGNSRLtrSLjqBVsQcvDLAGNIkD4geyIwhop4QK4k0dUI9PY9BGmcxOUCpQ==
X-Received: by 2002:a17:90b:3ec5:b0:2fa:20f4:d27a with SMTP id
 98e67ed59e1d1-2fc40d12e34mr11567577a91.7.1739725281897; 
 Sun, 16 Feb 2025 09:01:21 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2211eafd20dsm11196805ad.182.2025.02.16.09.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 09:01:21 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v8 02/17] app/test: use unit test runner for string tests
Date: Sun, 16 Feb 2025 08:53:01 -0800
Message-ID: <20250216170110.7230-3-stephen@networkplumber.org>
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

Switching to unit test table makes it easier to add new tests.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_string_fns.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/app/test/test_string_fns.c b/app/test/test_string_fns.c
index 3b311325dc..ce07c17228 100644
--- a/app/test/test_string_fns.c
+++ b/app/test/test_string_fns.c
@@ -205,16 +205,20 @@ test_rte_str_skip_leading_spaces(void)
 	return 0;
 }
 
+static struct unit_test_suite test_suite = {
+	.suite_name = "String functions tests",
+	.unit_test_cases = {
+		TEST_CASE(test_rte_strsplit),
+		TEST_CASE(test_rte_strlcat),
+		TEST_CASE(test_rte_str_skip_leading_spaces),
+		TEST_CASES_END()
+	}
+};
+
 static int
 test_string_fns(void)
 {
-	if (test_rte_strsplit() < 0)
-		return -1;
-	if (test_rte_strlcat() < 0)
-		return -1;
-	if (test_rte_str_skip_leading_spaces() < 0)
-		return -1;
-	return 0;
+	return unit_test_suite_runner(&test_suite);
 }
 
 REGISTER_FAST_TEST(string_autotest, true, true, test_string_fns);
-- 
2.47.2

