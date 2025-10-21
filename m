Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABCDCCD1A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 17:53:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6627140E2D;
	Tue, 21 Oct 2025 19:52:41 +0200 (CEST)
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com
 [209.85.214.228])
 by mails.dpdk.org (Postfix) with ESMTP id 29E7A40E2D
 for <dev@dpdk.org>; Tue, 21 Oct 2025 19:52:39 +0200 (CEST)
Received: by mail-pl1-f228.google.com with SMTP id
 d9443c01a7336-27ee41e074dso69736625ad.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761069158; x=1761673958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3QDFoWFB+cEq9OUyywXDabkxOCbl/adbGvZIBIcM9Kc=;
 b=SGMo7wAwcguhSbgFErb4c0phaAjtc7/RP+kW75fpdTHY5MUXLHtXobzjQ2gfMZerhu
 59EOH84qCbutnGPA1XYbTZKVlZmb1K593HL+j4iK1HNh+YUg+Ntbo3nsROEikiDmUw1/
 TPScBnRU38S6nSEl/PScml3r6KEUi1g0lpigSkZtsrHI9pX/30AliHf8pAjkTlY+wN0s
 7v3DjtocLHlAF+glFkFeI6FxTpgYrBOPbxpvyzWUXxafU8vdovw68LOlJ1Z5HbS0Ez5O
 m27ydgLiX87SDo342FhTEXGBanvbPHVsK8oil8tzS8zzqIIuKQaPBl4CLkXrjAa0jDLU
 g/qg==
X-Gm-Message-State: AOJu0YzMqTCUOHXltrO76yDJLkTS5mUVNi2ue+Q7zr6m4aeTxslK199C
 PeO1keCMs+9DZn6JMCn2h/zxFhEDlMbh9bjgbMUu7CghUdQCRkH+CmiM2q81TraIGX+ZweUHh4C
 f4l7ewk5ZJumPlAz2N2BcSQE+FgzS+P55Ru7riRt1xH1yLGHGbDIRaVWZNAp/M4AAD+EiSvHjnO
 87vUW3HoX3pOM9NAiarIO1y5wdVXHEZdagNhJwW5kE4gg1GjEc0twPtqnk5WUeOp9LccNQYw==
X-Gm-Gg: ASbGnctupCIRIRxLrISQ398TxwwIy58H9ZaSYtMJXQWxS9NIKacTAkPIN+kBP3ly9oc
 GVeDqKgw3XwdUSHUTV5F2bc6iZTJDPXN2lLNQg8D7B3Y3/QgmFRHZEuQuasWOPil2nQJHhOaZ/M
 bRuJ/nN8qO5qZKD1lplu0Akl2r2H+6M9sps1T9vWC9P3oOjuYtLHaKNGKC41yEFg2D2qJhFI6xq
 Ed6wlMLVE5+bL7Awcj87ppTsJ9QqJWzPFS/pwr3SZZJ8MLGt8XMVkIfBDjrRBs/qcaNP/5Pk/v8
 XM9jAGFZT8VBj1G/aiTy+gaMYYoq1FpNk31RF6xEzs3pqLyB70qerJYdnLFvKyN/Q7uIp1nTEPl
 OYUEo701ZFeW+ZO6THt+0rru97DYEesNswgllY9WbAbx+JENqiiq0qeRPhyVLF9f+b8Uoj+9LFh
 dCvUMbHf18f5cYgvgRWjDO1kibXYO93AOD9Q==
X-Google-Smtp-Source: AGHT+IFUXaLxzXefbG4bGR3YUglX9ClIzljU/zKJXM4Eud8pQxjXBkL8Nvfz5jWzB/XAK6rh7ToMgaWHPtuK
X-Received: by 2002:a17:902:d483:b0:265:47:a7b0 with SMTP id
 d9443c01a7336-290c9c896a5mr209563295ad.10.1761069158311; 
 Tue, 21 Oct 2025 10:52:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-29247037189sm12871425ad.29.2025.10.21.10.52.37
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 10:52:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-27c62320f16so60862805ad.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761069156; x=1761673956; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3QDFoWFB+cEq9OUyywXDabkxOCbl/adbGvZIBIcM9Kc=;
 b=OIxHgBU1E6GpC5wMJlRWBIe2yhMlCULu/IkInPg9fAm7DyxuD2JdqdqeymTUBFf0DN
 qTSGQS1hV73D8U49Z3Gs+kP/iIZ9MD+8j5cUM06CIPN3xHXTVnSfbJjfRa/ymg+rsM0n
 v3s/ggFVcj7nN61DSth+XPxpdG7jxs0/6inL8=
X-Received: by 2002:a17:903:22c1:b0:278:704:d6d0 with SMTP id
 d9443c01a7336-290c9cb2666mr232159155ad.19.1761069156322; 
 Tue, 21 Oct 2025 10:52:36 -0700 (PDT)
X-Received: by 2002:a17:903:22c1:b0:278:704:d6d0 with SMTP id
 d9443c01a7336-290c9cb2666mr232158695ad.19.1761069155638; 
 Tue, 21 Oct 2025 10:52:35 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292472193c2sm115441495ad.104.2025.10.21.10.52.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 10:52:34 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Jay Ding <jay.ding@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH v4 17/57] next/bnxt/tf_ulp: truflow fixes for meter and
 mac_addr cache
Date: Tue, 21 Oct 2025 13:50:09 -0400
Message-Id: <20251021175049.46092-18-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021175049.46092-1-manish.kurup@broadcom.com>
References: <20251015090024.32250-1-manish.kurup@broadcom.com>
 <20251021175049.46092-1-manish.kurup@broadcom.com>
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

