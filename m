Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE9AC982CD
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 15:21:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8570742E4F;
	Fri, 16 Jan 2026 16:21:04 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 2947B427CB
 for <dev@dpdk.org>; Fri, 16 Jan 2026 16:21:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1768576859;
 bh=UfwXKOwyYrO+QKbb3JF/JWCKG6cT631oH4q8NvMPC14=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DFSTduzk0YKReayxk1PFe2VbgkMs2qaMCLxuVheP0BQEaS18/yGgp4+dR5E0EbyZ7
 TtHyEpgcpNW2cuO2q6bDFqxpleKYeW4jDcAtDiMHFfLb4exRohGcB+AnwjLZynTdJ2
 W+uwC0wU6cyUtWTjWxhgFu8YzdHx/nJyoCVNkoSbW5G0z32vxnFElPUHyjNm5ouLEV
 ipzgzW6KyJLOmcAsH48jiM1k7xXdYlGOK/7p+aenbq0nkgJl+IWnZJFnLmv7lpZuEc
 T4iF0aM+qrgh1Qsc1K+wTS5jjC57fY7qbD37kLEWMf4aUoJ0DgnJIcqLKrIYlGqTtr
 ikqKJnSg4/xkA==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id ED73C1180080;
 Fri, 16 Jan 2026 16:20:59 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v3 3/6] net/nfb: update timestamp calculation to meaningful
 value
Date: Fri, 16 Jan 2026 16:20:54 +0100
Message-ID: <20260116152057.1456380-4-spinler@cesnet.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116152057.1456380-1-spinler@cesnet.cz>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260116152057.1456380-1-spinler@cesnet.cz>
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

