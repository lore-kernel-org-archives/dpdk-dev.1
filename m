Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19D0CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 13:28:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D6E440672;
	Mon, 18 May 2026 15:27:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id AD73D402B8
 for <dev@dpdk.org>; Mon, 18 May 2026 15:27:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779110861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=skGhwqMmxXw6fBirY9e1/vEZvbiLRp/vkCSYcz5EoVo=;
 b=cHUttL6iG/D4LU4NE+uqTTX6SY0L6pBYPDN8Mf60BFRPBE72wVOY12fS8pHdMn119Zg0DV
 I4WZP238Fvokf7MrD5NS5ccA5UF9wJkbbEHR/ie85xqrkGk1yvnADJ6SUWTZv5IGmZAKip
 8l1UGdYqSR10b6ixMs876gjLaukQE5s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-DBBsJuyXNEG1drEAlnuqmg-1; Mon,
 18 May 2026 09:27:39 -0400
X-MC-Unique: DBBsJuyXNEG1drEAlnuqmg-1
X-Mimecast-MFC-AGG-ID: DBBsJuyXNEG1drEAlnuqmg_1779110859
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B8831956052
 for <dev@dpdk.org>; Mon, 18 May 2026 13:27:39 +0000 (UTC)
Received: from ringo.home (unknown [10.44.34.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 188D419560A2; Mon, 18 May 2026 13:27:37 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org
Subject: [PATCH dpdk v5 4/5] net: parse L3 protocol after MPLS labels
Date: Mon, 18 May 2026 15:27:18 +0200
Message-ID: <20260518132712.70913-12-rjarry@redhat.com>
In-Reply-To: <20260518132712.70913-8-rjarry@redhat.com>
References: <20260422102814.645299-2-rjarry@redhat.com>
 <20260518132712.70913-8-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tdGz_b0u6z_tcDt_Quf_RQIVZG5jlbxlMVpldKN0AN0_1779110859
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

rte_net_get_ptype stops at the MPLS layer and never identifies the L3
protocol of the payload. Also, the label parsing uses a fixed maximum of
5 headers instead of checking the bottom of stack bit.

Use the bottom of stack bit to consume all labels and inspect the first
nibble of the payload to determine if it is IPv4 or IPv6.

Add test cases to verify this works. Ensure that an unknown protocol
after MPLS (e.g. ARP) does not produce a bogus L3 type.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 app/test/test_net_ptype.c | 57 +++++++++++++++++++++++++++++++++++++++
 lib/net/rte_net.c         | 34 ++++++++++++++++-------
 2 files changed, 81 insertions(+), 10 deletions(-)

diff --git a/app/test/test_net_ptype.c b/app/test/test_net_ptype.c
index bfe85da13543..cc7026077191 100644
--- a/app/test/test_net_ptype.c
+++ b/app/test/test_net_ptype.c
@@ -118,6 +118,51 @@ static const uint8_t pkt_vlan_vlan_ipv4_udp[] = {
 	0x89, 0x6f, 0x78,
 };
 
+/* Ether(type=MPLS)/MPLS(label=42,s=1)/IP()/UDP()/Raw('x') */
+static const uint8_t pkt_mpls_ipv4_udp[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x88, 0x47, 0x00, 0x02,
+	0xa1, 0x40, 0x45, 0x00, 0x00, 0x1d, 0x00, 0x01,
+	0x00, 0x00, 0x40, 0x11, 0x7c, 0xcd, 0x7f, 0x00,
+	0x00, 0x01, 0x7f, 0x00, 0x00, 0x01, 0x00, 0x35,
+	0x00, 0x35, 0x00, 0x09, 0x89, 0x6f, 0x78,
+};
+
+/* Ether(type=MPLS)/MPLS(label=42,s=0)/MPLS(label=43,s=1)/IPv6()/TCP() */
+static const uint8_t pkt_mpls2_ipv6_tcp[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x88, 0x47, 0x00, 0x02,
+	0xa0, 0x40, 0x00, 0x02, 0xb1, 0x40, 0x60, 0x00,
+	0x00, 0x00, 0x00, 0x14, 0x06, 0x40, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x14,
+	0x00, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x50, 0x02, 0x20, 0x00, 0x8f, 0x7d,
+	0x00, 0x00,
+};
+
+/* Ether(type=MPLSM)/MPLS(label=42,s=1)/IP()/UDP()/Raw('x') */
+static const uint8_t pkt_mplsm_ipv4_udp[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x88, 0x48, 0x00, 0x02,
+	0xa1, 0x40, 0x45, 0x00, 0x00, 0x1d, 0x00, 0x01,
+	0x00, 0x00, 0x40, 0x11, 0x7c, 0xcd, 0x7f, 0x00,
+	0x00, 0x01, 0x7f, 0x00, 0x00, 0x01, 0x00, 0x35,
+	0x00, 0x35, 0x00, 0x09, 0x89, 0x6f, 0x78,
+};
+
+/* Ether(type=MPLS)/MPLS(label=42,s=1)/ARP() -- unknown L3 after MPLS */
+static const uint8_t pkt_mpls_arp[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x88, 0x47, 0x00, 0x02,
+	0xa1, 0x40, 0x00, 0x01, 0x08, 0x00, 0x06, 0x04,
+	0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x7f, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x7f, 0x00, 0x00, 0x02,
+};
+
 /* Ether()/Dot1AD(vlan=42)/Dot1Q(vlan=43)/IPv6()/TCP() */
 static const uint8_t pkt_qinq_ipv6_tcp[] = {
 	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
@@ -222,6 +267,18 @@ test_net_ptype(void)
 	ret |= test_case(pool, pkt_qinq_ipv6_tcp,
 			 RTE_PTYPE_L2_ETHER_QINQ | RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L4_TCP,
 			 22, 40, 20);
+	ret |= test_case(pool, pkt_mpls_ipv4_udp,
+			 RTE_PTYPE_L2_ETHER_MPLS | RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_UDP,
+			 18, 20, 8);
+	ret |= test_case(pool, pkt_mpls2_ipv6_tcp,
+			 RTE_PTYPE_L2_ETHER_MPLS | RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L4_TCP,
+			 22, 40, 20);
+	ret |= test_case(pool, pkt_mplsm_ipv4_udp,
+			 RTE_PTYPE_L2_ETHER_MPLS | RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_UDP,
+			 18, 20, 8);
+	ret |= test_case(pool, pkt_mpls_arp,
+			 RTE_PTYPE_L2_ETHER_MPLS,
+			 18, 0, 0);
 
 	rte_mempool_free(pool);
 
diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index d3cded961fb5..3bb5fbc16d43 100644
--- a/lib/net/rte_net.c
+++ b/lib/net/rte_net.c
@@ -371,22 +371,36 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
 
 	} else if ((proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLS)) ||
 		(proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLSM))) {
-		unsigned int i;
 		const struct rte_mpls_hdr *mh;
 		struct rte_mpls_hdr mh_copy;
+		const uint8_t *nimble;
+		uint8_t nimble_copy;
 
-#define MAX_MPLS_HDR 5
-		for (i = 0; i < MAX_MPLS_HDR; i++) {
-			mh = rte_pktmbuf_read(m, off + (i * sizeof(*mh)),
-				sizeof(*mh), &mh_copy);
+		pkt_type = RTE_PTYPE_L2_ETHER_MPLS;
+
+		/* consume all labels until bottom of stack is reached */
+		do {
+			mh = rte_pktmbuf_read(m, off, sizeof(*mh), &mh_copy);
 			if (unlikely(mh == NULL))
 				return pkt_type;
-		}
-		if (i == MAX_MPLS_HDR)
+			off += sizeof(*mh);
+			hdr_lens->l2_len += sizeof(*mh);
+		} while (!mh->bs);
+
+		/* try to guess what is the payload based on the first 4 bits */
+		nimble = rte_pktmbuf_read(m, off, sizeof(*nimble), &nimble_copy);
+		if (nimble == NULL)
 			return pkt_type;
-		pkt_type = RTE_PTYPE_L2_ETHER_MPLS;
-		hdr_lens->l2_len += (sizeof(*mh) * i);
-		return pkt_type;
+		switch (*nimble & 0xf0) {
+		case 0x40:
+			proto = RTE_BE16(RTE_ETHER_TYPE_IPV4);
+			break;
+		case 0x60:
+			proto = RTE_BE16(RTE_ETHER_TYPE_IPV6);
+			break;
+		default:
+			return pkt_type;
+		}
 	}
 
 l3:
-- 
2.54.0

