Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CF7CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:04:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD37740E41;
	Wed, 15 Oct 2025 11:04:17 +0200 (CEST)
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com
 [209.85.166.228])
 by mails.dpdk.org (Postfix) with ESMTP id B019440E34
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:04:16 +0200 (CEST)
Received: by mail-il1-f228.google.com with SMTP id
 e9e14a558f8ab-430ab5bd51aso3647925ab.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519056; x=1761123856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7AC4lRdOLtLVMIYfNCDOJAsZu0pn1+BKzrGcc4bgyX4=;
 b=uEr81C0QRSrATX9yPpOXbkav686XoThgpYKpcFxi5S2TCzseQ+WE37cnJ+r+LA712j
 uHwCM0JO3eSgDY5isn5UF1BwuQbTtxXWR8j7Rucf1dSNV53A/vUb9BA+hNzuEBCeFyqa
 NwjAy898n7leEhGvMLGBkyNRq0Y39vfbdPQDybNmQ7EoETVUZk+Qd9e4nEAD/x+PAh+p
 sMz4nwvIzxlhH55L4IzMus4tcWeE/VwiwOMrNy5Xt62kQEB6diu2rqzTp6rrpMPV6vQF
 4s4/Ky1bpI/oVh2MCxkkPelirJvu0hbZTQ2MPPD2ejTUpBuCnWUEz6O8NGjoBk3yk1GQ
 xBVw==
X-Gm-Message-State: AOJu0YwRNTJvb7YzaEVanU1xq/9ISuzeQ8VTEKN2hsWY+FU6OKKpKEEx
 Z/LuRyR3G4aFhqqfRQniWxL2EbsafZGNaVc169lE/fUrmyKu3SGSigAvEwCFLlbmn9oIMPJhrpJ
 4GzTB/1jt9mnftbvgBE2xg05S5VNNIRnbvXtWmIfTzjf8z4ykaKbuTBFX4dmqoVdqIKXMslP72T
 XfAmNxMuYcZJcSmBOfnnBzP4ats+9HQu267Ir+MlBeh0U71LBWZNxorwKPLw2y0oe4ydoutA==
X-Gm-Gg: ASbGnctZtszzL3WviY1vbcyArO4B6R/sHskFudJwOrrqO/i6Z/oQQ+3Fyu7/zS1F4I/
 iPu9FWhCAZHDJeb4zLn0QhsV2QTAxqexiFcmxL2nqpSByukHGaak6hvANP/YAXOoyW6nlqxAAWU
 293Lizo23kDQItw+2PnW2lWywVCh/wYXRWcFbvNM1TtpSTvBCwXwkqk+9jzCfI4IPrNiaT24ohX
 BJX/PvLQcxmgwhN0xhHOkn353jnXRPXucPvcmhNrOfwWs4N+ajaefQEGTTQCdjRA3qb6azeF+BB
 cPFgjNpnc2PW7cYZEL+qaUMfz4ikW9yVu6Jp3ZvlaQ5DpC/dFZ4A4epWLf542ZR5znDxXkQdmgK
 bO8Se6wCuwQe0P7AXI6MlkpwYsu4tw7Z+kczq1nnMN6BvMb2zKZRBtgveu5c9Dqp6uL4Tu/hlFa
 55dQ==
X-Google-Smtp-Source: AGHT+IEa83GBZhTUqQLWPBksHjRxQwFll+RkwVq2NRCQFO8utMZvKqZ/vaysSLkqpQQDyiksgl1rmNSLqnwC
X-Received: by 2002:a05:6e02:1889:b0:430:aff9:a82e with SMTP id
 e9e14a558f8ab-430aff9ab5cmr3334595ab.16.1760519055921; 
 Wed, 15 Oct 2025 02:04:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
 by smtp-relay.gmail.com with ESMTPS id
 e9e14a558f8ab-430aedb37b7sm479785ab.18.2025.10.15.02.04.14
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:04:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7811a602576so13498408b3a.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519053; x=1761123853; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7AC4lRdOLtLVMIYfNCDOJAsZu0pn1+BKzrGcc4bgyX4=;
 b=ZA5EmAbzjek1/gfWH+aJTh7Sr85s+MlALilpGFerk+kL884QZe2qHMYvXBGRj7phkm
 uermNhHYZwAEWpq5AQ2xiBQeyRs3l3fctxvoujX8s/mrY30K8DSrnVONXssx23hX5z2e
 FTms3jKRLCFddSvoKM/yt/CtaOdAQa5/etEuo=
X-Received: by 2002:a05:6a21:9990:b0:2d4:5667:8da1 with SMTP id
 adf61e73a8af0-32da817d06emr38839411637.25.1760519053055; 
 Wed, 15 Oct 2025 02:04:13 -0700 (PDT)
X-Received: by 2002:a05:6a21:9990:b0:2d4:5667:8da1 with SMTP id
 adf61e73a8af0-32da817d06emr38839370637.25.1760519052480; 
 Wed, 15 Oct 2025 02:04:12 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.04.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:04:12 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH v3 21/54] net/bnxt/tf_ulp: fix seg fault when devargs argument
 missing
Date: Wed, 15 Oct 2025 04:59:51 -0400
Message-Id: <20251015090024.32250-22-manish.kurup@broadcom.com>
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

From: Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>

For Thor2 if any of the ports are attached on testpmd without
"mpc=1" argument, code flow will not initialize core mpc
structure which can lead to seg fault in bnxt_mpc_send while
accessing tx queues. Fix it by adding NULL conditional check for
mpc member of bp structure.

Signed-off-by: Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
---
 drivers/net/bnxt/bnxt_mpc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/bnxt_mpc.c b/drivers/net/bnxt/bnxt_mpc.c
index 2582b50782..ff2f0d7043 100644
--- a/drivers/net/bnxt/bnxt_mpc.c
+++ b/drivers/net/bnxt/bnxt_mpc.c
@@ -719,10 +719,20 @@ int bnxt_mpc_send(struct bnxt *bp,
 		  bool batch)
 {
 	int rc;
-	struct bnxt_mpc_txq *mpc_queue = bp->mpc->mpc_txq[in_msg->chnl_id];
+	struct bnxt_mpc_txq *mpc_queue;
 	int retry = BNXT_MPC_RX_RETRY;
 	uint32_t pi = 0;
 
+	/*
+	 * TODO: This condition check is added to avoid
+	 * segmentation fault in case mpc argument is
+	 * missing in dev-args. Fix this by removing
+	 * mpc argument from dev args.
+	 */
+	if (!bp->mpc)
+		return -1;
+	mpc_queue = bp->mpc->mpc_txq[in_msg->chnl_id];
+
 	if (out_msg->cmp_type != CMPL_BASE_TYPE_MID_PATH_SHORT &&
 	    out_msg->cmp_type != CMPL_BASE_TYPE_MID_PATH_LONG)
 		return -1;
-- 
2.39.5 (Apple Git-154)

