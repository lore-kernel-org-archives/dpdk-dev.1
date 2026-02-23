Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A653EA4FD8
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 15:56:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FEA84025E;
	Mon, 23 Feb 2026 16:56:17 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5A9C1400EF
 for <dev@dpdk.org>; Mon, 23 Feb 2026 16:56:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771862174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0pnWRRX0a3JnIKtwZzf1eooGKrCI6e+elDFhn4/5XYk=;
 b=XfW6TaMCuQNokU1YBolqttrrsOREPQZKo2IG9j7MyrJ0kULt5oZi40OF7aRdlCw9w0Qar6
 CTXr0TfrETOuKSWy5FR2u8voa4HSsSMYLL2AueKCphNsh/9msAj9y85Sr1PNI9gKHaHQvS
 ht2CtNSR5izJwNgtiUZK43gFlYUR1kE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-pB4csyKcOJqBgRQmOORE5A-1; Mon,
 23 Feb 2026 10:56:13 -0500
X-MC-Unique: pB4csyKcOJqBgRQmOORE5A-1
X-Mimecast-MFC-AGG-ID: pB4csyKcOJqBgRQmOORE5A_1771862169
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE6FA1955D9F; Mon, 23 Feb 2026 15:56:09 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.223])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA8A33003D91; Mon, 23 Feb 2026 15:56:08 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH] test/eal: remove PCI probing for vdev tests
Date: Mon, 23 Feb 2026 16:56:03 +0100
Message-ID: <20260223155603.3651641-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3xhHNnOiI8ie8-WSqvWybpC8X42J5jK5rVxqeNgonf8_1771862169
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

Similarly to commit f67f76e6bbfd ("test/eal: remove PCI probing for
recursive calls"), let's disable PCI probing in vdev tests as it
triggers false positive failures in GHA.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 app/test/test_eal_flags.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index bebddf1c98..06a605cce1 100644
--- a/app/test/test_eal_flags.c
+++ b/app/test/test_eal_flags.c
@@ -422,17 +422,17 @@ test_invalid_vdev_flag(void)
 
 	/* Test with invalid vdev option */
 	const char *vdevinval[] = {prgname, prefix, no_huge, eal_debug_logs,
-				bus_debug_logs, vdev, "eth_dummy"};
+				bus_debug_logs, no_pci, vdev, "eth_dummy"};
 
 	/* Test with valid vdev option */
 	const char *vdevval1[] = {prgname, prefix, no_huge, eal_debug_logs,
-				bus_debug_logs,	vdev, "net_ring0"};
+				bus_debug_logs,	no_pci, vdev, "net_ring0"};
 
 	const char *vdevval2[] = {prgname, prefix, no_huge, eal_debug_logs,
-				bus_debug_logs, vdev, "net_ring0,args=test"};
+				bus_debug_logs, no_pci, vdev, "net_ring0,args=test"};
 
 	const char *vdevval3[] = {prgname, prefix, no_huge, eal_debug_logs,
-				bus_debug_logs, vdev, "net_ring0,nodeaction=r1:0:CREATE"};
+				bus_debug_logs, no_pci, vdev, "net_ring0,nodeaction=r1:0:CREATE"};
 
 	if (launch_proc(vdevinval) == 0) {
 		printf("Error (line %d) - process did run ok with invalid vdev parameter\n",
-- 
2.53.0

