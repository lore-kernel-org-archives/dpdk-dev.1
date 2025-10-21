Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912EACCD1A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 17:52:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4B4F40C35;
	Tue, 21 Oct 2025 19:51:58 +0200 (CEST)
Received: from mail-il1-f227.google.com (mail-il1-f227.google.com
 [209.85.166.227])
 by mails.dpdk.org (Postfix) with ESMTP id D0CFC40A76
 for <dev@dpdk.org>; Tue, 21 Oct 2025 19:51:57 +0200 (CEST)
Received: by mail-il1-f227.google.com with SMTP id
 e9e14a558f8ab-430c6eef4b9so21886005ab.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761069117; x=1761673917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HFiy97n2BosNVN3rVP3rhYGLp86F8kIPf7vsU4FyJwA=;
 b=RV6YrVZpGdR7pb2qwUv5geiUnPXtXT3tgqqtf3nx/OCIR8D+LPMjl9d2TNJPsdb3u0
 69QhLtmmvyiOj7c4Gu5TQsC9V1XgfqZC6gph6xyPEhaYotM8dowxB90PlfAZItFeZ147
 RqOJCwGaL0Fn0e+VUV//enMQTutbxzzPq7qbyGCxXUTw3xDqiFhoTfv81bevPPhJK5kF
 m1pv07E8XHHqeetEGlDOW4OFcQh7hcmMn09eoeh/+mvp7Rjm5Xfr8MY+jENznTjj+Uba
 3epQ0c4dz6CCWwJgmzTb3l5J4OmGmlgDVWGdB/l6/kXbCtSRecYXqE79wv5khlayyiy4
 Zfvw==
X-Gm-Message-State: AOJu0Yz8dLw3nfJxpzXfOfRNxA0RGzGYqW52vE3rkUKCRuiF96+oIZlf
 0uE4OWEr04XYvZ+Yu8N+QOv3DLYlK5EFE+gTz/ZDaNN0nupMgyZjfhJ1xpnj2n13Eq7iGywO++k
 XcEbFpS+XDR0dOlPJMwkMGhZvEJYrGCG20pvHihc5qDootXFDioOYuxveuf5fbiFkDlxfuA4rXP
 TEmp8fEW09BTspRGhG3MrKyxuJn4LW9Svm31VOsXQ15eQQuin4cqMzxqOL9zvBBRw/lIqLFQ==
X-Gm-Gg: ASbGncsuDdxKiXJ0AyWZsV+krbmW8Wk7sjzi/833xMKwVPrezlLUPu+91AOWbwfyYmt
 tMbjn4Qy54TVCbeFWECsk0+ZExDQpts+6iNMug7cVt8i2tBcMv514Ur/tTMXn16xKi6eBZiYqFF
 xfD28V5Qnugrumn4NSlRMbpi2eh2JP4py8i4ZgDNOnHjyxLhL0yAIXgFdSX+U2cQGM4hhvFEZbF
 lPRlZyRiHjXQiRGNw9LoQ5fIQHWTis1KhK7l622HsjvWjd6NSzxc0MXRFS+7gTONuK3s4VSoJER
 MuzrLSHnO2eb1JEMAat5Khak0TB8xAwDkLMlcDg32FipkkisQS97LkyBi08uXeMKyroUBWDd++K
 fmmKU/92tkVO3PZzVArHqaOsM5Yu1u/XDQi7pl5qYaK+/KF+/IuDiYInZHD5cfrPm1tqeY9E2by
 uPPfSWupU/uj6z1CJySuY6sn4NpwHmOx4=
X-Google-Smtp-Source: AGHT+IFfGYqUY1AJrPov1PsQ0D4RfqWD4fpEfBOCiZcYHfvCa8wVIX+6cXqu5+h8faEObn2mOlEAxFpI8lOy
X-Received: by 2002:a92:cd83:0:b0:430:ae8b:d2d8 with SMTP id
 e9e14a558f8ab-430c526926cmr267470815ab.15.1761069117037; 
 Tue, 21 Oct 2025 10:51:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
 by smtp-relay.gmail.com with ESMTPS id
 8926c6da1cb9f-5a8a962728bsm1325717173.14.2025.10.21.10.51.56
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 10:51:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-27ee41e062cso75007295ad.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761069115; x=1761673915; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HFiy97n2BosNVN3rVP3rhYGLp86F8kIPf7vsU4FyJwA=;
 b=GUp1HRMH3nOhAuUg52SBYZtOw2npB+fbMnKSNxPviINWm0hW/7rrFefLUWR4a9HoWk
 Tgu8aTEkGlagQXXqJnk1IuJj7gytLvsF/9Ry6bd9+MyLWm7EKhRb2COHTv8316LtHQsB
 QcXrBxrcFc/wJOr8CCunkAyqSbskhMsROIHXY=
X-Received: by 2002:a17:902:e889:b0:27e:f1d1:74e0 with SMTP id
 d9443c01a7336-290c9ca3304mr229426195ad.17.1761069115069; 
 Tue, 21 Oct 2025 10:51:55 -0700 (PDT)
X-Received: by 2002:a17:902:e889:b0:27e:f1d1:74e0 with SMTP id
 d9443c01a7336-290c9ca3304mr229425945ad.17.1761069114423; 
 Tue, 21 Oct 2025 10:51:54 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292472193c2sm115441495ad.104.2025.10.21.10.51.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 10:51:54 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Jay Ding <jay.ding@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH v4 09/57] net/bnxt/tf_core: fix the miscalculation of the lkup
 table pool
Date: Tue, 21 Oct 2025 13:50:01 -0400
Message-Id: <20251021175049.46092-10-manish.kurup@broadcom.com>
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

