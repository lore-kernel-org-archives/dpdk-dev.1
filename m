Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2799BC88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 10:46:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EAE7941157;
	Tue, 15 Sep 2026 12:46:21 +0200 (CEST)
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
 by mails.dpdk.org (Postfix) with ESMTP id 700F640A7A;
 Tue, 15 Sep 2026 12:46:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru D50982C0B19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
 t=1789469180; bh=CsaDz6H6SeoBlXFR+WlHSLv3CsM4faRlQibxVWVe3VM=;
 h=From:To:CC:Subject:Date:From;
 b=SGn8JqldFDFO0EmJ7rAOn7z6tPx4niSFB1dys28bfQZwfRKhXBPZ7q9Gnt6kQ9SqM
 VrmN8ZmeaJ3Zk3sW3vR3N9kyipfzyziUZ9GR91VBiCKIOHhTYmmchC0OoijrBEGA4A
 u6Ah7oq6pttaVEL7N+uDt0odXI5s2H6YJGtr6TMM=
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
 by mx0.infotecs.ru (Postfix) with ESMTP id D50982C0B19;
 Tue, 15 Sep 2026 13:46:19 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs-nt 879F22C0ACE
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
 by mx0.infotecs-nt (Postfix) with ESMTP id 879F22C0ACE;
 Tue, 15 Sep 2026 13:46:19 +0300 (MSK)
From: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <simei.su@intel.com>, Sokolov Evgeny
 <Evgeny.Sokolov@infotecs.ru>
Subject: [PATCH 3/5] removing the next_type enum
Date: Tue, 15 Sep 2026 10:46:17 +0000
Message-ID: <20260915104617.467149-1-Evgeny.Sokolov@infotecs.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [11.0.20.76]
X-ClientProxiedBy: msk-exch-02.infotecs-nt (10.0.7.192) To
 msk-exch-02.infotecs-nt (10.0.7.192)
X-EXCLAIMER-MD-CONFIG: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 3.0.0.9059,
 bases: 2026/09/15 09:01:00 #28584736
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 8
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

From: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>

---
 drivers/net/intel/iavf/iavf_fdir.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_fdir.c b/drivers/net/intel/iavf/iavf_fdir.c
index 3213464254..ddfa1b97be 100644
--- a/drivers/net/intel/iavf/iavf_fdir.c
+++ b/drivers/net/intel/iavf/iavf_fdir.c
@@ -745,7 +745,6 @@ iavf_fdir_parse_pattern(__rte_unused struct iavf_adapter *ad,
 	struct rte_ecpri_common_hdr ecpri_common;
 	uint64_t input_set = IAVF_INSET_NONE;
 	enum rte_flow_item_type item_type;
-	enum rte_flow_item_type next_type;
 	uint8_t tun_inner = 0;
 	uint16_t ether_type, flags_version;
 	uint8_t item_num = 0;
@@ -835,13 +834,12 @@ iavf_fdir_parse_pattern(__rte_unused struct iavf_adapter *ad,
 		case RTE_FLOW_ITEM_TYPE_ETH:
 			eth_spec = item->spec;
 			eth_mask = item->mask;
-			next_type = (item + 1)->type;
 
 			hdr1 = &hdrs->proto_hdr[layer];
 
 			VIRTCHNL_SET_PROTO_HDR_TYPE(hdr1, ETH);
 
-			if (next_type == RTE_FLOW_ITEM_TYPE_END &&
+			if (((item + 1)->type == RTE_FLOW_ITEM_TYPE_END) &&
 			    (!eth_spec || !eth_mask)) {
 				rte_flow_error_set(error, EINVAL,
 						RTE_FLOW_ERROR_TYPE_ITEM,
@@ -891,13 +889,11 @@ iavf_fdir_parse_pattern(__rte_unused struct iavf_adapter *ad,
 
 			hdrs->count = ++layer;
 			break;
-
 		case RTE_FLOW_ITEM_TYPE_IPV4:
 			l3 = RTE_FLOW_ITEM_TYPE_IPV4;
 			ipv4_spec = item->spec;
 			ipv4_last = item->last;
 			ipv4_mask = item->mask;
-			next_type = (item + 1)->type;
 
 			hdr = &hdrs->proto_hdr[layer];
 
@@ -1075,7 +1071,6 @@ iavf_fdir_parse_pattern(__rte_unused struct iavf_adapter *ad,
 		case RTE_FLOW_ITEM_TYPE_IPV6_FRAG_EXT:
 			ipv6_frag_spec = item->spec;
 			ipv6_frag_mask = item->mask;
-			next_type = (item + 1)->type;
 
 			hdr = &hdrs->proto_hdr[layer];
 
-- 
2.39.5

