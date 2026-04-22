Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD7BF9B607
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Apr 2026 10:28:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CEB540654;
	Wed, 22 Apr 2026 12:28:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id DC72E402E0
 for <dev@dpdk.org>; Wed, 22 Apr 2026 12:28:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776853721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tLda3QcwdGCjBTJ8NIAB5FsNT5cAhh9yWYis6b1NJsg=;
 b=L7oXD+BKydNw5tIC13F/oMhCMUiZmbJ+KAnJWUFgxCZ8nKGEhYCjkDoj9ERwPNd7PUy4F4
 37dTwJ0pS1ysO4ejpztMHihtfLcAolU2ZcAh/9WYuagKZyTSEyG4XfaSyytUgWwYZac0aF
 9/L/m+nE+pIN9o6g1n3B1/VX5gQYk30=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-N1WQVN4zOEm7eYkzhmNb1Q-1; Wed,
 22 Apr 2026 06:28:37 -0400
X-MC-Unique: N1WQVN4zOEm7eYkzhmNb1Q-1
X-Mimecast-MFC-AGG-ID: N1WQVN4zOEm7eYkzhmNb1Q_1776853716
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 300F51956055; Wed, 22 Apr 2026 10:28:36 +0000 (UTC)
Received: from ringo.home (unknown [10.44.48.32])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B6C501800664; Wed, 22 Apr 2026 10:28:34 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org,
	Gregory Etelson <getelson@nvidia.com>
Cc: stable@dpdk.org
Subject: [PATCH dpdk] net: fix L2 ptype assignment in VLAN loop
Date: Wed, 22 Apr 2026 12:28:14 +0200
Message-ID: <20260422102814.645299-2-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J-YIb-DaeWKzD7r3xfPTSSQoHuo3NCWdGHOtNd9TyDo_1776853716
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

Since commit 1f250674085a ("net: fix packet type for stacked VLAN"),
rte_net_get_ptype() uses |= to set the L2 ptype inside the VLAN
parsing loop. Since pkt_type is already initialized with
RTE_PTYPE_L2_ETHER (0x1), or-ing it with RTE_PTYPE_L2_ETHER_VLAN
(0x6) results in RTE_PTYPE_L2_ETHER_QINQ (0x7). This causes single
VLAN frames to be misidentified as QinQ.

This was detected while testing DPDK 25.11.1 in grout. The net/tap
driver calls rte_net_get_ptype() in tap_verify_csum() to determine
the L2 header length. With the wrong ptype, l2_len is set to 22
(ether + QinQ = 14 + 8) instead of 18 (ether + VLAN = 14 + 4),
shifting the IP header pointer by 4 bytes. The checksum is then
computed on garbage data, causing valid packets to be dropped.

Use a simple assignment to replace the L2 ptype instead. Add VLAN
and QinQ test packets in cksum_autotest to prevent regressions.

Fixes: 1f250674085a ("net: fix packet type for stacked VLAN")
Cc: stable@dpdk.org

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 app/test/test_cksum.c | 29 +++++++++++++++++++++++++++++
 lib/net/rte_net.c     |  2 +-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/app/test/test_cksum.c b/app/test/test_cksum.c
index ea443382a128..3cc42eccedd9 100644
--- a/app/test/test_cksum.c
+++ b/app/test/test_cksum.c
@@ -75,6 +75,27 @@ static const char test_cksum_ipv6_udp[] = {
 	0x00, 0x35, 0x00, 0x09, 0x87, 0x70, 0x78,
 };
 
+/* generated in scapy with Ether()/Dot1Q(vlan=42)/IP()/UDP()/Raw('x') */
+static const char test_cksum_vlan_ipv4_udp[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x81, 0x00, 0x00, 0x2a,
+	0x08, 0x00, 0x45, 0x00, 0x00, 0x1d, 0x00, 0x01,
+	0x00, 0x00, 0x40, 0x11, 0x7c, 0xcd, 0x7f, 0x00,
+	0x00, 0x01, 0x7f, 0x00, 0x00, 0x01, 0x00, 0x35,
+	0x00, 0x35, 0x00, 0x09, 0x89, 0x6f, 0x78,
+};
+
+/* generated in scapy with Ether()/Dot1AD(vlan=42)/Dot1Q(vlan=43)/IP()/UDP()/Raw('x') */
+static const char test_cksum_qinq_ipv4_udp[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x88, 0xa8, 0x00, 0x2a,
+	0x81, 0x00, 0x00, 0x2b, 0x08, 0x00, 0x45, 0x00,
+	0x00, 0x1d, 0x00, 0x01, 0x00, 0x00, 0x40, 0x11,
+	0x7c, 0xcd, 0x7f, 0x00, 0x00, 0x01, 0x7f, 0x00,
+	0x00, 0x01, 0x00, 0x35, 0x00, 0x35, 0x00, 0x09,
+	0x89, 0x6f, 0x78,
+};
+
 /* generated in scapy with Ether()/IP(options='\x00')/UDP()/Raw('x')) */
 static const char test_cksum_ipv4_opts_udp[] = {
 	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
@@ -252,6 +273,14 @@ test_cksum(void)
 			  sizeof(test_cksum_ipv6_udp)) < 0)
 		GOTO_FAIL("checksum error on ipv6_udp");
 
+	if (test_l4_cksum(pktmbuf_pool, test_cksum_vlan_ipv4_udp,
+			  sizeof(test_cksum_vlan_ipv4_udp)) < 0)
+		GOTO_FAIL("checksum error on vlan_ipv4_udp");
+
+	if (test_l4_cksum(pktmbuf_pool, test_cksum_qinq_ipv4_udp,
+			  sizeof(test_cksum_qinq_ipv4_udp)) < 0)
+		GOTO_FAIL("checksum error on qinq_ipv4_udp");
+
 	if (test_l4_cksum(pktmbuf_pool, test_cksum_ipv4_opts_udp,
 			  sizeof(test_cksum_ipv4_opts_udp)) < 0)
 		GOTO_FAIL("checksum error on ipv4_opts_udp");
diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index 458b4814a9c9..ea5ba7019089 100644
--- a/lib/net/rte_net.c
+++ b/lib/net/rte_net.c
@@ -359,7 +359,7 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
 
 		if (++vlan_depth > RTE_NET_VLAN_MAX_DEPTH)
 			return 0;
-		pkt_type |=
+		pkt_type =
 			proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ?
 				 RTE_PTYPE_L2_ETHER_VLAN :
 				 RTE_PTYPE_L2_ETHER_QINQ;
-- 
2.53.0

