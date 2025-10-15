Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DCACCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:06:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3E1040E5E;
	Wed, 15 Oct 2025 11:04:59 +0200 (CEST)
Received: from mail-io1-f99.google.com (mail-io1-f99.google.com
 [209.85.166.99]) by mails.dpdk.org (Postfix) with ESMTP id 5C9F1410D2
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:04:58 +0200 (CEST)
Received: by mail-io1-f99.google.com with SMTP id
 ca18e2360f4ac-93e2d26fc82so411402639f.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519098; x=1761123898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PMUET9oKOU5BgZT25UYKJlu/fowsV70O9uZgsRHOT84=;
 b=luQueKUcFt9sNOBvNflWgraNSu0qa44KPZ7zidsQ6wp9WohQMBsYWCRsBvmWiishaj
 LkmkoRGST4/LTtPLElekAZVF/NMLcEL1lnjaSmnmZbw6CwigA/VfGAlwHfjKlqHdJwHl
 HKAKHmciTUmQrkTuACh+1tHLuIg26ARa77i/IvbppC/R635Z4NnF/2IUNueNHz6qbMCv
 ptUB401KEdXUSMmJ0IgOFN5V3Ha6gx1ENiPXU4mzqp1CHRjPEaY1ZZcnGZ1iO80sO3Gi
 6eiIY4f0Ddt8MsGbvPzWlXICz0Q9hpJ5/0NlvVxFtULetMSWjob6rhFIVBFyikMZfrg8
 +Qew==
X-Gm-Message-State: AOJu0Yz1nOdvY1/S0Qbuu2Ks6Y6p4y8y/GBwcbXyImUIu1WD/9OTQG1V
 x4JI5Vj1iROwkvctyEoTw0yGThP4fFrZR9HpN73QhyKNE5SgDDgkmo6Oe6G6iIhw0Oq1itFvivR
 iaThQ4aqtpOh82O8hPqcPGaaxrrOkNEIPv5m8cgGavq5XWaAIINgPfUNRmQP0djyfOvyLbS6XwS
 3Jy1fHuNUWfbrkELP6L5TumEg7NB/QiQPxDG+RBk+s3ZSUlwYEKTH9Ab/FMWutD2fmhOUFtQ==
X-Gm-Gg: ASbGnctOJ/W8UcfD8NX3ORkaxqSXgZdfMqC2HBVcE+ATaLH7aDku7Kt26c6xa0ur8Wp
 e5MDhuXX86vjy1onV9F+r/jwU5Ky8bjJjUdi18t92ja7JW/Ujk2v50O7AfuqOhf0rWVd75mcJg2
 UH+uscGQYjEKf7OWTti+4jkwRQDVDUYxyVhlQDz+/t8Oc3uQPfzfO/YO0vzZ8JJ+42wfbg0bWk9
 eReU1PiCl3w+wfPu+P81ZFYqLHePzLL4HN+US/MR7cztnFN9lY0eriEMtGti1eCJAq4DwYRoMvc
 +FgqSzO57MBeFK/2tG9GP4VaBZEv0f40ukMVa5eC9yUJhQMiZE2H8CrHR9stZpPhNkNSock7Ltx
 uWX0KDEHJ40WD+OchAgoyqSwvaXMgh1yNXMyKG2eS8kJNboWFJYMIU9HKs9J67fXE2ZtwHEvw/K
 +iiw==
X-Google-Smtp-Source: AGHT+IHomjbrI0HIYC+OcrNW7Up+GfCoVcmlRoSCCHcK85hiczBr6Qh4gvfjbalfM4JCW3F/AH/4DbYl9nky
X-Received: by 2002:a05:6e02:164c:b0:430:ae1a:3375 with SMTP id
 e9e14a558f8ab-430ae1a3634mr10847775ab.26.1760519097584; 
 Wed, 15 Oct 2025 02:04:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 e9e14a558f8ab-42f903396a7sm12348375ab.25.2025.10.15.02.04.56
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:04:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-339ee7532b9so27587547a91.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519094; x=1761123894; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PMUET9oKOU5BgZT25UYKJlu/fowsV70O9uZgsRHOT84=;
 b=DhegH+wgXtlSFt/zc5axrvyp/8Xr+RPLEQW7WvdSG5gmCwfPU4zPzr6iymoNrE3e0V
 bU3UmM2wdH9nPD+Z+lRRibZek5CvQu6Gcmo+bS5eEfqHsNDPZNmedWhMtJmDdqcRFfVq
 63VJLyVfICC6KaeGg2Zz3jPUMCiDfd8BWQxaI=
X-Received: by 2002:a17:90b:33ce:b0:336:b563:993b with SMTP id
 98e67ed59e1d1-33b5138e694mr34026033a91.28.1760519094579; 
 Wed, 15 Oct 2025 02:04:54 -0700 (PDT)
X-Received: by 2002:a17:90b:33ce:b0:336:b563:993b with SMTP id
 98e67ed59e1d1-33b5138e694mr34026002a91.28.1760519093958; 
 Wed, 15 Oct 2025 02:04:53 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.04.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:04:53 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH v3 35/54] net/bnxt/tf_ulp: add non vfr mode capability
Date: Wed, 15 Oct 2025 05:00:05 -0400
Message-Id: <20251015090024.32250-36-manish.kurup@broadcom.com>
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
index 78fd96ce48..3228bf4f99 100644
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
index 4134e2f628..baff9ef049 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
@@ -1095,6 +1095,9 @@ bnxt_ulp_cap_feat_process(uint64_t feat_bits, uint64_t *out_bits)
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

