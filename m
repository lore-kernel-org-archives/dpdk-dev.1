Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3572CCFA00
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 10:02:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C30DC4028C;
	Tue,  4 Nov 2025 11:02:28 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4B3CA40285
 for <dev@dpdk.org>; Tue,  4 Nov 2025 11:02:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762250546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bJXrnr6Ihur0vNZyrzT+IuDu0l0Y/gJqocvc99ShaqE=;
 b=CxfimoGw7c+mxPiUZGBElAKPTcSzyojyPgjYnPKdL0btbb1DK/Qcj4heRonYIjASwJsqZO
 +IX0iOZmwmm039kHh2gLZeURZUDU3WmRk3KHtDOk1W1G3N3Yar4/XGnB6qJkLT7HmER8Hs
 5gkbpPJypbGW54SRRGaymWVHR5GL4eE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-R_4ebf0SPhKLQhJPC15i6w-1; Tue,
 04 Nov 2025 05:02:23 -0500
X-MC-Unique: R_4ebf0SPhKLQhJPC15i6w-1
X-Mimecast-MFC-AGG-ID: R_4ebf0SPhKLQhJPC15i6w_1762250542
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C52F61954B08; Tue,  4 Nov 2025 10:02:22 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7A24119560A2; Tue,  4 Nov 2025 10:02:21 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v2] mbuf: dump Tx offload metadata
Date: Tue,  4 Nov 2025 11:02:14 +0100
Message-ID: <20251104100214.1818660-1-david.marchand@redhat.com>
In-Reply-To: <20251031131159.1199221-1-david.marchand@redhat.com>
References: <20251031131159.1199221-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y1wMx--C_5SnRP8xsSF48i88mhQ8AHT5l8eGE6cUTjk_1762250542
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
  outer_l2_len=14, outer_l3_len=40, l2_len=38, l3_len=40, l4_len=32
  ol_flags=0x3114800000000102, nb_segs=1, port=65535, ptype=0
  segment at 0x2201a916c0, data=0x22008005b2, len=6804, off=50, refcnt=1
  Dump data at [0x22008005b2], len=6804
...

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/mbuf/rte_mbuf.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
index 0d931c7a15..12710a59df 100644
--- a/lib/mbuf/rte_mbuf.c
+++ b/lib/mbuf/rte_mbuf.c
@@ -750,10 +750,43 @@ rte_pktmbuf_dump(FILE *f, const struct rte_mbuf *m, unsigned dump_len)
 
 	__rte_mbuf_sanity_check(m, 1);
 
-	fprintf(f, "dump mbuf at %p, iova=%#" PRIx64 ", buf_len=%u\n", m, rte_mbuf_iova_get(m),
-		m->buf_len);
-	fprintf(f, "  pkt_len=%u, ol_flags=%#"PRIx64", nb_segs=%u, port=%u",
-		m->pkt_len, m->ol_flags, m->nb_segs, m->port);
+	fprintf(f, "dump mbuf at %p, iova=%#" PRIx64 ", buf_len=%u, pkt_len=%u\n",
+		m, rte_mbuf_iova_get(m), m->buf_len, m->pkt_len);
+	if (m->ol_flags & RTE_MBUF_F_TX_OFFLOAD_MASK) {
+		const char *sep = "";
+
+		fprintf(f, "  ");
+		if (m->outer_l2_len != 0) {
+			fprintf(f, "%souter_l2_len=%u", sep, m->outer_l2_len);
+			sep = ", ";
+		}
+		if (m->outer_l3_len != 0) {
+			fprintf(f, "%souter_l3_len=%u", sep, m->outer_l3_len);
+			sep = ", ";
+		}
+		if (m->l2_len != 0) {
+			fprintf(f, "%sl2_len=%u", sep, m->l2_len);
+			sep = ", ";
+		}
+		if (m->l3_len != 0) {
+			fprintf(f, "%sl3_len=%u", sep, m->l3_len);
+			sep = ", ";
+		}
+		if (m->l4_len != 0) {
+			fprintf(f, "%sl4_len=%u", sep, m->l4_len);
+			sep = ", ";
+		}
+		if (m->tso_segsz != 0) {
+			fprintf(f, "%stso_segsz=%u", sep, m->tso_segsz);
+			sep = ", ";
+		}
+
+		if (sep[0] == '\0')
+			fprintf(f, "no tx offload length set");
+		fprintf(f, "\n");
+	}
+	fprintf(f, "  ol_flags=%#"PRIx64", nb_segs=%u, port=%u",
+		m->ol_flags, m->nb_segs, m->port);
 
 	if (m->ol_flags & (RTE_MBUF_F_RX_QINQ | RTE_MBUF_F_TX_QINQ))
 		fprintf(f, ", vlan_tci_outer=%u", m->vlan_tci_outer);
-- 
2.51.0

