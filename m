Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4A6C021A4
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 17:03:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B34E0410E4;
	Sun, 16 Feb 2025 18:01:43 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 0FE0940E68
 for <dev@dpdk.org>; Sun, 16 Feb 2025 18:01:36 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-22128b7d587so4726405ad.3
 for <dev@dpdk.org>; Sun, 16 Feb 2025 09:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739725295;
 x=1740330095; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Im45Wreomm3zRQ/zODQEb4h64DQAwYWmd5YzkwMj5Sc=;
 b=qQHlkBaWxiEkF6ke5LOcJMhPwYbJ7lCESp3o11x42yRJTY6v013dGtFkLzQlT1Xp1P
 ZFenGTzAb6RrKBirYlF2wSbwWsfyGpYj8+UDIyqRpAdxPNY0qZ891Orua5n+67w8d7Zs
 2jf3IyedyECia8TKyI6EM80exC6iXvuod0+TAmtG4TRV2ggf7jwtfHgjuBvNNGBLT0Xn
 gPWdOz9ctEhek8L0VW+cPAx0uWMwGI+WXOELtUxPJzabI/jaicQj+zrtudvhHE75a9gk
 Ycg3wzjCyj2+ZntKpG0G32ePWqR29huElySkEEFkhQPCIuvOyKkm4KGobi0I1w5y9c0J
 kLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739725295; x=1740330095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Im45Wreomm3zRQ/zODQEb4h64DQAwYWmd5YzkwMj5Sc=;
 b=l9bjvftI8Jrzghdc8QVanD0sSCDV4uPaEGTOX7HAwmPk2eOFS1MWd1AJe8rwMyp4BX
 ILf3k1K9JIzrXjR85Z+yM26Eo3l6/yO/jTssj/gZHwHpugYxHfjfdROj+KMeIw+OgklT
 QM62DLmTgcsDEhliKueqKiWRVOCiyFrCRxY+EWiEkyr4dU4Z3uIVVTo4hGMJCmTjCMQ1
 foVERnRmWYNTIXrNyr8WkIE//1mf4cOA4TVb+y6aPYZdkKq04jb34Oo1Hd+axVgUon3F
 dtgKcY/+I4PJJx8af2Ec8NDHH/bRkhHGFNNGoxfpcub6HUwP2RKC9Wmp8Z7tUgTxTssI
 OvIA==
X-Gm-Message-State: AOJu0YzB9XOl0PWMC2Fg31oI5i8AHPifCvU2CFHRnSU8ur5LlZGfqvag
 2JFKlMIXgGOQzgcVqxaodGioy1u1k6rBOCv1vxut8v8JuN2jYWENBhxz8cpasT0QcH+bijiES8x
 N
X-Gm-Gg: ASbGncvU4Xjr5plJn2Dusarj6SVb1tKmvHnSoDl9ZrkUp2gIUslfFocSB3bSdppYN7q
 XHVe7C1RfvjJbxdRuKe7EwcimWcSbsmrwA4kNdAsO7s2Vwcri/SscBw+lZiOefOa8gcPUWW7Cjp
 XqbvXqKo3ttivepyvKzKVu6/w2h2zQ6bzoxjmzdKMquWLwRkaXkDU5O2Ibin23Pun7n17Q0Kj4c
 bjGCz/cO0FpHtUG1rM6nOD3R/Zvuth3EHlKnf0Pkxh7SH4kHKd4dbpfoB7UrMLbjj6WaQRS7O0F
 lZlwV52hGvLvvOT1pcjG6iOZlBnL+cLQjTFb4LnUDmQ4YQFAZp7+0U0LkNVidDYArBaw
X-Google-Smtp-Source: AGHT+IEfSL/5z+54xUPLrF9u3FdFf5NUHG5rEsuMCbailIN/pkFRBkRuhOcjgwHGmSCTZqRDVQ8wKg==
X-Received: by 2002:a17:903:2b08:b0:216:4883:fb43 with SMTP id
 d9443c01a7336-221040ab99cmr110430405ad.32.1739725294424; 
 Sun, 16 Feb 2025 09:01:34 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2211eafd20dsm11196805ad.182.2025.02.16.09.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 09:01:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [PATCH v8 16/17] net/ntnic: remove unnecessary memset
