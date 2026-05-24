Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099B2CD4F54
	for <dpdk-dev@archiver.kernel.org>; Sun, 24 May 2026 09:34:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7709A4067D;
	Sun, 24 May 2026 11:33:18 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 19245402EE
 for <dev@dpdk.org>; Sun, 24 May 2026 11:33:08 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABXd97QxRJq+04kEg--.9115S7;
 Sun, 24 May 2026 17:33:05 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 05/23] drivers: support RSS feature
Date: Sun, 24 May 2026 17:32:41 +0800
Message-ID: <20260524093259.397506-6-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
References: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXd97QxRJq+04kEg--.9115S7
X-Coremail-Antispam: 1UD129KBjvAXoWfKw4fGF47WFy5ZF17JFWDJwb_yoWxCr48uo
 WfWr12q3Wjya42yw45Zr1kXa4jqw47ZF4xJan3uFs8Can2v34UKr13Ja4rAF4UWrsIvr1j
 gwn3Zay8trsrAFW8n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYK7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F
 4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4U
 JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
 IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
 M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l42
 xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
 GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI4
 8JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
 MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
 8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU1PfHUUUUU
X-Originating-IP: [118.112.177.181]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
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

From: Jie Liu <liujie5@linkdatatechnology.com>

Add support for Receive Side Scaling (RSS) to distribute incoming
traffic across multiple receive queues.

- Implement rss_hash_update and rss_hash_conf_get.
- Implement reta_update and reta_query.
- Support RSS hash configuration for IPv4, IPv6, TCP and UDP.
- Default hash key is initialized during port start.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/common/sxe2/sxe2_flow_public.h | 633 +++++++++++++++++++++++++
 drivers/net/sxe2/meson.build           |   1 +
 drivers/net/sxe2/sxe2_cmd_chnl.c       | 173 +++++++
 drivers/net/sxe2/sxe2_cmd_chnl.h       |  16 +
 drivers/net/sxe2/sxe2_drv_cmd.h        |  29 ++
 drivers/net/sxe2/sxe2_ethdev.c         |  37 ++
 drivers/net/sxe2/sxe2_ethdev.h         |   8 +
 drivers/net/sxe2/sxe2_flow_define.h    | 143 ++++++
 drivers/net/sxe2/sxe2_queue.c          |  11 +
 drivers/net/sxe2/sxe2_rss.c            | 584 +++++++++++++++++++++++
 drivers/net/sxe2/sxe2_rss.h            |  81 ++++
 drivers/net/sxe2/sxe2_txrx.h           |   4 +
 drivers/net/sxe2/sxe2_txrx_poll.c      |  85 +++-
 13 files changed, 1804 insertions(+), 1 deletion(-)
 create mode 100644 drivers/common/sxe2/sxe2_flow_public.h
 create mode 100644 drivers/net/sxe2/sxe2_flow_define.h
 create mode 100644 drivers/net/sxe2/sxe2_rss.c
 create mode 100644 drivers/net/sxe2/sxe2_rss.h

