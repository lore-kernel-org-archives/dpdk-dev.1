Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8582E106F31D
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 10:25:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0991427E4;
	Thu, 26 Mar 2026 11:25:03 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A9899427E2
 for <dev@dpdk.org>; Thu, 26 Mar 2026 11:25:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774520701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KvF19WRVh2SkWxm/c88gvIXIqNp/CFSw6Kby3QmTf/Y=;
 b=Co0rLuxYcW2fDFNGBEiOoNcJ0FyvOw08jfvr7TXfH9yovkRxxinxlEccIa4P/LQ4WsK2tx
 S1K8sCS+9vnklx8e3tasFreZRKLbBm1QtVXKcHBXDytDcvPqvljJF1zJNpvei8Lih3HsQD
 1/A2bacu8RJRZEYa8mihRpAx1bj4zyg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-wGi-ba5YO_qFaUpz_qni3g-1; Thu,
 26 Mar 2026 06:25:00 -0400
X-MC-Unique: wGi-ba5YO_qFaUpz_qni3g-1
X-Mimecast-MFC-AGG-ID: wGi-ba5YO_qFaUpz_qni3g_1774520699
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 220D51956046; Thu, 26 Mar 2026 10:24:58 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.173])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 67E393000223; Thu, 26 Mar 2026 10:24:55 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Maxime Leroy <maxime@leroys.fr>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 1/7] devtools: check packet forwarding in null test
Date: Thu, 26 Mar 2026 11:24:17 +0100
Message-ID: <20260326102424.2361945-2-david.marchand@redhat.com>
In-Reply-To: <20260326102424.2361945-1-david.marchand@redhat.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260326102424.2361945-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EIkCOUjwm3RogDRm-S_Lt3hYuXwXBeZUjqMGFU0QH98_1774520699
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
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
Tested-by: Maxime Leroy <maxime@leroys.fr>
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

