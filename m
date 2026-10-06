Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755E4CA6001
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 15:11:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C69AA427AD;
	Tue,  6 Oct 2026 17:10:26 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 44CF14279B
 for <dev@dpdk.org>; Tue,  6 Oct 2026 17:10:22 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 28BA2200019;
 Tue,  6 Oct 2026 17:10:22 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F1B7E200002;
 Tue,  6 Oct 2026 17:10:21 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9ECD71800229;
 Tue,  6 Oct 2026 23:10:20 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v6-S2 09/13] net/dpaa2: add minimum key size support
Date: Tue,  6 Oct 2026 20:40:05 +0530
Message-ID: <20261006151009.3593348-10-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006151009.3593348-1-prashant.gupta_3@nxp.com>
References: <20261001073307.1125305-1-prashant.gupta_3@nxp.com>
 <20261006151009.3593348-1-prashant.gupta_3@nxp.com>
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
index b7b79929b4..f3bb2a858f 100644
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

