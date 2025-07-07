Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43B0C8303C
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 07:51:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86D4340287;
	Mon,  7 Jul 2025 09:51:11 +0200 (CEST)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 9362B4025D
 for <dev@dpdk.org>; Mon,  7 Jul 2025 09:51:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1751874669;
 bh=LXR/QmdjoCwC/hcTEj3eA5xG07k4UhukuRxUGfyTxrc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=U0JXvlZk47eLvDzz2jCbdyY4T9XroIMHIgtkMU9RlKNR6WrBSVPDOkwYc22SVPDjs
 FOQnOd0nqRhTeA6+4k/i4x0TJXM51urph3lfd2ep0f7AIHfemAq43qtZ/IhoEzIclh
 GNu5vWORKDutdgXx+NyT2FHOQJbzNncXwiws7BrAqIJ+I3LJmcaNcggdrStAr0D7N1
 Y1TgVPGC5Kmptzh9/3YsNqkxT0/k957NP1d74k/RyQFu5TXoSdt1oYoXdv5IBQ2wrI
 NSrA/TC9L533K5T9NAr+oaQFfzaluwoTakpl60evD9bVDv9oRI9KG68p31yt5G/Dti
 ZpAJzQnUTJZsg==
Received: from T480.localdomain (178-143-32-119.static.orange.sk
 [178.143.32.119])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 44B9C1180080;
 Mon,  7 Jul 2025 09:51:09 +0200 (CEST)
From: Mario Kuka <kuka@cesnet.cz>
To: dev@dpdk.org
Cc: Mario Kuka <kuka@cesnet.cz>
Subject: [PATCH v2] mbuf: add new ptype for slow protocols
Date: Mon,  7 Jul 2025 09:51:00 +0200
Message-ID: <20250707075100.15034-1-kuka@cesnet.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704084502.237979-1-kuka@cesnet.cz>
References: <20250704084502.237979-1-kuka@cesnet.cz>
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
* Added 'destination mac'=01-80-C2-00-00-02 required by slow protocols.
* Change ether type value from optional to mandatory.

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
index c46a94f89f..b38b4d91be 100644
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
+ * <'destination mac'=01-80-C2-00-00-02, 'ether type'=0x8809>
+ */
+#define RTE_PTYPE_L2_ETHER_SLOW             0x0000000b
 /**
  * Mask of layer 2 packet types.
  * It is used for outer packet for tunneling cases.
-- 
2.43.0

