Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7841ACCD183
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:12:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0069240674;
	Fri, 10 Oct 2025 00:12:22 +0200 (CEST)
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com
 [209.85.214.228])
 by mails.dpdk.org (Postfix) with ESMTP id 9635040691
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:12:17 +0200 (CEST)
Received: by mail-pl1-f228.google.com with SMTP id
 d9443c01a7336-273a0aeed57so31701455ad.1
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760047937; x=1760652737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eLcMuE229SguVXhaiCprOxk0FY+Emi5s4rMOuCgVCJ0=;
 b=PvQnSpenwWVfQkfwu0Iu66sepAXSZMJH5WTyHyT0bCA5VCacQMYO/RWu8t6D4RfKl3
 djDFr75QmKOBuSlLYijnCG7kTkvHQlq1XSAVqL7u/25kuuq+2WoWrl2eoc3yzwAYBFp8
 YKbA34sT01hq9Hv5DgZfxoDunVgsO9JWqi7qfdPl8dUcKQ8yNBEy/jB5LPkLgvvme9B0
 L46Jnat0ZeiFnlvgI6SGWuU0doDBVoS7WckSGEQKd1scdAr/3a+xNIoXqUlOi/JKziyd
 Zg7+bObjRRCV6Xb6B9HiBWDtudiYPh2AaQpQCoGxu9m1kitkrPlimHPaM5flBzsgN6LE
 8EeA==
X-Gm-Message-State: AOJu0YwLvsH9RsLEHnKo5lEQ3BJzcvLyGfupQ4Iuo8mR5rNR6ln0IO73
 5Kvam+xk7hvihyXWJiaMRQpswLAQLlIBjDbeHv2si3qp+ITitW8xLOm1k06ql+1NjgaTY0qJDvi
 eCvozbXn0BtD7oMugi9GDSs5T4ZxUlNToW/Oi92r94gUzi/y3LwEYTgABhHxalGAY8QqHL8TBoF
 7fUNoMPyu68q4lLI0UNiwyZXBf24UXuCR7J1JpawEkjoTRV+pBAfu3ZNw+x9Vn0DLBr1jqYg==
X-Gm-Gg: ASbGncsR0473mpLp8tpIFErGM0+rU3Se5hG6hTYeNaa9+vGcpfZoZEXdgM6yDwFQw7g
 3xJN5InF8RH6F2R76wIJAKLH49AIagN2ZvwzUpPz65CYSfPOeMMuFj2KNGFOBLeYRx4PsEXu+dA
 hpqx7XklmcJNe8fIt9uttGJM9ysAqEticFOC16aBFQVU7KDwbSgMheA8s4u3vPq7eFbHdppytRh
 BDEhzdEkwnGKLE5pNo+Zgh4qdgjGikl4toyvvpVg6HMBqQoFfCmvTy7g5oIA71Xuwm1zoXUEpgb
 /9DDMbmRRBDoE+TlZxfSzHFCTWghcoPnLXzXHLn6+L0u2o30vEd2CItXu3NUTXJ7VOJFsivhD51
 dHpAXtn2clGeWbjPbv8hAvTW5ujNzT7ZiwHyBflmyjZpkIzy65GXzVsPmgE0rUuquYIVBsjLEoy
 lY2D4uP9k=
X-Google-Smtp-Source: AGHT+IF6j6kFNjZ2KCZSOJQeCBvjQm1oZdBfZl74PxHWbtg4igHFQld2oEgkARuvAqLj6Y0zlbRJbGKqRLZ9
X-Received: by 2002:a17:903:249:b0:282:2c52:508e with SMTP id
 d9443c01a7336-29027e78d63mr98467455ad.8.1760047936567; 
 Thu, 09 Oct 2025 15:12:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-29034e2b480sm3125835ad.27.2025.10.09.15.12.16
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:12:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-876ee102b44so84149376d6.1
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760047935; x=1760652735; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eLcMuE229SguVXhaiCprOxk0FY+Emi5s4rMOuCgVCJ0=;
 b=fcWv0oOvBTYnmNJUEs2DAIzz8br+YXg7pnutyB5HiYQn+Q5+7Ydog1yhBvXukCR4CS
 BAtCKuzYrOyDAKvV3s/kZuHFTaPNVxZVoumR34iX0OKxLeuKmCwDCYJsVP35NGqnibQY
 h80F/mcgUmHoHhGGVojutqM61y6K4dHUBaBgY=
