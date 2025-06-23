Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D3AC7115B
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 13:53:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47EB54069F;
	Mon, 23 Jun 2025 15:53:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6F7E540674
 for <dev@dpdk.org>; Mon, 23 Jun 2025 15:53:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750686811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m661c+oZMAJPvQqVQf0Kme0uhdVgj3mRY9OuAIZVJ5I=;
 b=UcKuqS6m25QfDOTS6h1qVl7hwKugRJntXyHJzVNViLKG1Wc5EALewiE+cMIWdejULTbRzB
 UPhq+iD4kO8NQx7RXzv3CIp4JDuN5hH+8VoeXcqeuJd7gIX0z7knAKSmlm1zvtFRCIX25D
 l42fPaRexs/dclXeatlpr2rFYpx84xc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-nObFVdFPPH-wdapup2oOgA-1; Mon,
 23 Jun 2025 09:53:30 -0400
X-MC-Unique: nObFVdFPPH-wdapup2oOgA-1
X-Mimecast-MFC-AGG-ID: nObFVdFPPH-wdapup2oOgA_1750686809
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22EEA19560AA; Mon, 23 Jun 2025 13:53:29 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.240])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 14120180035C; Mon, 23 Jun 2025 13:53:25 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 John McNamara <john.mcnamara@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v2 08/10] hash: fix unaligned access in predictable RSS
Date: Mon, 23 Jun 2025 15:52:38 +0200
Message-ID: <20250623135242.461965-9-david.marchand@redhat.com>
In-Reply-To: <20250623135242.461965-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250623135242.461965-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: miicGGgiA5fzY6z7KKUptPxOh-aFNsKyQuxjU2etZfM_1750686809
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

Caught by UBSan:

../lib/hash/rte_thash.c:421:8: runtime error: load of misaligned address
	0x0001816c2da3 for type 'uint32_t' (aka 'unsigned int'),
	which requires 4 byte alignment

Fixes: 28ebff11c2dc ("hash: add predictable RSS")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/hash/rte_thash.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/hash/rte_thash.c b/lib/hash/rte_thash.c
index 6c662bf14f..6d4dbea6d7 100644
--- a/lib/hash/rte_thash.c
+++ b/lib/hash/rte_thash.c
@@ -415,10 +415,10 @@ generate_subkey(struct rte_thash_ctx *ctx, struct thash_lfsr *lfsr,
 static inline uint32_t
 get_subvalue(struct rte_thash_ctx *ctx, uint32_t offset)
 {
-	uint32_t *tmp, val;
+	uint32_t tmp, val;
 
-	tmp = (uint32_t *)(&ctx->hash_key[offset >> 3]);
-	val = rte_be_to_cpu_32(*tmp);
+	memcpy(&tmp, &ctx->hash_key[offset >> 3], sizeof(tmp));
+	val = rte_be_to_cpu_32(tmp);
 	val >>= (TOEPLITZ_HASH_LEN - ((offset & (CHAR_BIT - 1)) +
 		ctx->reta_sz_log));
 
-- 
2.49.0

