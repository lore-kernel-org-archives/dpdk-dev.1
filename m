Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AB6C02193
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 16:07:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BFF040DF8;
	Tue,  4 Feb 2025 17:07:53 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 17B7F400D6
 for <dev@dpdk.org>; Tue,  4 Feb 2025 17:07:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738685271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+eONgFP7FzWQSevjYzzC844zQmGcKkNOIiyl5cndB74=;
 b=G8DWm3gns7QzU5fezH0zZTGIJgxn6E9Q9ECqjcrTZp0YIXN6g6WUgGBTy8tXixMxV4DFMx
 y8mSVPH5FxTFROfqJ9O51YNC9Sbc8HlLAJmoB6A0Bl6UfozWFuIRpSFJdpMBMhPZIhDbWR
 ourN/MowhpohAyC7rKDbZ4bTDlpcERM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-3JELHJfOP3eM3eNUhFte6A-1; Tue,
 04 Feb 2025 11:07:45 -0500
X-MC-Unique: 3JELHJfOP3eM3eNUhFte6A-1
X-Mimecast-MFC-AGG-ID: 3JELHJfOP3eM3eNUhFte6A
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E961A18009C9; Tue,  4 Feb 2025 16:07:43 +0000 (UTC)
Received: from RHTRH0061144.redhat.com (unknown [10.22.80.197])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D0B6018008C0; Tue,  4 Feb 2025 16:07:41 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: dev@dpdk.org
Cc: David Marchand <david.marchand@redhat.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Patrick Robb <probb@iol.unh.edu>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Michael Santana <maicolgabriel@hotmail.com>
Subject: [RFC] ci: Add support for Cirrus-CI service to test FreeBSD.
Date: Tue,  4 Feb 2025 11:07:39 -0500
Message-ID: <20250204160739.1603197-1-aconole@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AkKXzEpVWfLsB_Q4F9y7RNmh9Mj856WE0h14-g7Cmyo_1738685264
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

This commit adds preliminary support for developer driven FreeBSD testing
via the Cirrus-CI cloud continuous integration system.

NOTE: Currently, this does not successfully execute.  See the following
build result:
  https://cirrus-ci.com/task/5626189961756672

Full Logs:
  https://api.cirrus-ci.com/v1/task/5626189961756672/logs/check.log

The tests themselves may need to be run as root.

Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 .ci/freebsd-build.sh |  5 +++++
 .ci/freebsd-setup.sh |  3 +++
 .cirrus.yml          | 33 +++++++++++++++++++++++++++++++++
 MAINTAINERS          |  1 +
 4 files changed, 42 insertions(+)
 create mode 100755 .ci/freebsd-build.sh
 create mode 100755 .ci/freebsd-setup.sh
 create mode 100644 .cirrus.yml

diff --git a/.ci/freebsd-build.sh b/.ci/freebsd-build.sh
new file mode 100755
index 0000000000..099f9fd448
--- /dev/null
+++ b/.ci/freebsd-build.sh
@@ -0,0 +1,5 @@
+#!/bin/sh
+
+cd build
+ninja
+meson install
diff --git a/.ci/freebsd-setup.sh b/.ci/freebsd-setup.sh
new file mode 100755
index 0000000000..762a8383c3
--- /dev/null
+++ b/.ci/freebsd-setup.sh
@@ -0,0 +1,3 @@
+#!/bin/sh
+
+meson setup build
diff --git a/.cirrus.yml b/.cirrus.yml
new file mode 100644
index 0000000000..727dcb14f4
--- /dev/null
+++ b/.cirrus.yml
@@ -0,0 +1,33 @@
+freebsd_build_task:
+
+  freebsd_instance:
+    matrix:
+      image_family: freebsd-15-0-snap
+      image_family: freebsd-14-2-snap
+    cpu: 4
+    memory: 4G
+
+  env:
+    DEPENDENCIES: git gcc wget openssl python3 meson pkgconf
+    PY_DEPS:      pyelftools
+    matrix:
+      COMPILER: gcc
+      COMPILER: clang
+
+  prepare_script:
+    - sysctl -w kern.coredump=0
+    - pkg update -f
+    - pkg install -y ${DEPENDENCIES}
+        $(pkg search -xq "^py3[0-9]+-(${PY_DEPS})-[0-9]+" | xargs)
+    - mkdir -p /usr/src
+    - git clone --depth 1 https://git.freebsd.org/src.git /usr/src
+
+  configure_script:
+    - ./.ci/freebsd-setup.sh
+
+  build_script:
+    - ./.ci/freebsd-build.sh
+
+  check_script:
+    - meson test -C build --suite fast-tests -t 3
+            || { cat ./build/meson-logs/testlog.txt; exit 1; }
diff --git a/MAINTAINERS b/MAINTAINERS
index b86cdd266b..ed1df17f3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -142,6 +142,7 @@ M: Aaron Conole <aconole@redhat.com>
 M: Michael Santana <maicolgabriel@hotmail.com>
 F: .github/workflows/build.yml
 F: .ci/
+F: .cirrus.yml
 
 Driver information
 M: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
-- 
2.47.1

