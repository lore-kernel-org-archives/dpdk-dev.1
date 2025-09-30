Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A48CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:10:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0497840EDB;
	Tue, 30 Sep 2025 09:06:07 +0200 (CEST)
Received: from mail-io1-f99.google.com (mail-io1-f99.google.com
 [209.85.166.99]) by mails.dpdk.org (Postfix) with ESMTP id 725E1402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:25 +0200 (CEST)
Received: by mail-io1-f99.google.com with SMTP id
 ca18e2360f4ac-91f6ccdbfc8so110609239f.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192645; x=1759797445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PMUET9oKOU5BgZT25UYKJlu/fowsV70O9uZgsRHOT84=;
 b=udzoSa3T6Diu8VWMXVBR6G389goFs6r1uH76RnQdpqokHivgCLoP9Y3GmCV06B6Ov+
 2ENWJKIzuGDKELtjiV5gvdUOYy0gqhra72bgkkcFEuBnk92tf5Rj9Oi/Fiu+qdap6K34
 +UxGFqQrcBowj0BQe2Hvi+vpTrC0YQMhXeSTQmmmNaREQIcB1olWH2NJokntPqQVdFnO
 BtlgtLNfo2LHmvWNSfA/a7TBpJiiRou5fnFlbQyT0mVAbPKLy05ZtkZiqU3/o5P2QSMY
 ckIJCYKIvfgeUnEsS7xhP9n3soeECyuPZp81Y8XujoF5jRNRDYy0SHdzff19lOsK2Oy5
 WzQA==
X-Gm-Message-State: AOJu0YyVdyNMIGhrpXi895ohUAvXkDG/uhibAQoStZhyCa3AjQ0IEutq
 4aymAhXYfIpekCWAh5IeBvyDWRQor0qFkwyYudidRwFFTDY8KebejjbU1ffoxgkg8ZEPrYjmXqE
 eZHUkX7yAnX9soqK/g6OPmHlBWDWJSJQtSWf1XohejUX8R6Qg/Hb/DM8nAWHUl0x4f+iE1OxNmp
 /51nedznEuDQSo2W/oXaCm3LV+TKkHDcVKtk5m36dswlyQt81k6D8CLQKLnQ39kFhWpZ9HsA==
X-Gm-Gg: ASbGncs7b+vz9RJv09cpnfBZCAe0E+iPFxjgihoBA2xFoFcmwHk5cgNahSTa34frz48
 Ue1MGgT01gYFDHp0/72GZGV2zJblmUf/hPb4HAhZMnreELSN9Jsh5dD7Il6PmhCwX9XY0ZbCMRp
 GclfpQIGvIz3uF2VShCy7SuvOxV3JniGSmDcNsM9xl+R65dt3FeIAjAr5HcvCu97jaNLhetBngW
 V+z7tPIHWB8tcftmQwHnNgtxa8oHWdyqvabKyHqEzZmKp12NnQUn6aBibT/sVB+mkDqoutU8WI9
 GHtz9TkO0uYSZ8Frj+cUbpidzM8k84Jswtu360jdOnuBiDvgsD4XmkY62LBt/MoREqZ8DoXl++A
 TL/KvexP9PMjo0pFL6+Qlu+ZA7K34dg/gACKf59B4nv95Yq5icUkiSB3T1jjg0s6pz9/ak1tAVH
 ctKQ==
X-Google-Smtp-Source: AGHT+IEU7O7qmT+gkuVKA/8rI9YgMPNq4mYvWApiX8wpMNmwTlgxl2i0CRVcBjlapoOPQIL5OstxIqHn2SLm
X-Received: by 2002:a05:6602:2dce:b0:92e:298e:eedb with SMTP id
 ca18e2360f4ac-92e298ef1d4mr525946839f.10.1759192644683; 
 Mon, 29 Sep 2025 17:37:24 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 8926c6da1cb9f-56a6ae6ec3dsm752553173.42.2025.09.29.17.37.24
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:24 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-334b0876195so5336086a91.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192643; x=1759797443; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PMUET9oKOU5BgZT25UYKJlu/fowsV70O9uZgsRHOT84=;
 b=S/gqBBz39R2wgSzYsqzS2p0QtJqxFIZaJ2Kk83XSU99upNcW1zQ6UgwMw0f5ybE6aY
 WgJBSVmGx/2t0Svs5e2Ndr4GAaqbCqN56jhzZnQb5gOVWXOWqEiNEDd8yLzU1DpRxgnb
 MK/7DGUMA/tejS4FgMF2muUIa42f/IRjZsphw=
X-Received: by 2002:a17:90b:4f89:b0:32e:a4d:41cb with SMTP id
 98e67ed59e1d1-3342a272c97mr19400437a91.1.1759192642769; 
 Mon, 29 Sep 2025 17:37:22 -0700 (PDT)
X-Received: by 2002:a17:90b:4f89:b0:32e:a4d:41cb with SMTP id
 98e67ed59e1d1-3342a272c97mr19400409a91.1.1759192642217; 
 Mon, 29 Sep 2025 17:37:22 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.37.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:21 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH 35/54] net/bnxt/tf_ulp: add non vfr mode capability
Date: Mon, 29 Sep 2025 20:35:45 -0400
Message-Id: <20250930003604.87108-36-manish.kurup@broadcom.com>
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

