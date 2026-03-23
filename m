Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BFCEC01C9
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 10:53:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46E1F40659;
	Mon, 23 Mar 2026 11:53:23 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BA77B4064E
 for <dev@dpdk.org>; Mon, 23 Mar 2026 11:53:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774263201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GVhwEwTYatOhpqvptILP170J+4ieruZdtg/n/A+yA3E=;
 b=MNfu8+FA+oBs7J2/dbrw1JWD8ybipE7AlOwGIVuA73w/OJzMcjdcGRnLybYfiO1DmMDX94
 KpJt+/n1S56xbnDa9PkYpwrYC0aXXKKCbJNagh2H8zx+K8v6uh3w+gd6SsdKufEK1PJ4DH
 d1bvGuXQxGivJUMouMr5+LUFQRgE27Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-333LTmAiN62TVhwiVwO86A-1; Mon,
 23 Mar 2026 06:53:20 -0400
X-MC-Unique: 333LTmAiN62TVhwiVwO86A-1
X-Mimecast-MFC-AGG-ID: 333LTmAiN62TVhwiVwO86A_1774263199
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D60C195604F; Mon, 23 Mar 2026 10:53:18 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.173])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F37D7300019F; Mon, 23 Mar 2026 10:53:15 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 1/8] devtools: check packet forwarding in null test
Date: Mon, 23 Mar 2026 11:52:55 +0100
Message-ID: <20260323105306.1531689-2-david.marchand@redhat.com>
In-Reply-To: <20260323105306.1531689-1-david.marchand@redhat.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BuVvE5Lt_9trDUZfitmikf_a_Ag6TxC__eZb5Ua4t2I_1774263199
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

