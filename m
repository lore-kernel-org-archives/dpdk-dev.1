Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB68606A331
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mjho00fa
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D57B402CE;
	Tue, 17 Nov 2026 13:43:42 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by mails.dpdk.org (Postfix) with ESMTPS id 8E797402D2
 for <dev@dpdk.org>; Tue, 17 Nov 2026 13:43:40 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so54812605e9.2
 for <dev@dpdk.org>; Tue, 17 Nov 2026 04:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794919420; x=1795524220; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eV7SQL/L46/1vnv/0o7aw6IMHSyZOPYru7cTRNq1joM=;
 b=mjho00farHB55vgwmkiGZMsKqBqKotjcFcGwAr0R/loGmhHiODAZNQwzVE8aHuY/CR
 3bOHP1TC6CefKbPTCVpPxUZlmCm2BGXNYuP3MOLm+yP+If2onUrefUxxdq5Wx1Nl1IB9
 pTEivNKIaiuPZkAAWpUbD+/m8gNDs7B1B0bYW+XiQ+Yeh26RRR9wnPiSg9peSMRmVfDI
 2h2EF7hgb6fCrYkCHMhGSQU12rMDSSeYw0aVTScTUE3ntIeYqrHy79FpEMkdwSTNeXOH
 +1uHOVPIHCArzUAT9Wx04hVb1AXnIC9qRQkKvXTNeQi5uDgDwvWx3Fx/+xk6Yv3CccR+
 GAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794919420; x=1795524220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eV7SQL/L46/1vnv/0o7aw6IMHSyZOPYru7cTRNq1joM=;
 b=F78TibGyEbfNC/3zKsUAk/e0TJe0CWc5V/CQJnKNBWcPFcLXaxnw2xVj49/PA3CxvT
 +Jg7XJLjEBPBdo2JS/ja2jh47VtBoVFDUVndg704G6P+0NQyJmHx6GzIGmVpIZCR88DD
 Kdahp/bEoSvQtmqLpcrc29U7D6rK6Nayinslvy+89YMbFdGhoRCyd3khJhjS18eQ/NmX
 I6xRKn0cOgluwurY8oWgabetw7dqY72BwE8NvFFtIYdplPiaalicjHuAMIsVfs28lmvO
 5VwhXS7eXZIK0sPgPL7GLLQdAuSOhbyZqQA1bAaeNXfU+YQsm79G6lEFN83SCffcdHxC
 aQPw==
X-Gm-Message-State: APuU4Z+/RuwREP4CTw9Frtir3MVWL6UfG7sTE6j7J9w6+YcrdtCo5ykW
 /Wb8kFmbQD8BXdJ1jbP/haghsfPTv25aohC/jZLchUrGKUXuxgiYbFGu
X-Gm-Gg: AYBFou0qcopzt0pfIBp/pxftCxsYVpJWIaE/FfOZYk3Uk+NQcHi9XD6fzvPfVNHXMwC
 dWVuTrHdnDBBul6cubFpXwrDSr66xq4e4jE+/rmrLKqGO00hylyx2TTipHRtvjuGZJfEV8G1WPC
 jm/DBUS+/rTvlAitgNyd0fGGCwhJG4NdYZaTlBdPrJ4kHpW5LHq3JEx2ASt/lyJaMBsbP6YKu2/
 rEKYmuq0cdKwnk6laKKqQ3icqf0CQJY1Omzb2GQnD6HMJpGWjrAJhXA9y6EarDlJRLVgpcAW5C0
 oAPlzNUKGQzuHdOOfiLAB0JEYqLbM0yX7q1j5M5zs0Y5dhThSx8fiXkzQfMsj+dBOvH68MdzXJD
 TiD80raPiUUudF9/BrqIVh7/rAbsom5h3l096dPR9MhOMx59FoCorp50seg8Thb8N0GbzuKCdaU
 MK3xhfjtyP5j8PE2c7wbvy5xgJNmPcHMvMnomylM+A+sBcZuO1rFlrADLvNJf0AHM2W5iR4sy8Z
 WVSbTOLOpaA1Y4eo7qWNlQ1uDmBRAKIq2XyLBCC3J6ZMCQQYGK8fbjSs5twPJKY9Jo/D1qypT06
 zzpgWLVpVvqmSC7tyo8Vzfhi4Nb73I2T3AAt/1J8Hw==
X-Received: by 2002:a05:600c:482:b0:4a5:75d2:c104 with SMTP id
 5b1f17b1804b1-4bb55a59c9dmr211383375e9.22.1794919420058; 
 Tue, 17 Nov 2026 04:43:40 -0800 (PST)
Received: from fedora ([46.210.208.90]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb78386902sm73523765e9.1.2026.11.17.04.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 04:43:39 -0800 (PST)
From: Isaac Boukris <iboukris@gmail.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: dev@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>,
 David Marchand <david.marchand@redhat.com>,
 Isaac Boukris <iboukris@gmail.com>, stable@dpdk.org
Subject: [PATCH 1/1] net/virtio: fix Rx interrupt setup with MSI-X
Date: Tue, 17 Nov 2026 14:43:03 +0200
Message-ID: <20261117124303.717447-2-iboukris@gmail.com>
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

Disable the interrupts and release the eventfds before enabling them
again.

Do it for a VFIO MSI-X handle only, the type whose eventfds EAL
creates. The other type that gets here is virtio-user's: its eventfds
are the backend's call fds, set once when the device is created.
Releasing them would reset their count, which nothing sets again, and
registering an Rx queue's interrupt would then fail.

To reproduce, with a virtio-net PCI device bound to vfio-pci:

  dpdk-l3fwd-power -l 0 -a 0000:0c:00.0 -- -p 1 --interrupt-only \
      --parse-ptype --config="(0,0,0)"

Fixes: 3ba6b689893f ("eal/linux: fix eventfd leaks when enabling interrupts")
Cc: stable@dpdk.org

Signed-off-by: Isaac Boukris <iboukris@gmail.com>
---
 drivers/net/virtio/virtio_ethdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/virtio/virtio_ethdev.c b/drivers/net/virtio/virtio_ethdev.c
index f2302089ee..37fc896fae 100644
--- a/drivers/net/virtio/virtio_ethdev.c
+++ b/drivers/net/virtio/virtio_ethdev.c
@@ -1455,6 +1455,13 @@ virtio_configure_intr(struct rte_eth_dev *dev)
 		return -ENOTSUP;
 	}
 
+	/* Reinitialization: release the previous eventfds first. */
+	if (rte_intr_type_get(dev->intr_handle) == RTE_INTR_HANDLE_VFIO_MSIX &&
+	    rte_intr_dp_is_en(dev->intr_handle)) {
+		virtio_intr_disable(dev);
+		rte_intr_efd_disable(dev->intr_handle);
+	}
+
 	ret = rte_intr_efd_enable(dev->intr_handle, dev->data->nb_rx_queues);
 	if (ret < 0) {
 		PMD_INIT_LOG(ERR, "Fail to create eventfd");
-- 
2.56.1

