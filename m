Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFFEC77B7F
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 13:53:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 993A140648;
	Mon, 23 Jun 2025 15:52:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 43F7D40151
 for <dev@dpdk.org>; Mon, 23 Jun 2025 15:52:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750686777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jxJ8G3DEFEdXyN2Qk1FcBJxUzsKJWaqMh4/fmOqkEAo=;
 b=Cn2NlSUBKYPeoO3hC/4G+6VoPnytBNdHZ8bUOP4NISBdBzF8A3ZsApcvGn1g3mXrA8O406
 CdpGyshQNrwRQmk3JgGVTgDj4z51EOEZqmVrqLCYMhveoY0ws9CxMvc/NSOm6gIsPPa42i
 pUiOlfN8VbA7VXuUV67yC57F9itUobQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-rRr10GaRMACkX0uydIvjtQ-1; Mon,
 23 Jun 2025 09:52:54 -0400
X-MC-Unique: rRr10GaRMACkX0uydIvjtQ-1
X-Mimecast-MFC-AGG-ID: rRr10GaRMACkX0uydIvjtQ_1750686773
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCEAA18011DF; Mon, 23 Jun 2025 13:52:53 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.240])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5791A1803AFF; Mon, 23 Jun 2025 13:52:52 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Aaron Conole <aconole@redhat.com>,
 Michael Santana <maicolgabriel@hotmail.com>
Subject: [PATCH v2 01/10] ci: save ccache on failure
Date: Mon, 23 Jun 2025 15:52:31 +0200
Message-ID: <20250623135242.461965-2-david.marchand@redhat.com>
In-Reply-To: <20250623135242.461965-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250623135242.461965-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6lA2s675AZSV3Uh5QFLXcxQ4z-riBJbOmUcoSIbUOt8_1750686773
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

