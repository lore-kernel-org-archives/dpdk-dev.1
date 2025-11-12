Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51116CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 09:11:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 870A340691;
	Wed, 12 Nov 2025 10:11:34 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D4A5F40674
 for <dev@dpdk.org>; Wed, 12 Nov 2025 10:11:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762938692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=++BPbBPcpLfFhuuK0aAqYDUbV6VmgrgeJNw9uELKzdY=;
 b=fcq7IALkfIdSrw1nI7Y+/KktzQwAxf2vX98Anv+enlNNigttxb1u42RWCUAmT9szgMcOtV
 /6caZz0z38oHdZpLmPWBMXiz97Jm/yEUeIHmDypB9Lb7ZINXRX7licJOB/Il4GT0NbHB9p
 ZkNQUg8lwWjQFGZSOro2X1+3SgkPWGo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-ID0coQ_2Oyew1zvIvj29sA-1; Wed,
 12 Nov 2025 04:11:29 -0500
X-MC-Unique: ID0coQ_2Oyew1zvIvj29sA-1
X-Mimecast-MFC-AGG-ID: ID0coQ_2Oyew1zvIvj29sA_1762938688
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 414B71800350; Wed, 12 Nov 2025 09:11:28 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.34.108])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B0EC180035F; Wed, 12 Nov 2025 09:11:26 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, maxime@leroys.fr,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v2 5/5] bus/fslmc: remove raw device in bus device
Date: Wed, 12 Nov 2025 10:10:48 +0100
Message-ID: <20251112091049.2669481-6-david.marchand@redhat.com>
In-Reply-To: <20251112091049.2669481-1-david.marchand@redhat.com>
References: <20251108153207.1512863-1-david.marchand@redhat.com>
 <20251112091049.2669481-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iLvFKZXKGoVUSb5YfOpDrMkfbcuvspTzgJn79zyR264_1762938688
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

There is no user of this field.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/fslmc/bus_fslmc_driver.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus_fslmc_driver.h
index 094f885f59..89abc3c486 100644
--- a/drivers/bus/fslmc/bus_fslmc_driver.h
+++ b/drivers/bus/fslmc/bus_fslmc_driver.h
@@ -97,9 +97,6 @@ enum rte_dpaa2_dev_type {
 struct rte_dpaa2_device {
 	TAILQ_ENTRY(rte_dpaa2_device) next; /**< Next probed DPAA2 device. */
 	struct rte_device device;           /**< Inherit core device */
-	union {
-		struct rte_rawdev *rawdev;          /**< Raw Device */
-	};
 	enum rte_dpaa2_dev_type dev_type;   /**< Device Type */
 	uint16_t object_id;                 /**< DPAA2 Object ID */
 	enum rte_dpaa2_dev_type ep_dev_type;   /**< Endpoint Device Type */
-- 
2.51.0

