Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1469CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:05:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF90140E45;
	Wed, 15 Oct 2025 11:04:30 +0200 (CEST)
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com
 [209.85.219.97]) by mails.dpdk.org (Postfix) with ESMTP id 0959540E40
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:04:30 +0200 (CEST)
Received: by mail-qv1-f97.google.com with SMTP id
 6a1803df08f44-7960d69f14bso49561136d6.2
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519069; x=1761123869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BF+1RWP7HZuZ0jVq4900WIuWJRcPMvRIlRba3aJr6+c=;
 b=nvagMTJ2ykAXidZqYRpmZU880kjnET+6XquYpNOXqU0uO/Sn88/5f5LFcjZ/vvYjXm
 j3692al6D2yOvxR2hRak1OFhhBI1SVOVIk20WKk1/0//NZRO9vx81j5raL3MqSmXSWou
 eKRBtTTAxYuJfNnudCjpji8bdpaik82ixDiZJR+s5EDLD+0JX7POxE0aXY9jlUsdTmg9
 56AGGkDH0qocZ4loD4ljNTVxpDE//Q1b/AXCny7p/Oc16IClf6azqgj+9dU9xD5HTaeO
 CxgIjg6qEEBMAd57HE7zDMKQp3kO5JbD9gzTNgK+AeSn1hGbGLfVjbwzdcbuysf2ZJMt
 Y8KQ==
X-Gm-Message-State: AOJu0YwQaRfujseeBEF9IvDJ1i6ShRJmN/NPDDvKZLhgqCzLQYGJQiUv
 tXTs+Bdm7Pft2DnBL5mHSLbYQpkaP2j8JA4h430gjwXA8AcYOP5K16nhLkUXB2uPalJUQzn0qsE
 XyK1xAzXS9CdykKXL7Ze1O6AHqehHcbTMAn1gm+NicyvkrCUd/Mu6br1XBxl5bGa446UPF+6Xyo
 vg1UtsbqtlRtLNXx5zE64Ka7xVnjIaEMHeuakL6RSlX1O4DaRY05gGOd8HVi2D5wcwozYgCQ==
X-Gm-Gg: ASbGnctY6gn2gSt3A0g9yXe1eAfu4seKRrDSz530ECeHQ+HMv7bGWn0cKKByT0h0crW
 3QI2QI/GBiAutuPP6b2Edc4pJO+LselkvKu9pjwwW1KG1Gt+iHg1QI/vZn7JFFQ2n2rp5jk2f+g
 8sDDOsoFyNJoP3uUUcB//C89Fd4ASquGFrvyuK53cfV5aHBdSMSSmUyjWpqHTLtuNi8J8JMSTqr
 za3c974YmRSrvvno+ZT+UolN09vZHBzFGh+dZdOkE2y1SpH/Yoe1p/pAxKgwbmfZktHvlZI/s1A
 BqozR/LY/HACdaxCbe093F8wdz4zumMyb3qtNHPMMDYHM3GmoOcRBs0xUU483jLCfaZ92Hzjrid
 AxoI58+w4jqz79oZ1Ok1v/oPqZ3fcyt+MK/koQyfLCJJpW657xHkB7C9QUo/SsMM8uqmEYC+ku5
 CTzQ==
X-Google-Smtp-Source: AGHT+IHr7l57YIkK9knlCb7Jik7hB9Zr/+dAW824TzfQsvXQv/phkWBD+clISAfjjYEPe6kioKnvYUoxbnmr
X-Received: by 2002:a05:6214:2484:b0:802:b081:4f14 with SMTP id
 6a1803df08f44-87b2ef7b460mr384681406d6.66.1760519069040; 
 Wed, 15 Oct 2025 02:04:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-87c0122172esm1909566d6.10.2025.10.15.02.04.28
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:04:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-77f5e6a324fso17697017b3a.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519067; x=1761123867; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BF+1RWP7HZuZ0jVq4900WIuWJRcPMvRIlRba3aJr6+c=;
 b=ORLUxkXHlqNYU6CCCxOIVng4CuIUXsuG3unws8v8bvSoSVGZ7DqAyPBKGRdWwci6R7
 eGmK1gEkcQOkZzPx8kvjRYCFSIqeBpr6sQ1A9bYlHL5BLzBzKMaSZM5PfbKsQj1Twg+E
 X0u+q3tplAYE1Byuwkx9+tcKJ0BYc6cTz2JoY=
X-Received: by 2002:a05:6a00:17aa:b0:783:cb49:c67b with SMTP id
 d2e1a72fcca58-79387d0f40fmr36521529b3a.32.1760519067363; 
 Wed, 15 Oct 2025 02:04:27 -0700 (PDT)
X-Received: by 2002:a05:6a00:17aa:b0:783:cb49:c67b with SMTP id
 d2e1a72fcca58-79387d0f40fmr36521492b3a.32.1760519066606; 
 Wed, 15 Oct 2025 02:04:26 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.04.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:04:26 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH v3 26/54] net/bnxt/tf_ulp: optimize template enums
Date: Wed, 15 Oct 2025 04:59:56 -0400
Message-Id: <20251015090024.32250-27-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251015090024.32250-1-manish.kurup@broadcom.com>
References: <20251009221129.28256-1-manish.kurup@broadcom.com>
 <20251015090024.32250-1-manish.kurup@broadcom.com>
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

