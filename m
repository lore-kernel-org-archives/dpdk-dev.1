Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62978D1CDC6
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 08:50:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B61EF40270;
	Tue,  9 Dec 2025 09:50:42 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1667E4025F
 for <dev@dpdk.org>; Tue,  9 Dec 2025 09:50:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765270240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=x2VMpZME4ES5pjbLspByBgeOiXxzeK5pGoCAysvQgr8=;
 b=Rc2ykcCcb91+yqJtThWgQqpTza38gw8/pA2DGUVha6Q2+6M8Vgr7jXMDf0swX1x1TWmCol
 YWfyVc0+2/d4qmvYqpTmuuIAHr9/3enzyXwrGeNlb1blz+5tyivbtZ//AUAicAPfwx34Vq
 YNBi495hIYeGsZAyC7SBLXXQWfZtjIw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-syvURBQgMHWZvTf4G0ajeQ-1; Tue,
 09 Dec 2025 03:50:39 -0500
X-MC-Unique: syvURBQgMHWZvTf4G0ajeQ-1
X-Mimecast-MFC-AGG-ID: syvURBQgMHWZvTf4G0ajeQ_1765270238
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 377B618002C9
 for <dev@dpdk.org>; Tue,  9 Dec 2025 08:50:38 +0000 (UTC)
Received: from ringo.home (unknown [10.45.225.153])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3A4411800451; Tue,  9 Dec 2025 08:50:36 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org
Subject: [PATCH dpdk 0/2] Flexible graph nodes stats collection
Date: Tue,  9 Dec 2025 09:50:29 +0100
Message-ID: <20251209085028.115203-4-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jOq81sxM4taXMhfq-QdYuZIdR9FiyYhcnXQ8Z80J6xg_1765270238
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

Currently, the collection of statistics is fixed at compile time and
encompasses the number of cycles and number of node visits/calls and
processed objects.

While having fine grained statistics is a useful tool, calling accessing
rte_rdtsc() twice per node can be costly.

This series brings more flexibility and allows to always collect the
number of objects and node visits regardless of the compile time
constants. Node cycles collection can be enabled at runtime per-graph.

Robin Jarry (2):
  graph: always count objects and calls
  graph: allow enabling/disabling node visit cycles collection

 lib/graph/graph_populate.c          |  1 +
 lib/graph/rte_graph_worker_common.h | 24 +++++++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.52.0

