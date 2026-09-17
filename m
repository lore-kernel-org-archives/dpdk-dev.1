Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C37C88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 07:49:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77701402B8;
	Thu, 17 Sep 2026 09:49:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 08C1F400D5
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:49:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789631369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EcVsmAlcopW2kzezCwvVWpNyjBL+PF7l1fKJGREv8Vs=;
 b=fu+Vv4gueam5wu9SsbceWxUAsZKaDx/WIG51puHiWG9UkVZRGHXQCSH4hutC3YcniGHLTZ
 FxHS2UvbhxuhqOD78XSgYjPEBqnpIJJhrK4HMHQDAhTcVpe1Qm3BT69H/a6tmsCfV4KmQv
 KANWaB9FT+i9Uv/rYrdVfnp0Gz4oag0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-VYUveTCaOzisEo_A8_UH9A-1; Thu,
 17 Sep 2026 03:49:25 -0400
X-MC-Unique: VYUveTCaOzisEo_A8_UH9A-1
X-Mimecast-MFC-AGG-ID: VYUveTCaOzisEo_A8_UH9A_1789631365
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC4851945108; Thu, 17 Sep 2026 07:49:24 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 14A71180036E; Thu, 17 Sep 2026 07:49:23 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Subject: [RFC v2 00/16] Device unplug and bus cleanup refactoring for NXP
Date: Thu, 17 Sep 2026 09:49:00 +0200
Message-ID: <20260917074917.595603-1-david.marchand@redhat.com>
In-Reply-To: <20260723135400.3621271-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iM1XHPlkKgN8Fl0UEimDBg9krdue38cOuMeR4sCbSHk_1789631365
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

I went with the approach of splitting the device list between
internal bus object (that I called "control" devices, maybe a better
name can be found), and normal bus device object for which DPDK has a
driver.

I think it is worth testing and fixing, as it will make the two NXP
bus drivers similar to other bus drivers (but keep the special IO devices
handling internal to the FSLMC bus for example).


-- 
David Marchand

Changes since RFC v1:
- fixed FD leak in bus/dpaa pre existing code,
- fixed device name leak in bus/fslmc pre existing code,
- fixed other leaks found by AI review,
- split DPAA2 devices in two list:
  - one list in the bus object for devices for which a driver exists,
  - one list local to the fslmc bus code for internal resources that
    are initialised out of the EAL / bus framework,

David Marchand (16):
  drivers/bus: cleanup device freeing in NXP bus scan
  drivers/bus: fix FD leak during scan in NXP drivers
  bus/dpaa: allocate interrupt during probing
  bus/dpaa: support unplug and use generic cleanup
  bus/fslmc: fix device name leak
  bus/fslmc: fix memory leaks in scan
  bus/fslmc: fix per type device count
  bus/fslmc: fix some VFIO device FD and memory leaks
  bus/fslmc: fix interrupt leak in DPIO cleanup
  bus/fslmc: simplify device parsing in scan
  bus/fslmc: release resources on scan failure
  bus/fslmc: refactor device filtering for multiprocess
  bus/fslmc: move unplug for some device out of VFIO
  bus/fslmc: call VFIO setup for some device from bus layer
  bus/fslmc: allocate interrupt during probing
  bus/fslmc: use generic cleanup

 doc/guides/rel_notes/release_26_11.rst   |   4 +
 drivers/bus/dpaa/dpaa_bus.c              | 146 ++++----
 drivers/bus/fslmc/bus_fslmc_driver.h     |   4 +-
 drivers/bus/fslmc/fslmc_bus.c            | 431 +++++++++++++++++------
 drivers/bus/fslmc/fslmc_vfio.c           | 407 ++++++++++-----------
 drivers/bus/fslmc/fslmc_vfio.h           |   6 +
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c |   1 +
 drivers/bus/fslmc/private.h              |   6 +
 8 files changed, 601 insertions(+), 404 deletions(-)

-- 
2.54.0

