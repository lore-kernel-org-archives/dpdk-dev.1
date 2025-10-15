Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC96CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:07:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5738D42709;
	Wed, 15 Oct 2025 11:05:38 +0200 (CEST)
Received: from mail-oo1-f99.google.com (mail-oo1-f99.google.com
 [209.85.161.99]) by mails.dpdk.org (Postfix) with ESMTP id 59EE84275D
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:05:37 +0200 (CEST)
Received: by mail-oo1-f99.google.com with SMTP id
 006d021491bc7-6502a58396cso1556917eaf.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519136; x=1761123936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=00gnMT/+o3K5TobN2N8K1Xw2sPt5jaafikUUsU/uFsk=;
 b=X7cWQPx0NEz9+ot6x84t9by1FcWrGRgMOh6egUUZktYscU1uI3TGl6nb2NV8D47WvJ
 a3GtsL8aOqzTprWu2dT6iZsR34BHqWba2UNAovKsLMHG4HZ6OQ7u1YjAmITlMPwUDg2/
 +A0I4OtGzTiaHhxnsEsMb73OpVWfpvtNNTHaV9yjhH8fK1qeHrvElZHbMTQUUewJMaSY
 VaGlCTorVNTDOdaArej6Vmb1axyiNL8jtlaO1sziYFleAojo7xnnrG1CJW/kv1X6np04
 pVOnqGAoDPeZLzeONbRBUNILOZUEIr0r99Ev3T7drF7Qy425ubCUa2zrbpJenGH67oLc
 cRug==
X-Gm-Message-State: AOJu0YxlKKaN8RnXSCsTaYymWSoNKm3LuJx5dpTmDfDm+QvzGaNt68wM
 ZsjsE8ofG/UmHkTCx3YrOEP14mkkIC64UvY+PXcI0Jvj/sWrQsxYnMuxEP6NRYet3aqs+4z+558
 HLPS/myqci1eLmrpfv/QzV6gKNWwzl9WCvT9+ZV7lg6lhP6qCH4BM4ZpDBrvWJDVUWzvkqg2U2U
 RHZ4+nl+0Yx0j5pd9zMKiY3eaozGT/m8K5TJI0N4SwxgdWlzDCULk8ZydJwbDSMibAzcvGJg==
X-Gm-Gg: ASbGnctChxC/tQtb9dUQWl9AfAdF6jEa4/2HaPcHDSi00xPB/WWHctTjQizgalTqb4Y
 VBprRj86pKVsjLkIha1/4y4S0pAEHey+srfJevm8sLVXgdYk/8AYVHd/JG6RBjgO1J2XvUdE+nZ
 /fBdswEnQwzwjNOf1BOEUkWhfIZWnCPAAzWl4mRcfkJd5E2b7RJEcoVI6FBSIOvDcLrQkX9J56Q
 JTVq5uLq6IsuCDUnRlmhJwTroWW/romt2o0oSpyxR1wVlyPSkdKffOkdZ9SxuyRyZHbic64mfpY
 woPK+4IVpdcXFIWFCNa4zPKWL2vx4WwfXe480lW2TDxojEC+IHLZoKljczw1icqn1bpHN52c6lB
 CN4aCciSJb42gqZtOlCFR4otlyhJQyz7+XRPnPBPzxL4C3em1ojaf1A0Okt/mkGHNQfQ2FtATyY
 6p4A==
X-Google-Smtp-Source: AGHT+IGFMjZhrrt+nhUWUgcOP7uEABMwGqbxm0hU5bb34n096VjKFWH00MaMRnBj6FnZR6rBtHWamMpIv8v7
X-Received: by 2002:a05:6870:538e:b0:321:7bd4:963d with SMTP id
 586e51a60fabf-3c0f591e8a4mr12072882fac.14.1760519136491; 
 Wed, 15 Oct 2025 02:05:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-3c8c8bf9760sm1437768fac.11.2025.10.15.02.05.35
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:05:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b5527f0d39bso14260979a12.2
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519134; x=1761123934; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=00gnMT/+o3K5TobN2N8K1Xw2sPt5jaafikUUsU/uFsk=;
 b=ZhivZVX5N/rYTyDcWIVFPZ+e9lzGe6JolZ3EvjKprzSGvBTwtm23SQBbbscdDU1bzP
 WF052ef3oQzkeGhxBX51iqGF7phPafE5AG+E5j2aegpHp7HbE9aHrS3MEelGwbdLBIUX
 +KYtemot+OwE3xvv6tr1Lw2XPpZC3mYvShm40=
X-Received: by 2002:a05:6a20:3d8b:b0:2b0:ff55:f825 with SMTP id
 adf61e73a8af0-32da8171c93mr38152509637.25.1760519133756; 
 Wed, 15 Oct 2025 02:05:33 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d8b:b0:2b0:ff55:f825 with SMTP id
 adf61e73a8af0-32da8171c93mr38152460637.25.1760519133125; 
 Wed, 15 Oct 2025 02:05:33 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.05.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:05:32 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH v3 50/54] net/bnxt/tf_core: fix truflow PF init failure on
 sriov disabled
Date: Wed, 15 Oct 2025 05:00:20 -0400
Message-Id: <20251015090024.32250-51-manish.kurup@broadcom.com>
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

From: Farah Smith <farah.smith@broadcom.com>

When sriov is disabled and running DPDK on PFs fix invalid max VF
check during table scope creation.

Signed-off-by: Farah Smith <farah.smith@broadcom.com>
Reviewed-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
---
 drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
index 878f62c115..c06099af12 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
@@ -1210,7 +1210,8 @@ int tfc_tbl_scope_mem_alloc(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 				return rc;
 
 			if (fid > max_vf) {
-				PMD_DRV_LOG_LINE(ERR, "fid out of range %d", fid);
+				PMD_DRV_LOG_LINE(ERR, "%s fid out of range %d",
+						 __func__, fid);
 				return -EINVAL;
 			}
 
@@ -1419,16 +1420,7 @@ int tfc_tbl_scope_mem_free(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 	}
 	if (scope_type != CFA_SCOPE_TYPE_NON_SHARED && is_pf) {
 		uint16_t pool_cnt;
-		uint16_t max_vf;
 
-		rc = tfc_bp_vf_max(tfcp, &max_vf);
-		if (rc)
-			return rc;
-
-		if (fid > max_vf) {
-			PMD_DRV_LOG_LINE(ERR, "invalid fid 0x%x", fid);
-			return -EINVAL;
-		}
 		rc = tbl_scope_tpm_fid_rem(tfcp, fid, tsid, &pool_cnt);
 		if (rc) {
 			PMD_DRV_LOG_LINE(ERR, "error getting tsid(%d) pools status %s",
-- 
2.39.5 (Apple Git-154)

