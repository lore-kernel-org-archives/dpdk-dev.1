Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D0ACA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 23:51:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF59E40E1B;
	Tue,  6 Oct 2026 01:51:05 +0200 (CEST)
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com
 [209.85.216.99]) by mails.dpdk.org (Postfix) with ESMTP id 799F140DDD
 for <dev@dpdk.org>; Tue,  6 Oct 2026 01:51:04 +0200 (CEST)
Received: by mail-pj1-f99.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso1641968a91.3
 for <dev@dpdk.org>; Mon, 05 Oct 2026 16:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791244263; x=1791849063;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oIL4UUfpxIkCmGBFYRSUe9xqMPiU2Cw1bHwUFH1ic3c=;
 b=UMxi0rwNWQx/msXkQYTVg4ddQipb53hbVhCwxzJGKm0BNtG7i3hVFp1vQNP0rHl9aR
 DlnM2abNvbcJDMb0Q2TfRpUCGVLOvV92kunnHIrQo1hnarJDjxEyW2zUEgCa9sUFw43Z
 RiYQTtd6xUrvjbNOuAaiUp+FdPWii5/x13AzRCjNQxiWAUcrr3saADlMYZ6tnan7Cd11
 Y3hnkmc0bxrWH8R1CQBqGdiJpS4239b/1DkcTeSsFnnGvNo1anRB9daBTyhv0r7/wH/8
 PYYTJ3uR2hdTKdrHv6SFHP4IjOMyB+0VX56rwknN96MbiEstmCIdxy7x2jvXugdU4hdH
 MUNQ==
X-Gm-Message-State: AFq9FYJ6ymzk8DorhTNa14qrpQ1JzoPUiituqq0GEK7A5FnPg/U4CHPF
 UHWt6Jw9Un8E44Hupx5y9PIFd8Nl2MlWLTEy/2x8viaICp9moHrWbXJ6VD7FiJ4txtarsBc0TwC
 ZfIiDylOJtvQ/s4k1uLUOgKzWkrrRnCTMMOY0d/0zj9PmDlQRfglsfKXeJ+rqARboGXNDS0xJYM
 iJE2ogF7tlF9tlQtkpuPy73fM0izrgqTsm9cBtwIRZQtNaI8Lo6mDxQGQTgIWlXX9Y6EtzVA==
X-Gm-Gg: AYBFou13WLaQD20WxPmySdkaNCHeRtwvQhpo3gpcsFmfhNvqnq2AgoLlWUct7UKDnlU
 YwczZ24MFfr2kL+0Mo4/UtQP6ISCprOKdE+rB0WCnnZfpXGdqic/qrHbIeW6BkfmUEFfkSOMjRn
 HWPyH6CUXNEtGVCIP8ou7YkrKB2cWpeXzWBEhoIDmu2CzmV6DN9HVmzqZsLi2oI6UF4YeRQFofI
 Nax1pZUQB+8Mylc8tNgoPNFj6JteWSI4Zm9w6XhDGDHTxGdIGH6XreIdxF+SqhcybARK6L4r99I
 K+7S6koIVGx+KWvaROYQNfNdQWV8tvCFjQ9QdPlCpDUI355Vf+3XPPjvSWsEAw+t1Y6ws7kV331
 DigV2z7hwWNJwwKYnlufVWnZ0DBtC6BrjJXoFeGqEqlDISINh8HkvmLtvOrJ2fqcCDUlJ3GBFog
 Bh6F8LiVJ1FuHqxVM5e4H6TfjmZzG23lQBRQuhAw==
