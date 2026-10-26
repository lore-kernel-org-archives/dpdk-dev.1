Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3763C606A323
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 18:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GENNU8++
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2764F40613;
	Mon, 26 Oct 2026 19:10:46 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id F1A4040678
 for <dev@dpdk.org>; Mon, 26 Oct 2026 19:10:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793038244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0sRMZUsbADMUJNN4uafpSqP+Pc7V8ARQIFz0g0s+H1s=;
 b=GENNU8++M4TVXgq4baaw265kmBqe5wNHxXnnwS4vdoN3ZpBU1fbtJy7COPlR7YZD/+sn9D
 GKFY7uzzXERThs4f2OJBPQX/6xIZdeUDWDAsicyFzVzmJLam6rQp004Ez1TjY8gDgx7B9y
 COEp0pnJsfiBeA8pybnH8zPizJ/Nme8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-JyFXFjPePSSiWdFAnGPiOw-1; Mon,
 26 Oct 2026 14:10:42 -0400
X-MC-Unique: JyFXFjPePSSiWdFAnGPiOw-1
X-Mimecast-MFC-AGG-ID: JyFXFjPePSSiWdFAnGPiOw_1793038241
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80EBC1955EBA; Mon, 26 Oct 2026 18:10:41 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B262E1956088; Mon, 26 Oct 2026 18:10:40 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Subject: [PATCH v2 02/16] drivers/bus: fix FD leak during scan in NXP drivers
Date: Mon, 26 Oct 2026 19:10:16 +0100
Message-ID: <20261026181031.304100-3-david.marchand@redhat.com>
In-Reply-To: <20261026181031.304100-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20261026181031.304100-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CLoRleVi8cWbuv3apvTLp0YRm1qz7YU6NnuA1V-U4qY_1793038241
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

