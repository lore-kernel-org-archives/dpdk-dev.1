Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4CD606A32A
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 22:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I/vndZYL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A135402BF;
	Tue, 17 Nov 2026 23:00:23 +0100 (CET)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by mails.dpdk.org (Postfix) with ESMTPS id 88223402A4
 for <dev@dpdk.org>; Tue, 17 Nov 2026 23:00:21 +0100 (CET)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-491f34b4e0fso95188f8f.2
 for <dev@dpdk.org>; Tue, 17 Nov 2026 14:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794952821; x=1795557621; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3KpW2Mz+E+TP39sVd9185g2l59WM3iFale19YNZ4nNA=;
 b=I/vndZYLwSYNyv4mATdnzoyYOYSnsF+F/AmboYLGM/E8DB7Vw95sGsz6c9CnKVWHoT
 7Mk0m4bdl6vQPs3qhbGfpXfYq6FbsSxJSPsexwZy0BHbEYX9oozw5uJiG6DBXQTDy8Jg
 8VCML6h4SbILLiFmV/uH0AVB3wk32WuUdemeCvwFT0h+Yg8f3NqpbuLV1cJUHB4b370r
 z9oY5voghYL5DuURhNBl5QCwlQvvI7q2e3M+MhK6NL6Rimn7+P3vmTcWaibunRsTGUCg
 eOjyhtFXncVm2npLhyAy0Q6Fo5r2f5UrL6VAtRwzdDoDG+3yYH0NEGFyytgoFtjLcX53
 ox9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794952821; x=1795557621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3KpW2Mz+E+TP39sVd9185g2l59WM3iFale19YNZ4nNA=;
 b=SXbEQX50/4cXPJWOZQGIYlEwJaBufKVX1eNQ53DQ1iia9tejiuT7/VvX7KEfgK1z0z
 aMqCKsMChhTGFFY22Q2oRenql/OiQtndoao5nqfl5WLnvHGWAOsITU8rY3ArsljbzTrD
 UrZpa258IQgTRqra1xiFaUPtqD/pgO9F2+DnVtikp54VnREjyjNA+4e3ovutw5nSRej3
 FIPQ3eFcDXiGgJbjL+GwGNneGLbdMmc0aaWkCUDbhF2oI4tbtSORnsKzyRv5ckqlPJPh
 uPIsfud/BetQBxJb8TAL6DfwuDOuMbiRT9eVlQCWPe1QwL6GhHYOHKorTsxm6SrWS8Vz
 m6sQ==
X-Gm-Message-State: APuU4Z8X88sKXf5ZjYd5Wa1uRLEvTTfiGThDLHOjLm2pvFLg9riDo753
 jnU8hc/RTXZC/PdVG/jze/Eh+NrVLuk1VEMEqEG43CUBr8T0CHogVSFp
X-Gm-Gg: AZFdTZfI+1ajyZYDcxvOY09rp2ldpyq+UlPrPaIMxUhQXXj5J+1TXl0oqBJbc32DijX
 9ub5yxe+8TaUAOdA2tEm8ERMpRk+JconBPW4AhewRuhz3OhPLPioZ4E8N3AMVtEV/ViQOEq5L3K
 0M+wxA/oZG/1hRUIG2y0KI9cUF88WzDrBQhY7iRX8WqOjdoGryH4d2K35r/FK2yHTb1VkVegVEJ
 GaluUJPn8eDvQoS1AnYp++Fje0XTXb1UBJ+Y0yttyWBvB5cJ20ENpfwlhm/vIxIBYN/zRZEbXnl
 k92XmILR6QKOth3vr8XTM8dYl5zwqvMJvB6kn7ReNwlT+yQlN/IgyCM8RZyT6oLnmyaQ6+KX8Ak
 +vjTyevfKR0xwTD84KMhQkxOTzo1w1irleD5yBbEIZRn9yYGk8wp70qRCv5YCdq/c4ra79p1XKA
 IWRkEV/4cu7uMEWAlhfGcvxfiUoS9YaN8x5k1H0zYI7V7PRWOZjKv4uxIFsASp1vDL1hmXwdNCT
 JaRKJFK/XM8PCKThvTgHza5jLod4LHGgJti2VTX+oSXK32Ti3uSJBdEef4ex80X7WBBANha2YWs
 sf9XwKyqhwVSjUyIktbh
