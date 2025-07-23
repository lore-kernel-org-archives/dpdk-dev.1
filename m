Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A57C83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 13:33:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78B9540E34;
	Wed, 23 Jul 2025 15:33:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id CD36640E35
 for <dev@dpdk.org>; Wed, 23 Jul 2025 15:32:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753277579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8KWJzVPDV/8GkeopsIJwgu2HzHg8vK06iCww6PjeDik=;
 b=OsRMaLlzgiDmMpPIXatCBP87sHaWmJU7u2AJOChvR9Dj1PyZYim5Oj1ugmXEcwLDmc4cY0
 LeADSTaJIl3MHbiSLvRpbK4+sEvyX9rdD9FT98S8/2bICxpYRnP2R7RQ7DcJvSp/DGseNX
 AD2+K0peJZGeOCPsR+U7aICTZIs26pQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-f3ynMK1bPj66F5Yu7rC1_g-1; Wed,
 23 Jul 2025 09:32:52 -0400
X-MC-Unique: f3ynMK1bPj66F5Yu7rC1_g-1
X-Mimecast-MFC-AGG-ID: f3ynMK1bPj66F5Yu7rC1_g_1753277571
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28CA419560AE; Wed, 23 Jul 2025 13:32:51 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.51])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 597EE30001A4; Wed, 23 Jul 2025 13:32:48 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 John McNamara <john.mcnamara@intel.com>
Subject: [PATCH v5 08/22] hash: fix unaligned access in predictable RSS
Date: Wed, 23 Jul 2025 15:31:41 +0200
Message-ID: <20250723133157.159825-9-david.marchand@redhat.com>
In-Reply-To: <20250723133157.159825-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u-WPwa4ugOSwvwyZabe6nC_rF1FZzYakeYeefeugbFU_1753277571
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
Changes since v3:
- replaced memcpy() with use of unaligned_uint32_t type,

---
 lib/hash/rte_thash.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/hash/rte_thash.c b/lib/hash/rte_thash.c
index 6c662bf14f..0f9ed20d0d 100644
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
+	tmp = *(unaligned_uint32_t *)&ctx->hash_key[offset >> 3];
+	val = rte_be_to_cpu_32(tmp);
 	val >>= (TOEPLITZ_HASH_LEN - ((offset & (CHAR_BIT - 1)) +
 		ctx->reta_sz_log));
 
-- 
2.50.0

