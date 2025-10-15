Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E2FCCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:01:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47B4040609;
	Wed, 15 Oct 2025 11:01:11 +0200 (CEST)
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com
 [209.85.166.228])
 by mails.dpdk.org (Postfix) with ESMTP id F19EB40276
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:01:09 +0200 (CEST)
Received: by mail-il1-f228.google.com with SMTP id
 e9e14a558f8ab-430abca3354so6441805ab.2
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760518869; x=1761123669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=805lZjX2jdDGYGkrFvla+zLPmfx9Pfc7jTF7wfcVhwE=;
 b=OZVk8yqQtow2GlXFaKBczj4UJY5/s005NpJAyNsmSR5Y6sHP8cY2X2CVa6uhZYzQ9n
 OYtIgKkuaaZpwDsT6Zx9XO1BBfhaiw7O1ZJaPMxrsuKjyY90Duzd2wERwvJu7V7Hwmx4
 algJC1rBrDR6+IWCKH2cQuIEzB3xJZ1lGKtaPPhK8qyMRZ6ESo4xrSZdLfg2ZNfc4uf5
 MOqoBMNZufzt1/Fofih452acjYAeIpZp2XZOE3Nl5dDwLg3RD0VG62kQdVeK2+D5xyi9
 JORbhszrdkXWYKoMQo9Y2nUp9ZGhqtazH/bOJuywj32gWkIkNY5avwOEQ/LDGie1UxG8
 4bFA==
X-Gm-Message-State: AOJu0Ywd138bvIM0vsZIXGKW2yfgsFHnfyP/mbY4ExSjFJ6IvsuMTgn/
 Nw02yBbIHS/lN/EiDwABuuUGbcNytLsPWtmnWMCeku2+kW8+azj0w1j9PsFD1VyAZt41Mjbfu6R
 PzaMmBkJ3TCNJQSJFgBIg53UMudHqUc5HwX075KSEjke8Yrvn7PaJ9HeobDGLMvhcXOieEQy5Uq
 N7kiGPJome0uK0dS5mHkdIa4HavWnerpgMNHS5DdyiydUPlOzCoFGze7F/+GVOYmJ46lC7OA==
X-Gm-Gg: ASbGncu2sA/4Yicvxxx09u91XBO6E13X6XTSBEC4pw4o/vp9+8ck+wrc/lYnQci3g4F
 sIvYf6e0ymtI0GMpF1Me3mR9g5FftnASDGHN7khs4GD1Jojl51/JlZTJbAPhiqADpjUYm0v7Yo/
 LAaPmp//XA21twX34mQGOi4f/fXkOQ44dxPY5MVaH0lz6ffiq3lxlQOPhhVMNpgkYyVt9t4Y+3v
 p0yqMMTKAXLHKsh5IhlDWfgRIktqJDSR+EAbnn8wdI8Z0lmRzRwKlNTv1wzVUlfA24sIX9PDQJu
 XfvYBwUHOzLP6kQO99tS23fn7Vo8Qgn9hjniks3hpIIqRj6cFc9StU/yfmvddtlq3jcc+pFEtIm
 USN1OVq5RZRAm9oitIxxG/MbZfRF1gM1JIzpcEz6iQrwtUiWFMzrRiK4tsLCOXhenVUa/wVyk0R
 PIRg==
X-Google-Smtp-Source: AGHT+IH3at64njyfKUzSIe8d0at9Ebc6QsQMTxQ07oWpCJAOR3BvZK4KjIySEVASoKbl/SjZ8hL7hsjzC8+O
X-Received: by 2002:a05:6e02:1543:b0:42f:9410:ea96 with SMTP id
 e9e14a558f8ab-42f9410ec91mr268651425ab.2.1760518869135; 
 Wed, 15 Oct 2025 02:01:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
 by smtp-relay.gmail.com with ESMTPS id
 e9e14a558f8ab-42f90260c91sm11809215ab.13.2025.10.15.02.01.07
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:01:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7810e5a22f3so18591326b3a.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760518866; x=1761123666; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=805lZjX2jdDGYGkrFvla+zLPmfx9Pfc7jTF7wfcVhwE=;
 b=Oo16ib27b0nEcwU3QviVvIjnQQoUGmZpHirlSIzJX+DOkhMg8dy3Agzy8eA1+gVHgG
 oz0fw1Dkq4VpI7LPG246dvoODs4hnrm2SL7TYPf3edEX2vGMA1G/CL8trVoAGAhWjwkl
 1fnKUj0JRe56hAbFZlX0LDCdSv3fsW5oQg4DY=
X-Received: by 2002:a05:6a00:886:b0:780:f6db:b1bd with SMTP id
 d2e1a72fcca58-79385324e3dmr31513763b3a.4.1760518866330; 
 Wed, 15 Oct 2025 02:01:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:886:b0:780:f6db:b1bd with SMTP id
 d2e1a72fcca58-79385324e3dmr31513694b3a.4.1760518865708; 
 Wed, 15 Oct 2025 02:01:05 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.01.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:01:05 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Jay Ding <jay.ding@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH v3 02/54] net/bnxt: fix a NULL pointer dereference in bnxt_rep
 funcs
Date: Wed, 15 Oct 2025 04:59:32 -0400
Message-Id: <20251015090024.32250-3-manish.kurup@broadcom.com>
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

From: Jay Ding <jay.ding@broadcom.com>

There are some changes made in the 23.11 upstream function
rte_eth_dev_release_port(). The library now sets "eth_dev->data = NULL"
at the end of the routine. This causes a NULL pointer dereference in the
bnxt_rep_link_update_op() and bnxt_vfr_free() routines when it tries to
access the parent dev.

Signed-off-by: Jay Ding <jay.ding@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/bnxt_reps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_reps.c b/drivers/net/bnxt/bnxt_reps.c
index 6f5c3f80eb..20a0ba65a5 100644
--- a/drivers/net/bnxt/bnxt_reps.c
+++ b/drivers/net/bnxt/bnxt_reps.c
@@ -299,10 +299,10 @@ int bnxt_rep_link_update_op(struct rte_eth_dev *eth_dev, int wait_to_compl)
 	struct rte_eth_link *link;
 	int rc;
 
-	parent_bp = rep->parent_dev->data->dev_private;
-	if (!parent_bp)
+	if (!bnxt_rep_check_parent(rep))
 		return 0;
 
+	parent_bp = rep->parent_dev->data->dev_private;
 	rc = bnxt_link_update_op(parent_bp->eth_dev, wait_to_compl);
 
 	/* Link state. Inherited from PF or trusted VF */
@@ -542,7 +542,7 @@ static int bnxt_vfr_free(struct bnxt_representor *vfr)
 
 	if (!bnxt_rep_check_parent(vfr)) {
 		PMD_DRV_LOG_LINE(DEBUG, "BNXT Port:%d VFR already freed",
-			    vfr->dpdk_port_id);
+				 vfr->dpdk_port_id);
 		return 0;
 	}
 	parent_bp = vfr->parent_dev->data->dev_private;
-- 
2.39.5 (Apple Git-154)

