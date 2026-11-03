Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D1960A263D
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CH5VkXhK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9A53427E0;
	Tue,  3 Nov 2026 16:01:12 +0100 (CET)
Received: from mta1.migadu.com (out-200.mta1.migadu.com [95.215.58.200])
 by mails.dpdk.org (Postfix) with ESMTPS id 299E4427E0
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:01:12 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=ODeIlBufKGKjsVxYs+Q2j3gjlmbsaxFvz1ClpAnciuk=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718071; v=1; x=1794322871;
 b=CH5VkXhKt49ao+ZG7CzNLZ2iXyHRhBIzG33MzsIG6aTO7idpj5Q14dotZzHhfsCKD94V99Vn
 3ALEoOo5qzKVA24peZdXor1eUVLcXPS7CY80A7dhNkEQDqxST5K/rGle7Vu+1uHPPcfiKrpPPEi
 iDGnJU4Q6H1in/8y/dUifnwY=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 4080cccb2791c5df;
 Tue, 03 Nov 2026 15:01:11 +0000
X-Mizu-Trace-ID: 4080cccb2791c5df
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 049/227] bus/platform: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:07 +0800
Message-ID: <20261103145306.487255-50-chengwen.feng@linux.dev>
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
 drivers/bus/platform/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index b122d9545f..c968f5306d 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -61,7 +61,7 @@ dev_add(const char *dev_name)
 	pdev->device.name = pdev->name;
 	pdev->device.devargs = rte_bus_find_devargs(&platform_bus, dev_name);
 	snprintf(path, sizeof(path), PLATFORM_BUS_DEVICES_PATH "/%s/numa_node", dev_name);
-	pdev->device.numa_node = eal_parse_sysfs_value(path, &val) ? rte_socket_id() : val;
+	pdev->device.numa_node = eal_parse_sysfs_value(path, &val) ? rte_numa_id() : val;
 
 	RTE_BUS_FOREACH_DEV(tmp, &platform_bus) {
 		if (!strcmp(tmp->name, pdev->name)) {
-- 
2.55.0

