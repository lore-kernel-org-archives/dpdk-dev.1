Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A341C83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 13:02:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 641F840649;
	Wed, 16 Jul 2025 15:02:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 222D540608
 for <dev@dpdk.org>; Wed, 16 Jul 2025 15:02:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752670949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tmgV9SKsz+4rSjlCAN/dyhUOvszljr/hC46c+ZdbN2I=;
 b=Ol2yf8gItxU9KYhszu2h4rAmMYM+P78RP08g2u6W+nNYyb0qRVNIvs6pjExBnki9FNkx+8
 Kh1FpoMk44LekCMNrD7eVQAzfoDp5Omq4N9CxMlKK1o6iFUiZpOLzqXXanlFxk1WGkGRU2
 ASfIN4fr1xnDoymTTsjl/mqwWVRBFmA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-uJIbIHUmMIen53oKr-B5lw-1; Wed,
 16 Jul 2025 09:02:24 -0400
X-MC-Unique: uJIbIHUmMIen53oKr-B5lw-1
X-Mimecast-MFC-AGG-ID: uJIbIHUmMIen53oKr-B5lw_1752670943
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB733180028C; Wed, 16 Jul 2025 13:02:23 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.235])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1E9B2300019F; Wed, 16 Jul 2025 13:02:21 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Aaron Conole <aconole@redhat.com>,
 Michael Santana <maicolgabriel@hotmail.com>
Subject: [PATCH v4 01/22] ci: save ccache on failure
Date: Wed, 16 Jul 2025 15:01:48 +0200
Message-ID: <20250716130212.1736407-2-david.marchand@redhat.com>
In-Reply-To: <20250716130212.1736407-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250716130212.1736407-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _qo3VcG6Yj9sbVtP0D7IY0s_LWA7z6_w7_wlHftq7AA_1752670943
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
2.50.0

