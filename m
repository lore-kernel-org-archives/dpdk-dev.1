Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6D9CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:05:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 902E440E1F;
	Wed, 15 Oct 2025 11:04:26 +0200 (CEST)
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com
 [209.85.128.227])
 by mails.dpdk.org (Postfix) with ESMTP id 382ED40E48
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:04:25 +0200 (CEST)
Received: by mail-yw1-f227.google.com with SMTP id
 00721157ae682-780fe73e339so8100077b3.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519064; x=1761123864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j3sxnLaXiWkXvG469e06v5H7cEbF5In/yjOTAzyItFM=;
 b=aZklLMyHycaHbCoUHBTLVcXrUiyExiBDQSfGvCxfn4Wtz83AWLTRtjVz86drMNNwRf
 ZosGOFnpTNHNrhOQ0Pp1lUjsBRwy9vVsqfndjytdp5CRhDWVK/3bJZ+FPBQtWnZKac0L
 woqVuAUm0kBTRVX2REzZaBmvjOwRu7ig3F798XNK82lG1bZs6St5RNvWY9LLs2TmTFRB
 pg+39VU/hnKwiWNj7gY3ZhDtySIkhHJFqCj7eoTW60yaE6WJ6yclvJ6vkIYekLCDBIZj
 sR+HpupshCjJHmFQbF9XQcXrHt+u0wcD7HDKlUOXpQKjXuR/Jcx139fa5q4GR0aM9qhz
 vB9w==
X-Gm-Message-State: AOJu0YwwUfsz7QHOxxvDHBYuiGzk1auA9ISAhHIPgxXa3t6VSQ2micPI
 868hoC7C14Z8TWB/iqh5atPVMPxdIYRJETBRFQoOtzixCn96xo3YRZOiUORaZl2LEGnrazyxecA
 9E0A+ogz9kkAdpLerlAjpKvOmL1CzPlfFQxJLQxWOyjoAGQ26ahIE9S4bxeTVAyaGckiEy4HlEH
 sn1kz8Fl5EB2HIJvYl1f170LLL6weLjw2PBVy0JgA+hSDJniahu+aOPA3318r91OM0NpCeLA==
X-Gm-Gg: ASbGnct/u0x2oH99xjDuufxyVj8IPyVTCFvtXQtWlelotVcL9No9ftwsZx4ExqE7y9c
 g8Z1d7pV9MvFJiGa61QnQwSVKvVQ1FP6QnvsOna/AsVgvoW+rQOuYUSxQw6eskNLCddRfDXfSgl
 X+3YxHqe37UruLQ16MsJ0q7FnSmD68SXmXVvE5D7aDS5z1LbYYcyOipvNdXU8ANLvf6fyvZzILW
 Bstw7skOUSLYwRuKNkwzbshKDw/hP9NHorYUttEc99k0VJTtJ9T+x0Mkevc3v0uRTV5c9SV9bRM
 QeFMMD/x7YgoJPzE7rvR357ufIi35gr/VoSr84lNvEGQDAJjf79KZ0p2ZcxAxF2HZULwIQpKlzR
 79TRGEtw3h6b4kSgTTBYl0YxZpsH3RTjdhBYZFBB2NZO/7t5php3S5afGkEG/x1CDXvtrSaiq51
 WuRg==
X-Google-Smtp-Source: AGHT+IE2fHGLCiuxoBzb4WztXNhlpui/+MfrEC0VPa9H9XLKavJvDmvZg+SM7A9Nol97NXEtmYYxB+B3OUju
X-Received: by 2002:a53:cf08:0:b0:636:2128:36e9 with SMTP id
 956f58d0204a3-63ccc4c0deamr19302695d50.15.1760519064419; 
 Wed, 15 Oct 2025 02:04:24 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-63cd9474428sm1006889d50.0.2025.10.15.02.04.24
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:04:24 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-78108268ea3so728229b3a.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519063; x=1761123863; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3sxnLaXiWkXvG469e06v5H7cEbF5In/yjOTAzyItFM=;
 b=JZu7EaxmpORC0aCEPi6ZymRnOypZ8Mtf1KQBY8bHonn1lu+dyb54SAwCtFr1bpJ20z
 hMmkvjGMbB3BGAHX5Sv8hWaURDssqveOR9Gw+U0yfrSVv+BPWQvxjW8Te+bxcNWe/PjJ
 xwymrWgLsFQA+S5b+kN6WOwX3wIixEcpGuyug=
X-Received: by 2002:a05:6a20:12d1:b0:2ce:67b2:3c41 with SMTP id
 adf61e73a8af0-32da8df0495mr36651028637.5.1760519062569; 
 Wed, 15 Oct 2025 02:04:22 -0700 (PDT)
X-Received: by 2002:a05:6a20:12d1:b0:2ce:67b2:3c41 with SMTP id
 adf61e73a8af0-32da8df0495mr36650981637.5.1760519061771; 
 Wed, 15 Oct 2025 02:04:21 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.04.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:04:21 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Shuanglin Wang <shuanglin.wang@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v3 24/54] net/bnxt/tf_core: fix build failure with flow scale
 option
Date: Wed, 15 Oct 2025 04:59:54 -0400
Message-Id: <20251015090024.32250-25-manish.kurup@broadcom.com>
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

