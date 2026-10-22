Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323E5606A31D
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 17:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YWRPj5Qw
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0F984027D;
	Thu, 22 Oct 2026 19:45:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A0C0C40696
 for <dev@dpdk.org>; Thu, 22 Oct 2026 19:45:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792691110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7CZqthi4G5aFSRkYA7Q5d91heayJpUqn3FA7NDSnWJY=;
 b=YWRPj5Qw2QMr71I9pRbB6atfWEa+S45neweOJB660K4yxghEPtSwRkVn0HipUIuJUMdT+u
 /bjrn2TJDmOwTPmkBHCLHzzF0YzDwFb9kCkNpyDyYWGWie9mHHWnWnGtFAXO+c7WkQqmnf
 AWKsT2fi5jaE0mh+imzAmvrOE+vQ1lk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-mJYnR2V1NuiH53U3EuxFTA-1; Thu,
 22 Oct 2026 13:45:07 -0400
X-MC-Unique: mJYnR2V1NuiH53U3EuxFTA-1
X-Mimecast-MFC-AGG-ID: mJYnR2V1NuiH53U3EuxFTA_1792691107
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0316E1954B0E; Thu, 22 Oct 2026 17:45:07 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 053E57DE; Thu, 22 Oct 2026 17:45:05 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net
Subject: [PATCH v3 03/13] devtools: support Intel drivers in doc check
Date: Thu, 22 Oct 2026 19:44:30 +0200
Message-ID: <20261022174447.412638-4-david.marchand@redhat.com>
In-Reply-To: <20261022174447.412638-1-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261022174447.412638-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u55h1_Writ2JNVCuqDp0MGtuIf_TynPivdFU4BiPYtU_1792691107
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Intel network drivers are located in a subdirectory
(drivers/net/intel/) rather than directly in drivers/net/.

Update all_net_drivers() to find drivers based on meson.build
presence, which handles both locations.

Add driver_code_dir() helper to map driver names to their actual
code directory.

Update changed_net_drivers() to extract driver names from Intel
subdirectory paths.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v2:
- split changes out of original patch 3, now only dealing with Intel sub
  directory case,

---
 devtools/check-doc-vs-code.sh | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/devtools/check-doc-vs-code.sh b/devtools/check-doc-vs-code.sh
index 80d77907f0..e141fe9938 100755
--- a/devtools/check-doc-vs-code.sh
+++ b/devtools/check-doc-vs-code.sh
@@ -38,24 +38,38 @@ has_file_change() # <pattern>
 
 changed_net_drivers()
 {
-	net_paths='drivers/net/|doc/guides/nics/features/'
 	[ -n "$drivers" ] ||
 		drivers=$(changed_files |
-			sed -rn "s,^($net_paths)([^./]*).*,\2,p" |
+			sed -rn '
+				s,^drivers/net/intel/([^/]*).*,\1,p; t
+				s,^drivers/net/([^/]*).*,\1,p; t
+				s,^doc/guides/nics/features/([^.]*).*,\1,p' |
 			sort -u)
 	echo "$drivers"
 }
 
 all_net_drivers()
 {
-	find $rootdir/drivers/net -mindepth 1 -maxdepth 1 -type d |
-	sed 's,.*/,,' |
-	sort
+	find $rootdir/drivers/net -name meson.build |
+	sed -rn '
+		s,.*drivers/net/intel/([^/]*).*,\1,p; t
+		s,.*drivers/net/([^/]*).*,\1,p' |
+	sort -u
+}
+
+# give back a driver directory for a doc/driver name
+driver_code_dir() # <driver_name>
+{
+	if [ -d $rootdir/drivers/net/intel/$1 ]; then
+		echo "$rootdir/drivers/net/intel/$1"
+	else
+		echo "$rootdir/drivers/net/$1"
+	fi
 }
 
 check_rte_flow() # <driver>
 {
-	code=$rootdir/drivers/net/$1
+	code=$(driver_code_dir $1)
 	doc=$rootdir/doc/guides/nics/features/$1.ini
 	[ -d $code ] || return 0
 	[ -f $doc ] || return 0
-- 
2.54.0

