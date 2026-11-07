Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BCF606D82B
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Nov 2026 22:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KR4uazSB
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E46E402F0;
	Sat,  7 Nov 2026 23:19:21 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by mails.dpdk.org (Postfix) with ESMTPS id 7D0264003C
 for <dev@dpdk.org>; Sat,  7 Nov 2026 23:19:19 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso456445e9.1
 for <dev@dpdk.org>; Sat, 07 Nov 2026 14:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794089959; x=1794694759; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v9Loas9k3QYaRsjlwf5jvRL4rpm4b9j1cyqUng6MePg=;
 b=KR4uazSBpO5WGEtalaLa+dc9bmFD9+hH63yJ1LpPfYoxUfbgK121HTyEZSkCsk4BwB
 aTnO6WKrv9DMR0a5KCRQIDlJo1hvVelkvfC1RZYHursdBtweJxNjQp8JL4/5+VT/gci6
 5KR7NEfa+G12PivOGG1oRivKOQRD+u0uLhBQldJhi59xBLUC/Aws4XljSa5sarHBq2wX
 Z97e1MEg2EfOl2EdSIufPqsL0jeOGG1fAE/pjsVQ5M7LE9PyqbrisuBoEtVU5YeKs4Dk
 XXa6/AI3uF0HRh4eBU1JBu7L8xvmaRdJ7HqZYmZLE1jc61BDD9bDTJrEW65Ijbzibfao
 Wg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794089959; x=1794694759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=v9Loas9k3QYaRsjlwf5jvRL4rpm4b9j1cyqUng6MePg=;
 b=qYPoZJqje6r44WezCJqPxaHVjhdUVxt74t3opLlllQ0AhHMwith2MEBnn8ZOzpw8JS
 nJy//pcd0DN35fnUaerLqPUZemm1TXRmdmlQbcAMstHOVHAi5DIGp1bSbKxFpbJu+OuS
 pmmVWbyBAoajKG01Mc/+pi74Ws3AQi5vPOVpOKD2Rt/BUArPiFRINcPzQI9rJTQ2Duw1
 cLuw3SkyxlayCje4sIvMeN04lc7atggUoGardJQ/FuGOtU0yH+yrGZ9MINdiTA7wU+sA
 VCSDZixJTyM/0+qLTD2Kn6ANTOoi5yrNs9ekSuTeST3cnwpdX95J5QtQl4Y9UqaikeQ8
 U9/A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwcgki/9UREq0TBbQx0sWzRSqoO6Byd0U2SZltuCdrVszFIpDkSZGq5dXcnnHEVal7a824=@dpdk.org
X-Gm-Message-State: APuU4Z/9fpuxSMSlmt796JlRRQpTWo0hPseJF5dGavmgdQph0GXJfbYm
 xjFOw2bbiCpw5INcFrrKPpPpj/c5pcYg0q+tOCg/FHcBmBXevCETDkSR
X-Gm-Gg: AYBFou3/CaNNXtddyDoO7PVDF5zbfoRg+e8kdR3Dvk6kWdEQNqBHuyMAM31oUY9+PKi
 Yf5KOuwMBTuYutEF5xkUqlovcWr7PUpi7//NW9GPACuRtrm/rQIKh6uXme4ls7FtUDN1MjI9y/n
 uzhGNGplOEsBpvEp/dAH3XamVG1DySjct3sRlP2PTnUN5Hs199ZuAdjwFPGOp3UJ+7S1TokMyIS
 6w30FNYZJIxrEhOd/BiFBCUS3/i0XpwBxvF4WKl0k/kgpiv7cYKQF/zdh+BnBmhM2ODXFmiwvc9
 bEbqQyYcOShetUxM6iaJzbuAlD3nQxEQY2d7hu7XznGCWNt+X4vbW8b1DxC2i4NkzjhSW/362b4
 MHBQVBYR7G7Bfn6yFuvZkgmX2rXFZFSK3KEzsj05aR1yvdVgTypvYwxATrdlnHXHw28aJje+r1B
 C81wYkLMNY9iGxw4C60qCcCGbtoJ6uo6XjXqgDBsDh5MuYZZHku6CiX61Bet/3WTS5ROR+TeSuG
 FjKeQgmLWArvOzTCtHqxanY1JG/cVMA9NrPwUhQBWLZ5N4UCqWcQ3kmkVEv//aZFJ17FuSXbAIp
 zGm43JyX2DG+IeNWak/sEVSkhC3kah5yZ3TPH8/JktOehEFT/GYyU9oM/IzfV+icUpQ0QN/ItmT
 /w8hl4j4Qw2kJCehaJZeGrCX/2qLSVoiSKSEJQ+sIkjTjPUKaxHum+A==
X-Received: by 2002:a05:600c:6092:b0:4a1:f625:2108 with SMTP id
 5b1f17b1804b1-4b963c8722emr1732865e9.33.1794089958723; 
 Sat, 07 Nov 2026 14:19:18 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:2f07:7010:6500:f3ca:cc4f:cbe2:3b75])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b90f1117fasm12123105e9.13.2026.11.07.14.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 14:19:18 -0800 (PST)
From: Andrei-Niculae Petre <p31andrei@gmail.com>
To: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Sean Morrissey <sean.morrissey@intel.com>, dev@dpdk.org, stable@dpdk.org,
 Andrei-Niculae Petre <p31andrei@gmail.com>
