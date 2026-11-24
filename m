Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131F4606A336
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Nov 2026 18:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ncQuryZy
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02AD240616;
	Tue, 24 Nov 2026 19:03:28 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by mails.dpdk.org (Postfix) with ESMTPS id 58C464027A
 for <dev@dpdk.org>; Tue, 24 Nov 2026 19:03:26 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb6ba3b244so50148275e9.3
 for <dev@dpdk.org>; Tue, 24 Nov 2026 10:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795543406; x=1796148206; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LxjDHRBhWLkOKS03eQvCGoH4SPmvfCJpEkoDLZfsOw8=;
 b=ncQuryZyfwH/k4RsDAMqlotb6Azaj0I2h+eAHFMYTxTWe37NVOAGYGyJCCtAwyLLn0
 wzq4IEpeGP6VhsGHBcebCtqeRfHDkeVuciLCMFl2wdlo2YKXIBP8swnE9eb+IePFi35h
 2umCIzf8A41T90aj429dSQr9IaIcZVzZL3nZKrIpgCEtnkGIdbXUyVEUUAhbdtmCa8Sk
 cQa+WR1Un12NrNoHpdztYif0v3VSyFmso18/W+HeZNGccrVUyeZriFZUsx6BbnAHrITT
 40GiFqiNNkjn2FDcGZ4CdJQk0UrJJKvA2g8qzsdrvQEDrQkJvrLz5HpPr17F+PZO/eyq
 0vtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795543406; x=1796148206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LxjDHRBhWLkOKS03eQvCGoH4SPmvfCJpEkoDLZfsOw8=;
 b=ENkFDl6z81EYK0w/1nMwc6x9m/mYjknMS0Nw9NZ1+/ZtI4mOpZremPm6rp6C8BznOx
 wka8ZVOB8pn9jBEvOy4mhic4QWq4yqDahlt1e//M74DHGLVUzT8u5wrlFU+TIGhkYdzK
 1xYHw0Y8uOJFaHl07MyDIWZLoqIpqsVgrPfAwb474QHwpoyafRvseGPaJc351hIzpsM5
 iPO0Ni3RAZvRUiu3CdgSVYCtVOfX4TqWAL+ikv2RG2Qmer1yP0rXYsK5rhP9xIoU4seS
 RQmrUcxLAScLYE9Mkx5ETK06kSWMZu07FqHsjJ4bPGJd3NEGV6U3Gsrx84ZBq6mgSPzm
 VpoQ==
X-Gm-Message-State: APuU4Z9xfhLO/O3CfC+KNkutWCYJehnEfhhBKm20h5dD94EECR7rjc9H
 FEQ7018xp/Mkpm2P2ey+hKa1koSDYzYMzND4X1qj/FsMI/44dHChlf0z
X-Gm-Gg: AZFdTZccPPp7R1My8J8WKUqw+JUXcV7nTE36uXfKMfE99CAWHCKTpur/LBYgBUKeS1n
 HP793EWJXdiq0ZJ8tIsMtiQOAcW0RGAJZLFWmb3l+kSr/H4YdF5TXT6wXbTXKK6Xb/PLRVhpU3M
 ptdApMKNfxboxPNRVstfrf55WTPY0P7fb41udNLqIo6E5SDTWl8WCqcXJ1XMJHE4MuHXjHZgxes
 Ue7lIYnngIdGn8H4LrpzZ8KTuSS9k2rwiobeXWCgSwGQfxlY5/6wCVMB3ikdM2i3kqWsERmcN56
 1KwvZnlaL0djDOaILgB/61y+IaPlpocDgxy+Vm6Rboy7oyJfGTVG9dKUfHN5nyB4+Y4Djtt9NtY
 tgUpofCuYloX5/1/t8lYpSYv8xE0VrUGTMQkaCvrmy/n02mHlUFQAiSbnpst3Phif29hhsRglo0
 5kEtzp+TvNXLwUvSvKP5Fi0N37QmO3boWiJ1URfaaFTCeqTzGm2w7IsXZF6BnzX0w+HevyYgVN2
 LI9BvOAgbOUUforqOiyFuffWlLDe7z/3PrWFb8BkDGwjafurCeuuoTSPokCi01pO/dKc3cGTKEq
 eb+eytMUs1P47W8roRYerPaSWFPt0Qit+e1J7DRKfiDEuStd5+Kg+/jtuQc+
X-Received: by 2002:a05:600c:a08e:b0:4bb:647d:dabe with SMTP id
 5b1f17b1804b1-4bb887c3afamr347245255e9.3.1795543405876; 
 Tue, 24 Nov 2026 10:03:25 -0800 (PST)
Received: from freepad.home ([2a01:e0a:1248:bd70:ee15:c1ae:fed0:c345])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9846sm534996475e9.11.2026.11.24.10.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:03:25 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: vladimir.medvedkin@intel.com
Cc: dev@dpdk.org,
	rjarry@redhat.com,
	Maxime Leroy <maxime@leroys.fr>
Subject: [RFC v2 03/13] node: zero-initialize FIB config structs
Date: Tue, 24 Nov 2026 19:02:39 +0100
Message-ID: <20261124180249.1099506-4-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124180249.1099506-1-maxime@leroys.fr>
References: <20260331214117.142495-1-maxime@leroys.fr>
 <20261124180249.1099506-1-maxime@leroys.fr>
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

