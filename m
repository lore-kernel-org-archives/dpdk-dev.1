Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDA9C624A4
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 13:54:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B3BF427E0;
	Thu,  3 Sep 2026 15:54:09 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id CE58E427BE
 for <dev@dpdk.org>; Thu,  3 Sep 2026 15:54:05 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B3C1D1A0075;
 Thu,  3 Sep 2026 15:54:05 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7D4911A005E;
 Thu,  3 Sep 2026 15:54:05 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 246A718000BA;
 Thu,  3 Sep 2026 21:54:03 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH 06/45] crypto/dpaa2_sec: add support for env variables
Date: Thu,  3 Sep 2026 19:23:14 +0530
Message-ID: <20260903135353.3358303-7-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
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

From: Gagandeep Singh <g.singh@nxp.com>

Allow driver configuration via environment variables as a fallback
when devargs are not provided. After processing devargs (or when
devargs are absent), check DRIVER_STRICT_ORDER and DRIVER_DUMP_MODE
environment variables to set en_loose_ordered and dpaa2_sec_dp_dump.

This lets users configure the driver without modifying EAL arguments,
useful in environments where command-line access is restricted.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c | 27 ++++++++++++++++++---
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index 0e4e67aa07..c54960820c 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -4379,25 +4379,44 @@ check_devargs_handler(const char *key, const char *value,
 static void
 dpaa2_sec_get_devargs(struct rte_cryptodev *cryptodev, const char *key)
 {
+	struct dpaa2_sec_dev_private *internals;
 	struct rte_kvargs *kvlist;
 	struct rte_devargs *devargs;
+	int ret;
+	char *env;
+
+	internals = cryptodev->data->dev_private;
 
 	devargs = cryptodev->device->devargs;
 	if (!devargs)
-		return;
+		goto env_set;
 
 	kvlist = rte_kvargs_parse(devargs->args, NULL);
 	if (!kvlist)
-		return;
+		goto env_set;
 
 	if (!rte_kvargs_count(kvlist, key)) {
 		rte_kvargs_free(kvlist);
-		return;
+		goto env_set;
 	}
 
-	rte_kvargs_process(kvlist, key,
+	ret = rte_kvargs_process(kvlist, key,
 			check_devargs_handler, (void *)cryptodev);
 	rte_kvargs_free(kvlist);
+	if (!ret)
+		return;
+
+env_set:
+	env = getenv(DRIVER_STRICT_ORDER);
+	if (env)
+		internals->en_loose_ordered = !atoi(env);
+
+	env = getenv(DRIVER_DUMP_MODE);
+	if (env) {
+		dpaa2_sec_dp_dump = atoi(env);
+		if (dpaa2_sec_dp_dump > DPAA2_SEC_DP_FULL_DUMP)
+			dpaa2_sec_dp_dump = DPAA2_SEC_DP_FULL_DUMP;
+	}
 }
 
 static int
-- 
2.43.0

