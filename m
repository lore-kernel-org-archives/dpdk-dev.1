Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225B7E6F086
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Dec 2025 18:16:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6384406BB;
	Tue, 23 Dec 2025 19:14:54 +0100 (CET)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54]) by mails.dpdk.org (Postfix) with ESMTP id 9B4CE406BC
 for <dev@dpdk.org>; Tue, 23 Dec 2025 19:14:51 +0100 (CET)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-64ba74e6892so6230963a12.2
 for <dev@dpdk.org>; Tue, 23 Dec 2025 10:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766513691;
 x=1767118491; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oo5zg3H0fNmA0fokTFsaNurupvoyo3paQz/7WxhEv8o=;
 b=juOiR6oDzUB0fIQwkLRVQ1R+639EgSus7Yv5eW+DKnijOl36J5V7KzoEJzCspjQsHX
 Q8B2TQ29TdVxksRPMWt+wUfGl7bp5HoLfDI9D/C7QqYgJC1iWNVOBT2t+b/LCDFecgA4
 +E3pmamMN+qu8aNLSHXHIP3isT7W/RumcK78R0y3A+ZIkmYYBP02Lj3oCXsKf7FdRPhG
 xF+LOd5ExrZXX/LMspbG2W89v1ez6Wse3a0XCcmar8kZ6O4qxk3Klo28RQ6AXgAKMrSm
 GLxkbHTrJ526VSEbs/BcsNWqpzYlF7QiYIoaniIJSrAFYNXnalSQhMFHROeDX8q2hQZD
 BXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766513691; x=1767118491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oo5zg3H0fNmA0fokTFsaNurupvoyo3paQz/7WxhEv8o=;
 b=WtpedYXBOpIKLPQz+rM8xzIE3LGPyyyy27kZalKFOpFeNYQujAYznusZkk+upmYAn0
 Mv0gL3AXIDqXQj/a8XGTy68uHBcThi0iGMBM/cavPciGeIj9EhsU1Xyc0fRipNaoW/Bi
 Zb0H4gs5Hp5ERuVG9PtrbZfpUcULjL4jGY2RHLmft7L8MUjqigep02mzJYbF076t2U0Y
 t9xb+xOK8oF6mQ8yu3gC3A5ufL4KUle3PKsBVI+SNtp2JHX+gQvj8pD1ZPdq2KQajR4i
 DztHiPVewgdrwKZwPhR/OZGJzkxxJyB06yPECln1uQuoQbfRNqWbczwtnW3aMtaZc5k5
 LhcQ==
X-Gm-Message-State: AOJu0Yy3p2U+Udec9eBG42o8VwSbdhY6FJQXA241KAd9ItrZueTlOrdN
 8UoMluMU/KyBwCxSBjQqy29qokxoBpdr2BGQJPF/ct81adq0z+Fl6BGoYZwAjgUgHOCpqMHeKkJ
 AsWkk1Rc=
X-Gm-Gg: AY/fxX4GiQsCYCXJk/rRqMOnIe23ihB2d726cYYGqlg1nysoxS5AEczZKw8mW0bVPx7
 ZKtB6w3WqqabKFpDETdMm/dWaDibjUCPbBiCQBXS/GLXqrl+oZ/MOeZufIZ1huGGbujZzTTp8Qt
 kJOVUnY4BAd4qkdWtfaOsYJtAqizL+2si6fT9vcoM8uil9QulSNLfMJmP7NMow4rp+bJIr8QkUz
 WjR+t5xr5ZftkTGdhFf5GLE2CjgjuwYHOZkPyrp8O+ildpo9KIXSMnbBMBXiZReMUf+LaQfhITE
 2UiDRcemfpDn4AfwpAlRw6FWmKKJ8kAvivsrQk7kANsF7Cy3AAYHYrekw0SD3a/aLWVVpCXD7IF
 DirkLPJ6GYQZgOoQCPzIwRbTd9oPS++z44KfbkJ7WrjnKe+tUDL+MrAQMcNdbwEylClARPtXysH
 3QjhUb7zEwYC9IhmVaSaCGx2v/2atSBXWaiWF0I/3yO/qr9lL1qQ==
X-Google-Smtp-Source: AGHT+IE+1DCXYxJY08cfGvJdK7jbqwhGzpOC2lGQj3N4yQhkxhZb+BcVKRTjpAyQCQMxg1HT1dvptA==
X-Received: by 2002:a17:907:3d91:b0:b7a:1b3:5e5d with SMTP id
 a640c23a62f3a-b8036f0a474mr1646045866b.8.1766513691116; 
 Tue, 23 Dec 2025 10:14:51 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037f3e271sm1495302566b.60.2025.12.23.10.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 10:14:50 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 17/18] cfgfile: add length checks and increase line buffer
Date: Tue, 23 Dec 2025 10:13:15 -0800
Message-ID: <20251223181418.40834-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223181418.40834-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251223181418.40834-1-stephen@networkplumber.org>
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
 lib/cfgfile/rte_cfgfile.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/lib/cfgfile/rte_cfgfile.c b/lib/cfgfile/rte_cfgfile.c
index 9723ec756f..74a8bf7aae 100644
--- a/lib/cfgfile/rte_cfgfile.c
+++ b/lib/cfgfile/rte_cfgfile.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2010-2014 Intel Corporation
  */
 
+#include <assert.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -106,6 +107,9 @@ static int
 _add_entry(struct rte_cfgfile_section *section, const char *entryname,
 		const char *entryvalue)
 {
+	if (strlen(entryname) >= CFG_NAME_LEN || strlen(entryvalue) >= CFG_VALUE_LEN)
+		return -ENAMETOOLONG;
+
 	/* resize entry structure if we don't have room for more entries */
 	if (section->num_entries == section->allocated_entries) {
 		struct rte_cfgfile_entry *n_entries = realloc(
@@ -167,12 +171,16 @@ rte_cfgfile_load(const char *filename, int flags)
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
 
@@ -219,7 +227,13 @@ rte_cfgfile_load_with_params(const char *filename, int flags,
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
@@ -260,8 +274,13 @@ rte_cfgfile_load_with_params(const char *filename, int flags,
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
@@ -341,6 +360,9 @@ rte_cfgfile_add_section(struct rte_cfgfile *cfg, const char *sectionname)
 	if (sectionname == NULL)
 		return -EINVAL;
 
+	if (strlen(sectionname) >= CFG_NAME_LEN)
+		return -ENAMETOOLONG;
+
 	/* resize overall struct if we don't have room for more	sections */
 	if (cfg->num_sections == cfg->allocated_sections) {
 
@@ -376,8 +398,6 @@ int rte_cfgfile_add_entry(struct rte_cfgfile *cfg,
 		const char *sectionname, const char *entryname,
 		const char *entryvalue)
 {
-	int ret;
-
 	if ((cfg == NULL) || (sectionname == NULL) || (entryname == NULL)
 			|| (entryvalue == NULL))
 		return -EINVAL;
@@ -391,9 +411,7 @@ int rte_cfgfile_add_entry(struct rte_cfgfile *cfg,
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

