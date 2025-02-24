Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC00EC021BB
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 14:47:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CC24410D5;
	Mon, 24 Feb 2025 15:47:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2F29940DDD
 for <dev@dpdk.org>; Mon, 24 Feb 2025 15:47:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740408461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GwKsrof4QhQUNs8/4srMWb8AvcpAdvoIMY3wAqxb2Hs=;
 b=G6zQKI6+IAM5nIGoBWgJw0qwl+hcsD+YVsJliZWqqjk+ncP2xEKxgfwIoCuXXhZh4eNfjO
 cix9zY8amOs/yfu/rEnB44+7/t9PQK/bk4+kAsRbglV7UMwrqchgffU1xwX/UlS5I34xl/
 zmEobLJtoqio4J187XOsFlTixkYA58Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-urffHBp9NuSTaQQWh_tCLw-1; Mon,
 24 Feb 2025 09:47:37 -0500
X-MC-Unique: urffHBp9NuSTaQQWh_tCLw-1
X-Mimecast-MFC-AGG-ID: urffHBp9NuSTaQQWh_tCLw_1740408456
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 906711800983; Mon, 24 Feb 2025 14:47:36 +0000 (UTC)
Received: from ringo.home (unknown [10.45.224.207])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 66A3E19560AA; Mon, 24 Feb 2025 14:47:33 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: stable@dpdk.org,
	Junxiao Shi <sunnylandh@gmail.com>
Subject: [PATCH dpdk] net: fix IPv4 compat and mapped checks
Date: Mon, 24 Feb 2025 15:47:26 +0100
Message-ID: <20250224144725.271975-2-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0HkOITQenQrWJSU8H4A9OMqtmfynX7bjcIG1YHkyCZ8_1740408456
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

The RFC states that the first 96 bits should be compared, not the first
32 bits.

Add unit tests to ensure this works.

Cc: stable@dpdk.org
Fixes: 3d6d85f58c1c ("net: add utilities for well known IPv6 address types")
Reported-by: Junxiao Shi <sunnylandh@gmail.com>
Closes: https://bugs.dpdk.org/show_bug.cgi?id=1664
Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 app/test/test_net_ip6.c | 26 ++++++++++++++++++++++++++
 lib/net/rte_ip6.h       |  4 ++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/app/test/test_net_ip6.c b/app/test/test_net_ip6.c
index 9cc10b1f714f..cfc550940306 100644
--- a/app/test/test_net_ip6.c
+++ b/app/test/test_net_ip6.c
@@ -99,6 +99,8 @@ test_ipv6_addr_kind(void)
 	TEST_ASSERT(!rte_ipv6_addr_is_linklocal(&zero_addr), "");
 	TEST_ASSERT(!rte_ipv6_addr_is_loopback(&zero_addr), "");
 	TEST_ASSERT(!rte_ipv6_addr_is_mcast(&zero_addr), "");
+	TEST_ASSERT(rte_ipv6_addr_is_v4compat(&zero_addr), "");
+	TEST_ASSERT(!rte_ipv6_addr_is_v4mapped(&zero_addr), "");
 
 	const struct rte_ipv6_addr ucast =
 		RTE_IPV6(0x2a01, 0xcb00, 0x0254, 0x3300, 0x6239, 0xe1f4, 0x7a0b, 0x2371);
@@ -106,18 +108,24 @@ test_ipv6_addr_kind(void)
 	TEST_ASSERT(!rte_ipv6_addr_is_linklocal(&ucast), "");
 	TEST_ASSERT(!rte_ipv6_addr_is_loopback(&ucast), "");
 	TEST_ASSERT(!rte_ipv6_addr_is_mcast(&ucast), "");
+	TEST_ASSERT(!rte_ipv6_addr_is_v4compat(&ucast), "");
+	TEST_ASSERT(!rte_ipv6_addr_is_v4mapped(&ucast), "");
 
 	const struct rte_ipv6_addr mcast = RTE_IPV6(0xff01, 0, 0, 0, 0, 0, 0, 1);
 	TEST_ASSERT(!rte_ipv6_addr_is_unspec(&mcast), "");
 	TEST_ASSERT(!rte_ipv6_addr_is_linklocal(&mcast), "");
 	TEST_ASSERT(!rte_ipv6_addr_is_loopback(&mcast), "");
 	TEST_ASSERT(rte_ipv6_addr_is_mcast(&mcast), "");