diff --git a/drivers/common/sxe2/sxe2_flow_public.h b/drivers/common/sxe2/sxe2_flow_public.h
new file mode 100644
index 0000000000..32ab2a9713
--- /dev/null
+++ b/drivers/common/sxe2/sxe2_flow_public.h
@@ -0,0 +1,633 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_FLOW_PUBLIC_H__
+#define __SXE2_FLOW_PUBLIC_H__
+#include "sxe2_osal.h"
+
+enum sxe2_flow_type {
+	SXE2_FLOW_TYPE_NONE                               = 0,
+	SXE2_FLOW_MAC_PAY                                 = 1,
+	SXE2_FLOW_MAC_IPV4_FRAG_PAY                       = 22,
+	SXE2_FLOW_MAC_IPV4_PAY                            = 23,
+	SXE2_FLOW_MAC_IPV4_UDP_PAY                        = 24,
+	SXE2_FLOW_MAC_IPV4_TCP_PAY                        = 26,
+	SXE2_FLOW_MAC_IPV4_SCTP_PAY                       = 27,
+	SXE2_FLOW_MAC_IPV4_IPV4_FRAG_PAY                  = 29,
+	SXE2_FLOW_MAC_IPV4_IPV4_PAY                       = 30,
+	SXE2_FLOW_MAC_IPV4_IPV4_UDP_PAY                   = 31,
+	SXE2_FLOW_MAC_IPV4_IPV4_TCP_PAY                   = 33,
+	SXE2_FLOW_MAC_IPV4_IPV4_SCTP_PAY                  = 34,
+	SXE2_FLOW_MAC_IPV4_IPV6_FRAG_PAY                  = 36,
+	SXE2_FLOW_MAC_IPV4_IPV6_PAY                       = 37,
+	SXE2_FLOW_MAC_IPV4_IPV6_UDP_PAY                   = 38,
+	SXE2_FLOW_MAC_IPV4_IPV6_TCP_PAY                   = 40,
+	SXE2_FLOW_MAC_IPV4_IPV6_SCTP_PAY                  = 41,
+	SXE2_FLOW_MAC_IPV4_GRE_PAY                        = 43,
+	SXE2_FLOW_MAC_IPV4_GRE_IPV4_FRAG_PAY              = 44,
+	SXE2_FLOW_MAC_IPV4_GRE_IPV4_PAY                   = 45,
+	SXE2_FLOW_MAC_IPV4_GRE_IPV4_UDP_PAY               = 46,
+	SXE2_FLOW_MAC_IPV4_GRE_IPV4_TCP_PAY               = 48,
+	SXE2_FLOW_MAC_IPV4_GRE_IPV4_SCTP_PAY              = 49,
+	SXE2_FLOW_MAC_IPV4_GRE_IPV6_FRAG_PAY              = 51,
+	SXE2_FLOW_MAC_IPV4_GRE_IPV6_PAY                   = 52,
+	SXE2_FLOW_MAC_IPV4_GRE_IPV6_UDP_PAY               = 53,
+	SXE2_FLOW_MAC_IPV4_GRE_IPV6_TCP_PAY               = 55,
+	SXE2_FLOW_MAC_IPV4_GRE_IPV6_SCTP_PAY              = 56,
+	SXE2_FLOW_MAC_IPV4_GRE_MAC_PAY                    = 58,
+	SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV4_FRAG_PAY          = 59,
+	SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV4_PAY               = 60,
+	SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV4_UDP_PAY           = 61,
+	SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV4_TCP_PAY           = 63,
+	SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV4_SCTP_PAY          = 64,
+	SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV6_FRAG_PAY          = 66,
+	SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV6_PAY               = 67,
+	SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV6_UDP_PAY           = 68,
+	SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV6_TCP_PAY           = 70,
+	SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV6_SCTP_PAY          = 71,
+	SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_PAY               = 73,
+	SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV4_FRAG_PAY     = 74,
+	SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV4_PAY          = 75,
+	SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV4_UDP_PAY      = 76,
+	SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV4_TCP_PAY      = 78,
+	SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV4_SCTP_PAY     = 79,
+	SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV6_FRAG_PAY     = 81,
+	SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV6_PAY          = 82,
+	SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV6_UDP_PAY      = 83,
+	SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV6_TCP_PAY      = 85,
+	SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV6_SCTP_PAY     = 86,
+	SXE2_FLOW_MAC_IPV6_FRAG_PAY                       = 88,
+	SXE2_FLOW_MAC_IPV6_PAY                            = 89,
+	SXE2_FLOW_MAC_IPV6_UDP_PAY                        = 90,
+	SXE2_FLOW_MAC_IPV6_TCP_PAY                        = 92,
+	SXE2_FLOW_MAC_IPV6_SCTP_PAY                       = 93,
+	SXE2_FLOW_MAC_IPV6_IPV4_FRAG_PAY                  = 95,
+	SXE2_FLOW_MAC_IPV6_IPV4_PAY                       = 96,
+	SXE2_FLOW_MAC_IPV6_IPV4_UDP_PAY                   = 97,
+	SXE2_FLOW_MAC_IPV6_IPV4_TCP_PAY                   = 99,
+	SXE2_FLOW_MAC_IPV6_IPV4_SCTP_PAY                  = 100,
+	SXE2_FLOW_MAC_IPV6_IPV6_FRAG_PAY                  = 102,
+	SXE2_FLOW_MAC_IPV6_IPV6_PAY                       = 103,
+	SXE2_FLOW_MAC_IPV6_IPV6_UDP_PAY                   = 104,
+	SXE2_FLOW_MAC_IPV6_IPV6_TCP_PAY                   = 106,
+	SXE2_FLOW_MAC_IPV6_IPV6_SCTP_PAY                  = 107,
+	SXE2_FLOW_MAC_IPV6_GRE_PAY                        = 109,
+	SXE2_FLOW_MAC_IPV6_GRE_IPV4_FRAG_PAY              = 110,
+	SXE2_FLOW_MAC_IPV6_GRE_IPV4_PAY                   = 111,
+	SXE2_FLOW_MAC_IPV6_GRE_IPV4_UDP_PAY               = 112,
+	SXE2_FLOW_MAC_IPV6_GRE_IPV4_TCP_PAY               = 114,
+	SXE2_FLOW_MAC_IPV6_GRE_IPV4_SCTP_PAY              = 115,
+	SXE2_FLOW_MAC_IPV6_GRE_IPV6_FRAG_PAY              = 117,
+	SXE2_FLOW_MAC_IPV6_GRE_IPV6_PAY                   = 118,
+	SXE2_FLOW_MAC_IPV6_GRE_IPV6_UDP_PAY               = 119,
+	SXE2_FLOW_MAC_IPV6_GRE_IPV6_TCP_PAY               = 121,
+	SXE2_FLOW_MAC_IPV6_GRE_IPV6_SCTP_PAY              = 122,
+	SXE2_FLOW_MAC_IPV6_GRE_MAC_PAY                    = 124,
+	SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV4_FRAG_PAY          = 125,
+	SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV4_PAY               = 126,
+	SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV4_UDP_PAY           = 127,
+	SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV4_TCP_PAY           = 129,
+	SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV4_SCTP_PAY          = 130,
+	SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV6_FRAG_PAY          = 132,
+	SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV6_PAY               = 133,
+	SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV6_UDP_PAY           = 134,
+	SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV6_TCP_PAY           = 136,
+	SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV6_SCTP_PAY          = 137,
+	SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_PAY               = 139,
+	SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV4_FRAG_PAY     = 140,
+	SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV4_PAY          = 141,
+	SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV4_UDP_PAY      = 142,
+	SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV4_TCP_PAY      = 144,
+	SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV4_SCTP_PAY     = 145,
+	SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV6_FRAG_PAY     = 147,
+	SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV6_PAY          = 148,
+	SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV6_UDP_PAY      = 149,
+	SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV6_TCP_PAY      = 151,
+	SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV6_SCTP_PAY     = 152,
+	SXE2_FLOW_MAC_IPV4_UDP_GTPU_PAY                   = 329,
+	SXE2_FLOW_MAC_IPV6_UDP_GTPU_PAY                   = 330,
+	SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV4_FRAG_PAY         = 331,
+	SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV4_PAY              = 332,
+	SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV4_UDP_PAY          = 333,
+	SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV4_TCP_PAY          = 334,
+	SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV4_SCTP_PAY         = 335,
+	SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV4_FRAG_PAY         = 336,
+	SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV4_PAY              = 337,
+	SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV4_UDP_PAY          = 338,
+	SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV4_TCP_PAY          = 339,
+	SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV4_SCTP_PAY         = 340,
+	SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV6_FRAG_PAY         = 341,
+	SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV6_PAY              = 342,
+	SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV6_UDP_PAY          = 343,
+	SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV6_TCP_PAY          = 344,
+	SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV6_SCTP_PAY         = 345,
+	SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV6_FRAG_PAY         = 346,
+	SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV6_PAY              = 347,
+	SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV6_UDP_PAY          = 348,
+	SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV6_TCP_PAY          = 349,
+	SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV6_SCTP_PAY         = 350,
+	SXE2_FLOW_MAC_IPV6_MAC_PAY                        = 820,
+	SXE2_FLOW_MAC_IPV6_MAC_IPV4_FRAG_PAY              = 821,
+	SXE2_FLOW_MAC_IPV6_MAC_IPV4_PAY                   = 822,
+	SXE2_FLOW_MAC_IPV6_MAC_IPV4_UDP_PAY               = 823,
+	SXE2_FLOW_MAC_IPV6_MAC_IPV4_TCP_PAY               = 824,
+	SXE2_FLOW_MAC_IPV6_MAC_IPV4_SCTP_PAY              = 825,
+	SXE2_FLOW_MAC_IPV6_MAC_IPV6_FRAG_PAY              = 827,
+	SXE2_FLOW_MAC_IPV6_MAC_IPV6_PAY                   = 828,
+	SXE2_FLOW_MAC_IPV6_MAC_IPV6_UDP_PAY               = 829,
+	SXE2_FLOW_MAC_IPV6_MAC_IPV6_TCP_PAY               = 830,
+	SXE2_FLOW_MAC_IPV6_MAC_IPV6_SCTP_PAY              = 831,
+	SXE2_FLOW_MAC_IPV6_MAC_VLAN_PAY                   = 835,
+	SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV4_FRAG_PAY         = 836,
+	SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV4_PAY              = 837,
+	SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV4_UDP_PAY          = 838,
+	SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV4_TCP_PAY          = 839,
+	SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV4_SCTP_PAY         = 840,
+	SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV6_FRAG_PAY         = 842,
+	SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV6_PAY              = 843,
+	SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV6_UDP_PAY          = 844,
+	SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV6_TCP_PAY          = 845,
+	SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV6_SCTP_PAY         = 846,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_PAY                  = 878,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV4_FRAG_PAY        = 877,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV4_PAY             = 876,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV4_UDP_PAY         = 879,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV4_TCP_PAY         = 880,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV4_SCTP_PAY        = 875,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV6_FRAG_PAY        = 871,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV6_PAY             = 870,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV6_UDP_PAY         = 872,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV6_TCP_PAY         = 873,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV6_SCTP_PAY        = 869,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_PAY                  = 891,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV4_FRAG_PAY        = 890,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV4_PAY             = 889,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV4_UDP_PAY         = 892,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV4_TCP_PAY         = 893,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV4_SCTP_PAY        = 888,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV6_FRAG_PAY        = 884,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV6_PAY             = 883,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV6_UDP_PAY         = 885,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV6_TCP_PAY         = 886,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV6_SCTP_PAY        = 882,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_PAY                    = 904,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV4_FRAG_PAY          = 903,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV4_PAY               = 902,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV4_UDP_PAY           = 905,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV4_TCP_PAY           = 906,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV4_SCTP_PAY          = 901,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV6_FRAG_PAY          = 897,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV6_PAY               = 896,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV6_UDP_PAY           = 898,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV6_TCP_PAY           = 899,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV6_SCTP_PAY          = 895,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_PAY                    = 917,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV4_FRAG_PAY          = 916,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV4_PAY               = 915,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV4_UDP_PAY           = 918,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV4_TCP_PAY           = 919,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV4_SCTP_PAY          = 914,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV6_FRAG_PAY          = 910,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV6_PAY               = 909,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV6_UDP_PAY           = 911,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV6_TCP_PAY           = 912,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV6_SCTP_PAY          = 908,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_PAY         = 930,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV4_FRAG_PAY = 929,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV4_PAY    = 928,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV4_UDP_PAY = 931,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV4_TCP_PAY = 932,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV4_SCTP_PAY = 927,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV6_FRAG_PAY = 923,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV6_PAY    = 922,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV6_UDP_PAY = 924,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV6_TCP_PAY = 925,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV6_SCTP_PAY = 921,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_PAY         = 943,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV4_FRAG_PAY = 942,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV4_PAY    = 941,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV4_UDP_PAY = 944,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV4_TCP_PAY = 945,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV4_SCTP_PAY = 940,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV6_FRAG_PAY = 936,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV6_PAY    = 935,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV6_UDP_PAY = 937,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV6_TCP_PAY = 938,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV6_SCTP_PAY = 934,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_PAY           = 956,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV4_FRAG_PAY = 955,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV4_PAY      = 954,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV4_UDP_PAY  = 957,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV4_TCP_PAY  = 958,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV4_SCTP_PAY = 953,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV6_FRAG_PAY = 949,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV6_PAY      = 948,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV6_UDP_PAY  = 950,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV6_TCP_PAY  = 951,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV6_SCTP_PAY = 947,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_PAY           = 969,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV4_FRAG_PAY = 968,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV4_PAY      = 967,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV4_UDP_PAY  = 970,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV4_TCP_PAY  = 971,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV4_SCTP_PAY = 966,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV6_FRAG_PAY = 962,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV6_PAY      = 961,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV6_UDP_PAY  = 963,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV6_TCP_PAY  = 964,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV6_SCTP_PAY = 960,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_PAY              = 982,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV4_FRAG_PAY    = 981,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV4_PAY         = 980,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV4_UDP_PAY     = 983,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV4_TCP_PAY     = 984,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV4_SCTP_PAY    = 979,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV6_FRAG_PAY    = 975,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV6_PAY         = 974,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV6_UDP_PAY     = 976,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV6_TCP_PAY     = 977,
+	SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV6_SCTP_PAY    = 973,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_PAY              = 995,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV4_FRAG_PAY    = 994,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV4_PAY         = 993,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV4_UDP_PAY     = 996,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV4_TCP_PAY     = 997,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV4_SCTP_PAY    = 992,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV6_FRAG_PAY    = 988,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV6_PAY         = 987,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV6_UDP_PAY     = 989,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV6_TCP_PAY     = 990,
+	SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV6_SCTP_PAY    = 986,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_PAY                = 1008,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV4_FRAG_PAY      = 1007,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV4_PAY           = 1006,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV4_UDP_PAY       = 1009,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV4_TCP_PAY       = 1010,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV4_SCTP_PAY      = 1005,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV6_FRAG_PAY      = 1001,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV6_PAY           = 1000,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV6_UDP_PAY       = 1002,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV6_TCP_PAY       = 1003,
+	SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV6_SCTP_PAY      = 999,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_PAY                = 1021,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV4_FRAG_PAY      = 1020,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV4_PAY           = 1019,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV4_UDP_PAY       = 1022,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV4_TCP_PAY       = 1023,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV4_SCTP_PAY      = 1018,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV6_FRAG_PAY      = 1014,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV6_PAY           = 1013,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV6_UDP_PAY       = 1015,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV6_TCP_PAY       = 1016,
+	SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV6_SCTP_PAY      = 1012,
+	SXE2_FLOW_TYPE_MAX                                = 2048,
+};
+
+enum sxe2_rss_cfg_hdr_type {
+	SXE2_RSS_OUTER_HEADERS,
+	SXE2_RSS_INNER_HEADERS,
+
+	SXE2_RSS_INNER_HEADERS_WITH_OUTER_IPV4,
+
+	SXE2_RSS_INNER_HEADERS_WITH_OUTER_IPV6,
+
+	SXE2_RSS_INNER_HEADERS_WITH_OUTER_IPV4_GRE,
+
+	SXE2_RSS_INNER_HEADERS_WITH_OUTER_IPV6_GRE,
+
+	SXE2_RSS_INNER_HEADERS_WITH_OUTER_IPV4_UDP_GRE,
+
+	SXE2_RSS_INNER_HEADERS_WITH_OUTER_IPV6_UDP_GRE,
+
+	SXE2_RSS_INNER_HEADERS_WITH_OUTER_IPV4_UDP_VXLAN,
+
+	SXE2_RSS_INNER_HEADERS_WITH_OUTER_IPV6_UDP_VXLAN,
+
+	SXE2_RSS_INNER_HEADERS_WITH_OUTER_IPV4_UDP_GENEVE,
+
+	SXE2_RSS_INNER_HEADERS_WITH_OUTER_IPV6_UDP_GENEVE,
+
+	SXE2_RSS_INNER_HEADERS_WITH_OUTER_IPV4_UDP_GTPU,
+
+	SXE2_RSS_INNER_HEADERS_WITH_OUTER_IPV6_UDP_GTPU,
+	SXE2_RSS_ANY_HEADERS
+};
+
+enum sxe2_flow_hdr {
+	SXE2_FLOW_HDR_ETH = 0,
+	SXE2_FLOW_HDR_VLAN,
+	SXE2_FLOW_HDR_QINQ,
+	SXE2_FLOW_HDR_IPV4,
+	SXE2_FLOW_HDR_IPV6,
+	SXE2_FLOW_HDR_ICMP = 5,
+	SXE2_FLOW_HDR_TCP,
+	SXE2_FLOW_HDR_UDP,
+	SXE2_FLOW_HDR_SCTP,
+	SXE2_FLOW_HDR_GRE,
+	SXE2_FLOW_HDR_VXLAN = 10,
+	SXE2_FLOW_HDR_GENEVE,
+	SXE2_FLOW_HDR_GTPU,
+
+	SXE2_FLOW_HDR_IPV_FRAG,
+
+	SXE2_FLOW_HDR_IPV_OTHER,
+
+	SXE2_FLOW_HDR_ETH_NON_IP = 15,
+	SXE2_FLOW_HDR_MAX = 128,
+};
+
+enum sxe2_flow_fld_id {
+	SXE2_FLOW_FLD_ID_ETH_DA = 0,
+	SXE2_FLOW_FLD_ID_ETH_SA,
+	SXE2_FLOW_FLD_ID_S_TCI,
+	SXE2_FLOW_FLD_ID_C_TCI,
+	SXE2_FLOW_FLD_ID_S_TPID,
+	SXE2_FLOW_FLD_ID_C_TPID = 5,
+	SXE2_FLOW_FLD_ID_S_VID,
+	SXE2_FLOW_FLD_ID_C_VID,
+	SXE2_FLOW_FLD_ID_ETH_TYPE,
+
+	SXE2_FLOW_FLD_ID_IPV4_TOS,
+	SXE2_FLOW_FLD_ID_IPV6_DSCP = 10,
+	SXE2_FLOW_FLD_ID_IPV4_TTL,
+	SXE2_FLOW_FLD_ID_IPV4_PROT,
+	SXE2_FLOW_FLD_ID_IPV6_TTL,
+	SXE2_FLOW_FLD_ID_IPV6_PROT,
+	SXE2_FLOW_FLD_ID_IPV4_SA = 15,
+	SXE2_FLOW_FLD_ID_IPV4_DA,
+	SXE2_FLOW_FLD_ID_IPV6_SA,
+	SXE2_FLOW_FLD_ID_IPV6_DA,
+	SXE2_FLOW_FLD_ID_IPV4_CHKSUM,
+	SXE2_FLOW_FLD_ID_IPV4_ID = 20,
+	SXE2_FLOW_FLD_ID_IPV6_ID,
+	SXE2_FLOW_FLD_ID_IPV6_PRE32_SA,
+	SXE2_FLOW_FLD_ID_IPV6_PRE32_DA,
+	SXE2_FLOW_FLD_ID_IPV6_PRE48_SA,
+	SXE2_FLOW_FLD_ID_IPV6_PRE48_DA = 25,
+	SXE2_FLOW_FLD_ID_IPV6_PRE64_SA,
+	SXE2_FLOW_FLD_ID_IPV6_PRE64_DA,
+
+	SXE2_FLOW_FLD_ID_TCP_SRC_PORT,
+	SXE2_FLOW_FLD_ID_TCP_DST_PORT,
+	SXE2_FLOW_FLD_ID_UDP_SRC_PORT = 30,
+	SXE2_FLOW_FLD_ID_UDP_DST_PORT,
+	SXE2_FLOW_FLD_ID_SCTP_SRC_PORT,
+	SXE2_FLOW_FLD_ID_SCTP_DST_PORT,
+	SXE2_FLOW_FLD_ID_TCP_FLAGS,
+	SXE2_FLOW_FLD_ID_TCP_CHKSUM = 35,
+	SXE2_FLOW_FLD_ID_UDP_CHKSUM,
+	SXE2_FLOW_FLD_ID_SCTP_CHKSUM,
+
+	SXE2_FLOW_FLD_ID_VXLAN_VNI,
+
+	SXE2_FLOW_FLD_ID_GENEVE_VNI,
+
+	SXE2_FLOW_FLD_ID_GTPU_TEID = 40,
+
+	SXE2_FLOW_FLD_ID_NVGRE_TNI,
+
+	SXE2_FLOW_FLD_ID_MAX = 128,
+};
+
+struct sxe2_ether_hdr {
+	uint8_t dst_addr[SXE2_ETH_ALEN];
+	uint8_t src_addr[SXE2_ETH_ALEN];
+	uint16_t  ether_type;
+};
+
+struct sxe2_vlan_hdr {
+	uint16_t  type;
+	uint16_t  vlan;
+};
+
+struct sxe2_ipv4_hdr {
+	uint8_t ver_ihl;
+	uint8_t tos;
+	uint16_t  tot_len;
+	uint16_t  id;
+	uint16_t  frag_off;
+	uint8_t ttl;
+	uint8_t protocol;
+	uint16_t  check;
+	uint32_t saddr;
+	uint32_t daddr;
+};
+#define SXE2_IPV6_ADDR_LENGTH        (16)
+#define SXE2_IPV6_TC_SHIFT (20)
+#define SXE2_IPV6_TC_MASK  (0xFF)
+
+struct sxe2_ipv6_hdr {
+	uint32_t pri_ver_flow;
+	uint16_t  payload_len;
+	uint8_t nexthdr;
+	uint8_t hop_limit;
+	union {
+		uint8_t saddr[16];
+		uint16_t	saddr16[8];
+		uint32_t	saddr32[4];
+	};
+	union {
+		uint8_t daddr[16];
+		uint16_t	daddr16[8];
+		uint32_t	daddr32[4];
+	};
+};
+
+struct sxe2_tcp_hdr {
+	uint16_t  source;
+	uint16_t  dest;
+	uint32_t seq;
+	uint32_t ack_seq;
+	uint16_t  flag;
+	uint16_t  window;
+	uint16_t  check;
+	uint16_t  urg_ptr;
+};
+
+struct sxe2_udp_hdr {
+	uint16_t  source;
+	uint16_t  dest;
+	uint16_t  len;
+	uint16_t  check;
+};
+
+struct sxe2_sctp_hdr {
+	uint16_t src_port;
+	uint16_t dst_port;
+};
+
+struct sxe2_nvgre_hdr {
+	uint16_t flags;
+	uint16_t protocol;
+	uint32_t tni;
+};
+struct sxe2_geneve_hdr {
+	uint16_t flags;
+	uint16_t protocol;
+	uint32_t vni;
+};
+struct sxe2_gtpu_hdr {
+	uint8_t flag;
+	uint8_t msg_type;
+	uint16_t msg_len;
+	uint32_t teid;
+};
+struct sxe2_vxlan_hdr {
+	uint8_t flag;
+	uint8_t resvd0;
+	uint8_t resvd1;
+	uint8_t protocol;
+	uint32_t vni;
+};
+
+enum sxe2_flow_act_type {
+	SXE2_FLOW_ACTION_DROP = 0,
+	SXE2_FLOW_ACTION_TC_REDIRECT,
+	SXE2_FLOW_ACTION_TO_VSI,
+	SXE2_FLOW_ACTION_TO_VSI_LIST,
+	SXE2_FLOW_ACTION_PASSTHRU,
+	SXE2_FLOW_ACTION_QUEUE,
+	SXE2_FLOW_ACTION_Q_REGION,
+	SXE2_FLOW_ACTION_MARK,
+	SXE2_FLOW_ACTION_COUNT,
+	SXE2_FLOW_ACTION_RSS,
+	SXE2_FLOW_ACTION_MAX = 32,
+};
+
+enum sxe2_rss_hash_key_func {
+	SXE2_RSS_HASH_FUNC_TOEPLITZ     = 0,
+	SXE2_RSS_HASH_FUNC_SYM_TOEPLITZ = 1,
+	SXE2_RSS_HASH_FUNC_XOR          = 2,
+	SXE2_RSS_HASH_FUNC_JEKINS       = 3
+};
+
+struct sxe2_flow_action_rss {
+	DECLARE_BITMAP(hdr_out, SXE2_FLOW_HDR_MAX);
+	DECLARE_BITMAP(hdr_in, SXE2_FLOW_HDR_MAX);
+	DECLARE_BITMAP(fld, SXE2_FLOW_FLD_ID_MAX);
+	uint8_t is_inner;
+	uint8_t func;
+	uint8_t hdr_type;
+};
+
+struct sxe2_flow_action_queue {
+	uint16_t vsi_index;
+	uint16_t q_index;
+};
+
+struct sxe2_flow_action_queue_region {
+	uint16_t vsi_index;
+	uint16_t q_index;
+	uint8_t region;
+};
+
+struct sxe2_flow_action_passthru {
+	uint16_t vsi_index;
+};
+
+struct sxe2_flow_action_mark {
+	uint32_t mark_id;
+};
+
+#define SXE2_VSI_MAX (2048)
+struct sxe2_flow_action_vsi {
+	uint16_t vsi_index;
+};
+
+struct sxe2_flow_action_vsi_list {
+	DECLARE_BITMAP(vsi_list_map, SXE2_VSI_MAX);
+	uint16_t vsi_cnt;
+};
+
+enum sxe2_fnav_stat_ctrl_type {
+	SXE2_FNAV_STAT_ENA_NONE = 0,
+	SXE2_FNAV_STAT_ENA_PKTS,
+	SXE2_FNAV_STAT_ENA_BYTES,
+	SXE2_FNAV_STAT_ENA_ALL,
+};
+
+struct sxe2_flow_action_count {
+	uint32_t user_id;
+	uint32_t driver_id;
+	uint32_t stat_index;
+	uint32_t stat_ctrl;
+};
+
+enum sxe2_flow_engine_type {
+	SXE2_FLOW_ENGINE_ACL,
+	SXE2_FLOW_ENGINE_SWITCH,
+	SXE2_FLOW_ENGINE_FNAV,
+	SXE2_FLOW_ENGINE_RSS,
+	SXE2_FLOW_ENGINE_MAX,
+};
+
+struct sxe2_flow_item {
+	struct sxe2_ether_hdr eth;
+	struct sxe2_vlan_hdr vlan;
+	struct sxe2_vlan_hdr qinq;
+	struct sxe2_ipv4_hdr ipv4;
+	struct sxe2_ipv6_hdr ipv6;
+	struct sxe2_udp_hdr udp;
+	struct sxe2_tcp_hdr tcp;
+	struct sxe2_sctp_hdr sctp;
+	struct sxe2_gtpu_hdr gtpu;
+	struct sxe2_vxlan_hdr vxlan;
+	struct sxe2_nvgre_hdr nvgre;
+	struct sxe2_geneve_hdr geneve;
+};
+
+enum sxe2_flow_sw_direct_type {
+	SXE2_FLOW_SW_DIRECT_TX,
+	SXE2_FLOW_SW_DIRECT_RX,
+	SXE2_FLOW_SW_DIRECT_MAX,
+};
+enum sxe2_flow_sw_pattern_type {
+	SXE2_FLOW_SW_PATTERN_ONLY,
+	SXE2_FLOW_SW_PATTERN_LAST,
+	SXE2_FLOW_SW_PATTERN_FIRST,
+	SXE2_FLOW_SW_PATTERN_MAX,
+};
+
+enum sxe2_flow_tunnel_type {
+	SXE2_FLOW_TUNNEL_TYPE_NONE,
+	SXE2_FLOW_TUNNEL_TYPE_PARENT,
+	SXE2_FLOW_TUNNEL_TYPE_VXLAN,
+	SXE2_FLOW_TUNNEL_TYPE_GTPU,
+	SXE2_FLOW_TUNNEL_TYPE_GENEVE,
+	SXE2_FLOW_TUNNEL_TYPE_GRE,
+	SXE2_FLOW_TUNNEL_TYPE_IPIP,
+};
+
+struct sxe2_flow_meta {
+	uint8_t switch_pattern_dup_allow;
+	uint8_t switch_src_direct;
+	uint16_t flow_src_vsi;
+	uint16_t flow_rule_vsi;
+	uint32_t flow_prio;
+	uint16_t flow_type;
+	uint8_t tunnel_type;
+	uint8_t rsv;
+};
+
+struct sxe2_flow_pattern {
+	DECLARE_BITMAP(hdrs, SXE2_FLOW_HDR_MAX);
+	DECLARE_BITMAP(map_spec, SXE2_FLOW_FLD_ID_MAX);
+	DECLARE_BITMAP(map_mask, SXE2_FLOW_FLD_ID_MAX);
+	struct sxe2_flow_item item_spec;
+	struct sxe2_flow_item item_mask;
+	uint64_t rss_type_allow;
+};
+
+struct sxe2_flow_action {
+	DECLARE_BITMAP(act_types, SXE2_FLOW_ACTION_MAX);
+	struct sxe2_flow_action_rss rss;
+	struct sxe2_flow_action_queue queue;
+	struct sxe2_flow_action_queue_region q_region;
+	struct sxe2_flow_action_passthru passthru;
+	struct sxe2_flow_action_vsi vsi;
+	struct sxe2_flow_action_vsi_list vsi_list;
+	struct sxe2_flow_action_mark mark;
+	struct sxe2_flow_action_count count;
+};
+#endif /* __SXE2_FLOW_PUBLIC_H__ */
diff --git a/drivers/net/sxe2/meson.build b/drivers/net/sxe2/meson.build
index 8ff74e5233..dfd31bfc97 100644
--- a/drivers/net/sxe2/meson.build
+++ b/drivers/net/sxe2/meson.build
@@ -62,6 +62,7 @@ sources += files(
         'sxe2_txrx_vec.c',
         'sxe2_mac.c',
         'sxe2_filter.c',
+        'sxe2_rss.c',
 )
 
 allow_internal_get_api = true
diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c b/drivers/net/sxe2/sxe2_cmd_chnl.c
index 1fa9ad718e..b997e7b044 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.c
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
@@ -541,3 +541,176 @@ int32_t sxe2_drv_vlan_filter_switch(struct sxe2_adapter *adapter, bool on)
 
 	return ret;
 }
+
+int32_t sxe2_drv_rss_key_set(struct sxe2_adapter *adapter, uint8_t *key, uint16_t key_size)
+{
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_rss_key_req *req = NULL;
+	int32_t ret = 0;
+	uint16_t buf_size = sizeof(*req) + key_size;
+
+	req = rte_zmalloc("drv_cmd_rss_key", buf_size, 0);
+	if (!req) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to alloc rss key");
+		ret = -ENOMEM;
+		goto l_end;
+	}
+
+	req->vsi_id = rte_cpu_to_le_16(adapter->vsi_ctxt.dpdk_vsi_id);
+	req->key_size = rte_cpu_to_le_16(key_size);
+	rte_memcpy(req->key, key, key_size);
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_RSS_KEY_SET,
+		req, buf_size, NULL, 0);
+
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to cmd set rss key, ret=%d", ret);
+		goto l_end;
+	}
+
+l_end:
+	if (req) {
+		rte_free(req);
+		req = NULL;
+	}
+	return ret;
+}
+
+int32_t sxe2_drv_rss_lut_set(struct sxe2_adapter *adapter, uint8_t *lut, uint16_t lut_size)
+{
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_rss_lut_req *req = NULL;
+	int32_t ret = 0;
+	uint16_t buf_size = sizeof(struct sxe2_rss_lut_req) + lut_size;
+
+	req = rte_zmalloc("drv_cmd_rss_lut", buf_size, 0);
+	if (!req) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to alloc rss lut");
+		ret = -ENOMEM;
+		goto l_end;
+	}
+
+	req->vsi_id = rte_cpu_to_le_16(adapter->vsi_ctxt.dpdk_vsi_id);
+	req->lut_size = rte_cpu_to_le_16(lut_size);
+	rte_memcpy(req->lut, lut, lut_size);
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_RSS_LUT_SET,
+		req, buf_size, NULL, 0);
+
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to cmd set rss lut, ret=%d", ret);
+		goto l_end;
+	}
+
+l_end:
+	if (req) {
+		rte_free(req);
+		req = NULL;
+	}
+	return ret;
+}
+
+int32_t sxe2_drv_rss_hash_ctrl_func(struct sxe2_adapter *adapter, enum sxe2_rss_hash_key_func func)
+{
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_rss_func_req req = {0};
+	int32_t ret = 0;
+
+	req.vsi_id = rte_cpu_to_le_16(adapter->vsi_ctxt.dpdk_vsi_id);
+	req.func = func;
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_RSS_FUNC_SET,
+		&req, sizeof(req), NULL, 0);
+
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to cmd set rss func, ret=%d", ret);
+	return ret;
+}
+
+static void sxe2_drv_flow_bitmap_fill(uint32_t *bitmap, uint16_t *list)
+{
+	uint16_t index = 0;
+	uint16_t i = 0;
+	uint16_t map_size = sizeof(*bitmap) * SXE2_BITS_PER_BYTE;
+
+	while (list[i] != SXE2_FLOW_END) {
+		index = list[i] / map_size;
+		bitmap[index] |= (1UL << (list[i] % map_size));
+		i++;
+	}
+}
+
+int32_t sxe2_drv_rss_hf_add(struct sxe2_adapter *adapter,
+			struct sxe2_rss_hf_config *rss_conf)
+{
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_rss_hf_req req = {0};
+	int32_t ret = 0;
+
+	req.vsi_id = rte_cpu_to_le_16(adapter->vsi_ctxt.dpdk_vsi_id);
+	req.symm = rss_conf->symm;
+	req.hdr_type = rte_cpu_to_le_32(SXE2_RSS_OUTER_HEADERS);
+	sxe2_drv_flow_bitmap_fill(req.headers, rss_conf->hdrs);
+	sxe2_drv_flow_bitmap_fill(req.hash_flds, rss_conf->flds);
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_RSS_HF_ADD,
+		&req, sizeof(req), NULL, 0);
+
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to cmd add rss hf, ret=%d", ret);
+	return ret;
+}
+
+int32_t sxe2_drv_rss_hf_del(struct sxe2_adapter *adapter,
+				struct sxe2_rss_hf_config *rss_conf)
+{
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_rss_hf_req req = {0};
+	int32_t ret = 0;
+
+	req.vsi_id = rte_cpu_to_le_16(adapter->vsi_ctxt.dpdk_vsi_id);
+	req.symm = rss_conf->symm;
+	req.hdr_type = rte_cpu_to_le_32(SXE2_RSS_OUTER_HEADERS);
+	sxe2_drv_flow_bitmap_fill(req.headers, rss_conf->hdrs);
+	sxe2_drv_flow_bitmap_fill(req.hash_flds, rss_conf->flds);
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_RSS_HF_DEL,
+		&req, sizeof(req), NULL, 0);
+
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to cmd del rss hf, ret=%d", ret);
+	return ret;
+}
+
+int32_t sxe2_drv_rss_hf_clear(struct sxe2_adapter *adapter)
+{
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	int32_t ret = 0;
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_RSS_HF_CLEAR,
+		NULL, 0, NULL, 0);
+
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to cmd clear rss hf, ret=%d", ret);
+
+	return ret;
+}
+
+int32_t sxe2_drv_ptp_gettime(struct sxe2_adapter *adapter, struct sxe2_rx_queue *rxq)
+{
+	(void)adapter;
+	(void)rxq;
+	return 0;
+}
diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.h b/drivers/net/sxe2/sxe2_cmd_chnl.h
index fb01c41aad..3274db6551 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.h
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.h
@@ -53,4 +53,20 @@ int32_t sxe2_drv_vlan_insert_strip_cfg(struct sxe2_adapter *adapter);
 
 int32_t sxe2_drv_vlan_filter_switch(struct sxe2_adapter *adapter, bool on);
 
