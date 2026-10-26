Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAAC606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 18:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jh7uS2FL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CA5C40151;
	Mon, 26 Oct 2026 19:10:40 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id EF6C340041
 for <dev@dpdk.org>; Mon, 26 Oct 2026 19:10:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793038237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D6TIRFOKthKufApT1XjWUyd3StUiTxfVQgK7IJug9oc=;
 b=Jh7uS2FLdV8fC64mSYVKSG3UeD7shbLnbbzLPFokHCMZgmdE5CI+2ZZA4m/SReBgm90WG7
 /8siw3rXtDyf4FaJwHBJNyBRSrU8E+x9tg6abhFIGp/gUGIt5Ne7+RXUfIU6x6yF/396K9
 o4Zukw7aH6NGW73zjOfY4r3TPE1JmBk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-t_mjaKqcOPqzd09nOtmgnw-1; Mon,
 26 Oct 2026 14:10:36 -0400
X-MC-Unique: t_mjaKqcOPqzd09nOtmgnw-1
X-Mimecast-MFC-AGG-ID: t_mjaKqcOPqzd09nOtmgnw_1793038235
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4380C1800658; Mon, 26 Oct 2026 18:10:35 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3CF441800480; Mon, 26 Oct 2026 18:10:33 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Subject: [PATCH v2 00/16] Device unplug and bus cleanup refactoring for NXP
Date: Mon, 26 Oct 2026 19:10:14 +0100
Message-ID: <20261026181031.304100-1-david.marchand@redhat.com>
In-Reply-To: <20260723135400.3621271-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4S7pXfW6mrpZZ7YJ1ehSSsNWAV5g8J7zWd_3v9GXvFU_1793038235
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Hemant,

This is a followup to the refactoring started in 26.07.

Like the last time, only compilation has been checked.
I have no hardware to test runtime.

One thing that could be broken is either the order of devices
initialisation, or bugs in the device filtering that I tried to
simplify.

I went with the approach of splitting the device list between
internal bus object (that I called "control" devices, maybe a better
name can be found), and normal bus device object for which DPDK has a
driver.

I did not get much feedback on the series.
I'll let CI pass on this new revision and merge it.


-- 
David Marchand

Changes since v1:
- rebased,
- used fd_close API,
- branch rebased against next-net is available here:
  https://github.com/david-marchand/dpdk/commits/dpaa_bus_next-net

Changes since RFC v2:
- rebased,
- fixed interrupt closing,

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
  bus/fslmc: release resources on probe failure
  bus/fslmc: refactor device filtering for multiprocess
  bus/fslmc: move unplug for some device out of VFIO
  bus/fslmc: call VFIO setup for some device from bus layer
  bus/fslmc: allocate interrupt during probing
  bus/fslmc: use generic cleanup

 doc/guides/rel_notes/release_26_11.rst   |   4 +
 drivers/bus/dpaa/dpaa_bus.c              | 138 ++++----
 drivers/bus/fslmc/bus_fslmc_driver.h     |   4 +-
 drivers/bus/fslmc/fslmc_bus.c            | 410 +++++++++++++++++------
 drivers/bus/fslmc/fslmc_vfio.c           | 401 ++++++++++------------
 drivers/bus/fslmc/fslmc_vfio.h           |   6 +
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c |  10 +
 drivers/bus/fslmc/private.h              |   6 +
 8 files changed, 587 insertions(+), 392 deletions(-)

-- 
2.54.0