+	TEST_ASSERT(!rte_ipv6_addr_is_v4compat(&mcast), "");
+	TEST_ASSERT(!rte_ipv6_addr_is_v4mapped(&mcast), "");
 
 	const struct rte_ipv6_addr lo = RTE_IPV6_ADDR_LOOPBACK;
 	TEST_ASSERT(!rte_ipv6_addr_is_unspec(&lo), "");
 	TEST_ASSERT(!rte_ipv6_addr_is_linklocal(&lo), "");
 	TEST_ASSERT(rte_ipv6_addr_is_loopback(&lo), "");
 	TEST_ASSERT(!rte_ipv6_addr_is_mcast(&lo), "");
+	TEST_ASSERT(!rte_ipv6_addr_is_v4compat(&lo), "");
+	TEST_ASSERT(!rte_ipv6_addr_is_v4mapped(&lo), "");
 
 	const struct rte_ipv6_addr local =
 		RTE_IPV6(0xfe80, 0, 0, 0, 0x5a84, 0xc52c, 0x6aef, 0x4639);
@@ -125,6 +133,24 @@ test_ipv6_addr_kind(void)
 	TEST_ASSERT(rte_ipv6_addr_is_linklocal(&local), "");
 	TEST_ASSERT(!rte_ipv6_addr_is_loopback(&local), "");
 	TEST_ASSERT(!rte_ipv6_addr_is_mcast(&local), "");
+	TEST_ASSERT(!rte_ipv6_addr_is_v4compat(&local), "");
+	TEST_ASSERT(!rte_ipv6_addr_is_v4mapped(&local), "");
+
+	const struct rte_ipv6_addr v4compat = RTE_IPV6(0, 0, 0, 0, 0, 0, 0xc0a8, 0x0001);
+	TEST_ASSERT(!rte_ipv6_addr_is_unspec(&v4compat), "");
+	TEST_ASSERT(!rte_ipv6_addr_is_linklocal(&v4compat), "");
+	TEST_ASSERT(!rte_ipv6_addr_is_loopback(&v4compat), "");
+	TEST_ASSERT(!rte_ipv6_addr_is_mcast(&v4compat), "");
+	TEST_ASSERT(rte_ipv6_addr_is_v4compat(&v4compat), "");
+	TEST_ASSERT(!rte_ipv6_addr_is_v4mapped(&v4compat), "");
+
+	const struct rte_ipv6_addr v4mapped = RTE_IPV6(0, 0, 0, 0, 0, 0xffff, 0xc0a8, 0x0001);
+	TEST_ASSERT(!rte_ipv6_addr_is_unspec(&v4mapped), "");
+	TEST_ASSERT(!rte_ipv6_addr_is_linklocal(&v4mapped), "");
+	TEST_ASSERT(!rte_ipv6_addr_is_loopback(&v4mapped), "");
+	TEST_ASSERT(!rte_ipv6_addr_is_mcast(&v4mapped), "");
+	TEST_ASSERT(!rte_ipv6_addr_is_v4compat(&v4mapped), "");
+	TEST_ASSERT(rte_ipv6_addr_is_v4mapped(&v4mapped), "");
 
 	return TEST_SUCCESS;
 }
diff --git a/lib/net/rte_ip6.h b/lib/net/rte_ip6.h
index 92558a124a00..98bcac3f4dff 100644
--- a/lib/net/rte_ip6.h
+++ b/lib/net/rte_ip6.h
@@ -307,7 +307,7 @@ static inline bool
 rte_ipv6_addr_is_v4compat(const struct rte_ipv6_addr *ip)
 {
 	const struct rte_ipv6_addr unspec = RTE_IPV6_ADDR_UNSPEC;
-	return rte_ipv6_addr_eq_prefix(ip, &unspec, 32) && !rte_ipv6_addr_is_loopback(ip);
+	return rte_ipv6_addr_eq_prefix(ip, &unspec, 96) && !rte_ipv6_addr_is_loopback(ip);
 }
 
 #define RTE_IPV6_ADDR_PREFIX_V4MAPPED RTE_IPV6(0, 0, 0, 0, 0, 0xffff, 0, 0)
@@ -325,7 +325,7 @@ static inline bool
 rte_ipv6_addr_is_v4mapped(const struct rte_ipv6_addr *ip)
 {
 	const struct rte_ipv6_addr prefix = RTE_IPV6_ADDR_PREFIX_V4MAPPED;
-	return rte_ipv6_addr_eq_prefix(ip, &prefix, 32);
+	return rte_ipv6_addr_eq_prefix(ip, &prefix, 96);
 }
 
 /**
-- 
2.48.1

