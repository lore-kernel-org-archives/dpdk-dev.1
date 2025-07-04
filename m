Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862DDC83030
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Jul 2025 08:45:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5025B4028B;
	Fri,  4 Jul 2025 10:45:17 +0200 (CEST)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id DF85240267
 for <dev@dpdk.org>; Fri,  4 Jul 2025 10:45:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1751618715;
 bh=bHNkOFEv4Cr401RJquS7Xiq/s05HtdrZojGvByBBEqI=;
 h=From:To:Cc:Subject:Date;
 b=AH8ZOskaSVlJ8QVSFUn73IltOcbBr2SE6I72/tijhfeCGxn/krNJJbipctsqpz5pR
 XsREdXVw4j+7YEj605SJ39CtX9fd0rGRATiuvVJHKAIqeRA2VXcsN2CieFL2xYYKcY
 yjFCFXthZsFUB5B8Q7vV2KjylN+xy92SqrYvdb+DUaWDy25kooNWu1gX/xWgt9Tba6
 l1ZclyzyxXJapuih7cmjQxqR5DcdUgaQnwUiQpl//S6uP83/C7crt5i3wmfRpKjyKj
 8PuPonqqeuP8/8edKpFQ+92c2V/KGOCbbUi0s9xtfix5s4pnUgfYw4DWUoS9ldQdps
 8MFY/skfE8ITQ==
Received: from T480.localdomain (178-143-32-21.static.orange.sk
 [178.143.32.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id DA9851180080;
 Fri,  4 Jul 2025 10:45:14 +0200 (CEST)
From: Mario Kuka <kuka@cesnet.cz>
To: Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Cc: dev@dpdk.org,
	Mario Kuka <kuka@cesnet.cz>
Subject: [PATCH] mbuf: add new ptype for slow protocols
Date: Fri,  4 Jul 2025 10:45:01 +0200
Message-ID: <20250704084502.237979-1-kuka@cesnet.cz>
X-Mailer: git-send-email 2.43.0
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

Introduce a new ptype for identifying slow protocol packets.

Signed-off-by: Mario Kuka <kuka@cesnet.cz>
---
 dts/framework/remote_session/testpmd_shell.py | 2 ++
 lib/mbuf/rte_mbuf_ptype.c                     | 1 +
 lib/mbuf/rte_mbuf_ptype.h                     | 7 +++++++
 3 files changed, 10 insertions(+)

diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index ac99bd09ef..8c3dda3ab4 100644
--- a/dts/framework/remote_session/testpmd_shell.py
+++ b/dts/framework/remote_session/testpmd_shell.py
@@ -1046,6 +1046,8 @@ class RtePTypes(Flag):
     L2_ETHER_FCOE = auto()
     #: MPLS packet type.
     L2_ETHER_MPLS = auto()
+    #: Ethernet packet type for Slow Protocols.
+    L2_ETHER_SLOW = auto()
     #: No L2 packet information.
     L2_UNKNOWN = auto()
 
diff --git a/lib/mbuf/rte_mbuf_ptype.c b/lib/mbuf/rte_mbuf_ptype.c
index 2c80294498..6f5926344f 100644
--- a/lib/mbuf/rte_mbuf_ptype.c
+++ b/lib/mbuf/rte_mbuf_ptype.c
@@ -23,6 +23,7 @@ const char *rte_get_ptype_l2_name(uint32_t ptype)
 	case RTE_PTYPE_L2_ETHER_PPPOE: return "L2_ETHER_PPPOE";
 	case RTE_PTYPE_L2_ETHER_FCOE: return "L2_ETHER_FCOE";
 	case RTE_PTYPE_L2_ETHER_MPLS: return "L2_ETHER_MPLS";
+	case RTE_PTYPE_L2_ETHER_SLOW: return "L2_ETHER_SLOW";
 	default: return "L2_UNKNOWN";
 	}
 }
diff --git a/lib/mbuf/rte_mbuf_ptype.h b/lib/mbuf/rte_mbuf_ptype.h
index c46a94f89f..66c4eeb954 100644
--- a/lib/mbuf/rte_mbuf_ptype.h
+++ b/lib/mbuf/rte_mbuf_ptype.h
@@ -144,6 +144,13 @@ extern "C" {
  * <'ether type'=[0x8847|0x8848]>
  */
 #define RTE_PTYPE_L2_ETHER_MPLS             0x0000000a
+/**
+ * Ethernet packet type for Slow Protocols.
+ *
+ * Packet format:
+ * <'ether type'=[0x8809]>
+ */
+#define RTE_PTYPE_L2_ETHER_SLOW             0x0000000b
 /**
  * Mask of layer 2 packet types.
  * It is used for outer packet for tunneling cases.
-- 
2.43.0

