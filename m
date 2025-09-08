Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3235CAC582
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 21:20:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A3E540648;
	Mon,  8 Sep 2025 23:20:51 +0200 (CEST)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id 4BE1B40648;
 Mon,  8 Sep 2025 23:20:50 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id C440A140015A;
 Mon,  8 Sep 2025 17:20:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Mon, 08 Sep 2025 17:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1757366449; x=
 1757452849; bh=cGHpCIMaM2OGPYwUVTTw7X3M0DdnrYBNHNU05xYB3mA=; b=Q
 3KLKdgBMWtwyxj3trwKQgZ2+AFIA2l22Ki6gfIbzmfBdp2nMuOl25XSKoe5R7HJf
 8AR58dRcUF2gMB2W4WxRzNlP8JegqAvbS+KzawQdg99TFmrYZNec32OGB0z1acyG
 QnSo3ZHhz49rgHM9QH4IumKFhkeIBJCc0EeERyhtnYKxKeoZlMO3R+dPAtt4GFEr
 cHZbiakrCi4KuLcb/Mpg9g1mefTOQrE/v4yVQOtJMaBU5XCsI7lRr0iG1IE0OTgm
 ZqSBI1GFJDxNyXMdeIxaYoifOI07Of7JFK0Syd1ww6JpcVn7ME0UwnU5I4Aly5ky
 6FkbExjX80ybyuziAG4/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1757366449; x=1757452849; bh=c
 GHpCIMaM2OGPYwUVTTw7X3M0DdnrYBNHNU05xYB3mA=; b=fKFAzQthctoD3U9Ip
 rnQIxWIa+EEdkAvUbXtyToPEncDr0XlejsrdNaiEV9qWnEiLCcU/l+Tbwnd04srq
 8w0BcXLftoTfa6EPnQk1HBoBeYLplOguZHdOsUr5yo2yEPT8ZuEVokXbFjWyTEZ7
 6dfEh02CHElaSu/33sc42utRzjCeIIE1Ns5ocijIsOf2JlBFJ/2G2fZYJQ+B3cRs
 UB3jaBEPLxixoZoDNXDrPR7e8t942C9JhXJZtqD+mHddPWcd2VLAnxpdSgfBTObf
 4lFWpu4d1Zjjoz718vDetO8EFwSXEPvPedTva8JzVFC15NNh4j/XLnuwH+M8wk99
 pTuWw==
X-ME-Sender: <xms:sUi_aBV1ui3vTqJXaZp30zHiomgGQcerLmw13t_5qpdHpeFgosl6Ng>
 <xme:sUi_aOh1fbY8Xb_dEdAgwkxPNeAXPJAlX9JcGzmbB7WOavVhInVXvJ3LWukXBlMJW
 DNEYEBQvkSIrwgG4A>
X-ME-Received: <xmr:sUi_aJDBIsKD50SMC1JE48Z3lRBLD3p0EnMtrZe4LFZj_QGlN9fVHkVa2luPn9JQkRxiugsaY2zhj2pOUfzqIv7Yq-Q1afg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeitdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepvdejhfdugeehvddtieejieegteeuudfgjeeukeeiledthfetveekhefh
 ieelhfdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepkedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpth
 htohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthht
 ohepshhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopegthhgvnhgsohigsehnvh
 hiughirgdrtghomhdprhgtphhtthhopehnihhpuhhnrdhguhhpthgrsegrmhgurdgtohhm
 pdhrtghpthhtoheprhgrnhhjihhtrdhmvghnohhnsehinhhtvghlrdgtohhmpdhrtghpth
 htohepughmihhtrhihrdhkohiilhhiuhhksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
 rhhorhgvthiilhgrsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhm
X-ME-Proxy: <xmx:sUi_aMtYslvJmOsArScPQmcqkyAPz1j8XGW-S7b2ep1kI9FVBsyuaw>
 <xmx:sUi_aFcukgwm-qe9yX5um3AZlSvgKaV0iYdtnReYDovP-reRFip3pg>
 <xmx:sUi_aJ8111x5PvBvtsD2R_V3WOVyRQQAIG9PhKC3e-xplb1M98-I3w>
 <xmx:sUi_aASPFmWKV5QwADXJVzmIwWZbw_sQ5C6yk_GdKxbIEMtrNpWEVg>
 <xmx:sUi_aDChiH5HyFKY4Gx0ZvNfEcA22c3etDA1g6l_srOp5g_leb2pTDob>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 17:20:48 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, stable@dpdk.org,
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Ranjit Menon <ranjit.menon@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v3 1/3] bus/pci: fix build with MinGW 13
Date: Mon,  8 Sep 2025 23:17:49 +0200
Message-ID: <20250908212034.699713-2-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908212034.699713-1-thomas@monjalon.net>
References: <20250813152829.457463-1-thomas@monjalon.net>
 <20250908212034.699713-1-thomas@monjalon.net>
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

