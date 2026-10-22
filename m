Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5FE606A31E
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q3mqFa5W
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 962ED406A2;
	Thu, 22 Oct 2026 19:45:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E5FEC40687
 for <dev@dpdk.org>; Thu, 22 Oct 2026 19:45:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792691116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0VMAc+uAABgYnHhO9Q4a7k2bUhHnm2MO82kvYoLSXms=;
 b=Q3mqFa5W/nV35GmezgKyShj3ZtXb4h3MBvQsAAnH5LFlh4AcMH5Bmn4bO3x1baVlvUhMyE
 1Jemt/hyH1SXIlk0D82uIL7mGuP3AC+U8KbfZ1i7QdlCnjuPbYbaSufiKWlEtyOTuOfARO
 3AN74wSuyyinxXuJsTYVp6RG8duJWFw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-9sgfySnaMwumvkoKiesKzA-1; Thu,
 22 Oct 2026 13:45:12 -0400
X-MC-Unique: 9sgfySnaMwumvkoKiesKzA-1
X-Mimecast-MFC-AGG-ID: 9sgfySnaMwumvkoKiesKzA_1792691110
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91CE91955DB4; Thu, 22 Oct 2026 17:45:10 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7978A767; Thu, 22 Oct 2026 17:45:09 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 04/13] devtools: handle multiple drivers in doc check
Date: Thu, 22 Oct 2026 19:44:31 +0200
Message-ID: <20261022174447.412638-5-david.marchand@redhat.com>
In-Reply-To: <20261022174447.412638-1-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261022174447.412638-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: R4g8s9253AKV9Dp7mTzfj5QcgVCs_WEx5xKMOd41hCo_1792691110
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

Some drivers have multiple doc files sharing one code directory
(e.g., igb, igc, e1000 variants). Others have doc files for VF/DCF
variants (e.g., ice_dcf, ixgbe_vf).

Extend driver_code_dir() to strip variant suffixes and map driver
names to their shared code directories.

Build a cache mapping each code directory to its associated doc
files. Add docs_for_code() to retrieve all doc names for a given
code directory.

Add items_not_in() to compute set difference between two lists.
Use it in check_rte_flow() to compare doc vs code items:
- items documented but not in code are always reported,
- items in code but not documented in any doc for the code
  directory are reported, avoiding false positives when multiple
  docs share the same code.

Also rename doc files to match their code directory names.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v2:
- introduced logic earlier in the series,
- added comments and implemented for rte_flow checks,

---
 MAINTAINERS                                   |   2 +-
 devtools/check-doc-vs-code.sh                 | 109 +++++++++++++++---
 .../features/{afpacket.ini => af_packet.ini}  |   2 +-
 .../features/{cxgbevf.ini => cxgbe_vf.ini}    |   2 +-
 4 files changed, 98 insertions(+), 17 deletions(-)
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
index e141fe9938..7afc18d153 100755
--- a/devtools/check-doc-vs-code.sh
+++ b/devtools/check-doc-vs-code.sh
@@ -36,35 +36,86 @@ has_file_change() # <pattern>
 	changed_files | grep -q "$1"
 }
 
