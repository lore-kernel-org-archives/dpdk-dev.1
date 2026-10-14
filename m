Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9962ACC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:02:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A21CE40DF6;
	Wed, 14 Oct 2026 17:01:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5874540DD8
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:01:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791990080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EmQLgjwZpD+W+XZAoT48KjwzvUzuilzeb3lD3l4FT5g=;
 b=Vm5EizyvbpW8io07pHlJHsARdPJhrf3vdsG1hGI4SSNcjL+H5LbgI1+0amnYvh3zLbcFZS
 ABbNg147mCXdyIlxWlG5Svxl+lHpeImwS1M7s6pBFIiHkHWmlrBujU9jB39xZh6mnOsLUU
 QZepLf938+9N8lAzbvW3Y0flfQNOQZI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-Q3bv-7P5MoquuRhBcmF7gg-1; Wed,
 14 Oct 2026 15:01:15 +0000
X-MC-Unique: Q3bv-7P5MoquuRhBcmF7gg-1
X-Mimecast-MFC-AGG-ID: Q3bv-7P5MoquuRhBcmF7gg_1791990074
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 532A7180075A; Wed, 14 Oct 2026 15:01:14 +0000 (UTC)
Received: from max-p1.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0EE211800495; Wed, 14 Oct 2026 15:01:12 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Alexandru-Ionut Jipa <jipaionut@gmail.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH 14/14] gso: fix overflow when writing to very small buffers
Date: Wed, 14 Oct 2026 17:00:49 +0200
Message-ID: <20261014150049.2540538-14-maxime.coquelin@redhat.com>
In-Reply-To: <20261014150049.2540538-1-maxime.coquelin@redhat.com>
References: <20261014150049.2540538-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9OzYR3AarJiwssvT75IB7dhKn_Fd1HujYOjCLmYGiVw_1791990074
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

From: Bruce Richardson <bruce.richardson@intel.com>

The gso library never checks that the buffers used for the packet
headers are actually big enough to handle those headers, leading to a
memcpy overflow if the allocated mbuf size is too small. Add some
appropriate checks.

CVE-2026-100236
Bugzilla ID: 2047

Fixes: 119583797b6a ("gso: support TCP/IPv4 GSO")
Cc: stable@dpdk.org

Reported-by: Alexandru-Ionut Jipa <jipaionut@gmail.com>
Acked-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 .mailmap                  |  1 +
 lib/gso/gso_common.c      | 12 ++++++++++++
 lib/gso/gso_tcp4.c        |  5 ++---
 lib/gso/gso_tunnel_tcp4.c |  6 +++---
 lib/gso/gso_tunnel_udp4.c |  4 ++--
 lib/gso/gso_udp4.c        |  5 ++---
 6 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/.mailmap b/.mailmap
index 2e348c3bce..38d89d9e87 100644
--- a/.mailmap
+++ b/.mailmap
@@ -71,6 +71,7 @@ Alexander Skorichenko <askorichenko@netgate.com>
 Alexander Solganik <solganik@gmail.com>
 Alexander V Gutkin <alexander.v.gutkin@intel.com>
 Alexandre Ferrieux <alexandre.ferrieux@orange.com>
+Alexandru-Ionut Jipa <jipaionut@gmail.com>
 Alexey Kardashevskiy <aik@ozlabs.ru>
 Alexey Simakov <bigalex934@gmail.com>
 Alfredo Cardigliano <cardigliano@ntop.org>
