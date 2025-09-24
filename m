Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED67DCAC5B0
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 12:34:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30D4140615;
	Wed, 24 Sep 2025 14:34:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C2A9040611
 for <dev@dpdk.org>; Wed, 24 Sep 2025 14:34:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758717286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SpN1j7bofMsovvHBdmbgezzcaFdvdloxE9HN4qvzioU=;
 b=h2n8/orJ71rAgp5Q2qCTEuMZOwvfEUgrlYYk/meUyesZVmPfP/BdLT8V2zCGOQFmIJeXCc
 F2YsgKQ90m7T7qzHs4E3A8Q5aAFu2J7doJPoXf5o5rqnvFj+lFGXmtusRgClNVmtgpE0Wk
 HeSPCboTB7an5CQ6yxt00ktNCEE7tZo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-qGZ9zWuOOoiWwFArZMjNRA-1; Wed,
 24 Sep 2025 08:34:45 -0400
X-MC-Unique: qGZ9zWuOOoiWwFArZMjNRA-1
X-Mimecast-MFC-AGG-ID: qGZ9zWuOOoiWwFArZMjNRA_1758717284
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74520180034C; Wed, 24 Sep 2025 12:34:43 +0000 (UTC)
Received: from rh.Home (unknown [10.44.34.63])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5637A1800447; Wed, 24 Sep 2025 12:34:39 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: david.marchand@redhat.com, thomas@monjalon.net,
 Kevin Traynor <ktraynor@redhat.com>
Subject: [PATCH v2 1/2] build: add backward compatibility for nested drivers
Date: Wed, 24 Sep 2025 13:34:21 +0100
Message-ID: <20250924123422.224988-2-ktraynor@redhat.com>
In-Reply-To: <20250924123422.224988-1-ktraynor@redhat.com>
References: <20250922110708.47879-1-ktraynor@redhat.com>
 <20250924123422.224988-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p4O2CKhW_F4mFlG2BaUQUfE4B3dQtrEHMh_SNTaFrnE_1758717284
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

Intel driver were moved from 'net/*' to '/net/intel/*' in DPDK 25.03
in commit
c1d145834f28 ("net/intel: move Intel drivers to a subdirectory")

This means that any enabling or disabling of those drivers from
the command line using the old names will no longer work.
e.g. 'net/ixgbe' will not enable/disable the ixgbe driver.

The drivers enabled or disabled are reported in the meson logs,
but it is easy to miss this change in the list of drivers and end up
with a build missing drivers or drivers unintentionally enabled.

It also means that any users working with different versions of DPDK
have to enable/disable drivers differently depending on the DPDK
version.

To avoid the issues above, add backwards compatibility for old Intel
driver names with a warning. It can be extended for other drivers if
the need arises.

Fixes: c1d145834f28 ("net/intel: move Intel drivers to a subdirectory")

Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
---
 drivers/meson.build | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/meson.build b/drivers/meson.build
index f25f425565..2f32a8559f 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -33,10 +33,38 @@ if meson.is_cross_build()
 endif
 
-# add cmdline disabled drivers and meson disabled drivers together
-disable_drivers += ',' + get_option('disable_drivers')
+# map legacy driver names
+driver_map = {
+    'net/e1000': 'net/intel/e1000',
+    'net/fm10k': 'net/intel/fm10k',
+    'net/i40e': 'net/intel/i40e',
+    'net/iavf': 'net/intel/iavf',
+    'net/ice': 'net/intel/ice',
+    'net/idpf': 'net/intel/idpf',
+    'net/ipn3ke': 'net/intel/ipn3ke',
+    'net/ixgbe': 'net/intel/ixgbe',
+    'net/cpfl': 'net/intel/cpfl',
+}
+
+foreach driver_option : ['disable_drivers', 'enable_drivers']
+    # get list of drivers from the option
+    cmdline_drivers = get_option(driver_option)
+    foreach driver : cmdline_drivers.split(',')
+        if driver == ''
+            continue
+        endif
+        # check if driver has a legacy name which maps to a new name
+        if driver_map.has_key(driver)
+            # use new name instead of legacy name
+            driver = driver_map[driver]
+        endif
+        if driver_option == 'disable_drivers'
+            disable_drivers += ',' + driver
+        else
+            enable_drivers += ',' + driver
+        endif
+    endforeach
+endforeach
+
 disable_drivers = run_command(list_dir_globs, disable_drivers, check: true).stdout().split()
-
-# add cmdline enabled drivers and meson enabled drivers together
-enable_drivers = ',' + get_option('enable_drivers')
 enable_drivers = run_command(list_dir_globs, enable_drivers, check: true).stdout().split()
 require_drivers = true
-- 
2.51.0

