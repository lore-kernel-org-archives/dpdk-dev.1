Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014D3606A32C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 08:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vOzptu0p
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4441402BD;
	Wed, 18 Nov 2026 09:28:10 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by mails.dpdk.org (Postfix) with ESMTPS id 550D240298
 for <dev@dpdk.org>; Wed, 18 Nov 2026 09:28:10 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4bb6886d30aso5918025e9.3
 for <dev@dpdk.org>; Wed, 18 Nov 2026 00:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794990490; x=1795595290; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/ZJhRbhqPUicwrP5pWyZ3Gc0dpPI6Lx5/nf665xor3M=;
 b=vOzptu0ppQurSUk486ajfFZ7T8qPC7xllWHHcSQ9QVgCEwNbTvNLNWJ5A3mVYk3RHV
 X3/qvZJr71LeU/DF3PZlsAGPS88g5OaVOd3OBuBkH0/0qYmG5xOUQYk3iQy8vOx5oL9+
 NeSE+uOseB0yJH2mjVhJjEQZrLfWmiGOIMoOyuBitIczZG3WRcvVnt7SAsQ5J5kOBqiV
 3gKBsOpyrKC0Iok6N+/xOXnE0utl5j6DnHKjyRBb1uL9AuVMJpWd49UCoFfTjALlLpX7
 Ftldpgf39iIjBQvRA+i7nmZpQUj/uTIjX9tsJSVvRt8rHD8tuNoCFJqIbLxfvPKkcIWh
 z5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794990490; x=1795595290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/ZJhRbhqPUicwrP5pWyZ3Gc0dpPI6Lx5/nf665xor3M=;
 b=27eMCylC9PIr9DoXj+/Q1erSStC87CgG8Ahc3SC6ifEM/zCSiyjB6BjnsDMNKulPDr
 4L9yRtuUmzCQsd4Bula/bD6JDfUtk03VEadxr4B60A1mC7oJlbSgo2O9kSbHKVzg1dF7
 sp8yQlAMHP66qXfh2Sj0GH/UBxgES04IFZ1PoFribRvz56iiRNVSlSWzEmrnmELEaBF/
 /ijEcxAE6maiVm7At3TlqttgBt+Cm/4GEI3sqyc5hegdf6DVWIEmNE4KcbmND+LkjNHN
 Cyd3kw4zf10S5mw3nP2y20HMiqIZUyVBtllIHQK2x08HsFe3yzbxqoAy6T/PaHNIcjrC
 e5Tg==
X-Gm-Message-State: APuU4Z+Y1IJUMvVoMPXOHDzZGO/6FDXXDv0XIimWH6bj/FyoD1nnSFVN
 E1y/AJsAiNkBdVMOLE1inSyRWsDNPaKFUq6HrutZIExLUm+IVkEMxogD
X-Gm-Gg: AYBFou3dUGGWaFCDnS2kA02y6xrkqVm+4Ia7SxnixDf3zuqv3PdAd0g8wMq8AzjH1qD
 5qrs+8RrRQMLamzMK1k0h+l6W58A6xHC6SJAIJyNgEN1x4LmN5TzkKM227nERHw4Udh05qU9BoO
 hJo6nH9rOYvDFJ21tP8lbBH0KPJLGrJr8HzC//1JIZdEZgpPLxrSICV++rw3AyKi3+zJ1kKfu9a
 hglqnXNcHVjFOLP2jfCCWmVbFaE1W+0f4QZDsmO/0TQUPFxJ3C/6Ad/JHmew93++APIJ+oIoOkG
 vzqSfDuVvyK3zXw5OHQOjDuRQq1RfDTj5qO9bX+wacmR1RttIywqwG0WYp7nelVGegzehU5vv4V
 igTOT/0pLAsVy18AhRDHGwuGAuudG6FThVuZGnNAoTLrD1REfSPey+RDJ9ozi7loQovtlCb8b8J
 EcYkf0bwYw7hAhP5ae1vl0Km1YN4FU4pfjK/hBvzIOnYKrkM2iEe1T/ettDSiFfWBvVMjS6XOWt
 9oTQe0RRV5SgNM/iI4L3ly1zpfDWm7Uo0zC3ECWLFMSQNEayMhASi6Lu6dywdPz9LTBqDVS76b4
 gYRT8VUDupDXU1RRFgLPXuZKrXhtOP8v3oK53Qm1GQ==
X-Received: by 2002:a05:600c:6708:b0:4bb:534b:ada4 with SMTP id
 5b1f17b1804b1-4bb7da3c9dcmr30944895e9.33.1794990489447; 
 Wed, 18 Nov 2026 00:28:09 -0800 (PST)
