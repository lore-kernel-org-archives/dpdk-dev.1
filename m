Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8ACC83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 13:33:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B49140E18;
	Wed, 23 Jul 2025 15:33:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4933D40E4F
 for <dev@dpdk.org>; Wed, 23 Jul 2025 15:33:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753277597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S1/a5U6bdz9KNZENmpsF7Rw9vh9anFL5GWFQOqxGT6Y=;
 b=UbOFZR/8tDEPiPAZhKwxda7jXxVdmA+z255AY68YGdV8rTHO09oYuWWWMDn4lcGrsFuX/v
 uTZ4PVd2yVvFvWvn0/+EFWuGqIkvC/bZ2estQ8zPQ1tpC8+5uuWJmcVV/JDRV9r9YX6ikB
 fJCQih10LBN9iFRU848feBqfg5wWW/w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-nAgZIh57Mt6Feo6ov0yiSQ-1; Wed,
 23 Jul 2025 09:33:16 -0400
X-MC-Unique: nAgZIh57Mt6Feo6ov0yiSQ-1
X-Mimecast-MFC-AGG-ID: nAgZIh57Mt6Feo6ov0yiSQ_1753277586
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FA2F1800296; Wed, 23 Jul 2025 13:33:06 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.51])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 20617180045B; Wed, 23 Jul 2025 13:33:04 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 11/22] test/telemetry: catch errors in subshell
Date: Wed, 23 Jul 2025 15:31:44 +0200
Message-ID: <20250723133157.159825-12-david.marchand@redhat.com>
In-Reply-To: <20250723133157.159825-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ht24dx2H7agk7ik8_QyyCVI6Rp04LgFVdHNuxcXCaFc_1753277586
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

