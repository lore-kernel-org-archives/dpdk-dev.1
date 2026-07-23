Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B186C531CF
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:54:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6ACEB40679;
	Thu, 23 Jul 2026 15:54:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5480A40663
 for <dev@dpdk.org>; Thu, 23 Jul 2026 15:54:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784814853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sIZQKpX8e+7ug2zY9WCyrDBDIvrIp2AIKYWEQwffmrg=;
 b=fb/2Kgo42O8U+HSWarduRfH4c/Jk3IbNo1e7XviTXsGxPK5ek9lLmcc4/1vB52GBh/FUx3
 DcopDm5bx/4AgcCmqAQqAOREag/lABy0lMcy1LQvfz27++9gUlTEEwlF0celumYCTJyCdf
 SG6q7mku9vuFA8kHQl9IDv3WgZXizso=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-mE0l6JFmNC-GHnPd-U0cnQ-1; Thu,
 23 Jul 2026 09:54:11 -0400
X-MC-Unique: mE0l6JFmNC-GHnPd-U0cnQ-1
X-Mimecast-MFC-AGG-ID: mE0l6JFmNC-GHnPd-U0cnQ_1784814849
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E903D1944F05; Thu, 23 Jul 2026 13:54:08 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BFD3518005B8; Thu, 23 Jul 2026 13:54:07 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Subject: [RFC 00/11] Device unplug and bus cleanup refactoring for NXP
Date: Thu, 23 Jul 2026 15:53:48 +0200
Message-ID: <20260723135400.3621271-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C85AEjQ2-Tqu91cD7lDHYFrXwXRQYBYmdf6_rrgXa_Y_1784814849
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

Hello Hemant,

This is a followup to the refactoring started in 26.07.

I took some time with my best AI friend to cleanup DPAA and FSLMC bus
drivers.

Like the last time, only compilation has been checked.
I have no hardware to test runtime.

One thing that could be broken is either the order of devices
initialisation, or bugs in the device filtering that I tried to
simplify.

I think it is worth testing and fixing, as it will make the two NXP
bus drivers similar to other bus drivers (but keep the special IO devices
handling internal to the FSLMC bus for example).


-- 
David Marchand

David Marchand (11):
  drivers/bus: cleanup device freeing in NXP bus scan
  bus/dpaa: allocate interrupt during probing
  bus/dpaa: support unplug and use generic cleanup
  bus/fslmc: fix memory leaks in scan
  bus/fslmc: fix per type device count
  bus/fslmc: simplify device parsing in scan
  bus/fslmc: refactor device filtering for multiprocess
  bus/fslmc: move unplug for some device out of VFIO
  bus/fslmc: call VFIO setup for some device from bus layer
  bus/fslmc: allocate interrupt during probing
  bus/fslmc: use generic cleanup

 doc/guides/rel_notes/release_26_11.rst   |   4 +
 drivers/bus/dpaa/dpaa_bus.c              | 134 +++++-----
 drivers/bus/fslmc/fslmc_bus.c            | 295 +++++++++++++++--------
 drivers/bus/fslmc/fslmc_vfio.c           | 255 +++++++-------------
 drivers/bus/fslmc/fslmc_vfio.h           |   5 +
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c |   1 +
 drivers/bus/fslmc/private.h              |   2 +
 7 files changed, 368 insertions(+), 328 deletions(-)

-- 
2.54.0

