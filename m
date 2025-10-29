Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA118CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:20:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 365F24066A;
	Wed, 29 Oct 2025 17:20:35 +0100 (CET)
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com
 [209.85.214.227])
 by mails.dpdk.org (Postfix) with ESMTP id BD2A54065F
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:20:33 +0100 (CET)
Received: by mail-pl1-f227.google.com with SMTP id
 d9443c01a7336-26d0fbe238bso54506155ad.3
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754833; x=1762359633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UnGPfW/53Jz81zuzs9GGKJZBAtKwgg5oTUyMy1CtPUE=;
 b=eYG9AhpkOQKa7lfcjIdo4tmX0SoxEhIcAjFx24alxDxLwE2QOej6z8/e9epyXwzw7g
 AbVhV/GLfOvrlWCSdJDqJg6YPKy4aJx+/kHXogEie+MY/q93tPB9/n5L5cdTjMzwQgwD
 ECCQFxr1zqAqt7++527rSH282JhU2iRT7LFe8nbt72dUrwvSJihFpCNXJV8jq746jGOD
 0UIO1xz1B4b1c0FiJWCflQzYb3ItDY2gAKZlCzcaZqDY0yACw7v7s4FC86QmqR9dZQIO
 p3CWRICbVMf9lNrIktIqcvG5IKtWBYdkU9sTgumYrTZ8oqmVD673APa9FYXD/bthVK0D
 xYOw==
X-Gm-Message-State: AOJu0YySashLOPu8IiUzClJQAyxEBni0smRmdP/nvMQnN4+EfwgVU15t
 3jmOBSg1VHQ+D8lWRxKvtiM/qjRBdnILNnk++llfq+VQme4tIhTZ8q+IcHZwsSz3pur6K4whFG+
 /g8pjh7QYjKpDtSS8Kp3PV2abfqW0Qbl6kkK8CzGC95Vs2tS1eXbTcOtTz/LJ143UgogqhqQb2U
 OYa3uZHzJ5ZBlvTKzAjWezEAgNcIZja/Ii2EOi9w030krGDnpbl/WVbwdQe4TEhius6c8D6A==
X-Gm-Gg: ASbGncssphaIhOsIVLEncU57oYkRVm+poZyPADah5W6W7EYhIaBAESXSdWn73sxLDwN
 5qcWI4LpF58yGzSuOdXSIlD3XTcM1M+M4fdTLKiPWfCkc+gzZW48r5P6ZVpB+n4pQ/iv1MTEiwl
 vKDOVAIA/mwWTUAWmhtp/Os8YqZeQYA62nTgKxdJ8qQNYZGr/qaGpYuQLbsU7VXJSTyEKSQ/1se
 SOPJ3lLyWvgJmOaF7dvfzOwvuWszybbaZkN/2S6xilnlBNGZFzvGmSb/RtFgfrhvb9OJZuGaw2T
 oL5ZYVEjBtNlX2u8+NYUobIVKItb7BbeqxzA3ncTTWi2ZRpAzfvuVN03qIeUKLVQUzyIYzDAL6i
 W3NwjkeMrA/e6z18ozu4XEi1D1Im2hl7ealASDktZBcjPtMaDFUeGMpemr5/JD7oDCjRsC/zkyu
 YN9ugZOKmKfmuepy+8E6LJdNpjsx6KwpFV/z7O
X-Google-Smtp-Source: AGHT+IHhtgTiac+0nR5/zD0bRvWW1zcyrN/ujmr2HnhtCE0HkJ9Y/dJSdxx1NnM+WSkXBXNqBVatPlGlwzsS
X-Received: by 2002:a17:903:22c5:b0:290:c317:a34e with SMTP id
 d9443c01a7336-294dee33a17mr40271675ad.25.1761754832770; 
 Wed, 29 Oct 2025 09:20:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-29498d0aa83sm13581525ad.21.2025.10.29.09.20.32
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:20:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8a3f828c9bdso1919085a.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754831; x=1762359631; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UnGPfW/53Jz81zuzs9GGKJZBAtKwgg5oTUyMy1CtPUE=;
 b=dbfQU0Ovqljm+fgC4yKYMdbouRN7Zc2myYMQz+WXicd1uAZkt/7uqz3JmkTkj0p1pH
 /ecNBLv4DnURuNLdUrGqWbQryAOccl03bp4kA/bOeijHUUqC5Qb7BGRH5QYyQY4sP6cy
 lsF3RuM5X9gXffx+KWBDJzseeSVz/JASy7tc8=
