Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB1BCFD376
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 14:41:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B46940281;
	Fri, 28 Nov 2025 15:41:37 +0100 (CET)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id E6368400EF
 for <dev@dpdk.org>; Fri, 28 Nov 2025 15:41:35 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 663BD14001F3;
 Fri, 28 Nov 2025 09:41:35 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Fri, 28 Nov 2025 09:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1764340895; x=
 1764427295; bh=1OTe8eeL3CarRkXxC0TC8nEn6h6iBG2gR0zIOCYRYrY=; b=n
 qnC5msVMOuq/PlWM6LI6dmQzVk+QBTkxYOMMx+eTZfHc+IyUU9MKjrxXHYeyJj/K
 lQJpr9o1bRdgsLewGzxUVKR56SJwU2gAkMiXcBi3473N8cdCIu20PxiQlBbKv2TL
 feM9kWTKTLY14pZHcXiYs23LXmY6O0Z2Y7krjcLk9hDfDWIrsME2eLQKBXF7FuqI
 DxPJ7gRO9bjlMTYBh9cqEg27bPNQlp5JM5rr6SDf/dBLWM6wM6vzLAHDzhiSvfsX
 p+ir1djO3+Ao1IePVo9dDL3QMl3szaPjwHwE6kpsB3iG6hn8TTM8g13GzeLFNq/+
 8zNJmyCia/eHn9+wL5XmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1764340895; x=1764427295; bh=1
 OTe8eeL3CarRkXxC0TC8nEn6h6iBG2gR0zIOCYRYrY=; b=sR0QizCJnPbhjUUMx
 TveZbYXVJOfxueTsrYsjBVK26gtjw/40G03cRPD6CM294iloSqX7GN+bUTzvJPni
 +VzN6QMAM8L21lSUsBTMKQIhS3zV2Yi3oYugHTYA64R/v+yVExNzJ+m8EhTZLhD/
 KAFrp3ppmzfnPfbNmVv94Q3TZCcgFkCykIrm7NLPrWDLsSgvmpDqjRVusBn9z0bE
 m6Xm6ufs5GY/XPEJb2uDArX1cyyBUNpeaDyRNG4NdGm9MsUfwEoAfrCULG9vlNDZ
 ZrOas/RRQYcVJxIGt6VmI8ki9OAuvnHRk5TJEBeb6JElDDeBPiV6IceC7MzJS3EE
 eZY1Q==
X-ME-Sender: <xms:nrQpaVQzdOOOTTkdOy-wWPfhQ1VfJGY9bzoaHZW5snN8xut5RaUhCw>
 <xme:nrQpabE_sik-GUXPYQgkHaSbDuq9E-_utALuN3OsIJHuEXKmZZAArrwIRY50SpaH5
 1w0zX2BnJ291Yu8KrVjgIwxRuYsyWKu3nMEWUZ1n41a4aNWnstgZQ>
X-ME-Received: <xmr:nrQpadktSSodNufhUaPy-z0XE4Ef3mcvQXHZekZL0l4jo-ObaXpDnBfVuZg9eOubWmSwYRM4vosZVsObzwDXDZZJGaHE2X8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvhedtudehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopegrlhhirghlnhhusehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:nrQpae0a-QqpOVazzAQMoxOtSzETT_7Mo5zJ3Y3Uo1C6z87kCh-P8w>
 <xmx:nrQpaRRbBgdhokWIBh9ry-hkquREhxh7hofkpuhru91XT-8sru5xMw>
 <xmx:nrQpaYsI0ykmMQAnOf5T1LtAwPECzdGXmkGbNSwiOA1lMHrSfaLMNw>
 <xmx:nrQpaeYCcrx6Z7kmdKw1MeJma-jNOMTY3YXdoehpBzwNmHu0Htc70g>
 <xmx:n7QpaQThLo_MayqrEz4o5A4GzjDPOsXk64JUhrnCQvbsWl8LaO8wSR7p>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Nov 2025 09:41:34 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Ali Alnubani <alialnu@nvidia.com>
Subject: [PATCH v2] devtools: check patch from stdin only if nothing else
Date: Fri, 28 Nov 2025 15:40:48 +0100
Message-ID: <20251128144127.1552516-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <26063275.kmuVQn2iE0@thomas>
References: <26063275.kmuVQn2iE0@thomas>
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

From: Ali Alnubani <alialnu@nvidia.com>

The checkpatches.sh script was checking if stdin is a terminal before
honoring the -n flag, causing it to incorrectly attempt to read patches
from stdin when run without a TTY (e.g., in Jenkins/CI pipelines).

Reorder the conditionals to check for the -n and -r flags
before checking stdin state.
This ensures the -n/-r flags takes precedence
and the script checks git commits as intended.

Signed-off-by: Ali Alnubani <alialnu@nvidia.com>
Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
v2: make also -r a priority (before considering stdin)
---
 devtools/checkpatches.sh | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
index 9fb8fd0a07..47e8ca57b4 100755
--- a/devtools/checkpatches.sh
+++ b/devtools/checkpatches.sh
@@ -421,8 +421,8 @@ check_release_notes() { # <patch>
 		grep -v $current_rel_notes
 }
 
-number=0
-range='origin/main..'
+number=
+range=
 quiet=false
 verbose=false
 while getopts hn:qr:v ARG ; do
@@ -558,17 +558,20 @@ if [ -n "$1" ] ; then
 	for patch in "$@" ; do
 		check "$patch" ''
 	done
-elif [ ! -t 0 ] ; then # stdin
-	check '' ''
-else
-	if [ $number -eq 0 ] ; then
-		commits=$(git rev-list --reverse $range)
-	else
+elif [ -n "$number" ] || [ -n "$range" ] || [ -t 0 ]; then
+	if [ -n "$number" ] ; then
 		commits=$(git rev-list --reverse --max-count=$number HEAD)
+	else
+		if [ -z "$range" ] ; then
+			range='origin/main..' # default
+		fi
+		commits=$(git rev-list --reverse $range)
 	fi
 	for commit in $commits ; do
 		check '' $commit
 	done
+else # stdin
+	check '' ''
 fi
 pass=$(($total - $status))
 $quiet || printf '\n%d/%d valid patch' $pass $total
-- 
2.51.0

