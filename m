Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B41E784BE
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 20:21:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C18EC40B98;
	Sun, 28 Dec 2025 21:20:08 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 5CE0440A84
 for <dev@dpdk.org>; Sun, 28 Dec 2025 21:20:06 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so85665025e9.1
 for <dev@dpdk.org>; Sun, 28 Dec 2025 12:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766953206;
 x=1767558006; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2PVZAdm/aVlly4cKIPrVvek7t4zKvQ15pXBSKXquqss=;
 b=tfOdoFDrkAmCC184/bpbC1hM9SxusX6rs33qk1rYCNk6QKSu5g7ZpJKOfI4GyPeL2O
 WoovCVg8j3Ct7dsrVkxvgLE0I3yJzvd+Y7PS0c+G2Wj479UwDS02f05duvV3ANAakHOk
 K0Z1Nah+IiY/a6920EioCvUbT6rWJ4Fqa7O4oQe7fQ1rjuZ70OLg957qr+XdF/4zfhAt
 hi5l7F43K7HeRWb8UODTejoz+PBw2nnuP1sS3n177VIiV3Tw7RwbwQ+aH1To5ME5DCbV
 4NiBXBt8iLDjrJnq8YdQHueL5qUmz59+3RbH+bvUeysJ5qLmscxDieI4+4KjJAz668Aa
 WFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766953206; x=1767558006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2PVZAdm/aVlly4cKIPrVvek7t4zKvQ15pXBSKXquqss=;
 b=PXGDyUt4H17TL9mCPNdnIKtOlSmT8GgIITCGbMWGG3lVB2xQZMgygP3A9xVK7FdO1o
 hRSql0SI7BJpltABoVMb64Yx77rnTNvxVQ/8z0JWGMRDAi8BuB25NOitGOlRECIy2o38
 qULfpXVSZMs8AAcnkHntBd/EdyT39LMYL+t4Szpfo5MIepAV/8PkQLDulzJHRqk2y3Fz
 xarW4ePGxHprbxX2TWCQQZWY6PebxhlGAJLSzDUs3NLwV1/6uBahiYWgbMQg6gIFT+/9
 EOfWaka/N8wXTgFLVm3zzEvJoK1yAABtKSSLV08GxqKaTe1Qp8Fz98LwL/2WtPRhENxo
 YwPA==
X-Gm-Message-State: AOJu0YzZ0jQygF8qHlSGULNcbHQrwOYvrBkT2S7Atcwsl/5cCHckYToX
 kvWfiL+ZY9smuScy0yDf+/57KmpG4Gc7SaUy0YEwI3Ttx1NRMexxHQBrUJCpGrrDg5bK1yk1gW1
 b37MuWmY=
X-Gm-Gg: AY/fxX4KbKQtwbsSG4MS9YTa195ljqyj/vg41rAMe+0TfQUBo8LHreNjBJLHUJRxQYk
 e9vja6Zbs5MSrCzaBxIF0P7rotU59vOdNOT1n+LG04KCTqeQGA8RhoEz6TnYeVYEutq6Ijk1hzN
 qaOMee/LbOLHAKu/bTAnDK3sGsLeTJ3qpskiGnlmI3I3YljK1w8SAqqRd1dY4N77a5S5nGdvDaB
 agLeustERwjhTOQpiwEXPcvwc5HkNmo49JwOPoXeAwjxkAus7UTAZSPRnchmMv2Zp78t4CRHBKf
 v4SNyJNZKrTklmGz7mUT0cJCI7VM9MqzMclKRseoLcnaaEKHOjdlctw9fZmnmL1Oam9SGoRbIt4
 fgcPp65WGx/ZSryj+y8Q67NRPT2jc7VEXjUOkEben2V75AzZz06ERJgodASrCagWL2vGaQjlSqU
 3WWBssmWcFTS/RF1LZhWHCnLnBPNJHxnJQqFRWv2YiRFt+eRrbzw==
X-Google-Smtp-Source: AGHT+IFDBgnmzXpMvyvjAvv9jaZqq3XAMEDUeGN3num/4/++AWu/Lg6Q9Okkx//GjNqEdSaqLzZ65g==
X-Received: by 2002:a05:600c:828c:b0:479:3a87:2092 with SMTP id
 5b1f17b1804b1-47d19598e86mr253868285e9.36.1766953205950; 
 Sun, 28 Dec 2025 12:20:05 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3964226sm240319655e9.0.2025.12.28.12.20.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 12:20:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH v8 17/18] cfgfile: add length checks and increase line buffer
Date: Sun, 28 Dec 2025 10:56:20 -0800
Message-ID: <20251228201236.547268-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251228201236.547268-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251228201236.547268-1-stephen@networkplumber.org>
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
 lib/cfgfile/rte_cfgfile.h |  6 +++++-
 2 files changed, 39 insertions(+), 10 deletions(-)

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

