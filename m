Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930EFCCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:07:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D67CF40297;
	Wed, 29 Oct 2025 17:07:51 +0100 (CET)
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com
 [74.125.224.97]) by mails.dpdk.org (Postfix) with ESMTP id 4CFFD40297
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:07:50 +0100 (CET)
Received: by mail-yx1-f97.google.com with SMTP id
 956f58d0204a3-63e393c4a8aso115302d50.2
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754069; x=1762358869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wkpe2aPu78Hv/MopjDx+8y6MdV1RafXA4FnREVZ3LQQ=;
 b=JERv0okv9/euMdmQ0Xz+6AtR5u87VjL6OBqYhcEZJBOHAThYTZBB1dz00TNlDE92DC
 vdRktsVzTUb24FXa5u3M9Lk60CFQJvDZUDpXnWfOlprk5YUWQSWHRBTgIEUhL6HVUU8R
 es/mhJhcqsagCOkd/41Nc9aRCUS1iucMo3kwxcYu9btDXB1ElfD1s1mfsUeN3wosawgp
 kwFC9AMgV8TO7ld6iddByNeXgHB9c9fsF1F+w4bovrFCRmDpT3Jdg7fbRUhV9IpJb3ee
 yQgSD1rtF5DuvmM7kKixDKijRIOBGQtfHde81/LYZVjvFhEC/oKOo1PwzHsqVuSFdjk9
 u07Q==
X-Gm-Message-State: AOJu0YwzXKkCMQxTEP6sBI4NaK39v+HbD0LaX2UmMu5faRGXuwr7NnIj
 WVIIC98ANw+Ll5ArV+tHKrHv2wmwUDqOxCOiaqlxjIggQuyr5NHgOloYhosbS8vP6IW8ar2mD0X
 33D5gO+aoqxMH33Kyuv1NYtdHt9utOvZ+Pbl7bv4tlJLxqYjLbBleONR/71gtSR3g5jYgTEI60R
 SRAb7O63Vwc9MAZB43PF9hms5vC0XNxCU1xNDzkUQDMWf+ehFszkt7N0pDNHb713KJ0ycCrQ==
X-Gm-Gg: ASbGncvK388kfl/imGJtpydEWUqcHTdPc0RWK4wqLaSyojd3iG24XvNF82OEMKLKNE3
 t3a3f90VwFy2X+QRDIuIa4GofOL5Vy34+5JWNyg2Q79Bx2OoyURs0AVjELKSMkLA0f2ZExBxTG7
 1SUTixpNBhEc0BRNRntGjQqJZmwQQvXA7PKVnfkQP3hbiMi8D0LxMC4BxZckKAFSwZmegC9iU2e
 SSz3lNBhm14Hz5MVuxPTbxGumpWsEBiBlURbr+t8IKS3eWYVy+WQ7SvPfM/14geR4VaM0v+zht2
 PugrQsFGkQ5oopWtS3nHY7iYH1Zv3u7wK18TWPp37swashACH4Pi4evDkxpd1PPZgeP3H2hEx4q
 v2pgdcYu6vh4RAST9Ut4lQgk0fMch+jSZ2vzzYb7e6vWiLr9jCQG2146kT3h8Ix5pWTp1OSmaBs
 rGfs7rJJPNNa9RoUjl+eLnSht4n7evuAY=
X-Google-Smtp-Source: AGHT+IEvelC4taAXkYxjxU6bYGzph6h/nuTwvln8WPNC1msZN7+Kt4BpNpi+JdNBPHwOm7Goe25nGIZI+77v
X-Received: by 2002:a53:d018:0:b0:63f:7d65:7453 with SMTP id
 956f58d0204a3-63f7d6578bdmr974456d50.29.1761754069480; 
 Wed, 29 Oct 2025 09:07:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-785ed1b6762sm9858417b3.20.2025.10.29.09.07.49
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:07:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-891d8184bebso1580292785a.3
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754068; x=1762358868; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wkpe2aPu78Hv/MopjDx+8y6MdV1RafXA4FnREVZ3LQQ=;
 b=Cm2JeV2HVtF+us/UWygTMZ86PjfN7yIMBGIy7doDUYNa8iDLKNw5ohof6invvnC2su
 Es3ovxmbdLAS+nIVHE038iDYV44xNbYlPjrPW1Fvhg9//OmoEcu0Z76CpHuJ1MPI7Uw4
 b8cKk3wSvnfL5RQY4BR4GRWbkqSRn66h4WP8w=
X-Received: by 2002:a05:620a:44d1:b0:89f:24b:36c7 with SMTP id
 af79cd13be357-8aa2bea02e4mr16514885a.6.1761754068271; 
 Wed, 29 Oct 2025 09:07:48 -0700 (PDT)
X-Received: by 2002:a05:620a:44d1:b0:89f:24b:36c7 with SMTP id
 af79cd13be357-8aa2bea02e4mr16502685a.6.1761754067218; 
 Wed, 29 Oct 2025 09:07:47 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.07.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:07:46 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com
Subject: [PATCH v5 02/57] net/bnxt/tf_ulp: add bnxt app data for 25.11 for Wh+
Date: Wed, 29 Oct 2025 12:06:17 -0400
Message-Id: <20251029160712.58519-3-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251029160712.58519-1-manish.kurup@broadcom.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
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

