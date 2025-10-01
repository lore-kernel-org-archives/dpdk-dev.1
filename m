Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5371BCCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 08:18:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C9094065D;
	Wed,  1 Oct 2025 10:18:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 65F08400EF
 for <dev@dpdk.org>; Wed,  1 Oct 2025 10:18:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759306716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+0Pud6huWbag1hgtIg1x6FTRahc8sr2HMQQ0gZWWjkM=;
 b=Nty12sjtP1zXumpJsgxBc6eO1qyuHrVtXmGpI88Tk3IiD/Rnlp19g1IMLV+DA2986aKJ65
 +6QCYaGkeLHl1SIigstq01lCk1jqxMjntLveXJ2phIachMUkzINjanA5/SMq5kWh8cLS59
 xG94uiWADr0obAUHc7gVxKZu4VJc/d8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-HByhSglWM1m_bGyQY1upCw-1; Wed,
 01 Oct 2025 04:18:33 -0400
X-MC-Unique: HByhSglWM1m_bGyQY1upCw-1
X-Mimecast-MFC-AGG-ID: HByhSglWM1m_bGyQY1upCw_1759306712
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC261195608B; Wed,  1 Oct 2025 08:18:31 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.213])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 84EC6195608E; Wed,  1 Oct 2025 08:18:29 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, Aaron Conole <aconole@redhat.com>,
 Michael Santana <maicolgabriel@hotmail.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH] ci: configure Coderabbit
Date: Wed,  1 Oct 2025 10:18:25 +0200
Message-ID: <20251001081825.2638077-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iSz7mX2LR_qAXdcwVp5Z15CYlAC3q8pi7oJ-GiORZOw_1759306712
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

Coderabbit currently runs in ovsrobot repository (and can be used in
public personal forks).

poems are funny, but not really helpful.
Reduce some noise by disabling (or collapsing) some verbose outputs.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
I copied the tone instructions and some settings from grout.
The docstrings check is noisy, and often wrong for C headers
(especially EAL arch headers).

Opinions?

---
 .coderabbit.yaml           | 14 ++++++++++++++
 MAINTAINERS                |  1 +
 devtools/check-spdx-tag.sh |  2 +-
 3 files changed, 16 insertions(+), 1 deletion(-)
 create mode 100644 .coderabbit.yaml

diff --git a/.coderabbit.yaml b/.coderabbit.yaml
new file mode 100644
index 0000000000..7968f4f4ba
--- /dev/null
+++ b/.coderabbit.yaml
@@ -0,0 +1,14 @@
+language: "en-US"
+tone_instructions: "Only provide helpful, relevant comments. Be brief and terse but clear."
+reviews:
+  profile: "chill"
+  collapse_walkthrough: true
+  changed_files_summary: false
+  sequence_diagrams: false
+  suggested_labels: false
+  poem: false
+  finishing_touches:
+    docstrings:
+      enabled: false
+    unit_tests:
+      enabled: false
diff --git a/MAINTAINERS b/MAINTAINERS
index 1a2729be66..b82632fea3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -141,6 +141,7 @@ M: Aaron Conole <aconole@redhat.com>
 M: Michael Santana <maicolgabriel@hotmail.com>
 F: .github/workflows/build.yml
 F: .ci/
+F: .coderabbit.yaml
 
 Driver information
 M: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
diff --git a/devtools/check-spdx-tag.sh b/devtools/check-spdx-tag.sh
index 984825026e..eb4a88a3fb 100755
--- a/devtools/check-spdx-tag.sh
+++ b/devtools/check-spdx-tag.sh
@@ -18,7 +18,7 @@ print_usage () {
 no_license_list=\
 ':^.git* :^.mailmap :^.ci/* :^README :^*/README* :^MAINTAINERS :^VERSION :^ABI_VERSION '\
 ':^license/ :^config/ :^buildtools/ :^*.abignore :^*.cocci :^*/poetry.lock '\
-':^*/Kbuild :^kernel/linux/uapi/version '\
+':^*/Kbuild :^kernel/linux/uapi/version :^.coderabbit.yaml '\
 ':^*.ini :^*.data :^*.json :^*.cfg :^*.txt :^*.svg :^*.png'
 
 check_spdx() {
-- 
2.51.0

