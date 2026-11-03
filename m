Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40F6606D2EB
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AoEWKqej
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15EAA427CC;
	Tue,  3 Nov 2026 16:01:00 +0100 (CET)
Received: from mta0.migadu.com (out-127.mta0.migadu.com [91.218.175.127])
 by mails.dpdk.org (Postfix) with ESMTPS id 0E4F34013F
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:00:59 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=N5J7XI953ZHTOstGSFEuM7gNeOyvALy7Ay/xzp+fSMg=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718058; v=1; x=1794322858;
 b=AoEWKqej7ofWuv7vcGEsx3+btAPD/IdyBgW1tK4QvefYbmWrgfhAS4/X/fQVL1r+xec9CECH
 1c/LSae+IPdeoQ6hV3cOeWW5+U/b3rMtvKuN5f5uMyGpT2RzBAkEavPIvkzPCFn8S0ffamHzcUN
 qX1MXPG9U6xoQyeN56QCMOeQ=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id b82eb7567b4f2679;
 Tue, 03 Nov 2026 15:00:58 +0000
X-Mizu-Trace-ID: b82eb7567b4f2679
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 047/227] bus/ifpga: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:05 +0800
Message-ID: <20261103145306.487255-48-chengwen.feng@linux.dev>
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
 drivers/bus/ifpga/ifpga_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/ifpga/ifpga_bus.c b/drivers/bus/ifpga/ifpga_bus.c
index 79d1c3778f..f61d52f6aa 100644
--- a/drivers/bus/ifpga/ifpga_bus.c
+++ b/drivers/bus/ifpga/ifpga_bus.c
@@ -137,7 +137,7 @@ ifpga_scan_one(struct rte_rawdev *rawdev,
 		goto end;
 
 	afu_dev->device.devargs = devargs;
-	afu_dev->device.numa_node = SOCKET_ID_ANY;
+	afu_dev->device.numa_node = RTE_NUMA_ID_ANY;
 	afu_dev->device.name = devargs->name;
 	afu_dev->rawdev = rawdev;
 	afu_dev->id.uuid.uuid_low  = 0;
-- 
2.55.0

