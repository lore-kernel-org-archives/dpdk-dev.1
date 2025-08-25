Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A23ACA0EFA
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:44:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04D5140DD8;
	Mon, 25 Aug 2025 05:42:59 +0200 (CEST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id C49094065B
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:42:52 +0200 (CEST)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-3c6ae25978bso1493687f8f.0
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093372;
 x=1756698172; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C7+l7ufHhLeoJJSQYpu+KH6N2A5u6GubIYvfdwxubCE=;
 b=Zy8Vp6M6afJtqU0E8sNxQmGxylqi6pW+4WSr6JrGjHHgyosLQIC8xFNN5htrB/yiQU
 TByFg9F4d/vpIFfd5h+TQAZG9IAvPXw68ZeiiJe6Tpt5wVxlnwOPnAWoJfzcqTuATslE
 DqYxuGtttG/uqE5HU1L2wgjAI/IYy/XwK+wJbvP1HbP8VQVP/XXh1WQGuy3kQe3DQDN/
 IhdOe3nTkLQ3GzPYFYqDjjMjkey1Ibnh+HtH5pVlZ0wx0JCp9LDn3kXp1ygHe0p6tqyB
 OYqo2uXnmk/oAkyyv/fk0rC+VfmGZ2ISwE8gIpsVM2DfYMN7F11APoHQJbXols0uTLIU
 Kotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093372; x=1756698172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C7+l7ufHhLeoJJSQYpu+KH6N2A5u6GubIYvfdwxubCE=;
 b=u8EUCHuORGPRZJ+0ohibkyycuCGJIfkg1XbetbuO6baFn/JiO0aoS7fRZx9jy7OhlD
 dkqf0bUjZvComoXToee22xDbfDbFHac80Zcw+rglUl6IYhsgJb8RNwngmnzAW4dhdT94
 bjeeg9Mjtu0eCkU8Jdth6qekB7dbdkzganAGMv/b21cmsrCiKEZtJIOUJS41ZWODQYLH
 Yr74mG35T5FELOPggTcl/++expRpZF/r8Wf8i/aAzAj4QSJdJk5eQnwBCq5gZlOwUYfl
 JxKHhYZ6jYpmIgpwTdDoq7poVXi9B53dzdkFQ/ywbpDDV7q0N/6pJd+ub5081YTXW/N2
 27Ow==
X-Gm-Message-State: AOJu0Yz/PTONs1tY13rzSNvaZd7v8brmtnzdvyCT5+KxHMAvMSbAb0by
 83nUKWFF9w4buoWg7ynyxsLmgoA6Q3dK7hbA3PN5E+lSkG4ctaLvHEK0BP5vSYP8RfTJ+Ao15pq
 3kNNm
X-Gm-Gg: ASbGnctWrjDe75ZgjHrzr0lUDYQl1y0uGPSAG+/vMZkvzqmGvJkmBndvimpe4DZaro8
 NESNBLHoBpH1Xtjj86qEqdLHggafAkbm4WDovQonaw0FwT9nh4/cnZ4vUsWPOerhruU9EmXhpeT
 92jc+vNMsMdXMaUmoxyoyvpdXGFNLAU9z7Op9XJG62ShwZ4qH8uEePbG5riKL1KBUsVABuC01YA
 pSMv9s1Lnmhst7a+dEEimxLZ3NNjAm1n1e1iOzKJ3ZgGI/33KuqXUC65A7rKqvEX4BFuC5J9ct4
 HKHbPCd6eVxdyUHD4BPOMwMWHx/xH/hhDeB71WOc7L8KjuGARoohFq/RNanyMV6g+8QUeAOttsA
 CaP6SdQ0sYt5uTg8+Pb5Xya+7t8TLpr53mAGf/Jn45jKTISshapXknDk5RGYeQHQgNQHKeg8a
X-Google-Smtp-Source: AGHT+IH3ymAb8vgrl1nGxJXC07zT+ngjPP5mWfYCkJmfA4cqXHIiRTq/FRiIWqliyhYQ75zj1ykNIg==
X-Received: by 2002:a05:6000:238a:b0:3b6:1a8c:569f with SMTP id
 ffacd0b85a97d-3c5dac171cemr7451006f8f.1.1756093372378; 
 Sun, 24 Aug 2025 20:42:52 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:42:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>
Subject: [PATCH v2 31/43] net/thunderx: replace use of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:44 -0700
Message-ID: <20250825034126.12046-32-stephen@networkplumber.org>
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

Replace use of system sys/queue.h with DPDK rte_bsd_queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/thunderx/base/nicvf_bsvf.h | 2 +-
 drivers/net/thunderx/base/nicvf_plat.h | 1 +
 drivers/net/thunderx/nicvf_ethdev.c    | 1 -
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/thunderx/base/nicvf_bsvf.h b/drivers/net/thunderx/base/nicvf_bsvf.h
index 4c7615ca99..74019818e3 100644
--- a/drivers/net/thunderx/base/nicvf_bsvf.h
+++ b/drivers/net/thunderx/base/nicvf_bsvf.h
@@ -5,7 +5,7 @@
 #ifndef __THUNDERX_NICVF_BSVF_H__
 #define __THUNDERX_NICVF_BSVF_H__
 
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 
 struct nicvf;
 
diff --git a/drivers/net/thunderx/base/nicvf_plat.h b/drivers/net/thunderx/base/nicvf_plat.h
index 8421f57040..ccc6aef0fc 100644
--- a/drivers/net/thunderx/base/nicvf_plat.h
+++ b/drivers/net/thunderx/base/nicvf_plat.h
@@ -6,6 +6,7 @@
 #define _THUNDERX_NICVF_H
 
 /* Platform/OS/arch specific abstractions */
+#include <rte_bsd_queue.h>
 
 /* log */
 #include <rte_log.h>
diff --git a/drivers/net/thunderx/nicvf_ethdev.c b/drivers/net/thunderx/nicvf_ethdev.c
index 4441a90bdf..c7b6252cd6 100644
--- a/drivers/net/thunderx/nicvf_ethdev.c
+++ b/drivers/net/thunderx/nicvf_ethdev.c
@@ -12,7 +12,6 @@
 #include <stdarg.h>
 #include <inttypes.h>
 #include <netinet/in.h>
-#include <sys/queue.h>
 
 #include <rte_alarm.h>
 #include <rte_branch_prediction.h>
-- 
2.47.2