Date: Sun, 16 Feb 2025 08:53:15 -0800
Message-ID: <20250216170110.7230-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250216170110.7230-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250216170110.7230-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Calling memset before free() has no effect and will be flagged
by security parsing tools as a potential bug. None of these data
structures have sensitive information.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ntnic/nthw/core/nthw_hif.c                | 5 +----
 drivers/net/ntnic/nthw/core/nthw_iic.c                | 5 +----
 drivers/net/ntnic/nthw/core/nthw_pcie3.c              | 5 +----
 drivers/net/ntnic/nthw/core/nthw_rpf.c                | 5 +----
 drivers/net/ntnic/nthw/core/nthw_sdc.c                | 5 +----
 drivers/net/ntnic/nthw/core/nthw_si5340.c             | 5 +----
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.c    | 5 +----
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.c    | 5 +----
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c    | 5 +----
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.c    | 5 +----
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.c    | 5 +----
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.c   | 5 +----
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.c     | 5 +----
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.c    | 5 +----
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.c    | 5 +----
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c | 5 +----
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.c | 5 +----
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c | 1 -
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.c | 5 +----
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c | 5 +----
 drivers/net/ntnic/nthw/model/nthw_fpga_model.c        | 1 -
 21 files changed, 19 insertions(+), 78 deletions(-)

diff --git a/drivers/net/ntnic/nthw/core/nthw_hif.c b/drivers/net/ntnic/nthw/core/nthw_hif.c
index 9f699e4f94..d702257d76 100644
--- a/drivers/net/ntnic/nthw/core/nthw_hif.c
+++ b/drivers/net/ntnic/nthw/core/nthw_hif.c
@@ -23,10 +23,7 @@ nthw_hif_t *nthw_hif_new(void)
 
 void nthw_hif_delete(nthw_hif_t *p)
 {
-	if (p) {
-		memset(p, 0, sizeof(nthw_hif_t));
-		free(p);
-	}
+	free(p);
 }
 
 int nthw_hif_init(nthw_hif_t *p, nthw_fpga_t *p_fpga, int n_instance)
