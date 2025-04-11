Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4221C369A2
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 07:19:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1230D40696;
	Fri, 11 Apr 2025 09:19:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 69D1C40285
 for <dev@dpdk.org>; Fri, 11 Apr 2025 09:19:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744355950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JnzFKMHTmUq2OOQKE1BiKQbJFC7J3GW/5chaNqUjP5g=;
 b=Nkd3FkzZLSgOPDBquOqjho8xZtsod8s4nm9cNC92/3HYPH3SEik+siY/bMR47MOvLo0KjQ
 vCKSzkRbW72KV4g4Vj4pMDCucSvfhVQrrhnAEmAt+VGnTJeK6VoDiDu8tsqL5dHuy281O4
 VGryxgKiq9LN1HUAGh9zFsSNSR3U6Rw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-MrsR9GHpNLi30h3i4eZxCA-1; Fri,
 11 Apr 2025 03:19:06 -0400
X-MC-Unique: MrsR9GHpNLi30h3i4eZxCA-1
X-Mimecast-MFC-AGG-ID: MrsR9GHpNLi30h3i4eZxCA_1744355945
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05B9A1800262; Fri, 11 Apr 2025 07:19:05 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.228])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE795180176C; Fri, 11 Apr 2025 07:19:02 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 Aaron Conole <aconole@redhat.com>,
 Michael Santana <maicolgabriel@hotmail.com>
Subject: [PATCH] ci: check licenses
Date: Fri, 11 Apr 2025 09:18:57 +0200
Message-ID: <20250411071857.3355590-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Uttu356mcIVoOVMwRPNrGs6WhuD3e34P_h-4ya9fe0U_1744355945
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

Call check-spdx.tag.sh so that all committed files are checked.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 .github/workflows/build.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index 7a6b679fe5..1e289979e3 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -31,6 +31,7 @@ jobs:
         failed=
         devtools/check-doc-vs-code.sh upstream/${{ env.REF_GIT_BRANCH }} || failed=true
         devtools/check-meson.py || failed=true
+        devtools/check-spdx-tag.sh || failed=true
         [ -z "$failed" ]
   ubuntu-vm-builds:
     name: ${{ join(matrix.config.*, '-') }}
-- 
2.49.0

