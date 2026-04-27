Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66A6FF8867
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 09:58:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AE5240655;
	Wed, 29 Apr 2026 11:58:21 +0200 (CEST)
Received: from mail.amicon.ru (mail.amicon.ru [77.108.111.100])
 by mails.dpdk.org (Postfix) with ESMTP id BDC22402BC;
 Mon, 27 Apr 2026 17:16:52 +0200 (CEST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
 t=1777303011; h=from:subject:to:date:message-id;
 bh=cCc8dMmgGEa3kjiPidAihmiCNr4kUm2lowz+zK0Dh2Y=;
 b=W0nVb31/Q2OXdAxeNa55JNJRXjP+RTbwW0Oe555Fw/CwhEmq9p1kJUFEZ70ZjM/ESKCRQR79Rxq
 DWdHAx0LY7q8nMQU9w6IRq5mPdqb0UliBJkS5DDGip9qLEUVXFVKIbE1yKAG7ZtuJwNiCCRAIF22p
 l16IKro0/Rc/Y63OIalsaCpNfZbxaWr3wY2I61jF1ocavmMdCNQnu6Ri2jnmEeRIht29C05FP0gos
 On4BckLXke+iF0A8HC/UnNPgwRGIq6CBqyRxBFeHMY/G+FsEEVxiQkvx0Sw25wCXjHfQ8YY3dQLC5
 u+OFwx+1gUwrkCskYGlr1/l3AIPTP8/zA21g==
Received: from dish.amicon.lan (172.16.2.39) by mail.amicon.lan (192.168.0.59)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 27 Apr
 2026 18:16:51 +0300
From: Daniil Iskhakov <dish@amicon.ru>
To: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, Vladimir
 Medvedkin <vladimir.medvedkin@intel.com>, Wei Zhao <wei.zhao1@intel.com>,
 Wenzhuo Lu <wenzhuo.lu@intel.com>
CC: Daniil Iskhakov <dish@amicon.ru>, <stable@dpdk.org>, Daniil Agalakov
 <ade@amicon.ru>, <sdl.dpdk@linuxtesting.org>, <rrv@amicon.ru>
Subject: [PATCH] net/ixgbe: incorrect MAC/VLAN item validation for ntuple
Date: Mon, 27 Apr 2026 18:16:04 +0300
Message-ID: <20260427151605.1789289-1-dish@amicon.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Originating-IP: [172.16.2.39]
X-ClientProxiedBy: mail.amicon.lan (192.168.0.59) To mail.amicon.lan
 (192.168.0.59)
X-Mailman-Approved-At: Wed, 29 Apr 2026 11:58:18 +0200
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

When parsing an ntuple filter, the code attempts to ensure that if the
first item is ETH (or VLAN), its spec and mask must be NULL (i.e.
zeroed structure). The current check is:

  if ((item->spec || item->mask) &&
      (memcmp(spec, &null_struct, size) ||
          memcmp(mask, &null_struct, size)))

This condition is logically incorrect. If item->spec points to a
zero-filled structure and item->mask is NULL, memcmp(mask) would
dereference a NULL pointer.

The intention os code is to reject any non‑zero spec or mask.

Split the check into two independent conditions for spec and mask.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 46ea969177f3 ("net/ixgbe: add ntuple support to flow parser")
Cc: stable@dpdk.org

Signed-off-by: Daniil Agalakov <ade@amicon.ru>
Signed-off-by: Daniil Iskhakov <dish@amicon.ru>
---
Cc: wei.zhao1@intel.com
Cc: sdl.dpdk@linuxtesting.org
Cc: rrv@amicon.ru
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 37 +++++++++++++++++-----------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 01cd4f9bde..9edfff413e 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -238,14 +238,18 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 
 		}
 		/* if the first item is MAC, the content should be NULL */
-		if ((item->spec || item->mask) &&
-			(memcmp(eth_spec, &eth_null,
-				sizeof(struct rte_flow_item_eth)) ||
-			 memcmp(eth_mask, &eth_null,
-				sizeof(struct rte_flow_item_eth)))) {
+		if (item->spec && memcmp(eth_spec, &eth_null,
+			sizeof(struct rte_flow_item_eth))) {
 			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by ntuple filter");
+			  RTE_FLOW_ERROR_TYPE_ITEM,
+			  item, "Not supported by ntuple filter");
+			return -rte_errno;
+		}
+		if (item->mask && memcmp(eth_mask, &eth_null,
+			sizeof(struct rte_flow_item_eth))) {
+			rte_flow_error_set(error, EINVAL,
+			  RTE_FLOW_ERROR_TYPE_ITEM,
+			  item, "Not supported by ntuple filter");
 			return -rte_errno;
 		}
 		/* check if the next not void item is IPv4 or Vlan */
@@ -271,15 +275,18 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 			return -rte_errno;
 		}
 		/* the content should be NULL */
-		if ((item->spec || item->mask) &&
-			(memcmp(vlan_spec, &vlan_null,
-				sizeof(struct rte_flow_item_vlan)) ||
-			 memcmp(vlan_mask, &vlan_null,
-				sizeof(struct rte_flow_item_vlan)))) {
-
+		if (item->spec && memcmp(vlan_spec, &vlan_null,
+			sizeof(struct rte_flow_item_vlan))) {
 			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by ntuple filter");
+			  RTE_FLOW_ERROR_TYPE_ITEM,
+			  item, "Not supported by ntuple filter");
+			return -rte_errno;
+		}
+		if (item->mask && memcmp(vlan_mask, &vlan_null,
+			sizeof(struct rte_flow_item_vlan))) {
+			rte_flow_error_set(error, EINVAL,
+			  RTE_FLOW_ERROR_TYPE_ITEM,
+			  item, "Not supported by ntuple filter");
 			return -rte_errno;
 		}
 		/* check if the next not void item is IPv4 */
-- 
2.43.0

