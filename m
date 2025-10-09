Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE7ECCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:16:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1140406B6;
	Fri, 10 Oct 2025 00:15:56 +0200 (CEST)
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com
 [209.85.214.226])
 by mails.dpdk.org (Postfix) with ESMTP id 3021440B98
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:15:55 +0200 (CEST)
Received: by mail-pl1-f226.google.com with SMTP id
 d9443c01a7336-2681660d604so17965545ad.0
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048154; x=1760652954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j3sxnLaXiWkXvG469e06v5H7cEbF5In/yjOTAzyItFM=;
 b=odwkaFPivi0iZw8mbNADhhWu+fJtpN3MDNtkgMoGckE72FfNw+95epLYTBeUQvsytd
 YkgKBoQiA2NE/aupaT/FNuNZSBSFQ1uoTgOvFSHlHu/BygKQhQ/3uCIYyohq4y1V3UGp
 VzEFsZ9p3ym4ojj1iKMfgp2SkvQy6LwICo0LToaxdaF2V2POA5N/nzKUWjlmnUKTOJkn
 muHNVBFQ0W8mfcVoSHEyJxA9nOLUleuBunFa7+fOa3bE8Qgt4L7lKe0eg5n6TySNu1uX
 hIdvbVIbCmhm0Lekzv8wZoeRpvZnEWjdRK20B0GL5xT5TPvtmbTFp09hscyW2O3LAFXO
 EhIg==
X-Gm-Message-State: AOJu0YwaU4h3NDCBEo2J+uHscJQpHuxe34jP4ZU9/AgXnw3WR8d0/8Jo
 jH+1pYbYGXXvoUvUHj9LizhA1bwWShstAcxHfqAMk/8Dx/MVRgMc5Xzr93AP6DOFjwBWOGjtYRN
 U/Wy0O8oqy7M0ytIPSW8HSFFvgDyi2jxltwi/YKmnuOIvEi4rOl6BMzHclaj7AWkWupK3NTBvyD
 gOInTfQBs9gy/c1buJwkTBjLbnzuMxmnmVH9af6tINYIKIUX6nzCoko0I0JYkYoyaNhMRHLA==
X-Gm-Gg: ASbGncuiyIyAzKFK2TnzmuDOAJJ1kUScZwPpbmkH6LITpJxJvERA8+aJRNlr9yf/uNt
 0Mmj6lXMRbk8pYujdnjduVMAu7xhX+keogU0KU9PfCzKvGFTf87R0mLblMJbhdx8oXC7CpvnOrV
 /R8zYgkThI7IfaN9wpGRNRPtlj/O+KydEkoLAGC8KvClCT3e3qFpNIky/rSkss4392yGD13B3E4
 5yn9zyoFSDi4GgIKtD2+IpZUCHPG1fY55IOTf+K/ah68m/lU25irY1ei+ZwmU/emhMC99HQKZKk
 AeC8LW6sgZoWekJNNgm2mV8+CnxRH+WKuRORGnlZfIIK4K4epw6ki9I+483iav+BYcUfonZTvOo
 EUwaaRcsfbGUFxYjOyrDoO/BK6TI5nDmpo2FeY4h4GT2+/n22VgiVEIanUZwuTWJupyh2gmmLpD
 6Ek3032ww=
X-Google-Smtp-Source: AGHT+IHq4Te1qU6JFNMy/XuFXbTJYECGcl405FhVuXUFYkJhTlNz0qq2oBXoaxJKkSctsDeH55cQDxESc1XJ
X-Received: by 2002:a17:903:9cb:b0:24c:a9c6:d193 with SMTP id
 d9443c01a7336-2902723c576mr113147435ad.18.1760048154117; 
 Thu, 09 Oct 2025 15:15:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-29034e23631sm3384275ad.25.2025.10.09.15.15.53
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:15:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-78e45d71f05so37134066d6.2
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048152; x=1760652952; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3sxnLaXiWkXvG469e06v5H7cEbF5In/yjOTAzyItFM=;
 b=gOVMPpOm/H9UaIZvD63w+1Fw6LaNcchjPygeP6SLZluqm4Rp6iU2gU4/98QAdVwe+6
 VPrzj+r/fz859cXIIxGLGT9+mZ6Seq3cRUcmkPyEBRZLk4zxk9POQyZMvG9lUVQM5Rj+
 xUaZ7X2stJplHx1lg3xDBCHVIcFzMkdoXygc4=
