Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7228CCD1A5
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 18:58:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 020FD40E45;
	Tue, 21 Oct 2025 20:57:49 +0200 (CEST)
Received: from mail-oi1-f227.google.com (mail-oi1-f227.google.com
 [209.85.167.227])
 by mails.dpdk.org (Postfix) with ESMTP id 55A8340B9D
 for <dev@dpdk.org>; Tue, 21 Oct 2025 20:57:47 +0200 (CEST)
Received: by mail-oi1-f227.google.com with SMTP id
 5614622812f47-442003b80d0so102558b6e.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761073066; x=1761677866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UnGPfW/53Jz81zuzs9GGKJZBAtKwgg5oTUyMy1CtPUE=;
 b=BFemzyoSVA3fU8vRL5hqQfCn6Qe+mPAFpaw4J3avq1Y52Khl2HctvmTlDUyWFUTr7s
 g3dqdWLhbnh71hmM66ta0V4J01O09DwtxUm9CuBpxyH8IR1SNCs4DArURy33P4a3zFDj
 VIPRsRZNVD2Yw0il7WpUr2oGfL2kSa4dGDpjXnQdxhW1j0N3mgxD6O5RCDoiMspdAl2V
 zhKEn6KxbfttlQw5Sz46zDxBthmBOBWWDaBMxf80CEGDiSaGF9de9ikxzCb26lJRTaJ4
 wkCf8Zy9YQ2mKNDN2PfFk5+ptyuVZesmZduObqezStSyDxrOftGXHhxATg2Mqm2Mfrv5
 Xu2A==
X-Gm-Message-State: AOJu0YwdjKAE7eel3HmZ2zbRjcz6EDXckxM+SZyhEoWnxFrI3xeZ9VTa
 Vcu4aq0Gd5ghTNUNl7E4J3UOyBxq7FTk+HoyKxEZgY03SrGS+VH6WbZV+HBOWLHtog6pUUE9mSo
 sbVqa8+TLQRPendjhh3C5tqvfSDuGPXCStnevKaLDkue56aUuTI1BWV7IJlN584bJQak/SHNiq4
 v6ZnlM7RZ6qKWtMJxjopVYFioYVpySyy5TI2NnqLs+uRc1MKI2L22THSwWYw9RpWkUWgic+A==
X-Gm-Gg: ASbGnctTvlphCuERQV/1o0HrlG8NtHIctaOfcZxaqfeCkLnSWI1DGCr2agXSWbVC2tf
 5esXINkk41sGz5FSV/f4ToXtx8mCFOCk/LYyuGO2cqE1NsWB2Zl/AFV4/Sxnc1A4EAJ/ut3cmd5
 Vz4ErlZZc1dTviiA4YV4Szr3pbKIeWtbJMJdXriQwfzXPlcOFtEOiU23NFmppo0M9F4/5TaUGww
 28S99J/hdL2BP0DXCh0fURHrPLohZrzmHJAFFpkR+eLMncoShUkqMSKyTvEDQRzKcYj7le+tIGE
 QuNYfAqGFf4DzM9zorNtKdfuLCCptqqgkZo7nfjDqoGSWu2VCSmcCi/cquI8XhaD+mh2U5U2c+Z
 xOSHKNQB95W5yp7lp6eucba3Fju1kojveQpoyc9nfBRof1uLtWRpGBb1tBqEzoYruUwVBWTvD2w
 tujYt8ieVA5SeXtG3IIRnSfO2QYpjCEX02q6SH
X-Google-Smtp-Source: AGHT+IEW/QZmXCTig2SJWtY+o+7/vZdcoHfHBfWZZoyo1Nnsu5jz9R325DmfRtK7jNrvluZ32blYNgXTv7uC
X-Received: by 2002:a05:6808:1384:b0:43f:2790:cb77 with SMTP id
 5614622812f47-4495c9fb5bcmr395363b6e.5.1761073066330; 
 Tue, 21 Oct 2025 11:57:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 006d021491bc7-651d3b12c6csm178277eaf.2.2025.10.21.11.57.45
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 11:57:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2909daa65f2so2175795ad.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761073064; x=1761677864; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UnGPfW/53Jz81zuzs9GGKJZBAtKwgg5oTUyMy1CtPUE=;
 b=Lwp3ODXFfmo9kPqQjiebN9H2pp7EAV+cd1enbDGbnP3+eheOlqKl3C2gMul7YDYAIx
 25EhXYFGbGYKb2X2SHzpAXMfi3cwyUwAlvTrFyAXR+s2RsoKRv9wf6wU5yGgtKnXPWky
 7Ic5moChpQxkNO63SC326ifc/RdtBw6oo2IGA=
X-Received: by 2002:a17:902:ecc2:b0:269:a6b2:2463 with SMTP id
 d9443c01a7336-292ffc0b82emr8980655ad.16.1761073063733; 
 Tue, 21 Oct 2025 11:57:43 -0700 (PDT)
X-Received: by 2002:a17:902:ecc2:b0:269:a6b2:2463 with SMTP id
 d9443c01a7336-292ffc0b82emr8980355ad.16.1761073063147; 
 Tue, 21 Oct 2025 11:57:43 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246fdc9cfsm116598155ad.45.2025.10.21.11.57.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 11:57:42 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH v4 38/57] net/bnxt/tf_ulp: add non vfr mode capability
Date: Tue, 21 Oct 2025 14:56:42 -0400
Message-Id: <20251021185701.71881-7-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021185701.71881-1-manish.kurup@broadcom.com>
References: <20251021185701.71881-1-manish.kurup@broadcom.com>
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

