Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42733CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 17:51:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DEB840A6B;
	Tue, 21 Oct 2025 19:51:09 +0200 (CEST)
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com
 [74.125.224.97]) by mails.dpdk.org (Postfix) with ESMTP id 7651A40A6B
 for <dev@dpdk.org>; Tue, 21 Oct 2025 19:51:08 +0200 (CEST)
Received: by mail-yx1-f97.google.com with SMTP id
 956f58d0204a3-63e336b1ac4so225808d50.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761069068; x=1761673868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wkpe2aPu78Hv/MopjDx+8y6MdV1RafXA4FnREVZ3LQQ=;
 b=u2S/PKW3munCrur6VXodVM7v/bQ9Wmi32uyxKCh7+eqfMFigx6Gm9rUP5QX7FnCTHe
 PIjelthTJF/IyQG4IimS3I9FDnRG0CLMS/RtZLausKqYb4l3wtCzskeWnI7esYXccy77
 4OMmIm1Qt9xRpg+QNoxwnNof8NQ4z9SRCLGBj+B5mh0CJKTNWoCTo1miK6kxrwXzfVJ+
 PlofhwiuhyqE4kJseBcERUdp93tg/O4qvnjO5TxW8g9/dqf5KsuADGN0eabswyvATDkN
 ZlchxEd7KHviEbPvYg/N2JmHeg7v73YmMTShOD9fPjHX52OtE7XsrxNMaYckjxsaHjfQ
 PKtA==
X-Gm-Message-State: AOJu0YyhIJZLAW0v6zdeI7N21CZl73y2FRb/0YT04chAIyb3CIh4jri3
 YdDav0KT2BB/HIkPHn2rh7Qbpx2luCDoDNHyf5xX2d8SB0sPsK5mSL8YeCStGCbd++dBGRMh/DX
 6n+btjHN+K6K3mM89CgGtqQeqGLgTuF8YNkB0bm+yhNIobqJyzkvcQTvOniY8QzJkgPLoFgzEiN
 QSONEdr0aNhrqtJUdI75tm+GWeGmZrSZuawvVrtOoGo7f0nJZM7KVo3m67rV3Bm5ssUp6chw==
X-Gm-Gg: ASbGncs5fNM6OywficJ5scUEgS0APwLgZrcugVnpSAEDPw2B7cDixrB//i+kWTINaiS
 w7XWff6gQApi9JrHrmoe8+lCxEW7akqP1aQf9nGnc+uyLlqvBkGv3C0DE4rGgYXSn60llTy61uG
 KK84y6t8IeR9xuHXuUgy9MP/OPngs304srVQlb1BntyRBGVee5YL76L3UUW71e6kKSzXvqvWmkq
 MepMfglcMgn5GdAzikhxGBueN71FGrsDwd45zPX5E5n/0acljFxZsZvApmUoPKXAdIo2O8qDtF9
 LsxJ8S7y03SyaMv0XwjbxgKMlo+ZRkoYM0TvXUjCECcEcs2av/AcgQam3+0ok/y2JKcTC8DTwop
 X3C9MUHHlO/oKscvlZlqyt3tCMrfR7OsJwVwUCZKUBlQBWMj+AKN1WdhWR3N7RslH8IXmpSHMFw
 +uV0tEcj+M+UH/bwB2dCn6z5NrM7EGAEJofQ==
X-Google-Smtp-Source: AGHT+IFuHNUreeriIHNSNnaGdHolaz3w2FsyBS8edzJDR4085wjBb6aqgpSqrrL002IlTAY0TFXdRsUdU9Uh
X-Received: by 2002:a05:690e:d45:b0:633:102e:93ee with SMTP id
 956f58d0204a3-63f2823c8efmr515721d50.1.1761069067767; 
 Tue, 21 Oct 2025 10:51:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-63e267a0403sm901128d50.11.2025.10.21.10.51.07
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 10:51:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-290c2d13a01so1057015ad.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761069066; x=1761673866; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wkpe2aPu78Hv/MopjDx+8y6MdV1RafXA4FnREVZ3LQQ=;
 b=bKjVaLxgJ5OtVDaiM4WmzaeIj+Yh3qADj00Oxy07hE06COx2Cy9A40s53RgM72SY7x
 Potwou6aOuFoM+cCsRqkWWaAVUW8nVp7i0Hw+NZrjEV2YqngQm4GvrMiJbK3H+/JtvqT
 0R/KGO86gXQHx1oG7iVI3hFXEj0G6xQ5mj4+Y=
