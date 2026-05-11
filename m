Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99ACBCD37BE
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 16:11:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7649F4060F;
	Mon, 11 May 2026 18:11:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 892AE402D5
 for <dev@dpdk.org>; Mon, 11 May 2026 18:11:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778515887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9psl0sKg8ocpXNKY4xf7KnIE8w7znDxDqbEaMNLI4PY=;
 b=Olwa9wXjUbiUp/3019alqB4M+bBhuDWPkRowK5xRqG+/nXg3ZLdTecV+tJAzZ+bqfHC9DL
 0938xzwuzbTX3raBzNg8isNHXdZYkYQ2PE/hGf3Y1d2oeej5CMqYQhPJKKyAukhHHnFQ5S
 hR44Sb2cw5tJf+l2gmuhnheXV7gABX8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-d9_dDjWEMqKIPBR35OPS1g-1; Mon,
 11 May 2026 12:11:25 -0400
X-MC-Unique: d9_dDjWEMqKIPBR35OPS1g-1
X-Mimecast-MFC-AGG-ID: d9_dDjWEMqKIPBR35OPS1g_1778515884
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EFC718002CB; Mon, 11 May 2026 16:11:24 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.36])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F3FFD3002D30; Mon, 11 May 2026 16:11:22 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org,
	Aaron Conole <aconole@redhat.com>
Subject: [PATCH] ci: update versions of actions in GHA
Date: Mon, 11 May 2026 18:11:16 +0200
Message-ID: <20260511161116.18652-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Y9EGMC7h48ilD9ssse4zJErRaVfKua9r-F0V0i9jIyI_1778515884
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

GitHub started deprecating GHA actions based on Node 20.
For now, only warnings are raised, but we can switch to more recent
versions of the common actions, now:
- cache v5
- checkout v6
- upload-artifact v7
- setup-python v6

Link: https://github.blog/changelog/2025-09-19-deprecation-of-node-20-on-github-actions-runners/

Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 .github/workflows/build.yml | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index b3e2957411..f0ef39d34f 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -21,7 +21,7 @@ jobs:
     runs-on: ubuntu-24.04
     steps:
     - name: Checkout sources
-      uses: actions/checkout@v4
+      uses: actions/checkout@v6
       with:
         fetch-depth: 0
     - name: Check patches
@@ -121,7 +121,7 @@ jobs:
 
     steps:
     - name: Checkout sources
-      uses: actions/checkout@v4
+      uses: actions/checkout@v6
     - name: Generate cache keys
       id: get_ref_keys
       run: |
@@ -129,7 +129,7 @@ jobs:
         echo 'libabigail=libabigail-${{ env.LIBABIGAIL_VERSION }}-${{ matrix.config.os }}' >> $GITHUB_OUTPUT
         echo 'abi=abi-${{ matrix.config.os }}-${{ matrix.config.compiler }}-${{ matrix.config.cross }}-${{ env.REF_GIT_TAG }}' >> $GITHUB_OUTPUT
     - name: Retrieve ccache cache
-      uses: actions/cache@v4
+      uses: actions/cache@v5
       with:
         path: ~/.ccache
         key: ${{ steps.get_ref_keys.outputs.ccache }}-${{ github.ref }}
@@ -137,13 +137,13 @@ jobs:
           ${{ steps.get_ref_keys.outputs.ccache }}-refs/heads/main
     - name: Retrieve libabigail cache
       id: libabigail-cache
-      uses: actions/cache@v4
+      uses: actions/cache@v5
       if: env.ABI_CHECKS == 'true'
       with:
         path: libabigail
         key: ${{ steps.get_ref_keys.outputs.libabigail }}
     - name: Retrieve ABI reference cache
-      uses: actions/cache@v4
+      uses: actions/cache@v5
       if: env.ABI_CHECKS == 'true'
       with:
         path: reference
@@ -195,7 +195,7 @@ jobs:
         key: ${{ steps.get_ref_keys.outputs.ccache }}-${{ github.ref }}
     - name: Upload logs on failure
       if: failure()
-      uses: actions/upload-artifact@v4
+      uses: actions/upload-artifact@v7
       with:
         name: meson-logs-${{ join(matrix.config.*, '-') }}
         path: |
@@ -216,9 +216,9 @@ jobs:
 
     steps:
     - name: Checkout sources
-      uses: actions/checkout@v4
+      uses: actions/checkout@v6
     - name: Set up Python
-      uses: actions/setup-python@v5
+      uses: actions/setup-python@v6
       with:
         python-version: '3.x'
     - name: Install dependencies
@@ -235,7 +235,7 @@ jobs:
         meson compile -C build
     - name: Upload logs on failure
       if: failure()
-      uses: actions/upload-artifact@v4
+      uses: actions/upload-artifact@v7
       with:
         name: meson-logs-${{ join(matrix.config.*, '-') }}
         path: |
@@ -287,7 +287,7 @@ jobs:
         echo 'image=image-${{ matrix.config.image }}-'$(date -u +%Y-%m-%d) >> $GITHUB_OUTPUT
     - name: Retrieve image cache
       id: image_cache
-      uses: actions/cache@v4
+      uses: actions/cache@v5
       with:
         path: ~/.image
         key: ${{ steps.get_keys.outputs.image }}
@@ -331,7 +331,7 @@ jobs:
 
     steps:
     - name: Checkout sources
-      uses: actions/checkout@v4
+      uses: actions/checkout@v6
     - name: Generate various keys
       id: get_keys
       run: |
@@ -339,7 +339,7 @@ jobs:
         echo 'logs=meson-logs-${{ join(matrix.config.*, '-') }}' | tr -d ':' >> $GITHUB_OUTPUT
     - name: Retrieve image cache
       id: image_cache
-      uses: actions/cache@v4
+      uses: actions/cache@v5
       with:
         path: ~/.image
         key: ${{ needs.prepare-container-images.outputs.image }}
@@ -349,7 +349,7 @@ jobs:
         echo 'Image ${{ matrix.config.image }} is not cached.'
         false
     - name: Retrieve ccache cache
-      uses: actions/cache@v4
+      uses: actions/cache@v5
       with:
         path: ~/.ccache
         key: ${{ steps.get_keys.outputs.ccache }}-${{ github.ref }}
@@ -388,7 +388,7 @@ jobs:
       run: docker kill dpdk
     - name: Upload logs on failure
       if: failure()
-      uses: actions/upload-artifact@v4
+      uses: actions/upload-artifact@v7
       with:
         name: ${{ steps.get_keys.outputs.logs }}
         path: |
-- 
2.53.0

