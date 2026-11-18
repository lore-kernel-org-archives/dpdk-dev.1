Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236D2606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V0jeqkS4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C14E1402F1;
	Wed, 18 Nov 2026 09:28:17 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by mails.dpdk.org (Postfix) with ESMTPS id D0727402ED
 for <dev@dpdk.org>; Wed, 18 Nov 2026 09:28:15 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso4824875e9.2
 for <dev@dpdk.org>; Wed, 18 Nov 2026 00:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794990495; x=1795595295; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0+WN+FXDmK3U/JF44njyzot2ib0Es9+PBzKEH6gE4G8=;
 b=V0jeqkS4tkAlVQSnKMUO/U17KuPLJyAlJAOJpEZBt89BoNSMxdhSviMhyh+y4yaSoe
 MiVeEO/7vvHov2U9v2tC7/33W7HeCgh/tQMAS9gN2mOjjPhcs55x4WV15/0A+yIZmyVk
 XuzKieU9qG9a428XqmwAm2azp0j9ibrBmKOK3KRL0jdpop84zo4xW7VevepOQMjdOVtK
 v8BLO3pcuQZ+nYE+aE9gNoAelhGf44cc4C1iMdTmhMD7JM/ePcJVrs2hDND+EGTRUIha
 yyKEeoCQjU/ipB+5CgR3e4Q0ybcmbHJn/JG1L5cxmB1jyQ5lHVig67sIeSTqQfKXnRgX
 MTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794990495; x=1795595295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0+WN+FXDmK3U/JF44njyzot2ib0Es9+PBzKEH6gE4G8=;
 b=JCthrD9/Ib1Y+oJv28MFYYBfxqvxbB0NSXwMn70lg7b6/Qvnb3yN5yK+vd+5vM44wy
 u6na9Wu/A2rOcXn6ESWsw2PVwFRASd8PcGzMA2O6A1S543x5ruWiI0NcRAltLh+UU8mZ
 pvP34Mo2QNFiYnhL/wrEH/eFtPPE7dpkVxyTlU9J0Ki71rmhBrcldvEoq3GT9aOhOAIb
 m0hyGiPQqaf9KRSWJBnRJ+i8IIF5Z+WKEWF1Oajj18uDBC+Laqwv5XmLqQS51zouNOQl
 Fl/6H99MsEJFXT5txxxGB5CiLcV3UIOGG//7+YFZ+GAPxfGQYe2aPpNvvzYlsm1ksfHL
 Tn5g==
X-Gm-Message-State: APuU4Z+nz6btbFujxbD/tZPYj4/Ks3BHCw1B2EnqAnH/QnO3WpNWGMU3
 rj+QhCDIkXLa/8FgtLd+t478jAwT4VtqyrYJY54RzSOr9saEsF9m6as8
X-Gm-Gg: AYBFou1MGX3ioB32YKNIhIe3ESgRBTGSpgDqMMAaSxpKo8hm3Iav262/ytuyecvbjBK
 /M4YKaXQ4VpVjxPbFrBowjSG/rEz5jffdKAPIe7UW8QWOD97ZPF4m9GzWgh89j4rrUichBPwUGU
 S00qt6hyK2Og0NyuyYYnuee0jz4g+jg2nWc1mqYMyQrwghswQCwpYRzS42OQSyWJtT7O6qMFxD5
 1eZGLskAvsDxn2SVYyW1BcbPy+840rXV7foQc3uXYy0BouZH3Wzz4ESWfsxSM7V+re1L1IpkHGO
 kNocNdlIG79sLJtrH2hbjPlX5MYg7XP5uwxQLN+uKFvo1OE+VbrLXNsiJwMZxCxCkCVtKLjIDbR
 uFPJZKs6oYxmH/mzNdjfgggE4jyuj6wGWwXqSgN3btgAA7sSuMP6+vW5Hi72UNvb0GKxyntVSFg
 WuIFnuxI36vOCFyU4kbQKieRBWdC1IJqVezwUi1lkNeRoTOGPN/EnVJLPpMX7UiHmbeLVoUM6eT
 p+33ws8vlN/rZvB2Y/XzTXheCyMdMrQ9btRgM5HIzqaeH2OciuUv27Dt/wxKVjSn6vdkbpLkh6d
 zHdsK6ENpkxs/NhuWvIR
X-Received: by 2002:a05:600c:1c25:b0:4a0:1b14:e283 with SMTP id
 5b1f17b1804b1-4bb7d6d1e20mr35753665e9.1.1794990495186; 
 Wed, 18 Nov 2026 00:28:15 -0800 (PST)
