Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB68EB28D6
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 08:37:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D7F34029A;
	Fri,  6 Feb 2026 09:37:04 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8C19040293
 for <dev@dpdk.org>; Fri,  6 Feb 2026 09:37:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770367022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DzxVQPzSosAwfXlj6p/MyWDcVjUGjEvmew0aedOcW1s=;
 b=iz1T4xpOp0lpouKZQEDQwej2A3w5AenbzUcPUVsn+YJLbNoe46xjx7+GSQ6cAw33cqZQOn
 gR5UTmLcGCoWtV/srLbrn8g9RfrPsSRgHn7w3JjAFxGoexhNK1x6a1nQFKQZ8c5gxKP8np
 XbE7n7XWTsWZkCNIpWeWe0bYn8l5IUk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-DeNG0ZvyPSacfjbsrpMCEA-1; Fri,
 06 Feb 2026 03:36:58 -0500
X-MC-Unique: DeNG0ZvyPSacfjbsrpMCEA-1
X-Mimecast-MFC-AGG-ID: DeNG0ZvyPSacfjbsrpMCEA_1770367018
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6D6C1800349; Fri,  6 Feb 2026 08:36:57 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.34.76])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7637A1800465; Fri,  6 Feb 2026 08:36:56 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH] devtools: fix indent in SPDX check
Date: Fri,  6 Feb 2026 09:36:49 +0100
Message-ID: <20260206083649.2625478-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -wd6PPtSu_luV0FNrXzmfGOj9W1oAFcEV0k0CqzyKec_1770367018
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

We have a mix of tabs and spaces.
Clean this up.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 devtools/check-spdx-tag.sh | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/devtools/check-spdx-tag.sh b/devtools/check-spdx-tag.sh
index 2390941c74..a55d28581a 100755
--- a/devtools/check-spdx-tag.sh
+++ b/devtools/check-spdx-tag.sh
@@ -23,8 +23,8 @@ no_license_list=\
 
 check_spdx() {
     if $verbose ; then
-	echo "Files without SPDX License"
-	echo "--------------------------"
+        echo "Files without SPDX License"
+        echo "--------------------------"
     fi
 
     git grep -L SPDX-License-Identifier -- $no_license_list > $tmpfile
@@ -33,15 +33,15 @@ check_spdx() {
     $quiet || cat $tmpfile
 
     if $verbose ; then
-	echo
-	echo "Files with wrong SPDX format"
-	echo "----------------------------"
+        echo
+        echo "Files with wrong SPDX format"
+        echo "----------------------------"
     fi
 
     files_without_spdx=$(cat $tmpfile)
     git grep -LE '(/\*|#|;|\.\.) *SPDX-License-Identifier: [A-Z(]' -- $no_license_list > $tmpfile
     for file in $files_without_spdx ; do
-	sed -i "/^$file$/d" $tmpfile
+        sed -i "/^$file$/d" $tmpfile
     done
 
     warnings=$(($warnings + $(wc -l < $tmpfile)))
@@ -49,7 +49,7 @@ check_spdx() {
 
     files_with_andor=$(git grep -lEi 'SPDX-License-Identifier:.*\<(AND|OR)\>' -- $no_license_list)
     for file in $files_with_andor ; do
-	grep -LE 'SPDX-License-Identifier:.*\<(AND|OR)\>' "$file"
+        grep -LE 'SPDX-License-Identifier:.*\<(AND|OR)\>' "$file"
     done > $tmpfile
 
     warnings=$(($warnings + $(wc -l < $tmpfile)))
@@ -67,8 +67,8 @@ build_exceptions_list() {
 
 check_licenses() {
     if $verbose ; then
-	echo "Files with wrong license and no exception"
-	echo "-----------------------------------------"
+        echo "Files with wrong license and no exception"
+        echo "-----------------------------------------"
     fi
 
     exceptions=$(build_exceptions_list)
@@ -81,24 +81,23 @@ check_licenses() {
 
 check_boilerplate() {
     if $verbose ; then
-	echo "Files with redundant license text"
-	echo "---------------------------------"
+        echo "Files with redundant license text"
+        echo "---------------------------------"
     fi
 
-    git grep -l Redistribution -- \
-	':^license/' ':^/devtools/check-spdx-tag.sh' > $tmpfile
+    git grep -l Redistribution -- ':^license/' ':^/devtools/check-spdx-tag.sh' > $tmpfile
 
     warnings=$(($warnings + $(wc -l <$tmpfile)))
     $quiet || cat $tmpfile
 }
 
 while getopts qvh ARG ; do
-	case $ARG in
-		q ) quiet=true ;;
-		v ) verbose=true ;;
-		h ) print_usage ; exit 0 ;;
-		? ) print_usage ; exit 1 ;;
-	esac
+    case $ARG in
+        q ) quiet=true ;;
+        v ) verbose=true ;;
+        h ) print_usage ; exit 0 ;;
+        ? ) print_usage ; exit 1 ;;
+    esac
 done
 shift $(($OPTIND - 1))
 
-- 
2.52.0

