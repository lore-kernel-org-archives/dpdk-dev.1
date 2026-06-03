Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B95FCD6E69
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 17:50:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B83B402C4;
	Wed,  3 Jun 2026 19:50:00 +0200 (CEST)
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com
 [209.85.216.97]) by mails.dpdk.org (Postfix) with ESMTP id 554424065F
 for <dev@dpdk.org>; Wed,  3 Jun 2026 19:49:58 +0200 (CEST)
Received: by mail-pj1-f97.google.com with SMTP id
 98e67ed59e1d1-36da8439078so3451016a91.2
 for <dev@dpdk.org>; Wed, 03 Jun 2026 10:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780508997; x=1781113797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f3D3NJ8zQZ1gKqWPb7TuG6PIlbI/VjmbHpeQcL+swms=;
 b=EJhVQsSn6e2p+1E/gIa08ajO3EYM5EuVktgSkChufsQHlqMVBZKQF4XK7jD+cJmlYp
 aVaQdBxcXfh39wzb+UmnNOHX9UMLZATkL7hyopxLPpvtQ84TbU7y8Y5nvEyUlY4YTTeF
 kQzcBE8AqSJFMmvQQDD2pmGgoS+WJevgjpRtoigZncvCZ45FfWurKxKatA5/B00XxtCM
 c+Dzn7c4wadxTiswFcOrWM+xKRycRVqjFrtcCsBAqLWc+dQt5Er/ICOCzYM+vDj9EPlj
 uYIjqcte2CMT4KQXDu9/sg2wZTmn1h5aVID1hZlFGsN4V59LXf91FivJa7xDOICkdO/3
 kU7Q==
X-Gm-Message-State: AOJu0YwdRI/0w7Lt77oYDRLUls1oCtIg3jYEauHuELybt3EoTSh0BJou
 h1jabAmuVj8iG98/EmVgHi2Iw/sF47W78xY1upwwS+J978MazIR+cPNjze9bFzbJKjPuZbD3gC6
 lYh9PHHesiUcmR9Qn0TgNnPuZr6tpAD1lHx9cyEyShwfkcYz8SvWx/hGem0E9aztUzSWihhEtZh
 E04QBz17Ime/u2RAVedrJeDyBnLLDn+pOjtWdXQYtCv19zMfTzHQh9Vl6PTxozX45Rri2yK9TOc
 FfcyO4zveo0
X-Gm-Gg: Acq92OHtD2m9ULb+G7Xr3yFO4ujA2Ic+8H9RbDjOP32QAX65/3xfyG2KYXuLlAKJCL1
 u8s69dAQWGFAXDT9Ha0m92JyT7G9YdCF8d6N8RdwIvXI4AXdNlbcSY7lufQ39QuIdRKl/HH8jEJ
 cV71vC0YKT18m658ckqqJ9FuYh0SRcx8PwShyYTUNN7m5fd7hq1AIshHgO0E7gIzHZaxz/td2qO
 pLHqYziKBL6PJKLrqGBeNH1a0K6qStR17RD3fhZrryWz3l18AzENt4V+i1qLYlRdkMITGXGaiDd
 k2THbLmyXckWJKzTWEBJv3Hx197GdkBULx5YIN05GUmt7GoQK7E1BSHIAUoT4tbd9fhsizSzHs6
 lZK9cpistUSdMvqaO3b/W0cRFSljggy0EYaGrkUWEAVmK8BAxYSn1k+9s0Ak2mwBtTvvCKg6RaG
 NPu/8ic8eBJ4DDR32H70qW9t0ej6oviw==
X-Received: by 2002:a17:903:1786:b0:2c0:c38d:9d37 with SMTP id
 d9443c01a7336-2c163d92f23mr45474235ad.25.1780508997305; 
 Wed, 03 Jun 2026 10:49:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 ([144.49.247.127]) by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2c164f7073bsm2849795ad.6.2026.06.03.10.49.57
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 10:49:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5174a23afcbso53186501cf.3
 for <dev@dpdk.org>; Wed, 03 Jun 2026 10:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780508996; x=1781113796; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f3D3NJ8zQZ1gKqWPb7TuG6PIlbI/VjmbHpeQcL+swms=;
 b=gtItZ3oazKq8YHsKfLz8Jf05ApxC9At9YC3D0yftkeHYvkAb6RK+9AyzYRowCA86RR
 1H14hjDSiVoxUxtuIKbOwHrqJwUcmlIWhcfJ8Sy6Pc1nQY9bB30a4zBj7qOcZweAx5Mh
 mDBPwXvcW9+n68o4e1royW9dXQA6XsftzE/50=
X-Received: by 2002:a05:622a:6091:b0:517:7620:20f9 with SMTP id
 d75a77b69052e-517785d8b28mr66319321cf.19.1780508995999; 
 Wed, 03 Jun 2026 10:49:55 -0700 (PDT)
X-Received: by 2002:a05:622a:6091:b0:517:7620:20f9 with SMTP id
 d75a77b69052e-517785d8b28mr66318841cf.19.1780508995317; 
 Wed, 03 Jun 2026 10:49:55 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517780e8169sm29021021cf.2.2026.06.03.10.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 10:49:54 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 2/4] net/bnxt: fix QP resource count in backing store config
Date: Wed,  3 Jun 2026 11:51:35 -0600
Message-ID: <20260603175137.1990204-3-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603175137.1990204-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260603175137.1990204-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Ajit Khaparde <ajit.khaparde@broadcom.com>

The driver is not passing the QP1 count while
configuring backing store for QP type.
This can result in a smaller set of entries allocated by the
driver with the firmware.

The number of entries is provided by the firmware as a
part of backing store qcaps v2 HWRM command.

Fixes: 5b5d398434f9 ("net/bnxt: add support for backing store v2")
Cc: stable@dpdk.org
Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index b677f9491d..7d70d0f3ec 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -5404,11 +5404,11 @@ int bnxt_alloc_ctx_pg_tbls(struct bnxt *bp)
 			if (ctxm->type == HWRM_FUNC_BACKING_STORE_CFG_V2_INPUT_TYPE_CQ)
 				entries = ctxm->cq_l2_entries;
 			else if (ctxm->type == HWRM_FUNC_BACKING_STORE_CFG_V2_INPUT_TYPE_QP)
-				entries = ctxm->qp_l2_entries;
+				entries = ctxm->qp_l2_entries + ctxm->qp_qp1_entries;
 			else if (ctxm->type == HWRM_FUNC_BACKING_STORE_CFG_V2_INPUT_TYPE_MRAV)
 				entries = ctxm->mrav_av_entries;
 			else if (ctxm->type == HWRM_FUNC_BACKING_STORE_CFG_V2_INPUT_TYPE_TIM)
-				entries = ctx2->qp_l2_entries;
+				entries = ctx2->qp_l2_entries + ctx2->qp_qp1_entries;
 			entries = clamp_t(uint32_t, entries, ctxm->min_entries,
 					  ctxm->max_entries);
 			ctx_pg[i].entries = entries;
-- 
2.47.3

