Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83E1D340A6
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 16:34:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5ADE8410DD;
	Tue, 27 Jan 2026 17:33:31 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id BFD1F410DD
 for <dev@dpdk.org>; Tue, 27 Jan 2026 17:33:29 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-42fed090e5fso3619716f8f.1
 for <dev@dpdk.org>; Tue, 27 Jan 2026 08:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769531609;
 x=1770136409; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=abw719rhYkgH1OwePPZEJ0D3gjIN0vOEFGcXODNTTE4=;
 b=dsZ2xblPEdMNeydrE8+vMVyXMPdq69m6jaCa7kqTkFnqD5eT9rL+pBDzWJ9jbelWDf
 wkU+vskmyfVFMOMxU0u404AVDoMtZW9mzFyc2okwDBhburk2Z0GqP5F5gsPhhBJZ1Sl5
 pbflFhvDYUeUAhrni1HhyG+r9lrHmg26R0fRVWTIsUhLC0QOLPMBdmmHdGTpiQaUwpdt
 Tk3qVV/0UW/kuFQCY9HnriOv3aQVYHQ9igcaOBIEXWGvV0tg0ZcwOhF4K2nNrEN8a0D5
 bPgLa2osGAjrG4obb8/Ww5RfLRaJ+1Ax+dByscLV0avAJCss8tXSuHNDJHWX0yRgu9A1
 N/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769531609; x=1770136409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=abw719rhYkgH1OwePPZEJ0D3gjIN0vOEFGcXODNTTE4=;
 b=vzYp/cyMv2M+w9xfEa/QwwTSoc/8jqIZCTbTuesEcB3k1fljqV/CLU5ITkCxzSSSsS
 6xnUXPQgWb43glPzXilj/mjZ4xPrHU1lDNbRmZlM+boDGc2xiYO313XnpKTWZBuathf8
 9X2rzhLIkBAobtBSItdBrLw5Krl31dKmaCJGuJG0lE5wP21VBrL0jwUOFfNQ3rgeoDxe
 Za1ydBMA4NWbgrfQ8mGYGQmJGUNXzzC/E3QROxbPaJePxpm8jRTortFb477bNR1LIndo
 bkhIYQ7yM7XPFgFQa66YEkzQJpP0qMvfkj69YMmNtT4wn3imVP04tcRFwXIqT6xDt2lQ
 7Sog==
X-Gm-Message-State: AOJu0Yy/O4gPal7uZf4dxMHjP7tsVtpm7ELxPZHLLKBuSpCYKiLYyjXj
 DFLipIDMLiBkDBtCFJdaROpD4pFriWVHQY/cOBXqHiOkI/a2dVNZsCgGyqkuJTfc0IKDCdHxpP9
 NG0Lb
X-Gm-Gg: AZuq6aKSMMwcixnNhgf0d5zlXHYH23Y1DL0dct3x43t/PTr2L3mLOhEZk5SDlAaatk5
 oVmmbvR3aKLsQRvHwBP4QBy9PJVoWV9ZsX3CaHXlhZaXK6sfMaPai95rUJ75b3x9piqrY20Qtwo
 w/LRyG898qh/j7rTY4WymXpLGdOs35oPX7HyRGQ1jFZ+vIS1MaJc7iMjZKVOZYxCGEm2vc5B1Gc
 ApCMV9lFkAoqUtKiBL3Z4yLa/45O+t+khrcfOmIenwRZmMyRxI3sIsbABCv4Y5GB8ptYd+0T7IB
 TxKCifKg17ilC1OREX7ogF0H6PvcDpzDHmGtWFLJV6gP+BSRlfwFN//wCpEhrrWhAKHN8IcjarW
 89DhkVqotE7yfJGu9fgC2rN3kDFHScQJPoaxwuvBUGXRaKhxbqKGJ1ZeVVvERzxX54ESv0CZgxu
 jmBHyPYY6At0smW1NyJUs5DF51RrJ1M6TnouOZX40tvlIVj5kgVA==
X-Received: by 2002:a5d:64e8:0:b0:435:95dc:b8ca with SMTP id
 ffacd0b85a97d-435dd0a3e5cmr3725853f8f.40.1769531609234; 
 Tue, 27 Jan 2026 08:33:29 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f745dbsm39978513f8f.34.2026.01.27.08.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:33:28 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v13 12/17] eal: check tailq length
Date: Tue, 27 Jan 2026 08:30:26 -0800
Message-ID: <20260127163258.75566-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127163258.75566-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260127163258.75566-1-stephen@networkplumber.org>
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

The tailq name should not be allowed to exceed limits.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/rel_notes/release_26_03.rst |  1 +
 lib/eal/common/eal_common_tailqs.c     | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 91b1808455..d643206167 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -93,6 +93,7 @@ API Changes
   * lpm: name must be less than RTE_LPM_NAMESIZE.
   * hash: name parameter must be less than RTE_HASH_NAMESIZE.
   * efd: name must be less than RTE_EFD_NAMESIZE.
+  * tailq: name must be less than RTE_TAILQ_NAMESIZE.
 
 
 ABI Changes
diff --git a/lib/eal/common/eal_common_tailqs.c b/lib/eal/common/eal_common_tailqs.c
index 47080d75ac..c581f43b6f 100644
--- a/lib/eal/common/eal_common_tailqs.c
+++ b/lib/eal/common/eal_common_tailqs.c
@@ -8,6 +8,7 @@
 
 #include <rte_eal.h>
 #include <rte_eal_memconfig.h>
+#include <rte_errno.h>
 #include <rte_log.h>
 #include <rte_string_fns.h>
 
@@ -30,8 +31,10 @@ rte_eal_tailq_lookup(const char *name)
 	unsigned i;
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
 
-	if (name == NULL)
+	if (name == NULL) {
+		rte_errno = EINVAL;
 		return NULL;
+	}
 
 	for (i = 0; i < RTE_MAX_TAILQ; i++) {
 		if (!strncmp(name, mcfg->tailq_head[i].name,
@@ -39,6 +42,7 @@ rte_eal_tailq_lookup(const char *name)
 			return &mcfg->tailq_head[i];
 	}
 
+	rte_errno = ENOENT;
 	return NULL;
 }
 
@@ -67,6 +71,12 @@ rte_eal_tailq_create(const char *name)
 {
 	struct rte_tailq_head *head = NULL;
 
+	if (strlen(name) >= sizeof(head->name)) {
+		EAL_LOG(ERR, "tailq name '%s' is too long", name);
+		rte_errno = ENAMETOOLONG;
+		return NULL;
+	}
+
 	if (!rte_eal_tailq_lookup(name) &&
 	    (rte_tailqs_count + 1 < RTE_MAX_TAILQ)) {
 		struct rte_mem_config *mcfg;
@@ -115,6 +125,7 @@ rte_eal_tailq_register(struct rte_tailq_elem *t)
 	if (rte_eal_tailq_local_register(t) < 0) {
 		EAL_LOG(ERR,
 			"%s tailq is already registered", t->name);
+		rte_errno = EEXIST;
 		goto error;
 	}
 
-- 
2.51.0

