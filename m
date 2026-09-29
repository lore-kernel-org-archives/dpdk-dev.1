Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EC2CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:44:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2572842F83;
	Tue, 29 Sep 2026 18:40:07 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id D980142EEC
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:54 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-85469d249c6so2784819b3a.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699934;
 x=1791304734; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CyBLBRZcKgl9mKeeNzJ3BAmbcm8OmCNXEsoJesWQlkI=;
 b=RYKZ2HaW9CQatDrw4qD4l5SZc3gx5ligO7QO+UYc5Gm3l0qaReq8soyj4W/unhhk8k
 EOLqo+2gzzVQ9Ukn/Uc8In4nFHk2hgWyW/GTdWNBc7lK8+ybvFMEovfTs+MLKNYzXygl
 2BoxA0jsmUTottJCECHqEZTt64HFcSdyqcLX5MHOYdhE1TcgBEBWawJvVFD1ZPWgI8cR
 KOdqpR+IiCFRkWQ2bpBJmo+AObFM/n3H7pOH7l252DY8mslsykZ2fHQ2Cd3K9wxoiegL
 4fnKBvdpOCG6OZigQldaQxZzD013F67FVZzoWFTerjr1N5wDXN+mgduiHgiSQy5DuENr
 qr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699934; x=1791304734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CyBLBRZcKgl9mKeeNzJ3BAmbcm8OmCNXEsoJesWQlkI=;
 b=0S4eOkhHAPw4LP3AjcJjjFlgEHUbeBEBpzimVF2hdXQ4NTbD9yvsluSOkONgLPCKPD
 yKVw116EIwP8BYRq29dfF17PJ26uertB5uJOhmruizsyO+WrxtG6N64KE98Ng2FHjGea
 /ThEMs9Vu8ems9OLQZGoGn03pN2wZJepvTsLRFC/aQ7chFIebw1EIDgubnh37h19qwXw
 VH1D3MBiOPvYzs7318HFAxBfckvFbnN+IzFG4HlIn9fRiIb4WniiOQagpU/RXdl8GB62
 PToKLMapMjDsVRiqaBXhpIo7HPr0246MKJuy+bHeD9x4KvmDosAU9pw4xtHGGQagUkgb
 dOew==
X-Gm-Message-State: AFuF++kGZIxtgKgNAIdS6YoVReiWEbN0+ToqTgdJbhNog5N369oDPFj/
 dR9lGiTdUl7fdg/Zt49lcqMXI07TAIgwLZkUkZLy8OoNa1OXAdQqiEzZdbCQGTB0aDZZ6jfA+a+
 mlsVjOn8wTA==
X-Gm-Gg: AYBFou2Jic0eEOQ3dSjsBFJGg3PPIDPaeEgn/HhbEIgXMbIZqCeRTy/dFaqdTMm8s2e
 CT0D4LELaujNS8hlMpEftzQYx0ewx8ccqxbmlLN5W4zmktCEVV0+7DlZYgFhu0bWvtiYdzKsHEc
 7DwyJRKMKbuXMqi6H5RELTzfCoRbJYpopu3bLyJYm8Rkp+0pyFsCsm+Pejo+YULYUfAp2WCKMp4
 1jgkpB5yOJb2TguoQmW/44a2j52TBWb1931/rUXMEQSoZEfXPz93YMw3nLd2X8fbfOxNg8r4Czs
 p5H3T7ZlEk5og8RxDsbIi8Q4+NUXIlgnRpiFhpu68r9/A4PLHFrN1f5y87tyPqdPIHgiyxNkp7G
 nXNiDIQN2WJaSsT9bBeq4fKapmQL8vUF3av7ndg9hWdgR5nY0jtQ9tRivaMkG4jwstcERIcCaJs
 StpFd2NIzPIqkaHlK2rNh1peOzXf4f/72CZvPceHNPLh6VdwHjFfK/gDhHlKBOqSoPZp1TFK02C
 DN2HygI6YPV0FdTmBJrF3GPxpDJXg38FiTzhw==
X-Received: by 2002:a05:6a21:468a:b0:3de:53ba:4081 with SMTP id
 adf61e73a8af0-3de53ba4234mr6618513637.47.1790699934056; 
 Tue, 29 Sep 2026 09:38:54 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Ashwin Sekhar T K <asekhar@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Nawal Kishor <nkishor@marvell.com>
Subject: [PATCH v2 52/61] mempool/cnxk: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:55 -0700
Message-ID: <20260929163800.1108305-53-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

