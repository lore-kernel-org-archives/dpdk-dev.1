Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2F1CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:01:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AFBD40B9B;
	Wed, 15 Oct 2025 11:01:24 +0200 (CEST)
Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com
 [209.85.221.225])
 by mails.dpdk.org (Postfix) with ESMTP id C872C40DD0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:01:22 +0200 (CEST)
Received: by mail-vk1-f225.google.com with SMTP id
 71dfb90a1353d-5523142df73so4156609e0c.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760518882; x=1761123682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HFiy97n2BosNVN3rVP3rhYGLp86F8kIPf7vsU4FyJwA=;
 b=uGtzSJoaqk6oDriTaCSyvO4xDAg0ZKdFX/hy3anu+XDs9ud+binIyf4xB4IJBl9kCN
 r7rvP3tnM+tnh7kOnM2QwnZWbm9ZP474QflvTPZQTCcuJITOAMFFwchBMaAcegQfy4pB
 MeNdlpaSMTXw7A1Mdt+idiNAjKOsqC84ZAAoZgdng9yK3H64/NW4V528nhazZw+SMXOx
 Tyo2nrpOyG/YsjMMtXyWQFhuMApezBSdd7SiZAMvZmnIZfNl2I023Vr7ztEWj4hQms1F
 Ow+rdTNVYoolWcPPbMlsYuNlYU55fgwTbwr32P2X4hFuGXgBUykybbWPzvMd7HNs4G2M
 qV/w==
X-Gm-Message-State: AOJu0Yz4QzevWzs+iNJkJpEOV8Lbkjclqia9tBi8DtF/Eaq7CXL8IjAk
 u2JKGhvrZYCrkUC2ZbCDBk2X1cM6JxU2wO4cwXTXrFXJ3uhdCv2YjXLAYmGAN4zbSOPsv6qNbgu
 ejQVpx8hpI+X1/0nxQYp5thu5lvkEfz6opQtlAwsVvAaq7EuqSFQqADKpd+vYkwqxBqT6t3bBhJ
 Z03tBN0inem2cyr9t6h67H6bBXQoLt1a67SVg+sr5tCaq8xv9tAaz2WN2ZcXNBVYiynvnFxQ==
X-Gm-Gg: ASbGncv9NlBL/09LNPsSN9yj5eIQas3f1gS2SEd//kWCnbwEBfXc9NqRsX+kvAjobU7
 ssVIOmMF2NAU1MFFXxiZvqBjis4ynRJTCupP0ZYzNvfb7GJO62tquTReXz6rDVgIe/yS3Na4pWu
 Mm8U6bu3Zd0WqrbsvwxPNPvX9x2vZQ5Q7KACjt1QmQWH7m2/Xwxh7YpXwiPKtIFHj2908s9gv8K
 Kgw5NqmgIiqBIzngdVvvMzdO04dKnH1Ml9w8MlbGO5yUwZ2rkMXpPEC7pBOXTtXB6dfISsKitWs
 yJbx4gxekUVuZgveUGcZPSF0S+v1iXTnGaxjuJdJ2pHYBAxup06JPTq5Xa7ASXYvRcYPWd0ourt
 B4Tg2VlhAbUkLOekjnOfo9ZCeYNMLA1t5dz9G3ivLkoWLeno/DKEpImNhSN4/x2yHM9f9XcHx
