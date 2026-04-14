Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CE8F531E3
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 02:52:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB9AB402E1;
	Tue, 14 Apr 2026 04:52:39 +0200 (CEST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id D8BC2402B3
 for <dev@dpdk.org>; Tue, 14 Apr 2026 04:52:38 +0200 (CEST)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-488ba6366a7so62864825e9.0
 for <dev@dpdk.org>; Mon, 13 Apr 2026 19:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776135158; x=1776739958; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wJn7fSr6U46CeoD3CRPzEpG7LY8GBpkA4qezAgqovVw=;
 b=CGx7ZEY82HD0R2gY3hbsLmayirEfP0IsYC1XCho7Xelth+/RC0Oz3A/LpWMj9uhouE
 fwy91ueCjgPGmziznVqVIcXtOkTTzUOcy3wQjuOS4FOQNeCBUaVfjOlNHL5s09HUGzC5
 zwfscHyIZMOq+OnOBHhLwoRx9vE5R2fVsToNGgVCRSeB0dfJfY8i+dL/xIV5Fk45SHvm
 otDczIKUZILmCNMrc1ewKTAI9tw3tCgkngQO7ftwUOk54uEDlGl6NboGvIPIXjL+80aQ
 bPprtr4YDiaBSdRNdR15eqaUvm/E5VAJxTIv0n1dyldEGaqIypKI4GB/7aZ6TWe0Acgd
 73gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776135158; x=1776739958;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJn7fSr6U46CeoD3CRPzEpG7LY8GBpkA4qezAgqovVw=;
 b=CIRo6xiovcHjxvP0nz/wh9JxZNVmKGlpc7luD8VIh+KYh1d3Cg0PVHCmrvQaBVWh8Y
 EvGrEShDNbBas6p8ZlZhhVj4NsIP1wOEYW5X/uF2HkWsicDqtQ7Wzwd+KNtZegoqyQgR
 UEnR8DSkb3ir4ydkyx5mZbTFmJX8xTIUPl0rc3cgGhHWfKGouQliynLw2HTjTdhT8h6O
 nd/2oB7cV3cJNQuvgoVgHBFYNhAeqXLM9R/lNaxWpM4+C8e4Bbovo6lrIYJYwfo+JtOh
 8UylHSfVo/jVv5ZSsLdVt1+kdq5RUXLphND76Sbqo7ybGxBU3GejXdp2SH0s2+6h4t4f
 5KYg==
X-Gm-Message-State: AOJu0Yx/Oohbz0VZ84IxyFtEapm2Ldm0FCgI88FT9gK1AkHl0CvgEcOb
 Hv8spMpbbABj/OhOzppkFd7L0XpGjfyVIwdui3TCZCerMG2QqYINXuGq
X-Gm-Gg: AeBDiet2wQpPvGhcDnv1q+jaKrOEK5R0DYwjYJUHWW+bDGuEAoq0RTqoEUE9SmF9pnq
 I1rwr+tMABbIEUAPH6MM4fGnuDZt01VXPI7VUOvBBvQnU4orkw0miwoo0YdcdP8ecUSgm4Ws5jy
 5xorZw5+nJU3OHs4K1H+KmJ7Y2AoYEYd0O6SSjq7hwLbEeuovUo/TUTXS7Cz+WXX8WXAAIIwv/4
 opG1hm5pE39ipcrkmOMqdlMSECnEnOD//shZ3DZyILl7hZWXEYI0CIk+etHg/F77d7un4dR6NUi
 OE6ursspbsFBToF4Msn24d1xYzmVRE4zZ3pVX/5Essygh+KZn/FMOUvsnG13I//1ViwWOnUH+Di
 FrEE+3rUQhd2I6w2zOpQasedAtbZ2Drq+qrGh8WS1/frXOiMsytK50RkqrRKm0K94E37Ei5FAZD
 7dU9GWUilDpmiy6QwzoSAHcunro0Mu5mpyVCaZ464=
X-Received: by 2002:a05:600c:3149:b0:488:ab26:8fe0 with SMTP id
 5b1f17b1804b1-488d68432f2mr218341525e9.15.1776135158057; 
 Mon, 13 Apr 2026 19:52:38 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:2f07:7100:ec00:8472:c5fe:564a:7727])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d681ea59sm113032175e9.14.2026.04.13.19.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 19:52:37 -0700 (PDT)
