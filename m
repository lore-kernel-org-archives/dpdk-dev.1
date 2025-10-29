Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5E0CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:08:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29F0E40676;
	Wed, 29 Oct 2025 17:08:27 +0100 (CET)
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com
 [209.85.214.228])
 by mails.dpdk.org (Postfix) with ESMTP id 2293940672
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:08:24 +0100 (CET)
Received: by mail-pl1-f228.google.com with SMTP id
 d9443c01a7336-27c369f8986so67514755ad.3
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754103; x=1762358903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HFiy97n2BosNVN3rVP3rhYGLp86F8kIPf7vsU4FyJwA=;
 b=eebGOhOs+wM2HdFxyC9oKRg9sa795qrWrwhe+R+shTiJNXC+k34L106T1bRGvywXm/
 O9j64Y5YRVtYZTliXjXPUept6v+2kP2vDO7rOzfVyMhrxLWUJWU7sK2Hn4ug6K8SX4NQ
 bPx6VXVbONyVp5LPPtXtBbPLlBADibbJAXfmFYHizNBy4SAo/N4q9x2JNinmR9Lf3l3X
 fDG3DYNoGfIrfAK+b0h+U9EzgntSP409+VOVKlwNemy3uvvmYWxbvePDfd57kC9Ls2fr
 GH4qS4YxMOmKFuWKYwX0LiM755GPy+H6fFl2kpjZpU9uqEI3qvSEYpYTLZgptNLQhZhS
 QTUg==
X-Gm-Message-State: AOJu0YztWIL550lsia/k9/Cdsgo7dyIjuyYZDJvaImW0yBU9PSveIP0w
 2y3O++HSDtY0UTtTkRpgv/kIJXCE6bq3uVcOBt5CSIKmVXizDda0hKTTsAUggEBA5313HjcXSds
 vzbATY1jV6cr8KRbK6m+bdU0LgHc8EEiVp2F9Gtdz9De1mDtvElZ8coVmSubsj2FjUPEPVMTlMG
 v2rmayFiieOZSok65mLuhV+FCfdq0ZEqCLftIcbDOrRKzD45RnMwHpV/KC+P7cKznegb8BaQ==
X-Gm-Gg: ASbGncs2HowyAMb14JSsJzjvtS/9OfDPPBXYET4a6gI0makEDsP6ovGBvbj338ZDo1F
 GcelX9IFm+GZEMO1QEtv0ZqdBfWMOrkaOawLNNHMp52l/Gw6mFmjJEYSaj+UGn2ma0OOeOaLXmq
 UvyqBBwMBJsH9jNZ00PT6i2Q1dKE/TjnOKVh4u+VRjQyy7+biQ+zJyOGXF57pydEKlOg/V5OHmT
 PyFFvu3D5+yrdCHr+Gap35kikc0F65oIZxrRERvXaPLgeAtYGhmoTt7ToyxYSQKs8+Oa8YP5t99
 8edHhwexPlJvacNKYrs6gzlObac3r/PZ95u040LViJTbkE+VzpjKoh2JMdwBeHKS+RmSxC6hw/D
 TFgR370z+HovCcXkz968aKi4+cJOD0YLWHhm3GzpoPYHaV1iSfDCDLI3GDFHqB+z57AX92UYmx9
 IIx7FgP+bTB4oA3ZOoLpXbe5TSCxChza+RPgkG
X-Google-Smtp-Source: AGHT+IGYT8GEQpbE+Ik10nJ5sjpet4D64VYj1vhgDxByOYr9HtVcVc+6/BjavkpCjoouNJZMdUFziEVAmThQ
X-Received: by 2002:a17:902:da8b:b0:24c:9309:5883 with SMTP id
 d9443c01a7336-294deed42f4mr45724215ad.28.1761754102992; 
 Wed, 29 Oct 2025 09:08:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-29498d29903sm13090305ad.37.2025.10.29.09.08.22
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:08:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-89090e340bfso1469699985a.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754101; x=1762358901; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HFiy97n2BosNVN3rVP3rhYGLp86F8kIPf7vsU4FyJwA=;
 b=NzYaAw9lFXNSUP0gz8+mNWuQQQ1/RFWt5BBIPZAw/w/IBGl9VaqptiLksgODHszTYG
 9idd2p2AwVUEG4YmlFm5DMZcETNr2jgV6gqJcvobgkZp7fYiCegrvIWzIcb/PAbyCR36
 diq+wmQRqOzER288DZB72F5RIudgEXVAxfiwI=
X-Received: by 2002:a05:620a:454d:b0:8a4:107a:6769 with SMTP id
 af79cd13be357-8a8e6954d39mr469061585a.71.1761754101263; 
 Wed, 29 Oct 2025 09:08:21 -0700 (PDT)
X-Received: by 2002:a05:620a:454d:b0:8a4:107a:6769 with SMTP id
 af79cd13be357-8a8e6954d39mr469054685a.71.1761754100688; 
 Wed, 29 Oct 2025 09:08:20 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.08.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:08:20 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Jay Ding <jay.ding@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH v5 09/57] net/bnxt/tf_core: cleanup lkup table pool
 calculations
Date: Wed, 29 Oct 2025 12:06:24 -0400
Message-Id: <20251029160712.58519-10-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251029160712.58519-1-manish.kurup@broadcom.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
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

