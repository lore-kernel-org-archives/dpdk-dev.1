Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7589C531FC
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Jul 2026 07:02:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9CB240297;
	Mon, 27 Jul 2026 09:02:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7DEED400D6
 for <dev@dpdk.org>; Mon, 27 Jul 2026 09:02:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785135739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pdlv0OAOX01ESInXRGTrb+2OtuuODJvhevHBLKkQz/k=;
 b=Nv5/oboMWWjkD+ncqAz0rymfdjUO6J99tyzfGW/8n157VuPgr41feDN334EiFgchGhV/n9
 /5oFtzdWK6AN5UEhixIBspfSNUjC0MK6Azs/5YspgZpoLKPB86obp1hKaHdMjv/JzvSm5h
 p5nEHjwUqoItn53VkHbWlPyFRwMGlpY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-59axQ7RIO0OJK5VdGosJsA-1; Mon,
 27 Jul 2026 03:02:17 -0400
X-MC-Unique: 59axQ7RIO0OJK5VdGosJsA-1
X-Mimecast-MFC-AGG-ID: 59axQ7RIO0OJK5VdGosJsA_1785135736
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FD911955DCD
 for <dev@dpdk.org>; Mon, 27 Jul 2026 07:02:16 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8CDFA42C for <dev@dpdk.org>; Mon, 27 Jul 2026 07:02:15 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Subject: [PATCH 1/2] eal: remove deprecated packed attribute
Date: Mon, 27 Jul 2026 09:02:08 +0200
Message-ID: <20260727070210.1281566-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v4dQYHIBidrGLvAf5bUeciUULoClgc564kSl60ev1Tw_1785135736
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

This attribute was replaced in v25.03 by the couple
__rte_packed_begin/__rte_packed_end for Windows support.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 doc/guides/rel_notes/release_26_11.rst |  1 +
 lib/eal/include/rte_common.h           | 13 -------------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..8fbbe50b16 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -70,6 +70,7 @@ Removed Items
 
 * Removed deprecated symbols:
 
+  * eal: ``__rte_packed``
   * fib: ``RTE_FIB6_IPV6_ADDR_SIZE``, ``RTE_FIB6_MAXDEPTH``
   * lpm: ``RTE_LPM6_IPV6_ADDR_SIZE``, ``RTE_LPM6_MAX_DEPTH``
   * net: ``RTE_IP_ICMP_ECHO_REPLY``, ``RTE_IP_ICMP_ECHO_REQUEST``
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 79d2a0ab93..f872d3eabb 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -131,19 +131,6 @@ typedef uint32_t unaligned_uint32_t;
 typedef uint16_t unaligned_uint16_t;
 #endif
 
-/**
- * @deprecated
- * @see __rte_packed_begin
- * @see __rte_packed_end
- *
- * Force a structure to be packed
- */
-#ifdef RTE_TOOLCHAIN_MSVC
-#define __rte_packed RTE_DEPRECATED(__rte_packed)
-#else
-#define __rte_packed (RTE_DEPRECATED(__rte_packed) __attribute__((__packed__)))
-#endif
-
 /**
  * Force a structure to be packed
  * Usage:
-- 
2.54.0