From: Andrei-Niculae Petre <p31andrei@gmail.com>
To: konstantin.ananyev@huawei.com
Cc: dev@dpdk.org, Andrei-Niculae Petre <p31andrei@gmail.com>, stable@dpdk.org,
 sean.morrissey@intel.com
Subject: [PATCH] examples/l3fwd: fix compilation when DP debug on
Date: Tue, 14 Apr 2026 05:51:37 +0300
Message-Id: <20260414025137.91776-1-p31andrei@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Previously, l3fwd example app would fail to compile ([1]) if one would
put RTE_LOG_DP_LEVEL=RTE_LOG_DEBUG in config/rte_config.h and try to
compile dpdk; this path was not enabled via compiling debug build
(--buildtype=debug) alone, but needed the data path to be at debug
level.

[1] https://bugs.dpdk.org/show_bug.cgi?id=1318

Bugzilla ID: 1318
Fixes: 6de0ea50e9b9 ("examples/l3fwd: merge l3fwd-acl example")
Cc: stable@dpdk.org
Cc: sean.morrissey@intel.com

Signed-off-by: Andrei-Niculae Petre <p31andrei@gmail.com>
---
 .mailmap                   |  1 +
 MAINTAINERS                |  2 ++
 examples/l3fwd/l3fwd_acl.c | 27 ++++++++++++++-------------
 examples/l3fwd/l3fwd_acl.h |  6 ------
 4 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/.mailmap b/.mailmap
index cdaa471715..df999d00d8 100644
--- a/.mailmap
+++ b/.mailmap
@@ -106,6 +106,7 @@ Andre Muezerie <andremue@linux.microsoft.com> <andremue@microsoft.com>
 Andre Richter <andre.o.richter@gmail.com>
 Andrea Arcangeli <aarcange@redhat.com>
 Andrea Grandi <andrea.grandi@intel.com>
+Andrei-Niculae Petre <p31andrei@gmail.com>
 Andrew Bailey <abailey@iol.unh.edu>
 Andrew Boyer <andrew.boyer@amd.com> <aboyer@pensando.io>
 Andrew Harvey <agh@cisco.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 5683b87e4a..501f312ba1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1740,6 +1740,8 @@ F: lib/acl/
 F: doc/guides/prog_guide/packet_classif_access_ctrl.rst
 F: app/test-acl/
 F: app/test/test_acl.*
+F: examples/l3fwd/l3fwd_acl*
+F: doc/guides/sample_app_ug/l3_forward.rst
 
 EFD
 M: Byron Marohn <byron.marohn@intel.com>