Received: from fedora ([46.210.233.16]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d2cfb3esm55097605e9.15.2026.11.18.00.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 00:28:08 -0800 (PST)
From: Isaac Boukris <iboukris@gmail.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>,
 Isaac Boukris <iboukris@gmail.com>
Subject: [PATCH v4 0/8] net/virtio: fix Rx interrupts with MSI-X
Date: Wed, 18 Nov 2026 10:27:44 +0200
Message-ID: <20261118082752.1043794-1-iboukris@gmail.com>
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
configured with Rx interrupts and an offload or RSS, nor configured a
second time. l3fwd-power fails to start on it.

Patch 1 is the fix, for 26.11 and stable. The others can wait for
27.03:

- Patch 2 fixes a packet loss on virtio-user ports with vhost-net,
  which the unit test of v2 found. When the application uses fewer Rx
  queues than the port has queue pairs, the kernel still sends flows
  to the TAP queues of the unused pairs. The driver detached these
  queues before 21.11.
- Patch 3 fixes unaligned reads in virtio-user's control queue, which
  the sanitizer reports on the port of the unit tests.
- Patch 4 is a unit test of patch 2, on a virtio-user port with two
  queue pairs and one Rx queue.
- Patch 5 is a unit test of Rx interrupts on that port. It fails
  without the handle type check of patch 1 ("EAL: Wrong intr vector
  number"), which is why patch 1 has that check.
- Patch 6 adds testpmd's --rxq-interrupt. Idle forwarding lcores then
  sleep on the Rx queue interrupts, as l3fwd-power does. It will need
  a line in the 27.03 release notes.
- Patches 7 and 8 add a DTS suite that uses it. Each packet must wake
  the lcore up, also after the port is configured again with the same
  number of queues (first case), and with two queues and then one
  (second case, where both queues must receive packets).

Tested in a VM (QEMU 10.2, vhost-net):

- l3fwd-power in interrupt-only mode on a virtio-net PCI port fails
  without patch 1, as in its commit message. With it, each packet
  wakes its lcore up.
- The DTS suite on a virtio-net PCI port fails without patch 1 at the
  second configuration, and passes with it. It also passes on an
  emulated Intel 82576 port (igb).
- testpmd on a virtio-user port with two queue pairs and one Rx queue
  receives 22 of 64 UDP flows from the kernel without patch 2, and
  all 64 with it. A port of the TAP driver, and a virtio-net PCI port
  of QEMU with four queue pairs, receive all 64 on one Rx queue.
- The unit tests pass, also with ASan and UBSan. The first fails
  without patch 2, and the second without the handle type check of
  patch 1. UBSan reports the unaligned read without patch 3.

The unit tests log "Some interrupt handle is leaking an event FD" when
they close their port. This series does not cause it. main logs it
for any virtio-user port since commit 67813957d8 ("interrupts: warn
on leaked event FDs"), because virtio-user frees its interrupt handle
before it closes its call fds.

v4:
- Patch 3 is new.
- Patch 2 detaches the TAP queue again when a later step of the
  enable fails. One comment now says when a queue is attached, and
  why TUNSETQUEUE is not called twice for a state (AI review).
- Patch 4 ignores a flow number that is out of range (AI review).
- Patch 5 asks for the Rx offload without checking the capability
  first.
- Shorter commit messages and comments in all patches. Patches 1, 6,
  7 and 8 have no code change.

v3:
- The fix of the packet loss and its unit test were new. In v2, the
  unit test of Rx interrupts failed on about half of the CI hosts,
  because the kernel sent its frame to the TAP queue of the unused
  queue pair.
- The unit test of Rx interrupts moved on top of them, with an IPv4
  frame.
- testpmd logs an error when the interrupt of an Rx queue cannot be
  registered (AI review).

v2:
- Patch 1 keeps the eventfds when the number of Rx queues did not
  change (David Marchand). It releases them only when the number
  changed, and only then must an application register the Rx queue
  interrupts again.
- The unit test, the testpmd option and the DTS suite were new.

Patches generated with AI assistance.

Isaac Boukris (8):
  net/virtio: fix Rx interrupt setup with MSI-X
  net/virtio-user: fix packet loss with unused queue pairs
  net/virtio-user: fix unaligned reads of control commands
  test/virtio_user: add unit test of unused queue pairs
  test/virtio_user: add unit test of Rx interrupts
  app/testpmd: add Rx queue interrupts option
  dts: support virtio PCI ports
  dts: add Rx interrupt test suite

 MAINTAINERS                                   |   1 +
 app/test-pmd/parameters.c                     |   8 +
 app/test-pmd/testpmd.c                        |  89 ++++-
 app/test-pmd/testpmd.h                        |   2 +
 app/test/meson.build                          |   1 +
 app/test/test_pmd_virtio_user.c               | 327 ++++++++++++++++++
 doc/api/dts/tests.TestSuite_rx_interrupt.rst  |   8 +
 doc/guides/testpmd_app_ug/run_app.rst         |   7 +
 drivers/net/virtio/virtio_ethdev.c            |  18 +-
 drivers/net/virtio/virtio_user/vhost_kernel.c |  24 +-
 .../net/virtio/virtio_user/vhost_kernel_tap.c |  14 +
 .../net/virtio/virtio_user/vhost_kernel_tap.h |   4 +
 .../net/virtio/virtio_user/virtio_user_dev.c  |  26 +-
 dts/api/params/types.py                       |   1 +
 dts/api/testpmd/config.py                     |   2 +
 dts/framework/testbed_model/linux_session.py  |   9 +-
 dts/tests/TestSuite_rx_interrupt.py           | 119 +++++++
 17 files changed, 637 insertions(+), 23 deletions(-)
 create mode 100644 app/test/test_pmd_virtio_user.c
 create mode 100644 doc/api/dts/tests.TestSuite_rx_interrupt.rst
 create mode 100644 dts/tests/TestSuite_rx_interrupt.py

-- 
2.56.1

