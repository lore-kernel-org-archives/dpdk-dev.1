Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F851606A31D
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AS0NOM3e
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E329540A73;
	Wed, 21 Oct 2026 12:30:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0918C40041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 12:30:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792578647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KSDWzaUh4c9qbJwFO4byQNJVYmjI6MC+I3y7ZZI4KiI=;
 b=AS0NOM3e1k9m5qnOjEB3ym5LrueHkOzh4Jl566fT86+RecXVs1RwzzIzMavCXCtBfII0Cv
 NT38DkaBSvkPCkzvqUaAwRyZY9GTHmEjIgoAeUPzGOja6u3LFISV3M+aI2Fca9ecwEAPQr
 5st3HnRI594kJ2FJr7k1SYWU0KiY+RM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-2qbdgTLZOMS--lraXpscag-1; Wed,
 21 Oct 2026 06:30:44 -0400
X-MC-Unique: 2qbdgTLZOMS--lraXpscag-1
X-Mimecast-MFC-AGG-ID: 2qbdgTLZOMS--lraXpscag_1792578643
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BAB48195605A; Wed, 21 Oct 2026 10:30:42 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7EF0B18004D2; Wed, 21 Oct 2026 10:30:41 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 03/12] devtools: handle multiple drivers in doc check
Date: Wed, 21 Oct 2026 12:30:17 +0200
Message-ID: <20261021103027.2050351-4-david.marchand@redhat.com>
In-Reply-To: <20261021103027.2050351-1-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261021103027.2050351-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d_KZ8mPF2KH2x-6_gnXLyo7Ms-vlWgZ8_wuw2Pmy3jM_1792578643
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The doc check currently does not look into the Intel drivers, nor does
it handle multiple drivers in a single code.

Add helpers to extract driver names from paths and map them to code
directories.

When a driver name matches its code directory, report differences in
both directions (code vs doc, doc vs code).

When multiple docs share one code directory, only report doc items
not in code to avoid false positives.

Also rename doc files to match their code directory names.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 MAINTAINERS                                   |  2 +-
 devtools/check-doc-vs-code.sh                 | 67 +++++++++++++++++--
 .../features/{afpacket.ini => af_packet.ini}  |  2 +-
 .../features/{cxgbevf.ini => cxgbe_vf.ini}    |  2 +-
 4 files changed, 63 insertions(+), 10 deletions(-)
 rename doc/guides/nics/features/{afpacket.ini => af_packet.ini} (70%)
 rename doc/guides/nics/features/{cxgbevf.ini => cxgbe_vf.ini} (90%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1720cff62e..e05bea2f0c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -679,7 +679,7 @@ F: examples/bond/
 Linux AF_PACKET
 M: Stephen Hemminger <stephen@networkplumber.org>
 F: drivers/net/af_packet/
-F: doc/guides/nics/features/afpacket.ini
+F: doc/guides/nics/features/af_packet.ini
 F: app/test/test_pmd_af_packet.c
 
 Linux AF_XDP
diff --git a/devtools/check-doc-vs-code.sh b/devtools/check-doc-vs-code.sh
index 80d77907f0..4dacb78b2e 100755
--- a/devtools/check-doc-vs-code.sh
+++ b/devtools/check-doc-vs-code.sh
@@ -36,30 +36,83 @@ has_file_change() # <pattern>
 	changed_files | grep -q "$1"
 }
 
