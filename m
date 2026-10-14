Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4ABCC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 17:40:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90F8540687;
	Wed, 14 Oct 2026 19:40:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 80AFD40687
 for <dev@dpdk.org>; Wed, 14 Oct 2026 19:40:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791999619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0sRMZUsbADMUJNN4uafpSqP+Pc7V8ARQIFz0g0s+H1s=;
 b=ckGNo/W8CTmRiu4oQb+2HeUd0+Mb1ohqAq5lf03yj9gpD7VDsceYTSuIm644rKxXYZYsVz
 OrA9xd56ifu0Gis3GE/WQc2jGAwWixweYIDaYAOJM++l28CIHFhNLu//Ru963Hry+6+COj
 gvsAy1uzLf5N9F6y7jmoUM3sfjANSbM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-bnD8K1F4PXaICNgZEX1B1Q-1; Wed,
 14 Oct 2026 17:40:15 +0000
X-MC-Unique: bnD8K1F4PXaICNgZEX1B1Q-1
X-Mimecast-MFC-AGG-ID: bnD8K1F4PXaICNgZEX1B1Q_1791999613
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12D4C19560AE; Wed, 14 Oct 2026 17:40:13 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 82709195608E; Wed, 14 Oct 2026 17:40:11 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>, Hyong Youb Kim <hyonkim@cisco.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH 02/16] drivers/bus: fix FD leak during scan in NXP drivers
Date: Wed, 14 Oct 2026 19:39:45 +0200
Message-ID: <20261014174001.1830726-3-david.marchand@redhat.com>
In-Reply-To: <20261014174001.1830726-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20261014174001.1830726-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bWJTZtW1lWRHLbrtgyh9TXaTs3CDQBCRLLDhgBBYdTE_1791999613
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

In theory, if the interrupt handle setup fails, an eventfd gets leaked.

In practice, as long as the interrupt handle is valid, those calls can
not fail, but this could get broken in the future so it is better to
handle this error branch correctly.

Fixes: d61138d4f0e2 ("drivers: remove direct access to interrupt handle")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/dpaa/dpaa_bus.c    | 11 +++++++----
 drivers/bus/fslmc/fslmc_vfio.c | 18 ++++++++++--------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 06962a5b29..5df2dff8f2 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -648,11 +648,14 @@ static int rte_dpaa_setup_intr(struct rte_intr_handle *intr_handle)
 		return errno;
 	}
 
-	if (rte_intr_fd_set(intr_handle, fd))
-		return rte_errno;
+	if (rte_intr_fd_set(intr_handle, fd) ||
+			rte_intr_type_set(intr_handle, RTE_INTR_HANDLE_EXT)) {
+		int err = rte_errno;
 
-	if (rte_intr_type_set(intr_handle, RTE_INTR_HANDLE_EXT))
-		return rte_errno;
+		close(fd);
+		rte_intr_fd_set(intr_handle, -1);
+		return err;
+	}
 
 	return 0;
 }
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index e9bf6a6c5c..c8b5518956 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -1382,14 +1382,16 @@ rte_dpaa2_vfio_setup_intr(struct rte_intr_handle *intr_handle,
 			return fd;
 		}
 
-		if (rte_intr_fd_set(intr_handle, fd))
-			return -rte_errno;
-
-		if (rte_intr_type_set(intr_handle, RTE_INTR_HANDLE_VFIO_MSI))
-			return -rte_errno;
-
-		if (rte_intr_dev_fd_set(intr_handle, vfio_dev_fd))
-			return -rte_errno;
+		if (rte_intr_fd_set(intr_handle, fd) ||
+				rte_intr_type_set(intr_handle, RTE_INTR_HANDLE_VFIO_MSI) ||
+				rte_intr_dev_fd_set(intr_handle, vfio_dev_fd)) {
+			int error = -rte_errno;
+
+			close(fd);
+			rte_intr_fd_set(intr_handle, -1);
+			rte_intr_dev_fd_set(intr_handle, -1);
+			return error;
+		}
 
 		return 0;
 	}
-- 
2.54.0