X-Received: by 2002:a17:902:db07:b0:28d:195a:7d92 with SMTP id
 d9443c01a7336-292ffc7177amr5845815ad.25.1761069066074; 
 Tue, 21 Oct 2025 10:51:06 -0700 (PDT)
X-Received: by 2002:a17:902:db07:b0:28d:195a:7d92 with SMTP id
 d9443c01a7336-292ffc7177amr5845395ad.25.1761069065367; 
 Tue, 21 Oct 2025 10:51:05 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292472193c2sm115441495ad.104.2025.10.21.10.51.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 10:51:05 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com
Subject: [PATCH v4 02/57] net/bnxt/tf_ulp: add bnxt app data for 25.11 for Wh+
Date: Tue, 21 Oct 2025 13:49:54 -0400
Message-Id: <20251021175049.46092-3-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021175049.46092-1-manish.kurup@broadcom.com>
References: <20251015090024.32250-1-manish.kurup@broadcom.com>
 <20251021175049.46092-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

This commit adds the data, defines and enums for applications
targeting the Wh+ product

Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 .../ulp_template_db_wh_plus_act.c             |  2 +-
 .../ulp_template_db_wh_plus_class.c           | 26 ++++++++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/generic_templates/ulp_template_db_wh_plus_act.c b/drivers/net/bnxt/tf_ulp/generic_templates/ulp_template_db_wh_plus_act.c
index 98cb4f30df..7a7e9bf5d3 100644
--- a/drivers/net/bnxt/tf_ulp/generic_templates/ulp_template_db_wh_plus_act.c
+++ b/drivers/net/bnxt/tf_ulp/generic_templates/ulp_template_db_wh_plus_act.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2014-2024 Broadcom
+ * Copyright(c) 2014-2025 Broadcom
  * All rights reserved.
  */
 
diff --git a/drivers/net/bnxt/tf_ulp/generic_templates/ulp_template_db_wh_plus_class.c b/drivers/net/bnxt/tf_ulp/generic_templates/ulp_template_db_wh_plus_class.c
index 90224bb063..36b08faa71 100644
--- a/drivers/net/bnxt/tf_ulp/generic_templates/ulp_template_db_wh_plus_class.c
+++ b/drivers/net/bnxt/tf_ulp/generic_templates/ulp_template_db_wh_plus_class.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2014-2024 Broadcom
+ * Copyright(c) 2014-2025 Broadcom
  * All rights reserved.
  */
 
@@ -75,6 +75,16 @@ struct bnxt_ulp_mapper_tmpl_info ulp_wh_plus_class_tmpl_list[] = {
 	.device_name = BNXT_ULP_DEVICE_ID_WH_PLUS,
 	.num_tbls = 1,
 	.start_tbl_idx = 97,
+	.reject_info = {
+		.cond_list_opcode = BNXT_ULP_COND_LIST_OPC_FALSE,
+		.cond_start_idx = 50,
+		.cond_nums = 0 }
+	},
+	/* class_tid: 8, ingress */
+	[8] = {
+	.device_name = BNXT_ULP_DEVICE_ID_WH_PLUS,
+	.num_tbls = 1,
+	.start_tbl_idx = 98,
 	.reject_info = {
 		.cond_list_opcode = BNXT_ULP_COND_LIST_OPC_FALSE,
 		.cond_start_idx = 50,
@@ -2277,6 +2287,20 @@ struct bnxt_ulp_mapper_tbl_info ulp_wh_plus_class_tbl_list[] = {
 		.cond_nums = 0 },
 	.key_recipe_opcode = BNXT_ULP_KEY_RECIPE_OPC_NOP,
 	.fdb_opcode = BNXT_ULP_FDB_OPC_NOP
+	},
+	{ /* class_tid: 8, , table: control.reject */
+	.description = "control.reject",
+	.resource_func = BNXT_ULP_RESOURCE_FUNC_CTRL_TABLE,
+	.direction = TF_DIR_RX,
+	.true_message = "Reject: wh+ not supporting hot upgrade template",
+	.execute_info = {
+		.cond_true_goto  = 1023,
+		.cond_false_goto = 0,
+		.cond_list_opcode = BNXT_ULP_COND_LIST_OPC_TRUE,
+		.cond_start_idx = 50,
+		.cond_nums = 0 },
+	.key_recipe_opcode = BNXT_ULP_KEY_RECIPE_OPC_NOP,
+	.fdb_opcode = BNXT_ULP_FDB_OPC_NOP
 	}
 };
 
-- 
2.39.5 (Apple Git-154)

