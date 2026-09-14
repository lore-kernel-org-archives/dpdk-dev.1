Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C531BC88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:52:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF97340A6C;
	Mon, 14 Sep 2026 07:50:58 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 205F740E1E
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:50:57 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-39647aa9d52so2806339a91.0
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365056;
 x=1789969856; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UlAIMzxrgBIO2EgmlKn4lM09o5Jb1wO+CAu1a0nsT90=;
 b=P1sHqgtAafMOily6M95fq7UveAm6vWNCWKHfkxZUUPpFIqQWk8SWF/Z1YjT6LaXSKJ
 LSU4M7GvaKE6RyjtPh3qhtjo4gX3RkoCxcR7zTnSAzRmrWxBM+wBbrc1JzLJ1sboS8Ny
 6Z9QhJS2lIw/Uboqkx6Gl2cOxz0qXz/rxqsG+ZU+m9FTZRiGwR4pekGPRA0Wsm5Hxea9
 GilkM/fJOpwi3GEyY6CUJkSapuYdPxVUkc7f2S2NnnF5Yz5T/xEUkTNU4wyvf1etCRoZ
 6nAkz0JTZ+Zf5nHzrBLlGPAoU+fla4Dr4u9R7yADkVgeUWr6k0huRRSZqnbEtr7e/kF2
 z+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365056; x=1789969856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UlAIMzxrgBIO2EgmlKn4lM09o5Jb1wO+CAu1a0nsT90=;
 b=B17dYq+YiaXBjBd5SVuJhja8BHD8Ko+C2/PwLu1aiTlxzcH32Ol8NmCiDpYztgdVpd
 Lz41eaBw2oVU8Ru+by/h7IGfg9y5d4Rh5F6cDuFOrjC9CHKZo6ETOIdo9rXDnFbwRqU2
 Fn0xPHHB+L4UwwyA5txNNp2gFESmdCA19bYpqVjEWmvN5nOhmYmeK2OCSnsZI8i3KJiV
 fraZ/WPXN9P61/lJiEF+vssFe8+nDmN0tfs3Jp3xtEHq3u+fzhYdRtAvGYReIbzMQShS
 tFqg5suN1RZQ8cKrJEWJgdLROKEW6bH538KV+Kae5pI7uLf3cOv8kq2NVDfdM/4GwUZS
 /AOA==
X-Gm-Message-State: AFuF++nWCPDcQuelWI7lKqcJzPt2a/wpYy6CDVUPE1/cgT1hfxzm6dTg
 Yx4nhurWB1/xcwPR0LxvyM+UP7zIcG3/sjZ41/9Q0ymjlWeM3f0cgd4IK8FDH1XyhSNxWtSOan7
 I2+vvQaE=
X-Gm-Gg: AYBFou0EJDp43rFtuyFjRr0OsZOYSXNae3326H5WHEMXwYs7ie1dgAOnlcBQ8FK7vo9
 ZaLDVdTX5y8pQbR10dJ0zxA2ugJk2+22R+V2r1fe84TWi5Fh+07/5b7qx4x+lZcavlfZDiFdKcu
 O/KfIZ+InIp0CiODWGsPxB1CgDcdPVG73TfThrvcTH+T7yCc2K0DDSOvU+fzdLLBFMXm3o1xe8/
 S+5xULV9rOfPD8/+kECivP1sKbUsiwv+RkrEq9ZPCqTt3fHPBBZ0AKpvRzxCavjBkWB6Ck02S/Y
 cPnOVjEOYppIqOJaW/cg0k1nI0bwl9JfSYwTTERW/m0Dz0G120JLdi3L1x2LES+iGouUovQusSD
 fgrvTq6AAQQhU8V3IPwJHEwblsLoCDXSjK8h0hDwHuQs9ieuqaHPKwUvip8Xu9prqJBfrjtR7BN
 IQzKAVeqmxgV5Mg0j1Uyk7t80QOQxr25WJaplKzTScNrvc0Ly8Ilbarhm4v7yogdZHXWvXtIhMm
 JsnxlO1puNAcxkDcBfZQDLUm3NHog4l0R3QDQ==
X-Received: by 2002:a17:90b:1c02:b0:398:ceed:b903 with SMTP id
 98e67ed59e1d1-39dd54df000mr6815454a91.11.1789365056139; 
 Sun, 13 Sep 2026 22:50:56 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:50:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Mingxia Liu <mingxia.liu@intel.com>
Subject: [PATCH 28/62] net/cpfl: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:46:59 -0700
Message-ID: <20260914054912.755403-29-stephen@networkplumber.org>
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

parse_bool() only tested errno for ERANGE and ignored the end pointer, so
"1junk" was accepted.

It also stored through an int pointer, but both device arguments are bool
fields, so parsing either wrote four bytes into a one byte object.

The handler did nothing beyond a range checked store of a boolean, so
drop it and pass rte_kvargs_handle_bool() directly, which stores a bool
and also accepts the usual spellings such as "on" and "true".

The booleans use rte_kvargs_process_opt(), so that a bare key with no
value enables the option.

Bugzilla ID: 2042
Fixes: 2d823ecd671c ("net/cpfl: support device initialization")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/cpfl/cpfl_ethdev.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index 4315adb68c..6e6401a9ce 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -3,6 +3,7 @@
  */
 
 #include <rte_atomic.h>
+#include <rte_kvargs.h>
 #include <rte_eal.h>
 #include <rte_ether.h>
 #include <rte_malloc.h>
@@ -1445,27 +1446,6 @@ parse_vport(const char *key, const char *value, void *args)
 	return 0;
 }
 
-static int
-parse_bool(const char *key, const char *value, void *args)
-{
-	int *i = args;
-	char *end;
-	int num;
-
-	errno = 0;
-
-	num = strtoul(value, &end, 10);
-
-	if (errno == ERANGE || (num != 0 && num != 1)) {
-		PMD_INIT_LOG(ERR, "invalid value:\"%s\" for key:\"%s\", value must be 0 or 1",
-			value, key);
-		return -EINVAL;
-	}
-
-	*i = num;
-	return 0;
-}
-
 static int
 enlist(uint16_t *list, uint16_t *len_list, const uint16_t max_list, uint16_t val)
 {
@@ -1643,12 +1623,12 @@ cpfl_parse_devargs(struct rte_pci_device *pci_dev, struct cpfl_adapter_ext *adap
 	if (ret != 0)
 		goto fail;
 
-	ret = rte_kvargs_process(kvlist, CPFL_TX_SINGLE_Q, &parse_bool,
+	ret = rte_kvargs_process_opt(kvlist, CPFL_TX_SINGLE_Q, rte_kvargs_handle_bool,
 				 &adapter->base.is_tx_singleq);
 	if (ret != 0)
 		goto fail;
 
-	ret = rte_kvargs_process(kvlist, CPFL_RX_SINGLE_Q, &parse_bool,
+	ret = rte_kvargs_process_opt(kvlist, CPFL_RX_SINGLE_Q, rte_kvargs_handle_bool,
 				 &adapter->base.is_rx_singleq);
 	if (ret != 0)
 		goto fail;
-- 
2.53.0

