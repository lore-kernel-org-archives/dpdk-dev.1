Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08052C8303F
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 08:24:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8A0740651;
	Wed, 27 Aug 2025 10:24:41 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id EDF164065D
 for <dev@dpdk.org>; Wed, 27 Aug 2025 10:24:39 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id 4A1F81D000CF;
 Wed, 27 Aug 2025 04:24:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Wed, 27 Aug 2025 04:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1756283079; x=
 1756369479; bh=nVFrj08MoAxBUrwxQMuOan+ZJv5O4UHA461NLTl3IV8=; b=p
 yZxq4nEyFc5FjKawr9fGdtOYvrU4La38SHBhg26KT8dJiBkIs+uYj3GXZx10bFry
 N79uqjHntWFhZhToxhB2PAthbfN9lg8+JgJQDhVNeRH8ly3PI47vc22JB6+brVO5
 KSvlYeToZ3XhlXSi34Do3m7QkXtzO43c7xoHO40vNYYFbtrKvM+AGG5ywV8jqsC0
 7ZirGt82P35cU4lAeMdl2x6Jeu3HcwQJhW/z+56pgAyCsmZj6Kjpq+LtmtQdo8tO
 KjUus6KuSe5wqpmxOCBejxoxqU1Hi5/XXaPdBWMhz4O54QjlURJWblL6N+zoJxu3
 OIlMz7EGn2SmA0bUle5yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1756283079; x=1756369479; bh=n
 VFrj08MoAxBUrwxQMuOan+ZJv5O4UHA461NLTl3IV8=; b=Gaxk34ZBWFZ5h5O8i
 f2Uf2LCH8nstu6QJFH30/Cr1ZOVTzcBkfyhxX9Qj5K1bP0n3geOM+sfMoWun9Flf
 fyNxWBAC7Uti851hTpUtFQR0Xev6L9lGnXn19xJzkn3zhGFJKP7uySPbsn5JFBSi
 0+90WMXzlZVYWJ6ZZqrLOHH/XO/UeKpVZ/9kB73sF52oRA7NKKC65vZcMPBrEqoE
 O/VRKgAk5Q2dybiSW/OxL54ULka3AOzxtgOF1g8Z0JPcjswFECFXqH+1u1LWb3zC
 9DFXiG/99D+azYZC0pZ95LS+5mGuCOJTTDHcPPJWo0R/AWDGbELEz7ZJ2kNqYwJd
 NjNew==
X-ME-Sender: <xms:xsCuaMP0xF-QRvglOpoKJz1jbCBWzsM-_Ufum5bk5yuFsVHTZXIMEQ>
 <xme:xsCuaINyhoeq0rwt-NbGcwmZKPJLeywT_CKQUQWg39yt4QDljUt2pDQsQBJ1V6SnW
 nYHVnwfwm3ksagVzg>
X-ME-Received: <xmr:xsCuaE8TeILoPEfAO-XgiUaNBoUNsFER1OMdT4OGhp7A2fYeTtHv9AsOcWzh1lPvNkfar8YVDuTsNPT3aaMJJwe9H843zrk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeejieeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehmrgigihhmvgdrtghoqhhuvghlihhnsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:x8CuaM4olvGxNUvWYk9STEWodiQCha3AktY8AsIqU1ZtNmkKS4AFvA>
 <xmx:x8CuaL28Wi9zYI1FZNxLEtDUgJtsuV46sXU69nAP-PMN5HXMRBh5fQ>
 <xmx:x8CuaDCoNn0zg85YOvGNjAGGZwOX6xnOuknNpYR-oZhsaqN3PLI4tQ>
 <xmx:x8CuaN2nOLWqa3G1OYBEe1-bOjV5JaeLwYCDz5mMF67Zn_E1h0uWww>
 <xmx:x8CuaJbNuztHGP72eq4ZXKRPacyLPNidLTby2m09UBr2dWLhlLz-7OLx>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 04:24:38 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH 3/6] devtools: move uAPI processing into functions
