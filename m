Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19556CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:18:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B6E140684;
	Wed, 29 Oct 2025 17:18:44 +0100 (CET)
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com
 [74.125.224.100])
 by mails.dpdk.org (Postfix) with ESMTP id 9BF7340665
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:18:42 +0100 (CET)
Received: by mail-yx1-f100.google.com with SMTP id
 956f58d0204a3-63f7c7185c5so128885d50.3
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754722; x=1762359522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BF+1RWP7HZuZ0jVq4900WIuWJRcPMvRIlRba3aJr6+c=;
 b=Ca2/369BKRCY6AjDEoT8MxJWJtyZcoYANDzRpU23/v7E/zT7FAmM9Gd2bTjwGnywzB
 gJ7hRVfUP4g+o5IscBwfNEZSXGYuvloCeb+M4XR5UaZw+TMQu0RdwKn6ZKjb7WGCN0HC
 BqkEQZ7JyMwpEtZMQplW6TufwNFlk6+Icm3i9YYR2NTjFwCSoSA0AlrpnDLmQbKjv9fc
 7yForqIrKOV+NAtDomaksw73QaLxYtjJVE1DbSyuqofY8i//XBPQyX1Ym8e7nvpmIvzQ
 xpBz1GKx1DXdicsrr/N0j3+iRgf8HykGrcGXqKeDqVt5lcPnrmxnY2LyoO2Hx+JyuUP6
 4HRQ==
X-Gm-Message-State: AOJu0Yygsj4XoGSTo2MhZV3XgVb9Z5OCKjyHiyYIEohmUaqxCQ2SLhJh
 RZtVMxBay8RpJUbI++9EbsaHHvdt7SrbmRPS1q+aYSOG0RiL33JKEoa5kmGY7/VpAdwy4tcFxhx
 e2vAJBJsmFn1dw1LSkJj0oUAj/zN1CH+JCciitR0uGBby2dusRYIcNOj4/ANoo2SSP+vcRYPSW7
 7VVJDL8nq7DVrX/tWrCfd2JLV7qXuJ+hXUN9Kvmuh8yLPZUC/iHJlj+pjR0tTOB8QAkzkfyw==
X-Gm-Gg: ASbGncvfSSGyeLB85BqS8nGKzJa1xlB6imiJGAVk6r33pt1iWWv2BkDSxhQ3tfxr9Au
 mxb9dWtGxiEHjZ6oi2qNb0gHWsjjHUxbr2dww/Df/dm52XEIkxUByo7njwHQTli2IWLk7gnibxL
 TlphXsvOgT9u2MyOBOWZYrHnQxodYxkKFNKumIbPUYo3cfFBF8SYchMjye+dD5C0AKHaSljMvUn
 5IPTzJxTP4iizJYVY6i3Ja0X2MkYKFhd98cWCNDUR2dnUvhdcaQCEtmrVl2XUvSmkIfPFIyf1mN
 1te9Jbizw6USgnhumT4PGZ7pBQzpubDKzSjWou+23VON9+nxAaJgNjj8cDPRpll+OAr5bfr7KV2
 w3VY7BNJlfirVyiAIYOUl04/NPWUX3D6w+k0FkzQ3Zze71UyxojsOgjeQA69Iuq+55kcJU6jI1f
 EgHSGIkYfbJfJuwUIbUo/XXR8u6oAL0ckGKvVJ
X-Google-Smtp-Source: AGHT+IEEVG4CFrC/Isb1aYl4fKYMgnOeNZpRqA0PIg81t4nP6gNxno+iDJ45FF2qfFqL/DI/Rpy7RZqzCIJj
X-Received: by 2002:a05:690e:1a89:b0:63e:3b29:f1d7 with SMTP id
 956f58d0204a3-63f76db342emr2355929d50.42.1761754721937; 
 Wed, 29 Oct 2025 09:18:41 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-785ed2078a3sm10198337b3.34.2025.10.29.09.18.41
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:18:41 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-89ee646359cso1682525585a.1
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754721; x=1762359521; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BF+1RWP7HZuZ0jVq4900WIuWJRcPMvRIlRba3aJr6+c=;
 b=GIGkGwOkyttp/NGVUDYgpoHQOpqmA6FcYHZX6vu86imfZB6AmDkjZTPZDlQ44sMPZT
 DlpYKBg2zcncufBUZAe1XbeZ8n7oKDVNa7NU3GFdbeNLRxGJt8sWlW80JyVaadCWhJRx
 lmFN3l5NTR7UPWoFPfPKMyX90ngIigdRgoJQA=
