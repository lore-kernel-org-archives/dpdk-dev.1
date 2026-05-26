Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3433DCD5BD1
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 08:42:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76D3B4066E;
	Tue, 26 May 2026 10:42:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E6BE14066B
 for <dev@dpdk.org>; Tue, 26 May 2026 10:42:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779784961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s9JgFA6adsXoXlgqfKcNUr6iswJGsu88FVWrgIBh+OQ=;
 b=OFBEBIKe1uRhzlSP5I3EZmWR85dsfB0eObd5dPk2F9oBjSUjfxXkQJxzbs+KtmQD4f2Z0D
 1UICKWr/P+Az+ULXhDSo4h+zkK/jGxmxeRFrVsq7XFfkJsttHHqFWJ7sNvTcr8n4XHnAXG
 7XOad7kNCWQ8nywsm+FB7ECtszjVWko=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-KaYx_APKP4eLjJVF0k_7MA-1; Tue,
 26 May 2026 04:42:37 -0400
X-MC-Unique: KaYx_APKP4eLjJVF0k_7MA-1
X-Mimecast-MFC-AGG-ID: KaYx_APKP4eLjJVF0k_7MA_1779784956
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEC351956094; Tue, 26 May 2026 08:42:36 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.49.40])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B57301686; Tue, 26 May 2026 08:42:34 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, Kevin Laatz <kevin.laatz@intel.com>
Subject: [PATCH v3 04/25] dma/idxd: clear device at scan
Date: Tue, 26 May 2026 10:41:44 +0200
Message-ID: <20260526084212.3145685-5-david.marchand@redhat.com>
In-Reply-To: <20260526084212.3145685-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260526084212.3145685-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7cRTVeFO-9ZNZo3s9h3CquJ-GNguBFhpgxA7bs6roXg_1779784956
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