X-Received: by 2002:a05:6000:26cc:b0:4a6:c3f:9d0e with SMTP id
 ffacd0b85a97d-4a63c374195mr1658426f8f.44.1794952820788; 
 Tue, 17 Nov 2026 14:00:20 -0800 (PST)
Received: from fedora ([46.210.208.90]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c37fsm1011390f8f.18.2026.11.17.14.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 14:00:19 -0800 (PST)
From: Isaac Boukris <iboukris@gmail.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>,
 Isaac Boukris <iboukris@gmail.com>
Subject: [PATCH v2 0/5] net/virtio: fix Rx interrupts with MSI-X
Date: Tue, 17 Nov 2026 23:59:56 +0200
Message-ID: <20261117220001.965310-1-iboukris@gmail.com>
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

Patch 1 is the fix, for 26.11 and stable. The other patches are its
tests and can wait for 27.03.

- Patch 2 is a unit test of Rx interrupts on a virtio-user port.
  Without the check of the interrupt handle type in the fix, this
  test fails ("EAL: Wrong intr vector number"). This is why the fix
  has that check.
- Patch 3 adds a testpmd option, --rxq-interrupt. With it, idle
  forwarding lcores sleep on the Rx queue interrupts, as l3fwd-power
  does. It will need a line in the 27.03 release notes.
- Patches 4 and 5 add a DTS suite that uses this option. It has two
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
- The unit test passes with and without patch 1.

The unit test logs "Some interrupt handle is leaking an event FD" when
it closes its port. This series does not cause it. main logs it for
any virtio-user port, with testpmd too, since commit 67813957d8
("interrupts: warn on leaked event FDs"), because virtio-user frees
its interrupt handle before it closes its call fds.

v2:
- Patch 1 keeps the eventfds when the number of Rx queues did not
  change (David Marchand). It releases them only when the number
  changed, and only then must an application register the Rx queue
  interrupts again.
- Patches 2 to 5 are new.

Patches generated with AI assistance.

Isaac Boukris (5):
  net/virtio: fix Rx interrupt setup with MSI-X
  test/virtio_user: add unit test of Rx interrupts
  app/testpmd: add Rx queue interrupts option
  dts: support virtio PCI ports
  dts: add Rx interrupt test suite

 MAINTAINERS                                  |   1 +
 app/test-pmd/parameters.c                    |   8 +
 app/test-pmd/testpmd.c                       |  86 +++++-
 app/test-pmd/testpmd.h                       |   2 +
 app/test/meson.build                         |   1 +
 app/test/test_pmd_virtio_user.c              | 296 +++++++++++++++++++
 doc/api/dts/tests.TestSuite_rx_interrupt.rst |   8 +
 doc/guides/testpmd_app_ug/run_app.rst        |   7 +
 drivers/net/virtio/virtio_ethdev.c           |  18 +-
 dts/api/params/types.py                      |   1 +
 dts/api/testpmd/config.py                    |   2 +
 dts/framework/testbed_model/linux_session.py |   9 +-
 dts/tests/TestSuite_rx_interrupt.py          | 122 ++++++++
 13 files changed, 554 insertions(+), 7 deletions(-)
 create mode 100644 app/test/test_pmd_virtio_user.c
 create mode 100644 doc/api/dts/tests.TestSuite_rx_interrupt.rst
 create mode 100644 dts/tests/TestSuite_rx_interrupt.py

-- 
2.56.1

