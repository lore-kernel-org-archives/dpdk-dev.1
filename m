Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD3DC5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:32:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE94940EDC;
	Fri, 21 Aug 2026 21:31:15 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id 109CB40E30
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:31:14 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-c9d1fff21edso1082489a12.1
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340673;
 x=1787945473; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+O0gLRbcCRioBQadTTL1u3Jhr+3ioo/OhtHcDkLPfcY=;
 b=vseXVVRhv0EmZpmzJBR0wLPwn1Golbo01Vu1ZqFIMAFJv80vS5IMNi+M1Yhg4TuChg
 +GzWLCQR2rxq/NXEcn6VQidQXKzFPmrWrvUNPRgowBK+8ZEk7YmXedkQ2MUUklBEhxW0
 gl3HFwYfBxO6BsC9J+f/RVkLEF1mR/Uun0/1R8084ehTNbBLFW2j2nJ3FfYNVbODzqbS
 CgSTmpWg06ZlSxEBWcey9lA0mMpAodYx2hkQQwp7P2jOkTPpYXAuM9tXAQVa1EsY9HVx
 jmhM7u+74A5xKMpovEVnuJolboiRi8xzmFI5ZeU2JTk6zBN7preTBqtn5j7RBD31596+
 0EzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340673; x=1787945473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+O0gLRbcCRioBQadTTL1u3Jhr+3ioo/OhtHcDkLPfcY=;
 b=OHoDxKYeL9n9gAeH9nBaKgtueGpTkdHNXIxneLWH5vJgZbtC44gewul6Q4I+z2pR9L
 mR5UQ8SIUoscCeQwOeIcZ2xw1sVrT/pRqGaBNVacsi5Zqj9YT4JcVF4MEi+2L+IUg/yv
 ir60DsLGdEZFwrQLfJ99Pv0mrFRfan32ctzlqFEFLu9pi8ZhG69eNk3x0HCfBRgkkfmm
 Nm5mEtkfZGT64trLrb1m3Yad2zWJhqJqLSNoobvAChn6WQpHZChf/Fma3fUGHFwhFD6U
 VnkgUEwVcwfx6ITmrb4RTUh1ZXQixotHR+aDmiXKkJ9GRSIFHkxRMVrT82GqaDuSaQe4
 U3PQ==
X-Gm-Message-State: AFuF++lqnn8zk556+gnxyBUH3oU9p6MkxiaoiyKa85aOfaLLrFBT6BZ7
 4cwZuxikZjkSCQ0QKjaP9O2Fb6STexYLkBmQerHgFENcqEsgOGqXOQ59jLSAVpGGVQ0LJrAvq6i
 NBkDIkUA=
X-Gm-Gg: AR+sD12MbPCK4cpv11DHJQ0odQB8R3vNwuqTh9hmgn4OxGY9nqGLXaxj0WHPaAJ0NLV
 E/h+mgc73ojLK9oWUKXnNtdkC3AbV+j7jqBxTblduA34ixv0u6PULDon3G9IRq/USnbAXV621Zp
 xsHB1GRW6UfoUrnR9F+HVthMDn5qy0nZIYTL66ap4v4OfsRFwcCE3rRbqlAsMP6pKOqIqI5dD4v
 hG/Mckv6U++N5QH3/IIP35oTN4aaKwxCd44OdFNyHHZiYGpLyejq5ktNTOUeB9mOvQOGorg43x8
 mBsrz+lW7WrUq3WazW6/NIN90yy45sGzmwMlbY0U0wcVkXz4QBc1eh5qMrUE9+KQhn8TA3iDqdp
 cfMCU/88prRPJDPb6D2+G8szqAKXmM0982b4me+34JIwKo08mptY2ZzL25Ds/0gos0M+PO4ph3o
 U+RfgS5ce82llqNDamWQ7oRinKe55KW3g7dlLiN3sGHvDHfIeutvaDkcQJzRCR9DbtWaUFZdgpI
 FEMl3B43onsnSQPURMy5q0mKfw=
X-Received: by 2002:a05:6a21:1583:b0:3c4:511e:26ab with SMTP id
 adf61e73a8af0-3cd2fdb9115mr17088580637.3.1787340673196; 
 Fri, 21 Aug 2026 12:31:13 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:31:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v2 56/68] drivers/mempool: use memcpy for fixed size data
Date: Fri, 21 Aug 2026 12:24:51 -0700
Message-ID: <20260821192646.146382-57-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

