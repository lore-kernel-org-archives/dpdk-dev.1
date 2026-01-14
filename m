Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACBDD31A29
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 09:32:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4755E40656;
	Wed, 14 Jan 2026 10:32:46 +0100 (CET)
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
 by mails.dpdk.org (Postfix) with ESMTP id BA8E94064F
 for <dev@dpdk.org>; Wed, 14 Jan 2026 10:32:43 +0100 (CET)
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R12" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4drgrW38dhz3pcD;
 Wed, 14 Jan 2026 09:32:43 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R12" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4drgrW1w14z3YhJ;
 Wed, 14 Jan 2026 09:32:43 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1768383163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GoNZfs0Qmcg0CNDuYGSomjKv6jlyFd23JgCTH3Wxmq0=;
 b=ZuK0lG5bzqPfqpWhecyOsl346d9hvfXBb3JmXagm/0nnIhhG7svarWyy7bOmoxbaDvFbCr
 RUp5UDVfk3YS7D8mE/93QZFdKVNx/JG7dQADIbbZXYS/nRmMy3KqJ+pYb86+6rcDwN2zMH
 AaTEfyf91n/tIF8jrN5YyCBi8H6eKYpcT7fyBv5AZ1sTDkb5kUSLMgaN/+18FrnJ3S6qUY
 U2XNLrVJllf1Hp6TSVZla1hv8hW7JEP9LwZuAlIQzzd2v0K3JqHbhnEeExgf4L2YywN1Hg
 VGCSbt8ax08ciUDpv0T9daa59u7NLOL25aHl8ey0cLro8J0mXU18z4J0D6g7Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1768383163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GoNZfs0Qmcg0CNDuYGSomjKv6jlyFd23JgCTH3Wxmq0=;
 b=MURyfgaDh0h4LMjNinmeXsXxFKWeoNQXeiwV4LR0ed+IC43fMefVy3LOHgNh74OyuILSNQ
 L6bTJP7Mai/FgQVhsouhVks8Ol6MABqcPYk/Usq4wA1ehOaAhOJog8Fz4x4CtqFXjJLg6V
 +Aw9NN74Gq57o9Ffr+7apA36KQUlATm6y+TURehNfx16qk8wBQ6KCe3FLbnh2zmNPL9Fb8
 PAKPtvyOw7t3nCXm1rf3Xc2kye0hIXPeVjtx4cf+u1WbVGjk1fVBw44PN0dFkkDKqZAl3M
 KVaTHl+GCLdoEOgP2PkjFAISn/WFoTiEam59gNu2XEhQJdAyxWH0n3nlPyiQLg==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1768383163; a=rsa-sha256; cv=none;
 b=qy8x1eaKPh0JBIgpa8WS2IQee1q0XVeCVp+PFvJ2ymfV56oLjEXlPg7W/SNjUJI0knAXPG
 vLt/4y7bl4gPBPmxcIf4VEWCVx9fQV5STRQwQgM4T9knDvUfP2Ys/Jt0q5OoomfEfDI65F
 UWFcFHk8FiWBOb6wtzOE4rT+kx0NDucUc0RVxFM4WRGK1ulWqpyfT1P4+na3D6crT/B7tF
 PmtQxTDsfS9iuvYwZxrd53OdWTDPuF+AuVcJxOQzAnGbk8jpaQnTgPBfbX3vrL7ZTnat2N
 h55ocq00VmnUgF9wZWTsD8eyyPNSpjaSYu+bSjAU4U+K3Ov/ENOyrWHBEq2aKA==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
Received: from x1c.netflix.com (unknown [IPv6:2607:fb10:2023::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate) (Authenticated sender: jfree)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4drgrT1j0Xzs22;
 Wed, 14 Jan 2026 09:32:40 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
From: Jake Freeland <jfree@FreeBSD.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: Jake Freeland <jfree@FreeBSD.org>,
	dev@dpdk.org
Subject: [PATCH v3 1/3] eal/freebsd: do not use prev_ms_idx for hole detection
Date: Wed, 14 Jan 2026 18:31:27 +0900
Message-ID: <20260114093140.3256584-2-jfree@FreeBSD.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114093140.3256584-1-jfree@FreeBSD.org>
References: <20250814213246.4141803-1-jfree@FreeBSD.org>
 <20260114093140.3256584-1-jfree@FreeBSD.org>
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

Use rte_fbarray_is_used() to check if the previous fbarray entry is
already empty.

Using prev_ms_idx to do this is flawed in cases where we loop through
multiple memseg lists. Each memseg list has its own count and length,
so using a prev_ms_idx from one memseg list to check for used entries
in another non-empty memseg list can lead to incorrect hole placement.

Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
---
 lib/eal/freebsd/eal_memory.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/eal/freebsd/eal_memory.c b/lib/eal/freebsd/eal_memory.c
index 6d3d46a390..8c315d97d5 100644
--- a/lib/eal/freebsd/eal_memory.c
+++ b/lib/eal/freebsd/eal_memory.c
@@ -103,7 +103,6 @@ rte_eal_hugepage_init(void)
 	for (i = 0; i < internal_conf->num_hugepage_sizes; i++) {
 		struct hugepage_info *hpi;
 		rte_iova_t prev_end = 0;
-		int prev_ms_idx = -1;
 		uint64_t page_sz, mem_needed;
 		unsigned int n_pages, max_pages;
 
@@ -167,9 +166,13 @@ rte_eal_hugepage_init(void)
 				if (ms_idx < 0)
 					continue;
 
-				if (need_hole && prev_ms_idx == ms_idx - 1)
+				/* ms_idx should never be 0 if we need a hole,
+				 * but include a check for static analysis.
+				 */
+				if (need_hole &&
+				    ms_idx > 0 &&
+				    rte_fbarray_is_used(arr, ms_idx - 1))
 					ms_idx++;
-				prev_ms_idx = ms_idx;
 
 				break;
 			}
-- 
2.51.0

