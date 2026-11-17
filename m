Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3BB606A333
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 22:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fzARyudT
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1183402D8;
	Tue, 17 Nov 2026 23:00:29 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by mails.dpdk.org (Postfix) with ESMTPS id 0E930400D5
 for <dev@dpdk.org>; Tue, 17 Nov 2026 23:00:28 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so2601865e9.3
 for <dev@dpdk.org>; Tue, 17 Nov 2026 14:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794952827; x=1795557627; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sSVRGR2+lzkfoCT91SxZBO4HQjXmALXr0dCeZz99iN4=;
 b=fzARyudTn2G0bUPSR70fXXf51Hk/W/NcXl5IOuf6mY6BhswZv7iGNg2UI0Yi2/PcY9
 aH4NaJhqVelkpOdNmgEaWberuTNyoLQvLP/XnA24V5PXCdfHeVu1DabvMeSB4HOlpLJj
 ExFQIVjh/KiNSu4hCeL1Yl2rpsuGX4ISfEGC7Nd++e3bdzuoozUMRj1FnTa+96VdRvvF
 A3K27g9Y2hLj2CP12v/Hf/M76Bw33fWAMvvqnV09eeWcH8h7GJZpL136aOopmOnmIz9b
 lZT+Dn9uANVg/6lDS/p/xLcKY9lYiqgZgvSptEhhlwqpOjX4rHJ7AFMBRJcG0fDvNt6O
 kZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794952827; x=1795557627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sSVRGR2+lzkfoCT91SxZBO4HQjXmALXr0dCeZz99iN4=;
 b=sivUbkJ+/K++pzzP13tBDP8VzuLyQ2SyLVxNtc0Ysys858EXkLUG981yAczUBe+yBg
 p2Ckco9XcAJV7EgJ/9AEcPBm6oNV5KVU0TCMjuefYQ9RrkhY6zhpi9uaiuuPzTE+QSX+
 6ZNZ72VwhZUh3mnlolv8C2X2JFjICwMSsYB2wsDUcxNCjDKPEJ0rxwBBUMDNS3ddsniS
 jYlDE6dROo3YikfxUbpG1aRyUsfzu/F0n359w1PLU4TgIQ62ueqUdKdodtiAFBc8GcRz
 jfyvW7wUAO+RCLRr+xc2go1MSBDLzSfj0El0wOQFpiG1Hy9rTVV9E2pBlLozEYHlIvXE
 cRdA==
X-Gm-Message-State: APuU4Z8n+oTvU+qvG0NoAq93YxPcDrU2R9KWbPHDppVsA7CG5KS+q27W
 TRwCtUl2z7vCNdZkVM8zigi1/JoXrAlX0WSFxbU/AE6GQ8YB2ILTxtzU
X-Gm-Gg: AYBFou0MBO/VFMFa3qerfHAOdtGFF61+AaMYJLB/IGXNsdcPAGHdLgz7Sr64/M/vELS
 hP8EbvEFf5uMJ66gkOgrs9aurxC5pfEQl87lamTqnLq90FcGvIuwcayz7Hm2MEJuWPazfBMWci0
 3EV685MvN9+m4/nYpFFyq2G3TDoPaWV6C/U/4Po8ejXaOQ9hnlTB5hhwcBUwEkilfOjxbrXHaZs
 9RHB6YEY5mELpv6aROCUJbZUwg0cbtUMVyLJRFfzWwZI86MhKFLOtVxW51j/W5jxyaeneKQ8yMv
 nzNcdPVHI0n3Ahuqb3fmHMdT0XFYOSfk+d6Do3ZQUilZfjlcRpItJeNsFMiu//Dl2vEFlMASRoy
 B8Ux7WCmuA3risABWm/luWf+ER5rcZwibl9hV5tdxGE+JNENgkhCROtTQpU86zjiQJs0wbLiJjU
 xcJM2LRUdRztt7Sk/uiZ0QUmqclML4Ht7tNLw5FGa8G9gyfsbt6CLSJaXMrr7wji5CMDBcGg/TO
 YMutP50L7Lcwj753TBFrZmJbFPufCDuqbUzWYkMcJT9n2/OVKVEosWZdbADKTndW9qo1N1kIphb
 28GPxAjc54jE7nJcjMkW
X-Received: by 2002:a05:600c:1553:b0:4ba:493b:3401 with SMTP id
 5b1f17b1804b1-4bb7da12847mr9311035e9.9.1794952827369; 
 Tue, 17 Nov 2026 14:00:27 -0800 (PST)
Received: from fedora ([46.210.208.90]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c37fsm1011390f8f.18.2026.11.17.14.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 14:00:23 -0800 (PST)
From: Isaac Boukris <iboukris@gmail.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>,
 Isaac Boukris <iboukris@gmail.com>, stable@dpdk.org
Subject: [PATCH v2 1/5] net/virtio: fix Rx interrupt setup with MSI-X
Date: Tue, 17 Nov 2026 23:59:57 +0200
Message-ID: <20261117220001.965310-2-iboukris@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117220001.965310-1-iboukris@gmail.com>
References: <20261117124303.717447-1-iboukris@gmail.com>
 <20261117220001.965310-1-iboukris@gmail.com>
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

