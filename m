Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC12CC531FC
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Jul 2026 07:02:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B61364060B;
	Mon, 27 Jul 2026 09:02:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 27CB54060F
 for <dev@dpdk.org>; Mon, 27 Jul 2026 09:02:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785135743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hnvt5LYxemJfXvDZz+6TPRgt+xrT28k7HLbO1g8prvQ=;
 b=XRmLAW41bTPDjuruwkZuzEyWbsAwU2Vj3I29eWXwDJKJSeQxfigkagS/k7jVL3A5NNs5Se
 yfKZCsdnVs0E6oWoSUdMEpLLExap5VxXMyaQDkwiNYkS7VlMHSccJkLVgWgQwYNKJBSYcX
 FcI0En/COqzKDvED16V+GP2KS+Z1IFI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-ZYdzxifUNCW-r3zq0Yf2fA-1; Mon,
 27 Jul 2026 03:02:21 -0400
X-MC-Unique: ZYdzxifUNCW-r3zq0Yf2fA-1
X-Mimecast-MFC-AGG-ID: ZYdzxifUNCW-r3zq0Yf2fA_1785135740
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7768E1955F3B; Mon, 27 Jul 2026 07:02:20 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 18CC7429; Mon, 27 Jul 2026 07:02:18 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Chenbo Xia <chenbox@nvidia.com>,
	Gaetan Rivet <grive@u256.net>
Subject: [PATCH 2/2] pci: remove deprecated catch-all flag
Date: Mon, 27 Jul 2026 09:02:09 +0200
Message-ID: <20260727070210.1281566-2-david.marchand@redhat.com>
In-Reply-To: <20260727070210.1281566-1-david.marchand@redhat.com>
References: <20260727070210.1281566-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6eNvYNVwbbS-bqUIsAYygjkmwa7SQH8PfThYSpOm5Yw_1785135740
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

This flag got replaced by RTE_PCI_ID_ANY in v21.05.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 doc/guides/rel_notes/release_26_11.rst | 1 +
 lib/pci/rte_pci.h                      | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 8fbbe50b16..87c7e81bde 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -74,6 +74,7 @@ Removed Items
   * fib: ``RTE_FIB6_IPV6_ADDR_SIZE``, ``RTE_FIB6_MAXDEPTH``
   * lpm: ``RTE_LPM6_IPV6_ADDR_SIZE``, ``RTE_LPM6_MAX_DEPTH``
   * net: ``RTE_IP_ICMP_ECHO_REPLY``, ``RTE_IP_ICMP_ECHO_REQUEST``
+  * pci: ``PCI_ID_ANY``
   * rib: ``RTE_RIB6_IPV6_ADDR_SIZE``, ``get_msk_part``, ``rte_rib6_copy_addr``,
     ``rte_rib6_is_equal``
   * table: ``RTE_LPM_IPV6_ADDR_SIZE``
diff --git a/lib/pci/rte_pci.h b/lib/pci/rte_pci.h
index 9d04978a0f..a75b5327cc 100644
--- a/lib/pci/rte_pci.h
+++ b/lib/pci/rte_pci.h
@@ -187,8 +187,6 @@ struct rte_pci_addr {
 
 /** Any PCI device identifier (vendor, device, ...) */
 #define RTE_PCI_ANY_ID (0xffff)
-/** @deprecated Replaced with RTE_PCI_ANY_ID */
-#define PCI_ANY_ID RTE_DEPRECATED(PCI_ANY_ID) RTE_PCI_ANY_ID
 #define RTE_CLASS_ANY_ID (0xffffff)
 
 /**
-- 
2.54.0

