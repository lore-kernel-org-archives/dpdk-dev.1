Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF822CD4F50
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 13:27:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C64DB4065E;
	Mon, 18 May 2026 15:27:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id AC435402D9
 for <dev@dpdk.org>; Mon, 18 May 2026 15:27:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779110860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qo7/H6bfywxDLGy2ZkeuMnqhJcy85Cs/atHuHrUe2dQ=;
 b=iI53s5MCgAgyhd7nqXGfSdbHLI7rN+SfjZguxdhxYjShLLaFwzs7YXwNTq3RYnPIegPdgS
 yC4tWlzeeazyfohQICXbp6m95UKpoBxRnI9eSCJQMLV8tUuRXpn1QrLCGltSbio2m+h869
 OoNElyHeJtFWIV0AcCwPjTuIiekC4o0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-FmPKal1wPKqht10CdnU03w-1; Mon,
 18 May 2026 09:27:35 -0400
X-MC-Unique: FmPKal1wPKqht10CdnU03w-1
X-Mimecast-MFC-AGG-ID: FmPKal1wPKqht10CdnU03w_1779110854
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F02B718005BB; Mon, 18 May 2026 13:27:33 +0000 (UTC)
Received: from ringo.home (unknown [10.44.34.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7ADD619560A2; Mon, 18 May 2026 13:27:32 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org,
	Gregory Etelson <getelson@nvidia.com>
Cc: stable@dpdk.org
Subject: [PATCH dpdk v5 1/5] Revert "net: fix packet type for stacked VLAN"
Date: Mon, 18 May 2026 15:27:15 +0200
Message-ID: <20260518132712.70913-9-rjarry@redhat.com>
In-Reply-To: <20260518132712.70913-8-rjarry@redhat.com>
References: <20260422102814.645299-2-rjarry@redhat.com>
 <20260518132712.70913-8-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z3MFvjUJWOUgx7vnKNBRa0D5FabreEUmubxUT6bU8TI_1779110854
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

This reverts commit 1f250674085aeb4ffd15ac2519a68efc04faf7ac.

rte_net_get_ptype() now uses |= to set the L2 ptype inside the VLAN
parsing loop. Since pkt_type is already initialized with
RTE_PTYPE_L2_ETHER (0x1), or-ing it with RTE_PTYPE_L2_ETHER_VLAN (0x6)
results in RTE_PTYPE_L2_ETHER_QINQ (0x7). This causes single VLAN frames
to be misidentified as QinQ.

This was detected while testing DPDK 25.11.1 in grout. The net/tap
driver calls rte_net_get_ptype() in tap_verify_csum() to determine the
L2 header length. With the wrong ptype, l2_len is set to 22 (ether
+ QinQ = 14 + 8) instead of 18 (ether + VLAN = 14 + 4), shifting the IP
header pointer by 4 bytes. The checksum is then computed on garbage
data, causing valid packets to be dropped.

Bugzilla ID: 1941
Fixes: 1f250674085a ("net: fix packet type for stacked VLAN")
Cc: stable@dpdk.org
Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 lib/net/rte_net.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index 458b4814a9c9..c70b57fdc0f8 100644
--- a/lib/net/rte_net.c
+++ b/lib/net/rte_net.c
@@ -320,9 +320,6 @@ rte_net_skip_ip6_ext(uint16_t proto, const struct rte_mbuf *m, uint32_t *off,
 	return -1;
 }
 
-/* limit number of supported VLAN headers */
-#define RTE_NET_VLAN_MAX_DEPTH 8
-
 /* parse mbuf data to get packet type */
 RTE_EXPORT_SYMBOL(rte_net_get_ptype)
 uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
@@ -332,7 +329,7 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
 	const struct rte_ether_hdr *eh;
 	struct rte_ether_hdr eh_copy;
 	uint32_t pkt_type = RTE_PTYPE_L2_ETHER;
-	uint32_t off = 0, vlan_depth = 0;
+	uint32_t off = 0;
 	uint16_t proto;
 	int ret;
 
@@ -352,26 +349,30 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
 	if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4))
 		goto l3; /* fast path if packet is IPv4 */
 
-	while (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ||
-	       proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) {
+	if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN)) {
 		const struct rte_vlan_hdr *vh;
 		struct rte_vlan_hdr vh_copy;
 
-		if (++vlan_depth > RTE_NET_VLAN_MAX_DEPTH)
-			return 0;
-		pkt_type |=
-			proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ?
-				 RTE_PTYPE_L2_ETHER_VLAN :
-				 RTE_PTYPE_L2_ETHER_QINQ;
+		pkt_type = RTE_PTYPE_L2_ETHER_VLAN;
 		vh = rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
 		if (unlikely(vh == NULL))
 			return pkt_type;
 		off += sizeof(*vh);
 		hdr_lens->l2_len += sizeof(*vh);
 		proto = vh->eth_proto;
-	}
+	} else if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) {
+		const struct rte_vlan_hdr *vh;
+		struct rte_vlan_hdr vh_copy;
 
-	if ((proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLS)) ||
+		pkt_type = RTE_PTYPE_L2_ETHER_QINQ;
+		vh = rte_pktmbuf_read(m, off + sizeof(*vh), sizeof(*vh),
+			&vh_copy);
+		if (unlikely(vh == NULL))
+			return pkt_type;
+		off += 2 * sizeof(*vh);
+		hdr_lens->l2_len += 2 * sizeof(*vh);
+		proto = vh->eth_proto;
+	} else if ((proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLS)) ||
 		(proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLSM))) {
 		unsigned int i;
 		const struct rte_mpls_hdr *mh;
-- 
2.54.0