+int32_t sxe2_drv_rss_key_set(struct sxe2_adapter *adapter, uint8_t *key, uint16_t key_size);
+
+int32_t sxe2_drv_rss_lut_set(struct sxe2_adapter *adapter, uint8_t *lut, uint16_t lut_size);
+
+int32_t sxe2_drv_rss_hash_ctrl_func(struct sxe2_adapter *adapter, enum sxe2_rss_hash_key_func func);
+
+int32_t sxe2_drv_rss_hf_add(struct sxe2_adapter *adapter,
+			struct sxe2_rss_hf_config *rss_conf);
+
+int32_t sxe2_drv_rss_hf_del(struct sxe2_adapter *adapter,
+				struct sxe2_rss_hf_config *rss_conf);
+
+int32_t sxe2_drv_rss_hf_clear(struct sxe2_adapter *adapter);
+
+int32_t sxe2_drv_ptp_gettime(struct sxe2_adapter *adapter, struct sxe2_rx_queue *rxq);
+
 #endif /* __SXE2_CMD_CHNL_H__ */
diff --git a/drivers/net/sxe2/sxe2_drv_cmd.h b/drivers/net/sxe2/sxe2_drv_cmd.h
index c9d7cc719b..ced5a4b1a0 100644
--- a/drivers/net/sxe2/sxe2_drv_cmd.h
+++ b/drivers/net/sxe2/sxe2_drv_cmd.h
@@ -6,6 +6,7 @@
 #define __SXE2_DRV_CMD_H__
 
 #include "sxe2_osal.h"
+#include "sxe2_flow_public.h"
 
 #define SXE2_DRV_CMD_MODULE_S        (16)
 #define SXE2_MK_DRV_CMD(module, cmd) (((module) << SXE2_DRV_CMD_MODULE_S) | ((cmd) & 0xFFFF))
@@ -320,6 +321,34 @@ struct sxe2_vlan_filter_switch_req {
 	uint8_t rsv;
 };
 
+struct sxe2_rss_key_req {
+	__le16 vsi_id;
+	__le16 key_size;
+	uint8_t key[];
+};
+
+struct sxe2_rss_lut_req {
+	__le16 vsi_id;
+	__le16 lut_size;
+	uint8_t lut[];
+};
+
+struct sxe2_rss_func_req {
+	__le16 vsi_id;
+	uint8_t func;
+	uint8_t rsv[1];
+};
+
+struct sxe2_rss_hf_req {
+	__le16 vsi_id;
+	uint8_t rsv[2];
+	uint32_t headers[BITS_TO_U32(SXE2_FLOW_HDR_MAX)];
+	uint32_t hash_flds[BITS_TO_U32(SXE2_FLOW_FLD_ID_MAX)];
+	uint32_t hdr_type;
+	uint8_t symm;
+	uint8_t rsv1[3];
+};
+
 enum sxe2_drv_cmd_module {
 	SXE2_DRV_CMD_MODULE_HANDSHAKE = 0,
 	SXE2_DRV_CMD_MODULE_DEV = 1,
diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index 9b117f097e..d48841b8e4 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -125,6 +125,11 @@ static const struct eth_dev_ops sxe2_eth_dev_ops = {
 
 	.vlan_filter_set            = sxe2_dev_vlan_filter_set,
 	.vlan_offload_set           = sxe2_dev_vlan_offload_set,
+
+	.reta_update                = sxe2_dev_rss_reta_update,
+	.reta_query                 = sxe2_dev_rss_reta_query,
+	.rss_hash_update            = sxe2_dev_rss_hash_update,
+	.rss_hash_conf_get          = sxe2_dev_rss_hash_conf_get,
 };
 
 static int32_t sxe2_dev_configure(struct rte_eth_dev *dev)
@@ -141,6 +146,12 @@ static int32_t sxe2_dev_configure(struct rte_eth_dev *dev)
 		goto end;
 	}
 
+	ret = sxe2_rss_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to init rss, ret=%d", ret);
+		goto end;
+	}
+
 end:
 	return ret;
 }
