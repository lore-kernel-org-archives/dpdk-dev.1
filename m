Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8F8606A32C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 00:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pw2Ba6gl
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CF70402BF;
	Wed, 18 Nov 2026 01:19:36 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by mails.dpdk.org (Postfix) with ESMTPS id 42D82400D5
 for <dev@dpdk.org>; Wed, 18 Nov 2026 01:19:34 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so3541065e9.2
 for <dev@dpdk.org>; Tue, 17 Nov 2026 16:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794961174; x=1795565974; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OyssWoF7meCusHji5ficIcAj4wsbP4Gug9C7PVkMe9M=;
 b=pw2Ba6gluv7sKt6+suygyKpxSBeCACcG+bA5k8Ew8LFdd/cM3dJv/+SecfWSa0bUGj
 EapQMl4jfbIQpEaX3TERXrxskyYxFUyKN/edUwBf/svEYZqotw8JSAUcxAJX+kFn2bMi
 d0EC0nRIWknozMHCUVYVTBIwd9CVjsM6KWg8ATGv8PVqzYRCxENGVn/Bjgpg9XZLqm1s
 HlbStwjsxXdCsDwYLEvV0eGYdfciKJjjCzY+d/eh0FalwPSEtqLn7egekZ+Y4nkse4DD
 M4aUxF/MyTm5BXeYCirv8kploDBWhE9rv0CDfbMgDzfK7xyymEovzswwACYIZUxBRsPX
 Q5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794961174; x=1795565974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OyssWoF7meCusHji5ficIcAj4wsbP4Gug9C7PVkMe9M=;
 b=Nkw10bbnxayqvYbJhXCPfof+fH4vEjo/wh9O+MQfMvZLQ5Zvj6klQGwuc4SBapS6Gl
 t4F240UmkYK6EwgAud9XzZRlig9hWtFuSfc5hhYLte9tSqNXcJK6tWhG2Jza2i/g/3zm
 f5vEgowI5OIKn4lchAr+iwzlOflmjUJHDXTvvJ/2XUWU/RQSqXtznr1a0ZyG7e/FFy/3
 Vc1F9kZsOv0D4t72AcLt4GCEdBOHvHoRvvb6e9YxpZR+rOCStR2I9vqECwDHfP1p/m06
 m/KeTgk7YsAqo5jXtBwYlAgw5FjnzkK+ZJDo+gVD/mE9nC7n/xuHIOyD1QSInbTF+R9y
 0YvQ==
X-Gm-Message-State: APuU4Z8D4xxjMAbGEXit6FS0Fcz8GSChcYaEfqQCVe2ULDkuWBZO9qeb
 IpHOVcdkHaIZsNBOqhRb3AvJgeMC7roFxHAH75lvJxqJzR9HvMkR0OlF
X-Gm-Gg: AYBFou2tn+1SXOFVxgb1PJ+mpG3QPnI6ju5WzCa08omarXkaaCdu4EOarv1rAoWSEr/
 5wfuf1WIzrCUXXXRpD4pqk2ylzSLOMyLWXKzEE3OoQGvchGw9WfrgOtHZ/KK7y4ajBoPH6Cn5v7
 Zgm9cgKnjMeZok00cXd4TQKZ15kSLZDL8LcXufgTuAlupV9IfCZH6h9k7BTEd1UzLZlK+tHlVEA
 r0Wr8r0uC9MbHvc9nZtOtTsMmsTFEm4gSrL4qJ/8kTvikESTKDMHy0a+ZTYJAPTiTCgRxoRDM44
 WVQQsGc62ljV6HlOPDXVb/0iBurMn0OFqjSGG7cQXyMkEKW+9u/jCeo+K/12XxouBTFcNvd9Brv
 ckG/aUzrHPfRv0w3HZiBlb3VXVsJsFs9o7G6I7ECxUVzQcsmaAeIjKmedZlfUHp6fgQ4anZY2zJ
 G1PzuoRpvsh7loHmaf0ZBu4vCAuidXwFoEnXTWGEAFtmk03eY16KHYsaNIMRdlYTnfB4w3wqBYF
 vhhe6T8QpeuP5ylqlZdjLW9OZGA4PWeh9nbQQUAFJYwpNvjtKjj9Ro0QiZng1DGYO2DRu5gkIZA
 ivLv6kEajdv5Ch2Oc5oZTb2mgmqi5IqHBb/EEXHYKQ==
X-Received: by 2002:a05:600c:800c:b0:4a1:c5eb:b445 with SMTP id
 5b1f17b1804b1-4bb7da3d581mr16457045e9.35.1794961173472; 
 Tue, 17 Nov 2026 16:19:33 -0800 (PST)
