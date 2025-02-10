Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49FEC0219E
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 17:44:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A3B4409FA;
	Mon, 10 Feb 2025 18:44:41 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id DE05B40615
 for <dev@dpdk.org>; Mon, 10 Feb 2025 18:44:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739209479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XpyMfz337fz3HRCiFxUO1Q1fsJErfj2TQKvmj97Cqg8=;
 b=fF+fYV2dTmS7f30sFSIbj5NzHasn6wTR9RUq1T96ODmBGAapTrlh7V1VnZ/Ry6elbcVtRl
 p0mFc9AHV6FKfJ7ABP1F+Q4zXrUvVNTjra7MOcBKkFyLiXaYVlQ0m5eH3QVSP6oFgr+3Bx
 lhG4w0b9uILM9ivlA8q2zDCszrjK+Bg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-grKVJdeyOwWuK2B1kcRDaA-1; Mon,
 10 Feb 2025 12:44:38 -0500
X-MC-Unique: grKVJdeyOwWuK2B1kcRDaA-1
X-Mimecast-MFC-AGG-ID: grKVJdeyOwWuK2B1kcRDaA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9347B19560A7; Mon, 10 Feb 2025 17:44:36 +0000 (UTC)
Received: from dmarchan.com (unknown [10.44.32.76])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7ED3619560A3; Mon, 10 Feb 2025 17:44:34 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, fengchengwen@huawei.com,
 Aaron Conole <aconole@redhat.com>,
 Michael Santana <maicolgabriel@hotmail.com>
Subject: [PATCH v3 1/6] ci: check traces validity
Date: Mon, 10 Feb 2025 18:44:17 +0100
Message-ID: <20250210174424.3364021-2-david.marchand@redhat.com>
In-Reply-To: <20250210174424.3364021-1-david.marchand@redhat.com>
References: <20250124161408.310581-1-david.marchand@redhat.com>
 <20250210174424.3364021-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Qwd6RfodX42wN14OBK9LiSZEOfZAN7o3nWcfEChBsiw_1739209476
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

We currently do not validate if generated traces can be parsed by a
tracing tool.
Add some check.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v2:
- added this check, as v2 was breaking CTF metadata content,

---
 .ci/linux-build.sh          | 10 ++++++++++
 .github/workflows/build.yml |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
index fdb5787621..e9272d3931 100755
--- a/.ci/linux-build.sh
+++ b/.ci/linux-build.sh
@@ -44,6 +44,14 @@ catch_coredump() {
     return 1
 }
 
+check_traces() {
+    which babeltrace >/dev/null || return 0
+    for file in $(sudo find $HOME -name metadata); do
+        ! sudo babeltrace $(dirname $file) >/dev/null 2>&1 || continue
+        sudo babeltrace $(dirname $file)
+    done
+}
+
 cross_file=
 
 if [ "$AARCH64" = "true" ]; then
@@ -133,6 +141,7 @@ if [ -z "$cross_file" ]; then
     configure_coredump
     devtools/test-null.sh || failed="true"
     catch_coredump
+    check_traces
     [ "$failed" != "true" ]
 fi
 
@@ -173,6 +182,7 @@ if [ "$RUN_TESTS" = "true" ]; then
     configure_coredump
     sudo meson test -C build --suite fast-tests -t 3 || failed="true"
     catch_coredump
+    check_traces
     [ "$failed" != "true" ]
 fi
 
diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index dcafb4a8f5..72c7366b88 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -151,7 +151,7 @@ jobs:
       run: sudo apt install -y crossbuild-essential-riscv64
     - name: Install test tools packages
       if: env.AARCH64 != 'true' || env.PPC64LE != 'true' || env.RISCV64 != 'true' || env.RUN_TESTS == 'true'
-      run: sudo apt install -y gdb jq
+      run: sudo apt install -y babeltrace gdb jq
     - name: Install doc generation packages
       if: env.BUILD_DOCS == 'true'
       run: sudo apt install -y doxygen graphviz man-db python3-sphinx
-- 
2.48.1

