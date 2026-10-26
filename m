Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EF4606A325
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 18:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cmrUSnlg
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9775340A6D;
	Mon, 26 Oct 2026 19:11:10 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 0758D4068A
 for <dev@dpdk.org>; Mon, 26 Oct 2026 19:11:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793038267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wy+wmfzIGEvAYGjF4fkyx0a4SRpbVx14xUNMvPpSaWk=;
 b=cmrUSnlgBya3j4GoDUR9W4IRB2ooFa/bb3oilp0dxTLaIPa9YLkcT4kwtp2mZwL3aSjdQa
 NFyuVrmIaXjWDV4pgm79vc6P4H5xXbeqAeDi+1lA1s57OxnyjP3uDipWygVj5MU5Q+zNgI
 L6S4I1Ef1JLXiwEflQykQtM2nL80xXk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-MxQBJAhbNumTlEmkxEaUIQ-1; Mon,
 26 Oct 2026 14:11:05 -0400
X-MC-Unique: MxQBJAhbNumTlEmkxEaUIQ-1
X-Mimecast-MFC-AGG-ID: MxQBJAhbNumTlEmkxEaUIQ_1793038264
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0C501955EB6; Mon, 26 Oct 2026 18:11:04 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DD43E30000E7; Mon, 26 Oct 2026 18:11:03 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Subject: [PATCH v2 09/16] bus/fslmc: fix interrupt leak in DPIO cleanup
Date: Mon, 26 Oct 2026 19:10:23 +0100
Message-ID: <20261026181031.304100-10-david.marchand@redhat.com>
In-Reply-To: <20261026181031.304100-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20261026181031.304100-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MfvBLTAWi0CbJBtBvELJQ5BkBNLQ7WScuo_IU4zV0AQ_1793038264
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

The interrupt handle in the DPIO device is separate from the bus device
object handle. The cleanup code was leaking this handle and the FD it
carries.

Fixes: 274fd921ff7f ("bus/fslmc: support close operation")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v1:
- fixed FD leaks,

---
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index 9fe449ed38..2e8c660acf 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -476,6 +476,10 @@ dpaa2_close_dpio_device(int object_id)
 			rte_free(dpio_dev->dpio);
 		}
 		TAILQ_REMOVE(&dpio_dev_list, dpio_dev, next);
+		rte_intr_fd_close(dpio_dev->intr_handle);
+		/* dev_fd is closed by caller, clear reference here. */
+		rte_intr_dev_fd_set(dpio_dev->intr_handle, -1);
+		rte_intr_instance_free(dpio_dev->intr_handle);
 		rte_free(dpio_dev);
 	}
 }
@@ -668,6 +672,9 @@ dpaa2_create_dpio_device(int vdev_fd,
 		rte_free(dpio_dev->dpio);
 	}
 
+	rte_intr_fd_close(dpio_dev->intr_handle);
+	/* dev_fd is closed by caller, clear reference here. */
+	rte_intr_dev_fd_set(dpio_dev->intr_handle, -1);
 	rte_intr_instance_free(dpio_dev->intr_handle);
 	rte_free(dpio_dev);
 
@@ -680,6 +687,9 @@ dpaa2_create_dpio_device(int vdev_fd,
 				dpio_dev->token);
 			rte_free(dpio_dev->dpio);
 		}
+		rte_intr_fd_close(dpio_dev->intr_handle);
+		/* dev_fd is closed by caller, clear reference here. */
+		rte_intr_dev_fd_set(dpio_dev->intr_handle, -1);
 		rte_intr_instance_free(dpio_dev->intr_handle);
 		rte_free(dpio_dev);
 	}
-- 
2.54.0

