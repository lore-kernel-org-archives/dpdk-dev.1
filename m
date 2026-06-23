Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9985CDB46F
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 10:55:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70B5840651;
	Tue, 23 Jun 2026 12:55:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1C89940648
 for <dev@dpdk.org>; Tue, 23 Jun 2026 12:55:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782212104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mCIR5p6sR/M/ez8gvwEAJXdTTh/U2QxRgX+MUa7ergE=;
 b=DpMMlP/vDd33KTao6OiyPLmHIWRYs6qaIE4KKpcZ+1S8eQPuLmy60q2XYIpiEAWY6mguFy
 wAoqgRUR8+Pde1bsuUdxghXQPlFkfh/yFTJ6wVJy0Lu3/xJjn1CAFzCf9r3ElyDYEom5vi
 ffcHYklusJv9BskrzzZhl7UglNRGJcA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-5OD9iNCiO-yCYKLgwcOsvw-1; Tue,
 23 Jun 2026 06:54:59 -0400
X-MC-Unique: 5OD9iNCiO-yCYKLgwcOsvw-1
X-Mimecast-MFC-AGG-ID: 5OD9iNCiO-yCYKLgwcOsvw_1782212097
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A8881801BE5; Tue, 23 Jun 2026 10:54:57 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1DEF61956043; Tue, 23 Jun 2026 10:54:53 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com, longli@microsoft.com,
 hemant.agrawal@nxp.com, Kevin Laatz <kevin.laatz@intel.com>
Subject: [PATCH v3 02/11] dma/idxd: remove next pointer in bus specific device
Date: Tue, 23 Jun 2026 12:54:29 +0200
Message-ID: <20260623105439.2144694-3-david.marchand@redhat.com>
In-Reply-To: <20260623105439.2144694-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260623105439.2144694-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0ypInpz6ScQ5xz-EKgkNTb7-K4lpZRuyBBtd5XEoB0M_1782212097
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

The dma/idxd devices are now stored in a list of generic rte_device
objects.

Fixes: b4f0974a995b ("bus: factorize device list")

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/dma/idxd/idxd_bus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/idxd/idxd_bus.c b/drivers/dma/idxd/idxd_bus.c
index 4810d52f2a..2ec526ec09 100644
--- a/drivers/dma/idxd/idxd_bus.c
+++ b/drivers/dma/idxd/idxd_bus.c
@@ -34,7 +34,6 @@ struct dsa_wq_addr {
 /** a DSA device instance */
 struct rte_dsa_device {
 	struct rte_device device;           /**< Inherit core device */
-	TAILQ_ENTRY(rte_dsa_device) next;   /**< next dev in list */
 
 	char wq_name[32];                   /**< the workqueue name/number e.g. wq0.1 */
 	struct dsa_wq_addr addr;            /**< Identifies the specific WQ */
-- 
2.54.0

