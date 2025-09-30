Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460B9CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:07:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5863740DDB;
	Tue, 30 Sep 2025 09:05:43 +0200 (CEST)
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com
 [209.85.219.97]) by mails.dpdk.org (Postfix) with ESMTP id 8B5CE402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:36:51 +0200 (CEST)
Received: by mail-qv1-f97.google.com with SMTP id
 6a1803df08f44-8209dfef9c7so34954576d6.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192611; x=1759797411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3QDFoWFB+cEq9OUyywXDabkxOCbl/adbGvZIBIcM9Kc=;
 b=RCMXzUTZf9QC6BqBCKj4xlIyLKMcpxsgLToUVGYC1KLFKXIHNZhZPpwhc6O+Me0dBu
 kt2f97nKfO0lN+a+Nm0M7ftq5R/gEYF41dtJXW2bkUgNX1wNR7z1Kb0QCWOb8shmAmzh
 GPII5/5Q1pm0aoSBMm8tTBsdviyV55OCT4CvfG02ru1H50MA5rrFm2YFEK3vnuz25rdO
 1gv9U+bFS+cJ4lTQuWR8lqY02q0PY0Bjz96NfMkMf8Yr3VoluriFZfjYe+eOUDq104/H
 v5x4s4wEl6hlb4iYkhJzpBtdlzmm/GKzBDHXc0JVkpGPFNFbVO1Jr/CoJIdNwDH4E+Zr
 J+tA==
X-Gm-Message-State: AOJu0YzIw5rTib/CHS0/3tT1yQZ7ZMwwWqIyLkPMbxU7eEl6tz3KPOLa
 O8wOIGcKZpFxliXn3L7zCOe9GRiGHQ3H7MzC61WjRzdu3wYa+SKSnYjoin4PWmswkCAu6NkCIhy
 69XIOO1Q5U2TvEMSuj/kbsk3sIbIW+HOoh8cOa5fYBQTTdDKOPIIjYLgVaqu9s+vTmacrUwx3wJ
 gWWjLdeIu6oea9oS67E27RbyYKtHCyl/e/CKIkkv2falbUHkL8ELY8B1Midp5KEppjPbFpHQ==
X-Gm-Gg: ASbGncuMs48ZrDofOZZ9Jl0PC8kKkqOEWikkRQiCoKrFg8/ObragnLZnkIuVoo/dwK+
 yBeNf0kRuQnzsBaGlZEUMbBJ6GQuNBP4VmUT6DfSmgeQET5J2YbQ081UYwAyrIkzzry0kGMKeDS
 soZ7uBbXkn6wxzkzMQ2zDMQo/TxndXXvapdjH6QvZioCevuZll8MZB5Vwmvtr2yc1+/UWK3hAVw
 ZQqnKneQTRxvqH7VrSfNMRxww0/azHHKPMSXYlYZ56HepKz+ASTHwK/JePaVonW7BIFlAAV48nY
 4c35vqKzgJs9wgPQMiBejLyeWMdIGp22gegJAFQ5UkVhsn6FpzzzKvUb6a8YU3DHJeAKgJ0TExK
 RaY+kn+rO6+u+QzLDRXdSAzyi8AoaqdyE9BeEQS94yIG2WFVb5MejIOUnkUeWFU12nvogoPa4Js
 eAEFcfN+w=
X-Google-Smtp-Source: AGHT+IGff56UY81ncYWG/+BR684km9IO0e4ncu8xwD+ksoZAT4aKIYt0rhr5V9JV9aYb7uLCNethexnGdN8Z
X-Received: by 2002:ad4:5584:0:b0:84d:5b71:8a99 with SMTP id
 6a1803df08f44-86993a4b0dfmr23569746d6.3.1759192610843; 
 Mon, 29 Sep 2025 17:36:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-8016eb3d9desm8962116d6.41.2025.09.29.17.36.50
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:36:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-78117c85670so2261917b3a.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192609; x=1759797409; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3QDFoWFB+cEq9OUyywXDabkxOCbl/adbGvZIBIcM9Kc=;
 b=dyisnHZrbD3JFvKoDqR6bMobJz0gEzMt6T/YZfIo/VznJs+vJsyyYcyZtz7ntDnIMj
 1YzJiSRMbxuDu+6Dd1eKVfQI9esSKK8IvW6Qhk/oAs9568ZuLhGZfXiNjMveXXkZrD/T
 Ia+wnvuxenV/jrXu/AFHGTKT0wo9j3TBZesys=
X-Received: by 2002:a05:6a21:6b11:b0:2be:8ead:1bec with SMTP id
 adf61e73a8af0-31770d5d1d0mr2635396637.24.1759192609377; 
 Mon, 29 Sep 2025 17:36:49 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b11:b0:2be:8ead:1bec with SMTP id
 adf61e73a8af0-31770d5d1d0mr2635368637.24.1759192608839; 
 Mon, 29 Sep 2025 17:36:48 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.36.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:36:48 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Jay Ding <jay.ding@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH 14/54] next/bnxt/tf_ulp: truflow fixes for meter and mac_addr
 cache
Date: Mon, 29 Sep 2025 20:35:24 -0400
Message-Id: <20250930003604.87108-15-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250930003604.87108-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:07 +0200
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

