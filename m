Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59E7CD4F54
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 May 2026 07:52:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54FDB40650;
	Sat, 30 May 2026 09:52:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 797B940611
 for <dev@dpdk.org>; Sat, 30 May 2026 09:52:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780127559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9hPwcTK8yLDG1OrPL4xmHwnRuxbo1Rd0tYOtryrIGlw=;
 b=db5hk19a1c43eu3/Q8sYPEUhcLnXC6HKFudfJvLsshCsZ3WNLykqrquPXVs354RsCFhzdo
 y4aZsGrmU4siWoH7IK6QNjZCU5IEKm7wJ9Bs1eWMAT+9mhJxkVEUo0Gxsj33F1hVOQiIQN
 cnrBYPH82bczKKe0p8uNv21q7u6GGnU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-Nb2-zwQ4MHiry8j-0XMhOg-1; Sat,
 30 May 2026 03:52:35 -0400
X-MC-Unique: Nb2-zwQ4MHiry8j-0XMhOg-1
X-Mimecast-MFC-AGG-ID: Nb2-zwQ4MHiry8j-0XMhOg_1780127554
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DA6B1800343; Sat, 30 May 2026 07:52:34 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.49.40])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4C12330001BB; Sat, 30 May 2026 07:52:32 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, Kevin Laatz <kevin.laatz@intel.com>
Subject: [PATCH v5 04/25] dma/idxd: clear device at scan
Date: Sat, 30 May 2026 09:51:34 +0200
Message-ID: <20260530075201.869606-5-david.marchand@redhat.com>
In-Reply-To: <20260530075201.869606-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260530075201.869606-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tgOhsSN2MaB5iW4fFF1U5bquI8a22uJw5zNGsuOi3is_1780127554
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

