Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2575CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 21:12:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5BF240678;
	Wed,  3 Jun 2026 23:12:01 +0200 (CEST)
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com
 [209.85.214.225])
 by mails.dpdk.org (Postfix) with ESMTP id 2B9AE402B6
 for <dev@dpdk.org>; Wed,  3 Jun 2026 23:12:00 +0200 (CEST)
Received: by mail-pl1-f225.google.com with SMTP id
 d9443c01a7336-2bf77d4a4e2so6907905ad.1
 for <dev@dpdk.org>; Wed, 03 Jun 2026 14:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780521119; x=1781125919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yPSPKKFRy+greGTV1uzmgItIYrhycwWMD4vaclmca24=;
 b=eqioy0pehvZ0iep1SYWN5ikZJhGtbPiqZa5tNcnnXY64sFaWFwSJogdWPyqE7ibAd1
 clYN5YDa4d8Ao6rLCB42IsAtJnRxqHQc4DqMzf9Y8nADglWjKj1LlNq122eD5+MXBPGy
 faB2Ff4TmHHX8QO/zXtkBc4V81qhe6aM/lAL2YQO1+pmoupZCnIpiN7wW4dLTUU77j/5
 rsNIxVqwvOzTTvjX1gCrmLYEyCv04Mz57MWm5CzQdGt8UbwL1bY8Fs3NoPNQeLGi/rZP
 vEs0YAP3rYdAUBmwDRXoofIbdoMtUwXEYh+MBipqhk0g31I9AUHmz2dVYQwkXMziaFhQ
 QPCQ==
X-Gm-Message-State: AOJu0YyiXPDicIJgZ7/PlQbtdsZSordit/rQcFkxnL48DRV11xepVRBU
 Z6axXuF5Tq4YcG0MD50mvW9XH5g5ZJ2PrhAq3ND9KAZQS6vjhTObYZofPvLg3YYIQ4URPvwAlZE
 oC8EK7Ki3hxG39PtxnK/M0l6qIzUvcoJdqDoz9/+0Ot8lmxodlRA8XULE4FnxKDdTr9C93sN4uv
 oRIbep69WXf68HTHUTTw+AQwYVC3iR5xgIhdcl0neW2ygyXWGGQQf+4cEDg7fM0mQfdaWyS5E7O
 /vChks/dIpi
X-Gm-Gg: Acq92OH9D9EUk/gnFgMQEVUVWTm+qc3qjpSf96nJYklT8lNwpmQpB9amFBvaNfFAs8x
 1Waq+nRpNhAx0fepFBwBeUQG/ChROE5eYru3khBVCj4bPlODQr0sPm31UXtpuWgBkx96PZ5cVvw
 FkLyhyaWb9XgLPpXSL5uE345PZo06AwOJ70VUSza8nLT2yvXWiTMGOrZO75hKIHkEUqobayqmz9
 kw4z5sZL7tJH1FmsFE8nOxnHfIENpk2RS/YvquvW5XfNwmyVfvKzgSU8yQl7egqvAmY1A1om5qB
 dkQcGMiSheHWiKRhg44oc9a6WN7tSVPYdTO9h132zxbBIVZeXRN1tKOesHecZhnHm3eLzGraXwr
 c/NP0O9Y7s9S4Mlz0qMcsEB0GNjrNPV7Kp1SsHL02r2JL6j9Uhn4mR4fHQJeTwX1yolV6mje5mw
 3Q4GF7l3JjrPiUEHfWNOxx89wpysawTg==
X-Received: by 2002:a17:902:ecc3:b0:2bf:21e6:bae1 with SMTP id
 d9443c01a7336-2c197e90f70mr6900965ad.18.1780521119233; 
 Wed, 03 Jun 2026 14:11:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 ([144.49.247.127]) by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2c1664a7d18sm3242525ad.54.2026.06.03.14.11.58
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 14:11:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ccebf7e86aso28248036d6.0
 for <dev@dpdk.org>; Wed, 03 Jun 2026 14:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780521118; x=1781125918; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yPSPKKFRy+greGTV1uzmgItIYrhycwWMD4vaclmca24=;
 b=NOTDU0G4I0lYu7RjFjKwz6vLby1SR0DVD6WH8+DBub+2s2heES9TgwNf15NjWcy+jQ
 5f19B8ZPKsU1q9Gh89OEAF90t/FG1MHVMgTD7ILoDerH/MYS7D1+VmskR0OYyWh2vqXO
 Ifj+kr8GR7PZZ+8Il+tabLiAgaHtmqvHkYG0Y=
X-Received: by 2002:ad4:5c62:0:b0:8cc:f159:7b70 with SMTP id
 6a1803df08f44-8ced82ecdbamr16540406d6.32.1780521118173; 
 Wed, 03 Jun 2026 14:11:58 -0700 (PDT)
X-Received: by 2002:ad4:5c62:0:b0:8cc:f159:7b70 with SMTP id
 6a1803df08f44-8ced82ecdbamr16540076d6.32.1780521117702; 
 Wed, 03 Jun 2026 14:11:57 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd0520d3sm31665416d6.27.2026.06.03.14.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 14:11:57 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Subject: [PATCH 3/5] net/bnxt: fix IOVA range check for external mbuf head node
Date: Wed,  3 Jun 2026 15:13:39 -0600
Message-ID: <20260603211341.2112344-4-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603211341.2112344-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260603211341.2112344-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>

For extmem, the mbuf head node may be allocated from a pool
different from the data buffer pool. In that case the IOVA
address check using rte_mempool_virt2iova() will fail. To fix
this, skip the IOVA range check for external mbufs.
Also add unlikely() in checking invalid mbuf size.

Fixes: d01de33f98e2 ("net/bnxt: skip IOVA range check for external mbuf")
Cc: stable@dpdk.org
Signed-off-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_txr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_txr.c b/drivers/net/bnxt/bnxt_txr.c
index 51b886c1a6..83d18e220b 100644
--- a/drivers/net/bnxt/bnxt_txr.c
+++ b/drivers/net/bnxt/bnxt_txr.c
@@ -220,8 +220,10 @@ static int bnxt_invalid_mbuf(struct rte_mbuf *mbuf)
 	if (unlikely(rte_mbuf_check(mbuf, 1, &reason)))
 		return -EINVAL;
 
-	if (unlikely(!(mbuf->ol_flags & RTE_MBUF_F_EXTERNAL) &&
-		     (mbuf->buf_iova < mbuf_size ||
+	if (unlikely(mbuf->ol_flags & RTE_MBUF_F_EXTERNAL))
+		return 0;
+
+	if (unlikely((mbuf->buf_iova < mbuf_size ||
 		      (mbuf->buf_iova != rte_mempool_virt2iova(mbuf) + mbuf_size))))
 		return -EINVAL;
 
-- 
2.47.3

