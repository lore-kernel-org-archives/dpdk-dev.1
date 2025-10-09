Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90A7CCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:12:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF2874067A;
	Fri, 10 Oct 2025 00:12:14 +0200 (CEST)
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com
 [209.85.219.99]) by mails.dpdk.org (Postfix) with ESMTP id 955F140663
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:12:10 +0200 (CEST)
Received: by mail-qv1-f99.google.com with SMTP id
 6a1803df08f44-70ba7aa131fso16280256d6.2
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760047930; x=1760652730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HFiy97n2BosNVN3rVP3rhYGLp86F8kIPf7vsU4FyJwA=;
 b=Ha9i7EW9IJK9YNDUTW7X5aiRfDyh+dxEKp+DfGTl37v9sK/OidPnoWY3zP/HshAvP1
 AYWrDqiRSgz3zyhoZi12DRh4yJhOnIVJjD6dXhvAPybD4kYrwCK1FepQTFoAfTtDEkC9
 v2oUxceSvZHr5WPa1+6g1/ClfM33L5s0uiYDG5M7L+7Q3UuXo/Wce5qdTO1C0W7sHHZ0
 hl9VcsaGJjcMSSWnAmqjQojpD08SuXckjiLv4IF2mPgw0sv3ivHt+rDM+STBILJ44N1B
 /vdtXPuSAbhvhfSneHz0JiMdFy8avLJ3BrySkFZmrPOnunOdZcAsJQYxoErgbxk8EL/y
 W/cw==
X-Gm-Message-State: AOJu0YzTquynauGNIjzwmGiMLhD+9uaMvclZHtlUAKiyxu1yENcX0N5O
 js/M9JaDVos4NkD4htW1K/sjLHLJWsXt00uo2jEfE9zmli8Nw3s8gxSUHas0DAKyW0ckX37Iza0
 kCBuX4ZuM0IjzC34ox4AxSZtU2o0u09g4/TZl46VPy4o/cRjGfxex/U/6y+q1IJmLBlgsDVORNj
 FSm4PPiq5ZO/GrKfaPpmEPsENBDpGu1WMM+SU8vs6YG3Sx1BaS390HRMbu2MIjIJyN7FNnng==
X-Gm-Gg: ASbGncs4Z8l0LRZhbntcxxop4uiUIllp0RUtJ6YSRH7gOiRzYaF+zhmBAI2G9uu4Hth
 ZjM8fQwMYvcLb6ANFKKCn4J/zKt7/dsrQ0Kn6LMJJp/WidOnIftm1M050Wm2zWP7GVzBfwoXu3T
 OsG+9xkiu+z8Xk14LUlKSQLRtl31aRaKohD3LyD8jBH4q7ZIrtKTfdA7uuASp86s/pLqEXl0MnI
 JvD5B1PqDUbT20PO7JA5DcNjgW9bvfny4P1kOTpob/XhJy+mmGdkWhlVJ/bkrR1KwVvj90Z1dku
 4ai9ucwDQ7cfP5UJkhp+WUwL6o8ov21E6cSyoIoiC4NwSbfCzf/KjODl/xu8wCTUDE3J+l5SlR+
 Tbf2N4NqtSbEfG6F6XKYQE/qRSa0pyDwq4rkYGDINL6PdEL9zcvinxhUYMewX8LIMfS1ZxGcVPA
 rRCuGADfA=
X-Google-Smtp-Source: AGHT+IGydPgJRktZCCpOnppp/4beP5OIGbHmekO4QfT5TOZnfq1Cix8HYVbMv3V1rlUsuaJjS9ldsUcuxgR+
X-Received: by 2002:a05:6214:e87:b0:820:a83:eb04 with SMTP id
 6a1803df08f44-87b210a1875mr128544256d6.20.1760047929653; 
 Thu, 09 Oct 2025 15:12:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-87bc34614bfsm382576d6.9.2025.10.09.15.12.08
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:12:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-78efb3e2738so44828286d6.3
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760047928; x=1760652728; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HFiy97n2BosNVN3rVP3rhYGLp86F8kIPf7vsU4FyJwA=;
 b=Aqb3F7anrFPc2MvGd02Ywjf3CbDNVytj3cxLeOvEMRCGkO5DYEvUYw86CjJkOzj+pO
 Z8ojOkAtBCNQTXYH5HNDIFP/hsFF/EAwU8QLGEyUK02pYySTApKWpcuVXqsKFC82TndH
 WNUPl5Gct2O9UhRnC3zYRY730yT5BOwuIpBIg=
X-Received: by 2002:a05:6214:3001:b0:78d:8414:e4c2 with SMTP id
 6a1803df08f44-87b2efdb1b9mr144617266d6.50.1760047927791; 
 Thu, 09 Oct 2025 15:12:07 -0700 (PDT)
X-Received: by 2002:a05:6214:3001:b0:78d:8414:e4c2 with SMTP id
 6a1803df08f44-87b2efdb1b9mr144616656d6.50.1760047927218; 
 Thu, 09 Oct 2025 15:12:07 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.12.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:12:06 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Jay Ding <jay.ding@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH v2 06/54] net/bnxt/tf_core: fix the miscalculation of the lkup
 table pool
Date: Thu,  9 Oct 2025 18:10:41 -0400
Message-Id: <20251009221129.28256-7-manish.kurup@broadcom.com>
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

