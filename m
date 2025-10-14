Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A523CCD187
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 09:15:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E18540650;
	Tue, 14 Oct 2025 11:15:49 +0200 (CEST)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTP id 18156402DA;
 Tue, 14 Oct 2025 11:15:48 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id A427CEC0256;
 Tue, 14 Oct 2025 05:15:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 14 Oct 2025 05:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1760433347; x=
 1760519747; bh=RogLKhvwL13ujXhBZsa3W8Z/MD52cBsXcDI5jbOYcvk=; b=T
 +9iXsf9p+2n7cyy2h0LXXyV2nzuMnzoyU8hA5Xb4+ru2f2DtOLrg+SlOuT2Cacz/
 EbK4/8DY2RZgwmGDxZtnq82LRskZaBMF096ZtIjvMrZBtCYF0CAKDc2ryNllDObg
 bEm7/QAAp0y+mlRIDi/nCj9VZiiz3vOG3fn3JrYkoe1r5W7BIv1jnZVXcrKA98Mj
 +Z6wakBGD41NEO1VYY0XZGpmeDHe4Liz9yhxvlT02ZE5jkksS+1gmW+57OsXqO1Q
 QUurrBWakn43CBKdXt/Ha6/y1aAnP2xjUuYUroAMxQVdNZ5cEIl819E/BKPUiA/y
 iRtvi+FzdSiaM/tsjQ2PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1760433347; x=1760519747; bh=R
 ogLKhvwL13ujXhBZsa3W8Z/MD52cBsXcDI5jbOYcvk=; b=GS5fvqLCHa6UB7cu6
 KiymavBYJohsz4bRB9B25ERLO69ZpnszTbVdqF/858EzL7waYSuA8rTPtxrd6sRg
 yywiDtKMKs4Lc/GhVPYeWTSivijwOuTGdgGbcH+mRqGbD52eP3f5RTtCsLm7RvU8
 kJUo6v7mfqKqYGzRnOBcDIYT9lvucpZLBT65HylF9rvqhbQ+Pdhl0w6EuiHg8ein
 ErvePKOPXssRFTam1qfZXT+mG1onvAHM8KOMxYvnJhk7bum7WY+yXs9P0/b95F/+
 /UGsiZGZyezK8sc/K0Z1YMpfyHXdkfY/Ui7LGsDEk7PhH2hjY4tneJLn6eLn/L17
 hPhEw==
X-ME-Sender: <xms:wxTuaAFUQUSWr29QSN_tW4xGCtuEAuPNUPm--5_9Q8lsmKTMWwJ1QQ>
 <xme:wxTuaIalnp711nm0tizgyKEjYEyMX6wuVtm9RcM3qkpMe-yASAQbgBSi5NCU8QCYL
 vuUk_VICUioVLsjgiLYbbfIZFgqTSqq-_yJjvoUoc9pjOUxXpx4Qxs>
X-ME-Received: <xmr:wxTuaAWcV3GvlJeqQIjilGEnBHepm5b5IUJ3letqUVZKxhWDO3fuh8m4CYFkk8Sp2zTEgcunvX1KxG6edhWHXnWyiwHEv6I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtudegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphht
 thhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtoheptghhvghnsghogiesnh
 hvihguihgrrdgtohhmpdhrtghpthhtohepnhhiphhunhdrghhuphhtrgesrghmugdrtgho
 mhdprhgtphhtthhopehrohhrvghtiihlrgeslhhinhhugidrmhhitghrohhsohhfthdrtg
 homhdprhgtphhtthhopegumhhithhrhidrkhhoiihlihhukhesghhmrghilhdrtghomhdp
 rhgtphhtthhopehrrghnjhhithdrmhgvnhhonhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:wxTuaOkJ_5fQiWYt0z87651vrijcpMW9C8oTWkn76CYnjFsGE0oRlg>
 <xmx:wxTuaLAciTOp92x938NyyjX33S75Ad8CEz4khB_RLADodjYQ6o2t1Q>
 <xmx:wxTuaNhUHxSMYj3sz346h41rfmY-1s94qk7etYp7VKHBECGsHIcNMQ>
 <xmx:wxTuaIyAdMFEniDbiBrmXdLZP6SG0VjKiDrkNjEEMkNwQNcCrJ9Pyw>
 <xmx:wxTuaDKioUoWTIHZ24Oi-88U2XoyEVmd3X_BnQ5m-BRN8HQApU_0uOre>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 05:15:46 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, stable@dpdk.org,
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Ranjit Menon <ranjit.menon@intel.com>
Subject: [PATCH v4 1/3] bus/pci: fix build with MinGW 13
Date: Tue, 14 Oct 2025 11:13:59 +0200
Message-ID: <20251014091528.936405-2-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014091528.936405-1-thomas@monjalon.net>
References: <20250813152829.457463-1-thomas@monjalon.net>
 <20251014091528.936405-1-thomas@monjalon.net>
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
without defining the expected NetUIO constants.

The case MinGW64 is added to define NetUIO constants.

Some comments are improved to better track includes requirements.

Fixes: 6605c7f02e24 ("bus/pci: fix build with Windows SDK >= 10.0.20253")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/bus/pci/windows/pci.c        | 11 ++++++-----
 drivers/bus/pci/windows/pci_netuio.h |  6 +++---
 2 files changed, 9 insertions(+), 8 deletions(-)

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
diff --git a/drivers/bus/pci/windows/pci_netuio.h b/drivers/bus/pci/windows/pci_netuio.h
index 2f6c97ea73..8ac914920f 100644
--- a/drivers/bus/pci/windows/pci_netuio.h
+++ b/drivers/bus/pci/windows/pci_netuio.h
@@ -5,12 +5,12 @@
 #ifndef _PCI_NETUIO_H_
 #define _PCI_NETUIO_H_
 
-#if !defined(NTDDI_WIN10_FE) || NTDDI_VERSION < NTDDI_WIN10_FE
-/* GUID definition for device class netUIO */
+#if !defined(NTDDI_WIN10_FE) || NTDDI_VERSION < NTDDI_WIN10_FE ||  defined(__MINGW64__)
+/* GUID_DEVCLASS_NETUIO should be defined in devguid.h */
 DEFINE_GUID(GUID_DEVCLASS_NETUIO, 0x78912bc1, 0xcb8e, 0x4b28,
 	0xa3, 0x29, 0xf3, 0x22, 0xeb, 0xad, 0xbe, 0x0f);
 
-/* GUID definition for the netuio device interface */
+/* GUID_DEVINTERFACE_NETUIO should be defined in ndisguid.h */
 DEFINE_GUID(GUID_DEVINTERFACE_NETUIO, 0x08336f60, 0x0679, 0x4c6c,
 	0x85, 0xd2, 0xae, 0x7c, 0xed, 0x65, 0xff, 0xf7);
 #endif
-- 
2.51.0

