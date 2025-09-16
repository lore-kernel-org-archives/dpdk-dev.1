Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139DCCAC598
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 09:36:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F01B440277;
	Tue, 16 Sep 2025 11:35:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1C35740261
 for <dev@dpdk.org>; Tue, 16 Sep 2025 11:35:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758015358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6q4ri07GhrmuARCIQQcDvGhicdLEHrGaXqcJo1WtzL0=;
 b=fyehtIzQgLGqGJ/mqVmO70ds2/Ajk6MTuyqZXJK6KIN7CAxUu3A74kkvaGbUO2FS+SrqUk
 RTlU788HHmhZVS5yaTLbwH+LYUV4jj5SQNsv/H6Tm/R0WWtcKvGEr7di4UX/iGeelB6v45
 CtKieaSjV5U6gSmY4ybRx/OQ9wXPYcc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-hdxHnYTRNXylJkQDuEEFMA-1; Tue,
 16 Sep 2025 05:35:56 -0400
X-MC-Unique: hdxHnYTRNXylJkQDuEEFMA-1
X-Mimecast-MFC-AGG-ID: hdxHnYTRNXylJkQDuEEFMA_1758015356
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5CEF1800292; Tue, 16 Sep 2025 09:35:55 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.45.242.14])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B3FBC1800446; Tue, 16 Sep 2025 09:35:53 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org,
	david.marchand@redhat.com,
	chenbox@nvidia.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v2 0/2] vhost: VDUSE startup workaround and fix
Date: Tue, 16 Sep 2025 11:35:48 +0200
Message-ID: <20250916093550.1345901-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o7_O4Y_n0qBhg_RbXx8gsjmawMHlxLDKoRplZ6I1tuQ_1758015356
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

This series is a follow-up of the workaround to ensure queues are
in a ready state before starting the device.

It also adds a patch to ensure data passed to the kernel are properly
initialized.

Changes in v2:
==============
- Improve comments (David)
- Initialize vq_info properly (David)
- Add David's R-by

Maxime Coquelin (2):
  vhost: add VDUSE virtqueue ready state polling workaround
  vhost: fix uninitialized VQ info in VDUSE vring setup

 lib/vhost/vduse.c | 63 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 3 deletions(-)

-- 
2.51.0