+net_driver_from_path() # <path>
+{
+	sed -rn '
+		s,.*drivers/net/intel/([^/]*)/.*,\1,p; t
+		s,.*drivers/net/([^./]*)/.*,\1,p; t
+		s,.*doc/guides/nics/features/([^./]*).*,\1,p' |
+	grep -v '^default$'
+}
+
 changed_net_drivers()
 {
 	[ -n "$drivers" ] ||
 		drivers=$(changed_files |
-			sed -rn '
-				s,^drivers/net/intel/([^/]*).*,\1,p; t
-				s,^drivers/net/([^/]*).*,\1,p; t
-				s,^doc/guides/nics/features/([^.]*).*,\1,p' |
+			net_driver_from_path |
 			sort -u)
 	echo "$drivers"
 }
 
 all_net_drivers()
 {
-	find $rootdir/drivers/net -name meson.build |
-	sed -rn '
-		s,.*drivers/net/intel/([^/]*).*,\1,p; t
-		s,.*drivers/net/([^/]*).*,\1,p' |
+	{
+		find $rootdir/drivers/net -name meson.build
+		ls $rootdir/doc/guides/nics/features/*.ini
+	} |
+	net_driver_from_path |
 	sort -u
 }
 
 # give back a driver directory for a doc/driver name
 driver_code_dir() # <driver_name>
 {
-	if [ -d $rootdir/drivers/net/intel/$1 ]; then
-		echo "$rootdir/drivers/net/intel/$1"
-	else
-		echo "$rootdir/drivers/net/$1"
-	fi
+	drv=$(echo "$1" | sed -r 's/_(dcf|vec|vf)$//')
+	case $drv in
+	enetc|enetc4)
+		echo "$rootdir/drivers/net/enetc" ;;
+	igb|igc|e1000)
+		echo "$rootdir/drivers/net/intel/e1000" ;;
+	*)
+		if [ -d $rootdir/drivers/net/intel/$drv ]; then
+			echo "$rootdir/drivers/net/intel/$drv"
+		else
+			echo "$rootdir/drivers/net/$drv"
+		fi ;;
+	esac
+}
+
+# create a cache of the mapping between a driver code directory and associated driver docs
+# format of this cache is:
+# ^,$drv1_directory: $drv1_doc_name1 $drv1_doc_name2,$drv2_directory: $drv2_doc_name1,...,$
+doc_code_map=","
+for d in $rootdir/doc/guides/nics/features/*.ini; do
+	drv=$(basename "$d" .ini)
+	[ "$drv" != 'default' ] || continue
+	code=$(driver_code_dir $drv)
+	case $doc_code_map in
+	*,$code:*)
+		before=${doc_code_map%,$code:*}
+		after=${doc_code_map#*,$code:}
+		drvs=${after%%,*}
+		rest=${after#*,}
+		doc_code_map="$before,$code:$drvs $drv,$rest" ;;
+	*)
+		doc_code_map="$doc_code_map$code: $drv," ;;
+	esac
+done
+
+# extract all doc names from the cache created above
+docs_for_code() # <code_dir>
+{
+	tmp=${doc_code_map#*,$1:}
+	echo ${tmp%%,*}
+}
+
+# output items from first list that are not in second list
+items_not_in() # <list1> <list2>
+{
+	{
+		[ -n "$1" ] && echo "$1"
+		[ -n "$2" ] && { echo "$2"; echo "$2"; }
+	} | sort | uniq -u
 }
 
 check_rte_flow() # <driver>
@@ -73,7 +124,37 @@ check_rte_flow() # <driver>
 	doc=$rootdir/doc/guides/nics/features/$1.ini
 	[ -d $code ] || return 0
 	[ -f $doc ] || return 0
-	report=$($selfdir/parse-flow-support.sh $code $doc)
+	code_support=$($selfdir/parse-flow-support.sh $code)
+	report=$(
+		for category in item action; do
+			section="rte_flow ${category}s]"
+			code_items=$(echo "$code_support" | sed -n "/$section/,/]/p" |
+				sed '/]/d' |        # ignore section title
+				sed 's, *=.*,,' |   # keep only item name
+				sed '/^$/d' |       # remove empty lines
+				sort -u)
+			doc_items=$(sed -n "/$section/,/]/p" "$doc" |
+				sed '/]/d' |        # ignore section title
+				sed 's, *=.*,,' |   # keep only item name
+				sed '/^$/d' |       # remove empty lines
+				sort -u)
+			{
+				# items documented but not in code
+				items_not_in "$doc_items" "$code_items"
+				# items in code but not documented in any doc for the code directory
+				all_doc_items=$(
+					for drv in $(docs_for_code $code); do
+						d=$rootdir/doc/guides/nics/features/$drv.ini
+						sed -n "/$section/,/]/p" "$d" |
+							sed '/]/d' |        # ignore section title
+							sed 's, *=.*,,' |   # keep only item name
+							sed '/^$/d'         # remove empty lines
+					done | sort -u
+				)
+				items_not_in "$code_items" "$all_doc_items"
+			} | sed "s,^,$category ,"   # prefix with category name
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

