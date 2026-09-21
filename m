Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4080AC982EA
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 02:21:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F7D940E25;
	Mon, 21 Sep 2026 04:21:24 +0200 (CEST)
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com
 [209.85.215.227])
 by mails.dpdk.org (Postfix) with ESMTP id 672A640E17
 for <dev@dpdk.org>; Mon, 21 Sep 2026 04:21:21 +0200 (CEST)
Received: by mail-pg1-f227.google.com with SMTP id
 41be03b00d2f7-cc1b838f9b6so622084a12.3
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789957280; x=1790562080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lkvk9DML5w5tN1dN6tdiEfUUy484CeYbDUvtdPQW2CA=;
 b=hZ9oWHMh3bTss/GNnnvzaBusDi3yAKI4FahLr+AjAL30fQEYxMFS9swN1jvvG4F3jm
 eYRS0BnOfcB9zkV3jPalorIj6Jg78Jh1M/J4bDkJk0j+WiND1Yin14n1t+Udgbp9rPJC
 jLHlaVS2and2X32QZsiQ1LBJLDLMRZupykU8555P0jW0hdaws5+RvYrpBzTGkzj5eocP
 U7bt4MXD1wTYcSqo+B+oQ6aWmEwvr8EuvQb4Fx3+kCGX6FLj4gSXjeWofcqmxlONWgtc
 e3xWRVvyvwzAA810lHwoqcGDVsNC0MI1WZvVov0WTOMZGcdx+LrHX4jy/Uv53fUkjXWK
 vHKg==
X-Gm-Message-State: AFuF++nZXquPO98as+sZYsL6+hZ5cV+jQ9KGLEYFcxkpHml+C03VzFjy
 xKBJxCqcJwwqzI3TVfamFzbrw+JBhgs1evk8ymbcIlCI7ayy0ROvGAabmmPzNdxqar+fDdRgn5R
 yPJ6vUO8FGwDSo9G9wlLgLVAiE5eQAqBHmQUPf7m//lG1H5pEnC9ubk8WB9fvmvmFnJew0fNHJ3
 /i0clesDtIgpI+kty50TykV+HhmIu7/yvaGyarlzUMRKa3+v1IbkbHQ4fuk4kI0zr6nmAKLxHeF
 0xN+b4aASXk
X-Gm-Gg: AYBFou3Hke0UIzJ+UkfehxxfbmeMUBgbVdywTdyOEbMAJSp+3PNjvVinPbqOt8Y/ZDv
 Dm05OGCIeHtdtMQ1CMCsQqrXZIZVaXzONSJgd8aqFBEJaLMk2NRCnDmZJCTwD7tIScySl3bBWTs
 573jsu87ggSkvACDCX/shtGhFJ1bDNrYcV0f8A+4ek7H/sKwLgVikmGpe9gn9RKrAxiDPkapLc2
 O8azMnu3YZMTac8fWDQWaMpa/1HZdFt7gPTg7p673m8ICejs2G5j51+XqIIZvP245uw8mHRuskG
 WXvBzZIzoX6Q3gUiCwtHhkFqFeyt+J0Z9Gu2Z0zqL7sl7HAGTs7dDjxqLQcZjFx03rUuWSkhYSN
 /BEYY/PJERb/EY/c6xSTJbqRqy6sw7R62YfBiKBLd+MYtaGaAwUEJw4AuapPPwjM5nWCikllyHw
 XFVg9vHPmbyKWUfVImqARhQyRwmOPoz+LIUAhZCOuWE/7o6M2ylQ==
X-Received: by 2002:a05:6a20:3d94:b0:3cd:61d5:f342 with SMTP id
 adf61e73a8af0-3dd8c3f15d4mr14282279637.9.1789957280387; 
 Sun, 20 Sep 2026 19:21:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-cc72acebdcdsm3042362a12.1.2026.09.20.19.21.19
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Sep 2026 19:21:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-398d0010cfaso4456995a91.3
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789957278; x=1790562078; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lkvk9DML5w5tN1dN6tdiEfUUy484CeYbDUvtdPQW2CA=;
 b=DJjcqMZrGem0o/oUxyWEJr8a4nZtGY8OerHx3LknC/1SCXTMcUaaqlcfcPv8MOetpJ
 rvQ/sNXGKSGwhl6jw+tS6/+c/EV49k7jQMLSl/BMz/A9TumErRzyyQlnzF8JEBq+NFP/
 yTiTkdmYD2j7AngCZHaveIwkLTMIiScrFOgH8=
X-Received: by 2002:a17:90b:2d87:b0:39d:e54c:8658 with SMTP id
 98e67ed59e1d1-39e54d8ecdemr21208628a91.5.1789957278513; 
 Sun, 20 Sep 2026 19:21:18 -0700 (PDT)
X-Received: by 2002:a17:90b:2d87:b0:39d:e54c:8658 with SMTP id
 98e67ed59e1d1-39e54d8ecdemr21208595a91.5.1789957277923; 
 Sun, 20 Sep 2026 19:21:17 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144d53968afsm16587294c88.0.2026.09.20.19.21.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 19:21:17 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, Joseph Wong <joseph.wong@broadcom.com>,
 stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2 1/5] net/bnxt: fix stack exhaustion in flow stats
Date: Sun, 20 Sep 2026 20:24:16 -0600
Message-ID: <20260921022420.1034071-2-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260921022420.1034071-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032752.763408-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260921022420.1034071-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Joseph Wong <joseph.wong@broadcom.com>

In bnxt_flow_stats_cnt(), two variable-length arrays are allocated
on the stack. These arrays are allocated merely to be used to
calculate the dimensions via RTE_DIM(). Replace with the
mathematical equivalent to avoid potential stack exhaustion.

Fixes: 1e2f8aca2cc1 ("net/bnxt: fix allocation of flow stat related structs")
Cc: stable@dpdk.org

Signed-off-by: Joseph Wong <joseph.wong@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_stats.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_stats.c b/drivers/net/bnxt/bnxt_stats.c
index ba858710a5..c4efcb4b17 100644
--- a/drivers/net/bnxt/bnxt_stats.c
+++ b/drivers/net/bnxt/bnxt_stats.c
@@ -1095,12 +1095,8 @@ int bnxt_flow_stats_cnt(struct bnxt *bp)
 {
 	if (bp->fw_cap & BNXT_FW_CAP_ADV_FLOW_COUNTERS &&
 	    bp->fw_cap & BNXT_FW_CAP_ADV_FLOW_MGMT &&
-	    BNXT_FLOW_XSTATS_EN(bp)) {
-		struct bnxt_xstats_name_off flow_bytes[bp->max_l2_ctx];
-		struct bnxt_xstats_name_off flow_pkts[bp->max_l2_ctx];
-
-		return RTE_DIM(flow_bytes) + RTE_DIM(flow_pkts);
-	}
+	    BNXT_FLOW_XSTATS_EN(bp))
+		return 2 * bp->max_l2_ctx;
 
 	return 0;
 }
-- 
2.47.3

