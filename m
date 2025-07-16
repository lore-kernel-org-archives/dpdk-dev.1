Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D99C83F1B
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 13:04:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B27C640672;
	Wed, 16 Jul 2025 15:03:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B481240677
 for <dev@dpdk.org>; Wed, 16 Jul 2025 15:03:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752671000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S1/a5U6bdz9KNZENmpsF7Rw9vh9anFL5GWFQOqxGT6Y=;
 b=IsosRj0/kYAwp87fmLesP8lLC1BcgD/rxPVB/k2pg4/J/OycdUoYLd2v+uYe1IA1UcUugQ
 afPUdb8TflxDU0ce3bAMQdymiOWcMThSKBLYSVcMzDFr/hDf6SaqLF1wkDRDxMV/d4tdPN
 32TII0erTfNLY6Vnvmdz1IqX5hZ9FWE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-qZzitMQkO7y-UqcU4r_vXA-1; Wed,
 16 Jul 2025 09:03:18 -0400
X-MC-Unique: qZzitMQkO7y-UqcU4r_vXA-1
X-Mimecast-MFC-AGG-ID: qZzitMQkO7y-UqcU4r_vXA_1752670997
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9E4B19560AA; Wed, 16 Jul 2025 13:03:17 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.235])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7352318016F9; Wed, 16 Jul 2025 13:03:16 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 11/22] test/telemetry: catch errors in subshell
Date: Wed, 16 Jul 2025 15:01:58 +0200
Message-ID: <20250716130212.1736407-12-david.marchand@redhat.com>
In-Reply-To: <20250716130212.1736407-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250716130212.1736407-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Y53WMR5NQ2zo0ecJbkO0xmvoDzNzyl3z_Tb76hvAnqY_1752670997
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

