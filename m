Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F63606A331
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 00:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aHb4GUqY
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6110F40262;
	Wed, 18 Nov 2026 01:19:40 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by mails.dpdk.org (Postfix) with ESMTPS id 7578B402E5
 for <dev@dpdk.org>; Wed, 18 Nov 2026 01:19:38 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4bb5b8ef642so3047865e9.1
 for <dev@dpdk.org>; Tue, 17 Nov 2026 16:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794961178; x=1795565978; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mI4m6zJbGJSYBHbU/6vEqhHzNWYlV2MyGGi7LSRHXgc=;
 b=aHb4GUqYAuIoQqNuEfLl+KFCERsPp8HR4Jlom2rClS9rUqbgdlif9Exhxa0Bzf6W0/
 8jNbMlbFP44py1SaATyJrirTs4YbdPE+SDhoF0+FIMknY115Db3dxCYky3yF3voyWYH9
 7CYFyxZtiE/fGY5x+M1/RLSIucgTZztSJUVZBx/iaBD1K9ugCF2BJlYTLBHi6/BToGOF
 YrreEjIE5SHI8ZYbyC3JHXTykT/dx3sqa3oXYmItmSJWfxW1ibmwD1nzruyUfHJGeIU9
 qvJdngn+ZQOCrYrsLdwyHIaABq0XwQBtUXjw/utG/gOmqo/jRKkZh4oa4T9DbVqaid7G
 nwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794961178; x=1795565978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mI4m6zJbGJSYBHbU/6vEqhHzNWYlV2MyGGi7LSRHXgc=;
 b=MXeIiDuG3Sm6aQtdXjKbjI4L2qtKRyd6V1KYYTTp4ze/4rPCAoMqfRxSC9Fa/hG+4R
 H3x5gN7s7WjkNGza9OcsP3yB7I29Xg2mZXRq0/hv37rl6ASmPC/Vq9Xsqn31MtWbd/Fs
 g28Gm0SxcumhT7LD4GAqC+TKYnv6U0VQpV/JFEqcPOTr4o+MVwuCDNN+c6hhpi3LDrvP
 jQw7F8Aq3/ISQtHMqY/WYP4Bo0Ii/hoxL7SGBmLi4XsyyAxbCFZJd7YKAutFnDwfQOxb
 LKAjKHzMpanWdfuX7xF0/s1B0P0VZWsDAf47bDp6WcWnXkpPUQ4QB9y3unKMMb0n1nqd
 0N2g==
X-Gm-Message-State: APuU4Z9H4GrIU4GPdfQ0zVy1QjxvPln3OBpdIo3JNZcdcvwMIFirPzZd
 0oTWNknTOoVOrAFozvE9ZREkIdXWQn4mi8uYuEqwm8t4c0Kbof+s9sYZ
X-Gm-Gg: AYBFou1m/DSsLzd+BE4XbQdKFyJsSiNHQXVUA17Mn83ZH5FHyXj8O7vK1fjVwinPPUJ
 X2Qtf23L7jicjeqEUOWdjs3q5mWCM296Rz4uEv5HXhP7Q36NQ4dwiQ29GsLFScP7u8GqglefT8E
 G01znYiiEhFG9fDWdDju15rHnfOVhcUfDhe8PV/OYYbbxUMaseP8mWDfnLSrBC40y8WYom3YdV3
 h8vwUFFNRZozuWybsGhHNwtskYDXIGj9gWSeK4zJRNz1+PxaCeEhlvqGmNfKvxObZ0B37YvebtO
 NRg8ZXfC01c+GTDEy6sc1tzyNw0vzT8UbFJCdv6D8LhZfxpB8qbFgMz6MtL39qxlxV/VxpG3hdW
 s0QwQx7heHmR5hFlr0zCh0xBI4JLFLuEiJ2Jus0zdESWZqr7lR7yaKFpNVmkaGqWjrjjJJLLWDr
 7Y9idEOgL3CiCkh/NIVDEtWc5T2AVcz0/9qq1RiFoKWRIJ2vg0kRJzYkRP87wSDDbcKI4O09E2H
 ww0hkEf8tnpMQos7kc0VIBrFxi6YFf5R1c/agTSbvOcUSAfaaT8hgkYsiBReqfoZ8W8M+HR893M
 sb4ECMYZW/YMwZwEcN16
X-Received: by 2002:a05:600c:4e45:b0:4ba:38a9:85e3 with SMTP id
 5b1f17b1804b1-4bb7da127ccmr14789675e9.12.1794961177951; 
 Tue, 17 Nov 2026 16:19:37 -0800 (PST)
