Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6640606A329
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wCZL0WY6
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E966427C0;
	Tue,  3 Nov 2026 16:00:45 +0100 (CET)
Received: from mta1.migadu.com (out-161.mta1.migadu.com [95.215.58.161])
 by mails.dpdk.org (Postfix) with ESMTPS id BE3F64013F
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:00:44 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=77i2/ijqTVQ8WrbsuzHfUpW0EYIrs5V0ZhGBLB6M9zQ=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718044; v=1; x=1794322844;
 b=wCZL0WY6AguLmgsCfWmheT0VU5huW8RHqOxeQuIWQee7MEVtF1zv7DBANoKKxw0FE4OdHVQI
 fCkoGCg/bgpB/BFM8Q18v/M86GWg09AEsioC+DONTTXOAvEwfIx/6JUeIhjdP7g+MRYRPyhiu1E
 m4TcDLD6F+0wpntwU2C+FzWc=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 1dc34fd986663e81;
 Tue, 03 Nov 2026 15:00:44 +0000
X-Mizu-Trace-ID: 1dc34fd986663e81
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 045/227] bus/dpaa: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:03 +0800
Message-ID: <20261103145306.487255-46-chengwen.feng@linux.dev>
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
 drivers/bus/dpaa/dpaa_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index cbbeb927fe..c29086b783 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -216,7 +216,7 @@ dpaa_create_device_list(void)
 			goto cleanup;
 		}
 
-		dev->device.numa_node = SOCKET_ID_ANY;
+		dev->device.numa_node = RTE_NUMA_ID_ANY;
 
 		cfg = &dpaa_netcfg->port_cfg[i];
 		fman_intf = cfg->fman_if;
-- 
2.55.0

