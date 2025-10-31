Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53EDCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 13:12:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7672D402DB;
	Fri, 31 Oct 2025 14:12:12 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0CAFF40150
 for <dev@dpdk.org>; Fri, 31 Oct 2025 14:12:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761916330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=G9VMPOzXvVJHG3o39mQwH+3IXnU5+5m6VYO+e6qSd3w=;
 b=IDsbuioWUmO+Fh7gKfwdgxlR/6mQ/DgG6U03isMWvaAZzZGWBlVGAtXadxWbWNckdGlvBV
 0K0ah9/K+1a04VmEsY9uALhMuoQcliCp8rEwk/Eo16bNU7/WJp3VgZKiLdq9TZWLiFzrqU
 LAF1eh/K575SB6ztf607Ikxek1D/fsE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-vuo8k7kbNZ2sjgv32yQkNQ-1; Fri,
 31 Oct 2025 09:12:06 -0400
X-MC-Unique: vuo8k7kbNZ2sjgv32yQkNQ-1
X-Mimecast-MFC-AGG-ID: vuo8k7kbNZ2sjgv32yQkNQ_1761916325
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B91718001E9; Fri, 31 Oct 2025 13:12:05 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.16])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EFE77180057E; Fri, 31 Oct 2025 13:12:03 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH] mbuf: dump Tx offload metadata
Date: Fri, 31 Oct 2025 14:11:59 +0100
Message-ID: <20251031131159.1199221-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EQ9bC8q945L2jziaf-vgDze5qutf73Gp7NspPhRJCc4_1761916325
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

When debugging TSO and other checksum offloads, dumping the various
l*_len fields and TSO segmentation size can be helpful.

Example in OVS that dumps a mbuf on rte_eth_tx_prepare failure:

Before:
netdev_dpdk(pmd-c30/id:11)|DBG|dpdk0: First invalid packet:
dump mbuf at 0x2201a916c0, iova=0x2200800580, buf_len=6864
  pkt_len=6804, ol_flags=0x3114800000000102, nb_segs=1, port=65535, ptype=0
  segment at 0x2201a916c0, data=0x22008005b2, len=6804, off=50, refcnt=1
  Dump data at [0x22008005b2], len=6804
...

After:
netdev_dpdk(pmd-c30/id:11)|DBG|dpdk0: First invalid packet:
dump mbuf at 0x2201a916c0, iova=0x2200800580, buf_len=6864, pkt_len=6804
  outer_l2_len=14, outer_l3_len=40, l2_len=38, l3_len=40, l4_len=32, tso_segsz=0
  ol_flags=0x3114800000000102, nb_segs=1, port=65535, ptype=0
  segment at 0x2201a916c0, data=0x22008005b2, len=6804, off=50, refcnt=1
  Dump data at [0x22008005b2], len=6804
...

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/mbuf/rte_mbuf.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
index 0d931c7a15..74dcb6c934 100644
--- a/lib/mbuf/rte_mbuf.c
+++ b/lib/mbuf/rte_mbuf.c
@@ -750,10 +750,12 @@ rte_pktmbuf_dump(FILE *f, const struct rte_mbuf *m, unsigned dump_len)
 
 	__rte_mbuf_sanity_check(m, 1);
 
-	fprintf(f, "dump mbuf at %p, iova=%#" PRIx64 ", buf_len=%u\n", m, rte_mbuf_iova_get(m),
-		m->buf_len);
-	fprintf(f, "  pkt_len=%u, ol_flags=%#"PRIx64", nb_segs=%u, port=%u",
-		m->pkt_len, m->ol_flags, m->nb_segs, m->port);
+	fprintf(f, "dump mbuf at %p, iova=%#" PRIx64 ", buf_len=%u, pkt_len=%u\n",
+		m, rte_mbuf_iova_get(m), m->buf_len, m->pkt_len);
+	fprintf(f, "  outer_l2_len=%u, outer_l3_len=%u, l2_len=%u, l3_len=%u, l4_len=%u, tso_segsz=%u\n",
+		m->outer_l2_len, m->outer_l3_len, m->l2_len, m->l3_len, m->l4_len, m->tso_segsz);
+	fprintf(f, "  ol_flags=%#"PRIx64", nb_segs=%u, port=%u",
+		m->ol_flags, m->nb_segs, m->port);
 
 	if (m->ol_flags & (RTE_MBUF_F_RX_QINQ | RTE_MBUF_F_TX_QINQ))
 		fprintf(f, ", vlan_tci_outer=%u", m->vlan_tci_outer);
-- 
2.51.0

