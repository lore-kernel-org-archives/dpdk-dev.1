Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E04CCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:17:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDE8740E2A;
	Fri, 10 Oct 2025 00:16:18 +0200 (CEST)
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com
 [209.85.128.227])
 by mails.dpdk.org (Postfix) with ESMTP id 8DF7840E1E
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:16:16 +0200 (CEST)
Received: by mail-yw1-f227.google.com with SMTP id
 00721157ae682-780fe73e339so10662167b3.1
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048176; x=1760652976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PMUET9oKOU5BgZT25UYKJlu/fowsV70O9uZgsRHOT84=;
 b=XQASkKmw1qZm8ahjblRA6iPM1uEERkAqGqRnVYFrhYHDTd0MuxrVaYXtXqIzGA8A71
 p/qUgVYhbMt5JLmb3Ig+G15ZNm8U8fvlBwtb9znYQNiLnwAg76GE59dR1d/8VGURToTH
 UwWIuTTjX7TNhU7E2UqWpCaEEQbKD56D5WecPwYLXXwLsKnrqsKG1ybHaklhDHTGpNRW
 0bXRAV1tzHtEeEGx+AL1+aqkKv0l/QVZ7uYet41x8+ZrG/uv5udt8fYKAGYmeTXKE9F9
 Vc6IWhZ6uDKRVC4+qymrAOyG1ssIfoUtA4zzLNE6LUaAWmwnRkONOKYDsZj9xAHvW/4B
 XwGw==
X-Gm-Message-State: AOJu0Yxm8Y0v5keKtZxbznDBrutdqJQgKigk/iuBFxpZNDn1eeSGCXSZ
 SZKFv48aO75rvv49MVUF3AgTqjqgTCmFLTP3xSkTZkiV81LWCn1bu2ZGjMZQL+f3XyeguA+a1LK
 WQhFnMT6paM88wwZlPHF9xVfFgFXXb5ttU3stDgf1aAYVeym47qUjhAHqxk5uUMP/XGPM4dvQMR
 9Xejbqv577/QWLihCnpUS/c+e6V+2sqAZF4z6GswDvjbtiGTD4+kE7RbecIakBbPS2jh4Gjg==
X-Gm-Gg: ASbGncve7mT0MBxgdNiMF4HdXko6cqRfCDNaejDBY9XCSFTBwC8ARnyVe2ZWZpxHzf9
 ySnnjvsYEVzRebCmDQ00CBhQq12IYUn8WVB9Qwrkn9gS0IoFQeTuaQROtIaqIHFCdbDZS0cy8sP
 UUP9PJzmQBdfgnWXMvNhNGCm8iev9sejjpP00mwSEUbo0/+GjYcHxRTbZn6YNR4lJLViP3eTTcD
 00UhsFOuAB1OSJUl+qHIsBsIwDjimEZDr1LOOzxnmDHfJxxNdYs5Iw2PTbFkj+KXr4WGNjjLUih
 6iKIUUnryTNDdhO7bUoQt6ZSCM+Gh8lWeNENjMUHhFdoQcbzJ8EJLem3OmUL8ifFtI08vtebXIB
 FK2OSVRXFE/G9s6zOXrnBBFr2DHgFuR1AKepmyfjvoGxKj9Tmygzj2395O5p2w1+IG4wlpLUK5D
 2vWUoL
X-Google-Smtp-Source: AGHT+IFrsf3NOPTLMr9xlTbqe4Qt8P/1To2tMbQR8MxThnAKAn+0Ycggx0LIV5Alu3/6/1iif77pAIIROAxI
X-Received: by 2002:a0d:d2c4:0:b0:781:64f:2b73 with SMTP id
 00721157ae682-781064f3653mr9986357b3.28.1760048175694; 
 Thu, 09 Oct 2025 15:16:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-78107071317sm406637b3.37.2025.10.09.15.16.15
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:16:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-7fa235e330dso45742236d6.1
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048174; x=1760652974; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PMUET9oKOU5BgZT25UYKJlu/fowsV70O9uZgsRHOT84=;
 b=Q26aZAmdXzG2ZLeMEHPXIxEtshIbQNBs+moUf6x8DPo9RNLbRJVAIJkMkurBrp3dSs
 AZk4GkvOk4dAtiSyV4Dnlu/U9dUY+L6jOrPRDzuJRr88zb6TPryGGAb9wJ65K5jNtPzq
 4M+qi3PInqb4iWYcx9H1qfDwRPIFdjrZyVCT0=
X-Received: by 2002:a05:6214:2b06:b0:7f8:21f8:6f7a with SMTP id
 6a1803df08f44-87b3a7fb6aamr128109336d6.23.1760048174624; 
 Thu, 09 Oct 2025 15:16:14 -0700 (PDT)
X-Received: by 2002:a05:6214:2b06:b0:7f8:21f8:6f7a with SMTP id
 6a1803df08f44-87b3a7fb6aamr128108856d6.23.1760048174072; 
 Thu, 09 Oct 2025 15:16:14 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.16.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:16:13 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH v2 35/54] net/bnxt/tf_ulp: add non vfr mode capability
Date: Thu,  9 Oct 2025 18:11:10 -0400
Message-Id: <20251009221129.28256-36-manish.kurup@broadcom.com>
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