Date: Wed, 27 Aug 2025 10:21:46 +0200
Message-ID: <20250827082413.1417226-4-thomas@monjalon.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250827082413.1417226-1-thomas@monjalon.net>
References: <20250827082413.1417226-1-thomas@monjalon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

There are two main parts in the Linux uAPI script:
- update the headers
- check the headers

In order to facilitate reading and rework,
these two parts are move in functions.

There is no change in the behavior.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 devtools/linux-uapi.sh | 96 +++++++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 43 deletions(-)

diff --git a/devtools/linux-uapi.sh b/devtools/linux-uapi.sh
index dc2f8bb36e..05f3ddf87c 100755
--- a/devtools/linux-uapi.sh
+++ b/devtools/linux-uapi.sh
@@ -11,7 +11,6 @@ base_path="kernel/linux/uapi/"
 version=""
 file=""
 check_headers=0
-errors=0
 
 print_usage()
 {
@@ -91,7 +90,35 @@ fixup_includes()
 	done
 }
 
-check_header() {
+update_all()
+{
+	local current_version=$(< $base_path/version)
+
+	if [ -n "$version" ]; then
+		if version_older_than "$version" "$current_version"; then
+			echo "Headers already up to date ($current_version >= $version)"
+			version=$current_version
+		else
+			update_headers
+		fi
+	else
+		echo "Version not specified, using current version ($current_version)"
+		version=$current_version
+	fi
+
+	if [ -n "$file" ]; then
+		import_header $file
+	fi
+
+	for filename in $(find $base_path -name "*.h" -type f); do
+		fixup_includes $filename
+	done
+
+	echo $version > $base_path/version
+}
+
+check_header()
+{
 	echo -n "Checking $1... "
 
 	if ! diff -q $1 $2 >/dev/null; then
@@ -105,6 +132,28 @@ check_header() {
 	return 0
 }
 
+check_all()
+{
+	local errors=0
+
+	tmpheader="$(mktemp -t dpdk.checkuapi.XXXXXX)"
+	trap "rm -f '$tmpheader'" INT
+
+	echo "Checking imported headers for version $version"
+	for filename in $(find $base_path -name "*.h" -type f); do
+		header=${filename#$base_path}
+		download_header $header $tmpheader
+		fixup_includes $tmpheader
+		check_header $filename $tmpheader || errors=$((errors+1))
+	done
+	echo "$errors error(s) found"
+
+	rm -f $tmpheader
+	trap - INT
+
+	return $errors
+}
+
 while getopts i:u:ch opt ; do
 	case $opt in
 		i ) file=$OPTARG ;;
@@ -123,49 +172,10 @@ fi
 
 cd $(dirname $0)/..
 
-current_version=$(< $base_path/version)
-
-if [ -n "$version" ]; then
-	if version_older_than "$version" "$current_version"; then
-		echo "Headers already up to date ($current_version >= $version)"
-		version=$current_version
-	else
-		update_headers
-	fi
-else
-	echo "Version not specified, using current version ($current_version)"
-	version=$current_version
-fi
-
-if [ -n "$file" ]; then
-	import_header $file
-fi
-
-for filename in $(find $base_path -name "*.h" -type f); do
-	fixup_includes $filename
-done
-
-echo $version > $base_path/version
+update_all
 
 if [ $check_headers -eq 0 ]; then
 	exit 0
 fi
 
-tmpheader="$(mktemp -t dpdk.checkuapi.XXXXXX)"
-trap "rm -f '$tmpheader'" INT
-
-echo "Checking imported headers for version $version"
-
-for filename in $(find $base_path -name "*.h" -type f); do
-	header=${filename#$base_path}
-	download_header $header $tmpheader
-	fixup_includes $tmpheader
-	check_header $filename $tmpheader || errors=$((errors+1))
-done
-
-echo "$errors error(s) found"
-
-rm -f $tmpheader
-trap - INT
-
-exit $errors
+check_all
-- 
2.47.1

