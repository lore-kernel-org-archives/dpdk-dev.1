Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A08C83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 13:34:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0E0340E4F;
	Wed, 23 Jul 2025 15:33:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 11D584067C
 for <dev@dpdk.org>; Wed, 23 Jul 2025 15:33:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753277603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=69Cl5rH1nJhTguHVgodvWy1LNsMZCt5T/T/J6ytWcGo=;
 b=U2TYXYtby/hdu1A8FJyKxpLndbFBDkJ/XoCuisEjiFOcE5aD9F/D2OYNTtogcOA+MS5bjj
 4W54go+PRC1DDdLzDnj7EWo6wCfiTeTi1wgC5NVgocJGUn0OZRXextxeKY6Fq4SPMWgz3f
 GWxJ4da86RUoYslFH9rPC9o4CM9BLYQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-5ePCW7TwMdKeqnP-TuakbQ-1; Wed,
 23 Jul 2025 09:33:18 -0400
X-MC-Unique: 5ePCW7TwMdKeqnP-TuakbQ-1
X-Mimecast-MFC-AGG-ID: 5ePCW7TwMdKeqnP-TuakbQ_1753277596
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD6C619560AB; Wed, 23 Jul 2025 13:33:16 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.51])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6D57E19560AF; Wed, 23 Jul 2025 13:33:13 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Marat Khalili <marat.khalili@huawei.com>, stable@dpdk.org,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, Robin Jarry <rjarry@redhat.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [PATCH v5 13/22] graph: fix stats query with no node xstats
Date: Wed, 23 Jul 2025 15:31:46 +0200
Message-ID: <20250723133157.159825-14-david.marchand@redhat.com>
In-Reply-To: <20250723133157.159825-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ABREWr70qr4krZ6RFRQUjRDdeARtCxEFvS8SRbpEJ9w_1753277596
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

From: Marat Khalili <marat.khalili@huawei.com>

This was flagged by undefined behaviour sanitizer: memset should not be
called with NULL first argument. (memset requires first argument to be
pointer to a memory object, so passing NULL may result in an undefined
behaviour including among other things optimizer potentially removing
code paths depending on stat->xstat_count being NULL.)

Sanitizer message:

    lib/graph/graph_stats.c:473:2: runtime error: null pointer passed as
    argument 1, which is declared to never be null

Add a check that stat->xstat_cntrs is not zero before the call, since
stat->xstat_count can only be NULL when stat->xstat_cntrs is zero.

Fixes: 070db97e017b ("graph: support node xstats")
Cc: stable@dpdk.org

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/graph/graph_stats.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/graph/graph_stats.c b/lib/graph/graph_stats.c
index eac73cbf71..583ad8dbd5 100644
--- a/lib/graph/graph_stats.c
+++ b/lib/graph/graph_stats.c
@@ -470,7 +470,8 @@ cluster_node_arregate_stats(struct cluster_node *cluster, bool dispatch)
 	uint64_t *xstat;
 	uint8_t i;
 
-	memset(stat->xstat_count, 0, sizeof(uint64_t) * stat->xstat_cntrs);
+	if (stat->xstat_cntrs != 0)
+		memset(stat->xstat_count, 0, sizeof(uint64_t) * stat->xstat_cntrs);
 	for (count = 0; count < cluster->nb_nodes; count++) {
 		node = cluster->nodes[count];
 
-- 
2.50.0

