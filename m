Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCD0FED2FE
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 10:36:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 887EC402AC;
	Thu, 12 Mar 2026 11:36:30 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E800440275
 for <dev@dpdk.org>; Thu, 12 Mar 2026 11:36:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773311788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VyX82sK4ewvZMjiH6+Vb9nwJZ+LMahZ8jsVja42IcC8=;
 b=HfI6Gz/oadVbsyuDW8qLyy7Jr5aR/zIrFWPQajKgI+0GF+M6PMWgmzBABLEGC+jil13dhB
 zg+zJt86JdAPJZ9vymfM3CQ75VEMBNU86C1DPCuY7CAblLhkrHJJ6NdrV+lu11/EKdZMTW
 Y8LD6ZHyLkUKWM9qMfzsRtoGS5muxLw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-uKS0ixygOJCPF4H2lykztg-1; Thu,
 12 Mar 2026 06:36:27 -0400
X-MC-Unique: uKS0ixygOJCPF4H2lykztg-1
X-Mimecast-MFC-AGG-ID: uKS0ixygOJCPF4H2lykztg_1773311786
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EC1719776A8
 for <dev@dpdk.org>; Thu, 12 Mar 2026 10:36:26 +0000 (UTC)
Received: from rh.redhat.com (unknown [10.45.224.40])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3727330002E0; Thu, 12 Mar 2026 10:36:24 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: dev@dpdk.org
Cc: Kevin Traynor <ktraynor@redhat.com>
Subject: [PATCH 0/4] Static analysis fixes
Date: Thu, 12 Mar 2026 10:36:02 +0000
Message-ID: <20260312103606.702617-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZufOxayM4nMzWS0_vbOo3vWDevl6SX-Of9EI4ITiJiE_1773311786
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

Fix some leaks and uninitialized variables.

Kevin Traynor (4):
  vhost: fix resource leak
  net/bnxt: fix uninitialized read
  app/testpmd: check for no arguments
  app/testpmd: fix fd leak

 app/test-pmd/cmdline.c               | 10 ++++++++--
 drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c |  2 +-
 lib/vhost/socket.c                   |  1 +
 3 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.53.0

