Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB624CA0EFF
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 15:18:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5A2240648;
	Wed, 27 Aug 2025 17:18:09 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 0E67D40608;
 Wed, 27 Aug 2025 17:18:09 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 7A7A8EC00BD;
 Wed, 27 Aug 2025 11:18:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 27 Aug 2025 11:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1756307888; x=
 1756394288; bh=Mx3mKYILH9KzmJ/aySecQNbIxhekC+NATjjkfiUOjik=; b=g
 4wz3dDJh32O/lqB+PtmRaw/vBSIKaaLvebG0HOiWTipyhJjY2Ss8aBLArOLWcOf5
 wAREElFmS0ZhFI2QQw6eBBaFSPzUD6PFJmQyntS0xEL2cBoSKoGYB+xf+8jf28kV
 4vQ89WN++l5bDljATVlgTDmBa4TphU8yj/lf1b5nXVXRWHSGNctfK81zo2m2jY+x
 O/HpJsYiOpJYvOMVmn9i/JEfKsYv213n32pc8Bt/wZDoHsgFi4ZAyvgSfsVBjpbP
 RU50au6DlJrSj7dJdm+zE5H9OlMAdgz7RTkK5k/F3m7PwBVW4ygS3KT8s0J92Ud9
 TXYQuj5M8kHpcsZLCO1AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1756307888; x=1756394288; bh=M
 x3mKYILH9KzmJ/aySecQNbIxhekC+NATjjkfiUOjik=; b=lgyqe18deAdntkWAF
 BT38c1zcn8J64lqsS/IknA/HfFARpLPh7epJ4HgH++CW0OCUzEluydHLN07XfAua
 I3WT2A/klIavI+C3MF38wuUBHG/EV3pqwYvOjtUwhtWfz5cL0rvSD2fg68FMzXDq
 SvmT4ocD0TWCh70RRMd3YvJpIXyDTvhChb1F15Srqe+h8xPKxtTi3cfQoAqowUCB
 xbYTkPlMsc567PHS71+DTDcUfrjE0ZOB6zG7bekKw5h3d1owUQxucc9HR4CpEoeD
 qDwxoV2vENqRtbNGdTt0UfCQMUuK11LYU62+oPqBlaKLExScE3aC1UeAkTXHKFx5
 4ND4A==
X-ME-Sender: <xms:sCGvaHrsQ1XcqoF1FslKwLJN8dErp65IUod2ho92Iiw2fSvDTpVlOw>
 <xme:sCGvaOkJZrQh3btHODAl8sojxJoe8LiZIY9I5KHvt7XE9MfIvpau2zij7PRvhRw90
 _gAto3K1aOa6UmmdQ>
X-ME-Received: <xmr:sCGvaP2rDiI3p5usziGpzehR509kSMzExQSlZfrhx-eeWbOGNB9gNBy_yaRrT5enNtDdwBX3-jwq3q76ZYhZJAnbGqDNNA0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekgeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphht
 thhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtoheptghhvghnsghogiesnh
 hvihguihgrrdgtohhmpdhrtghpthhtohepnhhiphhunhdrghhuphhtrgesrghmugdrtgho
 mhdprhgtphhtthhopehrrghnjhhithdrmhgvnhhonhesihhnthgvlhdrtghomhdprhgtph
 htthhopegumhhithhrhidrkhhoiihlihhukhesghhmrghilhdrtghomhdprhgtphhtthho
 pehrohhrvghtiihlrgeslhhinhhugidrmhhitghrohhsohhfthdrtghomh
X-ME-Proxy: <xmx:sCGvaDQXP8qBbzK-xNK35OYELATigMWXmZFCOG3Xo1IAAMpUIVmr2Q>
 <xmx:sCGvaAyXXSiOHmKz7z8KIOMO0tcY9X0rdAyw_rnoq6TBt-Qh3xUEmQ>
 <xmx:sCGvaLBoYW8PQAH0HSm3hIWGtzKW-PhuLkan-Y2i-cq_db6U-HHyeA>
 <xmx:sCGvaEGTe0V5HI4ZWV2_l1Nd08Rhmf22DP1lE-Yjm31YoAQzMweT9A>
 <xmx:sCGvaL3rRGMRHJ3QRdd6kcErIGMMM53gTtDmqdNzcpwU3VNaKy-KpiSu>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 11:18:07 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, stable@dpdk.org,
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Ranjit Menon <ranjit.menon@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v2 1/3] bus/pci: fix build with MinGW 13
Date: Wed, 27 Aug 2025 17:16:41 +0200
Message-ID: <20250827151759.1448018-2-thomas@monjalon.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250827151759.1448018-1-thomas@monjalon.net>
References: <20250813152829.457463-1-thomas@monjalon.net>
 <20250827151759.1448018-1-thomas@monjalon.net>
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
and instead define what is not already defined.

Fixes: 6605c7f02e24 ("bus/pci: fix build with Windows SDK >= 10.0.20253")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/bus/pci/windows/pci_netuio.c | 6 ------
 drivers/bus/pci/windows/pci_netuio.h | 4 +++-
 2 files changed, 3 insertions(+), 7 deletions(-)

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
index 2f6c97ea73..c600da80b1 100644
--- a/drivers/bus/pci/windows/pci_netuio.h
+++ b/drivers/bus/pci/windows/pci_netuio.h
@@ -5,11 +5,13 @@
 #ifndef _PCI_NETUIO_H_
 #define _PCI_NETUIO_H_
 
-#if !defined(NTDDI_WIN10_FE) || NTDDI_VERSION < NTDDI_WIN10_FE
+#ifndef GUID_DEVCLASS_NETUIO
 /* GUID definition for device class netUIO */
 DEFINE_GUID(GUID_DEVCLASS_NETUIO, 0x78912bc1, 0xcb8e, 0x4b28,
 	0xa3, 0x29, 0xf3, 0x22, 0xeb, 0xad, 0xbe, 0x0f);
+#endif
 
+#ifndef GUID_DEVINTERFACE_NETUIO
 /* GUID definition for the netuio device interface */
 DEFINE_GUID(GUID_DEVINTERFACE_NETUIO, 0x08336f60, 0x0679, 0x4c6c,
 	0x85, 0xd2, 0xae, 0x7c, 0xed, 0x65, 0xff, 0xf7);
-- 
2.47.1

