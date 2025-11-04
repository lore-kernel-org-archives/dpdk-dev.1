Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3208CCFA04
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 13:08:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A9CC4028C;
	Tue,  4 Nov 2025 14:08:21 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B643640269
 for <dev@dpdk.org>; Tue,  4 Nov 2025 14:08:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762261700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Mu63TGjCtRvauhr1ZQGsug55cKhKyvk5fkFPrH4iqVg=;
 b=PBv1g1zqnEa2Cgm93VUwfs30kKMFjuAPxqa5w0xjdsxrelwRR1UF0d+rWuU8hKvnCvKQxZ
 sLCnk/mNcSXPI3A7/NRkq8hCLB3c+8L2Yix9wfmcPR5nqBTqAj/70VyvOciBRYd6aFjv7p
 +iQ0vrcgyIhTna3GM0UVkcZLYbT/rLY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-QbPTJHc6PlCiWpq5LBaQLg-1; Tue,
 04 Nov 2025 08:08:16 -0500
X-MC-Unique: QbPTJHc6PlCiWpq5LBaQLg-1
X-Mimecast-MFC-AGG-ID: QbPTJHc6PlCiWpq5LBaQLg_1762261695
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42E5319560BE; Tue,  4 Nov 2025 13:08:15 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.16])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 20DDF30001A1; Tue,  4 Nov 2025 13:08:12 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Sachin Saxena <sachin.saxena@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Shreyansh Jain <shreyansh.jain@nxp.com>
Subject: [PATCH] rawdev: fix build with clang 21
Date: Tue,  4 Nov 2025 14:08:08 +0100
Message-ID: <20251104130808.2692053-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6zC9Iv9FNsfdS4I9C0FnAH-h1CjYs8mYWGJo9Z_4ZiQ_1762261695
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Fix 16-bits formatting issues reported by clang 21 on Fedora 43:

../lib/rawdev/rte_rawdev.c:429:41: error: format specifies type
	'unsigned char' but the argument has type 'uint16_t'
	(aka 'unsigned short') [-Werror,-Wformat]
  429 |         RTE_RDEV_DEBUG("Start dev_id=%" PRIu8, dev_id);
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~

../lib/rawdev/rte_rawdev.c:435:9: error: format specifies type
	'unsigned char' but the argument has type 'uint16_t'
	(aka 'unsigned short') [-Werror,-Wformat]
  434 |         RTE_RDEV_ERR("Device with dev_id=%" PRIu8 "already started",
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  435 |                      dev_id);
      |                      ^~~~~~~

../lib/rawdev/rte_rawdev.c:457:40: error: format specifies type
	'unsigned char' but the argument has type 'uint16_t'
	(aka 'unsigned short') [-Werror,-Wformat]
  457 |         RTE_RDEV_DEBUG("Stop dev_id=%" PRIu8, dev_id);
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~

../lib/rawdev/rte_rawdev.c:464:4: error: format specifies type
	'unsigned char' but the argument has type 'uint16_t'
	(aka 'unsigned short') [-Werror,-Wformat]
  463 |         RTE_RDEV_ERR("Device with dev_id=%" PRIu8 "already stopped",
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  464 |                 dev_id);
      |                 ^~~~~~~

Fixes: c88b3f2558ed ("rawdev: introduce raw device library")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/rawdev/rte_rawdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/rawdev/rte_rawdev.c b/lib/rawdev/rte_rawdev.c
index f21d29114c..d193061842 100644
--- a/lib/rawdev/rte_rawdev.c
+++ b/lib/rawdev/rte_rawdev.c
@@ -426,12 +426,12 @@ rte_rawdev_start(uint16_t dev_id)
 	struct rte_rawdev *dev;
 	int diag;
 
-	RTE_RDEV_DEBUG("Start dev_id=%" PRIu8, dev_id);
+	RTE_RDEV_DEBUG("Start dev_id=%" PRIu16, dev_id);
 
 	RTE_RAWDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_rawdevs[dev_id];
 	if (dev->started != 0) {
-		RTE_RDEV_ERR("Device with dev_id=%" PRIu8 "already started",
+		RTE_RDEV_ERR("Device with dev_id=%" PRIu16 "already started",
 			     dev_id);
 		return 0;
 	}
@@ -454,13 +454,13 @@ rte_rawdev_stop(uint16_t dev_id)
 {
 	struct rte_rawdev *dev;
 
-	RTE_RDEV_DEBUG("Stop dev_id=%" PRIu8, dev_id);
+	RTE_RDEV_DEBUG("Stop dev_id=%" PRIu16, dev_id);
 
 	RTE_RAWDEV_VALID_DEVID_OR_RET(dev_id);
 	dev = &rte_rawdevs[dev_id];
 
 	if (dev->started == 0) {
-		RTE_RDEV_ERR("Device with dev_id=%" PRIu8 "already stopped",
+		RTE_RDEV_ERR("Device with dev_id=%" PRIu16 "already stopped",
 			dev_id);
 		return;
 	}
-- 
2.51.0

