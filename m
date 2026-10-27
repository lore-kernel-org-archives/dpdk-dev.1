Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BA7606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K6bmTQJk
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A05A402E0;
	Tue, 27 Oct 2026 15:54:30 +0100 (CET)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTPS id 7076A400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 15:54:28 +0100 (CET)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-93efc0452b5so276669085a.0
 for <dev@dpdk.org>; Tue, 27 Oct 2026 07:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793112867; x=1793717667; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I3NldxUGgLy3GtQUO8VfUmfmKF3tqYiAXrQ6shKBTkM=;
 b=K6bmTQJkuuAFD79dmN7avCHHUOBYF4xH5TVQ57tSKkYNQ09ikHdFBZp4w4wVkZyanG
 JB10vvfqkfXE7qL0T98hTTi3FqcPEab+oIpVSER9GNWoWtO2ABRDjZAhGRGuK3SPi3+R
 E5gfD/XxfJ8sGM3A3UJS7tZE6PaDWuDbouvb+w/B32UQLZ355GhNG8Q8ifgItJXJANzO
 C/eoEq5YqyhIFTvyxGSdrE0vGzei6O8uHAyocDttuQ9Sv4Lglt22ZHYfgsVk0C5mZUkp
 VkZTtFVFdB2hpWktrYug2rppU8IoBm71d4BzowaCqQJWkoANZXQxvss9Movp+uSEx3EP
 BCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793112867; x=1793717667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I3NldxUGgLy3GtQUO8VfUmfmKF3tqYiAXrQ6shKBTkM=;
 b=yPSqZrspm5eiatJzel/0jJYKlZjcljGOqLK3HGmzqc05z3/o3vBbspFTSEfNb37xED
 WAbTfFlJDKzdovO9zyGXy0he+LxQlHgFa+U4yh59AUY6WiZBp1cu51oB8O1WJfi7MQy1
 pG3l4mDwNHQgaRheRX8eFVeYiwc6ULnZOJsoGylErvOkJLMd7IsoT1zW1vppo6x5+hlL
 Ozi62Ys8+Ti+zzMnhKD7ukj8/gZqUqp2u/Uf65VhhEiDuQEFCx7qjC09MPqki6LPVj6p
 /8JlKtD8BI36EHFIJpY58ecISEskJdfQMlOdy++R2uA3TJHhDGB7e7oL7jc/dUQdsDMv
 dgOg==
X-Gm-Message-State: AFq9FYKMlK2e7KktDXAOjwloqVAQzRb7+5fuDdVZlIn97SvXEvEyLARq
 E7C86ygMec9er+raw7oZCm8nl48TA55N/SBKUHPkb8wRCQzjnexk5ULdrop+Jg==
X-Gm-Gg: AYBFou06UeSaPejhFSOeg1QpQzV849DFE4KQn/NotlexZo0oUxAfuLsxqckugWOx+A8
 in1IuNJmtn+Q8G8ljJH5hYM0u7YuHoGgdfAA3l9OeOV3rKa/OcA9uuZapqhKEBBTGubOWEQcBQ8
 M+TxVKbZoDpKDt3h9JKeN7IAp7KYiv/imuQ+cHYl53yIt1x1m8+XiyS91Ws+6My08UGxFKfWRU0
 4M62D/XYD4tsRDw2lslMJoXHLkVB2d7NSelW1fwqceYpFXCRdxPdvopDqixegySB2erCF7kNVec
 r0b+06r2s3FdSQI9FGoGJv+7u559KVLTIBdTw98ATD2k9Jhx8qw7hlHQH6trb1Pryqi/RhB6ec3
 JB38x3mLQVigayE/0+1cXestZ7d/wMDDpQG5dnHdIe2C/+5+78UNBVYTlZqCVQWSJ7hyxnTLGIP
 hkQKXQegH3vijkFjw+TBX501zS/z7w+fbmCcXLuiohfaHLjjgCub59JQ/Gn5OwCPovIowa2oTmo
 BJipA5V7q5VX4X3TkYgKKjPk4UMyoNHpgDJYNUVw3qkcBGdgYeFpEtMoa3/BpecALDdUS9blP0s
 jJ8iwY0KoXiNQyo5f0Bj0hNW4HCXaxaGR45oxZZsKReK9IfAFIviS88gQEtSTnospMZCAwnx2q1
 VfBWmAszY2Mqvx4ip/yNkUj5fWcE=
