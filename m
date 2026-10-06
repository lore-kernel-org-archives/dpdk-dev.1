Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D86CA5FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 11:44:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 232FD410D3;
	Tue,  6 Oct 2026 13:43:58 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id AC43840A81
 for <dev@dpdk.org>; Tue,  6 Oct 2026 13:43:52 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8E8B91A01A1;
 Tue,  6 Oct 2026 13:43:52 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 59B4B1A019A;
 Tue,  6 Oct 2026 13:43:52 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D0BCE180006C;
 Tue,  6 Oct 2026 19:43:51 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org,
	gakhil@marvell.com
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v3 5/6] crypto/dpaa2_sec: add support for env variables
Date: Tue,  6 Oct 2026 17:13:45 +0530
Message-Id: <20261006114346.1229651-6-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261006114346.1229651-1-g.singh@nxp.com>
References: <20260930070809.1929564-1-g.singh@nxp.com>
 <20261006114346.1229651-1-g.singh@nxp.com>
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

Allow driver configuration via environment variables as a fallback
when devargs are not provided. After processing devargs (or when
devargs are absent), check DRIVER_STRICT_ORDER and DRIVER_DUMP_MODE
environment variables to set en_loose_ordered and dpaa2_sec_dp_dump.

This lets users configure the driver without modifying EAL arguments,
useful in environments where command-line access is restricted.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/cryptodevs/dpaa2_sec.rst         | 12 ++++++++-
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c | 27 ++++++++++++++++++---
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/doc/guides/cryptodevs/dpaa2_sec.rst b/doc/guides/cryptodevs/dpaa2_sec.rst
index f95c6282bb..925d3371bf 100644
--- a/doc/guides/cryptodevs/dpaa2_sec.rst
+++ b/doc/guides/cryptodevs/dpaa2_sec.rst
@@ -1,5 +1,5 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
-    Copyright 2016 NXP
+    Copyright 2016,2026 NXP
 
 
 
@@ -188,9 +188,19 @@ along with other useful debugging information like session, queue, descriptor
 data.
 e.g. ``fslmc:dpseci.1,drv_dump_mode=1``
 
+Alternatively, set the environment variable ``drv_dump_mode`` to the desired
+mode value. The environment variable is used as a fallback when the devarg is
+not provided, which is useful in production environments where modifying EAL
+command-line arguments is not practical.
+e.g. ``export drv_dump_mode=1``
+
 Enable strict ordering
 ----------------------
 
 Use dev arg option ``drv_strict_order=1`` to enable strict ordering.
 By default, loose ordering is set for ordered schedule type event.
 e.g. ``fslmc:dpseci.1,drv_strict_order=1``
+
+Alternatively, set the environment variable ``drv_strict_order=1`` to enable
+strict ordering without modifying EAL arguments.
+e.g. ``export drv_strict_order=1``
diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index 15152cc5a1..0ff54fb644 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -4366,25 +4366,44 @@ check_devargs_handler(const char *key, const char *value,
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
2.25.1

