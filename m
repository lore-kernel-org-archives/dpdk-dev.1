Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59509C3DA7A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 19:22:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86B1040272;
	Wed, 14 Oct 2026 21:22:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id AFC2C4025A
 for <dev@dpdk.org>; Wed, 14 Oct 2026 21:22:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792005728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uYk9ZKEdC4MjKnyj78u9DDJFas/Hg+KfTTSPUYyAPKY=;
 b=YFkUEgn6ct34seTznHUdtZ2CAvNz2xQHjUxZ9eccTDprwmob+DRzB4mBpoF5TYtl3rMDHe
 rAyLUFYomfQQDKCMi2mWwZXPBLj6AvByA8ClxZcQDsrBgQtAy8g2fh7GY5NNs8k6u4vjCG
 7QnZrURdww4kzLex1zHwwGPF50CzWFk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-tVLxwFMHOcSdOJk06i_ILQ-1; Wed,
 14 Oct 2026 19:22:06 +0000
X-MC-Unique: tVLxwFMHOcSdOJk06i_ILQ-1
X-Mimecast-MFC-AGG-ID: tVLxwFMHOcSdOJk06i_ILQ_1792005726
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E11191955E80
 for <dev@dpdk.org>; Wed, 14 Oct 2026 19:22:05 +0000 (UTC)
Received: from ringo.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0E3FA180057F; Wed, 14 Oct 2026 19:22:04 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org
Subject: [PATCH dpdk 0/2] lib: remove niche libraries from always enabled list
Date: Wed, 14 Oct 2026 21:21:53 +0200
Message-ID: <20261014192153.2693883-4-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GMsxABRbOCAG9yRXv3D6cWoRCsnyTBszNcYYo5zOz1M_1792005726
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

Some libraries are only used either for internal apps/examples (cmdline)
or by a specific mempool driver (stack).

Everywhere they are used, an explicit dependency is already recorded in
meson. There is no reason to always enable them.

Robin Jarry (2):
  lib: remove cmdline from always enabled libraries
  lib: remove stack from always enabled libraries

 lib/meson.build | 2 --
 1 file changed, 2 deletions(-)

-- 
2.56.0

