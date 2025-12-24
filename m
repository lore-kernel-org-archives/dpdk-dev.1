Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F0EE78498
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Dec 2025 22:14:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7F1D40A76;
	Wed, 24 Dec 2025 23:13:57 +0100 (CET)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id CAAE840A73
 for <dev@dpdk.org>; Wed, 24 Dec 2025 23:13:56 +0100 (CET)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-42fbc305882so3125072f8f.0
 for <dev@dpdk.org>; Wed, 24 Dec 2025 14:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766614436;
 x=1767219236; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4zVMWB0SFOF9S/VljVvWvCx3VF/fOMeVOx25MYzPOv0=;
 b=mSJk7Yh0zaMCf5CsbGMkwZOTUuSkm/OjUqEjTrtemcnRqqph3SXO6HQ9t34K7TY70r
 fTUQ+lP9tnk6KNCR44YbWKisP7E2WXeax2b/HC9W+wD5JvN21kuLVNlCnulf9VZMTIf9
 t7P5HZCRHe3Pu4BrbeRyRNQfGQaeZWrNlwMlxP/HtdmkXKUPf+pu43WnLufhemtWo8BQ
 bZdZMFvHZdUH7R7lZZvLC7hab2Zz61oUxy9lG2iMCDHi1WmyC5qph4RoB0C5l2uaMcMO
 g04HLFLx/9lYlr+IpcIZeHEFsDCotRkgoQBQdMSB2JeU3DxaGzCGiQn3fyNKup2Hlch5
 EtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766614436; x=1767219236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4zVMWB0SFOF9S/VljVvWvCx3VF/fOMeVOx25MYzPOv0=;
 b=TIQ9WFbgZzxRYokQKp7LldV9RMra0d30AQyYnh2XxXxTrr7KSGL7hTbbgDWJdchBNV
 BoH6tnvRMvsr+JNTh6TK51Jni8sMAdhsV+AfKYa5z4TjL4SsG6UhVhb8iUUPKc26B+ec
 oNTbBgu9IOynwqKgB1Ux6mfJlbaFtgwxpPcCZYjmgRuKzaH7QM7gW1pm95B2WSYXmKDD
 kYcqSVGxHkMqkM7vhUnkwGj/1QVT5ZoeuyS7o41NNJdB7edlz0XKZtZByfKiwmNTwIwL
 SvBhxK3foieNf5yaOKobzpkkZdr+c8HyY30Y1/Wvd+ACNOxZbA9Wvn0w2QJzD/8m7v6i
 gznQ==
X-Gm-Message-State: AOJu0YyPCql8zpuVj43EvX/p+7e2cMOi89kJbEYhjDe07QsgG5Vrvy67
 PD3ak+SYxle3en13aSRgWIUGpwpnKFKlj6MrqLSDuU4dh5bIBvpetqbhkyIpaYzt8JaUzZLrecY
 3WZvHZSw=
X-Gm-Gg: AY/fxX4UYCkME+QLJY8p8WR6ykreFHAwGmnxDCqE+jDf9v/bQ/1Lca7kbvXSjE2VRbq
 3w7khsPexHal6PD1v0IZqe4r3iKkI3aZxemx/AgurL8cDvpJ7/6J1x0x2ubNepTPFsVCy+6TytS
 XveODtv4SLWCxIWNWLQx9URKVVQ0+zXf7Q0FB4W2DT2jIVlGviGjfHCch+gY9WRcX9WKodnaVj3
 tu7UZgBJDmqu8GaYIy6TV6gzwK592ya6+kMnN96Tl9VGtdZehMGJ8iGA2yagrLi10Ab0qJbnnV3
 iiYW58Fg9gJVxUTBRGzNS5hoEjAe6L6/jLhvNj+fcb1VsiK9KgDZCWrrMHfxSuSSIjzQdLZke4H
 wEWRfQF4xZDc8rdC8ZNsE3AUMPUtYLY/ScB3BBjwMO/DlLCheObNo6ZA5Dvgi4yd1klX1vBuk+7
 yCYW9ZDG/UIoAPypn1SiHC9ocDkPmsOxSZ41QerMp54m3Kleg9Dg==
X-Google-Smtp-Source: AGHT+IGknQYnl4sC0eo/aOH/9/hnegslHQ4QIzv0xItBVDKQDWzfiRnPrhPCx55VslrCQVbYqKnz6A==
X-Received: by 2002:a05:6000:2dc5:b0:430:f23f:4bc5 with SMTP id
 ffacd0b85a97d-4324e50684cmr23002649f8f.45.1766614436359; 
 Wed, 24 Dec 2025 14:13:56 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830fesm36796622f8f.20.2025.12.24.14.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 14:13:55 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH v7 17/18] cfgfile: add length checks and increase line buffer
Date: Wed, 24 Dec 2025 14:11:58 -0800
Message-ID: <20251224221301.52714-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224221301.52714-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251224221301.52714-1-stephen@networkplumber.org>
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

