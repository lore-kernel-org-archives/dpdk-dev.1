Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CCDC71159
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 07:11:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68AEA42DF0;
	Thu, 19 Jun 2025 09:11:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 797784025E
 for <dev@dpdk.org>; Thu, 19 Jun 2025 09:11:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750317081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jxJ8G3DEFEdXyN2Qk1FcBJxUzsKJWaqMh4/fmOqkEAo=;
 b=YP8yy/jYCJrpas5XZ3xSYIQ6R94XgQuHo7jDmsZxWPvm2OS0m38x30oJWm/1tt+UUKheZz
 HfhFvvkg3zcC3GreRZg3ct6FqdsUTzmkiqlLdYCSxo3k8TqFYahwKAl/oWZ3J6kA0Z6pfs
 U6DB6zjZAFsPPTBk0jALnqpl3EdSBKY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180--L1XIg3eOoKrQR-u3Vsw1g-1; Thu,
 19 Jun 2025 03:11:17 -0400
X-MC-Unique: -L1XIg3eOoKrQR-u3Vsw1g-1
X-Mimecast-MFC-AGG-ID: -L1XIg3eOoKrQR-u3Vsw1g_1750317077
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C29A9180AE05; Thu, 19 Jun 2025 07:11:16 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.8])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6012018003FC; Thu, 19 Jun 2025 07:11:15 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Aaron Conole <aconole@redhat.com>,
 Michael Santana <maicolgabriel@hotmail.com>
Subject: [PATCH 01/10] ci: save ccache on failure
Date: Thu, 19 Jun 2025 09:10:27 +0200
Message-ID: <20250619071037.37325-2-david.marchand@redhat.com>
In-Reply-To: <20250619071037.37325-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TesTqqtjjGdx1ZDeabHfnxEmR23Nf_FBcDgnvXQDzQU_1750317077
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
---
 .github/workflows/build.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index e5f17ef6ac..6c4bc664d0 100644
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
2.49.0

