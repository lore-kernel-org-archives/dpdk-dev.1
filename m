Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86602D1951B
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 23:25:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D326040DD1;
	Tue, 27 Jan 2026 00:24:59 +0100 (CET)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id C111440B9B
 for <dev@dpdk.org>; Tue, 27 Jan 2026 00:24:58 +0100 (CET)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4359228b7c6so3226069f8f.2
 for <dev@dpdk.org>; Mon, 26 Jan 2026 15:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769469898;
 x=1770074698; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=abw719rhYkgH1OwePPZEJ0D3gjIN0vOEFGcXODNTTE4=;
 b=d6IhrYDkflj0liWg0qYACnTGni2YWDK4qW6R4JgZrAxwMTOiDzW/hERz2meA7YwJqA
 dTDkExrZkDKDteUVPu/t6OxXtALYphZ/mvROgWIrCGADHrNhChtLteS95wzzkit/uE85
 P/v3OVc2NpKYq1ppUUNL9bx8lUXci8ekxXWg6D2bGixp0mdhum7aKoBolqI5I5+VkUMG
 r4V7TzH5pDdzPr1EnvIo5kLDyI10bPjCIHevJ29Xikf2/gF+XLBt5XWK5UsldC5qsFQ6
 CtijyXcvdeoWis3NCcfC5F4FXJgr00x+qmxHzx+7Y2nU7YvbZEKDvsG7iEbCxV7Imv4V
 bLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769469898; x=1770074698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=abw719rhYkgH1OwePPZEJ0D3gjIN0vOEFGcXODNTTE4=;
 b=fJCYg/xX/fhxajT0GPxetVdFJrAjqKtZGxlwnke4bTk5JF5WJnnBE8aWgcqXnOS4Bz
 C5Ph5nxBmuDR2TOJ0pw6PcIIqo8AMq5tNG0fVfVI0SJ99ndkxqkz3b+iIwj8TA7Z358g
 VPKx4kRvEhMC6kz6639tSO194rP5t6DnJIBtoKZg0HXiT53thGHGsXbZZmdK1CipcRz6
 FbVtgzFGey9l+ipAIQwNg6H4H8ip7zLOfMxwCsUKEJGI3XiNyK0G/kdyJypjKFMi7jv6
 w+OoEhVNI6Q2llGheCsNEo6dv5ZgfNmwPs/PZO1ts2bOWibXVcmqjfH+++IhMsatap/o
 2f8w==
X-Gm-Message-State: AOJu0YyAE1/jNzdKYs4+ehRWMsNi7772yiOxNVqC4WkS8hyl4TJ1JIQC
 w0W4/fY0DsFAl9kjwi9JlJtwc9zfEx0hvgoQXai5iP6olEJ0t+Q7REGRFV29GteodqAFcHtbHZV
 nmLa7
X-Gm-Gg: AZuq6aIkbEluJLhCIkwQZVSZ2c7WPtm65SCmI932hQKeUaBuOQyvIAG5nKjUNbGJEuV
 TgKZFdX7ESlYlIVYMxna6b9Fu7LZ3er+hR/wZW1zzDVZORHAbAoNTYyyQOkUDAipKvGtrLoFI4O
 4FuNR5U7c1OKCfcCW5rptkcCm6ge2M5Bb4oiUpGHxbTb9+BY0f21ranWEGk2PlMWR1C06pKxyXN
 YBaZwbFkZTSJncTbSB/+YzhByilhXewMGIzIC2uj1JELsPP0i10xdTm9h5uaeqpIaj2J/Zxcq3d
 l8lhx+T/8RBzerZRwlbQPVKe9wDlRjyV3CnEI959bLcH4yR8tH+0ZGYyRiKWgcGF+Oog61roLY9
 83M6W71kPwGTcZjTgod9XKEPnnIhPOqf27aAmsvj6XML2fGlD259EOByxaDqDqu1tlGjGstabZ/
 XLnbsFLsLAmidWCft9vzjkBwrTsdgbXbzp5LfNduv3aV9H77I4ls+KoayPS4Dx
X-Received: by 2002:a05:6000:2913:b0:435:a258:769 with SMTP id
 ffacd0b85a97d-435ca39bd49mr7631955f8f.59.1769469898382; 
 Mon, 26 Jan 2026 15:24:58 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24a6fsm33711846f8f.16.2026.01.26.15.24.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 15:24:57 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v12 12/17] eal: check tailq length
Date: Mon, 26 Jan 2026 15:22:20 -0800
Message-ID: <20260126232428.276534-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126232428.276534-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260126232428.276534-1-stephen@networkplumber.org>
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

