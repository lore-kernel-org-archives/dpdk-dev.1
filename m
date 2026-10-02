Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51EDCA5FD4
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 09:18:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7282427BB;
	Fri,  2 Oct 2026 11:18:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 07FC4427B9
 for <dev@dpdk.org>; Fri,  2 Oct 2026 11:18:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790932702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QVQtvIoSumIyxvRWjxMqIyUpEEpmVZjfPkQjF1Y9/xc=;
 b=EK5lBoewmvsmPTOWKYN7wYE138T9p0xTqkSuHnODWGQ/f90mPw/nHue6RZunXuTl5aOFHl
 FN/dmN6UG7s+oeX9JEDlmNNnLZukDHrKj2CgR+7Cuw1EzURMIeQsmYgh12rK5ezJlo91W4
 AwXT5XFKHSZCR3Xn+8D/IXOag/QBQyg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-PPwM5KHjMJmy-tu0M7Sqng-1; Fri,
 02 Oct 2026 05:18:19 -0400
X-MC-Unique: PPwM5KHjMJmy-tu0M7Sqng-1
X-Mimecast-MFC-AGG-ID: PPwM5KHjMJmy-tu0M7Sqng_1790932698
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CCFA1953944; Fri,  2 Oct 2026 09:18:17 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EF6221956086; Fri,  2 Oct 2026 09:18:15 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org,
	hkalra@marvell.com
Cc: stable@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH 2/5] eal/freebsd: fix a FD leak in the alarm subsystem
Date: Fri,  2 Oct 2026 11:17:55 +0200
Message-ID: <20261002091758.2922227-3-david.marchand@redhat.com>
In-Reply-To: <20261002091758.2922227-1-david.marchand@redhat.com>
References: <20261002091758.2922227-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Q3eRYqAHfhtUxzjPi8umR4vVvYpeKctHJ6c-K_9ai_w_1790932698
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

Caught by code review, while looking at rte_intr_instance_free() users.

Even if the FD is not used, it must still be closed when uninitialising
the alarm subsystem.

Fixes: 26021a715067 ("eal/bsd: support alarm API")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
Changes since RFC v3:
- fixed compilation,

---
 lib/eal/freebsd/eal_alarm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/eal/freebsd/eal_alarm.c b/lib/eal/freebsd/eal_alarm.c
index c03e281e67..8544fe8d03 100644
--- a/lib/eal/freebsd/eal_alarm.c
+++ b/lib/eal/freebsd/eal_alarm.c
@@ -10,6 +10,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
+#include <unistd.h>
 #include <errno.h>
 
 #include <eal_export.h>
@@ -54,6 +55,8 @@ rte_eal_alarm_cleanup(void)
 	int ret = rte_intr_callback_unregister_sync(intr_handle,
 			eal_alarm_callback, (void *)-1);
 	if (ret >= 0) {
+		close(rte_intr_fd_get(intr_handle));
+		rte_intr_fd_set(intr_handle, -1);
 		rte_intr_instance_free(intr_handle);
 		intr_handle = NULL;
 	}
@@ -62,7 +65,7 @@ rte_eal_alarm_cleanup(void)
 int
 rte_eal_alarm_init(void)
 {
-	int fd;
+	int fd = -1;
 
 	intr_handle = rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
 	if (intr_handle == NULL) {
@@ -88,6 +91,8 @@ rte_eal_alarm_init(void)
 
 	return 0;
 error:
+	if (fd >= 0)
+		close(fd);
 	rte_intr_instance_free(intr_handle);
 	return -1;
 }
-- 
2.54.0

