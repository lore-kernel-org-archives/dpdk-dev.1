Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C96CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 17:54:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 727A640E0C;
	Tue, 21 Oct 2025 19:53:13 +0200 (CEST)
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com
 [209.85.214.226])
 by mails.dpdk.org (Postfix) with ESMTP id AF132410F9
 for <dev@dpdk.org>; Tue, 21 Oct 2025 19:53:07 +0200 (CEST)
Received: by mail-pl1-f226.google.com with SMTP id
 d9443c01a7336-2907948c1d2so63607885ad.3
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761069187; x=1761673987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BF+1RWP7HZuZ0jVq4900WIuWJRcPMvRIlRba3aJr6+c=;
 b=WFn2P3CG2lnCGea7isoQc81jM8ljUF4IkYPgOuiBqCxuLHb/txdqopDHygXqxyVKHc
 J/a3ld/IOUVx/T5mcFloegnzdV52lvX7/S0+iTMjGQF0vkLcl5cyXmYAOKwivUZy+5ki
 3nz0dPWJFQqi2VhtNA7W+V7D+v/Hcht08/MEFS04tDhwUarm9B206MNQj1Gfov1DuArq
 yRR9LtRhuC3kMrgF5jelTmZg2XpPFAW1BmkEhIFE5KwkdpV1fFmkpmeIV4+giYE7Eq8Z
 n86NmAMJMCXbXIQemBZa6ERVDrXho7ppfdAj0SwwT8Hq7pYA8IKsjTKk8bcHkBUT3SlV
 J9gg==
X-Gm-Message-State: AOJu0Yw3eIAwoTXkqLUyFgoUPVU2DEGdH7wQPgMQTXO0pb4cCKawYHHB
 PNTvfFI3kqviLrAlGFtVIcAF0q1nGdeL81dZ9FgRwJduSF5h+zdsF20I+OIdMEMxhC2Xin/ra1Y
 0KQvBK6mTb8ScXB2lUabLd5wOh9euRFw4i0xflwcRWIE8CyC/PLVT8haG1r3KpruS4n85L9PcaX
 AQHmtvNr38ll1x57BqMv4gUlEKlKkQb/cNssX/cc3v8cJOsQD5olrxfB08A9k8SU5qyCmEMA==
X-Gm-Gg: ASbGnctw7h70L0IAnH/A73q99Dlcjl3CeAqzxxj5rgdinH0BoCpOOESzf2oYuXKC6BU
 hW8OFS2CcQ/9Ijn8cO0bP98MOY++V085t/qASS9L+I6r2m8Y/DBCWe7PEBhZhFBwc6194jsXQjI
 Ba1GaYhiz/u28VGww2Wjw0w9u2tkWWM+CCXg/h1WqZVWRuNukqgSthmQeRswEP7wqXJcEjJGAEB
 2lukYKsU/ByvGOgRfkX+HszUHXH0NdUwLJuaSBlC/MMvUfaCk/dpDUg5BZ1luwxunRUnAoF+JHi
 tMeUGOfapcnSdLe2QyyvncYGhIVSb/ZHbLn8NFJJvnjj4inZQtVk1CVtFuDoTTkl7ReX2P5Mehl
 VWpatWTVaqaqDwlGD4r0srPc0cycmIUngKmAKIEAo+GrHRJckB+DkDzSNIR9fn2OQ0vYc8H2Ksj
 lSif6VtG/jFUO0maRPgGiFyjltmiwKPlE=
X-Google-Smtp-Source: AGHT+IEm66UTe/SgVDAn4pkJu+VT/ANjWLYusupiWbziEJVBw5lYBD1+gT1ExTWr+s51D4ut2mYW79ltdPti
X-Received: by 2002:a17:902:e5c9:b0:273:daa6:cdf9 with SMTP id
 d9443c01a7336-290c9cdd599mr203185835ad.22.1761069186701; 
 Tue, 21 Oct 2025 10:53:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2924701570bsm13796795ad.21.2025.10.21.10.53.06
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 10:53:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-33bcb7796d4so5322514a91.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761069184; x=1761673984; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BF+1RWP7HZuZ0jVq4900WIuWJRcPMvRIlRba3aJr6+c=;
 b=CZecWho1owGNW8I2XnWJ6Rcx6fSK8pdLap8mrfxNR9WLaPHTFE9pq9UZBbQPVW2Z7I
 otd+9nxDBc6SKHhEL5Ebn54IpLmqYtR5IYqjnCG/iPe/1qcyMpZzvrzqYI1vv8yQ2t4F
 rosxoq7o2C13LHLJgBx53j1bk+r8Ns7DsNTkI=
X-Received: by 2002:a17:903:46d0:b0:26a:b9b4:8342 with SMTP id
 d9443c01a7336-290c9cf2ca2mr228024545ad.25.1761069184490; 
 Tue, 21 Oct 2025 10:53:04 -0700 (PDT)
X-Received: by 2002:a17:903:46d0:b0:26a:b9b4:8342 with SMTP id
 d9443c01a7336-290c9cf2ca2mr228024205ad.25.1761069183910; 
 Tue, 21 Oct 2025 10:53:03 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292472193c2sm115441495ad.104.2025.10.21.10.53.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 10:53:03 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH v4 29/57] net/bnxt/tf_ulp: optimize template enums
Date: Tue, 21 Oct 2025 13:50:21 -0400
Message-Id: <20251021175049.46092-30-manish.kurup@broadcom.com>
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

