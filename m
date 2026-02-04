Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC095EA7944
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 20:50:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4203440DC9;
	Wed,  4 Feb 2026 21:49:59 +0100 (CET)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTP id 1DC3E40B9A
 for <dev@dpdk.org>; Wed,  4 Feb 2026 21:49:58 +0100 (CET)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfhigh.phl.internal (Postfix) with ESMTP id C94B01400109;
 Wed,  4 Feb 2026 15:49:57 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Wed, 04 Feb 2026 15:49:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1770238197; x=
 1770324597; bh=FglrvCdPdm9Y4jJdDHZ1y/WR+tmDqvqGMo+3Zsayhho=; b=j
 qLelyWzUeWISm3PlBj/sN7u8G0aF5FBx4lh20gzgS9ofL5v2RKY7DeZLeozHZPtt
 5dqfo+Fu91kqbJ7zgU1WHZqWXHkZxAIrC54Qg8RTclBIUngi9As8NGuLVzEEfOIM
 4mR/rvC5Sm18kc9WIOELmzN3M+Sj5dJqkSXMk7MQepqtfYu6cqddGfjigoeTunND
 9B5N+7zmLhfWthb3IleXxzB7tQ7u3VUCLHfF2ahbcc7tsLrSVoAre3f6O5x5xw7e
 4junWKlBqS8F0WyUZ3+ZFJwcYixNRtEyLdd7GgCTkntgYPFPEF7vfXMR2iW3f3Ui
 ILEbPZtsrliU0fP0EdaYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:date:feedback-id:feedback-id:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1770238197; x=1770324597; bh=FglrvCdPdm9Y4jJdDHZ1y/WR+tmD
 qvqGMo+3Zsayhho=; b=AHzHZRqEQDpe2pMdAm5HvblPWh7oLTflhAIsfz+4b7Z9
 qIrp9mHqNS9itytP8hKzvgIugzwzeNAz9PHzdzy4gy3jr9EDCyt/8lmR5sVIsm2Y
 H3nFEiNehV6ynNnaou9c4icEdzfx9G0SMqMPn9CqRkhJMJc7xEUCTWPLZHezil6+
 l1shScn0U+3SqOjjRA4U02s52mvMrvOXzn5cNHNu11sgmXRP/+I8SemPOUXEbQyl
 N/1TWKNW7vv+/JLDIRjgrUjQLyS4HTSdqDXqfe5P6awxG0xAZDQML9+wfyW8i3a3
 ri9ZclBgv5Rf7Jsd0oBmagRndoWDbAMlOMFOeNilXQ==
X-ME-Sender: <xms:9bCDaTfSAXyHrlU-SIWhF_LEledghMBfWS6d5qoJS7LoqRLKLJ_-Ww>
 <xme:9bCDafF89V6taxu288EXC88y5oXUBBaPNYLBXMAQLD3LXhzuJsslMFyTwjuRG4rqg
 LrwHpSp3m2NavBjdR1gka5bydK3xH2EMUu6FJ0pFrsQNLdsHfPS1Q>
X-ME-Received: <xmr:9bCDaXmFozG1FAe7h7wRbGJ3B9vvQPtlOVXQMGmXoNVifkB5KywgRHeJZDEXuQnz-RlGHBFuyhDeL1dfjjMIT8Gh4QfhLwk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeefgeegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
 dttdenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhho
 nhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeefkeeuhedtgfeugfelheffte
 eigefgvddvleegffejteeuvdffhedvveejgffhudenucffohhmrghinhepmhgrihhlmhgr
 phdrtghinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepuddpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:9bCDaRyftqwedTErFQ2LhK5OSqqBbmAOO0XmaTZNccmy8rBi2f5D6w>
 <xmx:9bCDaTRSpw4bc2bSNMpNQMxX_2SVXxEn1zcehsoOz3eJdpjBrKwrwQ>
 <xmx:9bCDaUs5ftlejYMru00nVEjUEzQc7zfWNtSzGVTAYIdOZxKXn8TQ4w>
 <xmx:9bCDaVu8gH42D1l8SELYfWYsEd0M72aEN50PyicaHXtVp9dWoS6jnQ>
 <xmx:9bCDaY-bLquWfyFtuCfN09t-1aleHycy42Cn-ns3c9PmpqLaWVcrEk1T>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for <dev@dpdk.org>; 
 Wed, 4 Feb 2026 15:49:57 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Subject: [PATCH v3 2/2] devtools: check SPDX syntax
