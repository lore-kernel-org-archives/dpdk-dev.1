Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D4C606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jXDFBinS
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6AC440288;
	Fri, 30 Oct 2026 17:20:13 +0100 (CET)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by mails.dpdk.org (Postfix) with ESMTPS id C253F40285
 for <dev@dpdk.org>; Fri, 30 Oct 2026 17:20:12 +0100 (CET)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6b4bd3d98bfso1020130a12.1
 for <dev@dpdk.org>; Fri, 30 Oct 2026 09:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793377212; x=1793982012; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4YMHbm+YwF1KwEJn/pawA2g/uwpQM7t4z5vjhX2M2ZM=;
 b=jXDFBinSbpScC90SIdpYSDGdpwrj98i6HYm8UY18VvQXS4blt1h9Xtn+h3EEVeReX2
 rXPvf3XPkIEj8YKspuipVb1O4s8aIo/Ay4Z4Cfp3NhCZn3aStZZWxVXC5FrEuqzwd4WL
 SNl10kqAQ/wZqG75XV+dAT5BsgYED1t5Du/Zp2maOgXnIwXMcehgSoUYjT1YSsJSHQrn
 LIvSxy7t5AmQnmDGpJ16Sopfl+DeGB6zeEJIkvwNY/g4hXPdrbSKjWuVY1E6rGhMGgP0
 GAjGRvsvm6ueHHcPgDAlLVDxh8tQVgKC1DZptIBb5VJ/LzneG/qS6Nz2Qo5N31HxkoYJ
 QnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793377212; x=1793982012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4YMHbm+YwF1KwEJn/pawA2g/uwpQM7t4z5vjhX2M2ZM=;
 b=Ojq+ntlvdcot//go2nWUml3/y+Ivfh+B8oPamGpyFjotZdtdfLdGdTSOlCWyQ2RWMw
 8gSuJq5aMphkfB7dSeCG6yojxAbvf1jbxJAmFE7wKC4PsU+BYyd306CD0a477SdGT6cO
 91hUWP7+OdoP061pb+F4VBOwpOF+hwj9cuTsSbJ3G5SQPbNzOMjfx8j7bPwXUZRZ+Is5
 aqLC92RIHWhn2s9g4ETv1b0ObmvCkGkaXcBYltKiCWRkklzEcnAQmAid48O5m5UK8HyO
 ywtE/0fNH8cXgxpDayKvrIDRW8dHnKf0lbk6LeTaGZL+p6+yPjhhuCGjfbrd/e3tIZgZ
 B09Q==
X-Gm-Message-State: AFq9FYLiRojZCJHk1q+L9DFq9nREbJv0YIazr/UlqcpuV4BVbU5YmTZG
 KYOPMQAXfiu3dgAiZqys3sflcVd7TZeJlRUtDgHGEGY95G90krY2i7qVBFtCkw==
X-Gm-Gg: AYBFou2lxlJZKJFKXDjgJdAqXyM/vuOKkJZJgaWymcHL8No5/0XqEfC8RqlVA64tWXe
 xGXCq9Icir5KLVQluevSQtfmPjmMYUON+xCqr3gOWqJF2RY7LIzBLDlOde28WV0urr4ZalYEQll
 aeKzoJfw9TTgqR18Qj25OOYUgbCRaWCJD8BAZYhhx6j4WVnTc7POBiZ4zdn+5tMWiZF2QV9SKz7
 Cd7RvP9vR8EOfMWcYGYDutUipqRdmf8trb0kA+nXgkrCcpi1gizCh/ZwB6sxT+GKjV1Fu1PHLuX
 GkcHu9e2IUQP0u1CB/SURYrA1ACAlhH3q1exRrFkdhGERqzNQwDSDwv1CPUWjrOGxo38Cyv2EwS
 dTCjrrL2twkeNHiIeWs5gliKJdu21Yw2x9KqH4ouLBrb5TR26zTDTnIXPT2UA7NalSV/74SLJIa
 yAvBc/b6p4PhUbzDkdVIL7JTHH65pSMDj8I4vDRGATFDjbY3neleu2avlFn37M+HrDyOKRT8+CY
 Nv8RG34JJhCLaFyKQXCeZXcRk34ZvbZAaW3XNnmw0ZdCSLUUicGhTHuiS1oSR23CekWaiY0VKXE
 M1x/wEdEmt1LfMuJ5L9KngQb0ew5nZ/ZLmISuoFlsGN8JXoviOzuLvkBcU55DQE9YGQVB12rKxQ
 ysLrO2gGfSAg9OBS/vbzQ2+3vXOKrQKknni9p/KpGFngaAe5RLxDqjJ/rlL6uCOsfJBMtvhwVh7
 c7
