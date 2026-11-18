Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E517606A325
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y56IC4xr
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5BB2402E0;
	Wed, 18 Nov 2026 09:28:14 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by mails.dpdk.org (Postfix) with ESMTPS id 1B5A1402DD
 for <dev@dpdk.org>; Wed, 18 Nov 2026 09:28:13 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so7667675e9.2
 for <dev@dpdk.org>; Wed, 18 Nov 2026 00:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794990493; x=1795595293; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k67xp/lnQzfTDsAyDgt07TRZBvlLoumRHMlBckIlVik=;
 b=Y56IC4xrxxkLKOHS5eUY/WOh/Ld8qAzQf1RygaG/gbDdInvgl9lRi4VJwv6Bx0dO9k
 6fS2C+QmGlOlzFAckXNXD7zurPAJKotVRwRwGC5vH77fvk0n+v/k7IYf0MbPu7NQuN8r
 2MxaAxwYPbP7dY0ql/hDfNxkmXYLW6/abqun3R7TAZs/0PAEWPSMCmqWuNNvcz/FP0Wn
 3rCM7WaA0rSSz+Gxk91bbDWQOVqPzCNcsj7FDT6gF0GyqU1C8AJ3Co3F8wu2MEITD25+
 7tZVWFndgUvb6B2lJv1ycCqNl1dvc2YpxvUbaSqEBhU2crnxSadk06GjY68fCvS8zIa8
 4ovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794990493; x=1795595293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=k67xp/lnQzfTDsAyDgt07TRZBvlLoumRHMlBckIlVik=;
 b=Gd+APCLRS6jgjScbB/yKyaRVJC9BAgUFtl+jchh2sjJWNumY6njBwrvkg2BSzM88+a
 1pzgBrXzB216AHhCEdlMa25vQYvLmS+UQqMRUU40bHJcrTUShxjwYoI7iMPZqMUgeOmI
 9FdbpPtz+3StQ/RKVKhV8wOJMoF3NpRoI5nGP5pI4QynqZn9gj4Cf/DLGfLDPB8C2KyG
 XEsCfDwQDR5fU1AM0/VyHdFATdABtwjnUSmu6BE9G8KnIdFRDWvTSZsUmXKGeUecZevC
 RM5mKu2K7YvfaXvFNoR1X7b+kI6Pbd1LwC/Nni+ImPHMrGilp+sZ2Yx4c2wXfC1pfn0B
 5Cfw==
X-Gm-Message-State: APuU4Z8njSD1ZEh9JzqEyf683xfJWtwhWMugPuY00+qvx6LhbgBl+7ea
 3aY5eBJONBKgtOTkOtEESAO4NAPJQBgeza0Ebyxg7PvQyToR8P+pYzgC
X-Gm-Gg: AYBFou14syTyUNeAzEiVAg1rxmejNZb4kn3PSLqcD6Dav3D9mp7ILFVLgxc1cxFokg1
 tbUpf0Ntb4/GnHi2dlzBqjM6y5hhbzXKowGZ9lsZcIP+e0LzPA4i5Pe+A96IpQDHiBVSa/yqhP8
 cI+efwkr6OMrFv/dc3B5jr46zIQ4mN+7JOW9kV+W8dIvUjupeeaAc/G7Sytp0h3cZYob06iXZ0/
 BLb6QcIL3FaJRXMKV89aC3ydKCwf/S2xPTJrN81WCfvHXAnwFtNFyMw7x0nV0n0KDtVO3ifskF5
 SKUyxY3sw+Jp1lN/G/omjHu3ARTOoPuiQOVTxxHND/DDaMuIA1bS339TRLZwFRdynade24KKovH
 0U7XxMBOkQkNxndVg4GFFhMgmaZb3dV+NmEM4vjeVmF9jlBSz+z7mr2rkF88oorMC5YJZoZZoi8
 oX0HU3ldpAaHlDfvnuuQiaz9/uB2rt2oyEfpEkAVexAQfccQRCqjzMmtmtvxB5ibgcYLptteVCo
 8juKkZ2a9J43hgKBuGaKoUOdCZh/UWSdlBsaVfW6rbgeCjsbnLQ6L/7sRWZWaR8qfLwbiVhF/ag
 1jPaDPy8rJAGTmD92ECn
X-Received: by 2002:a05:600c:1f82:b0:4bb:6848:d433 with SMTP id
 5b1f17b1804b1-4bb7da4f53fmr32868135e9.26.1794990492496; 
 Wed, 18 Nov 2026 00:28:12 -0800 (PST)
Received: from fedora ([46.210.233.16]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d2cfb3esm55097605e9.15.2026.11.18.00.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 00:28:11 -0800 (PST)
From: Isaac Boukris <iboukris@gmail.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>,
 Isaac Boukris <iboukris@gmail.com>, stable@dpdk.org
Subject: [PATCH v4 1/8] net/virtio: fix Rx interrupt setup with MSI-X
Date: Wed, 18 Nov 2026 10:27:45 +0200
Message-ID: <20261118082752.1043794-2-iboukris@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118082752.1043794-1-iboukris@gmail.com>
References: <20261117124303.717447-1-iboukris@gmail.com>
 <20261118082752.1043794-1-iboukris@gmail.com>
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

With Rx interrupts, configuring a port initializes the device, twice
when an offload or RSS is requested. Each initialization enables the
interrupt eventfds. EAL now refuses to enable MSI-X eventfds twice
(before, it leaked the previous ones). So such a configuration fails,
and so does a second configuration:

  EAL: Interrupt eventfds are already enabled
  virtio_configure_intr(): Fail to create eventfd
  ETHDEV: Port0 dev_configure = -16

Enable the eventfds only when they are not enabled. There is one per
Rx queue, so release them first when the number of Rx queues changed.
The application must then register the Rx queue interrupts again.

Release them only for a VFIO MSI-X handle, whose eventfds EAL creates.
A virtio-user handle also gets here. Its eventfds are the backend's
call fds, set once when the device is created. Releasing them would
reset their count for good, and registering an Rx queue's interrupt
would then fail.

To reproduce, with a virtio-net PCI device bound to vfio-pci:

  dpdk-l3fwd-power -l 0 -a 0000:0c:00.0 -- -p 1 --interrupt-only \
      --parse-ptype --config="(0,0,0)"

Fixes: 3ba6b689893f ("eal/linux: fix eventfd leaks when enabling interrupts")
Cc: stable@dpdk.org

Signed-off-by: Isaac Boukris <iboukris@gmail.com>
---
v4: shorter commit message, no code change.
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

