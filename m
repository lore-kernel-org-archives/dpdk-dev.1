Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4A6CD6E75
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 00:48:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C618540676;
	Fri,  5 Jun 2026 02:48:35 +0200 (CEST)
Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com
 [209.85.160.227])
 by mails.dpdk.org (Postfix) with ESMTP id 6CA1640659
 for <dev@dpdk.org>; Fri,  5 Jun 2026 02:48:32 +0200 (CEST)
Received: by mail-qt1-f227.google.com with SMTP id
 d75a77b69052e-517583cb07aso14881281cf.2
 for <dev@dpdk.org>; Thu, 04 Jun 2026 17:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780620512; x=1781225312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yPSPKKFRy+greGTV1uzmgItIYrhycwWMD4vaclmca24=;
 b=U1/LNCZcg06SQDjoOGlLuzWwXh6bNBrikluqrUpIXQSBhNyofTTaH/Akrl0US4KK3v
 PToYz8MNc/szTST2GbGkHeL4Gv7b1I1SW4KrEOSv23UQLj1N1FyqwzOhtjEGLn4pqJXx
 vak3R8r/PsjuvzQ5yps/eYgetH2VWB28lERSd6oYE5uK6IGRDhCz/8c0rnCrHrgAneAC
 PSNXN9PYzEup6Xro9X4g1GrRoWUMi2cmPUoY7UPTio5fW/uvIRTPjrAO8T5j71fdg1NO
 fo8FX1QwdDCYc9pNqN/UCCd0SdzIMuL9lJ+7UHYk+iBU/STqjhWkQYlsUTsmVxYB8gA8
 qsSA==
X-Gm-Message-State: AOJu0Yywo23HpkKa7/DQJ8q0X+8ARZiDBvLPkt9847+eOrVkgXMABOTu
 4JNy5nuYGFjd0pxRjmjwBfFEGILEukeobt+nH5S9UL7FY2sIRyeea5MeRYL+iN6VUlmZMNWAGwh
 CcX8mJiadOi2BlzYJwFAGroi0cM24bBMeVNNeFf9HPvRLev51jth39BKr7RX41XkBIGkOqeTvRn
 fPh0ZQphgv0kDisljgLH4XEtyBrI0iS3gi2L29wM9SgWA9b2VFXB0knB4sAHb2X929Sur9STqbJ
 YMh1yrxrGE1
X-Gm-Gg: Acq92OEPZJUQ9NuvmgdMzytVFRQgw8g5GjsO8FnDfgbISYRdIylyeXYOvrN6OjJPyOy
 D5vszSqMuCIj4ekd5W+f4wL19L8KEDw4DII4N6MC/kDmGS5BZ+QvE3poNi/Fu4Ds9wV8WwfuGg/
 UAE9QNbHsKcyl8f3OV20A1hpGNyrH7JZOkxL0OtVMeDk3pfoqPPDnV+Mr3JfWZeLiYQwSV7QjOW
 sS7jtWG1Hq7ly+h0lO3mK9scgcH+nZjwmnLCqeVbcLEWukRzDj9CHFNM2QYIR4QJPjb9xddz8+Z
 Lu7jGqC+AntHxvtb4JcjhMMzgqsaUgnIGzZx25A+VvG4vmAhj+vpzO+tC1l/yRTe6F0qeKK2to6
 bPNawJ7tAUSyV4V5a+FrEqprDm2XdG2rhPztjfh0zPIpbzCRy1uLBChgac9QZbolCzUa8LFAYvN
 shhMNBNbbL6TfZiZFIb6rpvwTmTOEMwA==
X-Received: by 2002:a05:622a:6092:b0:517:7ef6:d78a with SMTP id
 d75a77b69052e-51795bbef7emr20703161cf.26.1780620511690; 
 Thu, 04 Jun 2026 17:48:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 ([144.49.247.127]) by smtp-relay.gmail.com with ESMTPS id
 d75a77b69052e-51775d2f4easm3120601cf.23.2026.06.04.17.48.31
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jun 2026 17:48:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ceba6ec0ccso12502996d6.1
 for <dev@dpdk.org>; Thu, 04 Jun 2026 17:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780620511; x=1781225311; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yPSPKKFRy+greGTV1uzmgItIYrhycwWMD4vaclmca24=;
 b=E1yMIATJnYR6OKi2JkJsRM9uSckcCZPiMxMyEfe5G3blwiwb8NEL7gsH2z1ih1t223
 asLY3p6l6Mg/vnZhOZfw4I6pgWD6kuG89Dw3jaWyMhE7uSeH4Ttg0YSywZ6TWCRTQSw1
 DPUepUtW2CsBfvZW214GbcGd0NGY+Z3V38D84=
X-Received: by 2002:ad4:524a:0:b0:8cc:f135:529e with SMTP id
 6a1803df08f44-8cee614a20bmr19964086d6.34.1780620511003; 
 Thu, 04 Jun 2026 17:48:31 -0700 (PDT)
X-Received: by 2002:ad4:524a:0:b0:8cc:f135:529e with SMTP id
 6a1803df08f44-8cee614a20bmr19963796d6.34.1780620510540; 
 Thu, 04 Jun 2026 17:48:30 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd0556c0sm67187396d6.25.2026.06.04.17.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 17:48:30 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Subject: [PATCH v2 3/5] net/bnxt: fix IOVA range check for external mbuf head
 node
Date: Thu,  4 Jun 2026 18:50:14 -0600
Message-ID: <20260605005016.2290160-4-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260605005016.2290160-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260603211341.2112344-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260605005016.2290160-1-Mohammad-Shuab.Siddique@broadcom.com>
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

