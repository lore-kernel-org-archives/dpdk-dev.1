Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2860105F794
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Mar 2026 10:35:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A92FB40279;
	Fri, 13 Mar 2026 11:35:43 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id BA7594026C
 for <dev@dpdk.org>; Fri, 13 Mar 2026 11:35:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773398142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JoVy/QHp5IyQyrX03yZXwVxiNsw/fLErMr9ojptbIgU=;
 b=Ik0dRI/a+YrO15/KJkNqFQ4H7kkZTqtHxosTP5N7FR/mEWUnR6UwNf31SPxQ5mj9Lf77nF
 tVUdRAViHerPkWbLGB0DJPlKN6368bMfdGGfVR4HbaWD3G8NzM5CrGsfdFu4IBJQCo13X+
 KZWpLdu9xXX8rylm8vQ9Wn+USKWvqf8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-NGISmJdWN9ap9RAVVOlLJg-1; Fri,
 13 Mar 2026 06:35:41 -0400
X-MC-Unique: NGISmJdWN9ap9RAVVOlLJg-1
X-Mimecast-MFC-AGG-ID: NGISmJdWN9ap9RAVVOlLJg_1773398140
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2E0219560B0; Fri, 13 Mar 2026 10:35:39 +0000 (UTC)
Received: from rh.redhat.com (unknown [10.45.224.40])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B176219540C5; Fri, 13 Mar 2026 10:35:37 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: dev@dpdk.org
Cc: Kevin Traynor <ktraynor@redhat.com>, stable@dpdk.org,
 Radu Nicolau <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>
Subject: [PATCH] examples/ipsec-secgw: fix discarded-qualifers warnings
Date: Fri, 13 Mar 2026 10:35:23 +0000
Message-ID: <20260313103523.1094309-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BFmBoZJNWAPMB405x51OQnSvwg21hLbN07z-5WlP-zA_1773398140
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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

glibc 2.42 has const-preserving functions.

This leads to warnings when there is a const argument
and an assignment to a non-const variable.

Example with GCC 16.0.1 and glibc 2.43 on Fedora Rawhide (F45).

/examples/ipsec-secgw/parser.c: In function ‘parse_ipv4_addr’:
../examples/ipsec-secgw/parser.c:53:13:
warning: assignment discards ‘const’ qualifier from pointer target type
[-Wdiscarded-qualifiers]
   53 |         pch = strchr(token, '/');
      |             ^

Cc: stable@dpdk.org

Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
---
 examples/ipsec-secgw/parser.c | 4 ++--
 examples/ipsec-secgw/sa.c     | 2 +-
 examples/ipsec-secgw/sp4.c    | 2 +-
 examples/ipsec-secgw/sp6.c    | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/examples/ipsec-secgw/parser.c b/examples/ipsec-secgw/parser.c
index cb463c704f..29c4d3cb3d 100644
--- a/examples/ipsec-secgw/parser.c
+++ b/examples/ipsec-secgw/parser.c
@@ -49,5 +49,5 @@ parse_ipv4_addr(const char *token, struct in_addr *ipv4, uint32_t *mask)
 {
 	char ip_str[INET_ADDRSTRLEN] = {0};
-	char *pch;
+	const char *pch;
 
 	pch = strchr(token, '/');
@@ -79,5 +79,5 @@ parse_ipv6_addr(const char *token, struct rte_ipv6_addr *ipv6, uint32_t *mask)
 {
 	char ip_str[256] = {0};
-	char *pch;
+	const char *pch;
 
 	pch = strchr(token, '/');
diff --git a/examples/ipsec-secgw/sa.c b/examples/ipsec-secgw/sa.c
index 86aeb25a49..a1a996dee8 100644
--- a/examples/ipsec-secgw/sa.c
+++ b/examples/ipsec-secgw/sa.c
@@ -1676,5 +1676,5 @@ sa_spi_present(struct sa_ctx *sa_ctx, uint32_t spi, int inbound)
 {
 	uint32_t num;
-	struct ipsec_sa *sa;
+	const struct ipsec_sa *sa;
 	struct ipsec_sa tmpl;
 	const struct ipsec_sa *sar;
diff --git a/examples/ipsec-secgw/sp4.c b/examples/ipsec-secgw/sp4.c
index fc4101a4a2..9c0badd062 100644
--- a/examples/ipsec-secgw/sp4.c
+++ b/examples/ipsec-secgw/sp4.c
@@ -611,5 +611,5 @@ sp4_spi_present(uint32_t spi, int inbound, struct ip_addr ip_addr[2],
 {
 	uint32_t num;
-	struct acl4_rules *rule;
+	const struct acl4_rules *rule;
 	const struct acl4_rules *acr;
 	struct acl4_rules tmpl;
diff --git a/examples/ipsec-secgw/sp6.c b/examples/ipsec-secgw/sp6.c
index ebc47dfe49..8aff843812 100644
--- a/examples/ipsec-secgw/sp6.c
+++ b/examples/ipsec-secgw/sp6.c
@@ -755,5 +755,5 @@ sp6_spi_present(uint32_t spi, int inbound, struct ip_addr ip_addr[2],
 {
 	uint32_t num;
-	struct acl6_rules *rule;
+	const struct acl6_rules *rule;
 	const struct acl6_rules *acr;
 	struct acl6_rules tmpl;
-- 
2.53.0

