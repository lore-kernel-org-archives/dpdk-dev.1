Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7346BC02196
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 08:33:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8FC7427C1;
	Fri,  7 Feb 2025 09:33:15 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 174CE427C0
 for <dev@dpdk.org>; Fri,  7 Feb 2025 09:33:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738917193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pRyfhKpU327LAZSKwaKAzat/YlIjCz55Lm6lAfubx7A=;
 b=MgxGS387nmPWiGgBdyVaFSfuepxahE4JuW+4Nt8W68vkHUkWu/RQ2999Qt++iYOs8Fw04B
 9aAKudPqZi2dI3ZkGR3KHLeRSMqhalPkmp9Z5SRE8Eygc2hrNGM/SwMnyrr9H2R5+bR2k3
 NXNlFRW+un19Z8w0PFTuXm7SY+ZUJQ0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-XeV1UI8EP466LW1mxhQHFg-1; Fri,
 07 Feb 2025 03:33:08 -0500
X-MC-Unique: XeV1UI8EP466LW1mxhQHFg-1
X-Mimecast-MFC-AGG-ID: XeV1UI8EP466LW1mxhQHFg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D2661800878; Fri,  7 Feb 2025 08:33:07 +0000 (UTC)
Received: from dmarchan.com (unknown [10.45.224.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F2C31800570; Fri,  7 Feb 2025 08:33:04 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com, Kai Ji <kai.ji@intel.com>
Subject: [RFC 02/10] common/qat: remove weak symbols
Date: Fri,  7 Feb 2025 09:32:42 +0100
Message-ID: <20250207083252.3131588-3-david.marchand@redhat.com>
In-Reply-To: <20250207083252.3131588-1-david.marchand@redhat.com>
References: <20250207083252.3131588-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AFoga6Nybf8LXOSK77nTlfv02l7C2KhiV4YWjGEYSQ4_1738917187
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

Remove dead code, those symbols are never used as the "strong" symbols
are always linked in.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/common/qat/qat_qp.c | 8 --------
 drivers/common/qat/qat_qp.h | 5 -----
 2 files changed, 13 deletions(-)

diff --git a/drivers/common/qat/qat_qp.c b/drivers/common/qat/qat_qp.c
index 4bf9bac23e..0d2bbdb8a5 100644
--- a/drivers/common/qat/qat_qp.c
+++ b/drivers/common/qat/qat_qp.c
@@ -944,11 +944,3 @@ qat_cq_get_fw_cipher_crc_cap(struct qat_qp *qp)
 	return ret;
 }
 #endif
-
-__rte_weak int
-qat_comp_process_response(void **op __rte_unused, uint8_t *resp __rte_unused,
-			  void *op_cookie __rte_unused,
-			  uint64_t *dequeue_err_count __rte_unused)
-{
-	return  0;
-}
diff --git a/drivers/common/qat/qat_qp.h b/drivers/common/qat/qat_qp.h
index f0ea907503..5ccaedefa7 100644
--- a/drivers/common/qat/qat_qp.h
+++ b/drivers/common/qat/qat_qp.h
@@ -156,11 +156,6 @@ int
 qat_cq_get_fw_cipher_crc_cap(struct qat_qp *qp);
 #endif
 
-/* Needed for weak function*/
-int
-qat_comp_process_response(void **op __rte_unused, uint8_t *resp __rte_unused,
-			  void *op_cookie __rte_unused,
-			  uint64_t *dequeue_err_count __rte_unused);
 int
 qat_read_qp_config(struct qat_pci_device *qat_dev);
 
-- 
2.48.1

