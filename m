Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521ADC0219E
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Feb 2025 17:29:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C0214066A;
	Sun,  9 Feb 2025 18:29:11 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D1D0F4065A
 for <dev@dpdk.org>; Sun,  9 Feb 2025 18:29:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739122149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pRyfhKpU327LAZSKwaKAzat/YlIjCz55Lm6lAfubx7A=;
 b=OoyZPPPG97iIBvEUS8uoIG7IM6W35E4EAbLDsJ9Nr/Wyvt0avF/QABkUL4Nv7/JHo3pFy+
 mIvEb6RP48Cfc+loNxnT1l0P/e9tcl9WVkL7ioAFXwxOnjY4SxTb+EUIlMqpTmLmrI/vLb
 nrNfoyNRHBLac6PWb37vletAxw/T6Bs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-sLNgTc_DOauEEhOXg1Zgvw-1; Sun,
 09 Feb 2025 12:29:06 -0500
X-MC-Unique: sLNgTc_DOauEEhOXg1Zgvw-1
X-Mimecast-MFC-AGG-ID: sLNgTc_DOauEEhOXg1Zgvw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4A78195608B; Sun,  9 Feb 2025 17:29:04 +0000 (UTC)
Received: from dmarchan.com (unknown [10.44.32.76])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AE0A130001AB; Sun,  9 Feb 2025 17:29:02 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com, Kai Ji <kai.ji@intel.com>
Subject: [RFC v2 02/10] common/qat: remove weak symbols
Date: Sun,  9 Feb 2025 18:28:40 +0100
Message-ID: <20250209172850.2429075-3-david.marchand@redhat.com>
In-Reply-To: <20250209172850.2429075-1-david.marchand@redhat.com>
References: <20250207083252.3131588-1-david.marchand@redhat.com>
 <20250209172850.2429075-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vFLZMC1tK2Yb_mnhOhzcA7SULsHi76gkVAqmZj0FqHo_1739122145
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

