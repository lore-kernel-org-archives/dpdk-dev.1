Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE1D606A32E
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nw7/Nyrb
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95EA642F7D;
	Tue,  3 Nov 2026 16:20:17 +0100 (CET)
Received: from mta1.migadu.com (out-158.mta1.migadu.com [95.215.58.158])
 by mails.dpdk.org (Postfix) with ESMTPS id ECF1042F76
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:20:16 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=Glh4XqgQevyihBlIqyx9z7wMeTQIJRogSM5plc2XkeU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719213; v=1; x=1794324013;
 b=nw7/NyrbgJOhorS9Mm+zIBExEkhiIiQxLYKqcfg2bMoXw1gsfk0rvSCBA/PHLUwEu1jNCszp
 yvq/go1HGcWkVHVbpQBIfaF6kN1M7U56GfHib0rm/R4QLx7pGUM9cAbUeR/DeiWEqrEtauILYel
 l5o2xMgJ/iu9kpDZSNntGANI=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 012bb67b27f17801;
 Tue, 03 Nov 2026 15:20:13 +0000
X-Mizu-Trace-ID: 012bb67b27f17801
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 173/227] app/graph: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:11 +0800
Message-ID: <20261103145306.487255-174-chengwen.feng@linux.dev>
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

Rename socket_id parameters, local variables and comments to the
NUMA node terminology, and switch calls to the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/graph/ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/graph/ethdev.c b/app/graph/ethdev.c
index ee4b9014e8..1e978ec267 100644
--- a/app/graph/ethdev.c
+++ b/app/graph/ethdev.c
@@ -433,8 +433,8 @@ ethdev_process(const char *name, struct ethdev_config *params)
 		}
 	}
 
-	numa_node = rte_eth_dev_socket_id(port_id);
-	if (numa_node == SOCKET_ID_ANY)
+	numa_node = rte_eth_dev_numa_id(port_id);
+	if (numa_node == RTE_NUMA_ID_ANY)
 		numa_node = 0;
 
 	if (params->mtu)
-- 
2.55.0

