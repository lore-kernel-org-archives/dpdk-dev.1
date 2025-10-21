Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E68CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 17:54:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FFB54111B;
	Tue, 21 Oct 2025 19:53:08 +0200 (CEST)
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com
 [209.85.166.228])
 by mails.dpdk.org (Postfix) with ESMTP id 1CC5E410D2
 for <dev@dpdk.org>; Tue, 21 Oct 2025 19:53:05 +0200 (CEST)
Received: by mail-il1-f228.google.com with SMTP id
 e9e14a558f8ab-431d2ca8323so1835715ab.3
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761069184; x=1761673984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ij0hSuFP4lyPjAbN4hXlpNhbJAvcj6+7MhEvujeLGeg=;
 b=EAvX42GZw0nipz51NaODRZGCAn6cSOHvCBdIkrq/TnopaqUTemob4L68IP8Mz5MNcj
 z1dM065SVZyb/9R0K+RluDU3VA7CYfFup/atnQQOEsP+BWsyjzSZACmswy6myj5ZYDJN
 vFv/U5fRaILFBzfauBZ8TTEpdJac/Sg45TU6/sqGPbHbEW/tGzygYwd1WdpRCBZK+t4m
 uiberIEmtmPF4yVhvo0NN4d+jM2+2pWHyIFinPBg4e85cRhkRVZHspwpYVDSrMrGz7g0
 br4wnU2uvaHRtumvUcUp/9LzRUd6ix82ohklcuQeliF+cyFn7g8uSUOK5wowpUC3fxIW
 duOA==
X-Gm-Message-State: AOJu0Yw4druFxyVOZTCUWdGNDEr+zxrbYGMjtbBrNtuSz3fe+4TWzMtm
 qIa+63J/MOCVhpzA7eskfuv6Pz0J9FPklQ9CC3iAzS5ZdS4p3xFLLXTbYUiCQfM7jbRd/T9Fq/+
 Nz8FalGmlZHE0ydtwTIqVvLziQtVQguY9GqgnsgZQkSKCNH6stqsCHp9AYGZTmcRsooninFUjej
 fVSAW+WZGq4hZYFAsaPp5Bf8cCmLAhl6ql3U0a3CQk2vIIJxBsyIXPsCpco0YBEjMMFmPMZQ==
X-Gm-Gg: ASbGncunmzo/o60+f2vyPLmHZ0BIrTfcM/VfVMZU3hNIhlrbgnOHMQyPi8Vn4kU3IUj
 SOlcZjyBaW8xkmkXltIvGTUVfKmOHa76IFx7nMz3TnMq9r1XCRz0KUIWt93ZAwKRSEPoq5nxF/t
 mUMhZUWCeE6X9PlD3En+z8tGix3MDMheDkoUbTNWvIOHMscLCShxUucIwOg8xDhbiQPkUx/ilM+
 6qjPo8dA9eyPQDdW7O/UbcfH0wYHXBBvvQNyBJYMTnj9UvMpaXDl4Fn/T4USs6DWEgp1xPaUJTy
 9ieQcnli3p9rMFTqTsmKLYLfw2PR48RoJqAdXCfFJuLoBwa185Ohlc5WJrXb2xaALa0OPSjbb+/
 toZgcFY5AJxXh8474+Hv0dbeSaloYgU/ItUP1rh9It40B/7EcBByopAR2KTLaXO7tqFiY40gP6I
 uFqTFSnrzjTm2FL0DM+2VUPTauimmJFsc=
X-Google-Smtp-Source: AGHT+IFjO0VckcnlE61GraVKsBNJMh5S2dV+WQP5ylnk6dyoXc1ZG4qSi0VLgLUiE/rxY19wqoVOzMsz2gCE
X-Received: by 2002:a05:6e02:2702:b0:42f:9574:7c1e with SMTP id
 e9e14a558f8ab-430c52a253amr256593855ab.27.1761069184271; 
 Tue, 21 Oct 2025 10:53:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
 by smtp-relay.gmail.com with ESMTPS id
 8926c6da1cb9f-5a8a95feddbsm1327688173.7.2025.10.21.10.53.03
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 10:53:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b60992e3b27so3939831a12.3
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761069182; x=1761673982; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ij0hSuFP4lyPjAbN4hXlpNhbJAvcj6+7MhEvujeLGeg=;
 b=KQYjR99h+6BFEHM1PhSOQBWR8Q0WJzcObtdq6/X5Tk9NBcU/pwzicAlzw5EYrl0MzG
 YKpkutxHc/5nhIT/5eXbGMqDvV1RuPvsLhkRQzrw6Zt7Xxc4ZCeOjrL1CmcdCeWoQiZz
 1OkrrKsTQUj0/m+P6mNLxSgiEZm801505GCp8=
X-Received: by 2002:a17:902:da88:b0:24c:9a51:9a33 with SMTP id
 d9443c01a7336-290c9cbc119mr222496425ad.22.1761069182412; 
 Tue, 21 Oct 2025 10:53:02 -0700 (PDT)
X-Received: by 2002:a17:902:da88:b0:24c:9a51:9a33 with SMTP id
 d9443c01a7336-290c9cbc119mr222496075ad.22.1761069181798; 
 Tue, 21 Oct 2025 10:53:01 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292472193c2sm115441495ad.104.2025.10.21.10.53.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 10:53:01 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>
Subject: [PATCH v4 28/57] net/bnxt: truflow remove redundant code for mpc init
Date: Tue, 21 Oct 2025 13:50:20 -0400
Message-Id: <20251021175049.46092-29-manish.kurup@broadcom.com>
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

