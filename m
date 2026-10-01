Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAC5CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 Oct 2026 07:34:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D29D42EB0;
	Thu,  1 Oct 2026 09:33:25 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id A980A42E82
 for <dev@dpdk.org>; Thu,  1 Oct 2026 09:33:22 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7D9AC1A0125;
 Thu,  1 Oct 2026 09:33:22 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4858B1A0120;
 Thu,  1 Oct 2026 09:33:22 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E3BD51800068;
 Thu,  1 Oct 2026 15:33:20 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v5-S2 09/13] net/dpaa2: add minimum key size support
Date: Thu,  1 Oct 2026 13:03:03 +0530
Message-ID: <20261001073307.1125305-10-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001073307.1125305-1-prashant.gupta_3@nxp.com>
References: <20260922095528.2469885-1-prashant.gupta_3@nxp.com>
 <20261001073307.1125305-1-prashant.gupta_3@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Hemant Agrawal <hemant.agrawal@nxp.com>

The default size for a QoS key is 24 bytes. If the key size is
smaller than the maximum, use the default (minimum) key size
instead of always returning the maximum size (56 bytes). This
allows smaller flow tables to be used when the extracted key
fits within the default size.

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_flow.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
index 45660df31a..2662c358e4 100644
--- a/drivers/net/dpaa2/dpaa2_flow.c
+++ b/drivers/net/dpaa2/dpaa2_flow.c
@@ -26,8 +26,11 @@
 static char *dpaa2_flow_control_log;
 static int dpaa2_sp_loaded = -1;
 
+/* Default size of a key */
+#define DPNI_DEFAULT_KEY_SIZE 24
+
 enum dpaa2_flow_entry_size {
-	DPAA2_FLOW_ENTRY_MIN_SIZE = (DPNI_MAX_KEY_SIZE / 2),
+	DPAA2_FLOW_ENTRY_MIN_SIZE = DPNI_DEFAULT_KEY_SIZE,
 	DPAA2_FLOW_ENTRY_MAX_SIZE = DPNI_MAX_KEY_SIZE
 };
 
@@ -4532,8 +4535,7 @@ dpaa2_flow_entry_size(uint16_t key_max_size)
 	if (key_max_size > DPAA2_FLOW_ENTRY_MIN_SIZE)
 		return DPAA2_FLOW_ENTRY_MAX_SIZE;
 
-	/* Current MC only support fixed entry size(56)*/
-	return DPAA2_FLOW_ENTRY_MAX_SIZE;
+	return DPAA2_FLOW_ENTRY_MIN_SIZE;
 }
 
 static inline int
-- 
2.43.0

