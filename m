Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06512CA5FAB
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 00:22:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B9D4410F2;
	Tue, 29 Sep 2026 02:21:47 +0200 (CEST)
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com
 [209.85.216.99]) by mails.dpdk.org (Postfix) with ESMTP id 87C6941060
 for <dev@dpdk.org>; Tue, 29 Sep 2026 02:21:45 +0200 (CEST)
Received: by mail-pj1-f99.google.com with SMTP id
 98e67ed59e1d1-39b2ad862bdso1534771a91.2
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641304; x=1791246104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ntQ6XfndmqlMxtjU9PTu+EQCuhacEnoZt+Rcdjy3v0k=;
 b=bkDfajf805pVZ1iu9NoijzpJIrrJ0n/VmbqUKaB40JQU8Fr9qxc2wC5KozTgpS+eYG
 PhzrNEBwdt/J/09rGTNLU+L0oKG5c8C78wocukMx49uHZEagRCSFAsPOyKNKJ1Fluy0w
 WgN4LclL9oCGCa5W+2vd5LGT43GJNdhRYd9uMYa3f1bDx9wbnt4qiKoN7tL2xVlOMdjH
 W+kKlhychYIDii50yNypubE7pH973OxRtrF5wK/5AxwF5kfMDhQbWdQ5L7tkvSBle3FG
 hLyIFW/5Q+L0H0F42T1CG99DaRK77fxAnADnAoFtjR+1h8/C8mrZR6q/jYBQwZmxzRBY
 BDeA==
X-Gm-Message-State: AFq9FYIjYvzWkNikH5mIyAXjohwJXfiQmDnP9a1hPx2Cbnf3g+eSnaG/
 RR879NWVjq4bTqHdEnxHTBNqm2GwBkjmEWqQZs8ZG2iZpJuV45SaXYyFJ0XYEt8Br89hOX2N4im
 /JVfpsqE6YhKcF40Hd1/RMiQ6L5H422k+BuRNoN8dE6RNK9/UY1Xc/8/+UK4WB0DeywYpoJN3Rx
 0eQOZp4p8UE5cxWRtQ9uDheS9Ei2Dhi3xBzUP49XiqBaXJAB+6952//843xsuQy7XFix/gBvaVD
 Sw9UDA5QNzz
X-Gm-Gg: AYBFou0vS6Zav2XX1PCLrhEPK+San/66elASbfkNVtBpzNTSeVUdqUpZGYoyxcjyG5f
 boWAX8NeqNyN7VcfcNymYOKc0VwmgfcBSLsUaSM5YDjDOaBOh6wDHaUTyM+zAWhmRY0lKXPyEiE
 REZigGx3iCy/wcq9O0P5/dNhZZDeH80tGMyuII39r+ercOwfjdqnSEAub31Jdd1RI5t5Dt6SFbs
 y6hygDZ0fANWZ9QJn0nd8Ov+g37zXxBYU/PN+yInDkOJG5JMYD8WI8vJKjExvxANM1q1NJ4JwSr
 9Djj4isc9obv/9zh8ZO/dY2jSbJ06K9fl+E/WGs0NjAkP1Zgk/oCtDw2p5rl9qKudZu4Ffd35PV
 iyXx8LRT8zOnNwo4z/LqjmWIENd/Q2d0lJgRSQr+lrc3m5qJg96+83sIWmxXaEYjItAm/bdRGSE
 0/TiJbWZsMPkhlwjuoZrFgYcr6haMonVB8N4H94TvCIZcsIShK7g==
X-Received: by 2002:a17:90b:2681:b0:3a0:cc33:22b4 with SMTP id
 98e67ed59e1d1-3a0cc332593mr7804755a91.52.1790641304483; 
 Mon, 28 Sep 2026 17:21:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-cc7877bc2f9sm7542959a12.10.2026.09.28.17.21.44
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2026 17:21:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91430af782dso82274366d6.2
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790641303; x=1791246103; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ntQ6XfndmqlMxtjU9PTu+EQCuhacEnoZt+Rcdjy3v0k=;
 b=htx4oadwnbSGQUOZew0gUsBW5rFdId6MnsYufGvWM/uUDA1txO65CweH5D+4OwrHMw
 glliQFhiV2ud7AvnIh/O+iUVhWxW9XYDvGBuwkZZXR1BPb2dfNm6rC6pS+RlfvQ+WZUn
 coJqSHTDJa2XBuxw8rVob8R2OiUQH9Mrn3Qa0=
X-Received: by 2002:a05:6214:3b87:b0:912:517b:40e2 with SMTP id
 6a1803df08f44-9142f8f8ffbmr229658476d6.41.1790641303319; 
 Mon, 28 Sep 2026 17:21:43 -0700 (PDT)
X-Received: by 2002:a05:6214:3b87:b0:912:517b:40e2 with SMTP id
 6a1803df08f44-9142f8f8ffbmr229658216d6.41.1790641302825; 
 Mon, 28 Sep 2026 17:21:42 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91430e0f78csm91234246d6.32.2026.09.28.17.21.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:21:41 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, Joseph Wong <joseph.wong@broadcom.com>,
 stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v3 1/5] net/bnxt: fix stack exhaustion in flow stats
Date: Mon, 28 Sep 2026 18:24:38 -0600
Message-ID: <20260929002442.1208481-2-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929002442.1208481-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032752.763408-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260929002442.1208481-1-Mohammad-Shuab.Siddique@broadcom.com>
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
index 37b33f0505..4074613eb0 100644
--- a/drivers/net/bnxt/bnxt_stats.c
+++ b/drivers/net/bnxt/bnxt_stats.c
@@ -1079,12 +1079,8 @@ int bnxt_flow_stats_cnt(struct bnxt *bp)
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

