Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CB5CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:05:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C12BE40E4C;
	Wed, 15 Oct 2025 11:04:28 +0200 (CEST)
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com
 [209.85.219.97]) by mails.dpdk.org (Postfix) with ESMTP id 2DBD240E4B
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:04:27 +0200 (CEST)
Received: by mail-qv1-f97.google.com with SMTP id
 6a1803df08f44-799572d92b0so83860716d6.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519066; x=1761123866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ij0hSuFP4lyPjAbN4hXlpNhbJAvcj6+7MhEvujeLGeg=;
 b=S25cywPb9JsM+sNS4YUCPmghm740o9Rj12a1P2ZUQvGVIh3cM7lZH9LCOp2+qsfa8b
 uoL2I1awdFT2Tf9E0jzyC3kA7AuN+dQDYDYCqWWQwEfC1CcbOU32YnAr990bYUnDhsTn
 7fZpW2sQGgdDhNRgfqkqxEz/VAhXFd7G/cSfX/O41hfjdI3Y9MDhSEQy5WD5oHBgrnTl
 5YQSRFHimt1ONjV8ESmtRXnf3kkWG2+vKO/c7h4y/wz5IfUfnhsDTFgIbR2zdH1hyazo
 ZRF7RLu5cectCqp7tV9Gfh5IGmVPaLNiHm4x36YNaALahgIvzVt8GzzRQd/Q85s57LZW
 y/LQ==
X-Gm-Message-State: AOJu0Yw2eKKAZllCZtkofgILjf53l8CxwPgsSR2Ey16auD5CZ1Inoxpn
 964+tCqqwVZB4gBVWPeGdITb+/6qRZ/qxFgHCawDfR+yKp9cN5PRJ+dZc70qpkYMEpfwHtpzh3U
 nuSE0XlmULZ6aemkERdr7dQyMU/vfxNmG30IVgAN37j3aihHNy5T71OTkaD5Tn1celvIutoR9jh
 uY6IccTfcEUXJgd2Lfz+S8DAg+0iNzUS3kTD2CmFXdYo46pgVKOwVWoHmy5xtyK7TM8Vr99g==
X-Gm-Gg: ASbGncsGdzjCV4v41cyEAQpFVCiOSfzYs5bfHKsZdqQwh1Mpyx4DV2cdqYeataZ+N34
 P48UYjIlEZHtaU7ItlIJFBhaHcJYgBushTuFUHGI6hIWhUvWN2eZnyyYIyMM7RB1GqlzNXhZ9Ag
 8pgTcx7mhtOrWY7k882yf2pT202IhPjNUP9BgX2OLlEwOwGG3laamdscRwQw7FTlUxIXptGzHMN
 oAxDXf7R5A5hToS/7N5E+kayl+XNZkfw9Mmwoe5s+QxUKAHgqL2xWP3T9ozZo481bHf+rIW9nrN
 G7d0yuJFHb1YyVKwTSlvJ1ofOysZMkKKrWdm59ofGTMW/rkTte0to7CfNKF72Abv/AflMoA5dhd
 CUCiqVAwN4hmracV9jaVV4A8ABNpxS4EHxqlCD2qr+OiHQotDb+FBl1V1KPdzp9OIcs6mQuDqtZ
 GxrA==
X-Google-Smtp-Source: AGHT+IGPyidekCNFGlS58sd4kXToIb4f5iOTBhAnWUGUEr4XDUwNBZLzcs2IzgkB1orGCRkFY+c2SmrT/Ma+
X-Received: by 2002:a05:6214:5299:b0:791:34a5:8682 with SMTP id
 6a1803df08f44-87b2ef6c765mr394157946d6.38.1760519066180; 
 Wed, 15 Oct 2025 02:04:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-87c0129faadsm1939936d6.30.2025.10.15.02.04.25
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:04:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7a153ba0009so1615385b3a.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519064; x=1761123864; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ij0hSuFP4lyPjAbN4hXlpNhbJAvcj6+7MhEvujeLGeg=;
 b=Gx3AeWMkK9J6DR7vUawSPYwo01d/qesM5Qn9bSovq8kenR+TTlt66bOgEzNpUomoIY
 SvSMj1PTgre8cZHyYo+PVcNnJAf/hgZfUlN+92BVqEtaPYxLEfnresi2TcGiT9Qe1DMc
 PoQG0YpW+AblXkiQt6pSvnCaagkDna7lHnDhA=
X-Received: by 2002:a05:6a00:1406:b0:78a:f70d:b80c with SMTP id
 d2e1a72fcca58-79387826a86mr29895850b3a.22.1760519064567; 
 Wed, 15 Oct 2025 02:04:24 -0700 (PDT)
X-Received: by 2002:a05:6a00:1406:b0:78a:f70d:b80c with SMTP id
 d2e1a72fcca58-79387826a86mr29895813b3a.22.1760519064053; 
 Wed, 15 Oct 2025 02:04:24 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.04.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:04:23 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>
Subject: [PATCH v3 25/54] net/bnxt: truflow remove redundant code for mpc init
Date: Wed, 15 Oct 2025 04:59:55 -0400
Message-Id: <20251015090024.32250-26-manish.kurup@broadcom.com>
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

This patch removes redundant code from two files which is used
during mpc init. The NULL condition check for mpc member in
bnxt_mpc.c file is not required as mpc will always be initialized
for P7 platform. The extra condition added in bnxt_ethdev.c to
enable mpc for tf apps is not required as it will be always be
enabled for P7 platform.

Signed-off-by: Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/bnxt_mpc.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_mpc.c b/drivers/net/bnxt/bnxt_mpc.c
index ff2f0d7043..2582b50782 100644
--- a/drivers/net/bnxt/bnxt_mpc.c
+++ b/drivers/net/bnxt/bnxt_mpc.c
@@ -719,20 +719,10 @@ int bnxt_mpc_send(struct bnxt *bp,
 		  bool batch)
 {
 	int rc;
-	struct bnxt_mpc_txq *mpc_queue;
+	struct bnxt_mpc_txq *mpc_queue = bp->mpc->mpc_txq[in_msg->chnl_id];
 	int retry = BNXT_MPC_RX_RETRY;
 	uint32_t pi = 0;
 
-	/*
-	 * TODO: This condition check is added to avoid
-	 * segmentation fault in case mpc argument is
-	 * missing in dev-args. Fix this by removing
-	 * mpc argument from dev args.
-	 */
-	if (!bp->mpc)
-		return -1;
-	mpc_queue = bp->mpc->mpc_txq[in_msg->chnl_id];
-
 	if (out_msg->cmp_type != CMPL_BASE_TYPE_MID_PATH_SHORT &&
 	    out_msg->cmp_type != CMPL_BASE_TYPE_MID_PATH_LONG)
 		return -1;
-- 
2.39.5 (Apple Git-154)