X-Received: by 2002:ad4:5aa4:0:b0:7c6:2778:2f8 with SMTP id
 6a1803df08f44-87b2efe7411mr122713726d6.47.1760048152411; 
 Thu, 09 Oct 2025 15:15:52 -0700 (PDT)
X-Received: by 2002:ad4:5aa4:0:b0:7c6:2778:2f8 with SMTP id
 6a1803df08f44-87b2efe7411mr122713476d6.47.1760048151804; 
 Thu, 09 Oct 2025 15:15:51 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.15.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:15:50 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Shuanglin Wang <shuanglin.wang@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v2 24/54] net/bnxt/tf_core: fix build failure with flow scale
 option
Date: Thu,  9 Oct 2025 18:10:59 -0400
Message-Id: <20251009221129.28256-25-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251009221129.28256-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
 <20251009221129.28256-1-manish.kurup@broadcom.com>
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

From: Shuanglin Wang <shuanglin.wang@broadcom.com>

Resolved the build failure when building dpdk with the extra c flag:
-DTF_FLOW_SCALE_QUERY. The issue is caused by the new debug code
in DPDK 24.11.

Signed-off-by: Shuanglin Wang <shuanglin.wang@broadcom.com>
Reviewed-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
---
 drivers/net/bnxt/tf_core/tf_resources.c     |  2 +-
 drivers/net/bnxt/tf_core/v3/tfc_resources.c | 12 +++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/tf_resources.c b/drivers/net/bnxt/tf_core/tf_resources.c
index b3174ba1af..3219d61cab 100644
--- a/drivers/net/bnxt/tf_core/tf_resources.c
+++ b/drivers/net/bnxt/tf_core/tf_resources.c
@@ -535,7 +535,7 @@ void tf_resc_usage_update_all(struct bnxt *bp)
 
 	tfp = bnxt_ulp_bp_tfp_get(bp, BNXT_ULP_SESSION_TYPE_DEFAULT);
 	if (!tfp || !tfp->session) {
-		BNXT_DRV_DBG(ERR, "Failed to get truflow or session pointer\n");
+		BNXT_DRV_DBG(ERR, "Failed to get truflow or session pointer");
 		return;
 	}
 
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_resources.c b/drivers/net/bnxt/tf_core/v3/tfc_resources.c
index 5fa6d113ca..44b7a0afcb 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_resources.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_resources.c
@@ -59,14 +59,16 @@ tfc_query_resc_usage(struct tfc *tfcp, enum cfa_dir dir)
 
 	rc = tfo_sid_get(tfcp->tfo, &sid);
 	if (rc) {
-		PMD_DRV_LOG_LINE(ERR, "Failed to retrieve SID, rc:%s\n",
-				 strerror(-rc));
+		PMD_DRV_LOG_LINE(ERR, "%s: Failed to retrieve SID, rc:%s",
+				 __func__, strerror(-rc));
 		return rc;
 	}
 	tfc_msg_resc_usage_query(tfcp, sid, dir, &data_size, &stats_info);
 	PMD_DRV_LOG_LINE(ERR,
-			 "dir:%s, %d - %d %d(1-slice) - %d %d(2-slices) - %d(4-slices) - %d(unused row) - %d(used_slices)\n",
-			 dir ? "TX" : "RX", stats_info.max_slices,
+			 "%s: dir:%s, %d - %d %d(1-slice) - %d %d(2-slices) - %d(4-slices) - %d(unused row) - %d(used_slices)",
+			 __func__,
+			 dir ? "TX" : "RX",
+			 stats_info.max_slices,
 			 stats_info.row_1_slice_p_used,
 			 stats_info.row_1_slice_f_used,
 			 stats_info.row_2_slice_p_used,
@@ -86,7 +88,7 @@ void tfc_resc_usage_query_all(struct bnxt *bp)
 
 	tfcp = bnxt_ulp_cntxt_tfcp_get(bp->ulp_ctx);
 	if (!tfcp) {
-		BNXT_DRV_DBG(ERR, "Failed to get truflow pointer\n");
+		BNXT_DRV_DBG(ERR, "Failed to get truflow pointer");
 		return;
 	}
 
-- 
2.39.5 (Apple Git-154)

