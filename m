Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9401C88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:54:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56D4E42DD6;
	Mon, 14 Sep 2026 07:52:25 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id 8CFE742DD5
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:52:23 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-398a5aad413so2818674a91.3
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365143;
 x=1789969943; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CyBLBRZcKgl9mKeeNzJ3BAmbcm8OmCNXEsoJesWQlkI=;
 b=J+Ai0RoVrAiHFTAKY+GCL5UaIUStbEfFsxMnpFL3aGaEcjqX7TAZ8AnHbPKK2v2viJ
 B5Cq2NAAQ51PIa/yOzqMc5uUBhDpENEq+BPZhRvJdwmcQsds9I2L3KQklAZoKqdR50FE
 UTIB+CBJXURyOmOEulOTvKifAU312SyGWgbln7XYaPS+YVJx5pqOWQyr111oGixtunwo
 2PJdf+EusRLwrp1zIJcv7mk043GeIZCn0cojIxf/+c9icgPgEI3c8KXoZ4MXCcKqbhT1
 BNEqdsEP5GYEfPbtXKybiiJiiTQL1zScacyNPib3c/fz1SKRZBiQc1lQ4Igz9W/DYNib
 YHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365143; x=1789969943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CyBLBRZcKgl9mKeeNzJ3BAmbcm8OmCNXEsoJesWQlkI=;
 b=eVx9xOg1LeYMv3WRaTlXsgf92X6LQXypN6toOKlcgRh4qRi9WzizOPJWgeK/yAqSNh
 sCY3Cc+RXe7Dqr0nFm45KNDiEesoBzfr4bsGSm/bnIMth5uPcuYsAiDZYSRQ0o1SgoZI
 VGFCESwIkRwKqHfsG03P6i/Kfduv7t6M3SHQjqT6He6zjYrd2gL7kL8rZ6msEDPSN5HJ
 1uC+T1aeY+ddnply19F8pvekMjGtpMs7bWJaHH5GW9H6F0WwaMoBTpqvUHt1J5gVGCGe
 Uhqb5c4s7DIeaRipXTewOVOkQoGNfgRHE5ZSMVfW+HIZQsBBDjT4/y4Vejf1U4s25CVO
 AF1Q==
X-Gm-Message-State: AFuF++nqqIqqnmM+sSv7HGhI/7QfCi3hEG5Xw4XO0qlFNLaUhw4yPoIv
 +2FgRTBLPJyJoBLD+MOwjECjStH+uX/l8uyqhe2Txiti3+tXEmxiw9OXsjIYhjHLaeDSrP2S3bd
 pW38lc+w=
X-Gm-Gg: AYBFou2JFkgHumd//PyFR4tNQpGjRSnsp0HzHKCT5nYBotzjnNRNPRd4YJPYWFGToLP
 PcpwVtGJWC0+RhbcrvycTmENBpgMJGyCXy61VUDgsRFTnj90eGWpSwWcORlCLNm/flV4xZIFSk+
 xsgzzj6m2JaaF36Q+J05IOcI3kawn/XxsbTnRlx0Rk61YZXq3ZUXaswduR7AcBLo/tLqMEobRpd
 mHim+LRTYijSTCYAQB05xCG487Oz2aki5jvjXXky6o7aWymzRCQPIL5HYAbv+stZUaVjR3BI7v8
 CkNS20BeYOh4rtR+Vff1oqSsC3JN03Xjw92rXvjT/t4g4WmZE7UYXdCmWb3aeKnBsEV2B4D45DA
 h3MxmPqzUHA1mU7FTygzVzGCeb3TNVCQAPEdhbYLTCgjEwb6/CB0GpDYeDfYCuQY/aqlHX8xFsC
 pK2tcV75Udn2IIWjgt9h9LzdNS5pLUAeznmWOYqspIasuI4CpHP2/POSfEfrVsLKI+cLaWJs3ui
 RRMT7XuG767LDiCRtpRcDhlxTFwDdPoeTg2q43/JEKHKBLZ
X-Received: by 2002:a17:90a:d2cf:b0:398:bf7e:b267 with SMTP id
 98e67ed59e1d1-39debf86d29mr2846832a91.2.1789365142685; 
 Sun, 13 Sep 2026 22:52:22 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:52:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Ashwin Sekhar T K <asekhar@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Nawal Kishor <nkishor@marvell.com>
Subject: [PATCH 53/62] mempool/cnxk: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:47:24 -0700
Message-ID: <20260914054912.755403-54-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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

