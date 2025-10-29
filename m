Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14135CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:18:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63B3F4066C;
	Wed, 29 Oct 2025 17:18:39 +0100 (CET)
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com
 [209.85.214.226])
 by mails.dpdk.org (Postfix) with ESMTP id 5A32140651
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:18:38 +0100 (CET)
Received: by mail-pl1-f226.google.com with SMTP id
 d9443c01a7336-290b48e09a7so195855ad.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754717; x=1762359517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ij0hSuFP4lyPjAbN4hXlpNhbJAvcj6+7MhEvujeLGeg=;
 b=s4MzFhZW/P1d4vqlKoHI4c/2PF46a0A7cBkAk5vAbH4JjiiXBWZgCtJNt1fj1FEezw
 c7tME9wG8wElBARPI3XmpgcztjaFEjEQdzStu9ZAqnIJiOKv7FFN22NCQUQAoON79kJ0
 YC0IAWXrYz4FyXpm0Y4+gpRUFmkO9neGacHx/81/4UcD3D9f0DT+ypqTEwToqVdqfsFZ
 6gw/Vl1VtPbUAxrPBxVSoFgnyF9IIuniRaIGdiB01bZcK7SAZ9DxdxB/HMARsE/TB5eS
 jEjL4PtMI8cLzCc/FqGN6L17d2PPEZmVCqaD4ux9C+FEldE+OLyMQ+lqpBDYS365ugKp
 Ga9g==
X-Gm-Message-State: AOJu0YyeehNvjwE9LEH8/UQvP4l8uwkPcU1aS5T2dHpTlwmhDt+R1o1e
 s234j+7MJs/GLn+Dmqiyxs3ZtgLXn1tGlrus3Ui5uyywlluNcRTrV4WH48ZWuFsCyHMBnHbS023
 xDhmd3HhrY2tEUhdez6Og37O+ELao3B0x6l1qZV3vBSOI5+Xl0RbrOP6ECAMD7jh8xiTpGj4M8w
 fhT4DFIvRrUwYM5cKOKL/NT42qH9VnJIL4D8nuQDbqxWkxWeHySz1q1DQO0MD8fNbRrA6okA==
X-Gm-Gg: ASbGnctTUa+O/JHTjqM3pt8xWhrdlUW4r+fLrHzlHwP6ODCOzSyz+HRW1bD/1+i0WjK
 VMAPwDrxY+osZl9K7QPVL3731cDZj0z9sQQ91yB5Vi+PQYvCjoI1Pj/bp+b7JXlTBtGEuajwVIq
 TGr0NDElD1VNrlXEozR8znlkHs+qzn9E8JsIs9f5T5ugWhaLFsm0uw/H4N+gypdMRr2BR+V0lFK
 PWrtXkEIHhNqQXDEenkjsVgHAAA5U1I+Yyv9MfAi3PB39/ubU0v+zpIO/FnKNHUUYzwpHe3R6NQ
 0u3pjb95vCmNN0pLQjuyjXRjLqKUFpQGRbtlEWKznjz+vq3A/EIPpE/Va12TbJmbAcBGuyJSQnq
 gS4fwhb9woCJJPAl3MvZeDgjBCWJIGoQ7DJW6gNT8gH/k+D69n+I6B/aecc4AzwxBdvRibf/QxV
 dXUtmJBZtzNGeFBqD6wpJSS/o6+JN75Yo0H4L8
X-Google-Smtp-Source: AGHT+IEaPh+UfkuI/ghl/qNfspp7M+lyHO5n/b3w9gfAS3oN9hvnrecdB+7hUToufPpuj8dZlCmyJAXHOl4x
X-Received: by 2002:a17:903:1246:b0:262:9ac8:610f with SMTP id
 d9443c01a7336-294dee06b3dmr37763185ad.22.1761754717284; 
 Wed, 29 Oct 2025 09:18:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-29498cf30b4sm13449565ad.12.2025.10.29.09.18.36
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:18:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-88f1dad9992so2927826085a.1
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754716; x=1762359516; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ij0hSuFP4lyPjAbN4hXlpNhbJAvcj6+7MhEvujeLGeg=;
 b=flqeX+yOsFHA05wurWckiUnLiaHtgqBinnl+yschrJHQ2wHCNl4mfQAQmHa5kjdHps
 boE+v+cHvab1oByj+ULPbVvUNY5xlqTmDrgkSgPtfKRn4vFbBySpELQCTkW+Mxw7uS7N
 bA6sgrsdMLw+xUwtzqfPOvESKeyqmkb0dkh1Y=
X-Received: by 2002:a05:620a:6914:b0:89f:3bd5:cacd with SMTP id
 af79cd13be357-8a8e5ba1974mr485401685a.74.1761754715804; 
 Wed, 29 Oct 2025 09:18:35 -0700 (PDT)
X-Received: by 2002:a05:620a:6914:b0:89f:3bd5:cacd with SMTP id
 af79cd13be357-8a8e5ba1974mr485394985a.74.1761754714994; 
 Wed, 29 Oct 2025 09:18:34 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.18.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:18:34 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>
Subject: [PATCH v5 28/57] net/bnxt: truflow remove redundant code for mpc init
Date: Wed, 29 Oct 2025 12:06:43 -0400
Message-Id: <20251029160712.58519-29-manish.kurup@broadcom.com>
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

