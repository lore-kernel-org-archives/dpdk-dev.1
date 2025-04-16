Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F02C369BD
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 12:34:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A64B440E09;
	Wed, 16 Apr 2025 14:34:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B0D4D40DFD
 for <dev@dpdk.org>; Wed, 16 Apr 2025 14:34:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744806878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Y3bJbbZt5Rx0mA7A/mMo9C7NOIFne1TiqZA4hkocZWU=;
 b=OYtHh6KajvsJxmzQSQHiVWPBbA60AHoKC5ix0Xy2gRs/7iqp3oFV0/eJDaS0yijpXXinBE
 jgMw3Wi2co+late9EuQxpQoM+TTqDZvGu+ykIhwUoXhHTqs62U9wT+GcuOBRqDXVP5lGKp
 05gzLMYuytjsROhJevfN0svvFDjqris=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-CMB1YTLWOq-Ay-WLJ_sJMg-1; Wed,
 16 Apr 2025 08:34:34 -0400
X-MC-Unique: CMB1YTLWOq-Ay-WLJ_sJMg-1
X-Mimecast-MFC-AGG-ID: CMB1YTLWOq-Ay-WLJ_sJMg_1744806872
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E118C19560AE; Wed, 16 Apr 2025 12:34:31 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.44.22.20])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 745E5180045C; Wed, 16 Apr 2025 12:34:29 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org,
	david.marchand@redhat.com,
	thomas@monjalon.net
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH 0/4] Linux Kernel uAPI headers import
Date: Wed, 16 Apr 2025 14:34:22 +0200
Message-ID: <20250416123426.2638250-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nDnv_7NP15B0YyD0ZXPmO9AttcD7_ChkDIU1phvSt2A_1744806872
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

This series documents the license exception granted by both
the technical and governing boards to import uAPI header
files.

It also imports VDUSE uAPI header file from Kernel v6.14.

David Marchand (1):
  ci: check licenses

Maxime Coquelin (3):
  license: add exception for Linux Kernel uAPI headers
  uapi: import VDUSE header from v6.14 kernel
  vhost: use imported VDUSE uAPI header

 .github/workflows/build.yml     |   1 +
 devtools/check-spdx-tag.sh      |   2 +-
 kernel/linux/uapi/linux/vduse.h | 353 ++++++++++++++++++++++++++++++++
 kernel/linux/uapi/version       |   2 +-
 lib/vhost/meson.build           |   5 +-
 lib/vhost/vduse.c               |   2 +-
 lib/vhost/vduse.h               |  22 --
 license/Linux-syscall-note      |  25 +++
 license/exceptions.txt          |  17 +-
 9 files changed, 392 insertions(+), 37 deletions(-)
 create mode 100644 kernel/linux/uapi/linux/vduse.h
 create mode 100644 license/Linux-syscall-note

-- 
2.49.0

