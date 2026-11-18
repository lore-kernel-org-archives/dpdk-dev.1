Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA88606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 00:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XT3mQVWa
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6ACB3402DF;
	Wed, 18 Nov 2026 01:19:38 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by mails.dpdk.org (Postfix) with ESMTPS id 79185402BD
 for <dev@dpdk.org>; Wed, 18 Nov 2026 01:19:36 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so3916545e9.2
 for <dev@dpdk.org>; Tue, 17 Nov 2026 16:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794961176; x=1795565976; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sSVRGR2+lzkfoCT91SxZBO4HQjXmALXr0dCeZz99iN4=;
 b=XT3mQVWawBvArzbRaeU1qWF8TypPY8GybNDw5oTTPxgIz92IZiWH0sBnazq5cszZO5
 N3kr+KaCJpGZVNKZZZ2MkBtSo5lKWdRu+vW1zKM8CRlQbx4j3fferVEJYUNd6TVtnhus
 NfU6yXszncfWQ7ygneiWcqhe6KssgIJiSq4we3BOorG1JwWurlzDkbuDA48vaSAxE/q8
 HZlRc1CziNp7OabUiDsQDW+5eXYx7A3PI6G978XYCjiTHIo2gBGvILyQCQr2cZbA0lkO
 BGPJuZ1Q9iJ36aACsMYkZcWBuwZsn9v7jnupOWYv0dPrvleJi0hXqN2Gt2W2YlqTrn3r
 FWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794961176; x=1795565976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sSVRGR2+lzkfoCT91SxZBO4HQjXmALXr0dCeZz99iN4=;
 b=vA3PaKp8SvWffscPu2KiQMEKvEO4y24Q+kf1GEl7wtaO9Ec9F7ZuR6mFkMhkUUmrzQ
 hOOULr0k50Dd6Xy+F28FSpUkNwetyZfkHrGl68b29jNEhI0jcQDD+zs1aegmdc2pVhUv
 nBeE1gXK91jDEzrDPNl64GDyZnFu/e8nludxO9poz4NFcKhwsAL/HUoFxS1AaL6yHGkK
 5Nffl6G3YbNUFeD2LfHGe+CHwjQg7Ae/r7zH/cijCZxvcBgGR9m6Sx7/Bum1yOQDXZni
 lFs6maVsvt+rOSt3C7HKJPbev3F3K0x2mpGRKupBi9u/4MDN6ntS2iVt8NH0i7AKfL4R
 9tiQ==
X-Gm-Message-State: APuU4Z8jLK9ukABjqptSR/G3rlUUnmf5lfKuKj8+oXKPk9IGEcf2ec4Z
 vAiK3h5GNrr0yXRTG5QfQVbsSv8KP+f0HO5ss85XxEY1cZV5RTk/4b75
X-Gm-Gg: AYBFou2Nrq0UiLXy3OH3oDFEoLX7NnWzqIkUgzI7cPNaER6JCUiXMU4sWzM0PRcDadm
 HIPSThJymB1HsNKccRne7nhH2IfY5MUX8UZ3PbXpRhk7lFTSt4k9Pe5KirYvgZUvb7bVN/qY/2D
 3P4WduLbkylpiqgp9Boni7OWXnLG0XUj9T0obWBHJIfGuqgQ0t2U/MNgh1NMp6kMkBdQeu0HQF6
 ZAzLN+m2KFkXKBrrlijR1Fnaawla8GtuxRVc+wvwUuWJR/T0x+jnoCiOL1vWDQY0eCV2oN8pNYs
 9RWiT8TqtjF5Dahca9CcNZPiHF20/s5MDx+jdvrHVV8YBYjY4wHpZHwXxvCdyr6Bh0k2N/ZhZiR
 oTDgUJaSI7Oywv3rzXaN1Bq1ZICASa1Dw+bktYNy1RovB4Y1Z3/JPm+LaGeF1LEwxfoyfAaR4x0
 a1pqxVjVYJ13PVmME9wanmBMWjT3nMOi8xqYYMzSSK3iJOt4cDqXzVj79C1ysc00HfcXC/7G+xV
 pGverdmQaXF9X1gNX1msSbq/vkG9yH1RvJqwmbbuEkCU6nUokqjfJLWDrSX3TcH4Q5aVep54skT
 hMphMOsX1CF5bZBHJ6N4