diff --git a/drivers/net/ntnic/nthw/core/nthw_iic.c b/drivers/net/ntnic/nthw/core/nthw_iic.c
index 269754c24a..a98ec659c4 100644
--- a/drivers/net/ntnic/nthw/core/nthw_iic.c
+++ b/drivers/net/ntnic/nthw/core/nthw_iic.c
@@ -253,10 +253,7 @@ int nthw_iic_init(nthw_iic_t *p, nthw_fpga_t *p_fpga, int n_iic_instance,
 
 void nthw_iic_delete(nthw_iic_t *p)
 {
-	if (p) {
-		memset(p, 0, sizeof(nthw_iic_t));
-		free(p);
-	}
+	free(p);
 }
 
 int nthw_iic_set_retry_params(nthw_iic_t *p, const int n_poll_delay, const int n_bus_ready_retry,
diff --git a/drivers/net/ntnic/nthw/core/nthw_pcie3.c b/drivers/net/ntnic/nthw/core/nthw_pcie3.c
index 5997ebb419..a5833e166c 100644
--- a/drivers/net/ntnic/nthw/core/nthw_pcie3.c
+++ b/drivers/net/ntnic/nthw/core/nthw_pcie3.c
@@ -24,10 +24,7 @@ nthw_pcie3_t *nthw_pcie3_new(void)
 
 void nthw_pcie3_delete(nthw_pcie3_t *p)
 {
-	if (p) {
-		memset(p, 0, sizeof(nthw_pcie3_t));
-		free(p);
-	}
+	free(p);
 }
 
 int nthw_pcie3_init(nthw_pcie3_t *p, nthw_fpga_t *p_fpga, int n_instance)
diff --git a/drivers/net/ntnic/nthw/core/nthw_rpf.c b/drivers/net/ntnic/nthw/core/nthw_rpf.c
index 1ed4d7b4e0..d5c19e312b 100644
--- a/drivers/net/ntnic/nthw/core/nthw_rpf.c
+++ b/drivers/net/ntnic/nthw/core/nthw_rpf.c
@@ -22,10 +22,7 @@ nthw_rpf_t *nthw_rpf_new(void)
 
 void nthw_rpf_delete(nthw_rpf_t *p)
 {
-	if (p) {
-		memset(p, 0, sizeof(nthw_rpf_t));
-		free(p);
-	}
+	free(p);
 }
 
 int nthw_rpf_init(nthw_rpf_t *p, nthw_fpga_t *p_fpga, int n_instance)
diff --git a/drivers/net/ntnic/nthw/core/nthw_sdc.c b/drivers/net/ntnic/nthw/core/nthw_sdc.c
index fc73e6957c..e32d87b967 100644
--- a/drivers/net/ntnic/nthw/core/nthw_sdc.c
+++ b/drivers/net/ntnic/nthw/core/nthw_sdc.c
@@ -22,10 +22,7 @@ nthw_sdc_t *nthw_sdc_new(void)
 
 void nthw_sdc_delete(nthw_sdc_t *p)
 {
-	if (p) {
-		memset(p, 0, sizeof(nthw_sdc_t));
-		free(p);
-	}
+	free(p);
 }
 
 int nthw_sdc_init(nthw_sdc_t *p, nthw_fpga_t *p_fpga, int n_instance)
diff --git a/drivers/net/ntnic/nthw/core/nthw_si5340.c b/drivers/net/ntnic/nthw/core/nthw_si5340.c
index 05cadc0bf4..ceaa58e0f7 100644
--- a/drivers/net/ntnic/nthw/core/nthw_si5340.c
+++ b/drivers/net/ntnic/nthw/core/nthw_si5340.c
@@ -44,10 +44,7 @@ int nthw_si5340_init(nthw_si5340_t *p, nthw_iic_t *p_nthw_iic, uint8_t n_iic_add
 
 void nthw_si5340_delete(nthw_si5340_t *p)
 {
-	if (p) {
-		memset(p, 0, sizeof(nthw_si5340_t));
-		free(p);
-	}
+	free(p);
 }
 
 /*
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.c
index d3213593e1..ff316065f3 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.c
@@ -25,10 +25,7 @@ struct cat_nthw *cat_nthw_new(void)
 
 void cat_nthw_delete(struct cat_nthw *p)
 {
-	if (p) {
-		(void)memset(p, 0, sizeof(*p));
-		free(p);
-	}
+	free(p);
 }
 
 void cat_nthw_set_debug_mode(struct cat_nthw *p, unsigned int n_debug_mode)
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.c
index c1b73179a8..ddb11edf7c 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.c
@@ -29,10 +29,7 @@ struct csu_nthw *csu_nthw_new(void)
 
 void csu_nthw_delete(struct csu_nthw *p)
 {
-	if (p) {
-		(void)memset(p, 0, sizeof(*p));
-		free(p);
-	}
+	free(p);
 }
 
 int csu_nthw_init(struct csu_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c
index 8855978349..0b2f97ff01 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c
@@ -26,10 +26,7 @@ struct flm_nthw *flm_nthw_new(void)
 
 void flm_nthw_delete(struct flm_nthw *p)
 {
-	if (p) {
-		(void)memset(p, 0, sizeof(*p));
-		free(p);
-	}
+	free(p);
 }
 
 void flm_nthw_set_debug_mode(struct flm_nthw *p, unsigned int n_debug_mode)
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.c
index 4a8b17101d..3170c363dc 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.c
@@ -29,10 +29,7 @@ struct hfu_nthw *hfu_nthw_new(void)
 
 void hfu_nthw_delete(struct hfu_nthw *p)
 {
-	if (p) {
-		(void)memset(p, 0, sizeof(*p));
-		free(p);
-	}
+	free(p);
 }
 
 int hfu_nthw_init(struct hfu_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.c
index 80ead2729a..17381ddea6 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.c
@@ -30,10 +30,7 @@ struct hsh_nthw *hsh_nthw_new(void)
 
 void hsh_nthw_delete(struct hsh_nthw *p)
 {
-	if (p) {
-		(void)memset(p, 0, sizeof(*p));
-		free(p);
-	}
+	free(p);
 }
 
 int hsh_nthw_init(struct hsh_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.c
index 8e0b24dd9a..7a17d36f6d 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.c
@@ -30,10 +30,7 @@ struct info_nthw *info_nthw_new(void)
 
 void info_nthw_delete(struct info_nthw *p)
 {
-	if (p) {
-		(void)memset(p, 0, sizeof(*p));
-		free(p);
-	}
+	free(p);
 }
 
 int info_nthw_init(struct info_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.c
index edc8f58759..88f3900caf 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.c
@@ -39,10 +39,7 @@ struct km_nthw *km_nthw_new(void)
 
 void km_nthw_delete(struct km_nthw *p)
 {
-	if (p) {
-		(void)memset(p, 0, sizeof(*p));
-		free(p);
-	}
+	free(p);
 }
 
 int km_nthw_init(struct km_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.c
index 4a9713965b..b0b3f41027 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.c
@@ -30,10 +30,7 @@ struct pdb_nthw *pdb_nthw_new(void)
 
 void pdb_nthw_delete(struct pdb_nthw *p)
 {
-	if (p) {
-		(void)memset(p, 0, sizeof(*p));
-		free(p);
-	}
+	free(p);
 }
 
 int pdb_nthw_init(struct pdb_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.c
index c887fe25e2..9b1dddb3a8 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.c
@@ -30,10 +30,7 @@ struct qsl_nthw *qsl_nthw_new(void)
 
 void qsl_nthw_delete(struct qsl_nthw *p)
 {
-	if (p) {
-		(void)memset(p, 0, sizeof(*p));
-		free(p);
-	}
+	free(p);
 }
 
 int qsl_nthw_init(struct qsl_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c
index e69a1ca823..3b7380b52f 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c
@@ -29,10 +29,7 @@ struct rpp_lr_nthw *rpp_lr_nthw_new(void)
 
 void rpp_lr_nthw_delete(struct rpp_lr_nthw *p)
 {
-	if (p) {
-		(void)memset(p, 0, sizeof(*p));
-		free(p);
-	}
+	free(p);
 }
 
 int rpp_lr_nthw_init(struct rpp_lr_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.c
index e062a700eb..9083455051 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.c
@@ -30,10 +30,7 @@ struct slc_lr_nthw *slc_lr_nthw_new(void)
 
 void slc_lr_nthw_delete(struct slc_lr_nthw *p)
 {
-	if (p) {
-		(void)memset(p, 0, sizeof(*p));
-		free(p);
-	}
+	free(p);
 }
 
 int slc_lr_nthw_init(struct slc_lr_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c
index ee85a1c61b..c0e26f9186 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c
@@ -31,7 +31,6 @@ void tx_cpy_nthw_delete(struct tx_cpy_nthw *p)
 {
 	if (p) {
 		free(p->m_writers);
-		(void)memset(p, 0, sizeof(*p));
 		free(p);
 	}
 }
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.c
index 47af44945f..40581c51ca 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.c
@@ -29,10 +29,7 @@ struct tx_ins_nthw *tx_ins_nthw_new(void)
 
 void tx_ins_nthw_delete(struct tx_ins_nthw *p)
 {
-	if (p) {
-		(void)memset(p, 0, sizeof(*p));
-		free(p);
-	}
+	free(p);
 }
 
 int tx_ins_nthw_init(struct tx_ins_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c
index c40857db0f..3786089326 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c
@@ -29,10 +29,7 @@ struct tx_rpl_nthw *tx_rpl_nthw_new(void)
 
 void tx_rpl_nthw_delete(struct tx_rpl_nthw *p)
 {
-	if (p) {
-		(void)memset(p, 0, sizeof(*p));
-		free(p);
-	}
+	free(p);
 }
 
 int tx_rpl_nthw_init(struct tx_rpl_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
diff --git a/drivers/net/ntnic/nthw/model/nthw_fpga_model.c b/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
index 9eaaeb550d..0fb525d34f 100644
--- a/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
+++ b/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
@@ -183,7 +183,6 @@ nthw_fpga_mgr_t *nthw_fpga_mgr_new(void)
 
 void nthw_fpga_mgr_delete(nthw_fpga_mgr_t *p)
 {
-	memset(p, 0, sizeof(nthw_fpga_mgr_t));
 	free(p);
 }
 
-- 
2.47.2

