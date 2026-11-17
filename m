Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACC8606A334
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s10UC+N1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0FE5402A4;
	Tue, 17 Nov 2026 13:43:37 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by mails.dpdk.org (Postfix) with ESMTPS id A56FA4026F
 for <dev@dpdk.org>; Tue, 17 Nov 2026 13:43:36 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so35660975e9.0
 for <dev@dpdk.org>; Tue, 17 Nov 2026 04:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794919416; x=1795524216; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=K6h3JdGM40eoHYUDJPQq1E/j7GT66h1rZRjRB2rEtV4=;
 b=s10UC+N13zmU+3yQtp0Cszjd7VuWOsPh4Hz4JvfmSI7SfkxOrsUt5JJMKY7cFpnKRO
 rnaoG4qS7lmRRHVYxBfJhGUw7/Q9SHfVDlHtvR3oVuE8/KpuOmC1PMG16Z9OETx2b5Hm
 nlQ0OQVzYnil6pVQ6Ojc22K6gBUP/8zZAPOaTeKnyJtrmRHf6Z6W2Q4LxMCciEhRyFYY
 j4AkP71601a2Mf8p+j757URwpNylnFU2RMFEHoEId4IOC8e+fcog/M8f4LMmTxHdY7uK
 2CV/EUZ7kejLB9zsFkf5zpOUjSdRk/PuHOXIgDc7Y5y57ctXPeBvTgwf1QezNMcLmOmd
 tmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794919416; x=1795524216;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K6h3JdGM40eoHYUDJPQq1E/j7GT66h1rZRjRB2rEtV4=;
 b=EhhSKcWho7GmpEpaHcC9vnuFr4tmxgMM0PTATvnaOHL79C1d9xMc8C3ATqMRPrJJqX
 NlYYF9xuWZtTxNySSyXwgsq+Sq168M/t973Q8qbo1fapKztz1eu7zHqIVwX04Y2WZ6R1
 AFygODUj/krPaAJEWiF1Mh2mqvhakq5GbbCg06OT6alIuA9vd3DJk9pkvvRBy+JtAD3d
 HWL5ZXHiepWJyweRRzw3vVi7wGzm8Y1+KI9jqeR57lZp8wd9BqAo3SbYSBxiFv1WwK8u
 JRknrizh8oH4Ssau35feopHfbPOFayzPPS4iOGKnle0Ng3KPzMbBD/SKyGzfiHDm7sw2
 rqVA==
X-Gm-Message-State: APuU4Z9ihw1lFfPNuvgKI3hXy1HR37l1y26+aeDAe8PxFhe8NRdPPery
 5RDd7gw2sEkROiX1lpLXpJ05l3VKWju8wJTpnulQGKzs4CQnmx9q9qJC
X-Gm-Gg: AYBFou3DkkJOGtfwU3nn1z60N88R+4G1NqH2yIk/SQ14T2h6hrk2W+Pksh8WN+aUJ7J
 lOjcdxp6r75yEpCgqfgZhi9YqHyFUdTg5DFJAUMn3uJw3pDF0HeFcTU6DxQZC7L32nOGHvNhxha
 oTVIgZw7mBT0ipD2KFmBpX6Wd1y8tif9xzqS9TEjSose045su2p/Qm6yv6lMbC03t/N6g8srzDJ
 /GMJZLTCLbIA4oLs46g4YPBhRBqQ8WuAo2bTB/ddqp8Knk/PnU9oHUDUoKROBvvAgTWZOo0nuld
 oALzWiJr8Io8q93w3iKPqNCJsavPOl/7GFhRPHVmf3TXtBximW3wtiftODV8hCwyHr/L54sEujh
 4ObMBm1808OogRZPvVdGpnBHhjgo7ZvFj9Ruf1eiRFNqjC2974HEidTHECEUbJ4ilMBNj+g4Hf5
 3Yt0ukgEiaOisGst4Ja1HVFGJvAoTKrtoUZax2kD7BjPC8agMrPL5U0BLtht8wrFrg8dEouqc2d
 JLML1gVJfVjHYyrTHnUDgWpKymTadFAaTrVgawflGcOEra32WpaV+jgd3iQuCWBlwOwwzAFHPSV
 m6eqkxZfwUSOuGEQNxbB
X-Received: by 2002:a05:600c:8819:b0:4a1:d8fc:8165 with SMTP id
 5b1f17b1804b1-4bb55a6ad4emr262464195e9.20.1794919415568; 
 Tue, 17 Nov 2026 04:43:35 -0800 (PST)
Received: from fedora ([46.210.208.90]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb78386902sm73523765e9.1.2026.11.17.04.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 04:43:35 -0800 (PST)
From: Isaac Boukris <iboukris@gmail.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: dev@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>,
 David Marchand <david.marchand@redhat.com>,
 Isaac Boukris <iboukris@gmail.com>
Subject: [PATCH 0/1] net/virtio: fix Rx interrupts with MSI-X
Date: Tue, 17 Nov 2026 14:43:02 +0200
Message-ID: <20261117124303.717447-1-iboukris@gmail.com>
X-Mailer: git-send-email 2.56.1
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
second time: l3fwd-power fails to start on it. This patch fixes it; it
is for 26.11 and stable.

Tested in a VM (QEMU 10.2, vhost-net):

- l3fwd-power in interrupt-only mode on a virtio-net PCI port. Without
  the patch it fails as in the commit message. With it, it starts and
  each packet wakes its lcore up.
- A port stopped, configured again and started: Rx interrupts still
  wake the lcore up (testpmd, with a patch that makes it sleep on
  them).
- Rx interrupts on a virtio-user port with a vhost-net backend, which
  the patch leaves alone: they work as before.

The legacy DTS has a test plan for this very case,
vhost_virtio_pmd_interrupt (l3fwd-power in a VM, on a virtio-net device
bound to vfio-pci); I did not run it. I will try to come up with a follow
up test for the DTS in the main tree, adding an option for testpmd to
sleep on Rx interrupts and a suite that uses it.

Patch generated with AI assistance.

Isaac Boukris (1):
  net/virtio: fix Rx interrupt setup with MSI-X

 drivers/net/virtio/virtio_ethdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.56.1

