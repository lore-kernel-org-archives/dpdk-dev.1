Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40ACCA0EFF
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 08:24:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DC294042E;
	Wed, 27 Aug 2025 10:24:35 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id CE83B402EA
 for <dev@dpdk.org>; Wed, 27 Aug 2025 10:24:33 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.stl.internal (Postfix) with ESMTP id 130541D0005E;
 Wed, 27 Aug 2025 04:24:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Wed, 27 Aug 2025 04:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1756283072; x=
 1756369472; bh=Byxktb7u1r80/wllqJRfirNcz4kr/231xlsKLDyfa2o=; b=F
 QHnJ2Cq9Sv3eXMw9PG8s0QQfwkjKr1jWMAjMzky1SFPIIAeOqNNc6p7U0jN1uvLJ
 /zC0it5+MyxpDtN1kNGCxFV6yWQfPHOi+VZ3LSuZRfm1z42YjlsaKD10SShu70Et
 cU+c+hFneyagOyD27em484SmqBRktV2eCCnKXgWoLI5foFvMqB4i9AcFu2V49O08
 te1W27A2sAjeWU1NvjAipzU66tLuFzWQMmTI0hz2lzx5AFwdILum6f37NbtP+lLr
 5dcOcqZGu6pTH7YJOOAI64sHNthndoknn5AphSj9c1ui8TCunUTUz6pA+qFFA5Ck
 7QmLgeW6/KsKXDH2ep4tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1756283072; x=1756369472; bh=B
 yxktb7u1r80/wllqJRfirNcz4kr/231xlsKLDyfa2o=; b=PGVcD6By3yCGF52yi
 f5moVLxxXuaX5J0bAaHPu3PLf6QoePQ8ePOxDFdgB0T/9RdPCoojIfrJczHQebZl
 NWSj19iRkI2PY5pe+cg8PzIQDbIXpT45FIWQvzyUI0cpn7E0qqA0wp6mfklXt4rB
 pw38xgp72lzlgwjENRerKgx8g0FpAUzGY+nUKm+xkD1ozWyZvzUywt9jmUSP3kLf
 wHIXKSJL8gcMTr32EI72aySL4ntEGJfhwS4T35bhGVpzJ4t2pO7bRejprpyYkwlg
 gBAxRkD13U0sEYVDrpYRbDAdPCEuXr9n/lf6h4Azso4hQXmKV9MLdlPqubR5BwAa
 /pQ2w==
X-ME-Sender: <xms:wMCuaD62II0Jwm-aiBjbr1xtBAdEO_clW5jsn8Zx1N4nPcQV8PXUfA>
 <xme:wMCuaOJV0E4rTgv-_WzuPsEf-1bIUgcXCr9OxKTN7ONdKG6euB-LmlF6NjipIV6Wn
 YjmKgSQTfWZH_ZS8A>
X-ME-Received: <xmr:wMCuaMI8ybyp2Ih0NWGVusvdf80NMk3q8uaqf3sVZg-C90PmeA8APU70ZjIoSuibGby76ddbkkJ_hAj3uyhg6BdF4uYTHOM>
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
X-ME-Proxy: <xmx:wMCuaMUgZqEo6HCDOfzKj01SwMxpCsL3RI7ZTkVAO7a973Z43p1MRA>
 <xmx:wMCuaOg6Y63Jd0cYWbPEnB4B55KiFp7wtlQQdfn_r5XxTSYYZ83A2Q>
 <xmx:wMCuaH8C02F5VCipXKAju8DUfaF8noBnivBRRKuR3sXD7lqH11EOjA>
 <xmx:wMCuaIAVwkeYFxdhNdfFrHb9VLUUaJrjuO1ltPPMp-OQxaqth9nnbg>
 <xmx:wMCuaFnzy5GZmf-BFtil5MA2qbNMLEPVqF79m8yK-lGqKOoko51byzTz>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 04:24:31 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH 1/6] devtools: remove superfluous curly braces in uAPI script
Date: Wed, 27 Aug 2025 10:21:44 +0200
Message-ID: <20250827082413.1417226-2-thomas@monjalon.net>
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

The use of curly braces for variables is inconsistent
in the Linux uAPI script.
It is chosen to remove all of them if not required.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 devtools/linux-uapi.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/devtools/linux-uapi.sh b/devtools/linux-uapi.sh
index ccd8b6816e..2000152607 100755
--- a/devtools/linux-uapi.sh
+++ b/devtools/linux-uapi.sh
@@ -30,7 +30,7 @@ download_header()
 	local header=$1
 	local path=$2
 
-	local url="${base_url}${header}?h=${version}"
+	local url="$base_url$header?h=$version"
 
 	if ! curl -s -f --create-dirs -o $path $url; then
 		echo "Failed to download $url"
@@ -61,12 +61,12 @@ import_header()
 	local import
 	local header=$1
 
-	local path="${base_path}${header}"
+	local path="$base_path$header"
 
 	download_header $header $path || return 1
 
 	for include in $(sed -ne 's/^#include <\(.*\)>$/\1/p' $path); do
-		if [ ! -f "${base_path}${include}" ]; then
+		if [ ! -f "$base_path$include" ]; then
 			read -p "Import $include (y/n): " import && [ "$import" = 'y' ] || continue
 			echo "Importing $include for $path"
 			import_header "$include" || return 1
@@ -85,8 +85,8 @@ fixup_includes()
 
 	# Prepend include path with "uapi/" if the header is imported
 	for include in $(sed -ne 's/^#include <\(.*\)>$/\1/p' $path); do
-		if [ -f "${base_path}${include}" ]; then
-			sed -i "s|${include}|uapi/${include}|g" $path
+		if [ -f "$base_path$include" ]; then
+			sed -i "s|$include|uapi/$include|g" $path
 		fi
 	done
 }
@@ -106,7 +106,7 @@ check_header() {
 }
 
 while getopts i:u:ch opt ; do
-	case ${opt} in
+	case $opt in
 		i ) file=$OPTARG ;;
 		u ) version=$OPTARG ;;
 		c ) check_headers=1 ;;
@@ -123,9 +123,9 @@ fi
 
 cd $(dirname $0)/..
 
-current_version=$(< ${base_path}/version)
+current_version=$(< $base_path/version)
 
-if [ -n "${version}" ]; then
+if [ -n "$version" ]; then
 	if version_older_than "$version" "$current_version"; then
 		echo "Headers already up to date ($current_version >= $version)"
 		version=$current_version
@@ -137,7 +137,7 @@ else
 	version=$current_version
 fi
 
-if [ -n "${file}" ]; then
+if [ -n "$file" ]; then
 	import_header $file || exit 1
 fi
 
@@ -145,7 +145,7 @@ for filename in $(find $base_path -name "*.h" -type f); do
 	fixup_includes $filename || exit 1
 done
 
-echo $version > ${base_path}/version
+echo $version > $base_path/version
 
 if [ $check_headers -eq 0 ]; then
 	exit 0
@@ -154,7 +154,7 @@ fi
 tmpheader="$(mktemp -t dpdk.checkuapi.XXXXXX)"
 trap "rm -f '$tmpheader'" INT
 
-echo "Checking imported headers for version ${version}"
+echo "Checking imported headers for version $version"
 
 for filename in $(find $base_path -name "*.h" -type f); do
 	header=${filename#$base_path}
-- 
2.47.1