Received: from fedora ([46.210.208.90]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7e50e992sm4655025e9.0.2026.11.17.16.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 16:19:37 -0800 (PST)
From: Isaac Boukris <iboukris@gmail.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>,
 Isaac Boukris <iboukris@gmail.com>, stable@dpdk.org
Subject: [PATCH v3 2/7] net/virtio-user: fix packet loss with unused queue
 pairs
Date: Wed, 18 Nov 2026 02:19:13 +0200
Message-ID: <20261118001918.990884-3-iboukris@gmail.com>
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

A virtio-user port on vhost-net loses received packets when the
application configures fewer Rx queues than the port has queue pairs
(the queues devarg). For example, with queues=2 and one Rx queue,
testpmd receives 22 of 64 flows that the kernel sends on the TAP
interface.

The TAP interface has one queue per queue pair, and the kernel picks
the queue of a packet by a hash of its flow. The driver unsets the
vhost backend of a disabled queue pair, but the TAP queue stays
attached. So the kernel still sends flows to it, and nothing reads
them.

The driver used to detach such a queue with TUNSETQUEUE. The commit
below removed that when it moved the opening of the TAP queues to
the initialization.

Detach the TAP queue of a queue pair when it is disabled, and attach
it when it is enabled. The queues after the first one are detached
when they are opened, because a queue pair is disabled until the
driver enables it. The first queue is never detached, because the
interface needs a queue.

A queue pair is also disabled for a moment when the memory table
changes. Its TAP queue is then detached and attached again.

Fixes: b72099be7f27 ("net/virtio-user: fix init when using existing tap")
Cc: stable@dpdk.org

Signed-off-by: Isaac Boukris <iboukris@gmail.com>
---
v3: new patch.

 drivers/net/virtio/virtio_user/vhost_kernel.c     | 12 ++++++++++++
 drivers/net/virtio/virtio_user/vhost_kernel_tap.c | 14 ++++++++++++++
 drivers/net/virtio/virtio_user/vhost_kernel_tap.h |  4 ++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/net/virtio/virtio_user/vhost_kernel.c b/drivers/net/virtio/virtio_user/vhost_kernel.c
index 7914b517cd..5b70999393 100644
--- a/drivers/net/virtio/virtio_user/vhost_kernel.c
+++ b/drivers/net/virtio/virtio_user/vhost_kernel.c
@@ -455,6 +455,9 @@ vhost_kernel_setup(struct virtio_user_dev *dev)
 		data->tapfds[i] = vhost_tap_open(dev->ifname, r_flags, true);
 		if (data->tapfds[i] < 0)
 			goto err_tapfds;
+		/* The queue stays detached until its queue pair is enabled. */
+		if (vhost_tap_set_queue(data->tapfds[i], false) < 0)
+			goto err_tapfds;
 	}
 
 	dev->backend_data = data;
@@ -546,6 +549,12 @@ vhost_kernel_enable_queue_pair(struct virtio_user_dev *dev,
 			PMD_DRV_LOG(ERR, "fail to set backend for vhost kernel");
 			return -1;
 		}
+		/*
+		 * Detach the queue, so that the kernel sends its packets to the
+		 * other queues. The interface keeps its first queue.
+		 */
+		if (pair_idx > 0 && vhost_tap_set_queue(tapfd, false) < 0)
+			return -1;
 		dev->qp_enabled[pair_idx] = false;
 		return 0;
 	}
@@ -561,6 +570,9 @@ vhost_kernel_enable_queue_pair(struct virtio_user_dev *dev,
 	    vhost_tap_set_mac(data->tapfds[pair_idx], dev->mac_addr) < 0)
 		return -1;
 
+	if (pair_idx > 0 && vhost_tap_set_queue(tapfd, true) < 0)
+		return -1;
+
 	if (vhost_kernel_tap_setup(tapfd, hdr_size, dev->features) < 0) {
 		PMD_DRV_LOG(ERR, "fail to setup tap for vhost kernel");
 		return -1;
diff --git a/drivers/net/virtio/virtio_user/vhost_kernel_tap.c b/drivers/net/virtio/virtio_user/vhost_kernel_tap.c
index da55aba505..bfdc6f46c0 100644
--- a/drivers/net/virtio/virtio_user/vhost_kernel_tap.c
+++ b/drivers/net/virtio/virtio_user/vhost_kernel_tap.c
@@ -126,6 +126,20 @@ vhost_tap_set_mac(int tapfd, uint8_t *mac)
 	return 0;
 }
 
+int
+vhost_tap_set_queue(int tapfd, bool attach)
+{
+	struct ifreq ifr;
+
+	memset(&ifr, 0, sizeof(ifr));
+	ifr.ifr_flags = attach ? IFF_ATTACH_QUEUE : IFF_DETACH_QUEUE;
+	if (ioctl(tapfd, TUNSETQUEUE, (void *)&ifr) == -1) {
+		PMD_DRV_LOG(ERR, "TUNSETQUEUE failed: %s", strerror(errno));
+		return -1;
+	}
+	return 0;
+}
+
 static int
 vhost_kernel_tap_set_offload(int fd, uint64_t features)
 {
diff --git a/drivers/net/virtio/virtio_user/vhost_kernel_tap.h b/drivers/net/virtio/virtio_user/vhost_kernel_tap.h
index 1e026d7488..05fa8a9244 100644
--- a/drivers/net/virtio/virtio_user/vhost_kernel_tap.h
+++ b/drivers/net/virtio/virtio_user/vhost_kernel_tap.h
@@ -16,12 +16,15 @@
 #define TUNSETSNDBUF   _IOW('T', 212, int)
 #define TUNGETVNETHDRSZ _IOR('T', 215, int)
 #define TUNSETVNETHDRSZ _IOW('T', 216, int)
+#define TUNSETQUEUE    _IOW('T', 217, int)
 
 /* TUNSETIFF ifr flags */
 #define IFF_TAP          0x0002
 #define IFF_NO_PI        0x1000
 #define IFF_VNET_HDR     0x4000
 #define IFF_MULTI_QUEUE  0x0100
+#define IFF_ATTACH_QUEUE 0x0200
+#define IFF_DETACH_QUEUE 0x0400
 #define IFF_NAPI         0x0010
 
 /* Features for GSO (TUNSETOFFLOAD). */
@@ -41,5 +44,6 @@ int vhost_tap_open(const char *ifname, unsigned int r_flags, bool multi_queue);
 int vhost_tap_get_name(int tapfd, char **ifname);
 int vhost_tap_get_flags(int tapfd, unsigned int *tap_flags);
 int vhost_tap_set_mac(int tapfd, uint8_t *mac);
+int vhost_tap_set_queue(int tapfd, bool attach);
 
 #endif
-- 
2.56.1