Date: Wed,  4 Feb 2026 21:46:06 +0100
Message-ID: <20260204204945.3893117-3-thomas@monjalon.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204204945.3893117-1-thomas@monjalon.net>
References: <20251112091335.662991-1-thomas@monjalon.net>
 <20260204204945.3893117-1-thomas@monjalon.net>
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

The script check-spdx-tag.sh is updated to detect some syntax errors
in SPDX declaration:
        - the line must start with /* or # or ; or ..
        - AND / OR must be uppercased

The Markdown files (.md) are skipped as other text files.

The quiet mode (-q) is made really quiet if no issue is found.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 devtools/check-spdx-tag.sh | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/devtools/check-spdx-tag.sh b/devtools/check-spdx-tag.sh
index 984825026e..2390941c74 100755
--- a/devtools/check-spdx-tag.sh
+++ b/devtools/check-spdx-tag.sh
@@ -19,17 +19,41 @@ no_license_list=\
 ':^.git* :^.mailmap :^.ci/* :^README :^*/README* :^MAINTAINERS :^VERSION :^ABI_VERSION '\
 ':^license/ :^config/ :^buildtools/ :^*.abignore :^*.cocci :^*/poetry.lock '\
 ':^*/Kbuild :^kernel/linux/uapi/version '\
-':^*.ini :^*.data :^*.json :^*.cfg :^*.txt :^*.svg :^*.png'
+':^*.ini :^*.data :^*.json :^*.cfg :^*.txt :^*.md :^*.svg :^*.png'
 
 check_spdx() {
     if $verbose ; then
 	echo "Files without SPDX License"
 	echo "--------------------------"
     fi
+
     git grep -L SPDX-License-Identifier -- $no_license_list > $tmpfile
 
     missing_spdx=$(wc -l < $tmpfile)
     $quiet || cat $tmpfile
+
+    if $verbose ; then
+	echo
+	echo "Files with wrong SPDX format"
+	echo "----------------------------"
+    fi
+
+    files_without_spdx=$(cat $tmpfile)
+    git grep -LE '(/\*|#|;|\.\.) *SPDX-License-Identifier: [A-Z(]' -- $no_license_list > $tmpfile
+    for file in $files_without_spdx ; do
+	sed -i "/^$file$/d" $tmpfile
+    done
+
+    warnings=$(($warnings + $(wc -l < $tmpfile)))
+    $quiet || cat $tmpfile
+
+    files_with_andor=$(git grep -lEi 'SPDX-License-Identifier:.*\<(AND|OR)\>' -- $no_license_list)
+    for file in $files_with_andor ; do
+	grep -LE 'SPDX-License-Identifier:.*\<(AND|OR)\>' "$file"
+    done > $tmpfile
+
+    warnings=$(($warnings + $(wc -l < $tmpfile)))
+    $quiet || cat $tmpfile
 }
 
 build_exceptions_list() {
@@ -46,6 +70,7 @@ check_licenses() {
 	echo "Files with wrong license and no exception"
 	echo "-----------------------------------------"
     fi
+
     exceptions=$(build_exceptions_list)
     git grep -l SPDX-License-Identifier: -- $no_license_list $exceptions |
     xargs grep -L -E 'SPDX-License-Identifier:[[:space:]]*(\(?|.* OR )BSD-3-Clause' > $tmpfile
@@ -63,7 +88,7 @@ check_boilerplate() {
     git grep -l Redistribution -- \
 	':^license/' ':^/devtools/check-spdx-tag.sh' > $tmpfile
 
-    warnings=$(wc -l <$tmpfile)
+    warnings=$(($warnings + $(wc -l <$tmpfile)))
     $quiet || cat $tmpfile
 }
 
@@ -89,5 +114,7 @@ $verbose && echo
 check_boilerplate
 $verbose && echo
 
-echo "total: $missing_spdx missing SPDX, $wrong_license license errors, $warnings warnings"
+if [ $missing_spdx -gt 0 -o $wrong_license -gt 0 -o $warnings -gt 0 ] || ! $quiet ; then
+    echo "total: $missing_spdx missing SPDX, $wrong_license license errors, $warnings warnings"
+fi
 exit $((missing_spdx + wrong_license))
-- 
2.52.0

