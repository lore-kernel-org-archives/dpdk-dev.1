Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D29ACCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:04:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A4D340E26;
	Wed, 15 Oct 2025 11:04:13 +0200 (CEST)
Received: from mail-io1-f97.google.com (mail-io1-f97.google.com
 [209.85.166.97]) by mails.dpdk.org (Postfix) with ESMTP id 51C2C40E09
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:04:11 +0200 (CEST)
Received: by mail-io1-f97.google.com with SMTP id
 ca18e2360f4ac-9379a062ca8so243870839f.2
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519050; x=1761123850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rSha/rHfhVpqMCkemzhzJt9MKBZNA3cJ/ALQp5n7hHk=;
 b=C7aj+jecdQ/QZRKl0zhcckLuQWG2p8waD3LY+l+24Gaa5G/vUZ0UW9a/ZH4sOXQWLK
 RVfVgitPhPvQ58VGd2/pboawPew8oQaeJJL4naozVVxoYCmkPIHIEDP9fXIq406FLAaM
 YhEkNvKJJ3w/N68s5jSiuuQ0cDngMvs0srbrtJA4WEOIYQQ8oDmvB3UagjKXMBLcsRFv
 Z6V4jgPwx5Eyxz2Q1uuJARM3O+dLbeHoVnC/B7YORUKrrAC11U/FNKO5qcLz1bn+W/PU
 LtkPpE5LQi0kCHMhbkMWJzwu0rf35G5k0CCOnz9H6NpRszVN96B/RDgrb3NWtCrE/IuF
 X6oQ==
X-Gm-Message-State: AOJu0YxSIQzFSm+V0LkQ9Zd+lXH7TPqAG55/dEYcZdRF3q+vpMGxHMTN
 lPRPga9+RFUvWvV4tvdVMs/hkG/rAIgxbC+mniBTk5V+XXjTJMtO+zlH1IpN86nHQEeufKhX87b
 /HazgGGxoGokVdDPPDaL0nbhcwrKh1IoyEnveKgSTuKWPaJaIBLaQ3aGZwCi8t7+Oka64ngqLfD
 9ZnpbiwNLw3xRQnL/UNIiF2tfJ6AvwN9UejaLyXSWKqn4dyvnPeHxbkmFoJAs2aAVY2d6aOw==
X-Gm-Gg: ASbGnctyuz82RI9Jp4ov/1IRgry1We4vfbM1ILiugE4xwtFrQaijXvgSKGNAd+B02gJ
 aiuIE5Lhynla43O6faBw2thE0qSlUQFcWQNy4aiK1pK96ZaVqyYIOxRLpP9A/CcsiWFk6rsLyZJ
 RGzn4be6/8qmxmuvIVeJK++vONPpAa/HXA66pxYD1uVJUfBOKbQxi4DEStEi331BEUQlV+TrA2R
 c9LcBOGdBy4eoze/bhAHCw5QowImaJws+HUUoJtFiK68XlGQtqFkmd5LwUmuqdcu/ePWW9fbV9b
 oNwFji6xXhvvyX8dIkNSb/5YRB0OFgGaV3BV8GckHDsDXUu7U17dSK6s+O7v52Lr5qvbvenOzWH
 NU76xuPHfgQJIhothI/OeJFieAtcfGaZ6wGEiIRV1mg2w7THf7p54Jt5XU59SISwixmI184cz+Q
 GoVg==
X-Google-Smtp-Source: AGHT+IHxUBkpqGsYFU/WggkZe1QOw6aZatGMLgIGT4DC1UGlnS5ygRkphA6DW/MioYL6oyLHxQp+/xnznfmF
X-Received: by 2002:a05:6602:2c8d:b0:93b:da4c:632c with SMTP id
 ca18e2360f4ac-93bda4c648bmr2953010539f.14.1760519050510; 
 Wed, 15 Oct 2025 02:04:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
 by smtp-relay.gmail.com with ESMTPS id
 ca18e2360f4ac-93e25a4c799sm93794939f.9.2025.10.15.02.04.09
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:04:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b632471eda1so10102415a12.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519048; x=1761123848; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rSha/rHfhVpqMCkemzhzJt9MKBZNA3cJ/ALQp5n7hHk=;
 b=ajyjt7ggyArH9taqrUlW68SzPLpZEp290QG2ZS3Sg7ljGrLEY6FS5497psfRwjgKGt
 xRqIC9YaVfq3QBTxytbJi9XibdWNoDBsGvc+kvtzJs7wdZpZZpKRumJUxvBAdewi1zer
 eAorUB6rBnpmMZ+5KsQc7aoeXwhgxoDSR7ZhY=