X-Received: by 2002:a05:620a:40c6:b0:892:ce2b:f84d with SMTP id
 af79cd13be357-8a8ed72d388mr460804885a.33.1761754831217; 
 Wed, 29 Oct 2025 09:20:31 -0700 (PDT)
X-Received: by 2002:a05:620a:40c6:b0:892:ce2b:f84d with SMTP id
 af79cd13be357-8a8ed72d388mr460797785a.33.1761754830491; 
 Wed, 29 Oct 2025 09:20:30 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.20.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:20:30 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH v5 38/57] net/bnxt/tf_ulp: add non vfr mode capability
Date: Wed, 29 Oct 2025 12:06:53 -0400
Message-Id: <20251029160712.58519-39-manish.kurup@broadcom.com>
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

For Wh+ platform, the generic template support representor
and non representor mode, this flag shall be controlled by the
newly added capability flag that is added during the compile time.
The flag enables the testpmd forward mode, so testpmd application
can forward packets from one port to another port.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Shuanglin Wang <shuanglin.wang@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c          | 5 ++++-
 drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h       | 3 +++
 drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h | 3 ++-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
index de87ce0349..54a5e6968c 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
@@ -1049,6 +1049,7 @@ ulp_tf_ctx_init(struct bnxt *bp,
 	int32_t			rc = 0;
 	enum bnxt_ulp_device_id devid;
 	enum bnxt_ulp_session_type stype;
+	uint64_t feat_bits;
 	struct tf *tfp;
 
 	/* Initialize the context entries list */
@@ -1101,7 +1102,9 @@ ulp_tf_ctx_init(struct bnxt *bp,
 		goto error_deinit;
 	}
 
-	if (BNXT_TESTPMD_EN(bp)) {
+	feat_bits = bnxt_ulp_feature_bits_get(bp->ulp_ctx);
+	if ((feat_bits & BNXT_ULP_FEATURE_BIT_NON_VFR_MODE) &&
+	    !BNXT_REP_MODE_EN(bp)) {
 		ulp_data->ulp_flags &= ~BNXT_ULP_VF_REP_ENABLED;
 		BNXT_DRV_DBG(ERR, "Enabled Testpmd forward mode\n");
 	}
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
index c46340b1a4..14ee1e05fb 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
@@ -1064,6 +1064,9 @@ bnxt_ulp_cap_feat_process(uint64_t feat_bits, uint64_t *out_bits)
 		BNXT_DRV_DBG(ERR, "Hot Upgrade Feature is enabled");
 	if (bit & BNXT_ULP_FEATURE_BIT_SOCKET_DIRECT)
 		BNXT_DRV_DBG(ERR, "Socket Direct Feature is enabled");
+	if (bit & BNXT_ULP_FEATURE_BIT_NON_VFR_MODE)
+		BNXT_DRV_DBG(ERR, "Non VFR Feature is enabled");
+
 	*out_bits =  bit;
 	return 0;
 }
diff --git a/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h b/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h
index 3ce43f4c92..d63862ffba 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h
+++ b/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h
@@ -913,7 +913,8 @@ enum bnxt_ulp_feature_bit {
 	BNXT_ULP_FEATURE_BIT_MULTI_INSTANCE = 0x00000010,
 	BNXT_ULP_FEATURE_BIT_SPECIAL_VXLAN = 0x00000020,
 	BNXT_ULP_FEATURE_BIT_HOT_UPGRADE = 0x00000040,
-	BNXT_ULP_FEATURE_BIT_GLOBAL_TBL_SCOPE = 0x00000080
+	BNXT_ULP_FEATURE_BIT_GLOBAL_TBL_SCOPE = 0x00000080,
+	BNXT_ULP_FEATURE_BIT_NON_VFR_MODE = 0x00000100
 };
 
 enum bnxt_ulp_flow_dir_bitmask {
-- 
2.39.5 (Apple Git-154)

