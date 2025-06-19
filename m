Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1688EC71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 07:11:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93D6342E1D;
	Thu, 19 Jun 2025 09:11:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2782842E0B
 for <dev@dpdk.org>; Thu, 19 Jun 2025 09:11:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750317083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AJSDNUVz/68Rgwi1KHD+dIVFlS87CPxLYSItdMjJzqg=;
 b=fSKqv1wwAJWQTun+tHI2lKZsYe+BgV4H6CSeTsye70Mexzl+xbwBZWAb4c48PoUJazJUPT
 FA4MIo36fTOKbtV3hV39yyEtH8nTiaoTGQWKlE7ZCywlZhF9QN78NIt+GehJPHxlOzhiqh
 xBqv2yJc3qLLSVIft9oqpn6357+F5rI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-OLeMuIHvMfqgrBWWohGM5g-1; Thu,
 19 Jun 2025 03:11:22 -0400
X-MC-Unique: OLeMuIHvMfqgrBWWohGM5g-1
X-Mimecast-MFC-AGG-ID: OLeMuIHvMfqgrBWWohGM5g_1750317081
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6823E18001C6; Thu, 19 Jun 2025 07:11:21 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.8])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C256D180045B; Thu, 19 Jun 2025 07:11:19 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 02/10] test/telemetry: fix test calling all commands
Date: Thu, 19 Jun 2025 09:10:28 +0200
Message-ID: <20250619071037.37325-3-david.marchand@redhat.com>
In-Reply-To: <20250619071037.37325-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4mMpW5aZ2DWiGppaONn2q2J0IuhTNzG15L7l-J_Enok_1750317081
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

