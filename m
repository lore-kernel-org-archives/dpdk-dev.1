Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26838C83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 13:05:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 325A14067B;
	Wed, 16 Jul 2025 15:03:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E190A40666
 for <dev@dpdk.org>; Wed, 16 Jul 2025 15:03:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752671034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lv3AEquNYT5usNguIYydWaaV9dT1FuEa7wtbgr8QbfI=;
 b=B471mPjpWXwHdww9i2qroayqlkPaTV0rpgYrCvXrBBAqmsXTQg2rnFFPFDjeb/nMKrwhi/
 zis9qH1PwzGJqGEuhnYssI4VzGQUME+qjWm9TRmn82GAHp+/ZmhCrvzVBrrAmJiUpur/+a
 OSD/q62ZgfHzB4yUkJ3Oo6mWDhYDz3w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-HPAraOUQMLW78h8WL3D1mg-1; Wed,
 16 Jul 2025 09:03:53 -0400
X-MC-Unique: HPAraOUQMLW78h8WL3D1mg-1
X-Mimecast-MFC-AGG-ID: HPAraOUQMLW78h8WL3D1mg_1752671032
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93FF218002A1
 for <dev@dpdk.org>; Wed, 16 Jul 2025 13:03:52 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.235])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A87F4180049D
 for <dev@dpdk.org>; Wed, 16 Jul 2025 13:03:51 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Subject: [PATCH v4 18/22] net: fix IPv4 macro with highest bit
Date: Wed, 16 Jul 2025 15:02:05 +0200
Message-ID: <20250716130212.1736407-19-david.marchand@redhat.com>
In-Reply-To: <20250716130212.1736407-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250716130212.1736407-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l8CpQvmzYmjXUk9uxkbZfpCD9DcfoKkJxs25HNWKoOU_1752671032
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

Without an explicit type, all parameters of this macro are considered as
a signed integer.

../app/test/test_fib.c:270:20: runtime error: left shift of
	128 by 24 places cannot be represented in type 'int'
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
	../app/test/test_fib.c:270:20 in

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/net/rte_ip4.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/net/rte_ip4.h b/lib/net/rte_ip4.h
index d4b38c513c..822a660cfb 100644
--- a/lib/net/rte_ip4.h
+++ b/lib/net/rte_ip4.h
@@ -65,10 +65,8 @@ struct __rte_aligned(2) __rte_packed_begin rte_ipv4_hdr {
 } __rte_packed_end;
 
 /** Create IPv4 address */
-#define RTE_IPV4(a, b, c, d) ((uint32_t)(((a) & 0xff) << 24) | \
-					   (((b) & 0xff) << 16) | \
-					   (((c) & 0xff) << 8)  | \
-					   ((d) & 0xff))
+#define RTE_IPV4(a, b, c, d) (((uint32_t)((a) & 0xff) << 24) | ((uint32_t)((b) & 0xff) << 16) | \
+	((uint32_t)((c) & 0xff) << 8) | ((uint32_t)((d) & 0xff)))
 
 /** Maximal IPv4 packet length (including a header) */
 #define RTE_IPV4_MAX_PKT_LEN        65535
-- 
2.50.0

