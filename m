Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F099DC531CF
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:19:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E686740689;
	Thu, 23 Jul 2026 15:19:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id DAA7B40274
 for <dev@dpdk.org>; Thu, 23 Jul 2026 15:19:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784812764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+jZK6K96QesmkQETjSySvm8UVAjdHRxgUgqWdpSV8cc=;
 b=IHB8xxijPyAz6rtGse3NKtXoL1pmvjyIXz24oGS7nmp4lWvrO3jeB8Id4+3FgANIn05vZq
 uSpMBgZCUpwfwO1F1DbA+FXFhdROYJ4AXbY/U4RW2qpfLxFpBCdEjZsmp93inEPYYTztOm
 LyQHAbFtvZevBo16KlDo7kbZifVAw/0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-2vOoJO01PwW4Fn_ofNBG7Q-1; Thu,
 23 Jul 2026 09:19:21 -0400
X-MC-Unique: 2vOoJO01PwW4Fn_ofNBG7Q-1
X-Mimecast-MFC-AGG-ID: 2vOoJO01PwW4Fn_ofNBG7Q_1784812760
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C674A1945CA7; Thu, 23 Jul 2026 13:19:19 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C9E13000225; Thu, 23 Jul 2026 13:19:17 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: hkalra@marvell.com, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: [RFC 1/4] bus/pci: fix check on interrupt FD for FreeBSD
Date: Thu, 23 Jul 2026 15:19:04 +0200
Message-ID: <20260723131908.3313223-2-david.marchand@redhat.com>
In-Reply-To: <20260723131908.3313223-1-david.marchand@redhat.com>
References: <20260723131908.3313223-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vUB1LUmMpPYgpwXAPaNIqt6cvUT5HBnIYYKPbguY964_1784812760
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

A 0 file descriptor is valid. And a negative value is not.
Only close a positive file descriptor.

Fixes: 5a60a7ffc801 ("pci: introduce functions to alloc and free uio resource")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/pci/bsd/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/pci/bsd/pci.c b/drivers/bus/pci/bsd/pci.c
index c6df31d486..bbe08605af 100644
--- a/drivers/bus/pci/bsd/pci.c
+++ b/drivers/bus/pci/bsd/pci.c
@@ -93,7 +93,7 @@ pci_uio_free_resource(struct rte_pci_device *dev,
 {
 	rte_free(uio_res);
 
-	if (rte_intr_fd_get(dev->intr_handle)) {
+	if (rte_intr_fd_get(dev->intr_handle) >= 0) {
 		close(rte_intr_fd_get(dev->intr_handle));
 		rte_intr_fd_set(dev->intr_handle, -1);
 		rte_intr_type_set(dev->intr_handle, RTE_INTR_HANDLE_UNKNOWN);
-- 
2.54.0

