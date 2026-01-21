Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFE5C44508
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 17:02:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BB6E42DD1;
	Wed, 21 Jan 2026 18:02:03 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 5503540261
 for <dev@dpdk.org>; Wed, 21 Jan 2026 18:01:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1769014918;
 bh=UfwXKOwyYrO+QKbb3JF/JWCKG6cT631oH4q8NvMPC14=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ll9VAZdbTcSFt5/yjqNgGIseB3FjM3HncXNSzmm9BxXtyjXWY0guzaoKymk+zpkRg
 OjFmAIv/2hZlXKevbVWfnBXM2kSWuiqsUI6wymlyWK8LH8hqq7+WIWI5D4acEeZXyI
 34WqLAI9wXa5I0aD9z68UXMLXR4gDkJBPIxsO3I632cVdl8b7B6228t5G2ftdyaZp2
 7Pcp95IFviol81FLPcQdKx16yjrN+BioDuDc7pXQJVWgDEGkOv7ObwDxXVDwx5gjlJ
 g1WScHEn/qKSFL1WMwMocEQhaJk7fYwFe/2RJLELlIhSOq/YWrDX7nG1PJ1J3iDoXj
 0qKmozAZRkyfw==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 2B3151180072;
 Wed, 21 Jan 2026 18:01:58 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v4 3/6] net/nfb: update timestamp calculation to meaningful
 value
Date: Wed, 21 Jan 2026 18:01:17 +0100
Message-ID: <20260121170120.268553-4-spinler@cesnet.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121170120.268553-1-spinler@cesnet.cz>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260121170120.268553-1-spinler@cesnet.cz>
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

From: Martin Spinler <spinler@cesnet.cz>

The resulting timestamp wasn't monotonically increasing value.

Now the timestamp is value in nanoseconds (Unix epoch).

Unfortunately there's currently no safe mechanism in nfb-framework
to get ticks from hardware to implement read_clock function.

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 doc/guides/nics/nfb.rst  |  6 ++----
 drivers/net/nfb/nfb_rx.h | 13 +++++++------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/doc/guides/nics/nfb.rst b/doc/guides/nics/nfb.rst
index 96aaf64440..a9b4049654 100644
--- a/doc/guides/nics/nfb.rst
+++ b/doc/guides/nics/nfb.rst
@@ -64,10 +64,8 @@ products). The standard `RTE_ETH_RX_OFFLOAD_TIMESTAMP` flag can be used for this
 When the timestamps are enabled, a timestamp validity flag is set in the MBUFs
 containing received frames and timestamp is inserted into the `rte_mbuf` struct.
 
-The timestamp is an `uint64_t` field. Its lower 32 bits represent *seconds* portion of the timestamp
-(number of seconds elapsed since 1.1.1970 00:00:00 UTC) and its higher 32 bits represent
-*nanosecond* portion of the timestamp (number of nanoseconds elapsed since the beginning of the
-second in the *seconds* portion.
+The timestamp is an `uint64_t` field and holds the number of nanoseconds
+elapsed since 1.1.1970 00:00:00 UTC.
 
 
 Using the NFB PMD
diff --git a/drivers/net/nfb/nfb_rx.h b/drivers/net/nfb/nfb_rx.h
index 12769841ae..67b3b00e2a 100644
--- a/drivers/net/nfb/nfb_rx.h
+++ b/drivers/net/nfb/nfb_rx.h
@@ -13,6 +13,7 @@
 #include <rte_mbuf.h>
 #include <rte_mbuf_dyn.h>
 #include <rte_ethdev.h>
+#include <rte_time.h>
 
 #include "nfb.h"
 
@@ -202,15 +203,15 @@ nfb_eth_ndp_rx(void *queue,
 			if (nfb_timestamp_dynfield_offset >= 0) {
 				rte_mbuf_timestamp_t timestamp;
 
-				/* nanoseconds */
-				timestamp =
-					rte_le_to_cpu_32(*((uint32_t *)
-					(packets[i].header + 4)));
-				timestamp <<= 32;
 				/* seconds */
-				timestamp |=
+				timestamp =
 					rte_le_to_cpu_32(*((uint32_t *)
 					(packets[i].header + 8)));
+				timestamp *= NSEC_PER_SEC;
+				/* nanoseconds */
+				timestamp +=
+					rte_le_to_cpu_32(*((uint32_t *)
+					(packets[i].header + 4)));
 				*nfb_timestamp_dynfield(mbuf) = timestamp;
 				mbuf->ol_flags |= nfb_timestamp_rx_dynflag;
 			}
-- 
2.52.0

