Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31827CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 04:16:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D5A840431;
	Wed,  3 Jun 2026 06:16:28 +0200 (CEST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 3CD12402AB
 for <dev@dpdk.org>; Wed,  3 Jun 2026 06:16:27 +0200 (CEST)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-490b613a17bso3502075e9.3
 for <dev@dpdk.org>; Tue, 02 Jun 2026 21:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780460187; x=1781064987; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7oj4pty3gmJa+H3k41jw33StPSTPnK2Z36fVM+xkJ40=;
 b=Umf58AZLMcq2hDfLJvhEkR2NvJzFpMDH0eKOZlM9Tg01fplkv6y1GrfhNaIORjr3n4
 t8x47H/hvUrfZmd0n3NN23zijAEnHK6WBP+MORaEMTkch+AwoAzdXDXeBH9ar/4+TOHT
 y5kgJL7djUMUmTODDR3H5KnjPcyKDRLbTobZijy7bP+gazPHmOS11eUxu+NvSAi8ZHxE
 RxfjDAzzevywiccwVTZQVmikAlljSRl+uyPDY6n/Qiuy/qh4nL21P8/GCOCr3PN8wq0j
 L5pyHBfhRZU1/dSwGSCAaNJIC0Bk/NRGHIq7Um7CnYV+3QT4S9t+rgF1wjtkD+xMCmFJ
 gNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780460187; x=1781064987;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7oj4pty3gmJa+H3k41jw33StPSTPnK2Z36fVM+xkJ40=;
 b=hkJSE0IQePZFD84G9wAkFYgKv308lXQDhpeRiCUf7cUmXeImKD3H+yWWFre4R5Zogz
 jwpadVQ7i7PYgID4ghRxlC4mHgvPyyVG200TLpjUlv2JEJX6GNO7l2K6rL2pml7hXz1q
 K2acFJNPzwkPy7bfVJjkydacsWbTS1tr9fICCmQ/NeOpUH+NXVPE37IWcp5pqWMpFTud
 EaCfb3eLk4sAZ3IeWn312GaTIVWKobX9HhjI3UE/S2X9OU0f3hvIoMI80QcHXjilXa47
 KlICe9lZbyKP7txbj3VZ0dqAEcVIKwJ7jaOSO6AtjtcZOCN3fKoMihJV0FnDwDx2Abik
 ZX+Q==
X-Gm-Message-State: AOJu0YwX6/y/plfkARautTeoGW7zY84SwoyAtgmJJKt4u+if2WO/c3cO
 QtjV1K2hTwA+YYQa+VIGFB24cegzSzL5YakSDIKjSYexGWbRyP3zrUn1UEa96Iry
X-Gm-Gg: Acq92OFna/ePYYJ5IxWb/5fCKNFKk2yG+kuCyEFoqcd+nYQxzEhWWv3n8mcbG0SJZes
 VaH6thMjoZMWANCtwCBsu/FRu88GGdjvig78wOz/PxuOfY8qbzNvH4TinN5eM4pvPEkll/AEZq9
 QCRqsiK5ONofTnfhI/5IQ+klAopYPZ+8lacdMW8uqfCeFULc2Ck5L6ArRzYFOrK16Ac5mGNdi6b
 fVgBz8dtz5yOFx63NHdDmVPk/zvmZNYgqqapNBwS5tVm0sAQWBTJZFQctkcpjHkgrFDR0OyXar3
 yvAQpoZ3cCLOuSjJwnHm65lxNgoVVQ4Wx+UNW8Un94WNNvWMDNTivKZuZ/5Qq0LO2eW1MgzQM4f
 ak5gnU7G/L2Orx4gHQcRRSp8KGlQr66ZqDrFm4KLJeO5+XSr0eyTynSzmpZ0PQscSYJfLAoxRFF
 iAYYuJrpKNLbBVg9PsK3AO5cgihcAA+rayjjnj8+SpFC54S5BsyoJlOFRd
X-Received: by 2002:a05:600c:810c:b0:48a:525b:e148 with SMTP id
 5b1f17b1804b1-490b5e7959emr22779735e9.4.1780460186792; 
 Tue, 02 Jun 2026 21:16:26 -0700 (PDT)
Received: from happy ([185.229.111.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b7a52d6bsm5636795e9.6.2026.06.02.21.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 21:16:26 -0700 (PDT)
From: Denis Sergeev <denserg.edu@gmail.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, ajit.khaparde@broadcom.com,
 stable@dpdk.org, sdl.dpdk@linuxtesting.org,
 Denis Sergeev <denserg.edu@gmail.com>
Subject: [PATCH] net/bnxt/tf_core: fix null deref on pool use allocation
Date: Wed,  3 Jun 2026 07:15:43 +0300
Message-ID: <20260603041557.115956-1-denserg.edu@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

rte_zmalloc() in cpm_insert_pool_id() can return NULL when memory is
exhausted. The return value was not checked before being dereferenced,
resulting in a crash.

Add a NULL check and return -ENOMEM on failure. Also propagate the
error in tfc_cpm_set_cmm_inst() which silently discarded the return
value of cpm_insert_pool_id(), and restore the pool state on failure.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 80317ff6adfd ("net/bnxt/tf_core: support Thor2")
Cc: stable@dpdk.org

Signed-off-by: Denis Sergeev <denserg.edu@gmail.com>
---
 drivers/net/bnxt/tf_core/v3/tfc_cpm.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/tf_core/v3/tfc_cpm.c b/drivers/net/bnxt/tf_core/v3/tfc_cpm.c
index f58ec48db7..28e2a3d8dd 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_cpm.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_cpm.c
@@ -92,6 +92,10 @@ static int cpm_insert_pool_id(struct tfc_cpm *cpm, uint16_t pool_id)
 
 	/* Alloc new entry */
 	new_pool_use = rte_zmalloc("tf", sizeof(struct cpm_pool_use), 0);
+	if (new_pool_use == NULL) {
+		PMD_DRV_LOG_LINE(ERR, "Failed to allocate pool_use entry");
+		return -ENOMEM;
+	}
 	new_pool_use->pool_id = pool_id;
 	new_pool_use->prev = NULL;
 	new_pool_use->next = NULL;
@@ -287,6 +291,7 @@ int tfc_cpm_get_pool_size(struct tfc_cpm *cpm, uint32_t *pool_sz_in_records)
 int tfc_cpm_set_cmm_inst(struct tfc_cpm *cpm, uint16_t pool_id, struct tfc_cmm *cmm)
 {
 	struct cpm_pool_entry *pool;
+	int rc;
 
 	if (cpm == NULL) {
 		PMD_DRV_LOG_LINE(ERR, "CPM is NULL");
@@ -313,7 +318,12 @@ int tfc_cpm_set_cmm_inst(struct tfc_cpm *cpm, uint16_t pool_id, struct tfc_cmm *
 		pool->valid = false;
 	} else {
 		pool->valid = true;
-		cpm_insert_pool_id(cpm, pool_id);
+		rc = cpm_insert_pool_id(cpm, pool_id);
+		if (rc) {
+			pool->cmm = NULL;
+			pool->valid = false;
+			return rc;
+		}
 	}
 
 	return 0;
-- 
2.50.1

