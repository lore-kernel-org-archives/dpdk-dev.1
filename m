Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD497606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h8+J1mX0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F62640264;
	Thu, 22 Oct 2026 19:45:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0FB084003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 19:45:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792691102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o3etFdRIJ71DblTmp8Xa004RPTAsg0o3fwN81WL3960=;
 b=h8+J1mX0le36hIhgweCkQUOGjmZJO1mpTdBNLKyF4gDEWjNd9jIsVgzboso8GWnZxexr0m
 1Sijer3eoeK+z3n44OkwbRg86aLkzuvGHici1Pfw7zIT/E6JYla4tLAeVCz/T3YYQwyBMK
 7qkdXBZt/CiPeO4GvkE2p+mbgereLUw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-Nxzkk19lPASBVHX8IVl6uw-1; Thu,
 22 Oct 2026 13:45:00 -0400
X-MC-Unique: Nxzkk19lPASBVHX8IVl6uw-1
X-Mimecast-MFC-AGG-ID: Nxzkk19lPASBVHX8IVl6uw_1792691099
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 651E21954213; Thu, 22 Oct 2026 17:44:59 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1A3C47E0; Thu, 22 Oct 2026 17:44:57 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	stable@dpdk.org
Subject: [PATCH v3 01/13] devtools: fix matching in doc check
Date: Thu, 22 Oct 2026 19:44:28 +0200
Message-ID: <20261022174447.412638-2-david.marchand@redhat.com>
In-Reply-To: <20261022174447.412638-1-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261022174447.412638-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 863xSjonyuupwaeMzzJHfHRSgh5d5b2y7bJ_qPCOx6Y_1792691099
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

The current user (rte_flow) of has_code_change pass what looks like
a regular expression, while -S matches exact strings.

Use -G.

Fixes: 947dff12bcf5 ("devtools: check flow API doc tables")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Thomas Monjalon <thomas@monjalon.net>
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

