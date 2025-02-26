Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B456DC021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 13:42:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A70674029F;
	Wed, 26 Feb 2025 14:42:22 +0100 (CET)
Received: from aer-iport-1.cisco.com (aer-iport-1.cisco.com [173.38.203.51])
 by mails.dpdk.org (Postfix) with ESMTP id 44D8F4026C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 14:42:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=832; q=dns/txt;
 s=iport01; t=1740577341; x=1741786941;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=06AzLwoJQznzrQuFIYqOWCxbW2tQY2RfTbeyCvcsLyU=;
 b=VCneG4Dw2mO1SpQ3kxEea0AB1nFeaXJR1CGh90slvRLdXrxtq/2QMW1x
 oLjmS3iREte6TSv5m2sv92fx15WbaQN2zDqWgbO6rttOZAVYQSc3cOUkN
 k3So9qaef7lqxgz5xhAYoRi3/jnKmTDEHSWoLDAeaLGVZYkJC21I1AJJg
 hs38c+Ai/QF0azJ8AIuN/0sFEFgpLkxpoLt7GoQaOQIfGe3NXHa4aKw/c
 fqtDSblSgcTsgHSNJ+gws4wzC1cO1Id4MWmgH0LpKteara099SXZOf+fV
 tonF+thhMfSfbXBgyCBID9WI+pp3ix5EjcLnu5veSRtLmybZRwtIzoAFx Q==;
X-CSE-ConnectionGUID: XyR5uWqsSJ2Pows7f08BwQ==
X-CSE-MsgGUID: fX4MRQZbTwmn3v0z7ngrpg==
X-IPAS-Result: =?us-ascii?q?A0AnAADUGb9n/81K/pBaHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBgkqBT0NIjHKnaoElA1YPAQEBD0QEAQGFB4sTAiY0CQ4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4YIhl02AUaBUIMCgmUDr0yCL?=
 =?us-ascii?q?IEBhHzZOIFugUgBjUqFZycbgUlEgRWDaIEPhAGFdwSHW6gRSIEhA1ksAVUTD?=
 =?us-ascii?q?QoLBwWBcQM1DAsuFYFGeoJFaUk6Ag0CNYIefIIrhFSEQ4RBhVKCEYILiTKEI?=
 =?us-ascii?q?kADCxgNSBEsNxQbBj5uB6BAPIQ9gQ6CacZPMoNzoUgaM6pUAZh9pEqEZoFnP?=
 =?us-ascii?q?IFZcBWDIlIZD9x7RTI8AgcLAQEDCZFlAQE?=
IronPort-Data: A9a23:xXExI6iYfNt1oxjTORH0ssq4X161KhEKZh0ujC45NGQN5FlHY01je
 htvD27VaP2INDakfox/Pozj/U0Hu5XSxodrQFBs+HhnHixjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOCn9SQkvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZSEULOZ82QsaD9Msfjd8EkHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqUo69wqHF5X7
 sc6cggKcQvcibrm6q2CH7wEasQLdKEHPasWt2slyXTSCuwrBMifBa7L/tRfmjw3g6iiH96HO
 5ZfM2czKkucJUcXZz/7C7pm9Ausrn/ndzRepVa9rqss6G+Vxwt0uFToGIOEIIfRGp8N9qqej
 mz2o0HDOyMQCMOaz2GbqmDzgODVhSyuDer+E5X9rJaGmma7ymENIBEOWVj9puO24ma3XttZb
 UAZ9zJotqk0+0yDT9/hUhn+q3mB1iPwQPJZHvd/7ESGzbDZpl7FQGMFVTVGLtchsafaWAAX6
 7NApPuxbRQHjVFfYSv1Gmu8xd9qBRUoEA==
IronPort-HdrOrdr: A9a23:UzfJVqgLEASPW08bIJkwjmViMnBQXukji2hC6mlwRA09TyVXra
 yTdZMgpH3JYVkqNk3I9errBEDiewK+yXcW2+gs1N6ZNWGMhILCFu5fBOXZrgHIKmnX6vNd2a
 B8c6J3FdH8SWRhgd2S2njcLz9Z+rm6GGTCv5a485+rJjsaD51d0w==
X-Talos-CUID: 9a23:Rt+v6G9af2C0z00TGqqVv34FIJ04TWTG91WKG0inEjlnEO2/VmbFrQ==
X-Talos-MUID: 9a23:R3yNTAhyVt1qU6RcKNXu4cMpOvc0xp6XOkoxjpAA4NfcJ3N2NC2Fg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,317,1732579200"; d="scan'208";a="19233720"
Received: from aer-l-core-04.cisco.com ([144.254.74.205])
 by aer-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 26 Feb 2025 13:42:19 +0000
Received: from CSCO-W-PF51WMQ6.cisco.com (unknown [10.190.13.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: nplanel)
 by aer-l-core-04.cisco.com (Postfix) with ESMTPSA id D1115180001D5;
 Wed, 26 Feb 2025 13:42:18 +0000 (GMT)
From: Nicolas PLANEL <nplanel@cisco.com>
To: aman.deep.singh@intel.com
Cc: dev@dpdk.org
Subject: [PATCH] app/test-pmd: enable hw checksum offload for txonly
Date: Wed, 26 Feb 2025 14:41:47 +0100
Message-ID: <20250226134147.33487-1-nplanel@cisco.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: nplanel
X-Outbound-SMTP-Client: 10.190.13.29, [10.190.13.29]
X-Outbound-Node: aer-l-core-04.cisco.com
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

This patch fix txonly forward mode, as it was lacking of MBUF
offload flags for IPv4 and UDP when the hardware support it.

Signed-off-by: Nicolas PLANEL <nplanel@cisco.com>
---
 app/test-pmd/txonly.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/app/test-pmd/txonly.c b/app/test-pmd/txonly.c
index 59d821a22d6f..bdcf6ea66008 100644
--- a/app/test-pmd/txonly.c
+++ b/app/test-pmd/txonly.c
@@ -334,6 +334,10 @@ pkt_burst_transmit(struct fwd_stream *fs)
 		ol_flags |= RTE_MBUF_F_TX_QINQ;
 	if (tx_offloads & RTE_ETH_TX_OFFLOAD_MACSEC_INSERT)
 		ol_flags |= RTE_MBUF_F_TX_MACSEC;
+	if (tx_offloads & RTE_ETH_TX_OFFLOAD_IPV4_CKSUM)
+		ol_flags |= RTE_MBUF_F_TX_IP_CKSUM;
+	if (tx_offloads & RTE_ETH_TX_OFFLOAD_UDP_CKSUM)
+		ol_flags |= RTE_MBUF_F_TX_UDP_CKSUM;
 
 	/*
 	 * Initialize Ethernet header.
-- 
2.43.0