X-Received: by 2002:ad4:5748:0:b0:783:aeed:f55d with SMTP id
 6a1803df08f44-87b3a7fc3c1mr113886146d6.26.1760047934912; 
 Thu, 09 Oct 2025 15:12:14 -0700 (PDT)
X-Received: by 2002:ad4:5748:0:b0:783:aeed:f55d with SMTP id
 6a1803df08f44-87b3a7fc3c1mr113885626d6.26.1760047934387; 
 Thu, 09 Oct 2025 15:12:14 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.12.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:12:13 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Farah Smith <farah.smith@broadcom.com>
Subject: [PATCH v2 10/54] net/bnxt/tf_core: fix table scope free
Date: Thu,  9 Oct 2025 18:10:45 -0400
Message-Id: <20251009221129.28256-11-manish.kurup@broadcom.com>
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

Removed the additional call to free the table scope memory. Also
fixed the scope size check which should be power of 2.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Farah Smith <farah.smith@broadcom.com>
---
 drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c | 13 ++++---------
 drivers/net/bnxt/tf_core/v3/tfc_util.c      |  6 ++++++
 drivers/net/bnxt/tf_core/v3/tfc_util.h      |  3 +++
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
index b01bf8d42a..60b8289805 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
@@ -926,8 +926,7 @@ int tfc_tbl_scope_size_query(struct tfc *tfcp,
 		return -EINVAL;
 	}
 
-	if (parms->max_pools != 1 && parms->max_pools !=
-	    (uint32_t)(1 << next_pow2(parms->max_pools))) {
+	if (is_pow2(parms->max_pools)) {
 		PMD_DRV_LOG(ERR, "%s: Invalid max_pools %u not pow2\n",
 			    __func__, parms->max_pools);
 		return -EINVAL;
@@ -1044,8 +1043,7 @@ int tfc_tbl_scope_mem_alloc(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 		return -EINVAL;
 	}
 
-	if (parms->max_pools != 1 && parms->max_pools !=
-	    (1 << next_pow2(parms->max_pools))) {
+	if (is_pow2(parms->max_pools)) {
 		PMD_DRV_LOG(ERR, "%s: Invalid max_pools %u not pow2\n",
 			    __func__, parms->max_pools);
 		return -EINVAL;
@@ -1541,11 +1539,8 @@ int tfc_tbl_scope_fid_rem(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 	/*
 	 * Check if any table has memory configured and, if so, free it.
 	 */
-	rc = tfo_ts_get_mem_cfg(tfcp->tfo, tsid, CFA_DIR_RX, CFA_REGION_TYPE_LKUP,
-				&local, &mem_cfg);
-	/* If mem already freed, then local is set to zero (false). */
-	if (rc == 0 && local)
-		(void)tfc_tbl_scope_mem_free(tfcp, fid, tsid);
+	(void)tfo_ts_get_mem_cfg(tfcp->tfo, tsid, CFA_DIR_RX,
+				 CFA_REGION_TYPE_LKUP, &local, &mem_cfg);
 
 	rc = tfo_ts_set(tfcp->tfo, tsid, false, CFA_APP_TYPE_INVALID,
 			false, 0);
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_util.c b/drivers/net/bnxt/tf_core/v3/tfc_util.c
index d3229bd104..91ad3ad657 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_util.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_util.c
@@ -220,6 +220,12 @@ uint32_t prev_pow2(uint32_t x)
 	return x == 1 ? 0 : (BITS_IN_VAR(x) - 1 - __builtin_clz(x - 1));
 }
 
+/* returns 0 if power of 2 */
+int32_t is_pow2(uint32_t x)
+{
+	return (x != 0 && ((x - 1) & x)) ? -1 : 0;
+}
+
 uint32_t roundup32(uint32_t x, uint32_t y)
 {
 	return ((x + y - 1) / y) * y;
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_util.h b/drivers/net/bnxt/tf_core/v3/tfc_util.h
index 7d33947d1d..5114517792 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_util.h
+++ b/drivers/net/bnxt/tf_core/v3/tfc_util.h
@@ -110,6 +110,9 @@ uint32_t tfc_getbits(uint32_t *data, int offset, int blen);
  */
 uint32_t next_pow2(uint32_t x);
 
+/* returns 0 if power of 2 */
+int32_t is_pow2(uint32_t x);
+
 /*
  * Calculate the largest power of 2 that is less than x.  The return value is
  * the exponent of 2.
-- 
2.39.5 (Apple Git-154)

