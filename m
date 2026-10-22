Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55ED4606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dnOJbAlh
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B157F40A7F;
	Thu, 22 Oct 2026 19:45:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 62D974068A
 for <dev@dpdk.org>; Thu, 22 Oct 2026 19:45:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792691136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lEq1Tx7RKM5IjlNqxMJwL97xoEgH5OkQzijlyQSG2qg=;
 b=dnOJbAlhtrG0CkG5RmrXXJwA1gEQCbwYttDUQNUQ81nfPpAoLZeVLt1ZYw4ScwDRcHvHtB
 pVK61nYqD8wXcYqOudaY6etzKt+ZW12X8WkdxGvTJh4sMFrD78EzbQqSVOpuSMWrohT+21
 D/ljmJzDKyJ6HPxlo5xT82n1AFJwPGY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-ZFzwxsGHM8qG3w0660vV0A-1; Thu,
 22 Oct 2026 13:45:26 -0400
X-MC-Unique: ZFzwxsGHM8qG3w0660vV0A-1
X-Mimecast-MFC-AGG-ID: ZFzwxsGHM8qG3w0660vV0A_1792691104
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD5341954B12; Thu, 22 Oct 2026 17:45:03 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D2F203000735; Thu, 22 Oct 2026 17:45:01 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Shaiq Wani <shaiq.wani@intel.com>
Subject: [PATCH v3 02/13] doc: fix L2TPv2 and PPP matching support for ICE
Date: Thu, 22 Oct 2026 19:44:29 +0200
Message-ID: <20261022174447.412638-3-david.marchand@redhat.com>
In-Reply-To: <20261022174447.412638-1-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261022174447.412638-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WxBJuVlUWx-ibbWBIb1blNxIq_TyO0BZXWs4hgd08Vs_1792691104
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Those features were missed when adding the code.

Fixes: 733640dae75e ("net/ice: support L2TPv2 flow pattern matching")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 doc/guides/nics/features/ice.ini | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/guides/nics/features/ice.ini b/doc/guides/nics/features/ice.ini
index 22f98c8de2..68c7f48ff0 100644
--- a/doc/guides/nics/features/ice.ini
+++ b/doc/guides/nics/features/ice.ini
@@ -67,9 +67,11 @@ icmp6                = Y
 ipv4                 = Y
 ipv6                 = Y
 ipv6_frag_ext        = Y
+l2tpv2               = Y
 l2tpv3oip            = Y
 nvgre                = Y
 pfcp                 = Y
+ppp                  = Y
 pppoed               = Y
 pppoes               = Y
 pppoe_proto_id       = Y
-- 
2.54.0