@@ -281,6 +292,22 @@ static int32_t sxe2_dev_infos_get(struct rte_eth_dev *dev,
 		RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |
 		RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO;
 
+
+	if (adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_PTP)
+		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_TIMESTAMP;
+
+	if (adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_RSS) {
+		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
+		dev_info->flow_type_rss_offloads  |= SXE2_RSS_HF_SUPPORT_ALL;
+		dev_info->reta_size = adapter->rss_ctxt.rss_lut_size;
+		dev_info->hash_key_size = adapter->rss_ctxt.rss_key_size;
+		dev_info->rss_algo_capa =
+			RTE_ETH_HASH_ALGO_TO_CAPA(RTE_ETH_HASH_FUNCTION_DEFAULT) |
+			RTE_ETH_HASH_ALGO_TO_CAPA(RTE_ETH_HASH_FUNCTION_TOEPLITZ) |
+			RTE_ETH_HASH_ALGO_TO_CAPA(RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ) |
+			RTE_ETH_HASH_ALGO_TO_CAPA(RTE_ETH_HASH_FUNCTION_SIMPLE_XOR);
+	}
+
 	dev_info->default_rxconf = (struct rte_eth_rxconf) {
 		.rx_thresh = {
 			.pthresh = SXE2_DEFAULT_RX_PTHRESH,
@@ -563,6 +590,8 @@ static int32_t sxe2_func_caps_get(struct sxe2_adapter *adapter)
 
 	sxe2_sw_queue_ctx_hw_cap_set(adapter, &dev_caps.queue_caps);
 
+	sxe2_sw_rss_ctx_hw_cap_set(adapter, &dev_caps.rss_hash_caps);
+
 	sxe2_sw_vsi_ctx_hw_cap_set(adapter, &dev_caps.vsi_caps);
 
 l_end:
@@ -950,8 +979,15 @@ static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 		goto init_eth_err;
 	}
 
+	ret = sxe2_rss_disable(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to disable rss, ret=%d", ret);
+		goto init_rss_err;
+	}
+
 	goto l_end;
 
+init_rss_err:
 init_eth_err:
 init_dev_info_err:
 	sxe2_vsi_uninit(dev);
@@ -965,6 +1001,7 @@ static int32_t sxe2_dev_close(struct rte_eth_dev *dev)
 {
 	(void)sxe2_dev_stop(dev);
 	(void)sxe2_queues_release(dev);
+	(void)sxe2_rss_disable(dev);
 	sxe2_vsi_uninit(dev);
 	sxe2_dev_pci_map_uinit(dev);
 	sxe2_eth_uinit(dev);
diff --git a/drivers/net/sxe2/sxe2_ethdev.h b/drivers/net/sxe2/sxe2_ethdev.h
index cc8a84c0a0..556a11cc77 100644
--- a/drivers/net/sxe2/sxe2_ethdev.h
+++ b/drivers/net/sxe2/sxe2_ethdev.h
@@ -13,6 +13,7 @@
 
 #include "sxe2_common.h"
 #include "sxe2_vsi.h"
+#include "sxe2_rss.h"
 #include "sxe2_irq.h"
 #include "sxe2_queue.h"
 #include "sxe2_mac.h"
@@ -120,6 +121,11 @@ enum {
 	SXE2_FLAGS_NBITS
 };
 
+struct sxe2_ptp_context {
+	uint64_t mbuf_rx_ts_flag;
+	int32_t mbuf_rx_ts_offset;
+};
+
 struct sxe2_devargs {
 	uint8_t flow_dup_pattern_mode;
 	uint8_t func_flow_direct_en;
@@ -298,7 +304,9 @@ struct sxe2_adapter {
 	struct sxe2_queue_context     q_ctxt;
 	struct sxe2_vsi_context       vsi_ctxt;
 	struct sxe2_filter_context    filter_ctxt;
+	struct sxe2_rss_context       rss_ctxt;
 	struct sxe2_link_context      link_ctxt;
+	struct sxe2_ptp_context       ptp_ctxt;
 	struct sxe2_devargs           devargs;
 	struct sxe2_switchdev_info    switchdev_info;
 	bool                          rule_started;
diff --git a/drivers/net/sxe2/sxe2_flow_define.h b/drivers/net/sxe2/sxe2_flow_define.h
new file mode 100644
index 0000000000..d2f6000efa
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_flow_define.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_FLOW_DEFINE_H__
+#define __SXE2_FLOW_DEFINE_H__
+#include <rte_tailq.h>
+#include <rte_eal.h>
+#include <rte_flow_driver.h>
+
+#include "sxe2_osal.h"
+#include "sxe2_flow_public.h"
+
+#define SXE2_FLOW_ETH_TYPE_MIN        (1500)
+
+enum sxe2_expansion {
+	SXE2_EXPANSION_ERROR = 0,
+	SXE2_EXPANSION_OUTER_ETH,
+	SXE2_EXPANSION_OUTER_VLAN,
+	SXE2_EXPANSION_OUTER_QINQ,
+	SXE2_EXPANSION_OUTER_IPV4,
+	SXE2_EXPANSION_OUTER_IPV4_FRAG_EXT,
+	SXE2_EXPANSION_OUTER_IPV6,
+	SXE2_EXPANSION_OUTER_IPV6_FRAG_EXT,
+	SXE2_EXPANSION_OUTER_UDP,
+	SXE2_EXPANSION_OUTER_TCP,
+	SXE2_EXPANSION_OUTER_SCTP,
+
+	SXE2_EXPANSION_VXLAN,
+	SXE2_EXPANSION_VXLAN_GPE,
+	SXE2_EXPANSION_GRE,
+	SXE2_EXPANSION_NVGRE,
+	SXE2_EXPANSION_GENEVE,
+	SXE2_EXPANSION_GTPU,
+	SXE2_EXPANSION_IPIP,
+	SXE2_EXPANSION_OUTER_END,
+
+	SXE2_EXPANSION_ETH,
+	SXE2_EXPANSION_VLAN,
+	SXE2_EXPANSION_IPV4,
+	SXE2_EXPANSION_IPV4_FRAG_EXT,
+	SXE2_EXPANSION_IPV6,
+	SXE2_EXPANSION_IPV6_FRAG_EXT,
+	SXE2_EXPANSION_UDP,
+	SXE2_EXPANSION_TCP,
+	SXE2_EXPANSION_SCTP,
+
+	SXE2_EXPANSION_END,
+	SXE2_EXPANSION_MAX,
+};
+
+enum sxe2_flow_udp_tunnel_protocol {
+	SXE2_FLOW_UDP_TUNNEL_PROTOCOL_VXLAN,
+	SXE2_FLOW_UDP_TUNNEL_PROTOCOL_VXLAN_GPE,
+	SXE2_FLOW_UDP_TUNNEL_PROTOCOL_GENEVE,
+	SXE2_FLOW_UDP_TUNNEL_PROTOCOL_GTP_U,
+	SXE2_FLOW_UDP_TUNNEL_PROTOCOL_NVGRE,
+	SXE2_FLOW_UDP_TUNNEL_MAX,
+};
+
+enum {
+	SXE2_FLOW_ETH_TYPE_IPV4 = 0x0800,
+	SXE2_FLOW_ETH_TYPE_IPV6 = 0x86DD,
+	SXE2_FLOW_IP_PROTOCOL_GRE = 0x2F,
+	SXE2_FLOW_IP_PROTOCOL_IPV4 = 0x04,
+	SXE2_FLOW_IP_PROTOCOL_IPV6 = 0x29,
+	SXE2_FLOW_IP_PROTOCOL_ETH = 0x3B,
+	SXE2_FLOW_IP_PROTOCOL_UDP = 0x11,
+	SXE2_FLOW_IP_PROTOCOL_TCP = 0x06,
+	SXE2_FLOW_IP_PROTOCOL_SCTP = 0x84,
+};
+
+union sxe2_flow_item_raw {
+	struct sxe2_flow_item item;
+	uint8_t raw[sizeof(struct sxe2_flow_item)];
+};
+
+struct sxe2_flow {
+	TAILQ_ENTRY(sxe2_flow) next;
+	enum sxe2_flow_engine_type engine_type;
+	struct sxe2_flow_pattern pattern_outer;
+	struct sxe2_flow_pattern pattern_inner;
+	uint8_t has_mask;
+	uint8_t has_spec;
+	uint8_t has_hdr;
+	struct sxe2_flow_meta meta;
+	struct sxe2_flow_action action;
+	uint32_t flow_id;
+	int32_t create_err;
+	DECLARE_BITMAP(flow_type, SXE2_EXPANSION_MAX);
+};
+
+TAILQ_HEAD(sxe2_flow_list_t, sxe2_flow);
+
+struct rte_flow {
+	TAILQ_ENTRY(rte_flow) next;
+	struct sxe2_flow_list_t sxe2_flow_list;
+};
+TAILQ_HEAD(rte_flow_list_t, rte_flow);
+
+struct sxe2_fnav_cid_mgr {
+	TAILQ_ENTRY(sxe2_fnav_cid_mgr) next;
+	uint16_t stat_index;
+	uint32_t user_id;
+	uint32_t driver_id;
+	uint32_t count_type;
+	uint64_t hits;
+	uint64_t bytes;
+};
+TAILQ_HEAD(sxe2_fnav_cid_mgr_list_t, sxe2_fnav_cid_mgr);
+
+struct sxe2_fnav_count_resource {
+	uint32_t count_type;
+	uint32_t global_index;
+	struct sxe2_fnav_cid_mgr_list_t fnav_cid_mgr_list;
+};
+
+struct sxe2_flow_context {
+	struct rte_flow_list_t rte_flow_list;
+	rte_spinlock_t flow_list_lock;
+	struct sxe2_fnav_count_resource hw_res;
+	uint32_t fnav_inited;
+};
+#define SXE2_INVALID_RSS_ATTR	\
+			(RTE_ETH_RSS_L3_PRE40 | RTE_ETH_RSS_L3_PRE56 | RTE_ETH_RSS_L3_PRE96)
+#define SXE2_VALID_RSS_IPV4_L4	 \
+			(RTE_ETH_RSS_NONFRAG_IPV4_UDP | RTE_ETH_RSS_NONFRAG_IPV4_TCP | \
+			 RTE_ETH_RSS_NONFRAG_IPV4_SCTP)
+
+#define SXE2_VALID_RSS_IPV6_L4	\
+			(RTE_ETH_RSS_NONFRAG_IPV6_UDP | RTE_ETH_RSS_NONFRAG_IPV6_TCP | \
+			 RTE_ETH_RSS_NONFRAG_IPV6_SCTP)
+#define SXE2_VALID_RSS_IPV4	\
+			(RTE_ETH_RSS_IPV4 | RTE_ETH_RSS_FRAG_IPV4  | \
+			 RTE_ETH_RSS_NONFRAG_IPV4_OTHER | SXE2_VALID_RSS_IPV4_L4)
+#define SXE2_VALID_RSS_IPV6	\
+			(RTE_ETH_RSS_IPV6 | RTE_ETH_RSS_FRAG_IPV6 | \
+			 RTE_ETH_RSS_NONFRAG_IPV6_OTHER | SXE2_VALID_RSS_IPV6_L4)
+
+#define SXE2_VALID_RSS_L3	(SXE2_VALID_RSS_IPV4 | SXE2_VALID_RSS_IPV6)
+#define SXE2_VALID_RSS_L4	(SXE2_VALID_RSS_IPV4_L4 | SXE2_VALID_RSS_IPV6_L4)
+
+#endif /* __SXE2_FLOW_DEFINE_H__ */
diff --git a/drivers/net/sxe2/sxe2_queue.c b/drivers/net/sxe2/sxe2_queue.c
index 1786d6ea4f..220cab6fce 100644
--- a/drivers/net/sxe2/sxe2_queue.c
+++ b/drivers/net/sxe2/sxe2_queue.c
@@ -17,6 +17,7 @@ void sxe2_sw_queue_ctx_hw_cap_set(struct sxe2_adapter *adapter,
 
 int32_t sxe2_queues_init(struct rte_eth_dev *dev)
 {
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
 	int32_t ret = 0;
 	uint16_t buf_size;
 	uint16_t frame_size;
@@ -36,6 +37,16 @@ int32_t sxe2_queues_init(struct rte_eth_dev *dev)
 			dev->data->scattered_rx = 1;
 	}
 
+	adapter->ptp_ctxt.mbuf_rx_ts_offset = -1;
+	adapter->ptp_ctxt.mbuf_rx_ts_flag = 0;
+	if (dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
+		ret = rte_mbuf_dyn_rx_timestamp_register
+			(&adapter->ptp_ctxt.mbuf_rx_ts_offset,
+			 (uint64_t *)&adapter->ptp_ctxt.mbuf_rx_ts_flag);
+		if (ret)
+			PMD_LOG_ERR(INIT, "Failed to enable timestamp offloads, ret=%d", ret);
+	}
+
 	return ret;
 }
 
diff --git a/drivers/net/sxe2/sxe2_rss.c b/drivers/net/sxe2/sxe2_rss.c
new file mode 100644
index 0000000000..1d56613043
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_rss.c
@@ -0,0 +1,584 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include "sxe2_rss.h"
+#include "sxe2_common_log.h"
+#include "sxe2_ethdev.h"
+#include "sxe2_cmd_chnl.h"
+
+void sxe2_sw_rss_ctx_hw_cap_set(struct sxe2_adapter *adapter,
+		struct sxe2_drv_rss_hash_caps *rss_caps)
+{
+	adapter->rss_ctxt.rss_key_size = rss_caps->hash_key_size;
+	adapter->rss_ctxt.rss_lut_size = rss_caps->lut_key_size;
+}
+
+int32_t sxe2_rss_hash_key_init(struct rte_eth_dev *dev)
+{
+	struct rte_eth_rss_conf *rss_conf = &dev->data->dev_conf.rx_adv_conf.rss_conf;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_rss_context *rss_ctxt = &adapter->rss_ctxt;
+	int32_t ret = 0;
+	uint16_t i = 0;
+
+	if (rss_ctxt->rss_key == NULL) {
+		rss_ctxt->rss_key = (uint8_t *)rte_zmalloc("rss_key", rss_ctxt->rss_key_size, 0);
+		if (rss_ctxt->rss_key == NULL) {
+			PMD_LOG_ERR(INIT, "Failed to allocate rss key");
+			ret = -ENOMEM;
+			goto l_end;
+		}
+	}
+
+	if (!rss_conf->rss_key) {
+		for (i = 0; i < rss_ctxt->rss_key_size; i++)
+			rss_ctxt->rss_key[i] = (uint8_t)rte_rand();
+	} else {
+		rte_memcpy(rss_ctxt->rss_key, rss_conf->rss_key,
+			   RTE_MIN(rss_conf->rss_key_len, rss_ctxt->rss_key_size));
+	}
+
+	ret = sxe2_drv_rss_key_set(adapter, rss_ctxt->rss_key,
+				   rss_ctxt->rss_key_size);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to set rss key, ret:%d", ret);
+		rte_free(rss_ctxt->rss_key);
+		rss_ctxt->rss_key = NULL;
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
+void sxe2_rss_hash_key_uninit(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_rss_context *rss_ctxt = &adapter->rss_ctxt;
+
+	if (rss_ctxt->rss_key) {
+		rte_free(rss_ctxt->rss_key);
+		rss_ctxt->rss_key = NULL;
+	}
+}
+
+int32_t sxe2_rss_lut_init(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_rss_context *rss_ctxt = &adapter->rss_ctxt;
+	int32_t ret = 0;
+	uint16_t i;
+
+	if (rss_ctxt->rss_lut == NULL) {
+		rss_ctxt->rss_lut = (uint8_t *)rte_zmalloc("rss_lut", rss_ctxt->rss_lut_size, 0);
+		if (rss_ctxt->rss_lut == NULL) {
+			PMD_DEV_LOG_ERR(adapter, INIT, "Failed to allocate rss lut");
+			ret = -ENOMEM;
+			goto l_end;
+		}
+	}
+
+	for (i = 0; i < rss_ctxt->rss_lut_size; i++)
+		rss_ctxt->rss_lut[i] = (uint8_t)(i % dev->data->nb_rx_queues);
+
+	ret = sxe2_drv_rss_lut_set(adapter, rss_ctxt->rss_lut, rss_ctxt->rss_lut_size);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to set rss lut, ret:%d", ret);
+		rte_free(rss_ctxt->rss_lut);
+		rss_ctxt->rss_lut = NULL;
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
+void sxe2_rss_lut_uninit(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_rss_context *rss_ctxt = &adapter->rss_ctxt;
+
+	if (rss_ctxt->rss_lut) {
+		rte_free(rss_ctxt->rss_lut);
+		rss_ctxt->rss_lut = NULL;
+	}
+}
+
+static struct sxe2_rss_hf_config sxe2_rss_default_hf_config[] = {
+	{
+		.rss_hf = RTE_ETH_RSS_L2_PAYLOAD,
+		.hdrs = {SXE2_FLOW_HDR_ETH,
+				 SXE2_FLOW_END},
+		.flds = {SXE2_FLOW_FLD_ID_ETH_TYPE,
+				 SXE2_FLOW_END},
+	},
+	{
+		.rss_hf = RTE_ETH_RSS_IPV4,
+		.hdrs = {SXE2_FLOW_HDR_IPV4,
+				 SXE2_FLOW_END},
+		.flds = {SXE2_FLOW_FLD_ID_IPV4_SA,
+				 SXE2_FLOW_FLD_ID_IPV4_DA,
+				 SXE2_FLOW_END},
+	},
+	{
+		.rss_hf = RTE_ETH_RSS_IPV6,
+		.hdrs = {SXE2_FLOW_HDR_IPV6,
+				 SXE2_FLOW_END},
+		.flds = {SXE2_FLOW_FLD_ID_IPV6_SA,
+				 SXE2_FLOW_FLD_ID_IPV6_DA,
+				 SXE2_FLOW_END},
+	},
+	{
+		.rss_hf = RTE_ETH_RSS_FRAG_IPV4,
+		.hdrs = {SXE2_FLOW_HDR_IPV4,
+				 SXE2_FLOW_HDR_IPV_FRAG,
+				 SXE2_FLOW_END},
+		.flds = {SXE2_FLOW_FLD_ID_IPV4_SA,
+				 SXE2_FLOW_FLD_ID_IPV4_DA,
+				 SXE2_FLOW_END},
+	},
+	{
+		.rss_hf = RTE_ETH_RSS_FRAG_IPV6,
+		.hdrs = {SXE2_FLOW_HDR_IPV6,
+				 SXE2_FLOW_HDR_IPV_FRAG,
+				 SXE2_FLOW_END},
+		.flds = {SXE2_FLOW_FLD_ID_IPV6_SA,
+				 SXE2_FLOW_FLD_ID_IPV6_DA,
+				 SXE2_FLOW_END},
+	},
+	{
+		.rss_hf = RTE_ETH_RSS_NONFRAG_IPV4_OTHER,
+		.hdrs = {SXE2_FLOW_HDR_IPV4,
+				 SXE2_FLOW_HDR_IPV_OTHER,
+				 SXE2_FLOW_END},
+		.flds = {SXE2_FLOW_FLD_ID_IPV4_SA,
+				 SXE2_FLOW_FLD_ID_IPV4_DA,
+				 SXE2_FLOW_END},
+	},
+	{
+		.rss_hf = RTE_ETH_RSS_NONFRAG_IPV6_OTHER,
+		.hdrs = {SXE2_FLOW_HDR_IPV6,
+				 SXE2_FLOW_HDR_IPV_OTHER,
+				 SXE2_FLOW_END},
+		.flds = {SXE2_FLOW_FLD_ID_IPV6_SA,
+				 SXE2_FLOW_FLD_ID_IPV6_DA,
+				 SXE2_FLOW_END},
+	},
+	{
+		.rss_hf = RTE_ETH_RSS_NONFRAG_IPV4_UDP,
+		.hdrs = {SXE2_FLOW_HDR_IPV4,
+				 SXE2_FLOW_HDR_UDP,
+				 SXE2_FLOW_END},
+		.flds = {SXE2_FLOW_FLD_ID_IPV4_SA,
+				 SXE2_FLOW_FLD_ID_IPV4_DA,
+				 SXE2_FLOW_FLD_ID_UDP_SRC_PORT,
+				 SXE2_FLOW_FLD_ID_UDP_DST_PORT,
+				 SXE2_FLOW_END},
+	},
+	{
+		.rss_hf = RTE_ETH_RSS_NONFRAG_IPV6_UDP,
+		.hdrs = {SXE2_FLOW_HDR_IPV6,
+				 SXE2_FLOW_HDR_UDP,
+				 SXE2_FLOW_END},
+		.flds = {SXE2_FLOW_FLD_ID_IPV6_SA,
+				 SXE2_FLOW_FLD_ID_IPV6_DA,
+				 SXE2_FLOW_FLD_ID_UDP_SRC_PORT,
+				 SXE2_FLOW_FLD_ID_UDP_DST_PORT,
+				 SXE2_FLOW_END},
+	},
+	{
+		.rss_hf = RTE_ETH_RSS_NONFRAG_IPV4_TCP,
+		.hdrs = {SXE2_FLOW_HDR_IPV4,
+				 SXE2_FLOW_HDR_TCP,
+				 SXE2_FLOW_END},
+		.flds = {SXE2_FLOW_FLD_ID_IPV4_SA,
+				 SXE2_FLOW_FLD_ID_IPV4_DA,
+				 SXE2_FLOW_FLD_ID_TCP_SRC_PORT,
+				 SXE2_FLOW_FLD_ID_TCP_DST_PORT,
+				 SXE2_FLOW_END},
+	},
+	{
+		.rss_hf = RTE_ETH_RSS_NONFRAG_IPV6_TCP,
+		.hdrs = {SXE2_FLOW_HDR_IPV6,
+				 SXE2_FLOW_HDR_TCP,
+				 SXE2_FLOW_END},
+		.flds = {SXE2_FLOW_FLD_ID_IPV6_SA,
+				 SXE2_FLOW_FLD_ID_IPV6_DA,
+				 SXE2_FLOW_FLD_ID_TCP_SRC_PORT,
+				 SXE2_FLOW_FLD_ID_TCP_DST_PORT,
+				 SXE2_FLOW_END},
+	},
+	{
+		.rss_hf = RTE_ETH_RSS_NONFRAG_IPV4_SCTP,
+		.hdrs = {SXE2_FLOW_HDR_IPV4,
+				 SXE2_FLOW_HDR_SCTP,
+				 SXE2_FLOW_END},
+		.flds = {SXE2_FLOW_FLD_ID_IPV4_SA,
+				 SXE2_FLOW_FLD_ID_IPV4_DA,
+				 SXE2_FLOW_FLD_ID_SCTP_SRC_PORT,
+				 SXE2_FLOW_FLD_ID_SCTP_DST_PORT,
+				 SXE2_FLOW_END},
+	},
+	{
+		.rss_hf = RTE_ETH_RSS_NONFRAG_IPV6_SCTP,
+		.hdrs = {SXE2_FLOW_HDR_IPV6,
+				 SXE2_FLOW_HDR_SCTP,
+				 SXE2_FLOW_END},
+		.flds = {SXE2_FLOW_FLD_ID_IPV6_SA,
+				 SXE2_FLOW_FLD_ID_IPV6_DA,
+				 SXE2_FLOW_FLD_ID_SCTP_SRC_PORT,
+				 SXE2_FLOW_FLD_ID_SCTP_DST_PORT,
+				 SXE2_FLOW_END},
+	},
+};
+
+int32_t sxe2_rss_hf_type_set(struct rte_eth_dev *dev, uint64_t rss_hf)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_rss_context *rss_ctxt = &adapter->rss_ctxt;
+	int32_t ret = 0;
+	uint32_t i;
+	uint8_t symm = 0;
+
+	if (0 == (rss_hf & SXE2_RSS_HF_SUPPORT_ALL) && rss_hf != 0) {
+		PMD_DEV_LOG_ERR(adapter, DRV,
+			"Failed to set unsupported rss_hf:0x%016" PRIx64,
+			rss_hf);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	for (i = 0; i < RTE_DIM(sxe2_rss_default_hf_config); i++) {
+		if (rss_ctxt->rss_hf & sxe2_rss_default_hf_config[i].rss_hf) {
+			sxe2_rss_default_hf_config[i].symm = rss_ctxt->symm;
+			ret = sxe2_drv_rss_hf_del(adapter, &sxe2_rss_default_hf_config[i]);
+			if (ret) {
+				PMD_DEV_LOG_ERR(adapter, INIT,
+					"Failed to del rss hf cfg[%d], ret:%d", i, ret);
+				goto l_end;
+			}
+		}
+	}
+
+	if (rss_ctxt->hash_func == RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ)
+		symm = 1;
+
+	for (i = 0; i < RTE_DIM(sxe2_rss_default_hf_config); i++) {
+		if (rss_hf & sxe2_rss_default_hf_config[i].rss_hf) {
+			sxe2_rss_default_hf_config[i].symm = symm;
+			ret = sxe2_drv_rss_hf_add(adapter, &sxe2_rss_default_hf_config[i]);
+			if (ret) {
+				PMD_DEV_LOG_ERR(adapter, INIT,
+					"Failed to add rss hf cfg[%d], ret:%d", i, ret);
+				goto l_end;
+			}
+		}
+	}
+
+	rss_ctxt->rss_hf = rss_hf & SXE2_RSS_HF_SUPPORT_ALL;
+	rss_ctxt->symm = symm;
+l_end:
+	return ret;
+}
+
+int32_t sxe2_rss_hash_function_set(struct rte_eth_dev *dev, enum rte_eth_hash_function func)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	enum sxe2_rss_hash_key_func hash_func = SXE2_RSS_HASH_FUNC_SYM_TOEPLITZ;
+	int32_t ret = 0;
+
+	switch (func) {
+	case RTE_ETH_HASH_FUNCTION_DEFAULT:
+	case RTE_ETH_HASH_FUNCTION_TOEPLITZ:
+	case RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ:
+		hash_func = SXE2_RSS_HASH_FUNC_SYM_TOEPLITZ;
+		break;
+	case RTE_ETH_HASH_FUNCTION_SIMPLE_XOR:
+		hash_func = SXE2_RSS_HASH_FUNC_XOR;
+		break;
+	default:
+		PMD_DEV_LOG_ERR(adapter, DRV, "RSS hash function[%d] not support.", func);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	ret = sxe2_drv_rss_hash_ctrl_func(adapter, hash_func);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to set rss hash function, ret=[%d]", ret);
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_rss_init(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct rte_eth_rss_conf *rss_conf = &dev->data->dev_conf.rx_adv_conf.rss_conf;
+	enum rte_eth_hash_function rss_func = RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ;
+	int32_t ret = 0;
+
+	adapter->rss_ctxt.inited = false;
+
+	if (dev->data->nb_rx_queues <= 1) {
+		PMD_DEV_LOG_DEBUG(adapter, INIT, "No need to init rss, rx queues %d.",
+				dev->data->nb_rx_queues);
+		goto l_end;
+	}
+
+	if ((adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_RSS) == 0) {
+		PMD_DEV_LOG_WARN(adapter, INIT, "RSS not supported");
+		goto l_end;
+	}
+
+	ret = sxe2_rss_hash_key_init(dev);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to init rss key");
+		goto l_end;
+	}
+
+	ret = sxe2_rss_lut_init(dev);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to init rss lut");
+		goto l_err_key;
+	}
+
+	rss_func = rss_conf->algorithm;
+	ret = sxe2_rss_hash_function_set(dev, rss_func);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to init rss hash function");
+		goto l_err_lut;
+	}
+	ret = sxe2_rss_hf_type_set(dev, rss_conf->rss_hf);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to set rss hf type");
+		goto l_err_lut;
+	}
+	adapter->rss_ctxt.inited = true;
+	goto l_end;
+
+l_err_lut:
+	sxe2_rss_lut_uninit(dev);
+l_err_key:
+	sxe2_rss_hash_key_uninit(dev);
+l_end:
+	return ret;
+}
+
+int32_t sxe2_rss_disable(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret = 0;
+
+	PMD_INIT_FUNC_TRACE();
+
+	if ((adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_RSS) == 0)
+		goto l_end;
+
+	ret = sxe2_drv_rss_hf_clear(adapter);
+	if (ret)
+		PMD_LOG_ERR(INIT, "Failed to clear rss hf");
+
+	sxe2_rss_hash_key_uninit(dev);
+
+	sxe2_rss_lut_uninit(dev);
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_dev_rss_reta_update(struct rte_eth_dev *dev,
+		struct rte_eth_rss_reta_entry64 *reta_conf,
+		uint16_t reta_size)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_rss_context *rss_ctxt = &adapter->rss_ctxt;
+	uint8_t *lut_tmp = NULL;
+	int32_t ret = 0;
+	uint16_t i;
+	uint16_t shift;
+	uint16_t idx;
+
+	if (!adapter->rss_ctxt.inited) {
+		PMD_DEV_LOG_INFO(adapter, DRV, "RSS not inited.");
+		ret = -ENOTSUP;
+		goto l_end;
+	}
+
+	if (reta_size != rss_ctxt->rss_lut_size) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "The size of hash lookup table configured "
+				"(%d) doesn't match the number of hardware can "
+			"support (%d)", reta_size, rss_ctxt->rss_lut_size);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	lut_tmp = rte_zmalloc("rss_lut_temp", reta_size, 0);
+	if (!lut_tmp) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "No memory can be allocated");
+		ret = -ENOMEM;
+		goto l_end;
+	}
+	rte_memcpy(lut_tmp, rss_ctxt->rss_lut, reta_size);
+
+	for (i = 0; i < reta_size; i++) {
+		idx = i / RTE_ETH_RETA_GROUP_SIZE;
+		shift = i % RTE_ETH_RETA_GROUP_SIZE;
+		if (reta_conf[idx].mask & (1ULL << shift))
+			lut_tmp[i] = reta_conf[idx].reta[shift];
+	}
+
+	ret = sxe2_drv_rss_lut_set(adapter, lut_tmp, reta_size);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to set rss lut");
+		goto l_end;
+	}
+
+	rte_memcpy(rss_ctxt->rss_lut, lut_tmp, reta_size);
+
+l_end:
+	if (lut_tmp)
+		rte_free(lut_tmp);
+	return ret;
+}
+
+int32_t sxe2_dev_rss_reta_query(struct rte_eth_dev *dev,
+		struct rte_eth_rss_reta_entry64 *reta_conf,
+		uint16_t reta_size)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_rss_context *rss_ctxt = &adapter->rss_ctxt;
+	int32_t ret = 0;
+	uint16_t i;
+	uint16_t shift;
+	uint16_t idx;
+
+	if (!adapter->rss_ctxt.inited) {
+		PMD_DEV_LOG_INFO(adapter, DRV, "RSS not inited.");
+		ret = -ENOTSUP;
+		goto l_end;
+	}
+
+	if (reta_size != rss_ctxt->rss_lut_size) {
+		PMD_LOG_ERR(INIT, "The size of hash lookup table configured "
+			"(%d) doesn't match the number of hardware can "
+			"support (%d)", reta_size, rss_ctxt->rss_lut_size);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	for (i = 0; i < reta_size; i++) {
+		idx = i / RTE_ETH_RETA_GROUP_SIZE;
+		shift = i % RTE_ETH_RETA_GROUP_SIZE;
+		if (reta_conf[idx].mask & (1ULL << shift))
+			reta_conf[idx].reta[shift] = rss_ctxt->rss_lut[i];
+	}
+
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_rss_hash_key_update(struct rte_eth_dev *dev,
+		struct rte_eth_rss_conf *rss_conf)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_rss_context *rss_ctxt = &adapter->rss_ctxt;
+	int32_t ret = 0;
+	uint16_t i;
+
+	if (rss_conf->rss_key_len == 0 || rss_conf->rss_key == NULL)
+		goto l_end;
+
+	if (rss_conf->rss_key_len != rss_ctxt->rss_key_size) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "The size of hash key configured "
+			"(%d) doesn't match the size of hardware can "
+			"support (%d)", rss_conf->rss_key_len,
+			rss_ctxt->rss_key_size);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	for (i = 0; i < rss_conf->rss_key_len; i++) {
+		if (rss_conf->rss_key[i] != rss_ctxt->rss_key[i])
+			break;
+	}
+	if (i == rss_conf->rss_key_len)
+		goto l_end;
+
+	ret = sxe2_drv_rss_key_set(adapter, rss_conf->rss_key,
+				   rss_conf->rss_key_len);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to set rss key");
+		goto l_end;
+	}
+
+	rte_memcpy(rss_ctxt->rss_key, rss_conf->rss_key, rss_conf->rss_key_len);
+l_end:
+	return ret;
+}
+
+int32_t sxe2_dev_rss_hash_update(struct rte_eth_dev *dev,
+		struct rte_eth_rss_conf *rss_conf)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_rss_context *rss_ctxt = &adapter->rss_ctxt;
+	int32_t ret = -1;
+
+	if (!adapter->rss_ctxt.inited) {
+		PMD_DEV_LOG_INFO(adapter, DRV, "RSS not inited.");
+		ret = -ENOTSUP;
+		goto l_end;
+	}
+
+	ret = sxe2_rss_hash_key_update(dev, rss_conf);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to set rss hash key");
+		goto l_end;
+	}
+
+	if (rss_conf->algorithm != rss_ctxt->hash_func) {
+		ret = sxe2_rss_hash_function_set(dev, rss_conf->algorithm);
+		if (ret) {
+			PMD_DEV_LOG_ERR(adapter, DRV, "Failed to set rss hash function");
+			goto l_end;
+		}
+		rss_ctxt->hash_func = rss_conf->algorithm;
+	}
+
+	if ((rss_conf->rss_hf & SXE2_RSS_HF_SUPPORT_ALL)
+			!= rss_ctxt->rss_hf) {
+		ret = sxe2_rss_hf_type_set(dev, rss_conf->rss_hf);
+		if (ret) {
+			PMD_DEV_LOG_ERR(adapter, DRV, "Failed to set rss hf type");
+			goto l_end;
+		}
+	}
+	ret = 0;
+l_end:
+	return ret;
+}
+
+int32_t sxe2_dev_rss_hash_conf_get(struct rte_eth_dev *dev,
+		struct rte_eth_rss_conf *rss_conf)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_rss_context *rss_ctxt = &adapter->rss_ctxt;
+	int32_t ret = 0;
+
+	if (adapter->rss_ctxt.inited == 0) {
+		PMD_DEV_LOG_INFO(adapter, DRV, "RSS not inited.");
+		ret = -ENOTSUP;
+		goto l_end;
+	}
+
+	if (rss_conf->rss_key) {
+		rss_conf->rss_key_len = rss_ctxt->rss_key_size;
+		rte_memcpy(rss_conf->rss_key, rss_ctxt->rss_key, rss_ctxt->rss_key_size);
+	}
+	rss_conf->rss_hf = rss_ctxt->rss_hf;
+	rss_conf->algorithm = rss_ctxt->hash_func;
+l_end:
+	return ret;
+}
diff --git a/drivers/net/sxe2/sxe2_rss.h b/drivers/net/sxe2/sxe2_rss.h
new file mode 100644
index 0000000000..2a454ac1b3
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_rss.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_RSS_H__
+#define __SXE2_RSS_H__
+#include <ethdev_driver.h>
+#include "sxe2_osal.h"
+#include "sxe2_drv_cmd.h"
+#include "sxe2_flow_define.h"
+
+#define SXE2_FLOW_END (0xFFFF)
+
+struct sxe2_rss_context {
+	enum rte_eth_hash_function hash_func;
+	uint16_t rss_key_size;
+	uint16_t rss_lut_size;
+	uint8_t  *rss_key;
+	uint8_t  *rss_lut;
+	uint64_t rss_hf;
+	uint8_t symm;
+	bool inited;
+};
+
+struct sxe2_rss_hf_config {
+	uint64_t rss_hf;
+	uint16_t hdrs[SXE2_FLOW_HDR_MAX];
+	uint16_t flds[SXE2_FLOW_FLD_ID_MAX];
+	uint8_t symm;
+};
+
+#define SXE2_RSS_HF_SUPPORT_ALL ( \
+	RTE_ETH_RSS_IPV4 | \
+	RTE_ETH_RSS_FRAG_IPV4 | \
+	RTE_ETH_RSS_NONFRAG_IPV4_TCP | \
+	RTE_ETH_RSS_NONFRAG_IPV4_UDP | \
+	RTE_ETH_RSS_NONFRAG_IPV4_SCTP | \
+	RTE_ETH_RSS_NONFRAG_IPV4_OTHER | \
+	RTE_ETH_RSS_IPV6 | \
+	RTE_ETH_RSS_FRAG_IPV6 | \
+	RTE_ETH_RSS_NONFRAG_IPV6_TCP | \
+	RTE_ETH_RSS_NONFRAG_IPV6_UDP | \
+	RTE_ETH_RSS_NONFRAG_IPV6_SCTP | \
+	RTE_ETH_RSS_NONFRAG_IPV6_OTHER | \
+	RTE_ETH_RSS_L2_PAYLOAD)
+
+struct sxe2_adapter;
+
+void sxe2_sw_rss_ctx_hw_cap_set(struct sxe2_adapter *adapter,
+		struct sxe2_drv_rss_hash_caps *rss_caps);
+
+int32_t sxe2_rss_hash_key_init(struct rte_eth_dev *dev);
+
+void sxe2_rss_hash_key_uninit(struct rte_eth_dev *dev);
+
+int32_t sxe2_rss_lut_init(struct rte_eth_dev *dev);
+
+void sxe2_rss_lut_uninit(struct rte_eth_dev *dev);
+
+int32_t sxe2_rss_init(struct rte_eth_dev *dev);
+
+int32_t sxe2_rss_hash_function_set(struct rte_eth_dev *dev, enum rte_eth_hash_function func);
+
+int32_t sxe2_rss_hf_type_set(struct rte_eth_dev *dev, uint64_t rss_hf);
+
+int32_t sxe2_rss_disable(struct rte_eth_dev *dev);
+
+int32_t sxe2_dev_rss_reta_update(struct rte_eth_dev *dev,
+		struct rte_eth_rss_reta_entry64 *reta_conf,
+		uint16_t reta_size);
+
+int32_t sxe2_dev_rss_reta_query(struct rte_eth_dev *dev,
+		struct rte_eth_rss_reta_entry64 *reta_conf,
+		uint16_t reta_size);
+
+int32_t sxe2_dev_rss_hash_update(struct rte_eth_dev *dev,
+		struct rte_eth_rss_conf *rss_conf);
+
+int32_t sxe2_dev_rss_hash_conf_get(struct rte_eth_dev *dev,
+		struct rte_eth_rss_conf *rss_conf);
+#endif /* __SXE2_RSS_H__ */
diff --git a/drivers/net/sxe2/sxe2_txrx.h b/drivers/net/sxe2/sxe2_txrx.h
index 6d3d7455c2..a642a077bf 100644
--- a/drivers/net/sxe2/sxe2_txrx.h
+++ b/drivers/net/sxe2/sxe2_txrx.h
@@ -20,4 +20,8 @@ int32_t sxe2_tx_burst_mode_get(struct rte_eth_dev *dev,
 			__rte_unused uint16_t queue_id, struct rte_eth_burst_mode *mode);
 int32_t sxe2_rx_burst_mode_get(struct rte_eth_dev *dev,
 			__rte_unused uint16_t queue_id, struct rte_eth_burst_mode *mode);
