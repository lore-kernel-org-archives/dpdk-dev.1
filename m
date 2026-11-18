Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0086F606A32A
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D++I1Hzz
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E5BE40615;
	Wed, 18 Nov 2026 09:28:20 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by mails.dpdk.org (Postfix) with ESMTPS id 1A78A40395
 for <dev@dpdk.org>; Wed, 18 Nov 2026 09:28:18 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4bb61185057so5665815e9.1
 for <dev@dpdk.org>; Wed, 18 Nov 2026 00:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794990498; x=1795595298; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kLuuwmuXKMpyiRnoc0ucRCSDX8V1826WICbpKuZrphE=;
 b=D++I1HzzX3TirN9VTh5afXgAKkwFZ66x79yw1Cac3FuZ0FXo6JYTqAp956QIGtQs0o
 8yhzCg67IjjrV7uCE/fPyAvKccJYVveM5HLGqzkxCc/28e6tjNcMn6j+GugRIwKodQTe
 f6UQFAaJXqjWYEeWY3ks+h0NwfUGpVa8DjbiuVyxQ+I+U5hRlX349js4iZmT1NeyowU+
 Zv+/BoVZ7Fz9gaMp2+daPo1TMD/YuDTrc3G37YlQs1uxZPnmyU0Zh/xBw1CO0XjJIVjS
 5ayXjV56SZkYEKeO5gpPCBVSlYFPsSeIwpMYy6saNr091GIsec52kc0R2kIJJgnADotq
 IudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794990498; x=1795595298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kLuuwmuXKMpyiRnoc0ucRCSDX8V1826WICbpKuZrphE=;
 b=Mi57aSLK1nvwIKxibePrJNqHnoZhpFWatLGGnxUEBmte7Zj/jwAsXC8RYuNJEkVyvz
 L3JyXqi4c01OPyH7FieACQQC2X2wUY91bnUUeneUYK7Nna8hMxKQs3mcfQ50B39cegkJ
 kLt6xcSLh0o26bjvcSoxhBrixum4EyMowpQ7olINVxll8gq5VAUW/b33/mqB+oo0nAGi
 nYT84XrLTZOJ3qI5WSYWobtoZ/RXjAUvWvo+LI1EjJupahL4wtprY1XwNCTzEl0P7zMD
 fl0jFG0nku6Ec+GGSOXNnn7wLPFac8/thwjxhmDt/F3K+3BaTYz3CxzkGKJjn2bsjgQ0
 FTDg==
X-Gm-Message-State: APuU4Z+MePDWzUYrTJhPlDdY300DQy7mvrQHMqV1n1uUWb4danX4ynhQ
 iCGgSv8Uba1RsAdatvWJpaMYVX7+GnuzCNH6P7Wn3SH5UXH6yhkiUcsB
X-Gm-Gg: AYBFou1rg7jE7GZ/iqlTYC//2UsZ4Zrus++Pab5fxPgjWX/Ht2SA9snJwoHQYE4If49
 2y3oxw2T3NusNcaZv9OVISr/Du/I8Sb/EiAjtkumy9MtUlx7qma5ogJGGIR28Cnkadlc0w+DUDe
 teL/LnCt6snOu/hAIEnp5q8P/mbY3MoH6WIlZC9hSowPHxlWvgWCBf2S3+pFi90PJUQysl8kDa3
 59/I3/evd/A4MzO30wBUJpniLKBfb9LakyNBoXzbpCRPyrT0FcbYCP2MtrUpTPl4jQO1KdRGxP1
 A/TH5b+OulAgUOawZy+VvcnKwnxks1nPuCzw3pOEm2QcVgc2fvnjmmf3WJohkH7EbqYsigl4CxD
 RppUwk8ZWeYJq9UQq8wW66IhEsggOFJ+N7Yle9G2sp/nU7AELA7sBJLrz70n2RKR5hcuGpwPSsU
 A2llp++ok0fvrIIO12q3j9NBfdcphDEaBlbY+UdlEQ7/HqT5knMTjm2M46ckqf2whOgDbtMjRTU
 K71nRedvnTUFvDs1RCm7xhFGjthRISTjWKTGo8IeG1KpXkRxhnNyJZnvvjv0ra0ZI5CLZFAWeE/
 EYKCeLQhX3Qxr7mBY05E6m7WYE4E/X4yccLwresxAQ==
X-Received: by 2002:a05:600c:8b8a:b0:4bb:52bd:a3c7 with SMTP id
 5b1f17b1804b1-4bb7da2240amr34586215e9.6.1794990497426; 
 Wed, 18 Nov 2026 00:28:17 -0800 (PST)