X-Received: by 2002:a05:600c:1d1f:b0:4bb:6a5a:7839 with SMTP id
 5b1f17b1804b1-4bb7da4d216mr16769515e9.34.1794961175939; 
 Tue, 17 Nov 2026 16:19:35 -0800 (PST)
Received: from fedora ([46.210.208.90]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7e50e992sm4655025e9.0.2026.11.17.16.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 16:19:35 -0800 (PST)
From: Isaac Boukris <iboukris@gmail.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>,
 Isaac Boukris <iboukris@gmail.com>, stable@dpdk.org
Subject: [PATCH v3 1/7] net/virtio: fix Rx interrupt setup with MSI-X
Date: Wed, 18 Nov 2026 02:19:12 +0200
Message-ID: <20261118001918.990884-2-iboukris@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118001918.990884-1-iboukris@gmail.com>
References: <20261117124303.717447-1-iboukris@gmail.com>
 <20261118001918.990884-1-iboukris@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With Rx interrupts enabled, configuring a port initializes the device,
and a second time when an offload or RSS is requested. Each
initialization enables the interrupt eventfds.

EAL now refuses to enable MSI-X eventfds twice, so such a configuration
fails, and so does configuring a port a second time:

  EAL: Interrupt eventfds are already enabled
  virtio_configure_intr(): Fail to create eventfd
  ETHDEV: Port0 dev_configure = -16

Before that EAL change, the previous eventfds were leaked.

Enable the eventfds only when they are not enabled yet. There is one
eventfd per Rx queue. So if the number of Rx queues changed, release
the eventfds first, and new ones are created. The application must
then register the Rx queue interrupts again.

Release them for a VFIO MSI-X handle only, the type whose eventfds EAL
creates. The other type that gets here is the virtio-user one. Its
eventfds are the backend's call fds, one per queue pair, set once when
the device is created. Releasing them would reset their count, which
nothing sets again, and registering an Rx queue's interrupt would then
fail.

To reproduce, with a virtio-net PCI device bound to vfio-pci:

  dpdk-l3fwd-power -l 0 -a 0000:0c:00.0 -- -p 1 --interrupt-only \
      --parse-ptype --config="(0,0,0)"

Fixes: 3ba6b689893f ("eal/linux: fix eventfd leaks when enabling interrupts")
Cc: stable@dpdk.org

Signed-off-by: Isaac Boukris <iboukris@gmail.com>
---
v2: keep the eventfds unless the number of Rx queues changed (David Marchand).

 drivers/net/virtio/virtio_ethdev.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio/virtio_ethdev.c b/drivers/net/virtio/virtio_ethdev.c
index f2302089ee..8600f3899a 100644
--- a/drivers/net/virtio/virtio_ethdev.c
+++ b/drivers/net/virtio/virtio_ethdev.c
@@ -1455,10 +1455,20 @@ virtio_configure_intr(struct rte_eth_dev *dev)
 		return -ENOTSUP;
 	}
 
-	ret = rte_intr_efd_enable(dev->intr_handle, dev->data->nb_rx_queues);
-	if (ret < 0) {
-		PMD_INIT_LOG(ERR, "Fail to create eventfd");
-		return ret;
+	/* On reinitialization, release the eventfds if the number of Rx queues changed. */
+	if (rte_intr_type_get(dev->intr_handle) == RTE_INTR_HANDLE_VFIO_MSIX &&
+	    rte_intr_dp_is_en(dev->intr_handle) &&
+	    rte_intr_nb_efd_get(dev->intr_handle) != dev->data->nb_rx_queues) {
+		virtio_intr_disable(dev);
+		rte_intr_efd_disable(dev->intr_handle);
+	}
+
+	if (!rte_intr_dp_is_en(dev->intr_handle)) {
+		ret = rte_intr_efd_enable(dev->intr_handle, dev->data->nb_rx_queues);
+		if (ret < 0) {
+			PMD_INIT_LOG(ERR, "Fail to create eventfd");
+			return ret;
+		}
 	}
 
 	ret = rte_intr_vec_list_alloc(dev->intr_handle, "intr_vec",
-- 
2.56.1