When adding values to config info, add string length checks instead
of silently truncating. Increase the size of the buffer used to read
from a config file so that there will be enough space for longest
entries.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/cfgfile/rte_cfgfile.c | 43 +++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/lib/cfgfile/rte_cfgfile.c b/lib/cfgfile/rte_cfgfile.c
index 9723ec756f..1aa8f4a597 100644
--- a/lib/cfgfile/rte_cfgfile.c
+++ b/lib/cfgfile/rte_cfgfile.c
@@ -2,16 +2,24 @@
  * Copyright(c) 2010-2014 Intel Corporation
  */
 
+#include <assert.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <ctype.h>
 #include <errno.h>
+#include <limits.h>
+
+#ifndef LINE_MAX
+#define LINE_MAX 2048
+#endif
+
 #include <eal_export.h>
 #include <rte_string_fns.h>
 #include <rte_common.h>
 #include <rte_log.h>
 
+
 #include "rte_cfgfile.h"
 
 struct rte_cfgfile_section {
@@ -106,6 +114,9 @@ static int
 _add_entry(struct rte_cfgfile_section *section, const char *entryname,
 		const char *entryvalue)
 {
+	if (strlen(entryname) >= CFG_NAME_LEN || strlen(entryvalue) >= CFG_VALUE_LEN)
+		return -ENAMETOOLONG;
+
 	/* resize entry structure if we don't have room for more entries */
 	if (section->num_entries == section->allocated_entries) {
 		struct rte_cfgfile_entry *n_entries = realloc(
@@ -167,12 +178,16 @@ rte_cfgfile_load(const char *filename, int flags)
 					    &default_cfgfile_params);
 }
 
+/* Need enough space for largest name and value */
+static_assert(LINE_MAX > CFG_NAME_LEN + CFG_VALUE_LEN + 4,
+	      "not enough space for cfgfile name/value");
+
 RTE_EXPORT_SYMBOL(rte_cfgfile_load_with_params)
 struct rte_cfgfile *
 rte_cfgfile_load_with_params(const char *filename, int flags,
 			     const struct rte_cfgfile_parameters *params)
 {
-	char buffer[CFG_NAME_LEN + CFG_VALUE_LEN + 4];
+	char buffer[LINE_MAX];
 	int lineno = 0;
 	struct rte_cfgfile *cfg;
 
@@ -219,7 +234,13 @@ rte_cfgfile_load_with_params(const char *filename, int flags,
 			*end = '\0';
 			_strip(&buffer[1], end - &buffer[1]);
 
-			rte_cfgfile_add_section(cfg, &buffer[1]);
+			int ret = rte_cfgfile_add_section(cfg, &buffer[1]);
+			if (ret != 0) {
+				CFG_LOG(ERR,
+					"line %d - add section failed: %s",
+					lineno, strerror(-ret));
+				goto error1;
+			}
 		} else {
 			/* key and value line */
 			char *split[2] = {NULL};
@@ -260,8 +281,13 @@ rte_cfgfile_load_with_params(const char *filename, int flags,
 			if (cfg->num_sections == 0)
 				goto error1;
 
-			_add_entry(&cfg->sections[cfg->num_sections - 1],
-					split[0], split[1]);
+			int ret = _add_entry(&cfg->sections[cfg->num_sections - 1],
+					     split[0], split[1]);
+			if (ret != 0) {
+				CFG_LOG(ERR,
+					"line %d - add entry failed: %s", lineno, strerror(-ret));
+				goto error1;
+			}
 		}
 	}
 	fclose(f);
@@ -341,6 +367,9 @@ rte_cfgfile_add_section(struct rte_cfgfile *cfg, const char *sectionname)
 	if (sectionname == NULL)
 		return -EINVAL;
 
+	if (strlen(sectionname) >= CFG_NAME_LEN)
+		return -ENAMETOOLONG;
+
 	/* resize overall struct if we don't have room for more	sections */
 	if (cfg->num_sections == cfg->allocated_sections) {
 
@@ -376,8 +405,6 @@ int rte_cfgfile_add_entry(struct rte_cfgfile *cfg,
 		const char *sectionname, const char *entryname,
 		const char *entryvalue)
 {
-	int ret;
-
 	if ((cfg == NULL) || (sectionname == NULL) || (entryname == NULL)
 			|| (entryvalue == NULL))
 		return -EINVAL;
@@ -391,9 +418,7 @@ int rte_cfgfile_add_entry(struct rte_cfgfile *cfg,
 	if (curr_section == NULL)
 		return -EINVAL;
 
-	ret = _add_entry(curr_section, entryname, entryvalue);
-
-	return ret;
+	return _add_entry(curr_section, entryname, entryvalue);
 }
 
 RTE_EXPORT_SYMBOL(rte_cfgfile_set_entry)
-- 
2.51.0

