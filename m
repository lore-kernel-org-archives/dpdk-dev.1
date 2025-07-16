Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92204C83F1B
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 13:05:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D6CB40A77;
	Wed, 16 Jul 2025 15:04:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 33E3540A77
 for <dev@dpdk.org>; Wed, 16 Jul 2025 15:04:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752671041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Edzh//s9MboZabojsKK8VBvTHmzDs+6fwg+TkXvMarw=;
 b=T1mE3fUwpSokXBIxW6ih/yQ2+H0/aaJ5Mr+gSXbS7MsFNJE3MLDSJ+k5GfVQ7LQA4HeaMa
 sgKsjIzadsC6xTGJVsag7Uya+Di97H3we2KXYXNaOYFpAp2wvi+abPflw/oDr6zfmRSGbO
 Zslmu8LqrWdYH1WzT5ZaJjKC//CWw64=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-071JVQT0Oz6GX6nKdMJfoQ-1; Wed,
 16 Jul 2025 09:03:58 -0400
X-MC-Unique: 071JVQT0Oz6GX6nKdMJfoQ-1
X-Mimecast-MFC-AGG-ID: 071JVQT0Oz6GX6nKdMJfoQ_1752671036
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB44919560AA; Wed, 16 Jul 2025 13:03:56 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.235])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 911121954213; Wed, 16 Jul 2025 13:03:55 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 19/22] rib6: fix some highest bits handling
Date: Wed, 16 Jul 2025 15:02:06 +0200
Message-ID: <20250716130212.1736407-20-david.marchand@redhat.com>
In-Reply-To: <20250716130212.1736407-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250716130212.1736407-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4jCjEehWV_V0BursdTRMU8oI-3vkY1BMWE6a3VNDikA_1752671036
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

Without an explicit type, ip_xor gets promoted to a int.

../lib/rib/rte_rib6.c:348:26: runtime error:
	left shift of 130 by 24 places cannot be represented in type 'int'

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/rib/rte_rib6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/rib/rte_rib6.c b/lib/rib/rte_rib6.c
index ded5fd044f..ec8ff68e87 100644
--- a/lib/rib/rte_rib6.c
+++ b/lib/rib/rte_rib6.c
@@ -352,7 +352,7 @@ rte_rib6_insert(struct rte_rib6 *rib,
 		if (ip_xor == 0)
 			d += 8;
 		else {
-			d += rte_clz32(ip_xor << 24);
+			d += rte_clz32((uint32_t)ip_xor << 24);
 			break;
 		}
 	}
-- 
2.50.0

