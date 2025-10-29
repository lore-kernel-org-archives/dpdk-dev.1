Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F94CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:09:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D07140A6D;
	Wed, 29 Oct 2025 17:08:59 +0100 (CET)
Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com
 [209.85.221.226])
 by mails.dpdk.org (Postfix) with ESMTP id 5714440669
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:08:54 +0100 (CET)
Received: by mail-vk1-f226.google.com with SMTP id
 71dfb90a1353d-54aa4b86b09so11921e0c.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:08:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754134; x=1762358934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3QDFoWFB+cEq9OUyywXDabkxOCbl/adbGvZIBIcM9Kc=;
 b=queqrOxkqR3USINS0BRntuyHTIvxblzICaAIVO6Et6FksYlgiNGdqYsx8Qm42AcoQ9
 vhEUbmk51dHwgU/aBJGXk47WbIqUAv0DNMvhwzrfSYJA3FTnZvL2LZ/T6GYwU0f3WJxx
 4N/L2CY7qT3ghC/ArvkBvS9EOOHbiefxgoXzxLzhUJm3GPBxnvzet628IdyZUJlH0q5e
 csRtPtI6wO2CZOo0CN9bCShN1zJ3zhMNPi0qcj2pCI1ypUGIllOgkr7XyMS1FjlPTllv
 /lYKHB1W93mQM8XPoJncRjrTvkLTsNsV8DdTj7bVJQiVSeaKxJ0SUcxv/4fkaCcNOg1V
 KOzA==
X-Gm-Message-State: AOJu0YzFd4jSudEM7W0upv51lvCqA9qieLSIWs7GSnjQ7G3VoqTIF/ex
 XGhAucJJ8fNqMeo7hl6olg8QAZCuQc22EREVrvpvSgWuwTEiUp8yqj4vc2kOOYhHHZele8YiLxi
 y1540Efw7B0459YWYapJ7b1/l9TVWHJloFTxbV+7A/JmpFqSYgKbBeOEKI002Vq7UNcPkDFb/zJ
 VSEKeWIaGKTAt3VLR+lSY2NKHMbBfbrJVecfvyt6LaPeU/H5zk9Dgx9feMtSx2YuGTYIilDg==
X-Gm-Gg: ASbGncsrvIouiPfe7gzVpGGghfnijgKOwMgO2Es9Er212uHYE5iHIIpfv8U6IKqh070
 xtzPcTPw5t8dFS/feYOjB247PC62ChIPWYX0/fiFE9LqZLrUoZn37sCqpuULE43F1BnK49jwhFf
 by/Lf1lTFTzR4UFLnscCJnz6apJ50UqVVGGY++Y4QfKFF9OklxshapkVCA0KSEZo/Z80WQDR0yP
 n9UA7jjdwBL70uEw9XGxn2dDkv+tOyJVNGnA+qFYXSmCDZElBA3iA0tikKdGuV6EuqI5Q0Mu9kX
 lbu5LkcfLzkeSU0zR7aYTcRUw6sAmU5LXLKmuyBQKXxtB5ttinxqa2O5FpjARp5Hg02tQpknuxE
 TBzvo2XLfrcpNd7JUWZKC9AWv8iQt308lOMvrcpawlMNKAL0KGAuzLFknRjBnBdJLSIytrLFp8D
 u8ZoQo5RN8fTFSHiaZqWXhKOmDbqAH8XXm7nPg
X-Google-Smtp-Source: AGHT+IEN5syU+8Spx1tplnw/6gV3ZJA/XJxk/fv0OjjyCMt06XIrFkmy6vVr+IfyO9DOyhWk/MjHtYwPq/8N
X-Received: by 2002:a05:6122:341c:b0:544:8830:8e15 with SMTP id
 71dfb90a1353d-55814220495mr1119370e0c.12.1761754133456; 
 Wed, 29 Oct 2025 09:08:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 71dfb90a1353d-557ddab68bcsm1664027e0c.1.2025.10.29.09.08.53
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:08:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5569a2b4244so2840e0c.2
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754132; x=1762358932; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3QDFoWFB+cEq9OUyywXDabkxOCbl/adbGvZIBIcM9Kc=;
 b=Q2mLNHxDPEAHI70VE6IREVvYT6q+UCsUvIbr8TcOYjXm7NE0LpZKDpuKRv4StHSJ6d
 PjopmxrFa8IatDlV5JOhhwn3hC04P2ALXrtAZtqj5xz83D9WiGw+AuqeTrFbSuFy1ZVv
 63Rm0YjVIzsEPQR02UFP0SUJ5LUIkzH4OwaD8=
X-Received: by 2002:a05:6122:17a7:b0:54a:9e02:f9c2 with SMTP id
 71dfb90a1353d-55814145932mr1108571e0c.6.1761754132227; 
 Wed, 29 Oct 2025 09:08:52 -0700 (PDT)
X-Received: by 2002:a05:6122:17a7:b0:54a:9e02:f9c2 with SMTP id
 71dfb90a1353d-55814145932mr1108446e0c.6.1761754131030; 
 Wed, 29 Oct 2025 09:08:51 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.08.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:08:50 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Jay Ding <jay.ding@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH v5 17/57] next/bnxt/tf_ulp: meter and mac_addr cache cleanup
Date: Wed, 29 Oct 2025 12:06:32 -0400
Message-Id: <20251029160712.58519-18-manish.kurup@broadcom.com>
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

From: Jay Ding <jay.ding@broadcom.com>

1. Thor doesn't support meter stats. Add null pointer check on
   ulp_mapper_mtr_stats_hndl_del.
2. Increased the number of mac_addr_cache from 512 to 2048.
   Changed the data type in an error message.

Signed-off-by: Jay Ding <jay.ding@broadcom.com>
Reviewed-by: Shuanglin Wang <shuanglin.wang@broadcom.com>
Reviewed-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c | 10 ++++++++++
 drivers/net/bnxt/tf_ulp/ulp_gen_hash.c   |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c
index bc48e35c00..7f6a84e699 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c
@@ -598,6 +598,16 @@ bnxt_flow_mtr_destroy(struct rte_eth_dev *dev,
 	if (ret)
 		goto parse_error;
 
+	oper = ulp_mapper_data_oper_get(ulp_ctx);
+	if (!oper)
+		goto parse_error;
+
+	if (oper->ulp_mapper_mtr_stats_hndl_del) {
+		ret = oper->ulp_mapper_mtr_stats_hndl_del(mtr_id);
+		if (ret)
+			goto parse_error;
+	}
+
 	BNXT_DRV_DBG(DEBUG, "Bnxt flow meter %d is deleted\n", mtr_id);
 
 	return 0;
diff --git a/drivers/net/bnxt/tf_ulp/ulp_gen_hash.c b/drivers/net/bnxt/tf_ulp/ulp_gen_hash.c
index e8cb1a3784..74cdd5c1da 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_gen_hash.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_gen_hash.c
@@ -33,7 +33,7 @@ int32_t ulp_bit_alloc_list_alloc(struct bit_alloc_list *blist,
 		return 0;
 	}
 	jdx = (uint32_t)(bsize_64 * ULP_INDEX_BITMAP_SIZE);
-	BNXT_DRV_DBG(ERR, "bit allocator is full reached max:%x\n", jdx);
+	BNXT_DRV_DBG(ERR, "bit allocator is full reached max:%d\n", jdx);
 	return -1;
 }
 
-- 
2.39.5 (Apple Git-154)

