Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD549CD4855
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 07:55:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53FD840615;
	Tue, 12 May 2026 09:55:51 +0200 (CEST)
Received: from mail.amicon.ru (mail.amicon.ru [77.108.111.100])
 by mails.dpdk.org (Postfix) with ESMTP id 6AB1240265;
 Thu,  7 May 2026 15:21:27 +0200 (CEST)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
 t=1778160085; h=from:subject:to:date:message-id;
 bh=WSLN3yV2fl1cK+fLzOxGfllNUWLh5ban5TsY//mlL/Y=;
 b=fQnBTv/UmHeM5PvMOJ3N9VQY9jWHNouiTRpOrGMDHo0s8Dxhg0OBAlttQLHckkqamRhY/8B+g9K
 7pkhHnAT9re2PDoNVC0iUQ2yBo3BIRXr4gtfHth4ep35N5QVPJk37U2JmZnS/k3TEz36eStc+nXTj
 vEvvZnKwMSsYIAMXkgdt5/fPXcNZN8i1/BEbhwY7THBg3q3Fl3to1oCpcvzA0kYNjFcgbD9IIfzja
 uL/ZQGZtQWneQ9U//tYT0olMiSms6u0vtN4KYvmobiHRktoIXiwCkWwG1BBFBFiznRa0Q0ZkCePRW
 baUCj07AFhZBN/39cBRTLba0H4Jy32tMG0Eg==
Received: from dish.amicon.lan (172.16.2.39) by mail.amicon.lan (192.168.0.59)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Thu, 7 May
 2026 16:21:25 +0300
From: Daniil Iskhakov <dish@amicon.ru>
To: Anatoly Burakov <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Wei Zhao <wei.zhao1@intel.com>, Wenzhuo Lu
 <wenzhuo.lu@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Daniil Iskhakov <dish@amicon.ru>,
 Daniil Agalakov <ade@amicon.ru>, <sdl.dpdk@linuxtesting.org>, <rrv@amicon.ru>
Subject: [PATCH v2] net/ixgbe: fix MAC/VLAN item validation for ntuple
Date: Thu, 7 May 2026 16:21:17 +0300
Message-ID: <20260507132117.1449179-1-dish@amicon.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Originating-IP: [172.16.2.39]
X-ClientProxiedBy: mail.amicon.lan (192.168.0.59) To mail.amicon.lan
 (192.168.0.59)
X-Mailman-Approved-At: Tue, 12 May 2026 09:55:49 +0200
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
first item is ETH or VLAN, its spec and mask are either absent or
contain only zero fields. The current check is:

  if ((item->spec || item->mask) &&
      (memcmp(spec, &null_struct, size) ||
       memcmp(mask, &null_struct, size)))

This condition is logically incorrect. If item->spec points to a
zero-filled structure and item->mask is NULL, memcmp(mask) would
dereference a NULL pointer.

The intended behavior is to reject any non-zero spec or mask.

Guard each memcmp() call with a check of the corresponding pointer while
keeping a single error path.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 46ea969177f3 ("net/ixgbe: add ntuple support to flow parser")
Cc: stable@dpdk.org

Signed-off-by: Daniil Agalakov <ade@amicon.ru>
Signed-off-by: Daniil Iskhakov <dish@amicon.ru>
---
v2:
- Kept spec/mask validation as a single condition.
- Added explicit comparisons against NULL and zero.
- Fixed continuation indentation.
- Fixed the commit message.

Cc: wei.zhao1@intel.com
Cc: sdl.dpdk@linuxtesting.org
Cc: rrv@amicon.ru
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 01cd4f9bde..a855cbfbd2 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -238,14 +238,10 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 
 		}
 		/* if the first item is MAC, the content should be NULL */
-		if ((item->spec || item->mask) &&
-			(memcmp(eth_spec, &eth_null,
-				sizeof(struct rte_flow_item_eth)) ||
-			 memcmp(eth_mask, &eth_null,
-				sizeof(struct rte_flow_item_eth)))) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by ntuple filter");
+		if ((item->spec != NULL && memcmp(eth_spec, &eth_null, sizeof(eth_null)) != 0) ||
+		    (item->mask != NULL && memcmp(eth_mask, &eth_null, sizeof(eth_null)) != 0)) {
+			rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM, item,
+					"Not supported by ntuple filter");
 			return -rte_errno;
 		}
 		/* check if the next not void item is IPv4 or Vlan */
@@ -271,15 +267,10 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 			return -rte_errno;
 		}
 		/* the content should be NULL */
-		if ((item->spec || item->mask) &&
-			(memcmp(vlan_spec, &vlan_null,
-				sizeof(struct rte_flow_item_vlan)) ||
-			 memcmp(vlan_mask, &vlan_null,
-				sizeof(struct rte_flow_item_vlan)))) {
-
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by ntuple filter");
+		if ((item->spec != NULL && memcmp(vlan_spec, &vlan_null, sizeof(vlan_null)) != 0) ||
+		    (item->mask != NULL && memcmp(vlan_mask, &vlan_null, sizeof(vlan_null)) != 0)) {
+			rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM, item,
+					"Not supported by ntuple filter");
 			return -rte_errno;
 		}
 		/* check if the next not void item is IPv4 */
-- 
2.43.0

