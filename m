Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5E5CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 12:34:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D7D34066A;
	Wed, 24 Sep 2025 14:34:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id CA6484065C
 for <dev@dpdk.org>; Wed, 24 Sep 2025 14:34:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758717292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h8erltaSScyKV7gwT8lQel/TCAvZ74xDKZtVcQLLoPc=;
 b=KPJWPrdJyTIFbkFy1MySwiCKRNsC38NQyz32xO3grguIRU165YGU2BO1BBMpPlEIllTqmo
 zYMfjWu0DjKjzpWb1OHcJWcy5YwmkXz3/hPEg1h7W1tzXPlyrHAhOFnxIp+sHUDQH2T5cW
 ieg3RMfR9FerxzFxf1XDLfzQ7JJ/tVM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-YJPQOH-UOKm8Nb9QVAm07Q-1; Wed,
 24 Sep 2025 08:34:49 -0400
X-MC-Unique: YJPQOH-UOKm8Nb9QVAm07Q-1
X-Mimecast-MFC-AGG-ID: YJPQOH-UOKm8Nb9QVAm07Q_1758717288
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 606FB19560B8; Wed, 24 Sep 2025 12:34:48 +0000 (UTC)
Received: from rh.Home (unknown [10.44.34.63])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE71C180044F; Wed, 24 Sep 2025 12:34:45 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: david.marchand@redhat.com, thomas@monjalon.net,
 Kevin Traynor <ktraynor@redhat.com>
Subject: [PATCH v2 2/2] build: add backward compatibility for wildcarding
 nested drivers
Date: Wed, 24 Sep 2025 13:34:22 +0100
Message-ID: <20250924123422.224988-3-ktraynor@redhat.com>
In-Reply-To: <20250924123422.224988-1-ktraynor@redhat.com>
References: <20250922110708.47879-1-ktraynor@redhat.com>
 <20250924123422.224988-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -9moGPGJOgvWmXBdhqL_O_ZsSdxWKT0E-ghEk-8WDN4_1758717288
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

Up until DPDK 25.03 'net/*' could be used with meson options
enable_drivers or disable_drivers to explicitly enable or
disable all net drivers.

In DPDK 25.03 commit
c1d145834f28 ("net/intel: move Intel drivers to a subdirectory")
moved Intel drivers to 'net/intel/*' and 'net/*' no longer enabled
or disabled the Intel drivers.

Enable recursive wildcard pattern '**' and expand wildcard
handling to include nested drivers. e.g. 'net/*' will also
enable/disable drivers in 'net/*/*'

This adds backward compatibility so that so that 'net/*' will
continue to enable/disable Intel and any future nested drivers.

Fixes: c1d145834f28 ("net/intel: move Intel drivers to a subdirectory")

Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
---
 buildtools/list-dir-globs.py | 2 +-
 drivers/meson.build          | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/buildtools/list-dir-globs.py b/buildtools/list-dir-globs.py
index fb8619db64..a8a3926d49 100755
--- a/buildtools/list-dir-globs.py
+++ b/buildtools/list-dir-globs.py
@@ -16,5 +16,5 @@
 for path in sys.argv[1].split(','):
     if path:
-        for p in iglob(os.path.join(root, path)):
+        for p in iglob(os.path.join(root, path), recursive=True):
             if os.path.isdir(p):
                 print(os.path.relpath(p, start=root).replace('\\', '/'))
diff --git a/drivers/meson.build b/drivers/meson.build
index 2f32a8559f..7163b5ddf1 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -57,4 +57,7 @@ foreach driver_option : ['disable_drivers', 'enable_drivers']
             # use new name instead of legacy name
             driver = driver_map[driver]
+        elif driver.endswith('/*')
+            # make wildcard recursive to include nested drivers
+            driver = driver + '*'
         endif
         if driver_option == 'disable_drivers'
@@ -71,5 +74,5 @@ require_drivers = true
 if enable_drivers.length() == 0
     require_drivers = false
-    enable_drivers = run_command(list_dir_globs, '*/*,*/*/*', check: true).stdout().split()
+    enable_drivers = run_command(list_dir_globs, '**', check: true).stdout().split()
 endif
 
-- 
2.51.0

