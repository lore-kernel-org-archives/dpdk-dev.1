Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBDCC982D2
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 03:25:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D2E043287;
	Fri, 18 Sep 2026 05:24:52 +0200 (CEST)
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com
 [209.85.214.227])
 by mails.dpdk.org (Postfix) with ESMTP id 6532842FDD
 for <dev@dpdk.org>; Fri, 18 Sep 2026 05:24:50 +0200 (CEST)
Received: by mail-pl1-f227.google.com with SMTP id
 d9443c01a7336-2d6e954afbdso950555ad.2
 for <dev@dpdk.org>; Thu, 17 Sep 2026 20:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789701889; x=1790306689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lkvk9DML5w5tN1dN6tdiEfUUy484CeYbDUvtdPQW2CA=;
 b=RzaNtqvz65WXc1pqbE5SQsgXCqzukT1XFbxLDGU95eixgJEm6Edjm+jwMbdkSGfB32
 UyA8cblDI9p+f/wyLBnb+M5mU6CqZGlOnaC+17TuJeEbd9Z48F8za3JFNSB6pYKWEiCU
 w64mMdu/JiHlYMr45Q7LVX56sY3u3olUgLCpR5uX+94HUM1jspAzIJ8hD4A7Wj6oNxv+
 BtCsnZbX6aiV++b/6GChqEUXEKcic1wZ6QlLHMm0ThjDsbCEJh+y0P6Lufp1QHr25t1B
 rmVLBDg5ngEc9vywTbELit3QOiIxmvNSljIKGUwONDoUxww5Lx9L2PvHbTDLyu1q6MF2
 otHg==
X-Gm-Message-State: AFuF++n8kPxAvYil5R4eKTdVTKoIjijbAQokhbEu88JoYbRkJPe3YOG0
 GVyoJzQgcDpWP6zNNDjLQmDRFzOoqu+zSJZpYucmjNlwTw9Xf3dgyETly/JngcRtc+FL5glplnO
 Gk4ppDUn9HSfamzSpbCvkMDEJ/dQoa74M0yj0rMcjLYwT3e2AlP44nPGZZ8YwBuV9U4GC0HJ0vR
 GXm9WT9qqwtpqlSazBL5HQpvhTMrHZshmMX3ZrRH5FIciceJ+zMJHEcoVrGYhx9mlz7xpe2NN2V
 RA/pl4M8X+a
X-Gm-Gg: AYBFou25a0SiMWQCIb9oh3m8KEp7f5QTXR2jPm/7xutNi6CD9XSiUXPLqqfuzRp3Pfi
 YS5nlOnRtVDfeopzAaxrHTn0YcOdnnQfhJ7OrKvZ92W9cpj2RtTGUdRo+RZF9oLSyITzcku+aV+
 h++vjGw6Zdk0GwLPezmrwX7V71OvnzGk1TAjFXO2wV9WG6eLiSJyWWz3+BjD+j/RtuI5h9kHD3/
 JZF+7OJkkMhYSbhewtFYcdPF66KB4FeRvlIJP1wzbwe8zpXopp58WdhdwAns6OlGnlOu/z8XlnK
 kLQOAfTZLnNw0js2gVc8WwHnMg9Fkm6giLmBjWzla6WTK0MzlvqU3ZY7WXNwKhSQAYNTDCDJ38+
 xzjiLes6sgMqIrgE6AeWnGQl9i+26VOicqanr9vGmD1wQ+NNeWRlHiNYKwxS/j80Wqc0yqnNeaT
 xGZP7gfBUb0Gge0d1IyjuOa98N+vylgGdwZMVABdv/jLNLMUXF5Q==
X-Received: by 2002:a17:902:db0b:b0:2dd:3ddf:b87a with SMTP id
 d9443c01a7336-2ddb16d5a08mr26867595ad.0.1789701889385; 
 Thu, 17 Sep 2026 20:24:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2ddb75e0ba5sm114125ad.46.2026.09.17.20.24.48
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Sep 2026 20:24:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e8fee6af3so485010a91.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 20:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789701887; x=1790306687; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lkvk9DML5w5tN1dN6tdiEfUUy484CeYbDUvtdPQW2CA=;
 b=Ay+3KDMNsWceWoVroQnnIbwfGAentnKujDb0/Ku4UOfhtohIv/R9R08KveEqQ+C0Np
 C+m49q84U4mN6SH9wT5YI8G3SJlmtTx+8L7x1OQ3tIZUZ+2kHfZ0TMl6S6wgTdSlAVW8
 MPpjQvDFP48qHK+T8KF6R5JtCqT9gHA2wCH+A=
X-Received: by 2002:a17:90b:548d:b0:39e:1ec8:ee7b with SMTP id
 98e67ed59e1d1-39e54c88f2dmr2620512a91.7.1789701887503; 
 Thu, 17 Sep 2026 20:24:47 -0700 (PDT)
X-Received: by 2002:a17:90b:548d:b0:39e:1ec8:ee7b with SMTP id
 98e67ed59e1d1-39e54c88f2dmr2620458a91.7.1789701886954; 
 Thu, 17 Sep 2026 20:24:46 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c286d98c6sm537742eec.5.2026.09.17.20.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 20:24:46 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, Joseph Wong <joseph.wong@broadcom.com>,
 stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 1/5] net/bnxt: fix stack exhaustion in flow stats
Date: Thu, 17 Sep 2026 21:27:48 -0600
Message-ID: <20260918032752.763408-2-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918032752.763408-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032752.763408-1-Mohammad-Shuab.Siddique@broadcom.com>
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

