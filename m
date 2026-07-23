Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63B5C531CB
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 12:56:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 423E740A6F;
	Thu, 23 Jul 2026 14:56:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C2BDB40A72
 for <dev@dpdk.org>; Thu, 23 Jul 2026 14:56:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784811391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3uZLo1keMlMBhZ/3aJUo1AF2zgKGQtm+RzLUAX/Lk0s=;
 b=CzZj0tDAg6kmpNmk0d4HUPH0alOm1Y311ZzqWQHclYsfHtvxo3fttJciucAvmYJgBtMkJr
 F5tEYMfW2PABSiAFoHW09yVMOzgKmRXxV8tsagR4oud1OGk+ThxFb4da1pz/7SMluqaUCV
 DssywLRLoseSt1NrGtb5va9/bZDw5dw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-r5aE4_CuMp6Ng_HaRhAqmA-1; Thu,
 23 Jul 2026 08:56:28 -0400
X-MC-Unique: r5aE4_CuMp6Ng_HaRhAqmA-1
X-Mimecast-MFC-AGG-ID: r5aE4_CuMp6Ng_HaRhAqmA_1784811387
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A65C1945CB4; Thu, 23 Jul 2026 12:56:27 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 66EA518002A0; Thu, 23 Jul 2026 12:56:25 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Chas Williams <3chas3@gmail.com>,
 "Min Hu (Connor)" <humin29@huawei.com>
Subject: [PATCH v2 4/9] test/bonding: get MAC address with public API
Date: Thu, 23 Jul 2026 14:55:53 +0200
Message-ID: <20260723125559.3087579-5-david.marchand@redhat.com>
In-Reply-To: <20260723125559.3087579-1-david.marchand@redhat.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260723125559.3087579-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: STWA5W-_85pcqG3Y-GE6f4oujqSZQOFINYIHwN6vL9E_1784811387
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Replace direct rte_eth_devices[].data->mac_addrs access with
rte_eth_macaddr_get() public API. This removes the dependency
on the internal ethdev_driver.h header.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 app/test/test_link_bonding.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/app/test/test_link_bonding.c b/app/test/test_link_bonding.c
index 19b064771a..b9c6718e36 100644
--- a/app/test/test_link_bonding.c
+++ b/app/test/test_link_bonding.c
@@ -19,7 +19,6 @@
 #include <rte_common.h>
 #include <rte_debug.h>
 #include <rte_ethdev.h>
-#include <ethdev_driver.h>
 #include <rte_log.h>
 #include <rte_lcore.h>
 #include <rte_memory.h>
@@ -4763,7 +4762,7 @@ test_alb_change_mac_in_reply_sent(void)
 	int retval = 0;
 
 	struct rte_ether_addr bond_mac, client_mac;
-	struct rte_ether_addr *member_mac1, *member_mac2;
+	struct rte_ether_addr member_mac1, member_mac2;
 
 	TEST_ASSERT_SUCCESS(
 			initialize_bonding_device_with_members(BONDING_MODE_ALB,
@@ -4779,9 +4778,7 @@ test_alb_change_mac_in_reply_sent(void)
 				MAX_PKT_BURST);
 	}
 
-	rte_ether_addr_copy(
-			rte_eth_devices[test_params->bonding_port_id].data->mac_addrs,
-			&bond_mac);
+	rte_eth_macaddr_get(test_params->bonding_port_id, &bond_mac);
 
 	/*
 	 * Generating four packets with different mac and ip addresses and sending
@@ -4831,10 +4828,8 @@ test_alb_change_mac_in_reply_sent(void)
 			RTE_ARP_OP_REPLY);
 	rte_eth_tx_burst(test_params->bonding_port_id, 0, &pkt, 1);
 
-	member_mac1 =
-			rte_eth_devices[test_params->member_port_ids[0]].data->mac_addrs;
-	member_mac2 =
-			rte_eth_devices[test_params->member_port_ids[1]].data->mac_addrs;
+	rte_eth_macaddr_get(test_params->member_port_ids[0], &member_mac1);
+	rte_eth_macaddr_get(test_params->member_port_ids[1], &member_mac2);
 
 	/*
 	 * Checking if packets are properly distributed on bonding ports. Packets
@@ -4852,13 +4847,13 @@ test_alb_change_mac_in_reply_sent(void)
 						sizeof(struct rte_ether_hdr));
 
 			if (member_idx%2 == 0) {
-				if (!rte_is_same_ether_addr(member_mac1,
+				if (!rte_is_same_ether_addr(&member_mac1,
 						&arp_pkt->arp_data.arp_sha)) {
 					retval = -1;
 					goto test_end;
 				}
 			} else {
-				if (!rte_is_same_ether_addr(member_mac2,
+				if (!rte_is_same_ether_addr(&member_mac2,
 						&arp_pkt->arp_data.arp_sha)) {
 					retval = -1;
 					goto test_end;
@@ -4885,7 +4880,7 @@ test_alb_reply_from_client(void)
 	int retval = 0;
 
 	struct rte_ether_addr bond_mac, client_mac;
-	struct rte_ether_addr *member_mac1, *member_mac2;
+	struct rte_ether_addr member_mac1, member_mac2;
 
 	TEST_ASSERT_SUCCESS(
 			initialize_bonding_device_with_members(BONDING_MODE_ALB,
@@ -4900,9 +4895,7 @@ test_alb_reply_from_client(void)
 				MAX_PKT_BURST);
 	}
 
-	rte_ether_addr_copy(
-			rte_eth_devices[test_params->bonding_port_id].data->mac_addrs,
-			&bond_mac);
+	rte_eth_macaddr_get(test_params->bonding_port_id, &bond_mac);
 
 	/*
 	 * Generating four packets with different mac and ip addresses and placing
@@ -4963,8 +4956,8 @@ test_alb_reply_from_client(void)
 	rte_eth_rx_burst(test_params->bonding_port_id, 0, pkts_sent, MAX_PKT_BURST);
 	rte_eth_tx_burst(test_params->bonding_port_id, 0, NULL, 0);
 
-	member_mac1 = rte_eth_devices[test_params->member_port_ids[0]].data->mac_addrs;
-	member_mac2 = rte_eth_devices[test_params->member_port_ids[1]].data->mac_addrs;
+	rte_eth_macaddr_get(test_params->member_port_ids[0], &member_mac1);
+	rte_eth_macaddr_get(test_params->member_port_ids[1], &member_mac2);
 
 	/*
 	 * Checking if update ARP packets were properly send on member ports.
@@ -4981,13 +4974,13 @@ test_alb_reply_from_client(void)
 						sizeof(struct rte_ether_hdr));
 
 			if (member_idx%2 == 0) {
-				if (!rte_is_same_ether_addr(member_mac1,
+				if (!rte_is_same_ether_addr(&member_mac1,
 						&arp_pkt->arp_data.arp_sha)) {
 					retval = -1;
 					goto test_end;
 				}
 			} else {
-				if (!rte_is_same_ether_addr(member_mac2,
+				if (!rte_is_same_ether_addr(&member_mac2,
 						&arp_pkt->arp_data.arp_sha)) {
 					retval = -1;
 					goto test_end;
@@ -5035,9 +5028,7 @@ test_alb_receive_vlan_reply(void)
 				MAX_PKT_BURST);
 	}
 
-	rte_ether_addr_copy(
-			rte_eth_devices[test_params->bonding_port_id].data->mac_addrs,
-			&bond_mac);
+	rte_eth_macaddr_get(test_params->bonding_port_id, &bond_mac);
 
 	/*
 	 * Generating packet with double VLAN header and placing it in the rx queue.
-- 
2.54.0

