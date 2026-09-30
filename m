Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EF1CA5FC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:50:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 134BB4327E;
	Thu,  1 Oct 2026 00:44:51 +0200 (CEST)
Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com
 [74.125.227.166])
 by mails.dpdk.org (Postfix) with ESMTP id AA74242FFD
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:46 +0200 (CEST)
Received: by mail-pj2-f38.google.com with SMTP id
 98e67ed59e1d1-3a4c0da0145so807914a91.0
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808286;
 x=1791413086; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0lI3virqKF8YH11Zm1z5LNn3RKes4noW2zwn1rG7R2Y=;
 b=iAGL9pL/qkaJMzLX43US8sI1SFzMnzCmCHumNH3QHXYQoiHhm/vZL+6UFgxWrUwPAN
 2yx7ximLNViSZRpQ6B1G1+XW8IYI3oKIrnG5TlBWNls9SuMW5r/GmRq4VwDQj87SUa8B
 pHOPikHELmjWlvgcB4TQBuvGkA+8UtA+e3yT8T1QIfRPvfpEOwmV5n+yIhwuSxd7rHmq
 r8LYIc1s8Zd0U02GnK9dD9iFQfwsrtfC3OTdBVgdwQI7zOXUAHJYt+zCBuSzBgnyl/gQ
 kzf92W2ulIzYH7X79yMImDzoFuHRNiU282p4tNxjl2gBh+iuWXzgyIXDOdA20TBiztFL
 0xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808286; x=1791413086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0lI3virqKF8YH11Zm1z5LNn3RKes4noW2zwn1rG7R2Y=;
 b=ngmgxwJtvGRsUPKHrKh8ZIwlKRnVaUAz99mmu/HwhaX1EluNuJR5nFsewqyTht0Aw8
 6kxx9vGhTK3nDb5Io9PtkhfqZUz9ZaU9ylzG/1b2Wgg5AQlAjISPUIM1mBmro7RODOt1
 cIzqTO7BCauTy1sqcn1ZXNZKfHi+UpN84xtwSOM8CCEXb6w2icGi3Md7Y25LD8ZF/gfm
 EPizfmTGg5sTlSx9Uq8JQoTgJu7ihm+WrNEbV8XtoE/7DJF7Osc8YssVC2vzbMNYs7Et
 mu3NKCuZJORXf5sBtaJ1YoFdEr3bfzRFX5jcIB/uU+cKTpWeRURTREtCWygkGNuIld8a
 OJqQ==
X-Gm-Message-State: AFq9FYJ1N4tKjWwduVnGlALJLK/vNJ9Lo5cEPESH0p5m6kCjSdOI/F93
 0GfbO5L2IuDCKRT6FisP550L2rb91Dk+TKuo2Di7EzLqZgz3YldpcR1/rPLHuo3lBkj+FDqbZUu
 xAdi/fWk=
X-Gm-Gg: AYBFou3VPaWJ4PVf3ShXlmDT3SHkrQdy6Clj1S092L8AISaWDwVD8ZrYXOrOLnGrH/p
 uir0q2c1fwoTU97JX9PV8XH3D2WR4MLG6NG/pVURogtWAmJYPqL/JHOvaexHNO4c8AbLtfMwWLA
 1mlWeWUtS9O9ni4lSnxw/6VBtWAYVA3YjGBJkJelavaSDHKI3uvdg5IheAgeVf5S3JeQiaopLch
 tRTEXDzoG7jqtpl6xvwn7IW1C1nINSO72a+m3GpI2UH2ny7e7NMND+oEmLGIQ93MkGtWkmo3Mkx
 lgs38uGycywHkoSmNzntUdf1TnavO0mcd6xJTAB13H0D4kMFrtAPqVn9P016pEB8d3Rt036+yLI
 G0h1briB7b9yGrBpu4XCyNDOFPlTdrda5GaxKWJGpU9YKIT7s12DkgStYjdip2p1/MMmh54HFke
 xaT3zKtJW74c7EwNfhvzaZhnbPlRA8uhX9IpHTKFfNbTf9fgtlg53DxhrFPq1mTnGD0J9XDXSHc
 UDuu2M6wO+HupUyZfYJZaLnY6ImjYgvb5Szeg==