After an upgrade to MinGW version 13, some compilation errors appear:

drivers/bus/pci/windows/pci.c:362:58:
	error: 'GUID_DEVCLASS_NETUIO' undeclared
drivers/bus/pci/windows/pci_netuio.c:57:39:
	error: 'GUID_DEVINTERFACE_NETUIO' undeclared

The cause is MinGW has set NTDDI_VERSION to the highest version
without defining the expected NETUIO constants.

It is safer to not rely on Windows headers version,
and instead define what is not already defined,
after including Windows headers.

Fixes: 6605c7f02e24 ("bus/pci: fix build with Windows SDK >= 10.0.20253")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
v3: try to fix Windows build by moving includes
---
 drivers/bus/pci/windows/pci.c        | 11 ++++++-----
 drivers/bus/pci/windows/pci_netuio.c |  6 ------
 drivers/bus/pci/windows/pci_netuio.h | 13 ++++++++++---
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/bus/pci/windows/pci.c b/drivers/bus/pci/windows/pci.c
index e7e449306e..6f6f368cb7 100644
--- a/drivers/bus/pci/windows/pci.c
+++ b/drivers/bus/pci/windows/pci.c
@@ -12,18 +12,19 @@
 #include <rte_memory.h>
 #include <rte_bus_pci.h>
 
-#include "private.h"
-#include "pci_netuio.h"
-
+/* DEVPKEY_Device_Numa_Node should be defined in devpkey.h */
 #include <devpkey.h>
-#include <regstr.h>
-
 #if defined RTE_TOOLCHAIN_GCC && (__MINGW64_VERSION_MAJOR < 8)
 #include <devpropdef.h>
 DEFINE_DEVPROPKEY(DEVPKEY_Device_Numa_Node, 0x540b947e, 0x8b40, 0x45bc,
 	0xa8, 0xa2, 0x6a, 0x0b, 0x89, 0x4c, 0xbd, 0xa2, 3);
 #endif
 
+#include <regstr.h>
+
+#include "private.h"
+#include "pci_netuio.h"
+
 /*
  * This code is used to simulate a PCI probe by parsing information in
  * the registry hive for PCI devices.
diff --git a/drivers/bus/pci/windows/pci_netuio.c b/drivers/bus/pci/windows/pci_netuio.c
index 346b2f4c0a..db75475f92 100644
--- a/drivers/bus/pci/windows/pci_netuio.c
+++ b/drivers/bus/pci/windows/pci_netuio.c
@@ -10,12 +10,6 @@
 #include <rte_eal.h>
 #include <rte_bus_pci.h>
 
-#ifdef __MINGW32__
-#include <ddk/ndisguid.h>
-#else
-#include <ndisguid.h>
-#endif
-
 #include "private.h"
 #include "pci_netuio.h"
 
diff --git a/drivers/bus/pci/windows/pci_netuio.h b/drivers/bus/pci/windows/pci_netuio.h
index 2f6c97ea73..0421de3854 100644
--- a/drivers/bus/pci/windows/pci_netuio.h
+++ b/drivers/bus/pci/windows/pci_netuio.h
@@ -5,12 +5,19 @@
 #ifndef _PCI_NETUIO_H_
 #define _PCI_NETUIO_H_
 
-#if !defined(NTDDI_WIN10_FE) || NTDDI_VERSION < NTDDI_WIN10_FE
-/* GUID definition for device class netUIO */
+/* GUID_DEVCLASS_NETUIO should be defined in devguid.h */
+#ifndef GUID_DEVCLASS_NETUIO
 DEFINE_GUID(GUID_DEVCLASS_NETUIO, 0x78912bc1, 0xcb8e, 0x4b28,
 	0xa3, 0x29, 0xf3, 0x22, 0xeb, 0xad, 0xbe, 0x0f);
+#endif
 
-/* GUID definition for the netuio device interface */
+/* GUID_DEVINTERFACE_NETUIO should be defined in ndisguid.h */
+#ifdef __MINGW32__
+#include <ddk/ndisguid.h>
+#else
+#include <ndisguid.h>
+#endif
+#ifndef GUID_DEVINTERFACE_NETUIO
 DEFINE_GUID(GUID_DEVINTERFACE_NETUIO, 0x08336f60, 0x0679, 0x4c6c,
 	0x85, 0xd2, 0xae, 0x7c, 0xed, 0x65, 0xff, 0xf7);
 #endif
-- 
2.51.0