diff --git a/lib/gso/gso_common.c b/lib/gso/gso_common.c
index 378bf2c6aa..481c3b3beb 100644
--- a/lib/gso/gso_common.c
+++ b/lib/gso/gso_common.c
@@ -50,8 +50,20 @@ gso_do_segment(struct rte_mbuf *pkt,
 	struct rte_mbuf *hdr_segment, *pyld_segment, *prev_segment;
 	uint16_t pkt_in_data_pos, segment_bytes_remaining;
 	uint16_t pyld_len, nb_segs;
+	uint16_t direct_buf_size, direct_tailroom;
 	bool more_in_pkt, more_out_segs;
 
+	/*
+	 * The header must be fully contained in pkt's first segment and must fit
+	 * in a freshly allocated direct_pool mbuf.
+	 */
+	direct_buf_size = rte_pktmbuf_data_room_size(direct_pool);
+	if (unlikely(direct_buf_size <= (uint16_t)RTE_PKTMBUF_HEADROOM))
+		return -EINVAL;
+	direct_tailroom = direct_buf_size - RTE_PKTMBUF_HEADROOM;
+	if (unlikely(pkt_hdr_offset > pkt->data_len || pkt_hdr_offset > direct_tailroom))
+		return -EINVAL;
+
 	pkt_in = pkt;
 	nb_segs = 0;
 	more_in_pkt = 1;
diff --git a/lib/gso/gso_tcp4.c b/lib/gso/gso_tcp4.c
index e2ae4aaf6c..d086106355 100644
--- a/lib/gso/gso_tcp4.c
+++ b/lib/gso/gso_tcp4.c
@@ -53,11 +53,10 @@ gso_tcp4_segment(struct rte_mbuf *pkt,
 		return 0;
 	}
 
-	/* Don't process the packet without data */
+	/* Don't process the packet without data or hdr larger than seg size */
 	hdr_offset = pkt->l2_len + pkt->l3_len + pkt->l4_len;
-	if (unlikely(hdr_offset >= pkt->pkt_len)) {
+	if (unlikely(hdr_offset >= pkt->pkt_len || hdr_offset >= gso_size))
 		return 0;
-	}
 
 	pyld_unit_size = gso_size - hdr_offset;
 
diff --git a/lib/gso/gso_tunnel_tcp4.c b/lib/gso/gso_tunnel_tcp4.c
index 3a9159774b..f0d1a6efd6 100644
--- a/lib/gso/gso_tunnel_tcp4.c
+++ b/lib/gso/gso_tunnel_tcp4.c
@@ -77,10 +77,10 @@ gso_tunnel_tcp4_segment(struct rte_mbuf *pkt,
 	}
 
 	hdr_offset += pkt->l3_len + pkt->l4_len;
-	/* Don't process the packet without data */
-	if (hdr_offset >= pkt->pkt_len) {
+	/* Don't process the packet without data or hdr larger than seg size */
+	if (hdr_offset >= pkt->pkt_len || hdr_offset >= gso_size)
 		return 0;
-	}
+
 	pyld_unit_size = gso_size - hdr_offset;
 
 	/* Segment the payload */
diff --git a/lib/gso/gso_tunnel_udp4.c b/lib/gso/gso_tunnel_udp4.c
index 4fb275484c..43e4103bc7 100644
--- a/lib/gso/gso_tunnel_udp4.c
+++ b/lib/gso/gso_tunnel_udp4.c
@@ -78,8 +78,8 @@ gso_tunnel_udp4_segment(struct rte_mbuf *pkt,
 		return 0;
 
 	hdr_offset += pkt->l3_len;
-	/* Don't process the packet without data */
-	if ((hdr_offset + pkt->l4_len) >= pkt->pkt_len)
+	/* Don't process the packet without data or hdrs larger than seg size */
+	if ((hdr_offset + pkt->l4_len) >= pkt->pkt_len || hdr_offset >= gso_size)
 		return 0;
 
 	/* pyld_unit_size must be a multiple of 8 because frag_off
diff --git a/lib/gso/gso_udp4.c b/lib/gso/gso_udp4.c
index 5d0186aa24..e2ec84759d 100644
--- a/lib/gso/gso_udp4.c
+++ b/lib/gso/gso_udp4.c
@@ -62,10 +62,9 @@ gso_udp4_segment(struct rte_mbuf *pkt,
 	 */
 	hdr_offset = pkt->l2_len + pkt->l3_len;
 
-	/* Don't process the packet without data. */
-	if (unlikely(hdr_offset + pkt->l4_len >= pkt->pkt_len)) {
+	/* Don't process the packet without data or header larger than seg size. */
+	if (unlikely(hdr_offset + pkt->l4_len >= pkt->pkt_len || hdr_offset >= gso_size))
 		return 0;
-	}
 
 	/* pyld_unit_size must be a multiple of 8 because frag_off
 	 * uses 8 bytes as unit.
-- 
2.56.0

