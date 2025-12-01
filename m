Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13ACD116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 22:04:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D09C4064C;
	Mon,  1 Dec 2025 23:04:30 +0100 (CET)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id E77FB4042C
 for <dev@dpdk.org>; Mon,  1 Dec 2025 23:04:28 +0100 (CET)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-8b25dd7ab33so296121885a.1
 for <dev@dpdk.org>; Mon, 01 Dec 2025 14:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764626668;
 x=1765231468; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MNKd2hEyFhSqzVQ7OOBt1Lj6Yji9f0uL7siww9edlW0=;
 b=iQw2HlrlKQzgV9GBlT4/WzczUrR2YMJsmalenUDlm29BRo8514kc8/x/igLzLCFWMf
 1x3TsalS10gU7ruR6fHC3yz6SbW1Y8BwRYCIOLctWYx7B9I0wvdiaMSxYtF7gzn+9p1H
 U95XS3eeC56VUJ6wU87Bk8/mjAurTrXspF8a+TLiK/MkYTAND4ClJQWWKOEBdULNg+64
 HU2qCO0CVEqnHEiuc0dSWPqMIshaCEBBX+Qpq9HPfkTzRphfJNqt0L6QRcPFroUymAO+
 z+HRDtfOFbTD8wZNv4LOHZNCdfOoJIvZxjAm5XLRajxHSVx9xEV90jqVbg3hURYOWUhU
 rZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764626668; x=1765231468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MNKd2hEyFhSqzVQ7OOBt1Lj6Yji9f0uL7siww9edlW0=;
 b=TwcfIMKPANSz0E+4FbwtJQl6aXtruenS/FaBbMsVXCx767zjiCKjkcNah+RC9qNZZJ
 aOkbZ5PXRgkeXMJ9yzWHi0zKahIHIvSoGABy/DX0x7LX/FGNb5m8mkQznhkMYHh4T1X7
 fmjDTYrTqmNfQxZkKRemRH/Js9uN3VUqGpjjU9wQuPNrwsmePz5RTZcrJzH6s4yKGB/U
 L2VrkoRE7u/OPUY5H8BPIjqGpd5WIOjOcteAgoh8h7qzc6ZT6mp17Ra/LVYE4Q0+Koqq
 2hKcBdI1jZGuoaz8aIH3jRkafx8k4ezL7fDrIhtEqVH6EMOMBmRPLpIsDhuCCmiIcXZD
 Tgkw==
X-Gm-Message-State: AOJu0Yz4wjWg+OFe7PIX3AepAjjI0j6iKbj1EmtP4/YekjlifNVaL5uZ
 qqMDohVgd7K11bYTtfG4T9QygLJWfuDTYZHCd7ls4TbAUeEwqerAtaNm3TspVAVcBVOUOacbfRU
 pLEJj
X-Gm-Gg: ASbGncukSPennc0P4qjzhzGBHEM3n3QtM/zGvTZMT9urCvI1/6SuPVu/Nkdsxm9d3v2
 jt8MGwch2spzRITPh9QrkNHAQ49Qb3K9fIJJteDnsOne+hOtHBe/pAo7hwc0yxZokNox3/P+NSr
 GjUftR3XbuDO3ItwTavhEcrcOXpZuI6MJCMOmYD3upquYXco49We0OyxlcsoKakufMURntkzzeX
 ysZ2GKqOwsknkRkLlbs1nE008LLnqFHU0SOzuggpRZhacGyx6pDwiLUHYI90xATuLvK2jU9y0IG
 2P/ls2XxL1nFw67kCf82/A1H+WW2b30OXwk0wssTPe5vcRoEOaEKQ9HTLOVLr5OqwYVCYMYuG4N
 SWmyWnLUPEllwJaTA0Z8jmBnhBD+//H60DdedPe+R+7J88yzAIa6xHp2pVo6qzSJobIQbrioU/1
 +R25+dZHDFjVdslnRORjBP71r+k0Y0p1Fzs28WlFFZ/diuWnH/Eg==
X-Google-Smtp-Source: AGHT+IGfi8Z9wmOBvBp9nkaWRzOMlRjxjd0ty/63lZbyoIsI/NQyZz+YHKEtKY4cVJQC9rIezaS5cg==
X-Received: by 2002:a05:620a:7104:b0:8b2:6606:edaf with SMTP id
 af79cd13be357-8b4ebd6a937mr3872015085a.37.1764626668078; 
 Mon, 01 Dec 2025 14:04:28 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b52a1cad4esm934398885a.45.2025.12.01.14.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 14:04:27 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 2/9] test: add new function to get current file-prefix arg
Date: Mon,  1 Dec 2025 14:02:00 -0800
Message-ID: <20251201220421.207285-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201220421.207285-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251201220421.207285-1-stephen@networkplumber.org>
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

Refactor so that there is one function to get current argument
for "--file-prefix=XXX".

The code does not need to initialize all these 4K buffers since
they are directly used by functions that set them.
The maximum sizeof of the current DPDK prefix is NAME_MAX (128)
not PATH_MAX(4096) so save a significant amount of space.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/process.h | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/app/test/process.h b/app/test/process.h
index f948a89786..251262d948 100644
--- a/app/test/process.h
+++ b/app/test/process.h
@@ -199,15 +199,22 @@ process_dup(const char *const argv[], int numargs, const char *env_value)
 	return status;
 }
 
-/* FreeBSD doesn't support file prefixes, so force compile failures for any
- * tests attempting to use this function on FreeBSD.
- */
+/* FreeBSD doesn't support file prefixes, so no argument passed. */
+#ifdef RTE_EXEC_ENV_FREEBSD
+static inline const char *
+file_prefix_arg(void)
+{
+	/* BSD target doesn't support prefixes at this point */
+	return "";
+}
+#else
+
 #ifdef RTE_EXEC_ENV_LINUX
 static inline char *
 get_current_prefix(char *prefix, int size)
 {
-	char path[PATH_MAX] = {0};
-	char buf[PATH_MAX] = {0};
+	char path[64];
+	char buf[PATH_MAX];
 
 	/* get file for config (fd is always 3) */
 	snprintf(path, sizeof(path), "/proc/self/fd/%d", 3);
@@ -216,10 +223,29 @@ get_current_prefix(char *prefix, int size)
 	if (readlink(path, buf, sizeof(buf)) == -1)
 		return NULL;
 
-	/* get the prefix */
+	/*
+	 * path should be something like "/var/run/dpdk/config"
+	 * which results in prefix of "dpdk"
+	 */
 	rte_basename(dirname(buf), prefix, size);
+	return prefix;
+}
+
+/* Return a --file-prefix=XXXX argument or NULL */
+static inline const char *
+file_prefix_arg(void)
+{
+	static char prefix[NAME_MAX + sizeof("--file-prefix=")];
+	char tmp[NAME_MAX];
 
+	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
+		fprintf(stderr, "Error - unable to get current prefix!\n");
+		return NULL;
+	}
+
+	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
 	return prefix;
+#endif
 }
 #endif
 
-- 
2.51.0

