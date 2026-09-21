Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F433C982EA
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 02:17:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FFF540ED1;
	Mon, 21 Sep 2026 04:17:11 +0200 (CEST)
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com
 [209.85.215.228])
 by mails.dpdk.org (Postfix) with ESMTP id CE3AC40E17
 for <dev@dpdk.org>; Mon, 21 Sep 2026 04:17:05 +0200 (CEST)
Received: by mail-pg1-f228.google.com with SMTP id
 41be03b00d2f7-cc52c1b8286so1964406a12.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789957025; x=1790561825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XVyCJRGHMd48gNZ1JAF6/eKiGLLHFJo05fI3+RhCztM=;
 b=ofgbKNRXcVqGonq28DQ0FFFCbgU0aXA9a/o4NDCSCWxa32qD3PRbRMa2RcilZf9qR3
 wfMP8d2bmYv8BfW5glsx0RV84QWJ0Eic7OhC6q1MnSwaYry4GDgZGaFJvwPiUf6ArpAw
 H16mtPDo+5EA815Goc1dLQEBcM1OhgBiO18Q+4/IvUcQXxnH47tjT3bvy7ZLSYTtQPkm
 jTIEeTR69RYSZcDEc6mO/C34MTPhUWt9QRvqfHULW3WN3Cc5/v0AHFbTAYC9r6+Al9nC
 tNpQ6rv+y7lvqbi/xTvBBYwrLZdwDwaELTxfpLvoMhJKddI9UfVfDO1bGlUEgm1w77tM
 ODoA==
X-Gm-Message-State: AFuF++ncN1lZ0TzkBaxQ/9idv6fGsay1dlkkN1RDj/kkWjTUM/XoGph6
 vFigEtkbvL6N4uocPaXTDfi6JR61kR6JUsScPzqQljhN6HVjnL/1SciFqkugshQ35CuHgQ04d73
 uyeC58hazUfk3JAV3MCoyfrLOGcrI4JQevfX3I2GHQq57knYjD0A9UhL2xq/8a/H4pK3sSTp6x0
 zLrU/vZo/1b6cSID7XDnO+A6f2RKCD1Zu7XksdZL0r6iplUNREru2qozB1PKv7pMedeZIU+7cqe
 0XO3rFr3rAY
X-Gm-Gg: AYBFou18l7glY/kmd1vP0efYzFMtZl78PmuLRuDW+/jkX9h8jpDmx4hfe6+fFFBPJyb
 ZumF2YzY4KNLhMq0dMm9Wc2+QTTO4El3j6cusQadvGPmjv+GK+mAxAAtPJbhIA0JxCT6mW8BXEY
 uvPu9NEmB3AU0SnCd49KqFgoMohNFqZUaSF7urvPKeM/3No/8MRasaacEwuZUkHO7BFbEdByE3U
 q1ITKKOsnqqL3rSbL9GKpzHEWPdnBJ10rp8d5zydtgyQZ+r4klPB7rmBSnNAvTm5s/CCUoks0Rx
 uZwbvBd/FlbtgEK15G2Gqd2h9CC+Q0lEeu/gvClSLgGv4Mkt9jX1DeU3aUngvcr+Yz8smhkiK4H
 tB0ox+anBGpTwXDWzYwd0OjeYGf4zMK0VrcY2sognr4ur+W6uk8s2s7pplY3uxP79wc5RIa/LhC
 8Byx6+ts3dgDcsnNj9KkAfZFToXKRSWGNjO46jGfHrMglKMbgDlg==
X-Received: by 2002:a05:6a21:168c:b0:3dd:a196:ffd0 with SMTP id
 adf61e73a8af0-3dda19700admr6173111637.32.1789957024844; 
 Sun, 20 Sep 2026 19:17:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-cc72af2814fsm3180509a12.9.2026.09.20.19.17.04
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Sep 2026 19:17:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2dd667770efso35840895ad.0
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789957023; x=1790561823; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XVyCJRGHMd48gNZ1JAF6/eKiGLLHFJo05fI3+RhCztM=;
 b=DKegkwKU8dB4bWTsMvlhtGidBATnQFxymqm2jBu2UvzULpU46d4YNvF8HYksamlFSB
 IppNORBDp7PJeRcx8WcrTMCwiTRpFHQnwb9KozlPTAtMA/FmIe7yoUkelhsjForerXE3
 k12AXT+jpeEWezecro5s7K6Z8WPwQDpWwG8FA=
X-Received: by 2002:a17:903:198f:b0:2dd:7682:a981 with SMTP id
 d9443c01a7336-2dd9ca0c80cmr168221355ad.13.1789957023153; 
 Sun, 20 Sep 2026 19:17:03 -0700 (PDT)
X-Received: by 2002:a17:903:198f:b0:2dd:7682:a981 with SMTP id
 d9443c01a7336-2dd9ca0c80cmr168221105ad.13.1789957022551; 
 Sun, 20 Sep 2026 19:17:02 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c331d55cfsm18536753eec.30.2026.09.20.19.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 19:17:02 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2 4/5] net/bnxt: fix memory leak in VF VNIC query error path
Date: Sun, 20 Sep 2026 20:20:01 -0600
Message-ID: <20260921022002.1033815-5-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260921022002.1033815-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032726.763384-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260921022002.1033815-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

bnxt_hwrm_func_vf_vnic_query_and_config() allocates vnic_ids before
calling bnxt_hwrm_func_vf_vnic_query(), but returns without freeing it
when that call fails.

Free vnic_ids on the error path too.

Fixes: 49947a13ba9e ("net/bnxt: support Tx loopback, set VF MAC and queues drop")
Cc: stable@dpdk.org

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_hwrm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 99539d3705..dee35758e1 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -6280,8 +6280,10 @@ int bnxt_hwrm_func_vf_vnic_query_and_config(struct bnxt *bp, uint16_t vf,
 
 	num_vnic_ids = bnxt_hwrm_func_vf_vnic_query(bp, vf, vnic_ids);
 
-	if (num_vnic_ids < 0)
+	if (num_vnic_ids < 0) {
+		rte_free(vnic_ids);
 		return num_vnic_ids;
+	}
 
 	/* Retrieve VNIC, update bd_stall then update */
 
-- 
2.47.3

