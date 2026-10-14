Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AD0CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 17:40:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 658C940B95;
	Wed, 14 Oct 2026 19:40:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A6B454067A
 for <dev@dpdk.org>; Wed, 14 Oct 2026 19:40:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791999643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e69mi6tX2/hGJtkEnAWdah4r50SPcDE2htYZJ9N9tJg=;
 b=WWdwjKWca6nWx6Nr0WhnwXs1kpfXfha8MbULHMBbop3nhAkGXOpvigX1P9P+o6+BZkV4zk
 ZQKOeXblyYY5g19EcOfw7mk55fMlDaWmDxzQMH2rNZkdZt81wEhu8Y3b693wZBgkLSj33t
 ieW40r12ZWC7JsR+SB66QUDbcwvGG00=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-cH8aKPSlOI2tPfpPvMyz2A-1; Wed,
 14 Oct 2026 17:40:38 +0000
X-MC-Unique: cH8aKPSlOI2tPfpPvMyz2A-1
X-Mimecast-MFC-AGG-ID: cH8aKPSlOI2tPfpPvMyz2A_1791999637
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA6971955EB5; Wed, 14 Oct 2026 17:40:37 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9CAA230000E3; Wed, 14 Oct 2026 17:40:36 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>,
	Rohit Raj <rohit.raj@nxp.com>
Subject: [PATCH 09/16] bus/fslmc: fix interrupt leak in DPIO cleanup
Date: Wed, 14 Oct 2026 19:39:52 +0200
Message-ID: <20261014174001.1830726-10-david.marchand@redhat.com>
In-Reply-To: <20261014174001.1830726-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20261014174001.1830726-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uGRHGBF5aIYZNIfwvdEsirMLe_OtYjIgxa42DMEYa2Y_1791999637
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

The interrupt handle in the DPIO device is separate from the bus device
object handle. The cleanup code was leaking this handle.

Fixes: 274fd921ff7f ("bus/fslmc: support close operation")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index 9fe449ed38..0776251d4d 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -476,6 +476,7 @@ dpaa2_close_dpio_device(int object_id)
 			rte_free(dpio_dev->dpio);
 		}
 		TAILQ_REMOVE(&dpio_dev_list, dpio_dev, next);
+		rte_intr_instance_free(dpio_dev->intr_handle);
 		rte_free(dpio_dev);
 	}
 }
-- 
2.54.0