+net_driver_from_path() # <path>
+{
+	sed -rn '
+		s,.*drivers/net/intel/([^/]*)/.*,\1,p; t
+		s,.*drivers/net/([^./]*)/.*,\1,p; t
+		s,.*doc/guides/nics/features/([^./]*).*,\1,p'
+}
+
 changed_net_drivers()
 {
-	net_paths='drivers/net/|doc/guides/nics/features/'
 	[ -n "$drivers" ] ||
 		drivers=$(changed_files |
-			sed -rn "s,^($net_paths)([^./]*).*,\2,p" |
+			net_driver_from_path |
 			sort -u)
 	echo "$drivers"
 }
 
 all_net_drivers()
 {
-	find $rootdir/drivers/net -mindepth 1 -maxdepth 1 -type d |
-	sed 's,.*/,,' |
-	sort
+	{
+		find $rootdir/drivers/net -name meson.build
+		ls $rootdir/doc/guides/nics/features/*.ini
+	} |
+	net_driver_from_path |
+	sort -u
+}
+
+driver_code_dir() # <driver>
+{
+	drv=$(echo "$1" | sed -r 's/_(dcf|vec|vf)$//')
+	case $drv in
+	enetc|enetc4)
+		echo "$rootdir/drivers/net/enetc" ;;
+	igb|igc|e1000)
+		echo "$rootdir/drivers/net/intel/e1000" ;;
+	ixgbe|i40e|ice|fm10k|ipn3ke|idpf|cpfl|iavf)
+		echo "$rootdir/drivers/net/intel/$drv" ;;
+	*)
+		echo "$rootdir/drivers/net/$drv" ;;
+	esac
+}
+
+# compare doc vs code items:
+# - if driver matches code dir: report differences in both directions
+# - otherwise: only report doc items not in code (shared code directory)
+flow_item_diff() # <driver> <code_dir> <doc_items> <code_items>
+{
+	{
+		[ -n "$3" ] && echo "$3"
+		[ -n "$4" ] && {
+			echo "$4"
+			[ "$1" != $(basename "$2") ] && echo "$4"
+		}
+	} | sort | uniq -u
 }
 
 check_rte_flow() # <driver>
 {
-	code=$rootdir/drivers/net/$1
+	code=$(driver_code_dir $1)
 	doc=$rootdir/doc/guides/nics/features/$1.ini
 	[ -d $code ] || return 0
 	[ -f $doc ] || return 0
-	report=$($selfdir/parse-flow-support.sh $code $doc)
+	code_support=$($selfdir/parse-flow-support.sh $code)
+	report=$(
+		for category in item action; do
+			section="rte_flow ${category}s]"
+			code_items=$(echo "$code_support" | sed -n "/$section/,/]/p" |
+				sed '/]/d' | sed 's, *=.*,,' | sed '/^$/d' | sort -u)
+			doc_items=$(sed -n "/$section/,/]/p" "$doc" |
+				sed '/]/d' | sed 's, *=.*,,' | sed '/^$/d' | sort -u)
+			if [ -n "$doc_items" ] || [ -n "$code_items" ]; then
+				flow_item_diff $1 $code "$doc_items" "$code_items"
+			fi |
+			grep . |
+			sed "s,^,$category ,"
+		done
+	)
 	if [ -n "$report" ]; then
 		error "rte_flow doc out of sync for $1"
 		echo "$report" | sed 's,^,\t,'
diff --git a/doc/guides/nics/features/afpacket.ini b/doc/guides/nics/features/af_packet.ini
similarity index 70%
rename from doc/guides/nics/features/afpacket.ini
rename to doc/guides/nics/features/af_packet.ini
index bc669dfb8a..b1cbc54aca 100644
--- a/doc/guides/nics/features/afpacket.ini
+++ b/doc/guides/nics/features/af_packet.ini
@@ -1,5 +1,5 @@
 ;
-; Supported features of the 'afpacket' network poll mode driver.
+; Supported features of the 'af_packet' network poll mode driver.
 ;
 ; Refer to default.ini for the full list of available PMD features.
 ;
diff --git a/doc/guides/nics/features/cxgbevf.ini b/doc/guides/nics/features/cxgbe_vf.ini
similarity index 90%
rename from doc/guides/nics/features/cxgbevf.ini
rename to doc/guides/nics/features/cxgbe_vf.ini
index a921cda6b1..b77b202272 100644
--- a/doc/guides/nics/features/cxgbevf.ini
+++ b/doc/guides/nics/features/cxgbe_vf.ini
@@ -1,5 +1,5 @@
 ;
-; Supported features of the 'cxgbevf' network poll mode driver.
+; Supported features of the 'cxgbe_vf' network poll mode driver.
 ;
 ; Refer to default.ini for the full list of available PMD features.
 ;
-- 
2.54.0