Subject: [PATCH v3] examples/l3fwd: fix compilation when DP debug on
Date: Sun,  8 Nov 2026 00:17:07 +0200
Message-Id: <20261107221707.20990-1-p31andrei@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260414025137.91776-1-p31andrei@gmail.com>
References: <20260414025137.91776-1-p31andrei@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Update l3fwd example app to fix compilation when building dpdk with
RTE_LOG_DP_LEVEL=RTE_LOG_DEBUG in config/rte_config.h .
Move l3fwd_acl.h include above all #ifdef L3FWDACL_DEBUG checks,
as previously one ifdef would evaluate to false all the time (as
header include was added too late).

Adapt maintainers line from previous examples/l3fwd-acl (removed in
6de0ea50e9b9) to examples/l3fwd/l3fwd_acl* after l3fwd-acl app
unification into l3fwd. In 6de0ea50e9b9, a line with maintainer
expertise was removed.

Own testing of the l3fwd example:
1. It now compiles with "#define RTE_LOG_DP_LEVEL RTE_LOG_DEBUG" in
   config/rte_config.h. See Bugzilla ID 1318 comments for full error
   seen before this patch.
2. I ran the l3fwd app with IPv4/IPv6 ACL rules to see the prints (when
   RTE_LOG_DP_LEVEL RTE_LOG_DEBUG is set) in the application around ACL
   work as expected. See extract below (I added \ to format to 72chars):

// dump_acl4_rule extract:
Packet Src:192.168.1.100 Dst:192.168.1.101 Src port:2048,Dst port:1846 \
hit ACL 1 - 192.168.1.100/24 0.0.0.0/0 0 : 65535 0 : 65535 0x0/0x0 \
0xffffffff-0x1ffffffe-0xf0000001

// dump_acl6_rule extract:
Packet Src2001:db8:1::100
Dst2001:db8:1::101
Src port:32768,Dst port:21005 hit ACL 0 - \
2001:0db8:0001:0000:0000:0000:0000:0000/64 \
0000:0000:0000:0000:0000:0000:0000:0000/0 0 : 65535 0 : 65535 \
0x0/0x0 0xffffffff-0x1fffffff-0xf0000000

Bugzilla ID: 1318
Fixes: 6de0ea50e9b9 ("examples/l3fwd: merge l3fwd-acl example")
Cc: stable@dpdk.org
Cc: sean.morrissey@intel.com

Signed-off-by: Andrei-Niculae Petre <p31andrei@gmail.com>
---
v3
* Drop l3_forward.rst addition from MAINTAINERS to avoid overmatching.
v2
* Rebase from latest main
* Shrink/simplify patch by not making print_one_ipv*_rule static
* Test l3fwd app with acl rules and add to description
---
 .mailmap                   |  1 +
 MAINTAINERS                |  1 +
 examples/l3fwd/l3fwd_acl.c | 23 ++++++++++++-----------
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/.mailmap b/.mailmap
index 754dd9e760..844deef539 100644
--- a/.mailmap
+++ b/.mailmap
@@ -115,6 +115,7 @@ Andre Richter <andre.o.richter@gmail.com>
 Andrea Arcangeli <aarcange@redhat.com>
 Andrea Grandi <andrea.grandi@intel.com>
 Andrea Panattoni <apanatto@redhat.com>
+Andrei-Niculae Petre <p31andrei@gmail.com> <andrei.petre@keysight.com>
 Andrew Bailey <abailey@iol.unh.edu>
 Andrew Boyer <andrew.boyer@amd.com> <aboyer@pensando.io>
 Andrew Harvey <agh@cisco.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 1d865ffd46..386338a00a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1757,6 +1757,7 @@ F: lib/acl/
 F: doc/guides/prog_guide/packet_classif_access_ctrl.rst
 F: app/test-acl/
 F: app/test/test_acl.*
+F: examples/l3fwd/l3fwd_acl*
 
 EFD
 M: Yipeng Wang <yipeng1.wang@intel.com>
diff --git a/examples/l3fwd/l3fwd_acl.c b/examples/l3fwd/l3fwd_acl.c
index 4ee3411d2a..6f39923140 100644
--- a/examples/l3fwd/l3fwd_acl.c
+++ b/examples/l3fwd/l3fwd_acl.c
@@ -239,6 +239,9 @@ enum {
 RTE_ACL_RULE_DEF(acl4_rule, RTE_DIM(ipv4_defs));
 RTE_ACL_RULE_DEF(acl6_rule, RTE_DIM(ipv6_defs));
 
+/* Must be included before any L3FWDACL_DEBUG define check. */
+#include "l3fwd_acl.h"
+
 static struct {
 	struct rte_acl_ctx *acx_ipv4[NB_SOCKETS];
 	struct rte_acl_ctx *acx_ipv6[NB_SOCKETS];
@@ -255,8 +258,6 @@ static struct rte_acl_rule *acl_base_ipv4, *route_base_ipv4,
 static unsigned int acl_num_ipv4, route_num_ipv4,
 		acl_num_ipv6, route_num_ipv6;
 
-#include "l3fwd_acl.h"
-
 #include "l3fwd_acl_scalar.h"
 
 /*
@@ -859,17 +860,17 @@ print_one_ipv6_rule(struct acl6_rule *rule, int extra)
 
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
@@ -883,7 +884,7 @@ dump_acl4_rule(struct rte_mbuf *m, uint32_t sig)
 }
 
 static inline void
-dump_acl6_rule(struct rte_mbuf *m, uint32_t sig)
+dump_acl6_rule(const struct rte_mbuf *m, uint32_t sig)
 {
 	char abuf[INET6_ADDRSTRLEN];
 	uint32_t offset = sig & ~ACL_DENY_SIGNATURE;
@@ -892,10 +893,10 @@ dump_acl6_rule(struct rte_mbuf *m, uint32_t sig)
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
@@ -988,8 +989,8 @@ dump_denied_pkt(const struct rte_mbuf *pkt, uint32_t res)
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
-- 
2.39.5

