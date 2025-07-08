Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14684C8303C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 12:31:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61573406BB;
	Tue,  8 Jul 2025 14:31:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 28B6C4028C
 for <dev@dpdk.org>; Tue,  8 Jul 2025 14:31:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751977869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S1/a5U6bdz9KNZENmpsF7Rw9vh9anFL5GWFQOqxGT6Y=;
 b=FcOFSdGc0U2KH4evoVNx0AyX9O3p951UT/eaHfhWPxZbCZoavzcZ4SQrFBXPgZu6FMlkId
 yASjqSCVNaDQNpUXAeViP3aielg73qH0seoDoAtZWdjuqLKcN6QVWG/4awoQXbcX9n6p/U
 zuNasoKcSUxIT6YtZneNz4odqQHlASE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-s7OXONTvPa-y5mhMiC9IMg-1; Tue,
 08 Jul 2025 08:31:08 -0400
X-MC-Unique: s7OXONTvPa-y5mhMiC9IMg-1
X-Mimecast-MFC-AGG-ID: s7OXONTvPa-y5mhMiC9IMg_1751977867
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B424A19560A6; Tue,  8 Jul 2025 12:31:07 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.95])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6D65C18003FC; Tue,  8 Jul 2025 12:31:06 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 11/18] test/telemetry: catch errors in subshell
Date: Tue,  8 Jul 2025 14:28:15 +0200
Message-ID: <20250708122823.3406288-12-david.marchand@redhat.com>
In-Reply-To: <20250708122823.3406288-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250708122823.3406288-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MAYCZKVEC1XEx7mLqWi_qg5xYGL6CHIKepNLJXWqWeY_1751977867
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

This script relies on subshell and pipes to prepare a list of commands
to pass to the telemetry script.

However, errors are not propagated to the parent process and the test
may still pass when an error occurs.
There is no POSIX option to cleanly catch all errors, so rely on bash
options (as some CI envs run with bash).

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 app/test/suites/test_telemetry.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/app/test/suites/test_telemetry.sh b/app/test/suites/test_telemetry.sh
index 20806b43e4..3c5b629b63 100755
--- a/app/test/suites/test_telemetry.sh
+++ b/app/test/suites/test_telemetry.sh
@@ -15,7 +15,7 @@ call_all_telemetry() {
     telemetry_script=$rootdir/usertools/dpdk-telemetry.py
     echo >$tmpoutput
     echo "Telemetry commands log:" >>$tmpoutput
-    for cmd in $(echo / | $telemetry_script | jq -r '.["/"][]')
+    echo / | $telemetry_script | jq -r '.["/"][]' | while read cmd
     do
         for input in $cmd $cmd,0 $cmd,z
         do
@@ -25,4 +25,6 @@ call_all_telemetry() {
     done
 }
 
+! set -o | grep -q errtrace || set -o errtrace
+! set -o | grep -q pipefail || set -o pipefail
 (sleep 1 && call_all_telemetry && echo quit) | $@
-- 
2.50.0

