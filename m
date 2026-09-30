Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C4ACA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:49:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1007743036;
	Thu,  1 Oct 2026 00:44:44 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 461B142FED
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:40 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccda24afso3059561a91.3
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808279;
 x=1791413079; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CyBLBRZcKgl9mKeeNzJ3BAmbcm8OmCNXEsoJesWQlkI=;
 b=vIy5qCgsQE0zOWFeObb+2bmTyb/jlnF+gSxHPwbAGj0eHCg99MCI97KYcdIU0ptZu9
 vxHLa9OMScKppTPNZs/3MYkP8OBQGLpKHBPxRGTjioHRTe+pI10cukdDbLrAgqm3L/nP
 IngEnsk/yFiEkZ5I2uOu+0VoDI7bpmScvE+bwFVPGKUcsKXpB6TyXiGu1a94n+JWHNun
 U8+gY77Kbt173drSoBS7U6+75/5gzbgRzx9Tp4Bl/EVVEdwIDntLq3FPf+YNb4XFATZR
 DqFDiaf4zlGzgjOXAKXMHoqxrcJDXAh1FC9byRUsTEjqmzKF3+5Z9fU8YEX+BxcMY1Ib
 ZI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808279; x=1791413079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CyBLBRZcKgl9mKeeNzJ3BAmbcm8OmCNXEsoJesWQlkI=;
 b=Cp8HEO0+bjzHZ1J1tdVnIrHQYqZM/35rdDFXzLxvYPWnqT/DWVQI0/xhoUyACLuZOZ
 jEkQQu2JxiV4QOYrbQ5RR2HnDH3cEci/+yEBv6fHrCsfpY1ev5tZclMkS65BLFsPSQmF
 wO8QIawjgN5e271dJC4vBSfIsk2u0N8W8kaUofcQHQuLCryV+prlFCBRlNjp3vd6PfYZ
 K00VVASsKVGrAdTbAQsbsvV7rhT5MC4upo7rBbuC0jkecgMZ4EYQLs0g2YVJPzwqvWyQ
 7SK0RW6ifhT2lTeY2mz8/9eT/3zFUeaKXcjDpLR9INZUiqbBp0BmY/wQkS4eVipRr7/k
 H/4Q==
X-Gm-Message-State: AFq9FYIV4gNSOlcWShLAOKJEsSU8etlGfu7vhT39NMR0EruM0l/Hpsx4
 tMYSOpDhDtdGzogvjMJBtYXBBIMTaNvXo7nAprmzCY3LLpxS3awRXr+95m/LrYHIqc+6bF3VYU8
 v1q6bmAM=
X-Gm-Gg: AYBFou1qhd0IqAC1VNtrT2+k6MLF+m1E91IM2qAW3u0F0hlwdpA+YqH2HawFWb653/h
 2pi5FUjBRspfLi8yknguivV6qgstrQCH7cRArSUgZjXRAlcWZLfUjSzeZ/0KUZEGwbC7sCEVKe/
 9OkJyuMgJy6RZrREF/Myy2Q5cY/moJFHxdKRTN8cvBdF6757dcdTMI7Tgwz/S1y9TW9cTBTnVat
 ZNIp3GwplB5bM2rGHBn/aBfgAtoSuqPAjYoTEb9cwTi1dzKQNUANBJ2v29sTHOqfCuxOKH9XFlK
 WL53fOZ1FfNI8tZ96d70FYsKuUzSXjWlpgpAHhoJvcf5jfVVjpIwVcabgFvtIST1gfqR2kJYjoE
 ENA5Di3aDvggDcMLmwWIpQuLxCX1CYVDozcbAANTNHlRVEoniJxVn0EsdPQPWf4WH98p+kvH2Nr
 n0tYSsivxcCI77OqX7xnwGoHnCbhtZvRYeVtg5SY1Ftm1PENAM84srjPD+yGiyH2P0DdN80l7bT
 uV07y+D66F9xSr84tWd9eNYBWEeo29uy0eiyg==
X-Received: by 2002:a17:90b:4c4b:b0:3a2:590c:a85f with SMTP id
 98e67ed59e1d1-3a4d14e0552mr1156353a91.21.1790808279392; 
 Wed, 30 Sep 2026 15:44:39 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Ashwin Sekhar T K <asekhar@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Nawal Kishor <nkishor@marvell.com>
