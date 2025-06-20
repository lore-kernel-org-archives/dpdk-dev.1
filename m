Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B47C7115D
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 11:47:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E5DF42E47;
	Fri, 20 Jun 2025 13:47:21 +0200 (CEST)
Received: from ns2.wilbury.net (ns2.wilbury.net [92.60.51.55])
 by mails.dpdk.org (Postfix) with ESMTP id 7EB16402F2
 for <dev@dpdk.org>; Fri, 20 Jun 2025 13:47:19 +0200 (CEST)
Received: from webmail.wilbury.net (localhost [IPv6:::1])
 (Authenticated sender: priikone@silc.fi)
 by svc.wilbury.net (Postfix) with ESMTPA id BD0B561F90
 for <dev@dpdk.org>; Fri, 20 Jun 2025 13:47:17 +0200 (CEST)
MIME-Version: 1.0
Date: Fri, 20 Jun 2025 14:47:17 +0300
From: priikone@iki.fi
To: dev@dpdk.org
Subject: [PATCH] bus/pci: fix automatic interrupt type selection
User-Agent: Roundcube Webmail/1.6.10
Message-ID: <8f5b22d3bedef793bf489c230b52b145@iki.fi>
X-Sender: priikone@iki.fi
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
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

Check if kernel returns 0 interrupt vectors and try another interrupt
type in that case.  Failing to check the vector count can select an
interrupt type that's unusable.

Signed-off-by: Pekka Riikonen <priikone@iki.fi>
---
  drivers/bus/pci/linux/pci_vfio.c | 4 ++++
  1 file changed, 4 insertions(+)

diff --git a/drivers/bus/pci/linux/pci_vfio.c 
b/drivers/bus/pci/linux/pci_vfio.c
index 5317170231..02e7d7e40b 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -237,6 +237,10 @@ pci_vfio_setup_interrupts(struct rte_pci_device 
*dev, int vfio_dev_fd)
                                 continue;
                 }

+               /* If no vectors, try another one */
+               if (irq.count == 0)
+                       continue;
+
                 /* Reallocate the efds and elist fields of intr_handle 
based
                  * on PCI device MSIX size.
                  */
--
2.34.1
