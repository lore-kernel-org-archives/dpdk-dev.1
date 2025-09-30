Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348ACCAC5B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:09:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0E4A40E39;
	Tue, 30 Sep 2025 09:05:57 +0200 (CEST)
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com
 [209.85.210.226])
 by mails.dpdk.org (Postfix) with ESMTP id 166A5402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:11 +0200 (CEST)
Received: by mail-pf1-f226.google.com with SMTP id
 d2e1a72fcca58-7800ff158d5so3458878b3a.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192630; x=1759797430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BF+1RWP7HZuZ0jVq4900WIuWJRcPMvRIlRba3aJr6+c=;
 b=wf3NmbzPr7JUPK2CEKXLaETj8s+6IDsYQGibWjbGnfNGVw1BMpEvkFlQLsWpNnJFWd
 ZqDZlHia+2EGAvtxXDQfXeR56MQEUF5EmJc/iCkafdVKqPwvGfcaJdjmIWomMWrN25q+
 4gbpzl1n91mQQfejO0CPJjqPtW/W8aLUhmsU2w2fdIajh5mRXcTo9SZst2h6lPMVHsBQ
 OoacHH7j8oNJRj8RXA7xEdL9gsXudNME+H5tL8QXkz8Y+hYhikUIY79HslBqUwBzYv8g
 wbl6Dff2X1Wdz7ywe6HfMJovyYzPc5hWteKwDcmBYdZ4FOdfyE+g0KroyemyqaRxYCWK
 OTPA==
X-Gm-Message-State: AOJu0YznaTALDOEbhyho6hEEt+j1xKlQbe10VfWKtLx+geJxaZpLGXJj
 G4SfPIr20iEsy4UH1oU26liCK+IEjydvjrHUycnK9wujgQIe5Xrbz6EX+uPV6/1LTpJM8GyfZ2J
 E8X5i98bid2Dg5uTayBI3zAjSLrA//gF0l2rrHo/Zuw/gdUnJI8RjTUPqeUIFXXdlN7cLcDb/NM
 pY49yK5rJIgmWxDmKHRGtJjjEK91Q/z97gE96SoierPuS56atswUYtidA/bWPBLFzy2H1b/A==
X-Gm-Gg: ASbGncvs/w1H4mjlRDqCusYSkQ0jdPpzlj9j4nO5l77op7dDEq1besxvwQJDNAyPOuW
 tcS6wae96TSBHfsz9TuXbyKo3vsgbZ28TXRakF9ioqt6JAlaTtGrziZdsM5dhIHrmf6KQztDtKO
 fERBTjnNT3kSn1ZScOsKHilcFwmKijuE3m92zPBYnRetL4QfA34NFhlYofkdoFesAQGkSBGSeoH
 kvn03UGl2/t74BPAG6VCIC6VVE/dubjLjMidwPja1NoR7ER4crA4cz0RubkYcK8Jmrnzlk0rTKA
 N0yQesN4Q74Sx2iPYOM+UH8Tyom7+oozaBvbso8zCZuRusnC33EwmVhVnmHXBGAZFLhaYnSqPLa
 IvXSLeiC2Kh0i78tqZNQNomW0rVcHwCg46WahHAxOgcS5o3y0zntzgYj8dFkmKlhQvTJUUOuA+B
 DxreRlIkw=
X-Google-Smtp-Source: AGHT+IFdMz/yMqQdWdqbBuuFEhDBT7+CnXrj7LHkSDgINRScbqpjRUVsXvyKAoOYKB9h2qkxoRjEn5Ryjam1
X-Received: by 2002:a05:6a00:2d24:b0:781:f1ee:a9cf with SMTP id
 d2e1a72fcca58-781f1eeacacmr8266090b3a.23.1759192630239; 
 Mon, 29 Sep 2025 17:37:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
 by smtp-relay.gmail.com with ESMTPS id
 d2e1a72fcca58-78102ae5c2csm942241b3a.9.2025.09.29.17.37.09
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-28c58e009d1so21347185ad.3
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192628; x=1759797428; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BF+1RWP7HZuZ0jVq4900WIuWJRcPMvRIlRba3aJr6+c=;
 b=ZIN6d6fatASUSo5TflbemA01QuZfqyJpHnDbZV2aJ4NcYX9qUYMDUgv6zNtTXpv0VQ
 7bhUh3z3b70daAs67mNlsvrUopdxIXmkb5TXCsR+9K4zkzGAkXNAfj6Gz+DT6oSJ8CLP
 piMa+axw/kLslLemhRznhbCDdDmtyq7WmdSrI=
X-Received: by 2002:a17:903:1c9:b0:24e:e5c9:ecfd with SMTP id
 d9443c01a7336-27ed4a491ffmr225384405ad.42.1759192627999; 
 Mon, 29 Sep 2025 17:37:07 -0700 (PDT)
X-Received: by 2002:a17:903:1c9:b0:24e:e5c9:ecfd with SMTP id
 d9443c01a7336-27ed4a491ffmr225384195ad.42.1759192627377; 
 Mon, 29 Sep 2025 17:37:07 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.37.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:06 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH 26/54] net/bnxt/tf_ulp: optimize template enums
Date: Mon, 29 Sep 2025 20:35:36 -0400
Message-Id: <20250930003604.87108-27-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250930003604.87108-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:07 +0200
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

