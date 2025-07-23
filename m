Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA0FC83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 13:32:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D271B40E16;
	Wed, 23 Jul 2025 15:32:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3F52640E11
 for <dev@dpdk.org>; Wed, 23 Jul 2025 15:32:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753277559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PSUz1G5Asb+Z8gGAde26oIbMKtZuzTmcW83gulWMC2U=;
 b=EwdTN/DqQck6njqXcpcX4SSWpQn4M209rwhSC5W+iFSwwGy2ptE1K4Ovhv/LXKwGj54Hdk
 YkTYVou7VntLf48x/xEjybT1LRsbMKr6HIPREVVFocB5Ka6QZd7hTuGIlXQlo3QjPuoloF
 tcwK5xcoUWoctnA4/xDw/WOn4nmtlL4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-ng20HpuUNSC26dc374tttw-1; Wed,
 23 Jul 2025 09:32:36 -0400
X-MC-Unique: ng20HpuUNSC26dc374tttw-1
X-Mimecast-MFC-AGG-ID: ng20HpuUNSC26dc374tttw_1753277555
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B6DE1802DCE; Wed, 23 Jul 2025 13:32:18 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.51])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EBEEC195608D; Wed, 23 Jul 2025 13:32:15 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Marat Khalili <marat.khalili@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v5 02/22] test/telemetry: fix test calling all commands
Date: Wed, 23 Jul 2025 15:31:35 +0200
Message-ID: <20250723133157.159825-3-david.marchand@redhat.com>
In-Reply-To: <20250723133157.159825-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UPrL-0UW-n8sYUIatmkakVArnPJV1N4lamMYy5Tu86w_1753277555
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
index 34a99f93a1..d4c04f3b81 100644
--- a/.mailmap
+++ b/.mailmap
@@ -955,6 +955,7 @@ Manish Chopra <manishc@marvell.com>
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

