Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B13C88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:55:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B2E342E61;
	Mon, 14 Sep 2026 07:52:48 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 7436A42E5E
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:52:47 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccdaea76so661866a91.0
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365166;
 x=1789969966; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0lI3virqKF8YH11Zm1z5LNn3RKes4noW2zwn1rG7R2Y=;
 b=PDxWYu5O3/PUp/zeGZLxuA+EffsGec35Rk9ypYTUudj2TzyYziLbpRDgOx1S9zmaqQ
 0n6frdkfEIPmGz+xcbfA/X3+lFu4PiSegqpQWoymOZvG0Pion6qgEpmoMA3N3u5vnYQx
 jPGCLe3kC6mkEJBdaEPxfbg0Iys56vT6qLQRz42taRG3a3mQiYWOykAo2l+ZcT94tPqf
 r2yeGv0GYo6vuwRzd1jeqpQWdQ3QMTNvU/zJW3CNhXL6tbP+vFuZmM1exL7zTbsQvMrC
 HgdmjUU/nFEhFZ5R/TFP/xg5hnIoEBBxEHrlRREt2QZ01z/i2pwjcxmCUlUQaaRi6tX3
 78zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365166; x=1789969966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0lI3virqKF8YH11Zm1z5LNn3RKes4noW2zwn1rG7R2Y=;
 b=BrB/Phw87SrTmywNnjYLYZv0gau/Q5xxQFFF+4TO4HviGDIiSp1cHn4e7HGOjB+x+d
 HfOtoXub+NL71oZnnA3azfELcMC2YKV++Z+oJvqDbhUBrqxXJEnHU9q5fVWu93o+i7oM
 t1FfbAyizPoldisjCMyitWfRdUSIqSPJVzHufM2q4YQg/PgizcvQMJ3FYcB4PIhmvVkV
 ycoQ2CIMQnnVC0/EcbVv+PIFM00pA/vvBX9y5n63yYB0IJPq/qY2vDYCLMop8lW4kxfN
 MPAgc4ECFpjf5aq9OG8NjRZrsNFG4E91lqM4Ys6UTgYLhjc5Wu1SujhpGgwXG8SiPnfu
 iAFg==
X-Gm-Message-State: AFuF++lT4YhSTTlLhOJT1wat8EspePnQ9B0Zc6IQTSWbLt+7qScewmMh
 hwq/CPQJRmLy7ym7c3bdKZgDCSTwVmCdagoqu2zYSlbd1OmddzFyuDPK6/v1/eWg/g8eoqmc+3R
 UqPWw
X-Gm-Gg: AYBFou3N71zX8+4niv85Dyu129yO0/mn40x4eXPU74Y+VKYr4zGpcCT4tE20QrV5jhb
 +xGNJBjWa+76UTRfeHH1CMdFmwYqjivWlKLmxgYfx33hzypLH/TPcC8Oenvg7v7zMarKJSgkvwh
 hU2b+jqFiXR8sYwG6ixhmLPyfRoi4AjrXE0up8OgHxKfZFaLcl2DnCyoWXhJsEMm6oqb6OHzGhi
 lMMc7ZRAdup7cGTpUgK+x5GXSgpuMY2uUy/LiKz/gcTeSvbc48t6GcRyMmvtND4YjbRRL1P2JJB
 dBZJ9trjEcuyAsF8yTSktGfyFN7n9IKUMoadRuJjeHaDI4bwhDRZopW890wmEQa+kpSVMFcjY6b
 kNQhSLEd2bY/Ep2StXP8+5165UvUGFRHcq9a724C0a7zsNBcxWikE+ei9ixc+eZtjO5e4efhmYn
 9plRYvX/wAlYCBL62YCRDoei7qjHhoQtRwGjIAwasgWP9PNStktlwi7EzwYiWANCkt5coHZvRgK
 sXSpw2g2IuvtxURx8F9hBSDnqnv29S7Xj3zIQ==
X-Received: by 2002:a17:90a:e7c2:b0:38f:de94:bf34 with SMTP id
 98e67ed59e1d1-39dec497e11mr1211251a91.10.1789365166608; 
 Sun, 13 Sep 2026 22:52:46 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:52:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Xingui Yang <yangxingui@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 60/62] net/hns3: use kvargs hex helper for capability mask
Date: Sun, 13 Sep 2026 22:47:31 -0700
Message-ID: <20260914054912.755403-61-stephen@networkplumber.org>
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

