Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10679C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:27:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A09FD40E3B;
	Thu, 20 Aug 2026 07:26:08 +0200 (CEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 2B48440E3E
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:26:00 +0200 (CEST)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-38e07ebd263so1210296a91.1
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203559;
 x=1787808359; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+O0gLRbcCRioBQadTTL1u3Jhr+3ioo/OhtHcDkLPfcY=;
 b=GoaP2vZhIguUGbcHoMfWGytOkT6Yk4RJZ51Nz336ZqGPgh1kox+R/Y7p2fgDv3MtBZ
 iUHrt6sxxDfXhuNfsZrK8Js+CPmnx6zFCOXDO3EIXTXXZDZyWuf2sKSoqrL8PVmF5svW
 tQUGpjUGVZpXgEeLGl9qPfNk6JMjrtMCs/Wb/Wte/rXH5iHtMZkLkIXE7VIpq/yV1+xV
 f8limkammJtsGm+9AuAMN/7x8vu51kXL7hNcDLC+F4ri86XXyGto9mcpro4dGAkuXkW3
 xXn8/kWzIGQpkjQ3vv4GlLLvbORD8fveNVGnYdeE4SedoxuhLacEnPnlzz5KD2Zrcyd5
 eRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203559; x=1787808359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+O0gLRbcCRioBQadTTL1u3Jhr+3ioo/OhtHcDkLPfcY=;
 b=KSvTUdD5rOrtd4pxx4WU686V5n3L1ISq3FVknb18q+pBj8NGlfiZKWdqGV8Ilu72XZ
 d9sbLjf8/gQDJ4cokKSCSIYvEc7626DNQpk+K0PgIw8THpQBh4/uyAUJgLllZRCk0zyp
 LIlt+Z1WDm7npYqvY1rezx5WFudVuOKNoPJWud8wh5esGGrKso16nA6hTFdRlbRazGY2
 0hK3dTklg5p4XgfkcxJ7QqFQGp0PYf5pl8bvXaC1m8s6up5sCj4QtaPJY5DDeQOe2Ope
 0X56PsAjRi+imEjtRu0IRiehV4gKWWhXvherW0ydleBU5PfcSpCVlbrKOKBTs+MiZTWH
 emIA==
X-Gm-Message-State: AFuF++nmDWumGxsSqm6zpHi7r9fvj4guvSOJJSJFvpLl62SZ9YfTE5I/
 4TfQz4kjjms5d/vdEIEqupUJwVD/dTJ3OeMP/LpdV2RLZbNGjLpViBNccNhRqpUuAFC1iJD9e6X
 SLL8o
X-Gm-Gg: AR+sD12ulyWt3dYu989VdJRMmpjdz+AKQ6yd+IUgSdfjnzdd4NKwd8+S4RNuR6qU6qz
 wRMj0Kr4iukYGDsuu3UShFEIHZK2jwYsYJ45vVZFtud9UsZ/7RgyqFSP+ZRqtteAibAMPg0FG5r
 9RwK2JbWPACWpNRtp758R1JnVkrTdCGuXDhgyfHUYshDQKUaLr1uyJa1FGy+0uPJha3rkBMEy39
 1P8pKk1IH1lXEzcWV2hroGl76rOhMTIDx6GigGzQZ0jbk8ld2XF/Gv8Gr4Ozsw4acP/uG67bWDq
 kLvCGX7uF/sHXt3k+Vd1KCDpTmSHg68Nlc9GR75W1Mc8iIcy9RwlhWg7GJSpAyA4lDOxEyChdei
 tWxqC2Ufi0XW3osfPIo/WT91eW2jRU6U4ZS2pcb1pkDyimo3vqQy38acvIEJM0nEIJJeJPxjyrK
 sK93zcnwXmRn2ZQmV3D68KoZqQNFD9Wc1H+3C5q9YX/krbMivlcCla/sUFHKNJKx52ZFJjqGbLU
 ZPdgiFI+YDMyEtLdCkvjO+6oivPglneqZyXCw==
X-Received: by 2002:a17:90a:da90:b0:395:4de9:b30 with SMTP id
 98e67ed59e1d1-39580a9aed7mr19985491a91.5.1787203559294; 
 Wed, 19 Aug 2026 22:25:59 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:25:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 49/61] drivers/mempool: use memcpy for fixed size data
Date: Wed, 19 Aug 2026 22:12:39 -0700
Message-ID: <20260820052251.1453273-50-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

The regular libc memcpy is inline for fix sizes and has
better analysis coverage.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/mempool/dpaa/dpaa_mempool.c      | 4 ++--
 drivers/mempool/dpaa2/dpaa2_hw_mempool.c | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mempool/dpaa/dpaa_mempool.c b/drivers/mempool/dpaa/dpaa_mempool.c
index 2f8555a026..d041e09942 100644
--- a/drivers/mempool/dpaa/dpaa_mempool.c
+++ b/drivers/mempool/dpaa/dpaa_mempool.c
@@ -124,8 +124,8 @@ dpaa_mbuf_create_pool(struct rte_mempool *mp)
 		return -ENOMEM;
 	}
 
-	rte_memcpy(bp_info, (void *)&rte_dpaa_bpid_info[bpid],
-		   sizeof(struct dpaa_bp_info));
+	memcpy(bp_info, (void *)&rte_dpaa_bpid_info[bpid],
+	       sizeof(struct dpaa_bp_info));
 	mp->pool_data = (void *)bp_info;
 
 	DPAA_MEMPOOL_INFO("BMAN pool created for bpid =%d", bpid);
diff --git a/drivers/mempool/dpaa2/dpaa2_hw_mempool.c b/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
index ee001d8ce0..f20e8dbdee 100644
--- a/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
+++ b/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
@@ -17,7 +17,6 @@
 #include <rte_mbuf.h>
 #include <ethdev_driver.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_string_fns.h>
 #include <rte_cycles.h>
 #include <rte_kvargs.h>
@@ -143,8 +142,8 @@ rte_hw_mbuf_create_pool(struct rte_mempool *mp)
 	rte_dpaa2_bpid_info[bpid].bp_list = bp_list;
 	rte_dpaa2_bpid_info[bpid].bpid = bpid;
 
-	rte_memcpy(bp_info, (void *)&rte_dpaa2_bpid_info[bpid],
-		   sizeof(struct dpaa2_bp_info));
+	memcpy(bp_info, (void *)&rte_dpaa2_bpid_info[bpid],
+	       sizeof(struct dpaa2_bp_info));
 	mp->pool_data = (void *)bp_info;
 
 	DPAA2_MEMPOOL_DEBUG("BP List created for bpid =%d", dpbp_attr.bpid);
-- 
2.53.0

