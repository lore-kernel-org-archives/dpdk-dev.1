Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A488CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 13:08:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AD8640647;
	Tue,  4 Nov 2025 14:08:36 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8606C40613
 for <dev@dpdk.org>; Tue,  4 Nov 2025 14:08:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762261714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2qe5Qvn6I2nra6opOMrUTwSl9L+Bi+dA7ZUhCj+0U7w=;
 b=h6oaota8IuqmnlnPVVAJ1Su9q/cP8Z/UviT1U5cBwVHMTPBFdKPP5Mr8sgANW0sLTi9Zpf
 bBChmU6wz8ZNDhhb37XLVq8vXOh4mFZNN+cQh5x994FEIcexZey5c2KVc4KsEhJ3ldxZ82
 bFM5NOZ6MR+IuDppdT//oKlVBpIUzbA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-Q_vhgQSvOVy5LkUUu0gcrg-1; Tue,
 04 Nov 2025 08:08:28 -0500
X-MC-Unique: Q_vhgQSvOVy5LkUUu0gcrg-1
X-Mimecast-MFC-AGG-ID: Q_vhgQSvOVy5LkUUu0gcrg_1762261706
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E44C195607F; Tue,  4 Nov 2025 13:08:26 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9401F18004D4; Tue,  4 Nov 2025 13:08:23 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Abhinandan Gujjar <abhinandan.gujjar@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, Akhil Goyal <gakhil@marvell.com>,
 Volodymyr Fialko <vfialko@marvell.com>,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>
Subject: [PATCH] eventdev: fix build with clang 21
Date: Tue,  4 Nov 2025 14:08:20 +0100
Message-ID: <20251104130820.2692144-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: m86nBQ2R-HYWtKSkP0csxyLEJdtDWv4HUGGK4pD42eA_1762261706
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

../lib/eventdev/rte_event_crypto_adapter.c:1461:4: error:
	format specifies type 'unsigned char' but the argument has type
	'uint16_t' (aka 'unsigned short') [-Werror,-Wformat]
 1459 |     RTE_EDEV_LOG_ERR("Failed to get adapter caps dev %" PRIu8
      |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1460 |             " cdev %" PRIu8, adapter->eventdev_id,
      |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1461 |             adapter->next_cdev_id);
      |             ^~~~~~~~~~~~~~~~~~~~~~

../lib/eventdev/rte_event_crypto_adapter.c:1592:46: error:
	format specifies type 'unsigned char' but the argument has type
	'uint16_t' (aka 'unsigned short') [-Werror,-Wformat]
 1592 |     RTE_EDEV_LOG_ERR("Invalid dev_id=%" PRIu8, cdev_id);
      |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~

../lib/eventdev/rte_event_crypto_adapter.c:1613:45: error:
	format specifies type 'unsigned char' but the argument has type
	'uint16_t' (aka 'unsigned short') [-Werror,-Wformat]
 1612 |     RTE_EDEV_LOG_ERR("Event vectorization is not supported,"
      |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1613 |                      "dev %" PRIu8 " cdev %" PRIu8, dev_id, cdev_id);
      |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~

Fixes: c1749bc5ee10 ("eventdev: introduce event cryptodev vector type")
Fixes: 04ed18cd41f1 ("eventdev/crypto: support runtime set/get parameters")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/eventdev/rte_event_crypto_adapter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/eventdev/rte_event_crypto_adapter.c b/lib/eventdev/rte_event_crypto_adapter.c
index b827a0ffd6..3f9cc7379a 100644
--- a/lib/eventdev/rte_event_crypto_adapter.c
+++ b/lib/eventdev/rte_event_crypto_adapter.c
@@ -1457,7 +1457,7 @@ crypto_adapter_cap_check(struct event_crypto_adapter *adapter)
 						&caps);
 	if (ret) {
 		RTE_EDEV_LOG_ERR("Failed to get adapter caps dev %" PRIu8
-			" cdev %" PRIu8, adapter->eventdev_id,
+			" cdev %" PRIu16, adapter->eventdev_id,
 			adapter->next_cdev_id);
 		return ret;
 	}
@@ -1589,7 +1589,7 @@ rte_event_crypto_adapter_vector_limits_get(
 	RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 
 	if (!rte_cryptodev_is_valid_dev(cdev_id)) {
-		RTE_EDEV_LOG_ERR("Invalid dev_id=%" PRIu8, cdev_id);
+		RTE_EDEV_LOG_ERR("Invalid dev_id=%" PRIu16, cdev_id);
 		return -EINVAL;
 	}
 
@@ -1610,7 +1610,7 @@ rte_event_crypto_adapter_vector_limits_get(
 
 	if (!(cap & RTE_EVENT_CRYPTO_ADAPTER_CAP_EVENT_VECTOR)) {
 		RTE_EDEV_LOG_ERR("Event vectorization is not supported,"
-				 "dev %" PRIu8 " cdev %" PRIu8, dev_id, cdev_id);
+				 "dev %" PRIu8 " cdev %" PRIu16, dev_id, cdev_id);
 		return -ENOTSUP;
 	}
 
-- 
2.51.0

