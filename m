Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD19BE92FDA
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 20:50:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B8F240697;
	Mon, 29 Dec 2025 21:49:02 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 125A340697
 for <dev@dpdk.org>; Mon, 29 Dec 2025 21:49:01 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-42fb2314f52so5246742f8f.0
 for <dev@dpdk.org>; Mon, 29 Dec 2025 12:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767041341;
 x=1767646141; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1v8e6aUWm5WXNa+aLtAVXtjf0nt1Rr3FAXZlKwQAxao=;
 b=vF/ptQVqD/Fb4KWsJn3HRYV+zdDqDoo+3zALyX4cYmkl8+pmKbeErWmws5Z3N3xaXL
 sjxrsuTq3WlLWyWFDYIPNuf2UY6akwow9NvMDDQooRRzNT4P0xN3Ut7BEO6Zks/2tboy
 xJR+8bylXkgMki3bIqTxhkRC1OyofpZVofbzO4w/2V2x6Xf61RsFgJ2ZDo7R590Ozt3h
 HNQWFcC2kE5xmey/Ffpcu1rtUXkZFdYJ1kqz2blwH+ieuNTQFB43EDbr6ROogYRP9uG8
 UOqdEEIeXDxtve/5Od2jwmf+ga38Fg3QG/W9Ew7uwddgF5dxJrycC4gc7hHla0EyhneM
 oK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767041341; x=1767646141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1v8e6aUWm5WXNa+aLtAVXtjf0nt1Rr3FAXZlKwQAxao=;
 b=bRszUrYD3Ak2SBrDg6GaUPBaTqm2RnSzkf2/UOTITVaKEhh093D4iySdmMdM4JXvbK
 7CV8CM8S3Pn3FJL0mqOWnO9F+SwBFsmgKnylyu0TlFPxph7iEbS6NnZR51kaypD/KEFZ
 GWpo4bicM099A4lf87Bht5yq+BtWr3562r6sJSa5qV1/iFfgLoByIBvcNFNqj4DynmeW
 t1HUqmbdHfsXamcyeKCThHfLlvBIDk3p8DDqbTiLqWUMAgGNIwjUGo6oSgE2LKz2OrsC
 XhEWnguIkY50/2FUej2DGT4F8JfxW5vPIfqC7W4oU1dfIxkm3sbZvWM0KyoEU9MXQPJi
 0sng==
X-Gm-Message-State: AOJu0YzIzKap6gOXn1aWB8g+j2/TsIfKCgtQKjHjojZMf1GC8YNp3PlD
 2/1+jpk6fDRH/iDsENjrWqzPAegCrNSYDqhikkRmxI7X2uxPRyqhtAu5dg4Ad1KBq9OLERN1Yen
 zBLx4Dro=
X-Gm-Gg: AY/fxX7D2Za7DjnXpWiVzBMrftHjaHnXi/hT4KuASWVkouXvOp4xbKMwMQKsCyex61F
 Z2L94ucdlKHSAiElnx33xNRjmEvBhvbwaLvIVDXnRNMb/wMuCkSQ/7/bPd5rqb+5gd9E6C1EXYy
 rZYGc/RDQVUKQ5pdvQOtfAMY1gtsTtKYZeC3vT7TRZmy4atzEaaQh2nB4ZjIseFWbT9VLvSRgEC
 TwA7qMOMNcTLE0MaMHtZfGhIgHIDgQy04sMLsg1VehV9WfXEg+zUpQDu7X+443WFC3o77aD93CP
 GPeawIOd0LPqq15yshSzxRw8RbFu11rvwX74bBcQu04SBLHgRvOUKZuI12899R2lQvHvriNTDzp
 hheusled9Gz4Dpn6DfjwyoKJBdW24EuKufHHCD7z/zJTQzczI9jCRxoAHNPM/DfE9lSjM3BtV4h
 Eyr27Xfl0nMgf64GOlVJ/Rk5xKj3MN2DH9DqLLFvPpEu55NvxEDg==
X-Google-Smtp-Source: AGHT+IHH7E1D2l2kH3OgITKGARBmEF6mi9fDMjxTY4gHVZC9is/i75r86r3/OvIc2rh9+m6QakTo/A==
X-Received: by 2002:a05:6000:2909:b0:42b:55a1:214c with SMTP id
 ffacd0b85a97d-4324e709a9dmr31866351f8f.55.1767041340653; 
 Mon, 29 Dec 2025 12:49:00 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2c4fsm64676298f8f.42.2025.12.29.12.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 12:48:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH v9 17/18] cfgfile: add length checks and increase line buffer
Date: Mon, 29 Dec 2025 11:38:15 -0800
Message-ID: <20251229204818.61231-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229204818.61231-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251229204818.61231-1-stephen@networkplumber.org>
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
 doc/guides/rel_notes/release_26_03.rst |  2 ++
 lib/cfgfile/rte_cfgfile.c              | 43 ++++++++++++++++++++------
 lib/cfgfile/rte_cfgfile.h              |  6 +++-
 3 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index d643206167..d0c504ba7b 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -94,6 +94,8 @@ API Changes
   * hash: name parameter must be less than RTE_HASH_NAMESIZE.
   * efd: name must be less than RTE_EFD_NAMESIZE.
   * tailq: name must be less than RTE_TAILQ_NAMESIZE.
+  * cfgfile: name must be less than CFG_NAME_LEN
+    and value must be less than CFG_VALUE_LEN.
 
 
 ABI Changes
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
diff --git a/lib/cfgfile/rte_cfgfile.h b/lib/cfgfile/rte_cfgfile.h
index 232c65c77b..c2caa830d6 100644
--- a/lib/cfgfile/rte_cfgfile.h
+++ b/lib/cfgfile/rte_cfgfile.h
@@ -131,7 +131,11 @@ rte_cfgfile_add_section(struct rte_cfgfile *cfg, const char *sectionname);
  * @param entryvalue
  *   Entry value to add.
  * @return
- *   0 on success, -EEXIST if entry already exist, -EINVAL if bad argument
+ *   0 on success
+ *   -EEXIST if entry already exist
+ *   -EINVAL if bad argument
+ *   -ENAMETOOLONG - entry excess CFG_NAME_LEN
+ *                   or value exceeds CFG_VALUE_LEN
  */
 int rte_cfgfile_add_entry(struct rte_cfgfile *cfg,
 		const char *sectionname, const char *entryname,
-- 
2.51.0

