Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75C0CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:06:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9758340BA6;
	Tue, 30 Sep 2025 09:05:38 +0200 (CEST)
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com
 [209.85.219.98]) by mails.dpdk.org (Postfix) with ESMTP id 130EA402D8
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:36:45 +0200 (CEST)
Received: by mail-qv1-f98.google.com with SMTP id
 6a1803df08f44-791875a9071so51393536d6.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192604; x=1759797404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eLcMuE229SguVXhaiCprOxk0FY+Emi5s4rMOuCgVCJ0=;
 b=YnrqZBHmvlQ2U+2piru4m4XHhocqjZo8aqEzSu9fncSnNAG5bfPNN9L3fbL0HAscp2
 1B1rZupTVAjAsbxwgVrVl4aSLH1h4zYW9sLMEq5ZSq3suV73RNb1aJeZVGrtdDnRNk4b
 xWhOJW9uPxeYmab1nzTlkrK348/s64Tdimq9m/1B2QlkTPkIdzpwHTQcNypgd7ELB+3v
 dcncjzCgMNSDoIE7fmewncWfSOq0DpbSMuQmN1d5JcWfS1h/eDvj7hxKr+DBOwR3wbL/
 fHU4oiyVbrge/CleaPTEvJAxzotuHVN92WSDHgH42oHmY8SBxyCa/YsT3WYty6c0gWL8
 gPBQ==
X-Gm-Message-State: AOJu0YyExpGgU+4nMJ/J3UvIHjUtzeiMMjn292uE0o5cXj1GIw0I+HLK
 U9vuIn5CrAS8l/eso8HYCi78FiHzhB+l071czU8vJN1cCqs2Mcst5sprFj/Y2P7YjMvJBbs6NWu
 aJOYwByOPiNu7U6y9Cm/NOF2y4UWUauILlOqv0+gky0MAX07Xd+byyvw04lMLRAJJ/mdXGlHimB
 g1cK767AeLL2C0bn5Nd2EDM8ipagtCaokKygWDlrnao2M93lZRsir7luvdf7YyaQkrYNP7PQ==
X-Gm-Gg: ASbGncun+CDDFn2sfkNT5kWQeuOqi9hR2MkVI7AMvqWERiRMPgWFoCieGsiOSSImDhS
 etjyTU5aXbrClSkuSVePlKFdTmVPn1QzhRP65kgtsa+cqFW03t3wr9X9sQXfpmcIGqKmnM/8iUW
 hiAsRL2GG1K2C9q5DXRg8nBuYYzYUraU38SaiDc3NPR1RTEBIk98DKxNbn7wUdDE8VePYmHCkbc
 u1fscM5KK1VMGVS3dDykHrGe0HDHOd5LuqBXtx0uQSPDQ0Rbu/9dxdeBn18WDo71smzn6ALmBe3
 PRw1nC2bUoXHil5/8LxpXYfv2mONZn2yQ8JkXilDPKoxdcyRCuS1tRyuM/Z6b/GihDuF/PIFat1
 aq5k5czRT6ZdWv4+ajXiJkXwYI+Trii7I/rrLNq0iuwOXUT1z/OG0D6EPM4cassYCqYupsyyPdo
 hQLhLQ4fY=
X-Google-Smtp-Source: AGHT+IFIOWTb24jq1eA+hMkJ5jvw07jsDt9dXzL2XvLTaHAlyufIHJKD4Lb6V5fNVvFfrqTHC7N76GnHKAlJ
X-Received: by 2002:a05:6214:242c:b0:83a:661:ff55 with SMTP id
 6a1803df08f44-83a0662012fmr102180646d6.35.1759192604012; 
 Mon, 29 Sep 2025 17:36:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-8016193d064sm9076736d6.28.2025.09.29.17.36.43
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:36:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-252afdfafe1so54182445ad.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192602; x=1759797402; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eLcMuE229SguVXhaiCprOxk0FY+Emi5s4rMOuCgVCJ0=;
 b=foT9JdtKqLsUuDYRw6dRgVqd73S7ETXLnp0kFhm/dUj5ckh4dFLkGQBh+MWYl4KUoS
 Iedr4bAnDyJvfUOLG9iC64GJAwhNNvrsfRwG24+UEMUG5EVZgH097CIFXbaQSkK5RfUS
 vLPRZ1zY3og4TCyriwUMQaGCTWPn9taaDg7c4=
X-Received: by 2002:a17:902:ceca:b0:269:b6bd:bc0b with SMTP id
 d9443c01a7336-27ed49b188cmr203445425ad.10.1759192602546; 
 Mon, 29 Sep 2025 17:36:42 -0700 (PDT)
X-Received: by 2002:a17:902:ceca:b0:269:b6bd:bc0b with SMTP id
 d9443c01a7336-27ed49b188cmr203445045ad.10.1759192601880; 
 Mon, 29 Sep 2025 17:36:41 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.36.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:36:41 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Farah Smith <farah.smith@broadcom.com>
Subject: [PATCH 10/54] net/bnxt/tf_core: fix table scope free
Date: Mon, 29 Sep 2025 20:35:20 -0400
Message-Id: <20250930003604.87108-11-manish.kurup@broadcom.com>
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