Received: from fedora ([46.210.233.16]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d2cfb3esm55097605e9.15.2026.11.18.00.28.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 00:28:14 -0800 (PST)
From: Isaac Boukris <iboukris@gmail.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>,
 Isaac Boukris <iboukris@gmail.com>, stable@dpdk.org
Subject: [PATCH v4 2/8] net/virtio-user: fix packet loss with unused queue
 pairs
Date: Wed, 18 Nov 2026 10:27:46 +0200
Message-ID: <20261118082752.1043794-3-iboukris@gmail.com>
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

A virtio-user port on vhost-net loses received packets when the
application configures fewer Rx queues than the port has queue pairs
(the queues devarg). With queues=2 and one Rx queue, testpmd receives
22 of the 64 flows that the kernel sends on the TAP interface.

The TAP interface has one queue per queue pair, and the kernel picks
a packet's queue by a hash of its flow. The driver unsets the vhost
backend of a disabled queue pair but leaves its TAP queue attached,
so the kernel still sends flows to it and nothing reads them.

The driver detached such a queue with TUNSETQUEUE until the commit
below, which opens all the TAP queues at initialization.

Attach the TAP queue of a queue pair when the pair is enabled, and
detach it when the pair is disabled or when a later step of the
enable fails. Detach the queues after the first when they are opened.
The first one stays attached, because the interface needs a queue.

TUNSETQUEUE fails on a queue that is already in the requested state.
The existing check of qp_enabled prevents that, because the state of
the TAP queue now follows it.

A memory table change disables the active queue pairs for a moment,
so their TAP queues are detached and attached again.

Fixes: b72099be7f27 ("net/virtio-user: fix init when using existing tap")
Cc: stable@dpdk.org

Signed-off-by: Isaac Boukris <iboukris@gmail.com>
---
v4: detach the queue again when a later step of the enable fails. One comment says the rule.
v3: new patch.

 drivers/net/virtio/virtio_user/vhost_kernel.c | 24 +++++++++++++++++--
 .../net/virtio/virtio_user/vhost_kernel_tap.c | 14 +++++++++++
 .../net/virtio/virtio_user/vhost_kernel_tap.h |  4 ++++
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio/virtio_user/vhost_kernel.c b/drivers/net/virtio/virtio_user/vhost_kernel.c
index 7914b517cd..e3b0583232 100644
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
@@ -541,11 +544,20 @@ vhost_kernel_enable_queue_pair(struct virtio_user_dev *dev,
 	vhostfd = data->vhostfds[pair_idx];
 	tapfd = data->tapfds[pair_idx];
 
+	/*
+	 * A queue pair's TAP queue is attached only while the pair is enabled,
+	 * so the kernel sends packets only to queues in use. The first queue
+	 * stays attached, because the interface needs one. TUNSETQUEUE fails
+	 * on a queue already in the requested state, which the check above
+	 * prevents.
+	 */
 	if (!enable) {
 		if (vhost_kernel_set_backend(vhostfd, -1) < 0) {
 			PMD_DRV_LOG(ERR, "fail to set backend for vhost kernel");
 			return -1;
 		}
+		if (pair_idx > 0 && vhost_tap_set_queue(tapfd, false) < 0)
+			return -1;
 		dev->qp_enabled[pair_idx] = false;
 		return 0;
 	}
@@ -561,18 +573,26 @@ vhost_kernel_enable_queue_pair(struct virtio_user_dev *dev,
 	    vhost_tap_set_mac(data->tapfds[pair_idx], dev->mac_addr) < 0)
 		return -1;
 
+	if (pair_idx > 0 && vhost_tap_set_queue(tapfd, true) < 0)
+		return -1;
+
 	if (vhost_kernel_tap_setup(tapfd, hdr_size, dev->features) < 0) {
 		PMD_DRV_LOG(ERR, "fail to setup tap for vhost kernel");
-		return -1;
+		goto err_detach;
 	}
 
 	if (vhost_kernel_set_backend(vhostfd, tapfd) < 0) {
 		PMD_DRV_LOG(ERR, "fail to set backend for vhost kernel");
-		return -1;
+		goto err_detach;
 	}
 
 	dev->qp_enabled[pair_idx] = true;
 	return 0;
+
+err_detach:
+	if (pair_idx > 0)
+		vhost_tap_set_queue(tapfd, false);
+	return -1;
 }
 
 static int
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

