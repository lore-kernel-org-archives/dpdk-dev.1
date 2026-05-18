Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FEACD4F50
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 13:28:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3620B40674;
	Mon, 18 May 2026 15:27:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A587740664
 for <dev@dpdk.org>; Mon, 18 May 2026 15:27:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779110863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cOhAMgTpDoJD3gjiih76cfHQbD39hl5cX5tzYQtJHzw=;
 b=FoK9Im9xA2stxn3EQT3FAdMeZOLwTf+pnuawMHPqJTHFhHDov/7qpT9I6NcYYUL/gJKR/5
 NBFLhs5nMFbN1uANG9sybjVumqZEbLeKuTzlzZNcKsrOlcFPhspL9jxpxuAFa+N1FQ7Hhr
 a/kwM8VBTavNokC2OZDjTYuSR7XZaC4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-iOIidI2kOeKV2eVMamAcCQ-1; Mon,
 18 May 2026 09:27:41 -0400
X-MC-Unique: iOIidI2kOeKV2eVMamAcCQ-1
X-Mimecast-MFC-AGG-ID: iOIidI2kOeKV2eVMamAcCQ_1779110860
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1FE01956054
 for <dev@dpdk.org>; Mon, 18 May 2026 13:27:40 +0000 (UTC)
Received: from ringo.home (unknown [10.44.34.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A69619560B0; Mon, 18 May 2026 13:27:39 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org
Subject: [PATCH dpdk v5 5/5] net: add truncated packet tests for
 rte_net_get_ptype
Date: Mon, 18 May 2026 15:27:19 +0200
Message-ID: <20260518132712.70913-13-rjarry@redhat.com>
In-Reply-To: <20260518132712.70913-8-rjarry@redhat.com>
References: <20260422102814.645299-2-rjarry@redhat.com>
 <20260518132712.70913-8-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7Eu0esbjEZgKb8ydqN13NOzEhDPTfTBE8Qq8wvePNGE_1779110860
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

Ensure rte_net_get_ptype handles truncated packets gracefully by
stopping at the last layer it can fully parse.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 app/test/test_net_ptype.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/app/test/test_net_ptype.c b/app/test/test_net_ptype.c
index cc7026077191..332ace5dd929 100644
--- a/app/test/test_net_ptype.c
+++ b/app/test/test_net_ptype.c
@@ -163,6 +163,32 @@ static const uint8_t pkt_mpls_arp[] = {
 	0x00, 0x00, 0x7f, 0x00, 0x00, 0x02,
 };
 
+/* Ether()/Dot1Q() -- VLAN header truncated */
+static const uint8_t pkt_vlan_trunc[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x81, 0x00, 0x00, 0x2a,
+};
+
+/* Ether(type=MPLS) -- MPLS header truncated */
+static const uint8_t pkt_mpls_trunc[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x88, 0x47, 0x00, 0x02,
+};
+
+/* Ether(type=MPLS)/MPLS(label=42,s=1) -- no payload after label */
+static const uint8_t pkt_mpls_no_payload[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x88, 0x47, 0x00, 0x02,
+	0xa1, 0x40,
+};
+
+/* Ether()/IP() -- IPv4 header truncated */
+static const uint8_t pkt_ipv4_trunc[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x45, 0x00,
+	0x00, 0x1d, 0x00, 0x01, 0x00, 0x00, 0x40, 0x11,
+};
+
 /* Ether()/Dot1AD(vlan=42)/Dot1Q(vlan=43)/IPv6()/TCP() */
 static const uint8_t pkt_qinq_ipv6_tcp[] = {
 	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
@@ -279,6 +305,18 @@ test_net_ptype(void)
 	ret |= test_case(pool, pkt_mpls_arp,
 			 RTE_PTYPE_L2_ETHER_MPLS,
 			 18, 0, 0);
+	ret |= test_case(pool, pkt_vlan_trunc,
+			 RTE_PTYPE_L2_ETHER_VLAN,
+			 14, 0, 0);
+	ret |= test_case(pool, pkt_mpls_trunc,
+			 RTE_PTYPE_L2_ETHER_MPLS,
+			 14, 0, 0);
+	ret |= test_case(pool, pkt_mpls_no_payload,
+			 RTE_PTYPE_L2_ETHER_MPLS,
+			 18, 0, 0);
+	ret |= test_case(pool, pkt_ipv4_trunc,
+			 RTE_PTYPE_L2_ETHER,
+			 14, 0, 0);
 
 	rte_mempool_free(pool);
 
-- 
2.54.0

