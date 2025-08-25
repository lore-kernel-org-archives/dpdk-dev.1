Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AF5CA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:45:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB94C40E13;
	Mon, 25 Aug 2025 05:43:09 +0200 (CEST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id 0E5BC40C35
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:43:08 +0200 (CEST)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-3c6abcfd142so755421f8f.2
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093388;
 x=1756698188; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ymvl2/SRa9CX0NNIhqc5W8YKJhsXakmHx00JL09dliY=;
 b=VPEOSwAzlqrUO9iE3uEKQQolfZbKn8N3TShMNvE6P41BArYv/ukzF1vMd2/yyXrhH6
 5KX8A+S5HQmdHZpjyt0SO4NHbeI6ociaMhaauggTAapya/HAf3jHRiD8SN1MrS5IN2cc
 5O86VF5iJDDlRZowgxDs6AfztL3VEs/eAYbFMm0mENIfzrn4LD9QcS9//9j5nNAkxU5E
 Dk7uCig/5Opsjdb4eXIe2C5aSJTanmuIJrjV6xbZkgEUx3KHnclAsNnGWas7k3HY8hpR
 QZUGyYf9iMstL1ySDB1PjN3/uP/lt9QD5U/Cd73PS8MVpSzawy88f40OwygsspQ2Vc28
 YhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093388; x=1756698188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ymvl2/SRa9CX0NNIhqc5W8YKJhsXakmHx00JL09dliY=;
 b=wyEzZCmq3Gy17cuw35UsgHq4kQMDRjCtgFGQhYvAHzLxhpsCukluy8Ao8+puAlO7rH
 gqkndQKS2HAYVk5aa0hH24XhYD1en2+sA2T1jm7NhEAO+aq0Khgo8DXg2ONtcyCFGjaK
 bYZduPYFkmQX9GbBo2PwZDd9Q4iTYtBa4Mdtu5AJyqs81cgMXWf0GgGK658j3HRiLOd7
 YYliahEfr6SKHCJkioJdoQBKgdZYF1Sh9GvwTB8wen8kE1o2lQJxIvH2uln9PqKmOEjz
 abTJf8AALmeA3yiLqBG1gqkKsNG4h4FbWMKQtIGQfw1g1loskAM+DkM6QwpwzfzxGLq+
 G6Hw==
X-Gm-Message-State: AOJu0YxarRsZNCpCTrFimi+uilS1UeHiilcHDOxSTkgFTJOWOtV/2sq/
 +XjSKs2VPdeNd4MRub0Knrg0H4pQiUNYjNy+J70YyfzcEihyiiNDHYKCDdrsfsoixgHMxpwBQpu
 7jINX
X-Gm-Gg: ASbGncvuJHhs3/WJMTzQVxzdg2Y7YHnKBDfHlTz9z1dEhHQEmbCvw570sKpLnqQptQl
 OvcNWVg1RiC+oF1NIbVxbgnAgybtSeR9i7Ze0M+G47iiwElEcXwWG9atM9TqhjC+lJpBd6sQrsF
 Zoj23H34AfHoBQQ53OrTRWzR+qcBsc9zS70KlmypEuUvmc3f+tOM9wyJdfAgEgVZ2NB+fq3bgNM
 7r88y2ldIg3yinsgW3tYn7aacGm0KO3FxgJCVmnNi5ISvZo96+lRUWpdRxeWWMi4Hh4vIJZ7Jt/
 qoVO8EAoqU1TU7VHYUziaNuwPf8WXYwMaICWVIgddnF5f2MKQfkixabNpNVoEYf56Ukx1eKKzA5
 C5TOPr0ktNvV4dNKm7ilDUkKHQPf+qyHtwNayyR6d6QBci99SKBi5LOZgdJWTy0sFUb49Dlfm
X-Google-Smtp-Source: AGHT+IEc75qoAffp8vtlBvpKta35w/TwoEHLTz6jnlCBWGFKe7MsgalZLqWK0vo6q1CsH1sw1gAepQ==
X-Received: by 2002:a05:6000:2404:b0:3b7:9b81:73f6 with SMTP id
 ffacd0b85a97d-3c5dcff3702mr9153887f8f.54.1756093387658; 
 Sun, 24 Aug 2025 20:43:07 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:43:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Rosen Xu <rosen.xu@altera.com>
Subject: [PATCH v2 38/43] raw/ifpga: replace with TAILQ_FOREACH_SAFE
Date: Sun, 24 Aug 2025 20:38:51 -0700
Message-ID: <20250825034126.12046-39-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825034126.12046-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250825034126.12046-1-stephen@networkplumber.org>
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

There is now a standard macro to safely walk tailq.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/raw/ifpga/base/ifpga_enumerate.c         | 6 +++---
 drivers/raw/ifpga/base/opae_hw_api.h             | 1 -
 drivers/raw/ifpga/base/opae_intel_max10.c        | 8 +-------
 drivers/raw/ifpga/base/osdep_rte/osdep_generic.h | 1 +
 4 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/raw/ifpga/base/ifpga_enumerate.c b/drivers/raw/ifpga/base/ifpga_enumerate.c
index 61eb6601ea..f8507fdf46 100644
--- a/drivers/raw/ifpga/base/ifpga_enumerate.c
+++ b/drivers/raw/ifpga/base/ifpga_enumerate.c
@@ -6,6 +6,8 @@
 #include <inttypes.h>
 #include <unistd.h>
 
+#include <rte_bsd_queue.h>
+
 #include "opae_hw_api.h"
 #include "ifpga_api.h"
 
@@ -725,9 +727,7 @@ static void dfl_fpga_enum_info_free(struct dfl_fpga_enum_info *info)
 		return;
 
 	/* remove all device feature lists in the list. */
-	for (dfl = TAILQ_FIRST(&info->dfls);
-		dfl && (tmp = TAILQ_NEXT(dfl, node), 1);
-		dfl = tmp) {
+	TAILQ_FOREACH_SAFE(dfl, &info->dfls, node, tmp) {
 		TAILQ_REMOVE(&info->dfls, dfl, node);
 		opae_free(dfl);
 	}
diff --git a/drivers/raw/ifpga/base/opae_hw_api.h b/drivers/raw/ifpga/base/opae_hw_api.h
index 57750022dd..f95bdf35b6 100644
--- a/drivers/raw/ifpga/base/opae_hw_api.h
+++ b/drivers/raw/ifpga/base/opae_hw_api.h
@@ -8,7 +8,6 @@
 #include <stdint.h>
 #include <stdlib.h>
 #include <stdio.h>
-#include <sys/queue.h>
 
 #include "opae_osdep.h"
 #include "opae_intel_max10.h"
diff --git a/drivers/raw/ifpga/base/opae_intel_max10.c b/drivers/raw/ifpga/base/opae_intel_max10.c
index 58c884a8d8..84e0767b3a 100644
--- a/drivers/raw/ifpga/base/opae_intel_max10.c
+++ b/drivers/raw/ifpga/base/opae_intel_max10.c
@@ -4,14 +4,8 @@
 
 #include "opae_intel_max10.h"
 #include <libfdt.h>
-#include "opae_osdep.h"
 
-#ifndef TAILQ_FOREACH_SAFE
-#define TAILQ_FOREACH_SAFE(var, head, field, tvar) \
-	for ((var) = TAILQ_FIRST((head)); \
-		(var) && ((tvar) = TAILQ_NEXT((var), field), 1); \
-	(var) = (tvar))
-#endif
+#include "opae_osdep.h"
 
 int max10_sys_read(struct intel_max10_device *dev,
 	unsigned int offset, unsigned int *val)
diff --git a/drivers/raw/ifpga/base/osdep_rte/osdep_generic.h b/drivers/raw/ifpga/base/osdep_rte/osdep_generic.h
index d4e634c9d2..0ff2700384 100644
--- a/drivers/raw/ifpga/base/osdep_rte/osdep_generic.h
+++ b/drivers/raw/ifpga/base/osdep_rte/osdep_generic.h
@@ -8,6 +8,7 @@
 #include <stdlib.h>
 
 #include <rte_common.h>
+#include <rte_bsd_queue.h>
 #include <rte_cycles.h>
 #include <rte_spinlock.h>
 #include <rte_log.h>
-- 
2.47.2

