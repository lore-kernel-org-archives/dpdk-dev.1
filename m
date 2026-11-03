Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CA160A2627
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nsF1up2j
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2BE542F3B;
	Tue,  3 Nov 2026 16:19:01 +0100 (CET)
Received: from mta1.migadu.com (out-92.mta1.migadu.com [95.215.58.92])
 by mails.dpdk.org (Postfix) with ESMTPS id BD78942F39
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:19:00 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=c1ZMKWslDEJuV95qBL+MCEMeJdzH31uBuyVY7KfbDzM=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719140; v=1; x=1794323940;
 b=nsF1up2jQlN6qWrHSdkpH4eMWEyZ2icCiURIB+t0Shf17I7a7O1OmVb6syikh41td0EdyX0F
 dPuHfY3T06hU++BFaIqvI6tN00R9wKsrXFf83CLWL43BNZGf3KNYRcHUOC0CGclCghdmliK7ysq
 Ibf4Akp+PLA3hZNagEhs8w4o=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 75793ee79dc0fc14;
 Tue, 03 Nov 2026 15:19:00 +0000
X-Mizu-Trace-ID: 75793ee79dc0fc14
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 164/227] raw/skeleton: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:02 +0800
Message-ID: <20261103145306.487255-165-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename socket_id parameters, internal structure fields, variables
and comments to the NUMA node terminology, and switch calls to
the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/raw/skeleton/skeleton_rawdev.c      | 10 +++++-----
 drivers/raw/skeleton/skeleton_rawdev_test.c | 14 +++++++-------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/raw/skeleton/skeleton_rawdev.c b/drivers/raw/skeleton/skeleton_rawdev.c
index 6e99d35536..b307d8aab3 100644
--- a/drivers/raw/skeleton/skeleton_rawdev.c
+++ b/drivers/raw/skeleton/skeleton_rawdev.c
@@ -573,7 +573,7 @@ static const struct rte_rawdev_ops skeleton_rawdev_ops = {
 static int
 skeleton_rawdev_create(const char *name,
 		       struct rte_vdev_device *vdev,
-		       int socket_id)
+		       int numa_id)
 {
 	int ret = 0, i;
 	struct rte_rawdev *rawdev = NULL;
@@ -587,7 +587,7 @@ skeleton_rawdev_create(const char *name,
 
 	/* Allocate device structure */
 	rawdev = rte_rawdev_pmd_allocate(name, sizeof(struct skeleton_rawdev),
-					 socket_id);
+					 numa_id);
 	if (rawdev == NULL) {
 		SKELETON_PMD_ERR("Unable to allocate rawdevice");
 		ret = -EINVAL;
@@ -729,12 +729,12 @@ skeleton_rawdev_probe(struct rte_vdev_device *vdev)
 		return -EINVAL;
 	}
 
-	SKELETON_PMD_INFO("Init %s on NUMA node %d", name, rte_socket_id());
+	SKELETON_PMD_INFO("Init %s on NUMA node %d", name, rte_numa_id());
 
 	selftest = skeldev_parse_vdev_args(vdev);
 	/* In case of invalid argument, selftest != 1; ignore other values */
 
-	ret = skeleton_rawdev_create(name, vdev, rte_socket_id());
+	ret = skeleton_rawdev_create(name, vdev, rte_numa_id());
 	if (ret >= 0) {
 		/* In case command line argument for 'selftest' was passed;
 		 * if invalid arguments were passed, execution continues but
@@ -760,7 +760,7 @@ skeleton_rawdev_remove(struct rte_vdev_device *vdev)
 	if (name == NULL)
 		return -1;
 
-	SKELETON_PMD_INFO("Closing %s on NUMA node %d", name, rte_socket_id());
+	SKELETON_PMD_INFO("Closing %s on NUMA node %d", name, rte_numa_id());
 
 	ret = skeleton_rawdev_destroy(name);
 	if (!ret)
diff --git a/drivers/raw/skeleton/skeleton_rawdev_test.c b/drivers/raw/skeleton/skeleton_rawdev_test.c
index 99765feb41..9bc808faaa 100644
--- a/drivers/raw/skeleton/skeleton_rawdev_test.c
+++ b/drivers/raw/skeleton/skeleton_rawdev_test.c
@@ -95,13 +95,13 @@ test_rawdev_get_dev_id(void)
 static int
 test_rawdev_socket_id(void)
 {
-	int socket_id;
-	socket_id = rte_rawdev_socket_id(test_dev_id);
-	RTE_TEST_ASSERT(socket_id != -EINVAL,
-			"Failed to get socket_id %d", socket_id);
-	socket_id = rte_rawdev_socket_id(RTE_RAWDEV_MAX_DEVS);
-	RTE_TEST_ASSERT(socket_id == -EINVAL,
-			"Expected -EINVAL %d", socket_id);
+	int numa_id;
+	numa_id = rte_rawdev_numa_id(test_dev_id);
+	RTE_TEST_ASSERT(numa_id != -EINVAL,
+			"Failed to get numa_id %d", numa_id);
+	numa_id = rte_rawdev_numa_id(RTE_RAWDEV_MAX_DEVS);
+	RTE_TEST_ASSERT(numa_id == -EINVAL,
+			"Expected -EINVAL %d", numa_id);
 
 	return TEST_SUCCESS;
 }
-- 
2.55.0