Received: from fedora ([46.210.233.16]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d2cfb3esm55097605e9.15.2026.11.18.00.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 00:28:16 -0800 (PST)
From: Isaac Boukris <iboukris@gmail.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>,
 Isaac Boukris <iboukris@gmail.com>, stable@dpdk.org
Subject: [PATCH v4 3/8] net/virtio-user: fix unaligned reads of control
 commands
Date: Wed, 18 Nov 2026 10:27:47 +0200
Message-ID: <20261118082752.1043794-4-iboukris@gmail.com>
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

The data of a control command follows the 2-byte header and the
1-byte status in the driver's buffer, so it starts at an odd address.
The device emulation reads the number of queue pairs from it through
a pointer to uint16_t, and through a pointer to the RSS configuration
structure. Both reads are unaligned. The undefined behaviour
sanitizer reports the first one for any port with more than one
queue pair:

  virtio_user_dev.c:1001:10: runtime error: load of misaligned
  address 0x7b4802f53f43 for type 'uint16_t', which requires 2 byte
  alignment

Read the number of queue pairs through an unaligned type, and copy
the RSS configuration before reading it.

Fixes: f9b9d1a55775 ("net/virtio-user: add multiple queues in device emulation")
Fixes: dbce501ed7c4 ("net/virtio-user: support RSS")
Cc: stable@dpdk.org

Signed-off-by: Isaac Boukris <iboukris@gmail.com>
---
v4: new patch.

 .../net/virtio/virtio_user/virtio_user_dev.c  | 26 +++++++++----------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/net/virtio/virtio_user/virtio_user_dev.c b/drivers/net/virtio/virtio_user/virtio_user_dev.c
index c38ac059df..8617c558ea 100644
--- a/drivers/net/virtio/virtio_user/virtio_user_dev.c
+++ b/drivers/net/virtio/virtio_user/virtio_user_dev.c
@@ -995,16 +995,15 @@ virtio_user_handle_ctrl_msg_split(struct virtio_user_dev *dev, struct vring *vri
 	hdr = virtio_user_iova2virt(dev, vring->desc[idx_hdr].addr);
 	if (hdr->class == VIRTIO_NET_CTRL_MQ &&
 	    hdr->cmd == VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET) {
-		uint16_t queues, *addr;
+		unaligned_uint16_t *queues;
 
-		addr = virtio_user_iova2virt(dev, vring->desc[idx_data].addr);
-		queues = *addr;
-		status = virtio_user_handle_mq(dev, queues);
+		queues = virtio_user_iova2virt(dev, vring->desc[idx_data].addr);
+		status = virtio_user_handle_mq(dev, *queues);
 	} else if (hdr->class == VIRTIO_NET_CTRL_MQ && hdr->cmd == VIRTIO_NET_CTRL_MQ_RSS_CONFIG) {
-		struct virtio_net_ctrl_rss *rss;
+		struct virtio_net_ctrl_rss rss;
 
-		rss = virtio_user_iova2virt(dev, vring->desc[idx_data].addr);
-		status = virtio_user_handle_mq(dev, rss->max_tx_vq);
+		memcpy(&rss, virtio_user_iova2virt(dev, vring->desc[idx_data].addr), sizeof(rss));
+		status = virtio_user_handle_mq(dev, rss.max_tx_vq);
 	} else if (hdr->class == VIRTIO_NET_CTRL_RX  ||
 		   hdr->class == VIRTIO_NET_CTRL_MAC ||
 		   hdr->class == VIRTIO_NET_CTRL_VLAN) {
@@ -1061,16 +1060,15 @@ virtio_user_handle_ctrl_msg_packed(struct virtio_user_dev *dev,
 	hdr = virtio_user_iova2virt(dev, vring->desc[idx_hdr].addr);
 	if (hdr->class == VIRTIO_NET_CTRL_MQ &&
 	    hdr->cmd == VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET) {
-		uint16_t queues, *addr;
+		unaligned_uint16_t *queues;
 
-		addr = virtio_user_iova2virt(dev, vring->desc[idx_data].addr);
-		queues = *addr;
-		status = virtio_user_handle_mq(dev, queues);
+		queues = virtio_user_iova2virt(dev, vring->desc[idx_data].addr);
+		status = virtio_user_handle_mq(dev, *queues);
 	} else if (hdr->class == VIRTIO_NET_CTRL_MQ && hdr->cmd == VIRTIO_NET_CTRL_MQ_RSS_CONFIG) {
-		struct virtio_net_ctrl_rss *rss;
+		struct virtio_net_ctrl_rss rss;
 
-		rss = virtio_user_iova2virt(dev, vring->desc[idx_data].addr);
-		status = virtio_user_handle_mq(dev, rss->max_tx_vq);
+		memcpy(&rss, virtio_user_iova2virt(dev, vring->desc[idx_data].addr), sizeof(rss));
+		status = virtio_user_handle_mq(dev, rss.max_tx_vq);
 	} else if (hdr->class == VIRTIO_NET_CTRL_RX  ||
 		   hdr->class == VIRTIO_NET_CTRL_MAC ||
 		   hdr->class == VIRTIO_NET_CTRL_VLAN) {
-- 
2.56.1

