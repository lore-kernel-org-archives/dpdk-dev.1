Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC9ACA0EFF
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 08:25:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77F2740666;
	Wed, 27 Aug 2025 10:24:49 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id 62C954065B
 for <dev@dpdk.org>; Wed, 27 Aug 2025 10:24:48 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id D4F1E1D0005E;
 Wed, 27 Aug 2025 04:24:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Wed, 27 Aug 2025 04:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1756283087; x=
 1756369487; bh=JFpnI0GQNPDMSwjSwwScHbM/9c3qy2MAULmXckjeXoI=; b=X
 PcZxEk0Ipuk0GDEyvw2xgGgrqG8ji68BaGcnbJ3bgkHBXOA7J4HSuRwYfCd1z8yl
 n0zxHIHE7lbgVc0P4yshf/VF5YU07Fc59pnXhJte2dmquf0d1VwjOou/uau9rVJR
 Xh85QbY95fWw6JiKR6xp1w3Y1rI7qvBv1/I/w8o+awydql5/u4gCaAloMATk85qo
 azGhIiPtTk3fHCLLpD+bunHffdGqyzPomFEOENPO4Lh4Bb3c2DJNdSmTJ3ZdY6Qd
 OnS7p6WVmbB3hhHj5+1PagPaLC5OwKeh2+wvVQddySL4+t3jNMHnZHkXmBjsvRob
 5MTp68ghdV4RgOKPxIiwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1756283087; x=1756369487; bh=J
 FpnI0GQNPDMSwjSwwScHbM/9c3qy2MAULmXckjeXoI=; b=EBkXT5/0NJ32U+iZk
 AUoukxVI+MxKHnSK8BFBsm9ybnPeLcFz127Cq/eDzFaywCt/Vj2/HZZ8zgkKtErm
 2nUMdhKsic4HlCBMSaiypRK9SUgmZ4MWMRw9bxZnL7I9o+Hcwve82LfwvOFSkkf9
 XZOYlDMWGOcR/Up89oPEG7946rU8hGws4GQRv6mXA2taqRm2e9nwO9V9S88txILU
 +sjlVyJSiwxVhZVR5o8fErgday8BnFDQxrR6V1jVAN1IZEdwP4qG28nYfVSlvYW0
 dIJ2+6k6CZvumYqvCs/20bPVpQ9q5wnvslIzH8Evb14B6cti9iln3CFkGmh1Xxpg
 F5aOA==
X-ME-Sender: <xms:z8CuaErjOfsobFIt0lKLif1uvayjAv58Ozr-mvEEedeLf-9_7Wih7g>
 <xme:z8CuaP5LEb1pT77BljRMpZ2M9w7F2UGCkQ5SsirIMciL0OBPNNlfesSR0GDvwhurf
 UM6SEdjAxRfA0sMRA>
X-ME-Received: <xmr:z8CuaK4uXzXw3PnlZOqyU6D6hRKDwLvN0BazuFjWz7go9UcAoDYfcWzC2S6Hu3Q_1CQKBLwOo9bFWr3NlyW7e_OAHGKEMAM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeejieeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehmrgigihhmvgdrtghoqhhuvghlihhnsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:z8CuaEEqKF6rdjsrbdE3HISZ6S4_S4MswQiY5fDbmCcAVKk0NwcoxQ>
 <xmx:z8CuaLSs1qYz_nORjnsA6j46BUdXVKeGTa3BDPPyWrmzpOgc5NGiLQ>
 <xmx:z8CuaFu-RyB_feiUfNiyWucSI90cXeELJPpUFYd4qAqyl3RKpkeY0A>
 <xmx:z8CuaCy6DTeePWdgvcpjGXW7PveGqkKW2okdHdUObG6FI7Q6-oYw-w>
 <xmx:z8CuaIXkfvGLroLd6T1fZnGcstV1PHygkrTBaUXtI2oKYMHCDFzXTm56>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 04:24:46 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH 6/6] devtools: add quiet mode in uAPI script
Date: Wed, 27 Aug 2025 10:21:49 +0200
Message-ID: <20250827082413.1417226-7-thomas@monjalon.net>
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

Most messages from the Linux uAPI script are not useful
when running the script in a regular fashion.
The quiet mode (option -q) is added to output only error messages if any.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 devtools/linux-uapi.sh | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/devtools/linux-uapi.sh b/devtools/linux-uapi.sh
index 0986b668de..9f9f08035f 100755
--- a/devtools/linux-uapi.sh
+++ b/devtools/linux-uapi.sh
@@ -11,6 +11,7 @@ base_path="kernel/linux/uapi/"
 version=""
 file=""
 check_headers=false
+quiet=false
 
 print_usage()
 {
@@ -43,7 +44,7 @@ update_headers()
 {
 	local header
 
-	echo "Updating to $version"
+	$quiet || echo "Updating to $version"
 	for filename in $(find $base_path -name "*.h" -type f); do
 		header=${filename#$base_path}
 		download_header $header $filename
@@ -65,7 +66,7 @@ import_header()
 	for include in $(sed -ne 's/^#include <\(.*\)>$/\1/p' $path); do
 		if [ ! -f "$base_path$include" ]; then
 			read -p "Import $include (y/n): " import && [ "$import" = 'y' ] || continue
-			echo "Importing $include for $path"
+			$quiet || echo "Importing $include for $path"
 			import_header "$include"
 		fi
 	done
@@ -92,13 +93,13 @@ update_all()
 {
 	if [ -n "$version" ]; then
 		if version_older_than "$version" "$current_version"; then
-			echo "Headers already up to date ($current_version >= $version)"
+			$quiet || echo "Headers already up to date ($current_version >= $version)"
 			version=$current_version
 		else
 			update_headers
 		fi
 	else
-		echo "Version not specified, using current version ($current_version)"
+		$quiet || echo "Version not specified, using current version ($current_version)"
 		version=$current_version
 	fi
 
@@ -115,14 +116,14 @@ update_all()
 
 check_header()
 {
-	echo -n "Checking $1... "
+	$quiet || echo -n "Checking $1... "
 
 	if ! diff -q $1 $2 >/dev/null; then
-		echo "KO"
-		diff -u $1 $2
+		$quiet || echo "KO"
+		$quiet || diff -u $1 $2
 		return 1
 	else
-		echo "OK"
+		$quiet || echo "OK"
 	fi
 
 	return 0
@@ -135,14 +136,16 @@ check_all()
 	tmpheader="$(mktemp -t dpdk.checkuapi.XXXXXX)"
 	trap "rm -f '$tmpheader'" INT
 
-	echo "Checking imported headers for version $version"
+	$quiet || echo "Checking imported headers for version $version"
 	for filename in $(find $base_path -name "*.h" -type f); do
 		header=${filename#$base_path}
 		download_header $header $tmpheader
 		fixup_includes $tmpheader
 		check_header $filename $tmpheader || errors=$((errors+1))
 	done
-	echo "$errors error(s) found"
+	if [ $errors -ne 0 ] || ! $quiet; then
+		echo "$errors error(s) found in Linux uAPI"
+	fi
 
 	rm -f $tmpheader
 	trap - INT
@@ -150,11 +153,12 @@ check_all()
 	return $errors
 }
 
-while getopts i:u:ch opt ; do
+while getopts i:u:cqh opt ; do
 	case $opt in
 		i ) file=$OPTARG ;;
 		u ) version=$OPTARG ;;
 		c ) check_headers=true ;;
+		q ) quiet=true ;;
 		h ) print_usage ; exit 0 ;;
 		? ) print_usage ; exit 1 ;;
 	esac
-- 
2.47.1

