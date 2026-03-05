Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A69EF3D332
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 16:46:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A9CB40B92;
	Thu,  5 Mar 2026 17:46:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D573440E7C
 for <dev@dpdk.org>; Thu,  5 Mar 2026 17:46:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772729182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GVhwEwTYatOhpqvptILP170J+4ieruZdtg/n/A+yA3E=;
 b=At2VImfJY1ZOHvMzFV9O17ivfnHL4aH3bfPC/a/PwtAj4VsfeiL+nL8LSwX8eHxQHepcXF
 VxiAQG2kfEg5ji4xxuiyWHdLZEqsku5LOeP53+9WHBaUIzwehyDWi22XsR4zqqiCBxIElC
 1fLh6IVKwMrwT3nfgY08nrtW1azLUi0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-prK8YeTLMWamPRbLZH70ww-1; Thu,
 05 Mar 2026 11:46:18 -0500
X-MC-Unique: prK8YeTLMWamPRbLZH70ww-1
X-Mimecast-MFC-AGG-ID: prK8YeTLMWamPRbLZH70ww_1772729177
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37D8A189F81D; Thu,  5 Mar 2026 16:46:06 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.121])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 64DB01962CE2; Thu,  5 Mar 2026 16:46:03 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [RFC v3 1/7] devtools: check packet forwarding in null test
Date: Thu,  5 Mar 2026 17:45:43 +0100
Message-ID: <20260305164550.2067453-2-david.marchand@redhat.com>
In-Reply-To: <20260305164550.2067453-1-david.marchand@redhat.com>
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260305164550.2067453-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E5Dfb1y_xq6tDD4hpr1FNXdcH6a_MCfq1pM9Yu6lt0k_1772729177
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

Add some simple checks that testpmd was indeed polling two ports, and
some packets got through it.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 devtools/test-null.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/devtools/test-null.sh b/devtools/test-null.sh
index e3ac168ce3..8f21189262 100755
--- a/devtools/test-null.sh
+++ b/devtools/test-null.sh
@@ -26,8 +26,14 @@ else
 	libs=
 fi
 
+logfile=$build/test-null.log
 (sleep 1 && echo stop) |
 # testpmd only needs 20M, make it x2 (default number of cores) for NUMA systems
 $testpmd -l $corelist --no-huge -m 40 \
 	$libs -a 0:0.0 --vdev net_null1 --vdev net_null2 $eal_options -- \
-	--no-mlockall --total-num-mbufs=2048 $testpmd_options -ia
+	--no-mlockall --total-num-mbufs=2048 $testpmd_options -ia | tee $logfile
+
+# we expect two ports and some traffic is received and transmitted
+grep -q 'io packet forwarding - ports=2 -' $build/test-null.log
+grep 'RX-packets: ' $logfile | tail -1 | grep -q 'RX-packets:[[:space:]]*[^0[:space:]]'
+grep 'TX-packets: ' $logfile | tail -1 | grep -q 'TX-packets:[[:space:]]*[^0[:space:]]'
-- 
2.53.0

