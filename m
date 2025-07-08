Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124FCC8303C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 12:30:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68E9940A6E;
	Tue,  8 Jul 2025 14:30:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 59B2A406BB
 for <dev@dpdk.org>; Tue,  8 Jul 2025 14:30:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751977826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5t9yploWbX/jcIoaytNm+uJ78DSsjQIRz3Sg8E5Iaik=;
 b=NEdLDoHHvHoTO+D1grmzlpR8fFmDt3OK0uduuD5rRfoQkvucoHlvTsjn14x7HIUguXTP/4
 4+9wKR+XT0PrHjZoIPU10LpexUi0O3Zdb77AHtKeb8ym+bIE6X/ZrTEvEsFvqm8XCD7OTa
 5PC3wB/XeHI941brA5EnWsl76QPhEIQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487-3gg0rtClNLO3epfZAOncmA-1; Tue,
 08 Jul 2025 08:30:20 -0400
X-MC-Unique: 3gg0rtClNLO3epfZAOncmA-1
X-Mimecast-MFC-AGG-ID: 3gg0rtClNLO3epfZAOncmA_1751977819
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 395FC18002ED; Tue,  8 Jul 2025 12:30:19 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.95])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6600E18002B5; Tue,  8 Jul 2025 12:30:11 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 John McNamara <john.mcnamara@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v3 08/18] hash: fix unaligned access in predictable RSS
Date: Tue,  8 Jul 2025 14:28:12 +0200
Message-ID: <20250708122823.3406288-9-david.marchand@redhat.com>
In-Reply-To: <20250708122823.3406288-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250708122823.3406288-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qnnMslbc-tqJ-l2RF5Awc3a9TYnryd26Sc4eWhjQGsQ_1751977819
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
2.50.0

