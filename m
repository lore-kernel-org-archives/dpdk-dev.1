Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B342D185F9
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 13:50:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56C754027A;
	Thu,  8 Jan 2026 14:50:06 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 10D984013F
 for <dev@dpdk.org>; Thu,  8 Jan 2026 14:50:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767880204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aVGM8/O4m6Waj0QjRaXe5JfNjYMBrrx+CGShRiIXZlA=;
 b=BjOGk5retA0wRh9AZAELKrP42Nj0PoVrXuoSHf4i3AU1P1Jx0xBDHIAUyQ898bU1nTxRCa
 8UQqfIiMtcjExW0g4ddXblnVIem9oK+5v7Y9Wg2AnFq85sP6EwW4YB2+ViZsxcKIaPjfC9
 C2L6bwjqMaLTpqrm76l6jSk0kLES0G4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-C4CaZZicO4upHT-XfMLhpw-1; Thu,
 08 Jan 2026 08:50:01 -0500
X-MC-Unique: C4CaZZicO4upHT-XfMLhpw-1
X-Mimecast-MFC-AGG-ID: C4CaZZicO4upHT-XfMLhpw_1767880200
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C3D61956059; Thu,  8 Jan 2026 13:50:00 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.45.242.13])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 12F561800109; Thu,  8 Jan 2026 13:49:57 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org,
	chenbox@nvidia.com,
	david.marchand@redhat.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH 0/3] vhost: VDUSE-related fixes
Date: Thu,  8 Jan 2026 14:49:48 +0100
Message-ID: <20260108134951.3857110-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9NYHTCfbW52N3IC8ck9w0KfYRyPQcUy7HHMf6akD7lE_1767880200
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

This series contains 3 fixes for issues spotted by Claude Code.

The first one is to avoid out-of-bound accesses in virtqueues array
in the case we have the maximum supported queue pairs and control queue.

Second one is a security issue that could result in theory in a denial
of service, but a CVE was not created because the control queue support
cannot currently be negotiated with the Kernel VDUSE driver.

Last patch is fixing mmap error handling in the VDUSE IOTLB miss handler.

Maxime Coquelin (3):
  vhost: fix virtqueue array size for control queue
  vhost: fix descriptor chain bounds check in control queue
  vhost: fix mmap error check in VDUSE IOTLB miss handler

 lib/vhost/vduse.c           |  5 +++--
 lib/vhost/vhost.h           |  5 +++--
 lib/vhost/virtio_net_ctrl.c | 22 ++++++++++++++++++++--
 3 files changed, 26 insertions(+), 6 deletions(-)

-- 
2.52.0

