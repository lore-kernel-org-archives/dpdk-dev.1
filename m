Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35F7C83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 13:02:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7C8240651;
	Wed, 16 Jul 2025 15:02:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id ADF3A4064F
 for <dev@dpdk.org>; Wed, 16 Jul 2025 15:02:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752670956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bO3jvITziNGLCjBwdY5UcRjceqpMM7rIKYgeeSVhUWw=;
 b=JZydGlennFIN0+9TppjQnz3PNP9NuCLaGqVpBBmXTajyJqlTM0hiPm9MSq8OCOWUx7T68i
 x5+u3At30t42xlfXSxahhv8ho4tiUxvsOVjgx9FuwfAq/ZfE0LuzhTdQNkSr0pu8h4zqJP
 vKbacKthzjUVvUlRtXCYpRbXWe8/D5c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-91d5RQpaP223ZD3rSYr1YA-1; Wed,
 16 Jul 2025 09:02:31 -0400
X-MC-Unique: 91d5RQpaP223ZD3rSYr1YA-1
X-Mimecast-MFC-AGG-ID: 91d5RQpaP223ZD3rSYr1YA_1752670950
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88A181800283; Wed, 16 Jul 2025 13:02:29 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.235])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F00051954213; Wed, 16 Jul 2025 13:02:26 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Marat Khalili <marat.khalili@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v4 02/22] test/telemetry: fix test calling all commands
Date: Wed, 16 Jul 2025 15:01:49 +0200
Message-ID: <20250716130212.1736407-3-david.marchand@redhat.com>
In-Reply-To: <20250716130212.1736407-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250716130212.1736407-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bBcfFcP9D5WcvMED9wANUrJMpLNuvmZHOoSX8gVhKDg_1752670950
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
Reviewed-by: Marat Khalili <marat.khalili@huawei.com>
---
 .mailmap                          | 1 +
 app/test/suites/test_telemetry.sh | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index c7d55c7386..728e700ffb 100644
--- a/.mailmap
+++ b/.mailmap
@@ -937,6 +937,7 @@ Manish Chopra <manishc@marvell.com>
 Manish Kurup <manish.kurup@broadcom.com>
 Manish Tomar <manish.tomar@nxp.com>
 Mao Jiang <maox.jiang@intel.com>
+Marat Khalili <marat.khalili@huawei.com>
 Marcel Apfelbaum <marcel@redhat.com>
 Marcel Cornu <marcel.d.cornu@intel.com>
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
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
2.50.0