Subject: [PATCH v3 53/65] mempool/cnxk: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:41:11 -0700
Message-ID: <20260930224340.58580-54-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

Both handlers use atoi(), which cannot report an error, so a malformed
value is silently taken as zero. For max_pools that then gets clamped up
to the minimum, and for halo_ena zero is a valid setting, so neither was
rejected.

Since the handlers can now fail, propagate the rte_kvargs_process()
return value instead of discarding it.

halo_ena is a boolean, so drop its handler and use
rte_kvargs_handle_bool() on a bool. That also removes the store through
a uint8_t pointer into what the caller declared as a wider variable,
which only worked because the local was zeroed first and the host is
little endian. A bare "halo_ena" now enables it, and the usual
spellings are accepted.

Bugzilla ID: 2044
Fixes: 45abbfc836b1 ("mempool/cnxk: support HALO in mempool")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/mempool/cnxk/cnxk_mempool.c | 37 +++++++++++++----------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/mempool/cnxk/cnxk_mempool.c b/drivers/mempool/cnxk/cnxk_mempool.c
index 6939fccff4..e5f1b9491b 100644
--- a/drivers/mempool/cnxk/cnxk_mempool.c
+++ b/drivers/mempool/cnxk/cnxk_mempool.c
@@ -2,6 +2,7 @@
  * Copyright(C) 2021 Marvell.
  */
 
+#include <limits.h>
 #include <rte_atomic.h>
 #include <bus_pci_driver.h>
 #include <rte_common.h>
@@ -34,10 +35,14 @@ npa_aura_size_to_u32(uint8_t val)
 static int
 parse_max_pools_handler(const char *key, const char *value, void *extra_args)
 {
+	uint64_t val;
+
 	RTE_SET_USED(key);
-	uint32_t val;
 
-	val = rte_align32pow2(atoi(value));
+	if (rte_kvargs_to_uint(value, 0, INT_MAX, &val) < 0)
+		return -EINVAL;
+
+	val = rte_align32pow2(val);
 	if (val < npa_aura_size_to_u32(NPA_AURA_SZ_128))
 		val = 128;
 	if (val > npa_aura_size_to_u32(NPA_AURA_SZ_1M))
@@ -47,27 +52,14 @@ parse_max_pools_handler(const char *key, const char *value, void *extra_args)
 	return 0;
 }
 
-static int
-parse_halo_ena_handler(const char *key, const char *value, void *extra_args)
-{
-	RTE_SET_USED(key);
-	uint8_t val;
-
-	val = atoi(value);
-	if (val != 0 && val != 1)
-		return -EINVAL;
-
-	*(uint8_t *)extra_args = val;
-	return 0;
-}
-
 static int
 cnxk_mempool_plt_parse_devargs(struct rte_pci_device *pci_dev)
 {
 	uint32_t max_pools = npa_aura_size_to_u32(NPA_AURA_SZ_128);
 	struct rte_devargs *devargs = pci_dev->device.devargs;
 	struct rte_kvargs *kvlist;
-	uint32_t halo_ena = 0;
+	bool halo_ena = false;
+	int ret;
 
 	if (devargs == NULL)
 		goto null_devargs;
@@ -75,12 +67,15 @@ cnxk_mempool_plt_parse_devargs(struct rte_pci_device *pci_dev)
 	if (kvlist == NULL)
 		goto exit;
 
-	rte_kvargs_process(kvlist, CNXK_NPA_MAX_POOLS_PARAM,
-			   &parse_max_pools_handler, &max_pools);
-	rte_kvargs_process(kvlist, CNXK_NPA_HALO_ENA_PARAM,
-			   &parse_halo_ena_handler, &halo_ena);
+	ret = rte_kvargs_process(kvlist, CNXK_NPA_MAX_POOLS_PARAM,
+				 &parse_max_pools_handler, &max_pools);
+	ret |= rte_kvargs_process_opt(kvlist, CNXK_NPA_HALO_ENA_PARAM,
+				      rte_kvargs_handle_bool, &halo_ena);
 	rte_kvargs_free(kvlist);
 
+	if (ret != 0)
+		goto exit;
+
 null_devargs:
 	roc_idev_npa_maxpools_set(max_pools);
 	roc_idev_npa_halo_ena_set(halo_ena);
-- 
2.53.0