X-Google-Smtp-Source: AGHT+IGDEzyubizaH1ocpOVMsYoJI0/emKiauYaNpwiiSMJJVHdPL/KZZ5jixLpx6lCKGTritAdcfzX5BTbi
X-Received: by 2002:a05:6122:4695:b0:535:e35d:49f4 with SMTP id
 71dfb90a1353d-554b8ba0b60mr9690829e0c.11.1760518882106; 
 Wed, 15 Oct 2025 02:01:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-1.dlp.protect.broadcom.com. [144.49.247.1])
 by smtp-relay.gmail.com with ESMTPS id
 71dfb90a1353d-554d803b7fcsm1596335e0c.8.2025.10.15.02.01.21
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:01:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b62b7af4fddso8054819a12.2
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760518880; x=1761123680; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HFiy97n2BosNVN3rVP3rhYGLp86F8kIPf7vsU4FyJwA=;
 b=APYpAg03PKyAkaQ86S0obz9jFBor5KaPqqm2O0QFXNS3wO2jC/HKxtYAqRsRlWSH2+
 B/oTB1rxBsyIYW/1m3wXuBxfb9xPBPDOjm1vpVAT2JlE2pvwFvLH9F8KwjDWf6ByRBEn
 4E5fRXRjWOQKx2UrRFUK4J3fMgZz//JjcfhIM=
X-Received: by 2002:a05:6a20:3d90:b0:2b7:e136:1f07 with SMTP id
 adf61e73a8af0-32da7e23a9amr34310535637.0.1760518879673; 
 Wed, 15 Oct 2025 02:01:19 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d90:b0:2b7:e136:1f07 with SMTP id
 adf61e73a8af0-32da7e23a9amr34310476637.0.1760518878906; 
 Wed, 15 Oct 2025 02:01:18 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.01.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:01:18 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Jay Ding <jay.ding@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH v3 06/54] net/bnxt/tf_core: fix the miscalculation of the lkup
 table pool
Date: Wed, 15 Oct 2025 04:59:36 -0400
Message-Id: <20251015090024.32250-7-manish.kurup@broadcom.com>
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

From: Jay Ding <jay.ding@broadcom.com>

The size of the lkup table pool should include the static
bucket. The miscalculation causes crash with big number of
offloaded flows.

Signed-off-by: Jay Ding <jay.ding@broadcom.com>
Reviewed-by: Manish Kurup <manish.kurup@broadcom.com>
Reviewed-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
---
 drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
index 10149a3963..88863ed6ad 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
@@ -941,8 +941,7 @@ int tfc_tbl_scope_size_query(struct tfc *tfcp,
 			break;
 
 		rc = calc_pool_sz_exp(&parms->lkup_pool_sz_exp[dir],
-				      parms->lkup_rec_cnt[dir] -
-				      (1 << parms->static_bucket_cnt_exp[dir]),
+				      parms->lkup_rec_cnt[dir],
 				      parms->max_pools);
 		if (rc)
 			break;
@@ -1290,6 +1289,7 @@ int tfc_tbl_scope_mem_alloc(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 					valid, parms->max_pools);
 		}
 	}
+
 	return rc;
 cleanup:
 	for (dir = 0; dir < CFA_DIR_MAX; dir++) {
@@ -1632,7 +1632,7 @@ int tfc_tbl_scope_cpm_alloc(struct tfc *tfcp, uint8_t tsid,
 				goto cleanup;
 			}
 			/* Create lkup pool CMM instance */
-			qparms.max_records = mem_cfg.rec_cnt;
+			qparms.max_records = mem_cfg.rec_cnt - mem_cfg.lkup_rec_start_offset;
 			qparms.max_contig_records = pi.lkup_max_contig_rec;
 			rc = cfa_mm_query(&qparms);
 			if (rc != 0) {
@@ -1653,7 +1653,8 @@ int tfc_tbl_scope_cpm_alloc(struct tfc *tfcp, uint8_t tsid,
 			/* override the record size since a single pool because
 			 * pool_sz_exp is 0 in this case
 			 */
-			tfc_cpm_set_pool_size(pi.lkup_cpm, mem_cfg.rec_cnt);
+			tfc_cpm_set_pool_size(pi.lkup_cpm,
+					      mem_cfg.rec_cnt - mem_cfg.lkup_rec_start_offset);
 
 			/* Store CMM instance in the CPM for pool_id 0 */
 			rc = tfc_cpm_set_cmm_inst(pi.lkup_cpm, pool_id, cmm_lkup);
-- 
2.39.5 (Apple Git-154)

