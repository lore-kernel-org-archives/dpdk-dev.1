Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3230C87FCF
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 15:29:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C86F540EDF;
	Wed, 13 Aug 2025 17:29:01 +0200 (CEST)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id 29E0540265;
 Wed, 13 Aug 2025 17:29:00 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id A3A98EC0191;
 Wed, 13 Aug 2025 11:28:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 13 Aug 2025 11:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1755098939; x=
 1755185339; bh=AkIM9L3odG6kBKxI0eVyirmMgUyIqKIU/rN0YQyHWSU=; b=H
 VQgsITQuGDW1RFc/JC8SI5s2s/hF/wbbgIH1hvbeGaIVMMNNnnS9krq+KBvFuGSe
 fkkeh49gZ7wbHodKyy9iGhDjcKW8DS2mwOzPN9x3eK2rLypk4Mc+04bsHte4t7f8
 RKbJDUU7edxJGxNeEPbVE/0fcQYB2zG/RuBoSZLVf2ocgnj8dMWE7aaC+xqeG9MR
 Wquiwvf04oKaccH7i4Hzt+3b9DE4ZASKmNSGSeCyvKQt+ejhPKtf7RdA95hrjzmD
 5/ZEPSgrbc6wK2kYZ95eS7UDl2cioBhFvlGpm5X0hzKgZ7MalVEGupgB2d09PDtV
 jrOp8eE4sRe41KZHeD0YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1755098939; x=1755185339; bh=A
 kIM9L3odG6kBKxI0eVyirmMgUyIqKIU/rN0YQyHWSU=; b=AbtTDhesytVvBRULc
 E9XQ/m2byis4i8muXcdo0rnpQwrqlnM3kYuNHAK2Ky5qgBfA/BHh5IPpVIHUijZq
 C4SVvHHNSeM+DGIA5w++P57TUTqqUV4mFMro6xTYWk0qvRHG2600daYHDSzW7gbi
 s+8fU2oTp5WwAXra07RqvKrkAzoMRs8B750OVwJaxsQfwDrUGY4LI1MenZxPhEzr
 NS6TMOeqgkr4+WRWWecYfB0mA/SD4lY59jZnfmV3wOtdpJehpFE7fcLU2JYbxbsw
 a/lwGBiH5tpj3AC2W3/1CZR+98wseT3gK3ICjh/vZpCjaGbsyq57qyophSb9Oaa9
 3KR8Q==
X-ME-Sender: <xms:O6-caFt0j5vd1Sb3ogEOV318qjUqA7N7D76HyaclGzYCW9A8oworvw>
 <xme:O6-caMAoxjfuiYUVTxDQ6RcmFIOaX3aCDlMmcZ4UurlhjXaLvtlxMC6e_49jzk7oo
 bbOGFPelxDlqzS9Hg>
X-ME-Received: <xmr:O6-caPNHq2cgSaNO3bySxogMz7ggQXm1RQyYUOgPGYMyqgelGUQdJNNaJF7Yb_OK3iau9hkYFL9kC2s_yOfvIOcSnrJNNnk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeekheejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtoheptghhvghnsghogies
 nhhvihguihgrrdgtohhmpdhrtghpthhtohepnhhiphhunhdrghhuphhtrgesrghmugdrtg
 homhdprhgtphhtthhopegumhhithhrhidrkhhoiihlihhukhesghhmrghilhdrtghomhdp
 rhgtphhtthhopehrohhrvghtiihlrgeslhhinhhugidrmhhitghrohhsohhfthdrtghomh
 dprhgtphhtthhopehrrghnjhhithdrmhgvnhhonhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:O6-caNzISlzNcGzbxH6ZfiKjY6OEvs3T9POkXt1KTDtx_ntOYdzAIQ>
 <xmx:O6-caHWNasEoNzp9PTJJopmj3frWUzyYe2yzQgwOZ-s8VSMjMdisLQ>
 <xmx:O6-caHO0K2fjsllqDtbLURKoZSeBZGQYVEvyhH90DFjc0gjUuZ0SFw>
 <xmx:O6-caBAiKNQFrsNi3tM5DN2eIk7lPvsYwgmEPDs-Yg4yQBPj4s71gw>
 <xmx:O6-caGQoVNSaACQ1-pGotrcMkoMNsnuMQ7AxLPKrGzvXiepscEKpiC7F>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 11:28:58 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: stable@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Ranjit Menon <ranjit.menon@intel.com>
Subject: [PATCH 1/3] bus/pci: fix build with MinGW 13
Date: Wed, 13 Aug 2025 17:25:23 +0200
Message-ID: <20250813152829.457463-2-thomas@monjalon.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250813152829.457463-1-thomas@monjalon.net>
References: <20250813152829.457463-1-thomas@monjalon.net>
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

