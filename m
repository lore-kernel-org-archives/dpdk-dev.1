Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F125C982D2
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 17:21:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EAE742FA3;
	Thu, 17 Sep 2026 19:21:24 +0200 (CEST)
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41]) by mails.dpdk.org (Postfix) with ESMTP id 3CD7E40281
 for <dev@dpdk.org>; Thu, 17 Sep 2026 19:21:21 +0200 (CEST)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-85469b35601so728120b3a.3
 for <dev@dpdk.org>; Thu, 17 Sep 2026 10:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789665680;
 x=1790270480; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E9ApxEiCFEfDaT06yPB0lD3VY7dH7ajiKdEFIMrkG7M=;
 b=LdVRr0XE/eU4U+SlKJ9XsZy46Kh4hRLiJ5SoZ3/K/Ex/Xxvogw1skRwxLfAogAw37S
 3FmcjcXD0TfuUFSJh97vbxvIg3KIim/AE+DCxLkkrzPdV0C2wHAiOkSkTnccz2iWcJYP
 x6ByQI0+l6P9QDcGXXW/y6ljw4dtVVX95e9gDx9alqUTc4hbb1HAO5ykbpguABZ8NuwB
 dvXY4wUrdf88m3CTEoPjfo4RJ6FDO6L8C0krTN0+9d/N7WE8T0Jw5xbcWjXUK4ebFQKr
 fLxyQBrnUhTSB+ICKjMWHC4dBWHuGVZrsL1y4TM8/O00zDSMuOxzJGqfjV0z7f6BcpGI
 sR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789665680; x=1790270480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=E9ApxEiCFEfDaT06yPB0lD3VY7dH7ajiKdEFIMrkG7M=;
 b=w8CSx8OCHmTpgP4SZMUz8Gv7TH0cNoC4VSgxLlYrYMWXp9wTgpd45JgIfaTU2t+45u
 TyBIYMKtlXJiDxOc+fisY0Q4PLmdsZV5TahnreIDVnwumLC55LNhhhv9y+0vhQusVxgz
 6QBwQibqseKZT7qqqIpU9ugHbSPsyjYsASa3Jdo6+syn5g98XvIxt+Ek8GNO7bkZfvx7
 7YBLAqnOtKNtz2qGhyhl9Y4ujoHdxAS8fdwhb133+0k2W4PeUn2Up0iyvw2F91q6EtsD
 wULm7kiupmb3rfrRh1lU9r2j2zzi9Ay7uiUGK3KJfWgNKirudH6De/G1yMd2vHgfCoEq
 //dg==
X-Gm-Message-State: AFuF++kANlGFUzFS9ZFiCDrEbG5RT29WaftC2LW6p8mk+hT9WHM6Vfpv
 rXbZV8QFnA2MSeFHD8/mMPsJVuGoya9S4cwZCEy+jKjJGPzDYiHm88w66FB/oYiefV0/2q2HGyp
 lconW
X-Gm-Gg: AYBFou3NMnwOJlWfauI6eYK6Q0mVECGnia2YuCWDnNC3LQ2NAo2lmtGTJu7gihD3ajg
 9SGPevVyzc//B/RvfkxlqzpkhMRzXQTcY5MLO5u6tAuz+pjC1aEOJAASBYSxTa3+ZV6eUyOj+eI
 DxQpiVgVLO8LHmTzkMkfHK6Gg1pNojFZKB8/Q3T4eUxmVaDFYRCkCxKbPOW5Zr1fZDlLIDj0RMF
 cSEGB0XLZ0FQQokOvpFc96JCXd6VqgDI0YIu6hyu+YNPdAkZDav3j+LUP8bOYKRlKeE1oqTuqCR
 bIMW8hG+4QGBTEbfrceAVoDE1QtjWRPiUCIbyW3M+DRibG7oX4oySDylnUf4iXuyrxxfqJOE2XW
 h0L3gyfy/ruEMzTYrKzHVEV7k/Mr2uP7OGhm09N1ZWffLcJ7Ih728iWUsQPC4UAoPBHlS+Kbjbb
 D0WeaWxxI289Ywi5EOovGnx4LKzQn0sdyaVtuJ7EAuM1JtWLobxd1zR/GcqMIYxtgh5oGCvGx+D
 6l943ukw1+TJq4UFz8+SpM7GzrbfqVAV5OvHQ==
X-Received: by 2002:a05:6a00:2e9c:b0:874:706d:962d with SMTP id
 d2e1a72fcca58-874706d99ffmr1793865b3a.31.1789665679962; 
 Thu, 17 Sep 2026 10:21:19 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87379a2e079sm1447408b3a.31.2026.09.17.10.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 10:21:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH 1/6] net/bnxt: fix use after free when freeing filters
Date: Thu, 17 Sep 2026 10:19:39 -0700
Message-ID: <20260917172116.660120-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917172116.660120-1-stephen@networkplumber.org>
References: <20260917172116.660120-1-stephen@networkplumber.org>
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

bnxt_free_filter_mem() freed each filter and then passed the freed
pointer to STAILQ_REMOVE, which walks the list to unlink it.
STAILQ_FOREACH also read the next pointer out of the freed element.

Remove the entry from the list before freeing it, and use
STAILQ_FOREACH_SAFE so that the iteration does not depend on the
element that was just freed. glibc does not provide the _SAFE
variants, so define it locally the same way several other drivers
already do.

Found while moving the list macros into a DPDK header, where the
compiler could see them and report -Wuse-after-free. The fix does
not depend on that work.

Fixes: f11fd694a84a ("net/bnxt: free memory allocated for VF filters")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bnxt/bnxt_filter.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_filter.c b/drivers/net/bnxt/bnxt_filter.c
index 7b90ba651f..0225215dae 100644
--- a/drivers/net/bnxt/bnxt_filter.c
+++ b/drivers/net/bnxt/bnxt_filter.c
@@ -18,6 +18,13 @@
 #include "bnxt_vnic.h"
 #include "hsi_struct_def_dpdk.h"
 
+#ifndef STAILQ_FOREACH_SAFE
+#define	STAILQ_FOREACH_SAFE(var, head, field, tvar)			\
+	for ((var) = STAILQ_FIRST((head));				\
+	    (var) && ((tvar) = STAILQ_NEXT((var), field), 1);		\
+	    (var) = (tvar))
+#endif
+
 /*
  * Filter Functions
  */
@@ -110,7 +117,7 @@ void bnxt_free_all_filters(struct bnxt *bp)
 
 void bnxt_free_filter_mem(struct bnxt *bp)
 {
-	struct bnxt_filter_info *filter;
+	struct bnxt_filter_info *filter, *temp_filter;
 	uint16_t max_filters, i;
 	int rc = 0;
 
@@ -151,10 +158,11 @@ void bnxt_free_filter_mem(struct bnxt *bp)
 	bp->filter_info = NULL;
 
 	for (i = 0; i < bp->pf->max_vfs; i++) {
-		STAILQ_FOREACH(filter, &bp->pf->vf_info[i].filter, next) {
-			rte_free(filter);
+		STAILQ_FOREACH_SAFE(filter, &bp->pf->vf_info[i].filter, next,
+				    temp_filter) {
 			STAILQ_REMOVE(&bp->pf->vf_info[i].filter, filter,
 				      bnxt_filter_info, next);
+			rte_free(filter);
 		}
 	}
 }
-- 
2.53.0

