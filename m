Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB93CCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:53:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D782D4064F;
	Mon,  3 Nov 2025 17:50:12 +0100 (CET)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id 456C540DD8
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:50:08 +0100 (CET)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-3410c86070dso978032a91.1
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188607;
 x=1762793407; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O/ilg0+6yZmBQg2WY0b31ZAOXykuu/jQR2VnBgbjc6g=;
 b=sfd3BApaj2MuYG7lKtVhs39GIOb2D421xWKDwUT057xco6KmYlVR2wHQ+MgtZNcorq
 9FFbfz1e1/NHqRcsUhx4fpwAjHquPvCHm7HcTKnjxLuQZ/cKK+nkDXXhmdOv27BgAp3n
 vFv9y9BHUHly2EyHGfTYWBlWlDa8c6xYE+zDSbPEGjaGrFo9AJO54dmNDfIy44x+AnTf
 mTF6pq6/3cIlebA+aTH1XZeHTm4eTp0EytzmHH+/cEdFF+XAsC/AELPncMxIh4SJQyoF
 fP7r59RX5/p05+sbxMylgEbjMDHOHzfOdk8n/CQdRrB2OUdKOFLwHDCcqJMVFdnNONDe
 MfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188607; x=1762793407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O/ilg0+6yZmBQg2WY0b31ZAOXykuu/jQR2VnBgbjc6g=;
 b=kzRkS7xGps/E+4os8pKlurwxE+uSZldo6ft2J8kSgMCCbrwZWukb1AETAW/NNevZon
 1efuOlbYIwJMj1jIuEt4jtJVrVdFpTOUWBw9QUpxMx8si2zkW4T5l/TmiXBOrjirOZ2v
 DdB1vUHk0m6siRsle1qyzrmQpccSOtmIOuC3xuQk/q1Rn8rmr+nFaxOjTTWnNmqqTUIt
 Aj6HbKm2+crk15PDDdzIZFXthmuVPS9vT6nnDYXlX4RMk1II0Rj/HXDhgHiAzg4/ya6I
 Q9oxlZUyZWneUhMTwf49VMJIjR1vu1A+vIo3TRMVb9kzbGvMbE3ZZcpKOveG/1B2GL8Q
 Fc2Q==
X-Gm-Message-State: AOJu0Yy0+XmwJ5OoJmpqIyhkKsBjWurZL3qGY8ImfRfiD5ogL/jrziBZ
 WpTw8snl/VIvilZlzvZhasRIoYMJ6Hr773XR1YYi53MFzjoXfBWI/QYBpp8EPmCqKo+UtApDwTq
 qvVJB
X-Gm-Gg: ASbGncusDjHVTMZ3pPsThkP2YaMcu29RoYfDZ8taYJe6nh4PIsVTi7Dlc9nY8wfxV20
 LUyglYvjYt0LIxDxI0M5YFtcC5x8+GVCttHaz4R7u0PNomV7t9q1+DNvQOf++vE/vN3TTtSiivX
 nxConNi0NN9cPGwyIdGKcpCuqMl+nNV29LfNGTZoEg63jmqeSijKgU5r35JPyI8Z/yfEFECt43l
 7zYtV6VbUakmZMg2ad5aIiabrx7GLWVqs4/QnS9P1GJnaioyIMBTGcC7KpBS549fpn9aHAsqGtV
 Y4JyDqjCeH4tXdvQKC11xRt5+c1+2lOmMAGVLaTqgLL/VJkqlOxZVl7hkfrC3AZw+TWvTWkzxI9
 NxHgl3Hu/zMj5IZI4sw3krUamxMTRAej/eaQ/w2fcCbqGpORN/GoXK00+Z915kmJQ6RWSMinnKb
 zYFScRgcs3vDyqc+aT9RFPT/e6sg7XmUcldLIHFXM=
X-Google-Smtp-Source: AGHT+IHwlpS+bLq5a0o59jokQ/IHHNOb5EAXjSGkvQe09CTh7O/fFG+qaS2MBEBvW3oTNp9bW9eE2Q==
X-Received: by 2002:a17:90b:5545:b0:341:315:f50d with SMTP id
 98e67ed59e1d1-3410315f828mr5916949a91.8.1762188607430; 
 Mon, 03 Nov 2025 08:50:07 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:50:07 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Rosen Xu <rosen.xu@altera.com>
Subject: [PATCH v3 38/44] raw/ifpga: replace with TAILQ_FOREACH_SAFE
Date: Mon,  3 Nov 2025 08:47:43 -0800
Message-ID: <20251103164915.101713-39-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103164915.101713-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
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
2.51.0

