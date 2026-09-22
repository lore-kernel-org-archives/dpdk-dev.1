Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4D2C982FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 09:40:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 279904275A;
	Tue, 22 Sep 2026 11:40:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1E74A410FC
 for <dev@dpdk.org>; Tue, 22 Sep 2026 11:40:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790070044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6el9nvipwoBaCS4yC20cw54L5nc2WyGsID29mv/mJ2Y=;
 b=WqdXH2g0J8bFfeCQefO4UfQO+LzJ7+W2hM67LBB3+Lr4FxyUtvKA5JXPEjh+pcGivTWtDt
 lMD5lbdcQpqqF3jR2mhBmUMX3Ff0Sknn4rl5AXmNqLsiuIUTMfHH8oz1OVTeYIb+d5uIl0
 s1uZROK5KnMNLOSQrOUQcUQRpXpvp5M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-TFYtgwuhOaCBWmewNmiZRA-1; Tue,
 22 Sep 2026 05:40:40 -0400
X-MC-Unique: TFYtgwuhOaCBWmewNmiZRA-1
X-Mimecast-MFC-AGG-ID: TFYtgwuhOaCBWmewNmiZRA_1790070038
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F4491802171; Tue, 22 Sep 2026 09:40:38 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 17EC2180036E; Tue, 22 Sep 2026 09:40:35 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 2/9] hash: fix GFNI stubs export
Date: Tue, 22 Sep 2026 11:40:18 +0200
Message-ID: <20260922094026.2636265-3-david.marchand@redhat.com>
In-Reply-To: <20260922094026.2636265-1-david.marchand@redhat.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260922094026.2636265-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -VKwhV0z-K8LTMwU2JhKmnEUHIbiknCrY7V6KI_HWtQ_1790070038
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

Internal symbols *can not* be called as part of public ABI.
The GFNI stubs must be exported so that an application may call them
through the (inlined) GFNI API without requiring ALLOW_INTERNAL_API.

Fixes: 944a03a5cfc1 ("hash: fix MSVC link on GFNI stubs")

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/hash/rte_thash_gfni.c | 4 ++--
 lib/hash/rte_thash_gfni.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/hash/rte_thash_gfni.c b/lib/hash/rte_thash_gfni.c
index 2003c7b3db..ae55f7f711 100644
--- a/lib/hash/rte_thash_gfni.c
+++ b/lib/hash/rte_thash_gfni.c
@@ -13,7 +13,7 @@ RTE_LOG_REGISTER_SUFFIX(hash_gfni_logtype, gfni, INFO);
 #define HASH_LOG(level, ...) \
 	RTE_LOG_LINE(level, HASH, "" __VA_ARGS__)
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_thash_gfni_stub)
+RTE_EXPORT_SYMBOL(rte_thash_gfni_stub)
 uint32_t
 rte_thash_gfni_stub(const uint64_t *mtrx __rte_unused,
 	const uint8_t *key __rte_unused, int len __rte_unused)
@@ -29,7 +29,7 @@ rte_thash_gfni_stub(const uint64_t *mtrx __rte_unused,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_thash_gfni_bulk_stub)
+RTE_EXPORT_SYMBOL(rte_thash_gfni_bulk_stub)
 void
 rte_thash_gfni_bulk_stub(const uint64_t *mtrx __rte_unused,
 	int len __rte_unused, uint8_t *tuple[] __rte_unused,
diff --git a/lib/hash/rte_thash_gfni.h b/lib/hash/rte_thash_gfni.h
index e82378933c..8a72fa9ec6 100644
--- a/lib/hash/rte_thash_gfni.h
+++ b/lib/hash/rte_thash_gfni.h
@@ -22,11 +22,9 @@ extern "C" {
  * @internal
  * Stubs only used when GFNI is not available.
  */
-__rte_internal
 uint32_t
 rte_thash_gfni_stub(const uint64_t *mtrx, const uint8_t *key, int len);
 
-__rte_internal
 void
 rte_thash_gfni_bulk_stub(const uint64_t *mtrx, int len, uint8_t *tuple[],
 	uint32_t val[], uint32_t num);
-- 
2.54.0

