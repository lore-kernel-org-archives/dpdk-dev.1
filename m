Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC84CA5FAB
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 00:21:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 735D5410DF;
	Tue, 29 Sep 2026 02:21:38 +0200 (CEST)
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com
 [209.85.210.98]) by mails.dpdk.org (Postfix) with ESMTP id 784EA40EDB
 for <dev@dpdk.org>; Tue, 29 Sep 2026 02:21:34 +0200 (CEST)
Received: by mail-ot1-f98.google.com with SMTP id
 46e09a7af769-81b21e6c5faso619990a34.2
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641294; x=1791246094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Di4Z96BFaOqDqo4xu60x6h8XXgKPE6F4jz7QZuG3lW0=;
 b=I0pkS6rH4q2b3LyPZfjoJL9gKQ4qlEfESs3j2cHxDaZoABB3OOzSDKmmTVeHYAk4PT
 FQuzgDEZ/Ri4Z5P92so4WNoKCLi03+pOlXJnvTF0WjUB0SZ7ZRR3PCi3KGvEmt5XTqY7
 9UiBqZaCObY0aw44/pqJ021STf0dCna+4fW/mt7d28HNcIBbtQ2gIt5Y1aYtPNk1elFf
 AyUZQ636l1azKNMB6KYQRmFzNXyLja28fm9cmh5R/HNF0lH4yjjh8b8zluYqDONQogC4
 Ysw92AhnE92WP9k5Hqp6Q80uJu8uEY51MIEb+cQRSnT+IH9B+RVySPhfXGE/7JWf60Un
 9LcA==
X-Gm-Message-State: AFuF++lMSgdK5moqJAKCr45q6HXtQXFMAC8zrbcZmIwEnfox5yjl3Uzt
 Vn2jBG8HFfYBFQYoRW639Gnl8XiHnFRJiCfTHt0E0pC/H7qUiZI+oS2afku+72GO0v2RwT6KhGO
 0SQ3xLSR7g3LtTB32RImRhNCiBTg0RJx93MoPF4ekfgMi5AwtrUT0s9MpRc09flxyAuGvOg5hE9
 SvIWyGztseqWDh5AHQzhhIi8LNFjyAj/7h+/df4jLauYzRrszBwxtv+i3e1o7dqK1dP9TMwiUyG
 Ak4du7JExNX
X-Gm-Gg: AYBFou2RLa4p1SsDYaAa/MhNL4CDMJOD+kumZmQJhcW7uOepdC5uL5wQLjoku4RMkw5
 l6VC6z78v5cd0e95Usg4RB7cN/7qbe+ykS4XBMw9egTepEwHtZggIsaSNsuVaGefwrn9dLezJXB
 hPhEZ3ksd+5Oyo1CLMqwWXkuHTDNaIsvy6bR4WsKILi8LM211JUlnLthKTCp4IlXQ3BAoE78pwO
 pvffD9kJ3cAKB6q8Wy01r9qhFKgzcb2VvI8GTEV6+OCinhU6WOVls9JgmrFhhrkHSa7UzRFxvgB
 Mp8UM0Ib4ndsuVBAvSozhkqGp//vHB2qiGcqZfHUosqNjdF15BP/runWf2v5JmNwSZi/iLzOJKc
 x9Bv2l/dvCnvxd8i5/OIaPpj3Fq8kkeOcYfKvHAWqfnEhaJRSDy/Q9sqkekAd5jtC8WdbAlhCH9
 LZUXx9dlmsWp08W8e0XhcSzUZ0tKHwEa+nzLKcKzcnqXRIi5CJPaMc
X-Received: by 2002:a05:6830:2aa7:b0:81e:abb6:74a5 with SMTP id
 46e09a7af769-81eabb67718mr367830a34.7.1790641293653; 
 Mon, 28 Sep 2026 17:21:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 46e09a7af769-81d580e8808sm908676a34.4.2026.09.28.17.21.33
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2026 17:21:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93ae8e7e546so731159185a.1
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790641292; x=1791246092; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Di4Z96BFaOqDqo4xu60x6h8XXgKPE6F4jz7QZuG3lW0=;
 b=bEisppK4pgBrt1OQY5jc4MbL4KwGekTiVFZB9Rg999ngWOmX0PGsCfNBqlJCQeyOUF
 h9kxpaEfzWk0XxFU2kGmytn3+CylxdtvbCmMJqPMq+yhw8Un4D7Jco5R0z4R5r0Efx2C
 2aeQT/PtNyTiKWS1wRaY3EfF+PrzH2qhw81HA=
X-Received: by 2002:a05:620a:172a:b0:930:987d:9cd7 with SMTP id
 af79cd13be357-93c43b5b782mr2427237385a.11.1790641292490; 
 Mon, 28 Sep 2026 17:21:32 -0700 (PDT)
X-Received: by 2002:a05:620a:172a:b0:930:987d:9cd7 with SMTP id
 af79cd13be357-93c43b5b782mr2427233785a.11.1790641291934; 
 Mon, 28 Sep 2026 17:21:31 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c813a5ae6sm273808385a.13.2026.09.28.17.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:21:30 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, Joseph Wong <joseph.wong@broadcom.com>,
 stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v3 5/5] net/bnxt: fix VF info alloc error path memory leak
Date: Mon, 28 Sep 2026 18:24:24 -0600
Message-ID: <20260929002424.1208457-6-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929002424.1208457-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032726.763384-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260929002424.1208457-1-Mohammad-Shuab.Siddique@broadcom.com>
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

In bnxt_alloc_vf_info(), vf_info pointer needs to be assigned prior to
the nested allocation operations. If an error occurs during the nested
allocations, the cleanup function bnxt_free_vf_info() needs the vf_info
pointer to correctly free the resources.

Fixes: 01406837bf49 ("net/bnxt: fix VF info allocation")
Cc: stable@dpdk.org

Signed-off-by: Joseph Wong <joseph.wong@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_hwrm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index f6623693fd..3a94838e3b 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -1079,6 +1079,7 @@ static int bnxt_alloc_vf_info(struct bnxt *bp, uint16_t max_vfs)
 	}
 
 	bp->pf->max_vfs = max_vfs;
+	bp->pf->vf_info = vf_info;
 	for (i = 0; i < max_vfs; i++) {
 		vf_info[i].fid = bp->pf->first_vf_id + i;
 		vf_info[i].vlan_table = rte_zmalloc("VF VLAN table",
@@ -1100,8 +1101,6 @@ static int bnxt_alloc_vf_info(struct bnxt *bp, uint16_t max_vfs)
 		STAILQ_INIT(&vf_info[i].filter);
 	}
 
-	bp->pf->vf_info = vf_info;
-
 	return 0;
 err:
 	bnxt_free_vf_info(bp);
-- 
2.47.3

