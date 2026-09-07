Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A76BC79F89
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 12:14:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3355D406B6;
	Mon,  7 Sep 2026 14:14:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0E83C40041
 for <dev@dpdk.org>; Mon,  7 Sep 2026 14:14:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788783249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KL/pH2VNUNg+Ob9HW3nRQwiaYMH87X9RdasdRV7OqCQ=;
 b=c0hlnQUBsOUpP66yWp95lDXGlT9HxTn4qzvByhpV/YPlNgZpa5M0U2Zyq7h44TQmYu09/q
 ecnVYYnZ5I3EB8wmvUi3WsMzPuSFd0bja28dfAtsoFVYTLqIesCUeJcmo6vMP+It4+DnFs
 wLS3RG2GONzw7976/2W7NTczJo82C40=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-1syXvk_FNo2VEoW8xq7Bew-1; Mon,
 07 Sep 2026 08:14:03 -0400
X-MC-Unique: 1syXvk_FNo2VEoW8xq7Bew-1
X-Mimecast-MFC-AGG-ID: 1syXvk_FNo2VEoW8xq7Bew_1788783242
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8DEE19540C2; Mon,  7 Sep 2026 12:14:01 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5A47D3000223; Mon,  7 Sep 2026 12:14:00 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org,
	hkalra@marvell.com
Cc: stable@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [RFC v3 2/5] eal/freebsd: fix a FD leak in the alarm subsystem
Date: Mon,  7 Sep 2026 14:13:45 +0200
Message-ID: <20260907121348.3049808-3-david.marchand@redhat.com>
In-Reply-To: <20260907121348.3049808-1-david.marchand@redhat.com>
References: <20260907121348.3049808-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JZfC93_wVFnPrLb6xZ4RZKC9E_8-ARPcKTiODh95FvQ_1788783242
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
---
 lib/eal/freebsd/eal_alarm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/eal/freebsd/eal_alarm.c b/lib/eal/freebsd/eal_alarm.c
index c03e281e67..2905841b5e 100644
--- a/lib/eal/freebsd/eal_alarm.c
+++ b/lib/eal/freebsd/eal_alarm.c
@@ -54,6 +54,8 @@ rte_eal_alarm_cleanup(void)
 	int ret = rte_intr_callback_unregister_sync(intr_handle,
 			eal_alarm_callback, (void *)-1);
 	if (ret >= 0) {
+		close(rte_intr_fd_get(intr_handle));
+		rte_intr_fd_set(intr_handle, -1);
 		rte_intr_instance_free(intr_handle);
 		intr_handle = NULL;
 	}
@@ -62,7 +64,7 @@ rte_eal_alarm_cleanup(void)
 int
 rte_eal_alarm_init(void)
 {
-	int fd;
+	int fd = -1;
 
 	intr_handle = rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
 	if (intr_handle == NULL) {
@@ -88,6 +90,8 @@ rte_eal_alarm_init(void)
 
 	return 0;
 error:
+	if (fd >= 0)
+		close(fd);
 	rte_intr_instance_free(intr_handle);
 	return -1;
 }
-- 
2.54.0

