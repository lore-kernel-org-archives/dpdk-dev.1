Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012CDCAC5BB
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Oct 2025 07:08:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0083140647;
	Fri, 10 Oct 2025 09:08:02 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 0C65F40267
 for <dev@dpdk.org>; Thu,  9 Oct 2025 17:28:00 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cjDFM4hNKz6M4d5
 for <dev@dpdk.org>; Thu,  9 Oct 2025 23:24:39 +0800 (CST)
Received: from frapema500004.china.huawei.com (unknown [7.182.19.21])
 by mail.maildlp.com (Postfix) with ESMTPS id F3DBC1402E9
 for <dev@dpdk.org>; Thu,  9 Oct 2025 23:27:59 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500004.china.huawei.com (7.182.19.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Oct 2025 17:27:59 +0200
From: Eimear Morrissey <eimear.morrissey@huawei.com>
To: <dev@dpdk.org>
Subject: [PATCH] lib/net: Add ICMP support to rte_net_get_ptype()
Date: Thu, 9 Oct 2025 16:27:40 +0100
Message-ID: <20251009152740.10437-1-eimear.morrissey@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapeml100005.china.huawei.com (7.182.85.132) To
 frapema500004.china.huawei.com (7.182.19.21)
X-Mailman-Approved-At: Fri, 10 Oct 2025 09:08:00 +0200
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

Set RTE_PTYPE_L4_ICMP for ICMP packets.

Signed-off-by: Eimear Morrissey <eimear.morrissey@huawei.com>
---
 lib/net/rte_net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index be24690fdf..eb205ca1b1 100644
--- a/lib/net/rte_net.c
+++ b/lib/net/rte_net.c
@@ -10,6 +10,7 @@
 #include <rte_byteorder.h>
 #include <rte_ether.h>
 #include <rte_ip.h>
+#include <rte_icmp.h>
 #include <rte_tcp.h>
 #include <rte_udp.h>
 #include <rte_sctp.h>
@@ -63,6 +64,7 @@ static uint32_t
 ptype_l4(uint8_t proto)
 {
 	static const uint32_t ptype_l4_proto[256] = {
+		[IPPROTO_ICMP] = RTE_PTYPE_L4_ICMP,
 		[IPPROTO_UDP] = RTE_PTYPE_L4_UDP,
 		[IPPROTO_TCP] = RTE_PTYPE_L4_TCP,
 		[IPPROTO_SCTP] = RTE_PTYPE_L4_SCTP,
@@ -120,6 +122,7 @@ static uint32_t
 ptype_inner_l4(uint8_t proto)
 {
 	static const uint32_t ptype_inner_l4_proto[256] = {
+		[IPPROTO_ICMP] = RTE_PTYPE_INNER_L4_ICMP,
 		[IPPROTO_UDP] = RTE_PTYPE_INNER_L4_UDP,
 		[IPPROTO_TCP] = RTE_PTYPE_INNER_L4_TCP,
 		[IPPROTO_SCTP] = RTE_PTYPE_INNER_L4_SCTP,
-- 
2.35.3

