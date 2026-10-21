Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EBA606A31A
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YBJ01kBw
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AB13406BC;
	Wed, 21 Oct 2026 12:30:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 74A9E40A70
 for <dev@dpdk.org>; Wed, 21 Oct 2026 12:30:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792578640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sBeX5lZlsimgjMHVrlallho4TaTisgFZBTxhNYrmoww=;
 b=YBJ01kBw01XNE4FwhG4G6aRNZJGvBP+t/2Fdc0puctLT6nx6Xg6OtAP6gDjGJt6kV6H7U3
 bJnq2pEDsWjfOL2BWVYGIA46fbaOVcojW9zmv4YP/FEwJkgtEtQ6wCAxqMt40wnEO9/FyO
 3smbDGCAxUg91jS2zYcL5l0IxKH8M3E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-2uoj_walPci6tGKF4IRCAw-1; Wed,
 21 Oct 2026 10:30:36 +0000
X-MC-Unique: 2uoj_walPci6tGKF4IRCAw-1
X-Mimecast-MFC-AGG-ID: 2uoj_walPci6tGKF4IRCAw_1792578635
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46D651955F7E; Wed, 21 Oct 2026 10:30:35 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 44F5E1800347; Wed, 21 Oct 2026 10:30:33 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	stable@dpdk.org
Subject: [PATCH v2 01/12] devtools: fix matching in doc check
Date: Wed, 21 Oct 2026 12:30:15 +0200
Message-ID: <20261021103027.2050351-2-david.marchand@redhat.com>
In-Reply-To: <20261021103027.2050351-1-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261021103027.2050351-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XCqDih1lke7YOFVXhIivSaZUtphQcpSiOq5H-DntgY0_1792578635
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The current user (rte_flow) of has_code_change pass what looks like
a regular expression, while -S matches exact strings.

Use -G.

Fixes: 947dff12bcf5 ("devtools: check flow API doc tables")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 devtools/check-doc-vs-code.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/devtools/check-doc-vs-code.sh b/devtools/check-doc-vs-code.sh
index c58c239c87..80d77907f0 100755
--- a/devtools/check-doc-vs-code.sh
+++ b/devtools/check-doc-vs-code.sh
@@ -28,7 +28,7 @@ changed_files()
 
 has_code_change() # <pattern>
 {
-	test -n "$(git log --format='%h' -S"$1" $trusted_commit..)"
+	test -n "$(git log --format='%h' -G"$1" $trusted_commit..)"
 }
 
 has_file_change() # <pattern>
-- 
2.54.0

