Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C939260A3823
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lfEhQijF
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B53F4427C5;
	Tue,  3 Nov 2026 16:01:22 +0100 (CET)
Received: from mta1.migadu.com (out-210.mta1.migadu.com [95.215.58.210])
 by mails.dpdk.org (Postfix) with ESMTPS id E4DB64013F
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:01:20 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=DcpTu5hk4ehNeeCE2oPbklH6OhIYiL9QfGFtqzKQ42Q=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718080; v=1; x=1794322880;
 b=lfEhQijF5FXUOyYeJWcR0LRFmh4z+u7Xc+mQNBQ/Ao56mKFqepidpWFnBk8yxw3SmUEoLJxA
 smWGwPlFnP4uP/xFdBcOOcSU+r3p6r/h5h8LT77fsiwjx/flauV0sl7/XBifZ/B7ODiWn4qIG2O
 I3+jEuf0q5B7HFNnY6+ngRqQ=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id fac443521cf082c5;
 Tue, 03 Nov 2026 15:01:20 +0000
X-Mizu-Trace-ID: fac443521cf082c5
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 050/227] bus/vdev: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:08 +0800
Message-ID: <20261103145306.487255-51-chengwen.feng@linux.dev>
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
 drivers/bus/vdev/vdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/vdev/vdev.c b/drivers/bus/vdev/vdev.c
index 02d719a44d..e3ff2e55d7 100644
--- a/drivers/bus/vdev/vdev.c
+++ b/drivers/bus/vdev/vdev.c
@@ -275,7 +275,7 @@ insert_vdev(const char *name, const char *args,
 		goto fail;
 	}
 
-	dev->device.numa_node = SOCKET_ID_ANY;
+	dev->device.numa_node = RTE_NUMA_ID_ANY;
 
 	if (find_vdev(name)) {
 		/*
@@ -537,7 +537,7 @@ vdev_scan(void)
 		}
 
 		dev->device.devargs = devargs;
-		dev->device.numa_node = SOCKET_ID_ANY;
+		dev->device.numa_node = RTE_NUMA_ID_ANY;
 		dev->device.name = devargs->name;
 
 		rte_bus_add_device(&rte_vdev_bus, &dev->device);
-- 
2.55.0

