Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B54CA0EFF
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 08:24:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 633F340616;
	Wed, 27 Aug 2025 10:24:38 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id 4AD9340616
 for <dev@dpdk.org>; Wed, 27 Aug 2025 10:24:37 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id A27941D00088;
 Wed, 27 Aug 2025 04:24:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 27 Aug 2025 04:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1756283076; x=
 1756369476; bh=qxyBSM0YTdrEcqMEPqtz6NEbzopAh9DnQjFCC+t6wy4=; b=l
 wjWmCS2gfmRmhwYJUrfelW48KGNX6aDnzaCn1Nr3G9AqA1W1t3GbWkv5Y4UvFTeO
 4lkp3G87zNTPUT/nhKrbvgFFcOwgsDVP981//k5welDYY3i9AbAILUzNQMZjBbnP
 LR3iSn2nYyj4tMrJB4yYPtBnkIqEDv79rTR/AEuqkiBAuQbJwyLFfhNStN0YPgFa
 wVrEvfPm6vR6SrFNcAUQ1dEZ89A33Rz9RfcYgrD2RNbkAHAcvSiFtggVsc8YzKpd
 SqEqxpB5n6TjANDtpLjFRKBwqZHjj9b+JuBph/mJgQXc5MXR5CiMYrVnzRRwOzTa
 hD3BNxixgkuyvTijUJ2Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1756283076; x=1756369476; bh=q
 xyBSM0YTdrEcqMEPqtz6NEbzopAh9DnQjFCC+t6wy4=; b=F+eVKsEXKFnNze9VR
 Y2N4ATsHabth/5LLnMELayHzv8nVgGWrITxqXg/tZ18Zp+h6BH4+ROoZhN0dMlgk
 LE7SUBszch/W5WATHb4O9JC9UXJ9AmKrYVbKae/LFg8unUtD5LbgWqwV85eioVfS
 kxynhks/aHRNbUOklhD5w6CPhoCLEEMwSvkusKlVKQDCzQd5d/ncFvEOOcwwHqe1
 xrLEdoSSuVuckQsDtyxZvBU/0dJzsTojnGdCC+jpJistyRgOvqeV1hGJUVuaX/Dq
 R8cPc93c8o+G2ZE0DpTNLdg31rKnO3/IvGRL04JfOiEg0+KGPGOBN29eK+BKzYWT
 eW5wQ==
X-ME-Sender: <xms:xMCuaNlA4kTGHa7LUfg0h5aHLRIszYDe7ALL2he7dqFvE1_VjnXlVw>
 <xme:xMCuaO0xOGkIfKB-bbW1jGDSY8gbfBmlh31XqwScpDnX21gT6jYr1tMnbxKcOCncm
 nrubUh4FEJjJDypvw>
X-ME-Received: <xmr:xMCuaBQmjQrwn7SPk0V83iDjuJge-WPG1Olh712X_sZiKcXa1YrPeyJo9mRGgyy0sk2cCX7S73tk2HaQ4ZSm8u2TuzmAnw8>
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
X-ME-Proxy: <xmx:xMCuaIt3meh6CJ9UAkEAgNM6yEJtaHGpOhvbJglt_a3u01P2rFUgGg>
 <xmx:xMCuaOZFqZLfsJpreLTRhKsKozx0MojuMGuS0pM28-pdnHAVTSWJlw>
 <xmx:xMCuaFtSfwhpzGzJpZZcneD4o1NFwGQ22CvnQXXpCbSzKqRquej0Tg>
 <xmx:xMCuaIGFrLMLv1qlIhTwniM-L7Iwt9gWqZDodCotYE0zVPdPZbmFbA>
 <xmx:xMCuaGKDHgt85YruFfDkhoPVM8HXL9ckAHqGNcUxdmJEhXk_OMgxdBVx>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 04:24:35 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH 2/6] devtools: remove superfluous fallbacks in uAPI script
Date: Wed, 27 Aug 2025 10:21:45 +0200
Message-ID: <20250827082413.1417226-3-thomas@monjalon.net>
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

The option -e was set on the script shebang (first line),
so the script will stop if an error is not caught.
Hence the explicit return or exit commands in case of error
were superfluous and can be removed.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 devtools/linux-uapi.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/devtools/linux-uapi.sh b/devtools/linux-uapi.sh
index 2000152607..dc2f8bb36e 100755
--- a/devtools/linux-uapi.sh
+++ b/devtools/linux-uapi.sh
@@ -49,7 +49,7 @@ update_headers()
 	echo "Updating to $version"
 	for filename in $(find $base_path -name "*.h" -type f); do
 		header=${filename#$base_path}
-		download_header $header $filename || return 1
+		download_header $header $filename
 	done
 
 	return 0
@@ -63,13 +63,13 @@ import_header()
 
 	local path="$base_path$header"
 
-	download_header $header $path || return 1
+	download_header $header $path
 
 	for include in $(sed -ne 's/^#include <\(.*\)>$/\1/p' $path); do
 		if [ ! -f "$base_path$include" ]; then
 			read -p "Import $include (y/n): " import && [ "$import" = 'y' ] || continue
 			echo "Importing $include for $path"
-			import_header "$include" || return 1
+			import_header "$include"
 		fi
 	done
 
@@ -130,7 +130,7 @@ if [ -n "$version" ]; then
 		echo "Headers already up to date ($current_version >= $version)"
 		version=$current_version
 	else
-		update_headers || exit 1
+		update_headers
 	fi
 else
 	echo "Version not specified, using current version ($current_version)"
@@ -138,11 +138,11 @@ else
 fi
 
 if [ -n "$file" ]; then
-	import_header $file || exit 1
+	import_header $file
 fi
 
 for filename in $(find $base_path -name "*.h" -type f); do
-	fixup_includes $filename || exit 1
+	fixup_includes $filename
 done
 
 echo $version > $base_path/version
@@ -158,8 +158,8 @@ echo "Checking imported headers for version $version"
 
 for filename in $(find $base_path -name "*.h" -type f); do
 	header=${filename#$base_path}
-	download_header $header $tmpheader || exit 1
-	fixup_includes $tmpheader || exit 1
+	download_header $header $tmpheader
+	fixup_includes $tmpheader
 	check_header $filename $tmpheader || errors=$((errors+1))
 done
 
-- 
2.47.1