X-Received: by 2002:a17:90b:3ec2:b0:3a0:afc9:a51a with SMTP id
 98e67ed59e1d1-3a4d15064dcmr2270895a91.12.1790808285823; 
 Wed, 30 Sep 2026 15:44:45 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Xingui Yang <yangxingui@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v3 60/65] net/hns3: use kvargs hex helper for capability mask
Date: Wed, 30 Sep 2026 15:41:18 -0700
Message-ID: <20260930224340.58580-61-stephen@networkplumber.org>
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

hns3_parse_dev_caps_mask() does no validation whatsoever: strtoull() is
called with neither errno cleared nor the end pointer checked, so
"dev_caps_mask=junk" is silently taken as zero and "dev_caps_mask=-1"
wraps around to enable every capability.

The value is documented as a hexadecimal mask, so use
rte_kvargs_handle_hex64(), which reads it as hexadecimal with or without
a 0x prefix. The documented form "dev_caps_mask=0xF" is unchanged, and
so is a bare "F".

Note that hns3_parse_devargs() discards the rte_kvargs_process() return
value for every argument it parses, so a malformed mask is now reported
but still leaves the default of zero in place rather than failing probe.
Propagating those errors is a behaviour change per argument and is left
for a separate patch.

HNS3_CONVERT_TO_HEXADECIMAL loses its last user here, and
HNS3_CONVERT_TO_DECIMAL lost its own earlier in this series, so remove
both.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/hns3/hns3_common.c | 18 +-----------------
 drivers/net/hns3/hns3_common.h |  3 ---
 2 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/net/hns3/hns3_common.c b/drivers/net/hns3/hns3_common.c
index c21740ba5e..35cc3fca40 100644
--- a/drivers/net/hns3/hns3_common.c
+++ b/drivers/net/hns3/hns3_common.c
@@ -205,22 +205,6 @@ hns3_get_io_hint_func_name(uint32_t hint)
 	}
 }
 
-static int
-hns3_parse_dev_caps_mask(const char *key, const char *value, void *extra_args)
-{
-	uint64_t val;
-
-	RTE_SET_USED(key);
-
-	if (value == NULL || extra_args == NULL)
-		return 0;
-
-	val = strtoull(value, NULL, HNS3_CONVERT_TO_HEXADECIMAL);
-	*(uint64_t *)extra_args = val;
-
-	return 0;
-}
-
 static int
 hns3_parse_mbx_time_limit(const char *key, const char *value, void *extra_args)
 {
@@ -341,7 +325,7 @@ hns3_parse_devargs(struct rte_eth_dev *dev)
 	(void)rte_kvargs_process(kvlist, HNS3_DEVARG_TX_FUNC_HINT,
 			   &hns3_parse_io_hint_func, &tx_func_hint);
 	(void)rte_kvargs_process(kvlist, HNS3_DEVARG_DEV_CAPS_MASK,
-			   &hns3_parse_dev_caps_mask, &dev_caps_mask);
+			   rte_kvargs_handle_hex64, &dev_caps_mask);
 	(void)rte_kvargs_process(kvlist, HNS3_DEVARG_MBX_TIME_LIMIT_MS,
 			   &hns3_parse_mbx_time_limit, &mbx_time_limit_ms);
 	if (!hns->is_vf) {
diff --git a/drivers/net/hns3/hns3_common.h b/drivers/net/hns3/hns3_common.h
index 7b3f96b01a..967cde9e39 100644
--- a/drivers/net/hns3/hns3_common.h
+++ b/drivers/net/hns3/hns3_common.h
@@ -9,9 +9,6 @@
 
 #include "hns3_ethdev.h"
 
-#define HNS3_CONVERT_TO_DECIMAL 10
-#define HNS3_CONVERT_TO_HEXADECIMAL 16
-
 enum {
 	HNS3_IO_FUNC_HINT_NONE = 0,
 	HNS3_IO_FUNC_HINT_VEC,
-- 
2.53.0