+#ifndef RTE_LIBRTE_SXE2_16BYTE_RX_DESC
+int32_t sxe2_rx_update_ptp_time(struct sxe2_rx_queue *rxq);
+#endif
+
 #endif /* __SXE2_TXRX_H__ */
diff --git a/drivers/net/sxe2/sxe2_txrx_poll.c b/drivers/net/sxe2/sxe2_txrx_poll.c
index 21d5c38725..3c6fe37404 100644
--- a/drivers/net/sxe2/sxe2_txrx_poll.c
+++ b/drivers/net/sxe2/sxe2_txrx_poll.c
@@ -17,6 +17,7 @@
 #include "sxe2_queue.h"
 #include "sxe2_ethdev.h"
 #include "sxe2_common_log.h"
+#include "sxe2_cmd_chnl.h"
 
 static __rte_always_inline int32_t
 sxe2_tx_bufs_free(struct sxe2_tx_queue *txq)
@@ -282,6 +283,30 @@ sxe2_tx_desc_checksum_fill(uint64_t offloads, uint32_t *desc_cmd, uint32_t *desc
 	return;
 }
 
+static __rte_always_inline void sxe2_desc_tso_fill(struct rte_mbuf *tx_pkt,
+						   uint64_t *desc_type_cmd_tso_mss,
+						   union sxe2_tx_offload_info ol_info)
+{
+	uint32_t hdr_len;
+	uint32_t tso_len;
+
+	if (!ol_info.l4_len) {
+		PMD_LOG_DEBUG(TX, "TSO ERROR: L4 length is 0");
+		goto l_end;
+	}
+	hdr_len = ol_info.l2_len + ol_info.l3_len + ol_info.l4_len;
+	if (tx_pkt->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
+		hdr_len += ol_info.outer_l2_len + ol_info.outer_l3_len;
+
+	tso_len = tx_pkt->pkt_len - hdr_len;
+	*desc_type_cmd_tso_mss |=
+			((uint64_t)SXE2_TX_CTXT_DESC_CMD_TSO << SXE2_TX_CTXT_DESC_CMD_SHIFT) |
+			((uint64_t)tso_len << SXE2_TX_CTXT_DESC_TSO_LEN_SHIFT) |
+			((uint64_t)tx_pkt->tso_segsz << SXE2_TX_CTXT_DESC_MSS_SHIFT);
+l_end:
+	return;
+}
+
 static __rte_always_inline uint64_t
 sxe2_tx_data_desc_build_cobt(uint32_t cmd, uint32_t offset, uint16_t buf_size, uint16_t l2tag)
 {
@@ -395,6 +420,11 @@ uint16_t sxe2_tx_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkt
 				rte_pktmbuf_free_seg(buffer->mbuf);
 				buffer->mbuf = NULL;
 			}
+			if (offloads & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
+				sxe2_desc_tso_fill(tx_pkt,
+					&desc_type_cmd_tso_mss, ol_info);
+			else if (offloads & RTE_MBUF_F_TX_IEEE1588_TMST)
+				desc_type_cmd_tso_mss |= SXE2_TX_CTXT_DESC_CMD_TSYN_MASK;
 
 			if (offloads & RTE_MBUF_F_TX_QINQ) {
 				desc_l2tag2 = tx_pkt->vlan_tci_outer;
@@ -707,6 +737,57 @@ sxe2_rx_desc_filter_para_fill(struct sxe2_rx_queue *rxq __rte_unused,
 #endif
 }
 
+#ifndef RTE_LIBRTE_SXE2_16BYTE_RX_DESC
+int32_t sxe2_rx_update_ptp_time(struct sxe2_rx_queue *rxq)
+{
+	struct sxe2_adapter *adapter;
+	uint64_t cur_time_ms;
+	int32_t ret = 0;
+	cur_time_ms = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
+
+	if (likely((cur_time_ms - rxq->update_time) < SXE2_RX_PKTS_TS_TIMEOUT_VAL))
+		goto l_end;
+	rxq->update_time = cur_time_ms;
+	adapter = rxq->vsi->adapter;
+	rxq->ts_need_update = true;
+	ret = sxe2_drv_ptp_gettime(adapter, rxq);
+	if (rxq->desc_ts < rxq->ts_low)
+		rxq->ts_need_update = false;
+
+	PMD_LOG_INFO(RX, "rxq update time ret=%d, cur time=%" PRIu64 ", rxqh=%" PRIu64 ", rxql=%d",
+		     ret, cur_time_ms, rxq->ts_high, rxq->ts_low);
+l_end:
+	return ret;
+}
+
+static inline void sxe2_rx_desc_ptp_para_fill(struct sxe2_rx_queue *rxq,
+					      struct rte_mbuf *mbuf,
+					      union sxe2_rx_desc *desc)
+{
+	struct sxe2_adapter *adapter = rxq->vsi->adapter;
+	uint64_t ts_ns;
+
+	if (adapter->ptp_ctxt.mbuf_rx_ts_flag != 0 &&
+	    (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) &&
+	    SXE2_RX_DESC_RXDID_VAL_GET(desc->wb.rxdid_src) == SXE2_RX_DESC_RXDID_1588) {
+		rxq->desc_ts = rte_le_to_cpu_32(desc->wb_ts.ts_h);
+		(void)sxe2_rx_update_ptp_time(rxq);
+		if (rxq->ts_need_update && rxq->desc_ts < rxq->ts_low)
+			rxq->ts_high += 1;
+
+		rxq->ts_need_update = true;
+		rxq->ts_low = rxq->desc_ts;
+		rxq->update_time = rte_get_timer_cycles() /
+			(rte_get_timer_hz() / 1000);
+		ts_ns = rxq->ts_high * NSEC_PER_SEC + rxq->ts_low;
+		*RTE_MBUF_DYNFIELD(mbuf, adapter->ptp_ctxt.mbuf_rx_ts_offset, uint64_t *) = ts_ns;
+		mbuf->ol_flags |= adapter->ptp_ctxt.mbuf_rx_ts_flag;
+		PMD_LOG_INFO(RX, "receive ptp pkt,ts_s=%" PRIu64 ", ts_ns=%d", rxq->ts_high,
+			     rxq->ts_low);
+	}
+}
+#endif
+
 static __rte_always_inline void
 sxe2_rx_mbuf_common_fields_fill(struct sxe2_rx_queue *rxq, struct rte_mbuf *mbuf,
 		union sxe2_rx_desc *rxd)
@@ -718,10 +799,12 @@ sxe2_rx_mbuf_common_fields_fill(struct sxe2_rx_queue *rxq, struct rte_mbuf *mbuf
 
 	mbuf->ol_flags = 0;
 	mbuf->packet_type = ptype_tbl[SXE2_RX_DESC_PTYPE_VAL_GET(qword1)];
-
 	pkt_flags = sxe2_rx_desc_error_para(rxq, rxd);
 	sxe2_rx_desc_vlan_para_fill(mbuf, rxd);
 	sxe2_rx_desc_filter_para_fill(rxq, mbuf, rxd);
+#ifndef RTE_LIBRTE_SXE2_16BYTE_RX_DESC
+	sxe2_rx_desc_ptp_para_fill(rxq, mbuf, rxd);
+#endif
 
 	mbuf->ol_flags |= pkt_flags;
 }
-- 
2.47.3