diff --git a/examples/l3fwd/l3fwd_acl.c b/examples/l3fwd/l3fwd_acl.c
index a1275e18bc..8e24f1c599 100644
--- a/examples/l3fwd/l3fwd_acl.c
+++ b/examples/l3fwd/l3fwd_acl.c
@@ -235,6 +235,9 @@ enum {
 RTE_ACL_RULE_DEF(acl4_rule, RTE_DIM(ipv4_defs));
 RTE_ACL_RULE_DEF(acl6_rule, RTE_DIM(ipv6_defs));
 
+/* Must be included before acl_config definition to enable L3FWDACL_DEBUG */
+#include "l3fwd_acl.h"
+
 static struct {
 	struct rte_acl_ctx *acx_ipv4[NB_SOCKETS];
 	struct rte_acl_ctx *acx_ipv6[NB_SOCKETS];
@@ -251,8 +254,6 @@ static struct rte_acl_rule *acl_base_ipv4, *route_base_ipv4,
 static unsigned int acl_num_ipv4, route_num_ipv4,
 		acl_num_ipv6, route_num_ipv6;
 
-#include "l3fwd_acl.h"
-
 #include "l3fwd_acl_scalar.h"
 
 /*
@@ -773,7 +774,7 @@ read_config_files_acl(void)
 	}
 }
 
-void
+static void
 print_one_ipv4_rule(struct acl4_rule *rule, int extra)
 {
 	char abuf[INET6_ADDRSTRLEN];
@@ -800,7 +801,7 @@ print_one_ipv4_rule(struct acl4_rule *rule, int extra)
 			rule->data.userdata);
 }
 
-void
+static void
 print_one_ipv6_rule(struct acl6_rule *rule, int extra)
 {
 	unsigned char a, b, c, d;
@@ -855,17 +856,17 @@ print_one_ipv6_rule(struct acl6_rule *rule, int extra)
 
 #ifdef L3FWDACL_DEBUG
 static inline void
-dump_acl4_rule(struct rte_mbuf *m, uint32_t sig)
+dump_acl4_rule(const struct rte_mbuf *m, uint32_t sig)
 {
-	char abuf[INET6_ADDRSTRLEN];
+	char abuf[INET_ADDRSTRLEN];
 	uint32_t offset = sig & ~ACL_DENY_SIGNATURE;
 	struct rte_ipv4_hdr *ipv4_hdr =
 		rte_pktmbuf_mtod_offset(m, struct rte_ipv4_hdr *,
 					sizeof(struct rte_ether_hdr));
 
-	printf("Packet Src:%s ", inet_ntop(AF_INET, ipv4_hdr->src_addr,
+	printf("Packet Src:%s ", inet_ntop(AF_INET, &ipv4_hdr->src_addr,
 		abuf, sizeof(abuf)));
-	printf("Dst:%s ", inet_ntop(AF_INET, ipv4_hdr->dst_addr,
+	printf("Dst:%s ", inet_ntop(AF_INET, &ipv4_hdr->dst_addr,
 		abuf, sizeof(abuf)));
 
 	printf("Src port:%hu,Dst port:%hu ",
@@ -879,7 +880,7 @@ dump_acl4_rule(struct rte_mbuf *m, uint32_t sig)
 }
 
 static inline void
-dump_acl6_rule(struct rte_mbuf *m, uint32_t sig)
+dump_acl6_rule(const struct rte_mbuf *m, uint32_t sig)
 {
 	char abuf[INET6_ADDRSTRLEN];
 	uint32_t offset = sig & ~ACL_DENY_SIGNATURE;
@@ -888,10 +889,10 @@ dump_acl6_rule(struct rte_mbuf *m, uint32_t sig)
 					sizeof(struct rte_ether_hdr));
 
 	printf("Packet Src");
-	printf("%s", inet_ntop(AF_INET6, ipv6_hdr->src_addr,
+	printf("%s", inet_ntop(AF_INET6, &ipv6_hdr->src_addr,
 		abuf, sizeof(abuf)));
 	printf("\nDst");
-	printf("%s", inet_ntop(AF_INET6, ipv6_hdr->dst_addr,
+	printf("%s", inet_ntop(AF_INET6, &ipv6_hdr->dst_addr,
 		abuf, sizeof(abuf)));
 
 	printf("\nSrc port:%hu,Dst port:%hu ",
@@ -984,8 +985,8 @@ dump_denied_pkt(const struct rte_mbuf *pkt, uint32_t res)
 	if ((res & ACL_DENY_SIGNATURE) != 0) {
 		if (RTE_ETH_IS_IPV4_HDR(pkt->packet_type))
 			dump_acl4_rule(pkt, res);
-		else if (RTE_ETH_IS_IPV6_HDR(pkt[i]->packet_type))
-			dump_acl6_rule(pkt[i], res[i]);
+		else if (RTE_ETH_IS_IPV6_HDR(pkt->packet_type))
+			dump_acl6_rule(pkt, res);
 	}
 #else
 	RTE_SET_USED(pkt);
diff --git a/examples/l3fwd/l3fwd_acl.h b/examples/l3fwd/l3fwd_acl.h
index 05af62fe10..a34a08eb7f 100644
--- a/examples/l3fwd/l3fwd_acl.h
+++ b/examples/l3fwd/l3fwd_acl.h
@@ -48,10 +48,4 @@
  */
 #define FWD_PORT_SHIFT 1
 
-void
-print_one_ipv4_rule(struct acl4_rule *rule, int extra);
-
-void
-print_one_ipv6_rule(struct acl6_rule *rule, int extra);
-
 #endif /* L3FWD_ACL_H */
-- 
2.39.5

