Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5A2C982C1
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 07:50:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43C1E42DE9;
	Thu, 17 Sep 2026 09:50:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B4D58427D5
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:50:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789631400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=72WOYR4gppb3ZjXoB/pr0++pQD84ksyCCeSKljZnn4s=;
 b=Pj88OwBo5tq5+UPHNn11T3bOGRFeFuPMcHz7DN5vNB4TwoOzAcJwXRA5ITViENthg6wCLs
 fzceZSxZ+gfhOVnSJzOdyUrV6XljYDUGLmHM1oPBDfdR8JFUpTxCAs08FhfC1RRQWVqS16
 Ns70YOGRfj16xGxCX7cqD81DpCtlCXM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-ZmGNiPd9M7GHNDqxAzYtGw-1; Thu,
 17 Sep 2026 03:49:58 -0400
X-MC-Unique: ZmGNiPd9M7GHNDqxAzYtGw-1
X-Mimecast-MFC-AGG-ID: ZmGNiPd9M7GHNDqxAzYtGw_1789631397
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98FF419539BD; Thu, 17 Sep 2026 07:49:57 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 66071180049F; Thu, 17 Sep 2026 07:49:56 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>,
	Rohit Raj <rohit.raj@nxp.com>
Subject: [RFC v2 09/16] bus/fslmc: fix interrupt leak in DPIO cleanup
Date: Thu, 17 Sep 2026 09:49:09 +0200
Message-ID: <20260917074917.595603-10-david.marchand@redhat.com>
In-Reply-To: <20260917074917.595603-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20260917074917.595603-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wuJVwmiuz-tWQ2U21VI1Z6ZEqtHF5G0Epjsa3Bttc30_1789631397
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
index e17050b625..71996b2b38 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -470,6 +470,7 @@ dpaa2_close_dpio_device(int object_id)
 			rte_free(dpio_dev->dpio);
 		}
 		TAILQ_REMOVE(&dpio_dev_list, dpio_dev, next);
+		rte_intr_instance_free(dpio_dev->intr_handle);
 		rte_free(dpio_dev);
 	}
 }
-- 
2.54.0

