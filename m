Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F85606A31A
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 13:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fVUacDHX
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2D89406BA;
	Sat, 24 Oct 2026 15:22:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id ACE0540A67
 for <dev@dpdk.org>; Sat, 24 Oct 2026 15:22:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792848149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w09nLSzFj2tfsB+a7LpdPe3YS5Ih8hxGwUDgwVPxeeM=;
 b=fVUacDHXdn4b3DkH8sZKlVvLHIMNnyT+ieGSl6wDmhb/PXQZEOP5jHJ0nWJd/GWpG/wptx
 Je5Na1cVYZfqnRi0ZKZwN2l7X3tqwQc81BDCO9jaP1Y+NnUrNhxEcvLLv29NUY86MqSrpb
 VERQlz0xgbXjgcV69N2ImfeXd05xHjY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-_FD-tESFO0aNBXZkx5JcnQ-1; Sat,
 24 Oct 2026 09:22:23 -0400
X-MC-Unique: _FD-tESFO0aNBXZkx5JcnQ-1
X-Mimecast-MFC-AGG-ID: _FD-tESFO0aNBXZkx5JcnQ_1792848142
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9EFA11955DCB; Sat, 24 Oct 2026 13:22:22 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C9008180057F; Sat, 24 Oct 2026 13:22:20 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, hkalra@marvell.com, anatoly.burakov@intel.com,
 Rosen Xu <rosen.xu@altera.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v2 09/12] raw/ifpga: reset FD in interrupt handle
Date: Sat, 24 Oct 2026 15:21:34 +0200
Message-ID: <20261024132138.7239-10-david.marchand@redhat.com>
In-Reply-To: <20261024132138.7239-1-david.marchand@redhat.com>
References: <20261021092318.1554295-1-david.marchand@redhat.com>
 <20261024132138.7239-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Z47hr9wJKEQlpjad_flYgdWetVeiPTKfAt5i7BHdJ3o_1792848142
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

The interrupt handle fd points to efd[0] which is already closed
by rte_intr_efd_disable(). Clear the FD reference before freeing
the interrupt handle to avoid a spurious leak warning.

Fixes: d770ee9caed0 ("interrupts: warn on leaked FDs")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/raw/ifpga/ifpga_rawdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/raw/ifpga/ifpga_rawdev.c b/drivers/raw/ifpga/ifpga_rawdev.c
index c4143bfb3e..d44141824f 100644
--- a/drivers/raw/ifpga/ifpga_rawdev.c
+++ b/drivers/raw/ifpga/ifpga_rawdev.c
@@ -1421,6 +1421,8 @@ ifpga_unregister_msix_irq(struct ifpga_rawdev *dev, enum ifpga_irq_type type,
 			type == IFPGA_FME_IRQ ? "FME" : "AFU",
 			type == IFPGA_FME_IRQ ? 0 : vec_start);
 	} else {
+		/* fd was pointing to efd[0] which is closed by rte_intr_efd_disable(). */
+		rte_intr_fd_set(*intr_handle, -1);
 		rte_intr_instance_free(*intr_handle);
 		*intr_handle = NULL;
 	}
-- 
2.54.0

