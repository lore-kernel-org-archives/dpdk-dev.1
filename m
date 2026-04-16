Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD80F8A146
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 09:36:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB31A40297;
	Thu, 16 Apr 2026 11:36:18 +0200 (CEST)
Received: from mail.amicon.ru (mail.amicon.ru [77.108.111.100])
 by mails.dpdk.org (Postfix) with ESMTP id 5FCDA40144;
 Thu, 16 Apr 2026 11:36:17 +0200 (CEST)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
 t=1776332175; h=from:subject:to:date:message-id;
 bh=jaUA7hfaiuUdCKWc5gZZ6Q+3t0+8ZhlYSnrYD59VZ+s=;
 b=f1SKDTpS6Rt8G2YyltEH+vKW9oojrkINupw6ptF6PB4f6+svmBLeluD4IelqBj/bIHZjPgZY5Zq
 06LZX0oZvfSVWa1gixmTbssO0q1dV0Uw0UIe0eUBOJEq03kK/3WKS07DEe/2j3ZHZj0YPEQfp20G/
 P1VDEDb3qzzXutLxdElunLgkgE7jGgAB/XQz8NocP+ninWZQPbBdjW8rlYvOXNMAC7kGqPUqrvB2y
 A0VU0fKgX1bXnjR+wVcgB6w7iph11GOKhYzLPQWKFiTn012rBBasNkUTCAdNCwPiUO3qeOB03CjRU
 Zdsa5lLfTYZedfvUuNvvqfRcGte8XffVqJZA==
Received: from dish.amicon.lan (172.16.2.39) by mail.amicon.lan (192.168.0.59)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Thu, 16 Apr
 2026 12:36:15 +0300
From: Daniil Iskhakov <dish@amicon.ru>
To: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Abhinandan Gujjar <abhinandan.gujjar@intel.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Daniil Iskhakov <dish@amicon.ru>,
 Daniil Agalakov <ade@amicon.ru>, <sdl.dpdk@linuxtesting.org>, <rrv@amicon.ru>
Subject: [PATCH] cryptodev: reset resource pointers in init error path
Date: Thu, 16 Apr 2026 12:34:36 +0300
Message-ID: <20260416093437.711435-1-dish@amicon.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Originating-IP: [172.16.2.39]
X-ClientProxiedBy: mail.amicon.lan (192.168.0.59) To mail.amicon.lan
 (192.168.0.59)
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

cryptodev_cb_init() may free partially allocated resources on failure,
but does not reset their pointers afterwards.

A later call to cryptodev_cb_cleanup() may then attempt to release both
resources even when one of them has already been freed, because the
cleanup logic does not rely on both pointers being valid independently.

Set freed pointers to NULL in the cryptodev_cb_init() error path to
make subsequent cleanup safe.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1c3ffb95595e ("cryptodev: add enqueue and dequeue callbacks")
Cc: stable@dpdk.org

Signed-off-by: Daniil Agalakov <ade@amicon.ru>
Signed-off-by: Daniil Iskhakov <dish@amicon.ru>
---
Cc: abhinandan.gujjar@intel.com
Cc: sdl.dpdk@linuxtesting.org
Cc: rrv@amicon.ru
---
 lib/cryptodev/rte_cryptodev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/cryptodev/rte_cryptodev.c b/lib/cryptodev/rte_cryptodev.c
index 50071935c2..5cb9c93c77 100644
--- a/lib/cryptodev/rte_cryptodev.c
+++ b/lib/cryptodev/rte_cryptodev.c
@@ -811,6 +811,7 @@ cryptodev_cb_init(struct rte_cryptodev *dev)
 	if (dev->deq_cbs == NULL) {
 		CDEV_LOG_ERR("Failed to allocate memory for deq callbacks");
 		rte_free(dev->enq_cbs);
+		dev->enq_cbs = NULL;
 		return -ENOMEM;
 	}
 
-- 
2.43.0

