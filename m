Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CB9606A32F
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AHX0Ccbl
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C546427D0;
	Tue,  3 Nov 2026 16:08:18 +0100 (CET)
Received: from mta1.migadu.com (out-194.mta1.migadu.com [95.215.58.194])
 by mails.dpdk.org (Postfix) with ESMTPS id 1B3B0427D0
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:08:17 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=MkxDJqEFlvnMK3FLMIkFj5uT21QMMcM2gBTLqbHteXY=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718496; v=1; x=1794323296;
 b=AHX0CcblAzp0mIoa7ua2mvKsAIKP0j9opnJjUC/cvdhdcevvI7cycdatARF2lmZodlpvdlUI
 a7//Z+YG6AUYn5aMVvORQ8VoU84GRqNF7UdcgiMoYfFsi1PLEjl3nCoQ4euFPnTjqdMcuOPa/Ms
 6f5FvcLJF69SOGClULrz7wug=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 1cf80c3ddf101473;
 Tue, 03 Nov 2026 15:08:16 +0000
X-Mizu-Trace-ID: 1cf80c3ddf101473
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 094/227] event/dsw: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:52 +0800
Message-ID: <20261103145306.487255-95-chengwen.feng@linux.dev>
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
 drivers/event/dsw/dsw_evdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/event/dsw/dsw_evdev.c b/drivers/event/dsw/dsw_evdev.c
index 55e3a2045c..84ba4a06c2 100644
--- a/drivers/event/dsw/dsw_evdev.c
+++ b/drivers/event/dsw/dsw_evdev.c
@@ -448,7 +448,7 @@ dsw_probe(struct rte_vdev_device *vdev)
 	name = rte_vdev_device_name(vdev);
 
 	dev = rte_event_pmd_vdev_init(name, sizeof(struct dsw_evdev),
-				      rte_socket_id(), vdev);
+				      rte_numa_id(), vdev);
 	if (dev == NULL)
 		return -EFAULT;
 
-- 
2.55.0

