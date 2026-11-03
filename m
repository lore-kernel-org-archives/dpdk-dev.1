Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B56A606B277
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Hj7YCN3e
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A914F42F08;
	Tue,  3 Nov 2026 16:17:41 +0100 (CET)
Received: from mta1.migadu.com (out-30.mta1.migadu.com [95.215.58.30])
 by mails.dpdk.org (Postfix) with ESMTPS id 57585427C7
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:17:40 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=h5jFOhy7a3xWZs4dHy15ezhZor3g3zuFV//ucx/G/BU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719060; v=1; x=1794323860;
 b=Hj7YCN3ehODsTCeE7MqEyuOQlQqel2KbuyGH4mKNDpsj90hpA/FC3eNOaXAj3QBBUHQmm1yj
 22pKgBsaARhIq9HbxgpzaHrPIW51r5imiAmdAuU9Z2ubE+I2hM0u5CxRjEFGgTAeGKUyMRaBxCp
 e0onoMZXSbs5MHiEHfjsdL5Y=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id cb8ea8750e40662a;
 Tue, 03 Nov 2026 15:17:40 +0000
X-Mizu-Trace-ID: cb8ea8750e40662a
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 158/227] raw/cnxk_gpio: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:56 +0800
Message-ID: <20261103145306.487255-159-chengwen.feng@linux.dev>
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
 drivers/raw/cnxk_gpio/cnxk_gpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/raw/cnxk_gpio/cnxk_gpio.c b/drivers/raw/cnxk_gpio/cnxk_gpio.c
index 8a5dda68dc..ed4e533740 100644
--- a/drivers/raw/cnxk_gpio/cnxk_gpio.c
+++ b/drivers/raw/cnxk_gpio/cnxk_gpio.c
@@ -147,7 +147,7 @@ cnxk_gpio_params_reserve(size_t len)
 {
 	const struct rte_memzone *mz;
 
-	mz = rte_memzone_reserve(CNXK_GPIO_PARAMS_MZ_NAME, len, rte_socket_id(), 0);
+	mz = rte_memzone_reserve(CNXK_GPIO_PARAMS_MZ_NAME, len, rte_numa_id(), 0);
 	if (!mz)
 		return NULL;
 
@@ -879,7 +879,7 @@ cnxk_gpio_probe(struct rte_vdev_device *dev)
 	int ret;
 
 	cnxk_gpio_format_name(name, sizeof(name));
-	rawdev = rte_rawdev_pmd_allocate(name, sizeof(*gpiochip), rte_socket_id());
+	rawdev = rte_rawdev_pmd_allocate(name, sizeof(*gpiochip), rte_numa_id());
 	if (!rawdev) {
 		CNXK_GPIO_LOG(ERR, "failed to allocate %s rawdev", name);
 		return -ENOMEM;
-- 
2.55.0

