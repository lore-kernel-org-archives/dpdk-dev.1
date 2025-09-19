Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08229CAC59A
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 19:03:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42E1640658;
	Fri, 19 Sep 2025 21:03:41 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 38A2B4042F
 for <dev@dpdk.org>; Fri, 19 Sep 2025 21:03:39 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id DA2FFEC025F;
 Fri, 19 Sep 2025 15:03:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Fri, 19 Sep 2025 15:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm1; t=1758308618; x=1758395018; bh=0XP+2L1fY+xyatODCjMlB
 IDZ+cic0c4USZx89S2wf5A=; b=XYV7XguKx8wcwlXXsUABAJkdwgqj4ajfw45Fl
 h9EoXtBqSPnEmNX21aS7hDkIp0Kgbv+H9HXsOzGC4Sb2X80ZgkXw70UIIk1ssS5N
 kWu+Ss/YwSHIU+3Yph5huaOKRBppIZLPGwshH/N2+Q3+tQWzhiejZhpNFTdmY6+n
 Rxa8c+pd97I1K9hgW3TVQvutJORxZ6fsCJvCtq+b4lioDp4AYDjaaB5MQfXywram
 LVFkfoaVGFNhE/QPONrxwe8fgUr0WEIeOVjN4WkwiMCA8XOfOZSZtIwIxGQIOC8/
 idyqq/yfV01EV8vcYw0fvc8+ipVcZJ4a7avtvR4IhAXVkDdIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1758308618; x=1758395018; bh=0XP+2L1fY+xyatODCjMlBIDZ+cic0c4USZx
 89S2wf5A=; b=YFK7s91ZKuoTosUP1D15smFpg+ySP28X1uYFvJkS4krpmBEIJ5z
 5z+aKTvcjaQiE5P1lQ5v3mdtKOCXgeE5AFp8sCHT1GLkTrX4Ph1aZSEn6uQqwBFH
 nWpru0+P8y+NRiSFFwa3XNMByPl1NeUDecEy9SK78C0TZmF4nxWD03/Emgp+oZ9H
 Mt58a8mYaYO8YkzhdJEDYK3FwB158tior93R1dpuNvxZXnaJxIcTw/VkQG7Ty7qk
 slVA8iyMEbr2izAMJdLQhn3Bemjdcy0tue/TT1lTZzBF9/BLUeKCTLbr3DTgVQov
 VN8yxzY5w/MgtyHvNpyOIUAwzi/7vgAQ7KA==
X-ME-Sender: <xms:CqnNaPTEEpCtKekQUH5_JRCkDf0AKhlSFXxTAWTBGAqaTc1qnGEVzg>
 <xme:CqnNaIZvu9EvPcpEZM7UF73KGtoYAeOU1ftPlivkLGLFUxUui8Q2GNcKVyBz3n_Jb
 6G0Vy8OLAKopIEv9A>
X-ME-Received: <xmr:CqnNaCfb8URrcZsE5btKgpm9UFxAAA862bQrQgiPv7v_wV6luU0aSk557KBPzgsx3jTE79D8Zvv1hG4SUs9DSU8kZuJxxJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehtddttdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvhhhomhgrshcuofho
 nhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrth
 htvghrnhepveevfeevieeihfetudekgeekleeigeffueekveduteeuffeiudevteeiudek
 feelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepth
 hhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggv
 pehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtoh
 epkhgrihdrjhhisehinhhtvghlrdgtohhmpdhrtghpthhtohepphgrsghlohdruggvrdhl
 rghrrgdrghhurghrtghhsehinhhtvghlrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrh
 hitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepkhhonhhsthgrnhht
 ihhnrdgrnhgrnhihvghvsehhuhgrfigvihdrtghomhdprhgtphhtthhopehvlhgrughimh
 hirhdrmhgvughvvggukhhinhesihhnthgvlhdrtghomhdprhgtphhtthhopeihihhpvghn
 ghdurdifrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehsrghmvghhrdhgohgsrh
 hivghlsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:CqnNaJIXYBPZfreq_7AvjXjx3r8heFKhoJ5BS5Dpox1LQzXRozn6GQ>
 <xmx:CqnNaPJSmGAK40AXwhJu3G91gZL_Io2Q3Pc-bB_ZeVCMqJBK6yfc2g>
 <xmx:CqnNaIVLt3bRfPQcw-3C3l8LBiH_1naXXHwW9CTMpJvi5Jqk4lmUJg>
 <xmx:CqnNaImjOA9aj4EmwmxaDPiqrNTXmZ1okvZFYbe0zkc2uheXNkQ9gw>
 <xmx:CqnNaDpmeM4GQEt-bmZHPJ63N71IzgWiAAaEt746sFWYWmTr5rM_XgVk>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 15:03:37 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Kai Ji <kai.ji@intel.com>, Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>
