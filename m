Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E99CCD4F50
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 13:27:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EBF7402D9;
	Mon, 18 May 2026 15:27:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C5F934064F
 for <dev@dpdk.org>; Mon, 18 May 2026 15:27:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779110860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1y6PXdyyCLUtOo94VHi1ZJQijTMKBXzffRni5hH5+zM=;
 b=NMttFJx8ctKQMTNgj0e3WZYf8s3VI9Cr0XwN7YdxzhKKrL9xrhHccK+R8Iui0bEjLNf5qf
 FtsIkI6tKxGUD/ujETzHLg4VUa2I5pC1CCd+LQW8/l+uWSm1j+YY2JAj7yLvOdeFFZh1IF
 GEz2WQ2/UntDHjjabCd8X79NzUlI46g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-EIYriGVJMoyA6Hpk3Zs-IQ-1; Mon,
 18 May 2026 09:27:36 -0400
X-MC-Unique: EIYriGVJMoyA6Hpk3Zs-IQ-1
X-Mimecast-MFC-AGG-ID: EIYriGVJMoyA6Hpk3Zs-IQ_1779110856
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12AC718002C8
 for <dev@dpdk.org>; Mon, 18 May 2026 13:27:36 +0000 (UTC)
Received: from ringo.home (unknown [10.44.34.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 983BE19560A2; Mon, 18 May 2026 13:27:34 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org
Cc: David Marchand <david.marchand@redhat.com>
Subject: [PATCH dpdk v5 2/5] net: support multiple stacked VLAN tags
Date: Mon, 18 May 2026 15:27:16 +0200
Message-ID: <20260518132712.70913-10-rjarry@redhat.com>
In-Reply-To: <20260518132712.70913-8-rjarry@redhat.com>
References: <20260422102814.645299-2-rjarry@redhat.com>
 <20260518132712.70913-8-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I2CPsaHxM-EfAn92tzhNkp6EswLswSIVMlmHDenrNUo_1779110856
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

The VLAN and QinQ code paths in rte_net_get_ptype handle at most two
tags with duplicated logic. Replace them with a single loop that
consumes all consecutive VLAN/QinQ headers regardless of depth.

Bugzilla ID: 1941
Suggested-by: David Marchand <david.marchand@redhat.com>
Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 lib/net/rte_net.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index c70b57fdc0f8..d3cded961fb5 100644
--- a/lib/net/rte_net.c
+++ b/lib/net/rte_net.c
@@ -349,29 +349,26 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
 	if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4))
 		goto l3; /* fast path if packet is IPv4 */
 
-	if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN)) {
+	if ((proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN)) ||
+		(proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ))) {
 		const struct rte_vlan_hdr *vh;
 		struct rte_vlan_hdr vh_copy;
 
-		pkt_type = RTE_PTYPE_L2_ETHER_VLAN;
-		vh = rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
-		if (unlikely(vh == NULL))
-			return pkt_type;
-		off += sizeof(*vh);
-		hdr_lens->l2_len += sizeof(*vh);
-		proto = vh->eth_proto;
-	} else if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) {
-		const struct rte_vlan_hdr *vh;
-		struct rte_vlan_hdr vh_copy;
+		if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN))
+			pkt_type = RTE_PTYPE_L2_ETHER_VLAN;
+		else
+			pkt_type = RTE_PTYPE_L2_ETHER_QINQ;
+
+		do {
+			vh = rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
+			if (unlikely(vh == NULL))
+				return pkt_type;
+			off += sizeof(*vh);
+			hdr_lens->l2_len += sizeof(*vh);
+			proto = vh->eth_proto;
+		} while (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ||
+			proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ));
 
-		pkt_type = RTE_PTYPE_L2_ETHER_QINQ;
-		vh = rte_pktmbuf_read(m, off + sizeof(*vh), sizeof(*vh),
-			&vh_copy);
-		if (unlikely(vh == NULL))
-			return pkt_type;
-		off += 2 * sizeof(*vh);
-		hdr_lens->l2_len += 2 * sizeof(*vh);
-		proto = vh->eth_proto;
 	} else if ((proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLS)) ||
 		(proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLSM))) {
 		unsigned int i;
-- 
2.54.0

