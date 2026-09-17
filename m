Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3D4C982C1
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 07:49:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D26BE427D5;
	Thu, 17 Sep 2026 09:49:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8F9B5400D5
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:49:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789631379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UUlnthVppk3QEC+AY897J/A7gmtvizujoRkuQRNDq/Q=;
 b=gMG8i+I0Q6fzXJgwf4OdprZ6LuAT334ITdVRoGzbyZoqv6tUbHCRVpcE1fUquua/TdT7as
 eNkR6uyZ+RwrJL+nxOvhlslpb510BGySvuX7V0sMeinUCVt+SZfOKzOq6B68fXQGPQVbl1
 5vZWkTEN7gk02h88cxe/6age6Say6OI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-AsJ4AqEUNeKgtaCsEOLCTA-1; Thu,
 17 Sep 2026 03:49:33 -0400
X-MC-Unique: AsJ4AqEUNeKgtaCsEOLCTA-1
X-Mimecast-MFC-AGG-ID: AsJ4AqEUNeKgtaCsEOLCTA_1789631372
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7AC851800663; Thu, 17 Sep 2026 07:49:32 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 04A73180049F; Thu, 17 Sep 2026 07:49:30 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>, Hyong Youb Kim <hyonkim@cisco.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [RFC v2 02/16] drivers/bus: fix FD leak during scan in NXP drivers
Date: Thu, 17 Sep 2026 09:49:02 +0200
Message-ID: <20260917074917.595603-3-david.marchand@redhat.com>
In-Reply-To: <20260917074917.595603-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20260917074917.595603-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fL2oI41A6Xx1Gxrk7XDd-F2sWe0JSss2dWg52ZlXPrA_1789631372
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
index 412b70e5ae..165e9444f5 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -1371,14 +1371,16 @@ rte_dpaa2_vfio_setup_intr(struct rte_intr_handle *intr_handle,
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

