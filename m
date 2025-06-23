Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A8BC77B7F
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 13:53:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C87E4065F;
	Mon, 23 Jun 2025 15:53:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 819514065E
 for <dev@dpdk.org>; Mon, 23 Jun 2025 15:53:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750686780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LGC6rtoAvxBH8K/PgihHLc7QFSGqFQpP0pitdHe760A=;
 b=Ik7KilsdQ6urZxcGUKKl58XDWW12p84RfqPILKlOwRJQHruyqyrD550BTDPr57ZaDXns1f
 c81Eo+K3Xwkld3vdfKiFwExExtxNMGvhkyrUv6i1welUGuyfOjKXQDQEfr1h1HKSk9CdG0
 QrMMw4msS/cr546cZWWa4tuG9nm3T+k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-alCLQIOqMlix9aoI6X7vJA-1; Mon,
 23 Jun 2025 09:52:59 -0400
X-MC-Unique: alCLQIOqMlix9aoI6X7vJA-1
X-Mimecast-MFC-AGG-ID: alCLQIOqMlix9aoI6X7vJA_1750686778
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5652A1808984; Mon, 23 Jun 2025 13:52:58 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.240])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CCEB9195608D; Mon, 23 Jun 2025 13:52:56 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 02/10] test/telemetry: fix test calling all commands
Date: Mon, 23 Jun 2025 15:52:32 +0200
Message-ID: <20250623135242.461965-3-david.marchand@redhat.com>
In-Reply-To: <20250623135242.461965-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250623135242.461965-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GQWUECbDvEiCM16GxS263giJT3WRwITmmU91pZ17aco_1750686778
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

This test was doing nothing as it could not find the telemetry client
script following the test suite rework.

Caught while looking at UNH unit test logs:

/root/workspace/Generic-Unit-Test-DPDK/dpdk/app/test/suites/test_telemetry.sh:
18: /root/workspace/Generic-Unit-Test-DPDK/dpdk/app/usertools/dpdk-telemetry.py:
not found

Fixes: 9da71dc4f96e ("test: add test case for scripted telemetry commands")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/suites/test_telemetry.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test/suites/test_telemetry.sh b/app/test/suites/test_telemetry.sh
index ca6abe266e..20806b43e4 100755
--- a/app/test/suites/test_telemetry.sh
+++ b/app/test/suites/test_telemetry.sh
@@ -7,7 +7,7 @@ which jq || {
     exit 77
 }
 
-rootdir=$(readlink -f $(dirname $(readlink -f $0))/../..)
+rootdir=$(readlink -f $(dirname $(readlink -f $0))/../../..)
 tmpoutput=$(mktemp -t dpdk.test_telemetry.XXXXXX)
 trap "cat $tmpoutput; rm -f $tmpoutput" EXIT
 
-- 
2.49.0

