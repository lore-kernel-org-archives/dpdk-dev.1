Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6EECA5FB1
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 10:00:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0C0040A7A;
	Wed, 30 Sep 2026 12:00:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4306440278
 for <dev@dpdk.org>; Wed, 30 Sep 2026 12:00:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790762415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SAmyA3g/RGmNLprMXeIhSO/jfP6vOqQzZvqhtXFbxi4=;
 b=H7MfgKeHjA0SFVj2rUzaVrBTMdeyeLbL98TqoHpVwu/2AWD/kwbC5I6ACHZjGT/1UsBKrx
 6jta0LJb5wYbeUTKNZRSZez9JagFTwEJ3k+9ivbdGsxa/K1gCAJstKvqYfkf2uTYmRrcR9
 ohkRPKsC7b3nxAEcNSs6zmbOwggcklE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-Q7HQxc0rO5uwaOUctnDalQ-1; Wed,
 30 Sep 2026 06:00:14 -0400
X-MC-Unique: Q7HQxc0rO5uwaOUctnDalQ-1
X-Mimecast-MFC-AGG-ID: Q7HQxc0rO5uwaOUctnDalQ_1790762413
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C48FA180883E; Wed, 30 Sep 2026 10:00:12 +0000 (UTC)
Received: from max-p1 (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C969D30000E8; Wed, 30 Sep 2026 10:00:10 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org, eperezma@redhat.com, david.marchand@redhat.com,
 thomas@monjalon.net, stephen@networkplumber.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH 0/2] uapi: introduce compatibility define of old compilers
Date: Wed, 30 Sep 2026 11:57:58 +0200
Message-ID: <20260930095800.551314-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0vr5mSwUbS4i8iFHOEeH6oX_WH8Sd704gH3-POwRQSE_1790762413
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

This series introduces a compatibility define for __counted_by
attribute, which is not defined by old compilers. We define is
as empty if the compiler don't provide it.

The second patch updates the UAPI headers to v6.19, in which vfio.h
introduces the use of this attribute.

Maxime Coquelin (2):
  config: add compatibility for old compilers with new UAPI headers
  uapi: update headers to v6.19

 config/rte_config.h             |  9 ++++++++
 kernel/linux/uapi/linux/vduse.h |  2 +-
 kernel/linux/uapi/linux/vfio.h  | 40 ++++++++++++++++++++++++++++++++-
 kernel/linux/uapi/version       |  2 +-
 4 files changed, 50 insertions(+), 3 deletions(-)

-- 
2.55.0