X-Received: by 2002:a05:620a:394f:b0:8a2:a5b2:e3bc with SMTP id
 af79cd13be357-8aa2ea0cac4mr19199785a.89.1761754720863; 
 Wed, 29 Oct 2025 09:18:40 -0700 (PDT)
X-Received: by 2002:a05:620a:394f:b0:8a2:a5b2:e3bc with SMTP id
 af79cd13be357-8aa2ea0cac4mr19194485a.89.1761754720236; 
 Wed, 29 Oct 2025 09:18:40 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.18.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:18:39 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH v5 29/57] net/bnxt/tf_ulp: optimize template enums
Date: Wed, 29 Oct 2025 12:06:44 -0400
Message-Id: <20251029160712.58519-30-manish.kurup@broadcom.com>
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

The template enums are broken into two files, the enum file contains
the enumeration that is common for applications and define file that
contains application specific enumerations.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Shuanglin Wang <shuanglin.wang@broadcom.com>
---
 .../ulp_template_db_enum.h                    | 82 +------------------
 1 file changed, 3 insertions(+), 79 deletions(-)
 rename drivers/net/bnxt/tf_ulp/{generic_templates => }/ulp_template_db_enum.h (96%)

diff --git a/drivers/net/bnxt/tf_ulp/generic_templates/ulp_template_db_enum.h b/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h
similarity index 96%
rename from drivers/net/bnxt/tf_ulp/generic_templates/ulp_template_db_enum.h
rename to drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h
index 87e24c37c2..4e7cb570b0 100644
--- a/drivers/net/bnxt/tf_ulp/generic_templates/ulp_template_db_enum.h
+++ b/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h
@@ -3,74 +3,10 @@
  * All rights reserved.
  */
 
-#ifndef ULP_TEMPLATE_DB_H_
-#define ULP_TEMPLATE_DB_H_
+#ifndef ULP_TEMPLATE_DB_ENUM_H_
+#define ULP_TEMPLATE_DB_ENUM_H_
 