X-Received: by 2002:a17:906:9fc7:b0:c24:6985:d7a1 with SMTP id
 a640c23a62f3a-c4ca793bcf4mr252962066b.7.1793377211954; 
 Fri, 30 Oct 2026 09:20:11 -0700 (PDT)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabe0f504sm84565166b.36.2026.10.30.09.20.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 09:20:10 -0700 (PDT)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com,
	Robert Sanford <rsanford@akamai.com>
Subject: [PATCH v1] rib: reduce node mempool memory footprint
Date: Fri, 30 Oct 2026 12:19:26 -0400
Message-Id: <20261030161926.1185112-1-rsanford2@gmail.com>
X-Mailer: git-send-email 2.34.1
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Robert Sanford <rsanford@akamai.com>

RIB nodes are allocated from a mempool created with no flags, so each
object is cache-line aligned and padded for memory-channel spreading.
On x86-64, an object takes 192 bytes for a 40-byte rte_rib_node or a
56-byte rte_rib6_node. Nodes are small and only accessed by the CPU,
so the padding is wasted. The whole pool is reserved up front, and
rte_fib and rte_fib6 size it at twice max_routes nodes.

Create the node pools with RTE_MEMPOOL_F_NO_CACHE_ALIGN,
RTE_MEMPOOL_F_NO_SPREAD and RTE_MEMPOOL_F_NO_IOVA_CONTIG.
RTE_MEMPOOL_F_NO_SPREAD is implied by RTE_MEMPOOL_F_NO_CACHE_ALIGN,
but is passed explicitly to document the intent. Nodes remain 8-byte
aligned, which is all the node structures need. The extension area
returned by rte_rib_get_ext() and rte_rib6_get_ext() was only 8-byte
aligned before as well.

With 2M nodes (1M routes), the pool shrinks from 390 MiB to 128 MiB
for IPv4 and to 160 MiB for IPv6. On an AMD EPYC 7643 with 1 GiB
hugepages, fib_perf_autotest (about 1M IPv4 routes) shows average add
and delete times 13 and 29 percent lower. Lookup times, and the add
and delete times in fib6_perf_autotest, which uses 1000 routes, are
unchanged.

Signed-off-by: Robert Sanford <rsanford@akamai.com>
---
 lib/rib/rte_rib.c  | 10 +++++++++-
 lib/rib/rte_rib6.c | 10 +++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/lib/rib/rte_rib.c b/lib/rib/rte_rib.c
index 046db131ca..2ba46393ed 100644
--- a/lib/rib/rte_rib.c
+++ b/lib/rib/rte_rib.c
@@ -425,9 +425,17 @@ rte_rib_create(const char *name, int socket_id, const struct rte_rib_conf *conf)
 	}
 
 	snprintf(mem_name, sizeof(mem_name), "MP_%s", name);
+	/*
+	 * Nodes are small, CPU-only objects: skip cache-line alignment and
+	 * memory-channel spreading, which otherwise grow each object well
+	 * beyond sizeof(struct rte_rib_node), and IOVA contiguity, which
+	 * only matters for device access.
+	 */
 	node_pool = rte_mempool_create(mem_name, conf->max_nodes,
 		sizeof(struct rte_rib_node) + conf->ext_sz, 0, 0,
-		NULL, NULL, NULL, NULL, socket_id, 0);
+		NULL, NULL, NULL, NULL, socket_id,
+		RTE_MEMPOOL_F_NO_SPREAD | RTE_MEMPOOL_F_NO_CACHE_ALIGN |
+		RTE_MEMPOOL_F_NO_IOVA_CONTIG);
 
 	if (node_pool == NULL) {
 		RIB_LOG(ERR,
diff --git a/lib/rib/rte_rib6.c b/lib/rib/rte_rib6.c
index 918ddbdfd3..808aac79ce 100644
--- a/lib/rib/rte_rib6.c
+++ b/lib/rib/rte_rib6.c
@@ -488,9 +488,17 @@ rte_rib6_create(const char *name, int socket_id,
 	}
 
 	snprintf(mem_name, sizeof(mem_name), "MP_%s", name);
+	/*
+	 * Nodes are small, CPU-only objects: skip cache-line alignment and
+	 * memory-channel spreading, which otherwise grow each object well
+	 * beyond sizeof(struct rte_rib6_node), and IOVA contiguity, which
+	 * only matters for device access.
+	 */
 	node_pool = rte_mempool_create(mem_name, conf->max_nodes,
 		sizeof(struct rte_rib6_node) + conf->ext_sz, 0, 0,
-		NULL, NULL, NULL, NULL, socket_id, 0);
+		NULL, NULL, NULL, NULL, socket_id,
+		RTE_MEMPOOL_F_NO_SPREAD | RTE_MEMPOOL_F_NO_CACHE_ALIGN |
+		RTE_MEMPOOL_F_NO_IOVA_CONTIG);
 
 	if (node_pool == NULL) {
 		RIB_LOG(ERR,
-- 
2.34.1

