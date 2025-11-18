Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08463CEE344
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 17:45:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC61A402C8;
	Tue, 18 Nov 2025 18:45:39 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 722714027D
 for <dev@dpdk.org>; Tue, 18 Nov 2025 18:45:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763487937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oHEgjEaYcQnrA934ff2swxWJuAz6bYzswm22JVlnPyU=;
 b=LcQnCGDcAX2taNwhxzM0Cc56z0Du+qKPICqrw06F7EpHcQHlJYhkRzH45M37F6+EHGI3GS
 vPSVakxCaLRvf0FTHZ0AVUC/F0X8YCuPti+E6tCN06bUHtMCI67IN9IuEchg38yaeVFxzK
 jwCq9CO8+LD3M7UDcwUd6OPh4OX5tHo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-EsCTlgeoOqel8HMvjZjDGw-1; Tue,
 18 Nov 2025 12:45:35 -0500
X-MC-Unique: EsCTlgeoOqel8HMvjZjDGw-1
X-Mimecast-MFC-AGG-ID: EsCTlgeoOqel8HMvjZjDGw_1763487935
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEFD019560B3; Tue, 18 Nov 2025 17:45:34 +0000 (UTC)
Received: from ringo.redhat.com (unknown [10.44.32.121])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 491B3180047F; Tue, 18 Nov 2025 17:45:31 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: Christophe Fontaine <cfontain@redhat.com>,
	stable@dpdk.org
Subject: [PATCH dpdk v2] net: ipv6 link local compliance with rfc 4291
Date: Tue, 18 Nov 2025 18:45:26 +0100
Message-ID: <20251118174526.321856-1-rjarry@redhat.com>
In-Reply-To: <20251114105751.54802-3-rjarry@redhat.com>
References: <20251114105751.54802-3-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9ubw_EC81YboCfCy9kFI57CTcrcHKjn8G7iQVsQyUeM_1763487935
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

From: Christophe Fontaine <cfontain@redhat.com>

As specified in RFC 4291 section 2.5.1, link local addresses must be
generated based on a modified EUI-64 interface identifier:

> Modified EUI-64 format interface identifiers are formed by inverting
> the "u" bit (universal/local bit in IEEE EUI-64 terminology) when
> forming the interface identifier from IEEE EUI-64 identifiers.

This translates to 'mac->addr_bytes[0] ^= 0x02'.

Fixes: 3d6d85f58c1c ("net: add utilities for well known IPv6 address types")
Cc: stable@dpdk.org

Signed-off-by: Christophe Fontaine <cfontain@redhat.com>
Signed-off-by: Robin Jarry <rjarry@redhat.com>
---

Notes:
    v2:
    
    - Stephen: replaced magic number 0x02 with RTE_ETHER_LOCAL_ADMIN_ADDR

 app/test/test_net_ip6.c | 2 +-
 lib/net/rte_ip6.h       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/app/test/test_net_ip6.c b/app/test/test_net_ip6.c
index cfc550940306..e4642c9a39d9 100644
--- a/app/test/test_net_ip6.c
+++ b/app/test/test_net_ip6.c
@@ -160,7 +160,7 @@ test_ipv6_llocal_from_ethernet(void)
 {
 	const struct rte_ether_addr local_mac = {{0x04, 0x7b, 0xcb, 0x5c, 0x08, 0x44}};
 	const struct rte_ipv6_addr local_ip =
-		RTE_IPV6(0xfe80, 0, 0, 0, 0x047b, 0xcbff, 0xfe5c, 0x0844);
+		RTE_IPV6(0xfe80, 0, 0, 0, 0x067b, 0xcbff, 0xfe5c, 0x0844);
 	struct rte_ipv6_addr ip;
 
 	rte_ipv6_llocal_from_ethernet(&ip, &local_mac);
diff --git a/lib/net/rte_ip6.h b/lib/net/rte_ip6.h
index 98bcac3f4dff..7ffbccacf842 100644
--- a/lib/net/rte_ip6.h
+++ b/lib/net/rte_ip6.h
@@ -393,7 +393,7 @@ rte_ipv6_mc_scope(const struct rte_ipv6_addr *ip)
 
 /*
  * Generate a link-local IPv6 address from an Ethernet address as specified in
- * RFC 2464, section 5.
+ * RFC 4291, section 2.5.1.
  *
  * @param[out] ip
  *   The link-local IPv6 address to generate.
@@ -406,7 +406,7 @@ rte_ipv6_llocal_from_ethernet(struct rte_ipv6_addr *ip, const struct rte_ether_a
 	ip->a[0] = 0xfe;
 	ip->a[1] = 0x80;
 	memset(&ip->a[2], 0, 6);
-	ip->a[8] = mac->addr_bytes[0];
+	ip->a[8] = mac->addr_bytes[0] ^ RTE_ETHER_LOCAL_ADMIN_ADDR;
 	ip->a[9] = mac->addr_bytes[1];
 	ip->a[10] = mac->addr_bytes[2];
 	ip->a[11] = 0xff;
-- 
2.51.1

