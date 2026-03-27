Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D1E10BA435
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 08:07:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9F8542DA1;
	Fri, 27 Mar 2026 09:07:16 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8A35740280
 for <dev@dpdk.org>; Fri, 27 Mar 2026 09:07:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774598835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HlcBcg0iLM01IzJzLt8F65F9A4sds+evgkbH4wJvaDs=;
 b=NJUuowQdM96mhlLKB09i27pdunm9HyK+c5ldmbgYYqENLzFNlA/zPSCopmIgj7SuOelimo
 urM9BB3nytvtv4MgbYiMeB0XuD7xQ79eZyeW62e/Wo7d9S65m6F2RasbqdfvqjH59d/pge
 ED+LhDs3JSDA+GumjWUlqNpZb96HW+U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-B-8kjiT0ME2guKXrfX-iNA-1; Fri,
 27 Mar 2026 04:07:09 -0400
X-MC-Unique: B-8kjiT0ME2guKXrfX-iNA-1
X-Mimecast-MFC-AGG-ID: B-8kjiT0ME2guKXrfX-iNA_1774598828
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A72071956046; Fri, 27 Mar 2026 08:07:07 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.173])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 97EE219560B1; Fri, 27 Mar 2026 08:07:04 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: ajp@marvell.com, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Santosh Shukla <santosh.shukla@caviumnetworks.com>,
 Nemanja Marjanovic <nemanja.marjanovic@intel.com>,
 David Hunt <david.hunt@intel.com>
Subject: [PATCH] examples/vm_power_manager: fix format specifier for port ID
Date: Fri, 27 Mar 2026 09:06:59 +0100
Message-ID: <20260327080659.3250395-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DJwqeW0DuUXKoSJnesUCbZfwgwmcbxo6xHSevvRlEF4_1774598828
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

Caught by code review, port_id is a uint16_t.

Fixes: 20c78ac9ee23 ("examples/vm_power_mgr: add port initialisation")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 examples/vm_power_manager/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/examples/vm_power_manager/main.c b/examples/vm_power_manager/main.c
index c141382020..ae9b326f4a 100644
--- a/examples/vm_power_manager/main.c
+++ b/examples/vm_power_manager/main.c
@@ -382,7 +382,7 @@ main(int argc, char **argv)
 
 			if (port_init(portid, mbuf_pool) != 0)
 				rte_exit(EXIT_FAILURE,
-					"Cannot init port %"PRIu8 "\n",
+					"Cannot init port %"PRIu16 "\n",
 					portid);
 
 			for (w = 0; w < RTE_POWER_MAX_VFS; w++) {
-- 
2.53.0