X-Received: by 2002:a17:90b:3ccd:b0:3a8:878:ebab with SMTP id
 98e67ed59e1d1-3a80879621cmr3778797a91.35.1791244263525; 
 Mon, 05 Oct 2026 16:51:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-ccb74b4d4c0sm1762075a12.9.2026.10.05.16.51.03
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 16:51:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5337b591609so30404221cf.3
 for <dev@dpdk.org>; Mon, 05 Oct 2026 16:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791244262; x=1791849062; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oIL4UUfpxIkCmGBFYRSUe9xqMPiU2Cw1bHwUFH1ic3c=;
 b=Z0xBhHUSupELrbqR50bTEMdL3pJCgMJYWQ0gaUwqUcMKEQQsnp4DuuKz9WYLpFeJNX
 qPEstDWqLEu2Ookl4nEGhzvn45ENKSgdXjsEah2toWNwlYEzQZVDdA6H9hBeGylrM8lp
 8QA3cg4AWkssKAE1Bo2pdmhDEZU8lZTfishp8=
X-Received: by 2002:a05:622a:5793:b0:533:3af3:43b9 with SMTP id
 d75a77b69052e-53511ea5f4amr163784011cf.44.1791244262071; 
 Mon, 05 Oct 2026 16:51:02 -0700 (PDT)
X-Received: by 2002:a05:622a:5793:b0:533:3af3:43b9 with SMTP id
 d75a77b69052e-53511ea5f4amr163783611cf.44.1791244261426; 
 Mon, 05 Oct 2026 16:51:01 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53398516c45sm109039161cf.0.2026.10.05.16.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 16:51:01 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH] net/bnxt: avoid maybe-uninitialized warning in flow counters
Date: Mon,  5 Oct 2026 18:50:59 -0500
Message-Id: <20261005235059.27176-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
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

From: Shuanglin Wang <shuanglin.wang@broadcom.com>

In ulp_fc_mgr_cntr_set, ulp_fc_mgr_cntr_reset, and
ulp_fc_mgr_cntr_parent_flow_set, sw_cntr_idx was declared without
an initializer. The variable is always written through a pointer by
ulp_fc_mgr_sw_cntr_idx_get before it is read, but GCC
-Wmaybe-uninitialized cannot prove this from the function signature
alone. Initialize sw_cntr_idx to 0 at each declaration to silence
the three build warnings.

Signed-off-by: Shuanglin Wang <shuanglin.wang@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/ulp_fc_mgr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_fc_mgr.c b/drivers/net/bnxt/tf_ulp/ulp_fc_mgr.c
index c765e123fe..4f02dd2c20 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_fc_mgr.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_fc_mgr.c
@@ -437,7 +437,7 @@ int32_t ulp_fc_mgr_cntr_set(struct bnxt_ulp_context *ctxt, enum tf_dir dir,
 			    enum bnxt_ulp_session_type session_type)
 {
 	struct bnxt_ulp_fc_info *ulp_fc_info;
-	uint32_t sw_cntr_idx;
+	uint32_t sw_cntr_idx = 0;
 
 	ulp_fc_info = bnxt_ulp_cntxt_ptr2_fc_info_get(ctxt);
 	if (!ulp_fc_info)
@@ -473,7 +473,7 @@ int32_t ulp_fc_mgr_cntr_reset(struct bnxt_ulp_context *ctxt, uint8_t dir,
 			      uint32_t hw_cntr_id)
 {
 	struct bnxt_ulp_fc_info *ulp_fc_info;
-	uint32_t sw_cntr_idx;
+	uint32_t sw_cntr_idx = 0;
 
 	ulp_fc_info = bnxt_ulp_cntxt_ptr2_fc_info_get(ctxt);
 	if (!ulp_fc_info)
@@ -691,7 +691,7 @@ int32_t ulp_fc_mgr_cntr_parent_flow_set(struct bnxt_ulp_context *ctxt,
 					uint32_t pc_idx)
 {
 	struct bnxt_ulp_fc_info *ulp_fc_info;
-	uint32_t sw_cntr_idx;
+	uint32_t sw_cntr_idx = 0;
 	int32_t rc = 0;
 
 	ulp_fc_info = bnxt_ulp_cntxt_ptr2_fc_info_get(ctxt);
-- 
2.31.1