Subject: [PATCH] eal/x86: remove useless include from spinlock header
Date: Fri, 19 Sep 2025 21:02:26 +0200
Message-ID: <20250919190226.1840008-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
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

rte_cpuflags.h is not used in rte_spinlock.h,
so it is removed, and added back in .c files where needed.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 drivers/crypto/ipsec_mb/ipsec_mb_private.c | 1 +
 lib/eal/x86/include/rte_spinlock.h         | 1 -
 lib/eal/x86/rte_power_intrinsics.c         | 1 +
 lib/fib/trie.c                             | 1 +
 lib/member/rte_member_ht.c                 | 1 +
 lib/member/rte_member_sketch.c             | 1 +
 6 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ipsec_mb/ipsec_mb_private.c b/drivers/crypto/ipsec_mb/ipsec_mb_private.c
index 0d2538832d..b4c36e7f58 100644
--- a/drivers/crypto/ipsec_mb/ipsec_mb_private.c
+++ b/drivers/crypto/ipsec_mb/ipsec_mb_private.c
@@ -5,6 +5,7 @@
 #include <bus_vdev_driver.h>
 #include <rte_common.h>
 #include <rte_cryptodev.h>
+#include <rte_cpuflags.h>
 #include <rte_errno.h>
 
 #include "ipsec_mb_private.h"
diff --git a/lib/eal/x86/include/rte_spinlock.h b/lib/eal/x86/include/rte_spinlock.h
index a14da41964..273bbdc39c 100644
--- a/lib/eal/x86/include/rte_spinlock.h
+++ b/lib/eal/x86/include/rte_spinlock.h
@@ -7,7 +7,6 @@
 
 #include "generic/rte_spinlock.h"
 #include "rte_rtm.h"
-#include "rte_cpuflags.h"
 #include "rte_branch_prediction.h"
 #include "rte_common.h"
 #include "rte_pause.h"
diff --git a/lib/eal/x86/rte_power_intrinsics.c b/lib/eal/x86/rte_power_intrinsics.c
index 1cb2e908c0..489ad3983f 100644
--- a/lib/eal/x86/rte_power_intrinsics.c
+++ b/lib/eal/x86/rte_power_intrinsics.c
@@ -10,6 +10,7 @@
 #include <rte_lcore_var.h>
 #include <rte_rtm.h>
 #include <rte_spinlock.h>
+#include <rte_cpuflags.h>
 
 #include "rte_power_intrinsics.h"
 
diff --git a/lib/fib/trie.c b/lib/fib/trie.c
index 24a08b827d..ff4c750952 100644
--- a/lib/fib/trie.c
+++ b/lib/fib/trie.c
@@ -8,6 +8,7 @@
 
 #include <rte_debug.h>
 #include <rte_malloc.h>
+#include <rte_cpuflags.h>
 #include <rte_errno.h>
 
 #include <rte_rib6.h>
diff --git a/lib/member/rte_member_ht.c b/lib/member/rte_member_ht.c
index 738471b378..8c89a949c8 100644
--- a/lib/member/rte_member_ht.c
+++ b/lib/member/rte_member_ht.c
@@ -8,6 +8,7 @@
 #include <rte_random.h>
 #include <rte_log.h>
 #include <rte_vect.h>
+#include <rte_cpuflags.h>
 
 #include "member.h"
 #include "rte_member.h"
diff --git a/lib/member/rte_member_sketch.c b/lib/member/rte_member_sketch.c
index 15af6786e9..b753bac1bd 100644
--- a/lib/member/rte_member_sketch.c
+++ b/lib/member/rte_member_sketch.c
@@ -12,6 +12,7 @@
 #include <rte_log.h>
 #include <rte_random.h>
 #include <rte_prefetch.h>
+#include <rte_cpuflags.h>
 #include <rte_ring_elem.h>
 
 #include "member.h"
-- 
2.51.0

