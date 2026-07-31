Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4983EC5516D
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 13:38:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B550A40671;
	Fri, 31 Jul 2026 15:38:50 +0200 (CEST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44]) by mails.dpdk.org (Postfix) with ESMTP id CE6E04028B
 for <dev@dpdk.org>; Fri, 31 Jul 2026 15:38:48 +0200 (CEST)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c15ba3a2b4bso116372266b.1
 for <dev@dpdk.org>; Fri, 31 Jul 2026 06:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785505128; x=1786109928; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eU+U8WE6DRBQbsOdhNcRwhoeuSmZ7DhP7AeaIB0l78w=;
 b=CbE/aKJjd3hduuIsI+2Q6pFYL60Slq54xTGfYabzn5LCBEeMeYRYC43WQt0GzYeNTc
 cjKWSAvXrGJ3HyKcR1UE0KjFHX/nyyxMbFxzVNB+msut7FeHD5XFszr7rkNGEQ3i4d/4
 XGak1ZYM258iJFDSXkfu+zv0lxvitZlkyhHqOTpSUIavvUntNFRz44OIJazKruPDwTHD
 GDkC9jMTXU7XXUJFY6F9LX5CGhBYRMmNsmCtLwzr5mGeySpM/sg1SFXBo7C25WQwLD4y
 unjU/AK4JTeZxjTvN5qZki/0Jdkax7C+vTLr6lj4l24qcPaZRnRcIm7s/C3LvbUo8ilD
 m0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785505128; x=1786109928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eU+U8WE6DRBQbsOdhNcRwhoeuSmZ7DhP7AeaIB0l78w=;
 b=C06SSGar9gOpP9VqHPJHt4gUa//roehxBJ2Flg1St9K0SzXFvHC3ky71DBqhUZt+5e
 Uq/HNu4mF4TOb9yWXUxsGCpthRGmZ1PRVCXEVgdrUX1gJhlp0L4yPyX7OBNYMD81CBRi
 0DKqj8FdHC2nBM+IusQsiCC4Nzwdz4u0g4Hv2ZfHhm/EcFBW0hmJ+FLvLLaDwuirbbIo
 8CFbacXwo7CAVYy5m9MaZRssn89TfucrX0oCAY7U0vbhTn2r9IqoTbfMDV5k1hAWIc9w
 YFv8Rxh/aq9/iqDpPR0XKP4gxCzGuBwNrBOITAhyhXzEIj1oT71G1iH5MxD6z7wHBhKV
 jIYg==
X-Gm-Message-State: AOJu0YxIIPi0cQf2NvxZgbvFznJXMLGAuN1hOO7hHD3QNd0+QhUGKu9I
 RVH4IvZaShP2KOZZUN88fIuNwvYPm56kpgg0izsi7Z4UJu1lgU6PQKJh
X-Gm-Gg: AR+sD109itLjKWZlIuCt9qz/LMd6M7iXp5pK0MZTCI6y/qhYFAvjgFUc/Tahij26THP
 6Y/nmOl9zXKQk7DlbF8k9cUHY+G6euj7e7VMeqAIZmtHDfwGVXjtu82Smx5px9+nF6qJ5A2Oc8n
 d1KYUxw+bOjw6S1yFcx4G4vUga09NzTMXVvEbZY062HOYWwT/hJ4Cs7ntElzaJ1oFosQX1K6fHF
 EVtd7O4GwsvbH3g+4YWnpYZPsGQSBw9XLpbgzYe1zKquMdHHm6L0FaDR0Q9QDJRMRCwU8d7BfzP
 CzWGgfFKEJ8JRyPK/lLHuY40mdMGj0dCYy3srAiCItZDTVVo0tPu12tnQWRR60er1QuQ47xoWbW
 9IKz54+2VEdLmBdXLbfbTyfX/GASo2OdXcNP1IU79QCbNDP59MDLmPKauYb/E0RdSrmbI1x6faD
 mda4epmvyXKtzHZ3eCpzlFXL7LTmHcobdTGj5GMUZuEdoQgmA6/S3U6gKG8j1rgiZk4Syx01bVm
 ZxbxgiZt424+tE=
X-Received: by 2002:a17:907:ea8c:b0:c16:5f28:4575 with SMTP id
 a640c23a62f3a-c1fd253c76fmr143357966b.31.1785505128029; 
 Fri, 31 Jul 2026 06:38:48 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:2f07:7204:7e00:2d6d:8511:1637:7faa])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd42d91b3sm5474660f8f.14.2026.07.31.06.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 06:38:47 -0700 (PDT)
From: Andrei-Niculae Petre <p31andrei@gmail.com>
To: konstantin.ananyev@huawei.com
Cc: dev@dpdk.org, Andrei-Niculae Petre <p31andrei@gmail.com>, stable@dpdk.org,
 sean.morrissey@intel.com
Subject: [PATCH v2] examples/l3fwd: fix compilation when DP debug on
Date: Fri, 31 Jul 2026 16:37:39 +0300
Message-Id: <20260731133739.223235-1-p31andrei@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260414025137.91776-1-p31andrei@gmail.com>
References: <20260414025137.91776-1-p31andrei@gmail.com>
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
v2
* Rebase from latest main
* Shrink/simplify patch by not making print_one_ipv*_rule static
* Test l3fwd app with acl rules and add to description
---
 .mailmap                   |  1 +
 MAINTAINERS                |  2 ++
 examples/l3fwd/l3fwd_acl.c | 23 ++++++++++++-----------
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/.mailmap b/.mailmap
index fcb3d1bb3f..01a4bedf97 100644
--- a/.mailmap
+++ b/.mailmap
@@ -112,6 +112,7 @@ Andre Richter <andre.o.richter@gmail.com>
 Andrea Arcangeli <aarcange@redhat.com>
 Andrea Grandi <andrea.grandi@intel.com>
 Andrea Panattoni <apanatto@redhat.com>
+Andrei-Niculae Petre <p31andrei@gmail.com> <andrei.petre@keysight.com>
 Andrew Bailey <abailey@iol.unh.edu>
 Andrew Boyer <andrew.boyer@amd.com> <aboyer@pensando.io>
 Andrew Harvey <agh@cisco.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index e99a65d197..6b6446a998 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1756,6 +1756,8 @@ F: lib/acl/
 F: doc/guides/prog_guide/packet_classif_access_ctrl.rst
 F: app/test-acl/
 F: app/test/test_acl.*
+F: examples/l3fwd/l3fwd_acl*
+F: doc/guides/sample_app_ug/l3_forward.rst
 
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

