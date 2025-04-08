Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F226CC36010
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 18:30:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE0204026B;
	Tue,  8 Apr 2025 20:30:44 +0200 (CEST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id 7B9A940267
 for <dev@dpdk.org>; Tue,  8 Apr 2025 20:30:43 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-730517040a9so7195596b3a.0
 for <dev@dpdk.org>; Tue, 08 Apr 2025 11:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744137042;
 x=1744741842; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xPTdzgGVpla2euujeX7Fo64TSKgoQ0Lxovf0AWM9/gU=;
 b=wh4R1IdrCOHaDOFCYFGaZieaoBEkxoGpYtPi2Uqw4kh9dEatQAv1HX+oL5zh1FewEw
 5f1iUGmpo4VzBG799ACphTv0ZT5+B47J1HyDwmnMNhbS1cC/G2EmldPUYyBe3eicqVQO
 XnnRV3y9/kYoZz64FGB2ER89F2v+hcIPJtDo63zZDKpp4igY0WBcOJHYUsNtwEGTftm1
 ffGT3Lmh/3eyZGnGDy1IWExp1R4sKEYWBGCqZamulTSxaHDndmn9ZMV8EI+RaWYHyPaZ
 xVkVqZYnOBmRLBdas98iGn5vPqVScpKswFa64/fgMrrM1tBoY9X3AixtFH6ZDaS24oqP
 C9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744137042; x=1744741842;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xPTdzgGVpla2euujeX7Fo64TSKgoQ0Lxovf0AWM9/gU=;
 b=kNAXwskdj2xTg1KAnC65pA7JRjs2TYP3rg2iUjhXaGYaTqBZEdx89Qmjo8iQW5s+gj
 SAj424SRintutmuuvBDF0vt4glcm3avdjMduUm318IyRPxMyskWcnQd6Kg6WGa3phZ7o
 95n7fMSSP3Be+EIcYWNJHMtuxRiQk0WvhLUXVbw7wDqoF5CxbV2gv6d+XJFoYYiF3bW4
 uOwltizJv2ibeXku00poELuZ29R/x2A1uvytYc429VcxMeB8Cot+1gzapSuMnzGuF3lo
 ZkKlcyDtxRtFb1J5jtDpeSVr/edM+s0pFcaFQsJRzSFkfiF9/jL/tBbMCrzT+SogccJN
 AecQ==
X-Gm-Message-State: AOJu0YxydT78qkUIHv3VyiqQwztv5nqaqoqqPlL0ASsLbCSbK52UeGOU
 E+2dWRSgJ7gNvlqsiQI0ZeKUJoKgZOLWKam8bdRHzD+IST4KDlZvWmZcVXfpxxDSMoFimmA9qLC
 x
X-Gm-Gg: ASbGncsWDRq6yb32jaQxHa1Lj6bVIEIYfOyCZkRbNHglejiO4MkVOpo2XHGhczA2qGx
 7kT9Pyg86RtEruzOjOy+uDE1PzEnDc7ksdkPUiE1IJS3jR1955LPuBBxpj/thY/2+gmNSs8e6AV
 WIRuwGDWUS/a2UTI1zrwrTHvR0mFMWCuQ1rh3vh3bknEg6OODW8uRxv/Krvr9o20Tmj4GExerVJ
 IbmNPlKIG8Fm9l6tANSbuTUVYBKGtgswH5kRik9OjCU8mDuxcozEXQuBqs+Tm3dkn/qyq7SQmLB
 5Afu4iepvQzy6WXnro2YKyB8RduD0SY1P1UrDPUS0zntxtuldgh17pDmCPm+RbTOQQYOAaLG8HR
 RVrQWFqnrPhLL1DnumIis
X-Google-Smtp-Source: AGHT+IEULGrrJ06YARoLpmJApf4lr/CrXI2rtn/A0QbLkcqelCmDTqrWMo5y52QzADR/B03oj6WWww==
X-Received: by 2002:a05:6a00:3d02:b0:736:491b:536d with SMTP id
 d2e1a72fcca58-73bae54e3dfmr59992b3a.20.1744137042149; 
 Tue, 08 Apr 2025 11:30:42 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739da0dedd4sm10872886b3a.166.2025.04.08.11.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 11:30:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [RFC] eal: remove support for I/O port
Date: Tue,  8 Apr 2025 11:30:32 -0700
Message-ID: <20250408183032.86167-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

In early days of virtio, the x86 I/O instructions were used
to ring the doorbell for host access. To support these DPDK
needed to enable IO access. This is no longer necessary and
the vestiage can be marked deprecated.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/deprecation.rst   |  4 ++++
 drivers/bus/pci/linux/pci_uio.c        | 15 ++-------------
 drivers/net/virtio/virtio_pci_ethdev.c |  1 -
 lib/eal/include/rte_eal.h              |  9 ++++-----
 lib/eal/linux/eal.c                    |  7 -------
 5 files changed, 10 insertions(+), 26 deletions(-)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 36489f6e68..473148b5c7 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -142,3 +142,7 @@ Deprecation Notices
 * bus/vmbus: Starting DPDK 25.11, all the vmbus API defined in
   ``drivers/bus/vmbus/rte_bus_vmbus.h`` will become internal to DPDK.
   Those API functions are used internally by DPDK core and netvsc PMD.
+
+* eal: No devices in DPDK currently use I/O port access (inb, outb)
+  and therefore the function to enable I/O port access rte_eal_iopl_init()
+  is deprecated and will be removed in 25.11 release.
diff --git a/drivers/bus/pci/linux/pci_uio.c b/drivers/bus/pci/linux/pci_uio.c
index 4c1d3327a9..1914ecd34e 100644
--- a/drivers/bus/pci/linux/pci_uio.c
+++ b/drivers/bus/pci/linux/pci_uio.c
@@ -412,19 +412,8 @@ pci_uio_ioport_map(struct rte_pci_device *dev, int bar,
 		goto error;
 
 	if (flags & IORESOURCE_IO) {
-		if (rte_eal_iopl_init()) {
-			PCI_LOG(ERR, "%s(): insufficient ioport permissions for PCI device %s",
-				__func__, dev->name);
-			goto error;
-		}
-
-		base = (unsigned long)phys_addr;
-		if (base > PIO_MAX) {
-			PCI_LOG(ERR, "%s(): %08lx too large PIO resource", __func__, base);
-			goto error;
-		}
-
-		PCI_LOG(DEBUG, "%s(): PIO BAR %08lx detected", __func__, base);
+		PCI_LOG(DEBUG, "%s(): PIO BAR %" PRIx64" ignored", __func__, phys_addr);
+		goto error;
 	} else if (flags & IORESOURCE_MEM) {
 		base = (unsigned long)dev->mem_resource[bar].addr;
 		PCI_LOG(DEBUG, "%s(): MMIO BAR %08lx detected", __func__, base);
diff --git a/drivers/net/virtio/virtio_pci_ethdev.c b/drivers/net/virtio/virtio_pci_ethdev.c
index 9b4b846f8a..abb04abba1 100644
--- a/drivers/net/virtio/virtio_pci_ethdev.c
+++ b/drivers/net/virtio/virtio_pci_ethdev.c
@@ -233,7 +233,6 @@ static struct rte_pci_driver rte_virtio_net_pci_pmd = {
 
 RTE_INIT(rte_virtio_net_pci_pmd_init)
 {
-	rte_eal_iopl_init();
 	rte_pci_register(&rte_virtio_net_pci_pmd);
 }
 
diff --git a/lib/eal/include/rte_eal.h b/lib/eal/include/rte_eal.h
index c826e143f1..8d28e9f914 100644
--- a/lib/eal/include/rte_eal.h
+++ b/lib/eal/include/rte_eal.h
@@ -15,6 +15,7 @@
 #include <time.h>
 
 #include <rte_config.h>
+#include <rte_common.h>
 #include <rte_compat.h>
 #include <rte_per_lcore.h>
 #include <rte_uuid.h>
@@ -49,12 +50,10 @@ enum rte_proc_type_t rte_eal_process_type(void);
 /**
  * Request iopl privilege for all RPL.
  *
- * This function should be called by pmds which need access to ioports.
-
- * @return
- *   - On success, returns 0.
- *   - On failure, returns -1.
+ * This function was used by pmds which need access to ioports.
+ * No longer used.
  */
+__rte_deprecated
 int rte_eal_iopl_init(void);
 
 /**
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 20f777b8b0..2f1523ffdb 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -20,9 +20,6 @@
 #include <limits.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
-#if defined(RTE_ARCH_X86)
-#include <sys/io.h>
-#endif
 #include <linux/version.h>
 
 #include <rte_common.h>
@@ -825,10 +822,6 @@ RTE_EXPORT_SYMBOL(rte_eal_iopl_init)
 int
 rte_eal_iopl_init(void)
 {
-#if defined(RTE_ARCH_X86)
-	if (iopl(3) != 0)
-		return -1;
-#endif
 	return 0;
 }
 
-- 
2.47.2

