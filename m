Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DA2C83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 13:32:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C133840E17;
	Wed, 23 Jul 2025 15:32:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0B49940E0F
 for <dev@dpdk.org>; Wed, 23 Jul 2025 15:32:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753277559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=17k+6OklrVFUREj8fXNymb3tYTBDevGuW7/aXLCwK38=;
 b=APS1jBi+xiPlo8SUc/7zZgG3Mr8tK3nh0iry2S90xyIrNrLAssQodnWlWsyBdjMXN70Mof
 PS90OLnFxncJlXjopi4CUJQlqEXjLn2DslvB2BkAZ5rBhUa2zTLyU0ngwV27zYETPpAtlX
 DXSehrlIBfKn6aZEUgCSg48uN48k6yo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-LxIFUvqlOl2E2RFvxuf_nw-1; Wed,
 23 Jul 2025 09:32:37 -0400
X-MC-Unique: LxIFUvqlOl2E2RFvxuf_nw-1
X-Mimecast-MFC-AGG-ID: LxIFUvqlOl2E2RFvxuf_nw_1753277557
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C06B1851048; Wed, 23 Jul 2025 13:32:13 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.51])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8FA8F195608D; Wed, 23 Jul 2025 13:32:11 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Aaron Conole <aconole@redhat.com>,
 Michael Santana <maicolgabriel@hotmail.com>
Subject: [PATCH v5 01/22] ci: save ccache on failure
Date: Wed, 23 Jul 2025 15:31:34 +0200
Message-ID: <20250723133157.159825-2-david.marchand@redhat.com>
In-Reply-To: <20250723133157.159825-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kPoDDCrMwM9T7LaOWTf6RyTuAoKNx2bbhnXxd7bD6IY_1753277557
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

When troubleshooting unit test failures and repeating jobs in GHA,
the absence of ccache makes the whole process way slower.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Aaron Conole <aconole@redhat.com>
---
 .github/workflows/build.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index aca86bb6ed..79c1e62c03 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -164,6 +164,12 @@ jobs:
         chmod o-w $HOME
     - name: Build and test
       run: .ci/linux-build.sh
+    - name: Save ccache on failure
+      if: failure()
+      uses: actions/cache/save@v4
+      with:
+        path: ~/.ccache
+        key: ${{ steps.get_ref_keys.outputs.ccache }}-${{ github.ref }}
     - name: Upload logs on failure
       if: failure()
       uses: actions/upload-artifact@v4
-- 
2.50.0

