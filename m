Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3842EC83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 16:50:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C451402D4;
	Wed, 23 Jul 2025 18:50:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 50E9B40267
 for <dev@dpdk.org>; Wed, 23 Jul 2025 18:50:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753289425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9qjkJEn6Y/YRQn3KqwyxrRlmjrIEDs594ZxxcM9o42c=;
 b=UUwIvZS8FKtOsblEcJleLh/b7qvdHEO8bXdaDnYjqnx196OugzPkbEo59QUs2qMXod5B4H
 DRJLBwWnvm+rlqKQx3JBR0XmVOGmwLpN9Rh2j4SRXZ67K+vu9Z6S/3SbJ5f3aBPO+61BKy
 ZOdx0HTsfGO6bCF4aSH19LZl4qhdQC8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-UWrmyTKbPaK6gwwwnaf9lw-1; Wed,
 23 Jul 2025 12:50:24 -0400
X-MC-Unique: UWrmyTKbPaK6gwwwnaf9lw-1
X-Mimecast-MFC-AGG-ID: UWrmyTKbPaK6gwwwnaf9lw_1753289423
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7479A180028C; Wed, 23 Jul 2025 16:50:23 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.165])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0181B180049D; Wed, 23 Jul 2025 16:50:20 +0000 (UTC)
From: Christophe Fontaine <cfontain@redhat.com>
To: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Cc: dev@dpdk.org,
	Christophe Fontaine <cfontain@redhat.com>
Subject: [PATCH 0/2] graph: dispatch mode improvements
Date: Wed, 23 Jul 2025 18:49:59 +0200
Message-ID: <20250723165001.11162-1-cfontain@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Iqohz-cgaPMX0nGFK1qLl7ughjaZy3fJx43bseSSx_A_1753289423
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

Small series to improve dispatch mode for lib/graph.
In order to run an instance of the graph in a control thread (slow path
defined as nodes) in addition to the datapath thread, we need:
  - the ability to run graph_walk on an non-eal thread
  - a signaling mechanism to wake up the control thread

Christophe

Christophe Fontaine (2):
  graph: allow non EAL Thread for pipeline mode
  graph: add callback in dispatch mode

 lib/graph/graph.c                          | 23 +++++++++++++++-------
 lib/graph/rte_graph.h                      | 14 +++++++++++++
 lib/graph/rte_graph_model_mcore_dispatch.c |  2 ++
 lib/graph/rte_graph_worker_common.h        |  2 ++
 4 files changed, 34 insertions(+), 7 deletions(-)

-- 
2.43.5