X-Received: by 2002:a05:6a20:9f8c:b0:2f6:9592:9075 with SMTP id
 adf61e73a8af0-32da81f3adbmr37216484637.25.1760519047821; 
 Wed, 15 Oct 2025 02:04:07 -0700 (PDT)
X-Received: by 2002:a05:6a20:9f8c:b0:2f6:9592:9075 with SMTP id
 adf61e73a8af0-32da81f3adbmr37216449637.25.1760519047149; 
 Wed, 15 Oct 2025 02:04:07 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.04.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:04:06 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v3 19/54] net/bnxt: fix max VFs count for thor2
Date: Wed, 15 Oct 2025 04:59:49 -0400
Message-Id: <20251015090024.32250-20-manish.kurup@broadcom.com>
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

The number of max vfs per pf is 128 for thor2.
Fixed the vnic hash table creation if the number of max vnics is less
than 8.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/bnxt.h      |  2 ++
 drivers/net/bnxt/bnxt_vnic.c | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/bnxt/bnxt.h b/drivers/net/bnxt/bnxt.h
index 00bdb53215..90352d537c 100644
--- a/drivers/net/bnxt/bnxt.h
+++ b/drivers/net/bnxt/bnxt.h
@@ -260,8 +260,10 @@ struct bnxt_pf_info {
 #define BNXT_MAX_VFS(bp)	((bp)->pf->max_vfs)
 #define BNXT_MAX_VF_REPS_P4     64
 #define BNXT_MAX_VF_REPS_P5     256
+#define BNXT_MAX_VF_REPS_P7     128
 #define BNXT_MAX_VF_REPS(bp) \
 				(BNXT_CHIP_P5(bp) ? BNXT_MAX_VF_REPS_P5 : \
+				BNXT_CHIP_P7(bp) ? BNXT_MAX_VF_REPS_P7 : \
 				BNXT_MAX_VF_REPS_P4)
 #define BNXT_TOTAL_VFS(bp)	((bp)->pf->total_vfs)
 #define BNXT_FIRST_VF_FID	128
diff --git a/drivers/net/bnxt/bnxt_vnic.c b/drivers/net/bnxt/bnxt_vnic.c
index 7b028f2ee5..637e9b9aa4 100644
--- a/drivers/net/bnxt/bnxt_vnic.c
+++ b/drivers/net/bnxt/bnxt_vnic.c
@@ -16,6 +16,11 @@
 #include "hsi_struct_def_dpdk.h"
 #include "bnxt_hwrm.h"
 
+#ifndef RTE_HASH_BUCKET_ENTRIES
+/* it is defined in lib/hash/rte_cuckoo_hash.h */
+#define RTE_HASH_BUCKET_ENTRIES     8
+#endif /* RTE_HASH_BUCKET_ENTRIES */
+
 /* Macros to manipulate vnic bitmaps*/
 #define BNXT_VNIC_BITMAP_SIZE	64
 #define BNXT_VNIC_BITMAP_SET(b, i)	((b[(i) / BNXT_VNIC_BITMAP_SIZE]) |= \
@@ -978,6 +983,12 @@ int32_t bnxt_vnic_queue_db_init(struct bnxt *bp)
 	hash_tbl_params.name = hash_tbl_name;
 	hash_tbl_params.entries = (bp->max_vnics > BNXT_VNIC_MAX_SUPPORTED_ID) ?
 		BNXT_VNIC_MAX_SUPPORTED_ID : bp->max_vnics;
+
+	/* if the number of max vnis is less than bucket size */
+	/* then let the max entries size be the least value */
+	if (hash_tbl_params.entries <= RTE_HASH_BUCKET_ENTRIES)
+		hash_tbl_params.entries = RTE_HASH_BUCKET_ENTRIES;
+
 	hash_tbl_params.key_len = BNXT_VNIC_MAX_QUEUE_SZ_IN_8BITS;
 	hash_tbl_params.socket_id = rte_socket_id();
 	bp->vnic_queue_db.rss_q_db = rte_hash_create(&hash_tbl_params);
-- 
2.39.5 (Apple Git-154)