X-Received: by 2002:a05:620a:25c7:b0:93c:ba88:cd65 with SMTP id
 af79cd13be357-940ef7d30a8mr1456869385a.7.1793112867286; 
 Tue, 27 Oct 2026 07:54:27 -0700 (PDT)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-940f0789b18sm996910385a.29.2026.10.27.07.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:54:26 -0700 (PDT)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com, Robert Sanford <rsanford@akamai.com>,
 stable@dpdk.org
Subject: [PATCH v2 1/5] rib: fix undefined behavior in bit test
Date: Tue, 27 Oct 2026 10:54:01 -0400
Message-Id: <20261027145405.3454251-2-rsanford2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027145405.3454251-1-rsanford2@gmail.com>
References: <20261027001423.3028072-1-rsanford2@gmail.com>
 <20261027145405.3454251-1-rsanford2@gmail.com>
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

The tree walk in rte_rib.c tests the bit below a node's depth with
1 << (31 - depth). For a node at depth 0, which exists for a default
route or for a common parent of routes in both halves of the address
space, that is 1 << 31 on a signed int, which is undefined behavior.
UBSan reports:

  rte_rib.c:82:18: runtime error: left shift of 1 by 31 places
  cannot be represented in type 'int'

and the same at lines 311 and 343. No existing unit test adds a
depth-0 route, so this was not caught before. The new test/fib
wraparound test in this series does.

Use an unsigned constant in all four bit tests. The shift count is
between 0 and 31 at each of them.

Fixes: 5a5793a5ffa2 ("rib: add RIB library")
Cc: stable@dpdk.org

Signed-off-by: Robert Sanford <rsanford@akamai.com>
---
v2: new patch in this series.

 lib/rib/rte_rib.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/rib/rte_rib.c b/lib/rib/rte_rib.c
index 046db131ca..43d5ab1498 100644
--- a/lib/rib/rte_rib.c
+++ b/lib/rib/rte_rib.c
@@ -79,7 +79,7 @@ get_nxt_node(struct rte_rib_node *node, uint32_t ip)
 {
 	if (node->depth == RIB_MAXDEPTH)
 		return NULL;
-	return (ip & (1 << (31 - node->depth))) ? node->right : node->left;
+	return (ip & (1U << (31 - node->depth))) ? node->right : node->left;
 }
 
 static struct rte_rib_node *
@@ -308,7 +308,7 @@ rte_rib_insert(struct rte_rib *rib, uint32_t ip, uint8_t depth)
 		if ((d >= depth) || !is_covered(ip, (*tmp)->ip, d))
 			break;
 		prev = *tmp;
-		tmp = (ip & (1 << (31 - d))) ? &(*tmp)->right : &(*tmp)->left;
+		tmp = (ip & (1U << (31 - d))) ? &(*tmp)->right : &(*tmp)->left;
 	}
 	/* closest node found, new_node should be inserted in the middle */
 	common_depth = RTE_MIN(depth, (*tmp)->depth);
@@ -319,7 +319,7 @@ rte_rib_insert(struct rte_rib *rib, uint32_t ip, uint8_t depth)
 	common_prefix = ip & rte_rib_depth_to_mask(common_depth);
 	if ((common_prefix == ip) && (common_depth == depth)) {
 		/* insert as a parent */
-		if ((*tmp)->ip & (1 << (31 - depth)))
+		if ((*tmp)->ip & (1U << (31 - depth)))
 			new_node->right = *tmp;
 		else
 			new_node->left = *tmp;
@@ -340,7 +340,7 @@ rte_rib_insert(struct rte_rib *rib, uint32_t ip, uint8_t depth)
 		common_node->parent = (*tmp)->parent;
 		new_node->parent = common_node;
 		(*tmp)->parent = common_node;
-		if ((new_node->ip & (1 << (31 - common_depth))) == 0) {
+		if ((new_node->ip & (1U << (31 - common_depth))) == 0) {
 			common_node->left = new_node;
 			common_node->right = *tmp;
 		} else {
-- 
2.34.1