-#define BNXT_ULP_REGFILE_MAX_SZ 107
-#define BNXT_ULP_MAX_NUM_DEVICES 5
-#define BNXT_ULP_LOG2_MAX_NUM_DEV 2.32192809488736
-#define BNXT_ULP_GEN_TBL_MAX_SZ 62
-#define BNXT_ULP_ALLOCATOR_TBL_MAX_SZ 2
-#define BNXT_ULP_CLASS_MATCH_LIST_MAX_SZ 163
-#define BNXT_ULP_ACT_MATCH_LIST_MAX_SZ 21
-#define BNXT_ULP_APP_RESOURCE_RESV_LIST_MAX_SZ 0
-#define BNXT_ULP_GLB_RESOURCE_TBL_MAX_SZ 57
-#define BNXT_ULP_APP_GLB_RESOURCE_TBL_MAX_SZ 0
-#define BNXT_ULP_RESOURCE_RESV_LIST_MAX_SZ 73
-#define BNXT_ULP_APP_CAP_TBL_MAX_SZ 3
-#define BNXT_ULP_COND_GOTO_REJECT 1023
-#define BNXT_ULP_COND_GOTO_RF 0x10000
-#define BNXT_ULP_APP_ID_CONFIG 0
-#define BNXT_ULP_GLB_FIELD_TBL_SIZE 129
-#define BNXT_ULP_GLB_SIG_TBL_SIZE 1
-#define ULP_WH_PLUS_CLASS_TMPL_LIST_SIZE 8
-#define ULP_WH_PLUS_CLASS_TBL_LIST_SIZE 98
-#define ULP_WH_PLUS_CLASS_KEY_INFO_LIST_SIZE 683
-#define ULP_WH_PLUS_CLASS_KEY_EXT_LIST_SIZE 0
-#define ULP_WH_PLUS_CLASS_IDENT_LIST_SIZE 29
-#define ULP_WH_PLUS_CLASS_RESULT_FIELD_LIST_SIZE 657
-#define ULP_WH_PLUS_CLASS_COND_LIST_SIZE 50
-#define ULP_WH_PLUS_CLASS_COND_OPER_LIST_SIZE 0
-#define ULP_THOR_CLASS_TMPL_LIST_SIZE 8
-#define ULP_THOR_CLASS_TBL_LIST_SIZE 214
-#define ULP_THOR_CLASS_KEY_INFO_LIST_SIZE 940
-#define ULP_THOR_CLASS_KEY_EXT_LIST_SIZE 778
-#define ULP_THOR_CLASS_IDENT_LIST_SIZE 67
-#define ULP_THOR_CLASS_RESULT_FIELD_LIST_SIZE 1322
-#define ULP_THOR_CLASS_COND_LIST_SIZE 4909
-#define ULP_THOR_CLASS_COND_OPER_LIST_SIZE 15
-#define ULP_THOR2_CLASS_TMPL_LIST_SIZE 8
-#define ULP_THOR2_CLASS_TBL_LIST_SIZE 182
-#define ULP_THOR2_CLASS_KEY_INFO_LIST_SIZE 737
-#define ULP_THOR2_CLASS_KEY_EXT_LIST_SIZE 668
-#define ULP_THOR2_CLASS_IDENT_LIST_SIZE 61
-#define ULP_THOR2_CLASS_RESULT_FIELD_LIST_SIZE 1603
-#define ULP_THOR2_CLASS_COND_LIST_SIZE 4214
-#define ULP_THOR2_CLASS_COND_OPER_LIST_SIZE 14
-#define ULP_WH_PLUS_ACT_TMPL_LIST_SIZE 13
-#define ULP_WH_PLUS_ACT_TBL_LIST_SIZE 155
-#define ULP_WH_PLUS_ACT_KEY_INFO_LIST_SIZE 49
-#define ULP_WH_PLUS_ACT_KEY_EXT_LIST_SIZE 0
-#define ULP_WH_PLUS_ACT_IDENT_LIST_SIZE 20
-#define ULP_WH_PLUS_ACT_RESULT_FIELD_LIST_SIZE 995
-#define ULP_WH_PLUS_ACT_COND_LIST_SIZE 134
-#define ULP_WH_PLUS_ACT_COND_OPER_LIST_SIZE 6
-#define ULP_THOR_ACT_TMPL_LIST_SIZE 13
-#define ULP_THOR_ACT_TBL_LIST_SIZE 104
-#define ULP_THOR_ACT_KEY_INFO_LIST_SIZE 83
-#define ULP_THOR_ACT_KEY_EXT_LIST_SIZE 5
-#define ULP_THOR_ACT_IDENT_LIST_SIZE 19
-#define ULP_THOR_ACT_RESULT_FIELD_LIST_SIZE 416
-#define ULP_THOR_ACT_COND_LIST_SIZE 90
-#define ULP_THOR_ACT_COND_OPER_LIST_SIZE 0
-#define ULP_THOR2_ACT_TMPL_LIST_SIZE 13
-#define ULP_THOR2_ACT_TBL_LIST_SIZE 121
-#define ULP_THOR2_ACT_KEY_INFO_LIST_SIZE 86
-#define ULP_THOR2_ACT_KEY_EXT_LIST_SIZE 5
-#define ULP_THOR2_ACT_IDENT_LIST_SIZE 42
-#define ULP_THOR2_ACT_RESULT_FIELD_LIST_SIZE 452
-#define ULP_THOR2_ACT_COND_LIST_SIZE 96
-#define ULP_THOR2_ACT_COND_OPER_LIST_SIZE 0
+#include "ulp_template_db_defs.h"
 
 enum bnxt_ulp_act_bit {
 	BNXT_ULP_ACT_BIT_MARK                = 0x0000000000000001,
@@ -2181,16 +2117,4 @@ enum ulp_thor2_sym {
 	ULP_THOR2_SYM_T_ECPRI_CONTEXT_MASK = 0
 };
 
-enum bnxt_ulp_df_tpl {
-	BNXT_ULP_DF_TPL_DEFAULT_UPLINK_PORT = 3,
-	BNXT_ULP_DF_TPL_DEFAULT_VFR = 4
-};
-
-enum bnxt_ulp_template_id {
-	BNXT_ULP_TEMPLATE_PROMISCUOUS_ENABLE = 5,
-	BNXT_ULP_TEMPLATE_PROMISCUOUS_DISABLE = 6,
-	BNXT_ULP_TEMPLATE_GROUP_MISS_ACTION = 7
-};
-
 #endif
-
-- 
2.39.5 (Apple Git-154)

