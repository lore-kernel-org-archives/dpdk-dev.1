Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A127ECCFA04
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 08:43:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99FF040663;
	Wed,  5 Nov 2025 09:43:33 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2BAF9400D7
 for <dev@dpdk.org>; Wed,  5 Nov 2025 09:43:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762332211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RYLa5Y683wDefm6lXGk1F3Eo70zC3A4YDlol+Lfzn8Q=;
 b=DfILDr16rWRrUFp6IB/mTJM8J6Ai2kzbcsZsdWvCbshW0yxakcfhHCyUS9UK5AvBvJaqZs
 aAydUYLB5TBHXXyFbQbPgjqJdRlRp5k20JC5QvRCG41yOUN21zGXEMaSMiNQVbwRzk8Qmp
 y8nhF+J13HovSvm71p5lTfDh8NjSLbg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-CYl4vbWyMnCzD3ks9NwfjA-1; Wed,
 05 Nov 2025 03:43:28 -0500
X-MC-Unique: CYl4vbWyMnCzD3ks9NwfjA-1
X-Mimecast-MFC-AGG-ID: CYl4vbWyMnCzD3ks9NwfjA_1762332207
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79EBF1800451; Wed,  5 Nov 2025 08:43:27 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AE52A1800451; Wed,  5 Nov 2025 08:43:25 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: sivaprasad.tummala@amd.com, Aaron Conole <aconole@redhat.com>,
 Michael Santana <maicolgabriel@hotmail.com>
Subject: [PATCH 1/2] ci: refactor build dependencies in GHA
Date: Wed,  5 Nov 2025 09:43:08 +0100
Message-ID: <20251105084309.3851898-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _6YWFimYPwdhD2VzKeeL4G5O4G2a5Xm8LtH3mXorc-w_1762332207
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

Move build dependencies in some multiline variable to make it easier to
update.
For the Fedora pipeline, use a single source of trust in the prepare
image job.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 .github/workflows/build.yml | 64 +++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 14 deletions(-)

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index 2da27dca5d..e7090dcee1 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -55,6 +55,27 @@ jobs:
       RUN_TESTS: ${{ contains(matrix.config.checks, 'tests') }}
       STDATOMIC: ${{ contains(matrix.config.checks, 'stdatomic') }}
       UBSAN: ${{ contains(matrix.config.checks, 'ubsan') }}
+      build_deps: |
+        ccache \
+        libarchive-dev \
+        libbsd-dev \
+        libbpf-dev \
+        libfdt-dev \
+        libibverbs-dev \
+        libipsec-mb-dev \
+        libisal-dev \
+        libjansson-dev \
+        libnuma-dev \
+        libpcap-dev \
+        libssl-dev \
+        libvirt-dev \
+        ninja-build \
+        pkg-config \
+        python3-pip \
+        python3-pyelftools \
+        python3-setuptools \
+        python3-wheel \
+        zlib1g-dev
 
     strategy:
       fail-fast: false
@@ -133,10 +154,7 @@ jobs:
     - name: Update APT cache
       run: sudo apt update || true
     - name: Install packages
-      run: sudo apt install -y ccache libarchive-dev libbsd-dev libbpf-dev
-        libfdt-dev libibverbs-dev libipsec-mb-dev libisal-dev libjansson-dev
-        libnuma-dev libpcap-dev libssl-dev libvirt-dev ninja-build pkg-config python3-pip
-        python3-pyelftools python3-setuptools python3-wheel zlib1g-dev
+      run: sudo apt install -y ${{ env.build_deps }}
     - name: Install libabigail build dependencies if no cache is available
       if: env.ABI_CHECKS == 'true' && steps.libabigail-cache.outputs.cache-hit != 'true'
       run: sudo apt install -y autoconf automake libdw-dev libtool libxml2-dev libxxhash-dev
@@ -227,7 +245,31 @@ jobs:
   prepare-container-images:
     name: ${{ join(matrix.config.*, '-') }}
     runs-on: ubuntu-latest
+    env:
+      build_deps: |
+        ccache \
+        intel-ipsec-mb-devel \
+        isa-l-devel \
+        jansson-devel \
+        libarchive-devel \
+        libatomic \
+        libbsd-devel \
+        libbpf-devel \
+        libfdt-devel \
+        libpcap-devel \
+        libvirt-devel \
+        libxdp-devel \
+        ninja-build \
+        numactl-devel \
+        openssl-devel \
+        python3-pip \
+        python3-pyelftools \
+        python3-setuptools \
+        python3-wheel \
+        rdma-core-devel \
+        zlib-devel
     outputs:
+      build_deps: ${{ steps.get_keys.outputs.build_deps }}
       image: ${{ steps.get_keys.outputs.image }}
 
     strategy:
@@ -240,6 +282,7 @@ jobs:
     - name: Generate various keys
       id: get_keys
       run: |
+        echo 'build_deps='$(echo -n ${{ env.build_deps }}) >> $GITHUB_OUTPUT
         echo 'image=image-${{ matrix.config.image }}-'$(date -u +%Y-%m-%d) >> $GITHUB_OUTPUT
     - name: Retrieve image cache
       id: image_cache
@@ -259,11 +302,7 @@ jobs:
       run: docker exec -i dpdk dnf update -y
     - name: Install packages
       if: steps.image_cache.outputs.cache-hit != 'true'
-      run: docker exec -i dpdk dnf install -y ccache intel-ipsec-mb-devel
-        isa-l-devel jansson-devel libarchive-devel libatomic libbsd-devel
-        libbpf-devel libfdt-devel libpcap-devel libvirt-devel libxdp-devel
-        ninja-build numactl-devel openssl-devel python3-pip python3-pyelftools
-        python3-setuptools python3-wheel rdma-core-devel zlib-devel
+      run: docker exec -i dpdk dnf install -y ${{ env.build_deps }}
     - name: Save image in cache
       if: steps.image_cache.outputs.cache-hit != 'true'
       run: |
@@ -335,11 +374,8 @@ jobs:
     - name: Update
       run: docker exec -i dpdk dnf update -y || true
     - name: Install packages
-      run: docker exec -i dpdk dnf install -y ccache intel-ipsec-mb-devel
-        isa-l-devel jansson-devel libarchive-devel libatomic libbsd-devel
-        libbpf-devel libfdt-devel libpcap-devel libvirt-devel libxdp-devel
-        ninja-build numactl-devel openssl-devel python3-pip python3-pyelftools
-        python3-setuptools python3-wheel rdma-core-devel zlib-devel
+      run: docker exec -i dpdk dnf install -y
+        ${{ needs.prepare-container-images.outputs.build_deps }}
         ${{ matrix.config.compiler }}
     - name: Run setup
       run: docker exec -i dpdk .ci/linux-setup.sh
-- 
2.51.0

