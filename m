Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E8CCCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:16:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3455C40DCE;
	Fri, 10 Oct 2025 00:16:00 +0200 (CEST)
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com
 [209.85.210.227])
 by mails.dpdk.org (Postfix) with ESMTP id 2677140BA2
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:15:59 +0200 (CEST)
Received: by mail-pf1-f227.google.com with SMTP id
 d2e1a72fcca58-7810289cd4bso1436867b3a.2
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048158; x=1760652958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BF+1RWP7HZuZ0jVq4900WIuWJRcPMvRIlRba3aJr6+c=;
 b=Xct4ZGwl43yjmW1fyijwGf4WwHpXmdDoBaXBDl49KbM9HQzGxRI5oIPYB9aTm4gBHE
 D4PeUvUBHON04qIpMPze82IASsIHULNKVcmDlwfD4Q19l0rdUBO3S6Cme7WVKmlxxxAk
 00DAbtUUAAocMSsxeS+SaqOK28ww3UsD6u1yZfGVJxdsdHcEMi0Yg35+B3jyhGVbc3sI
 2GfalywFn0/LAr48vLAoUrJx/jLxwXKYwPtxdVtDrXFGnw0DUCDSQvWs4cY4Q79M1FkT
 pBy8Bl9DqSm3GNbpafsK+gFp5ns0jSbRe+wPeRuPQQKi7+AUgi5Wz1Tm37zGL4udVaU7
 7WRA==
X-Gm-Message-State: AOJu0YxRdamJ87I5XXb7IFmtwcy9O7YPdq4GUo+vyVELAAT1/v8z4pSB
 2bgaZSI32LHTehD2K0o6OzqbhhBVl1ZKNTLrRC9ReOGLNpu5zMBeRfiohHYk+8NNoPV27uTpuo9
 F6u+ot9I/fX0IZ+3Ky4J5MiG5B11IexntpcNMux6FB4mgY0rT5XwcjysiCJs1DnKtHgrQf7M5hL
 +fafd0bWMFg4dpyu8z2aPovgQo+QkAisxIdR96tA026GZ+0lzxn+VRn1vSVpm/iy4MMDh6/Q==
X-Gm-Gg: ASbGncsKlKbQfiy4KaVu5ne8xyJ9+5xKYA12jkITu6aUUnXRJi7048dP67i4GZSGEPM
 Xak7jO+u00wQE7WxZltSKZhimpTV8IHoxg7puQK/Jw8Zru1+brEq596KSvTwqSDuOdrIkzx7Wsr
 RKZ8Emdm6bHM2MMzcFN39kxdZPoNVdGjv8Lcj19Bnwg602Bxcq2XxWXJCNR9FvsbhyoxY9ITSpM
 U2Hl9mafH4tORTxwQBBEWzodLvT4zEUGVIf7U+E3PEy368FOfrKHNc1avHDVuiFNkHNLPcd1tqy
 vssP/dWiwxCPc0k43vKErhkZWWsa96pEAEpy1hnq6HR9tbRLOQk0me22bgSJJ6QM3vjAOl07AJG
 nX70fCffHFQhE0da+y7KOAFXsvANwFanId1PSr68xDjaAjTutJ8FP45qMNL/7U8yh35BQrXVIYb
 no9a6UdNI=
X-Google-Smtp-Source: AGHT+IFDbEZR9C3xKy6B9tUW0U4MYCRLAwGG0zWYQCNNMyK/wgn5sqnAAEZwQFAqQTkS7cykxxQxguCqzlnT
X-Received: by 2002:a05:6a00:3c87:b0:792:574d:b13 with SMTP id
 d2e1a72fcca58-793858fb720mr11488409b3a.13.1760048158023; 
 Thu, 09 Oct 2025 15:15:58 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
 by smtp-relay.gmail.com with ESMTPS id
 d2e1a72fcca58-7992fbbb666sm74834b3a.1.2025.10.09.15.15.57
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:15:58 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-859df490f9dso258553085a.2
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048156; x=1760652956; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BF+1RWP7HZuZ0jVq4900WIuWJRcPMvRIlRba3aJr6+c=;
 b=HyErZhekm3Y1G89WICj76c1i6iqEeDHpI0RwxtPuyFu8IRG6NECdxNVC99uIutamCv
 arJvevNc2IK4nYtl2IIOlX0f8EEajM758q4udDd7PSb/9SodBZc0AISk47UQe4u3aTMV
 2tqIkAjKeHFlP7kYK27GcMxaQ6ymDdVh7DlpI=
X-Received: by 2002:a05:6214:130f:b0:795:184e:fef9 with SMTP id
 6a1803df08f44-87b2ef1a0c6mr108484046d6.33.1760048156191; 
 Thu, 09 Oct 2025 15:15:56 -0700 (PDT)
X-Received: by 2002:a05:6214:130f:b0:795:184e:fef9 with SMTP id
 6a1803df08f44-87b2ef1a0c6mr108483716d6.33.1760048155596; 
 Thu, 09 Oct 2025 15:15:55 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.15.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:15:55 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH v2 26/54] net/bnxt/tf_ulp: optimize template enums
Date: Thu,  9 Oct 2025 18:11:01 -0400
Message-Id: <20251009221129.28256-27-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251009221129.28256-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
 <20251009221129.28256-1-manish.kurup@broadcom.com>
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

