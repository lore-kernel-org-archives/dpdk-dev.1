Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CCDCCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 17:52:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDF1240E1F;
	Tue, 21 Oct 2025 19:52:30 +0200 (CEST)
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com
 [209.85.166.226])
 by mails.dpdk.org (Postfix) with ESMTP id 139FA40A81
 for <dev@dpdk.org>; Tue, 21 Oct 2025 19:52:29 +0200 (CEST)
Received: by mail-il1-f226.google.com with SMTP id
 e9e14a558f8ab-430ca464785so41020875ab.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761069148; x=1761673948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eLcMuE229SguVXhaiCprOxk0FY+Emi5s4rMOuCgVCJ0=;
 b=LXAHNH+ePVM5Eg/V71CkdQH9DUx6NkTKAsIr8NGuqdESkBtaatVAH/yDswBQpWyY5w
 gBpL0ADMN+5/YLBYkzHZ9J6e+MQMDQolLHVjF6yB1XhkaG9lXMZX3fAxZAS3RRmajMMY
 tWjlNTaqX2HVdAfSIEZZcPIui3jPj2KaYQ/07/hiUKw5X9BR9yKT4crvoNl1EUjWDusY
 V0JhtbwaiW2o5ldbLSv21qUokYK0Ia2KmsvnDrWuGFGu2ZZddvPg49blZ8Oc0og7qcMn
 oZ/2VzD9rnweCbgliQvh1S1x/xVWdmCe7/JpD5jJ3/3KRFR4elHphG/a+nyPpMTuCh2f
 OlTQ==
X-Gm-Message-State: AOJu0YyfIrSYaE4gi704nIqQnY+fTiYO+RWyJ86oCF2q7ch/PMc3YfPN
 1uXYJV2K8nlpplxCE9WZHOKfJzkj0R8ngefoGCwN5EPVZFA9bunZDVTPq32PivZjDeV7HpYSoxX
 Wxpze8cd4DBPv+036OI0MfJPy/jDMQ3td+CWBZW6gjMQhT/OifHv/c+bOnnyOniIZoWXSsBVyHs
 v8+NEKxsXdNpuZk2rw/kbozja+8rdiJ5n7PG9JVuqyEJYCAvG4MLG4SMdaDuPuMdsw2xTghA==
X-Gm-Gg: ASbGncvjjoqkWvQBXgm054j2A34j6RYzsreRfYEboBj3fxpGd1TSUwqfvLZsGnW8jPC
 fCE1o2D71LEJNKWXWieM2fGYRz9ys7oT9w7ZoC2UoxCFFmP+JnQLhOX2BAVkSYjgeSzdksoRfRX
 WizQ+pBA0W7xVnVzPUk71G+XZn9DCuz6YZ/1U2vJkqaVKquSlGMwsJfVvvc2kkQ1b1Kqcl1GbVR
 nehXRCWytvAPWY2IX07MSjmHE4jbQYIB22LKL7DVzVqCWXlaPruYu54gZqTmQr/rlC8Ej2S1Ogu
 R4Sg7Ke3zUebCusbQmeKG5UQUtPBXuCixeGLn0dN/EDgBA86dMv0D2wX7LBw6OaDuEdZM6QG22w
 6XYLItNp8wKwac7KZCoH13hwyuxnwtUDnpHsFkkAD/aazYECOQrxxA4ECqI2M7Rm+Fav7flNnkO
 mgb7o1yK1nh8dKv9Csu6B5oIeWDORsXzIdsYnG
X-Google-Smtp-Source: AGHT+IFhxBODh7r9FotjCrcPE8u7S9i3QK8XoVPfBGsHFJI+yWAx8gCHungWtOJ5wVtK4dtq9Bo7XTAy/172
X-Received: by 2002:a05:6e02:198c:b0:430:c461:34c1 with SMTP id
 e9e14a558f8ab-430c52700b2mr277077225ab.12.1761069148236; 
 Tue, 21 Oct 2025 10:52:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 e9e14a558f8ab-430d0717a3bsm11895415ab.13.2025.10.21.10.52.27
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 10:52:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b62f9247dd1so4474918a12.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761069146; x=1761673946; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eLcMuE229SguVXhaiCprOxk0FY+Emi5s4rMOuCgVCJ0=;
 b=OgEq20T/veEIQiqBAHNhsSNIyH19jCgJGeG9mK5b6JZOsBEFCQpKcKMNXlKMW6IIeh
 05IB7+sHX2syofV6+aeWNUbpy6zTxzHYEqusTsk61TbOI27Kz+Qk/dSyT03fOp2ihoRp
 2uoIZyxW6hePeduQTF8FGxzcrIwDGpd0GUCmM=
X-Received: by 2002:a17:903:1d1:b0:264:ee2:c3f5 with SMTP id
 d9443c01a7336-290c9cbcca1mr233646225ad.19.1761069146413; 
 Tue, 21 Oct 2025 10:52:26 -0700 (PDT)
X-Received: by 2002:a17:903:1d1:b0:264:ee2:c3f5 with SMTP id
 d9443c01a7336-290c9cbcca1mr233645905ad.19.1761069145868; 
 Tue, 21 Oct 2025 10:52:25 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292472193c2sm115441495ad.104.2025.10.21.10.52.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 10:52:25 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Farah Smith <farah.smith@broadcom.com>
Subject: [PATCH v4 13/57] net/bnxt/tf_core: fix table scope free
Date: Tue, 21 Oct 2025 13:50:05 -0400
Message-Id: <20251021175049.46092-14-manish.kurup@broadcom.com>
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

