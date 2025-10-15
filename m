Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EB0CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:03:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CA3E40DD6;
	Wed, 15 Oct 2025 11:03:57 +0200 (CEST)
Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com
 [209.85.221.227])
 by mails.dpdk.org (Postfix) with ESMTP id D7B4A40B94
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:03:55 +0200 (CEST)
Received: by mail-vk1-f227.google.com with SMTP id
 71dfb90a1353d-54bc2d1feb2so1789121e0c.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519035; x=1761123835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3QDFoWFB+cEq9OUyywXDabkxOCbl/adbGvZIBIcM9Kc=;
 b=itzytBPUc5xgsqoi/kssNRBrvFMJenTt55zQBle06vfia9KyeYk+tGPtvoBy4Bw/GG
 KfWcBK0mxLipLoTDtAz+vLfM6WlK0CAgmQeahAYf5jutYAYT4BFPFu70/5VaeqihyK78
 9LJuV5h0Jo9++VzWHPbYecGFaBD0QegSrWx0Rr7EPMitK/7Z8xuiVxRYxu1WdoVWD2Fp
 q0RiMyrWdPVGuC/5R21X7QHvPvLnSftpmGYYCtgVmQE6WI+BfGjrXwQNrQ8S9F9l8A74
 BsAPj+ftvarFTweW5Ay/IF8RgcHpz5xFV19GygY2by2jj/EpPHWNv3miIIHsaVw2rAN6
 v5eA==
X-Gm-Message-State: AOJu0YxwVZWacY2+jD3fLWzI05hGpzwyzG5yVYF9qf65Wt3b0zjJvfXg
 cA66S0as+4XYRG6VQH7K94ufFEYcryTqVIHGMSfiiqWFlkxWt//oO57NUUCd1TrIBuOOh48jrlh
 GKAv4NSwmrwjvclNA3p1tx59q1dW2hOVUkZJEuXA7Hpko3FuJPkNg+oohsOEnc9U0+7M9Hmreyi
 09iF8WVCyaS3rZpg3jCTJn9r83RiqSiFoR05i5pLg2YcmubQKoolz+OcRqmAx6BuZih8U/Gg==
X-Gm-Gg: ASbGncuRpAr/wrRhPb1i5ayMzg4GZt3t2m2htWnF82GNoKNt3sp1JrlawKHdBN1Z1L4
 Vrq7UohhmtOJSI0Yk07tBrO3/7WY4yNSUIkM0PJbIMKu826gSlu6oA5NYow70iQt61MgfUWkMcV
 IoArd+IWYroU689bWO5EHc8FYjttvFvpOPdWMLS8MHJUOoVKvTSQpWQIIzwnqppgCOwqXvduRRv
 prfc1exe9utNCYxaqQOZd9zictyR93bJRWMUjOZD6suks6oAmhHaNGHosTFajE8EMWjgphJATzN
 /PX8FCR/brvSaxSCqWGKwd+QARyQ+PCVVggn7nCaX+CCE8z1G9M+BEDuteGMT84fV/yA5jjFCOI
 AFhWNWrqcP0pVWw4GuwV9+Qa9WZ8kMkfuopIoiLGbCnTryIhl/8NXKdbKweM06eaD2GDbM9bY2y
 c=
X-Google-Smtp-Source: AGHT+IEQvQXbyOoznhJmVkB5de9U9y4PEL2ap9LtMYqffQ+XGsBSEtDX06rzUntbvTH1ELq1lYi9q4RTEGuu
X-Received: by 2002:a05:6122:1e04:b0:54a:a782:47c5 with SMTP id
 71dfb90a1353d-554b8c074d4mr9649913e0c.15.1760519035110; 
 Wed, 15 Oct 2025 02:03:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 71dfb90a1353d-554d7ef9daasm1712147e0c.2.2025.10.15.02.03.54
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:03:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b55443b4114so7619093a12.2
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519033; x=1761123833; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3QDFoWFB+cEq9OUyywXDabkxOCbl/adbGvZIBIcM9Kc=;
 b=ch4meaKx+E7uRNGa5RyCJzgDWQD1gJ+VCP25N+79UfUcticnXUmBViWGGLsZ2pZoLn
 46D2PunAw2vhGKJ1dVtD5eXKFZTrqjfzdpCSXyb5g58YzaxvVTH0n+GFXOfux3G1Em3w
 ca1vRHlK56BOnlO59xJm/Wl1wRyCum1ybc43c=
X-Received: by 2002:a05:6a20:7d9d:b0:303:8207:eb51 with SMTP id
 adf61e73a8af0-32da8462f4bmr37801886637.55.1760519032748; 
 Wed, 15 Oct 2025 02:03:52 -0700 (PDT)
X-Received: by 2002:a05:6a20:7d9d:b0:303:8207:eb51 with SMTP id
 adf61e73a8af0-32da8462f4bmr37801846637.55.1760519032161; 
 Wed, 15 Oct 2025 02:03:52 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.03.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:03:51 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Jay Ding <jay.ding@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH v3 14/54] next/bnxt/tf_ulp: truflow fixes for meter and
 mac_addr cache
Date: Wed, 15 Oct 2025 04:59:44 -0400
Message-Id: <20251015090024.32250-15-manish.kurup@broadcom.com>
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

