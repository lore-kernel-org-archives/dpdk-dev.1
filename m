Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EC0606A339
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Nov 2026 18:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DC78unaO
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF8E640653;
	Tue, 24 Nov 2026 19:05:54 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by mails.dpdk.org (Postfix) with ESMTPS id 926B54064F
 for <dev@dpdk.org>; Tue, 24 Nov 2026 19:05:54 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4bb64c99d2fso46825575e9.3
 for <dev@dpdk.org>; Tue, 24 Nov 2026 10:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795543554; x=1796148354; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LxjDHRBhWLkOKS03eQvCGoH4SPmvfCJpEkoDLZfsOw8=;
 b=DC78unaO4ETHJq7vOj0+uh5CldgkT6TUo9zikAqhqqWkhk5dW3yoBxKnLOj/FFatM1
 X4HKoZz2VOSA0BWYeMB+lqQC+EBFmm7Qo1C0yrcKBbRbDB4UgC0xhRM/Lokqr8c1kFMw
 0r44LRhifaxfManSsOpW4ffM2uDqTiUwYII5ubiBK7iGLK1PHA3fafHy8Bm3vxrS8zDT
 nbCg0aUHAca5PactXaKd1VK5B1XJzGSIYhZ5L9odK0AOnQ2Nw0NfEAGI4Q4qK8nzijK1
 9C7svijR85eAw7o/ZvT8YKeJEjppCqh+qfBLLidq2yyupF7Yw0JSo4y2pN0OiRrZQoiY
 Iurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795543554; x=1796148354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LxjDHRBhWLkOKS03eQvCGoH4SPmvfCJpEkoDLZfsOw8=;
 b=Mwr3N2UbvnNjuMgJy+wpc74aX7CtOTgWdmnzOYwiGe4wnFFLTAVkiP+Mzk5ANpdQKY
 hju/ug1ewIaRooI7XRnIa+k7T14QzTeF4JZH7x6PnVonZ6oy8lsnz7MXtnmVha3EZ/xO
 tGI/NmrNgWcY3O+OyrTFc2WrR7qLX7NAnEopLMXcGUo/QvmJLxYV3b+Su94sSAd56jfj
 aV5IuHztLnajpGTtd4mw/DwE7FkerlSfQ6QvjLBHsIYj/XVP/z6HGusB8ecr0sAh2Kx2
 uI3813I/VMHy8hMHI4a0JwpVmqESQqYMt9rnQopDxZ719pjeoU+cfqJoHs+SO34ij6QR
 pU2A==
X-Gm-Message-State: APuU4Z8XfR4YGoIndKfpY8hNBViA4b3QTZgM1j5USWFD5DRzwaZF3H8t
 PtgJWk0qvI85t6NiKbaF9SADGJtoYYMMDpgN/ubfTi/2l4255nEsdeH3ZtYkzQ==
X-Gm-Gg: AZFdTZcHnZMYdQ9YPpcaYWk+Wm54nptBjKV9+WQMmjrk496czPlS8icgjnBPvV89NDm
 AZiiZ9A7QjJ3vmjhX0+Ljbi0VVVVZsGvEfCWnSdLxL/F1va5hjqfGJMMfP4DLvjScPIdROR5aUU
 j8s6X9doETEc3KXspQ5tDB34BTReqhN98q8z0iR63R6EiMXAWN3sy9SdmZTiBQCzXv6aXAluVyr
 xDlFsIw5a0onVjsVA5Pib05xXQMhC7S4x2I1nhLzY/YgL32z7GaY8Inb050d6UOzaXjO8g7NA7q
 6p9KObUfaSVAVj/6zcNZiVtnecSqN/w4i6vNyi8mUDK0xWN5Tuq52me09TRATil3nSsoG8UHEQE
 hqGRllvF43OWzWO9xfB0tctImPMUQ8PGF9XyttN+hiPKCK09RjJFnOfjnK/pmR7fxRXNdXAMeoF
 XqWTdOji0TO3ty/i+jaOjYcMwFh1NgqzPlM02C1iZ885DKqbBAexKkZ71xQk54MF6VvaIAS99wk
 8K582Ch9Gz131uTW3jF8PitfWK6zw0BB/1RygRsip5A3IsPNifaeE2cgSfA96SpwCBqtBJ/UOqd
 gvrPckh3GWFYOCZ9FnEi7Gn7kXmS8f2W/Is1y7GzIrs3s5/bnMyiD9VUaeO0
X-Received: by 2002:a05:600c:4584:b0:4b8:4af2:88b3 with SMTP id
 5b1f17b1804b1-4bb88817aa2mr313743155e9.22.1795543554131; 
 Tue, 24 Nov 2026 10:05:54 -0800 (PST)
Received: from freepad.home ([2a01:e0a:1248:bd70:ee15:c1ae:fed0:c345])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ad6403fdbbsm21635935f8f.15.2026.11.24.10.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:05:53 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: vladimir.medvedkin@intel.com
Cc: dev@dpdk.org,
	rjarry@redhat.com,
	Maxime Leroy <maxime@leroys.fr>
Subject: [RFC 2/5] node: zero-initialize FIB config structs
Date: Tue, 24 Nov 2026 19:04:12 +0100
Message-ID: <20261124180415.1099828-3-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124180415.1099828-1-maxime@leroys.fr>
References: <20261124180415.1099828-1-maxime@leroys.fr>
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The FIB and FIB6 configurations are filled field by field, which
leaves any field added to struct rte_fib_conf or struct rte_fib6_conf
uninitialized. Zero-initialize them.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 lib/node/ip4_lookup_fib.c | 2 +-
 lib/node/ip6_lookup_fib.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/node/ip4_lookup_fib.c b/lib/node/ip4_lookup_fib.c
index 0857d889fc..8609d81b77 100644
--- a/lib/node/ip4_lookup_fib.c
+++ b/lib/node/ip4_lookup_fib.c
@@ -252,7 +252,7 @@ static int
 setup_fib(int socket)
 {
 	struct ip4_lookup_fib_node_main *nm = &ip4_lookup_fib_nm;
-	struct rte_fib_conf conf;
+	struct rte_fib_conf conf = { 0 };
 	char s[RTE_FIB_NAMESIZE];
 
 	/* One fib per socket */
diff --git a/lib/node/ip6_lookup_fib.c b/lib/node/ip6_lookup_fib.c
index 40c5c753df..1cd37ea457 100644
--- a/lib/node/ip6_lookup_fib.c
+++ b/lib/node/ip6_lookup_fib.c
@@ -244,7 +244,7 @@ static int
 setup_fib6(int socket)
 {
 	struct ip6_lookup_fib_node_main *nm = &ip6_lookup_fib_nm;
-	struct rte_fib6_conf conf;
+	struct rte_fib6_conf conf = { 0 };
 	char s[RTE_FIB6_NAMESIZE];
 
 	/* One fib6 per socket */
-- 
2.43.0

