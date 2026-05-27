Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405B2CD5BDE
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 07:57:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 085CB4064E;
	Wed, 27 May 2026 09:57:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 79BEC402F1
 for <dev@dpdk.org>; Wed, 27 May 2026 09:57:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779868645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9hPwcTK8yLDG1OrPL4xmHwnRuxbo1Rd0tYOtryrIGlw=;
 b=ie7szx8etdztA2SEoIcycmfqwPF/vqwB5HVdWBwXModDJI4jrvSi/E0ClDuq7GSq5z2kuE
 4Ul/CY60zpVtnOiTjCL02AxIuVtzTUMPoviL9lo6t6dmUgVSclXQ5/1Xzd3vIqhyxDfZRw
 Eff/BF11Q+OrpiF5Euq2Skivv52LtWs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-oHQptu6TO8Sx2o3lHKImwQ-1; Wed,
 27 May 2026 03:57:21 -0400
X-MC-Unique: oHQptu6TO8Sx2o3lHKImwQ-1
X-Mimecast-MFC-AGG-ID: oHQptu6TO8Sx2o3lHKImwQ_1779868640
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4416519560AF; Wed, 27 May 2026 07:57:20 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.49.40])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 32C8F1800352; Wed, 27 May 2026 07:57:17 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, Kevin Laatz <kevin.laatz@intel.com>
Subject: [PATCH v4 04/25] dma/idxd: clear device at scan
Date: Wed, 27 May 2026 09:56:28 +0200
Message-ID: <20260527075654.3780732-5-david.marchand@redhat.com>
In-Reply-To: <20260527075654.3780732-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260527075654.3780732-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T6rP-zA1H68_rLBWgQlD2eX-D-jL7yc9wNM_npeWw6U_1779868640
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

Currently, the device object is only manipulated by the dma/idxd bus
callbacks and EAL is not looking too much into this object.

However, in the next refactoring, EAL will expect a clean object, like
when checking that the device has been already probed
(iow dev->driver != NULL).

Request a 0'd object when allocating.

Reported-by: Bruce Richardson <bruce.richardson@intel.com>
Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/dma/idxd/idxd_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/idxd_bus.c b/drivers/dma/idxd/idxd_bus.c
index 291cd6c707..f267c20a59 100644
--- a/drivers/dma/idxd/idxd_bus.c
+++ b/drivers/dma/idxd/idxd_bus.c
@@ -322,7 +322,7 @@ dsa_scan(void)
 		}
 		IDXD_PMD_DEBUG("%s(): found %s/%s", __func__, path, wq->d_name);
 
-		dev = malloc(sizeof(*dev));
+		dev = calloc(1, sizeof(*dev));
 		if (dev == NULL) {
 			closedir(dev_dir);
 			return -ENOMEM;
-- 
2.53.0

