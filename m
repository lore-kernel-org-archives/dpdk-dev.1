Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D065AC8303F
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 08:25:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E74D40667;
	Wed, 27 Aug 2025 10:24:45 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id 70B7340671
 for <dev@dpdk.org>; Wed, 27 Aug 2025 10:24:44 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id DC77C1D0010E;
 Wed, 27 Aug 2025 04:24:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 27 Aug 2025 04:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1756283083; x=
 1756369483; bh=RcOhKQ0Mfe3SRKOz+9Ct0BpRxJpNEdRtZQd18hjVufo=; b=N
 e8mnKG26+UUKBV6htN46rG/atpxfIvDIx/r94N1JpdwXqlJcTpiCfN6/d3IwX7aK
 W52lDTyPcz9al8C3Q3EsgOmOE0I+5tsTTE82L9W7j+oDq/VAQZ0KskamVOglvVFg
 jw3EEQWf8YDUPt4EnNncX4A/W8Vo+y0hgn4dOBQcF4FPOC3B30PB2TLlVKGjCQoL
 u2ospsEtKvJzQHeQ+ClPMIm4PZU4DCmfhcAmViMW+rXhGa3KWQuFzyZSjcNyGG+b
 UPpiNVzvfuA0ic0XfbaEeok2Y6nWaFyl4QLO28P9hYiNkpn8KJRsXqFJ/vFMP4e2
 4bdc4muM5khXLLk1asurQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1756283083; x=1756369483; bh=R
 cOhKQ0Mfe3SRKOz+9Ct0BpRxJpNEdRtZQd18hjVufo=; b=Wy+VsVW/tSjjPvacm
 G/K40u5a9vWOp/ydrndkFAN/T9XMumAP4vzGDI0n5MHegmGaUZDYQDt8TJSRC6G2
 /kXKWs5Cy06fqNZScaXyYC/pFzDjYqIeqt7YVezmpzlpTZPTBM5jOF+FoN7o57+H
 DryQX20CjC437TGL5EO+m8suyT2Uuix6TKDobCx1WpK1CmmmBavOvHBeTxIwjvyQ
 3OH7HXd6vSg10c/qOhff4rEXGXPwTnbrLrHCnZO7mU1LzywheFtlgakndVngonst
 kDSQ+V8OJx+TzxG9pMYf9JC6YDggusAbKiS71bUnsw6eKjsYUhdi1hUcaJS7d3FA
 Z9d7w==
X-ME-Sender: <xms:y8CuaN_F9TdOm1ZI2QQ9IesTPGdNlfYNgzNT4-VL6OgP2JBbdzdoGg>
 <xme:y8CuaG-j_n1LYSbPE7OiS1964KHilWHfZE4CxumrT0jZjSd8x89k2lFXXiGq5Afi_
 5ac-kkSRIaAa8ReKg>
X-ME-Received: <xmr:y8CuaMvvKDGJ2p3vgXqKRtyhIp2ofDhYDWFj2L0Hv4rTtGJNOmIziJSfKpIGtZ9JrtXY-dLJPKdyqK3mv0ximTvGo9W-hko>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeejieeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeeugeduhfetffdtheduffffueeigfelvdeguefghfeffffhfefffeff
 fffggfevkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhho
 nhdrnhgvthdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
 htohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepmhgrgihimhgvrdgtohhquhgv
 lhhinhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:y8CuaJpxSwPhV5QXrC2V7QVPSlKuv7RuNmcusxuw-QwuaXFuGuVFow>
 <xmx:y8CuaJkDAp3ZdiLFlvvXMl5khw8WiZG7tAyNpIcCqjVeOHhpcFswgg>
 <xmx:y8CuaNx76ZFd9c0yFbWHcA_616pYgtUExi88V1lnXOM_vdaP54e_WA>
 <xmx:y8CuaBlQGXrLAZRDQaMBtVE5mSoiHYXSW2fcq4kwy2PibZZwH-u_ug>
 <xmx:y8CuaFIor3CG_YbpRp3weQgYJLiUhOzwrQ7JD2DIFWfiHSXhoV_DVR7x>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 04:24:43 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH 5/6] devtools: make uAPI check exclusive to other options
Date: Wed, 27 Aug 2025 10:21:48 +0200
Message-ID: <20250827082413.1417226-6-thomas@monjalon.net>
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

When doing a check of Linux uAPI headers,
it is better to not fix them before.
Also, it does not make sense to check just after doing an update,
as the check would just repeat the same update process.
That's why a check is now run alone without any update.

The current version has to be retrieved in all cases,
so it is moved at the beginning of any processing.

If the check option (-c) is used with an import (-i) or an upgrade (-u),
an error is raised.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 devtools/linux-uapi.sh | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/devtools/linux-uapi.sh b/devtools/linux-uapi.sh
index 654c4a8c25..0986b668de 100755
--- a/devtools/linux-uapi.sh
+++ b/devtools/linux-uapi.sh
@@ -10,7 +10,7 @@ base_url="https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/pla
 base_path="kernel/linux/uapi/"
 version=""
 file=""
-check_headers=0
+check_headers=false
 
 print_usage()
 {
@@ -90,8 +90,6 @@ fixup_includes()
 
 update_all()
 {
-	local current_version=$(< $base_path/version)
-
 	if [ -n "$version" ]; then
 		if version_older_than "$version" "$current_version"; then
 			echo "Headers already up to date ($current_version >= $version)"
@@ -156,7 +154,7 @@ while getopts i:u:ch opt ; do
 	case $opt in
 		i ) file=$OPTARG ;;
 		u ) version=$OPTARG ;;
-		c ) check_headers=1 ;;
+		c ) check_headers=true ;;
 		h ) print_usage ; exit 0 ;;
 		? ) print_usage ; exit 1 ;;
 	esac
@@ -167,13 +165,17 @@ if [ $# -ne 0 ]; then
 	print_usage
 	exit 1
 fi
+if $check_headers && [ -n "$file" -o -n "$version" ]; then
+	echo "The option -c is incompatible with -i and -u"
+	exit 1
+fi
 
 cd $(dirname $0)/..
+current_version=$(cat $base_path/version)
 
-update_all
-
-if [ $check_headers -eq 0 ]; then
-	exit 0
+if $check_headers; then
+	version=$current_version
+	check_all
+else
+	update_all
 fi
-
-check_all
-- 
2.47.1