Received: from fedora ([46.210.208.90]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7e50e992sm4655025e9.0.2026.11.17.16.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 16:19:33 -0800 (PST)
From: Isaac Boukris <iboukris@gmail.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>,
 Isaac Boukris <iboukris@gmail.com>
Subject: [PATCH v3 0/7] net/virtio: fix Rx interrupts with MSI-X
Date: Wed, 18 Nov 2026 02:19:11 +0200
Message-ID: <20261118001918.990884-1-iboukris@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117124303.717447-1-iboukris@gmail.com>
References: <20261117124303.717447-1-iboukris@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since 26.11-rc2, a virtio-net PCI device on vfio-pci cannot be
configured with Rx interrupts and an offload or RSS, and it cannot be
configured a second time. For example, l3fwd-power fails to start on
it.

Patch 1 is the fix, for 26.11 and stable. The other patches can wait
for 27.03.

- Patch 2 fixes a packet loss on virtio-user ports with vhost-net.
  The unit test of v2 found it. When the application uses fewer Rx
  queues than the port has queue pairs, the kernel still sends flows
  to the TAP queues of the unused queue pairs, and they are lost. The
  driver detached these queues before 21.11.
- Patch 3 is a unit test of it, on a virtio-user port with two queue
  pairs and one Rx queue.
- Patch 4 adds a unit test of Rx interrupts on that port. Without the
  check of the interrupt handle type in patch 1, this test fails
  ("EAL: Wrong intr vector number"). This is why patch 1 has that
  check.
- Patch 5 adds a testpmd option, --rxq-interrupt. With it, idle
  forwarding lcores sleep on the Rx queue interrupts, as l3fwd-power
  does. It will need a line in the 27.03 release notes.
- Patches 6 and 7 add a DTS suite that uses this option. It has two
  test cases. In the first, each packet sent to the port must wake
  the lcore up, also after the port is configured a second time with
  the same number of queues. The second does the same after the
  number of queues changed, to two queues and back to one. With two
  queues, both must receive packets. It is skipped if the port cannot
  have two queues, or if the packets do not reach both.

Tested in a VM (QEMU 10.2, vhost-net):

- l3fwd-power in interrupt-only mode on a virtio-net PCI port. Without
  patch 1 it fails as in the commit message. With it, each packet
  wakes its lcore up.
- The DTS suite on a virtio-net PCI port. Without patch 1 both test
  cases fail at the second configuration. With it, they pass. They
  also pass on an emulated Intel 82576 port (igb driver). On a
  virtio-net port with one queue pair, the second test case is
  skipped.
- testpmd, receiving, on a virtio-user port with two queue pairs,
  while the kernel sends 64 UDP flows on the TAP interface. With one
  Rx queue, 22 flows arrive without patch 2, and all 64 with it. With
  two Rx queues, all arrive with and without it. A port of the TAP
  driver, and a virtio-net PCI port of QEMU with four queue pairs,
  receive all 64 on one Rx queue.
- The unit tests pass. Without patch 2, the first one fails. Without
  the handle type check of patch 1, the second one fails.

The unit tests log "Some interrupt handle is leaking an event FD" when
they close their port. This series does not cause it. main logs it for
any virtio-user port, with testpmd too, since commit 67813957d8
("interrupts: warn on leaked event FDs"), because virtio-user frees
its interrupt handle before it closes its call fds.

v3:
- Patches 2 and 3 are new. In v2, the unit test of Rx interrupts
  failed on about half of the CI hosts, because the kernel sent its
  frame to the TAP queue of the unused queue pair. Patch 2 fixes that
  in the driver.
- Patch 4 is that unit test, on top of patch 3. Its frame is now an
  IPv4 one.
- Patch 5: testpmd logs an error when the interrupt of an Rx queue
  cannot be registered (AI review).
- Patches 1, 6 and 7 are unchanged.

v2:
- Patch 1 keeps the eventfds when the number of Rx queues did not
  change (David Marchand). It releases them only when the number
  changed, and only then must an application register the Rx queue
  interrupts again.
- The unit test, the testpmd option and the DTS suite are new.

Patches generated with AI assistance.

Isaac Boukris (7):
  net/virtio: fix Rx interrupt setup with MSI-X
  net/virtio-user: fix packet loss with unused queue pairs
  test/virtio_user: add unit test of unused queue pairs
  test/virtio_user: add unit test of Rx interrupts
  app/testpmd: add Rx queue interrupts option
  dts: support virtio PCI ports
  dts: add Rx interrupt test suite

 MAINTAINERS                                   |   1 +
 app/test-pmd/parameters.c                     |   8 +
 app/test-pmd/testpmd.c                        |  93 ++++-
 app/test-pmd/testpmd.h                        |   2 +
 app/test/meson.build                          |   1 +
 app/test/test_pmd_virtio_user.c               | 339 ++++++++++++++++++
 doc/api/dts/tests.TestSuite_rx_interrupt.rst  |   8 +
 doc/guides/testpmd_app_ug/run_app.rst         |   8 +
 drivers/net/virtio/virtio_ethdev.c            |  18 +-
 drivers/net/virtio/virtio_user/vhost_kernel.c |  12 +
 .../net/virtio/virtio_user/vhost_kernel_tap.c |  14 +
 .../net/virtio/virtio_user/vhost_kernel_tap.h |   4 +
 dts/api/params/types.py                       |   1 +
 dts/api/testpmd/config.py                     |   2 +
 dts/framework/testbed_model/linux_session.py  |   9 +-
 dts/tests/TestSuite_rx_interrupt.py           | 122 +++++++
 16 files changed, 635 insertions(+), 7 deletions(-)
 create mode 100644 app/test/test_pmd_virtio_user.c
 create mode 100644 doc/api/dts/tests.TestSuite_rx_interrupt.rst
 create mode 100644 dts/tests/TestSuite_rx_interrupt.py

-- 
2.56.1

