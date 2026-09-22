Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3B1C98302
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 19:42:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF1A442EAE;
	Tue, 22 Sep 2026 21:41:51 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id 894B842EAC
 for <dev@dpdk.org>; Tue, 22 Sep 2026 21:41:47 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-396ccd4f99dso200348a91.2
 for <dev@dpdk.org>; Tue, 22 Sep 2026 12:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790106107;
 x=1790710907; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U9h6Ms4aW7XkWOL3AAI2C3brvZRL5yXmwumWG1h5CMU=;
 b=FlcRy9BBpomDjHfuxKJxuTCiR6NmzfkLQzkr0vGl0iECQL930f2+uhnkOQJZREnyGW
 D9hnxLpaAEmOD9B5mcUMKZilafndE3WcR88DXWWxNLmCh8VYG4EiW27/dDrUfsG5AYah
 z51u+JigAtpkVDc4cSIZj+HfsqDzqDjjS38KP4fvz8aIVh0NYlFXsQAEHiB+IQSyKzCU
 4QGZ+ThpStYE+3YmPDmwvy5zNCZZXQ4aWVujWjga9vzmo+VLtDKNBD14p2VVdwC+NxSt
 3lxkBniFO+cpFYRZfWhQ2Oc6QXdifMaxqp5KwQGtamZLoJsLdSZrHB2t4w+GyOFp6m8r
 +YhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790106107; x=1790710907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=U9h6Ms4aW7XkWOL3AAI2C3brvZRL5yXmwumWG1h5CMU=;
 b=xxAqXyW3wL5vsgexMBHn8v0q1uG5bY3qbA22p8Gf40cI4bg97UHfyjoQyXo8sHENrR
 zLD9CxyNwBVSo7Rn+JyaI78GlfpmI7Zg2maeBmgJgLKk6uYiFf+Py/wwcml8pcZNtVYR
 vRF7c0fB/FUEuRKVcF9GHlJW+aoC7BSMVRr03D7RUegXwijjtvu+QVuXtYhIlRzMvpcT
 xG5IVhq4/yatvn/or+MgkApcj6o2e15L3BrtFxvqiBSpxkJsG6/XWJ32bfqfUJNgcqg4
 znk+x8RGTtNOcyngintVgceFTrOfWEq6QlT04lsycuIAehAy9M0AHEMBOHBuuPa7hpWL
 t7bw==
X-Gm-Message-State: AFuF++nKvIW0R5D0mABoYOxahtqs17wkpX7cMV2+zgJBkL1c8s4KSo7j
 VJk+RXo+jXScBjkzMU77AoXUvr04AhcEgw8u4fBf0sawqnI5tDixi0mtXIfnnHborul/uSYOmgK
 Iojqckd0=
X-Gm-Gg: AYBFou3MUqTh5zUZsrV2haZz3RaWOh+gE/8XdNms/F0l1CUWkeLWmwqzis8SzSLpuJ7
 ZeRyKClpRckd9x8bYEaLsjs62x5aaqy7c3wTw99xt8epCiIWYeaLqKm/nqe5x0IGLWwcAjRE777
 JW7lajreB+bs3gnFY/Fw4LzHF/is9XC8FrlacekN1j/bFfjNvVrViPXz0sLbf1my4qhmhpUlmYQ
 L7aFUMKz//2yVG5gvLoJGolwyDd5hD7bj014rZd0LpIcrlWBntRTGYU9b/dj1RgrYE+2u5xv56N
 BdK6GWvEiI7xDesakc+LSDCSic1qjwLNBB2cia5ilc+60PET02UtbuANiq33Me1XUuImMHiZzM0
 uv511ZJmsamjk2rV+Rv7hrBoI29cpREFycpUJOdjhGhE7RM1vKuFNTzj4+ipgh1GPD95gOOIR+R
 DpGMyOT8uax02HhQ5hy2TSeHm+i3KJamP6MJLhK0VJbZTdADQXhSCGrjvVqEahC7WJAJeFFBUVM
 ORgDYS4MP/qLUUhEJZhqpZQLdzT7+BXUiNSM9hicEFplbFu
X-Received: by 2002:a17:90b:3dc3:b0:39e:4c81:6c96 with SMTP id
 98e67ed59e1d1-3a07e56914bmr436108a91.28.1790106105554; 
 Tue, 22 Sep 2026 12:41:45 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a07ddf1cf3sm814881a91.9.2026.09.22.12.41.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 12:41:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Arthur Chan <arthur.chan@adalogics.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jakub Grajciar <jgrajcia@cisco.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH 4/7] net/memif: validate control channel requests
Date: Tue, 22 Sep 2026 12:40:55 -0700
Message-ID: <20260922194138.508919-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922194138.508919-1-stephen@networkplumber.org>
References: <20260922194138.508919-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

The server can not trust the connecting client, validate
connection requests before acting on them.

Check the file passed with region request to make sure that the
claimed region size is backed by the file. Mapping beyond the end
of a file succeeds and only faults on access, so a client that
overstates the size can otherwise fault the server with SIGBUS.
This also underpins the data path descriptor checks, which bound
each descriptor against the region size.

Warn when the region is not sealed against shrinking, but do not
reject it. Requiring a seal would disconnect conforming clients:
VPP's hugepage backed regions can not be sealed, and a memfd
created without MFD_ALLOW_SEALING can not be distinguished from
one whose owner chose not to seal.

For an add ring request: require rings to be added in order exactly
once so the ring counts can not exceed the number of configured
queues, bound the ring size to the advertised maximum, reject
unsupported private headers, and check that the referenced region
exists and that the ring plus its descriptor table fits inside that
region at a naturally aligned offset.

A passed file descriptor is also closed when the message that
carried it does not take one. Only add region and add ring consume
an fd, so without this a client could attach one to any other
message type and exhaust the file descriptors of the server.

Bugzilla ID: 2011
Bugzilla ID: 2012
Bugzilla ID: 2013
Bugzilla ID: 2019
Fixes: 09c7e63a71f9 ("net/memif: introduce memory interface PMD")
Cc: stable@dpdk.org

Reported-by: Arthur Chan <arthur.chan@adalogics.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Tested-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 drivers/net/memif/memif_socket.c | 129 ++++++++++++++++++++++++++-----
 1 file changed, 108 insertions(+), 21 deletions(-)

diff --git a/drivers/net/memif/memif_socket.c b/drivers/net/memif/memif_socket.c
index 898ad75fa6..8231a936e5 100644
--- a/drivers/net/memif/memif_socket.c
+++ b/drivers/net/memif/memif_socket.c
@@ -7,6 +7,7 @@
 #include <unistd.h>
 #include <sys/types.h>
 #include <sys/socket.h>
+#include <sys/stat.h>
 #include <sys/ioctl.h>
 #include <errno.h>
 
@@ -262,6 +263,8 @@ memif_msg_receive_add_region(struct rte_eth_dev *dev, memif_msg_t *msg,
 	struct pmd_process_private *proc_private = dev->process_private;
 	memif_msg_add_region_t *ar = &msg->add_region;
 	struct memif_region *r;
+	struct stat st;
+	int seals;
 
 	if (fd < 0) {
 		memif_msg_enq_disconnect(pmd->cc, "Missing region fd", 0);
@@ -272,13 +275,32 @@ memif_msg_receive_add_region(struct rte_eth_dev *dev, memif_msg_t *msg,
 			ar->index != proc_private->regions_num ||
 			proc_private->regions[ar->index] != NULL) {
 		memif_msg_enq_disconnect(pmd->cc, "Invalid region index", 0);
-		return -1;
+		goto error;
+	}
+
+	/* The client is not trusted to describe the region it shares. */
+	if (ar->size == 0 || fstat(fd, &st) < 0 || (uint64_t)st.st_size < ar->size) {
+		memif_msg_enq_disconnect(pmd->cc, "Invalid region size", 0);
+		goto error;
 	}
 
+	/*
+	 * Prefer regions sealed against shrinking so the peer can not truncate
+	 * the file after connect and fault the server. Sealing is not supported
+	 * on all fd types (for example hugetlbfs).
+	 */
+	seals = fcntl(fd, F_GET_SEALS);
+	if (seals < 0)
+		MIF_LOG(INFO, "Port %u region %u fd does not support sealing",
+			dev->data->port_id, ar->index);
+	else if ((seals & F_SEAL_SHRINK) == 0)
+		MIF_LOG(NOTICE, "Port %u region %u fd is not sealed against shrinking",
+			dev->data->port_id, ar->index);
+
 	r = rte_zmalloc("region", sizeof(struct memif_region), 0);
 	if (r == NULL) {
 		memif_msg_enq_disconnect(pmd->cc, "Failed to alloc memif region.", 0);
-		return -ENOMEM;
+		goto error;
 	}
 
 	r->fd = fd;
@@ -289,46 +311,92 @@ memif_msg_receive_add_region(struct rte_eth_dev *dev, memif_msg_t *msg,
 	proc_private->regions_num++;
 
 	return 0;
+error:
+	close(fd);
+	return -1;
 }
 
 static int
 memif_msg_receive_add_ring(struct rte_eth_dev *dev, memif_msg_t *msg, int fd)
 {
 	struct pmd_internals *pmd = dev->data->dev_private;
+	struct pmd_process_private *proc_private = dev->process_private;
 	memif_msg_add_ring_t *ar = &msg->add_ring;
+	const struct memif_region *r;
 	struct memif_queue *mq;
+	uint64_t ring_size;
 
 	if (fd < 0) {
 		memif_msg_enq_disconnect(pmd->cc, "Missing interrupt fd", 0);
 		return -1;
 	}
 
-	/* check if we have enough queues */
+	/* rings must be added in order, exactly once */
 	if (ar->flags & MEMIF_MSG_ADD_RING_FLAG_C2S) {
-		if (ar->index >= pmd->cfg.num_c2s_rings) {
+		if (ar->index >= pmd->cfg.num_c2s_rings ||
+				ar->index != pmd->run.num_c2s_rings) {
 			memif_msg_enq_disconnect(pmd->cc, "Invalid ring index", 0);
-			return -1;
+			goto error;
 		}
-		pmd->run.num_c2s_rings++;
 	} else {
-		if (ar->index >= pmd->cfg.num_s2c_rings) {
+		if (ar->index >= pmd->cfg.num_s2c_rings ||
+				ar->index != pmd->run.num_s2c_rings) {
 			memif_msg_enq_disconnect(pmd->cc, "Invalid ring index", 0);
-			return -1;
+			goto error;
 		}
-		pmd->run.num_s2c_rings++;
+	}
+
+	if (ar->log2_ring_size > ETH_MEMIF_MAX_LOG2_RING_SIZE) {
+		memif_msg_enq_disconnect(pmd->cc, "Invalid ring size", 0);
+		goto error;
+	}
+
+	/* private headers are not supported */
+	if (ar->private_hdr_size != 0) {
+		memif_msg_enq_disconnect(pmd->cc, "Unsupported private header", 0);
+		goto error;
+	}
+
+	if (ar->region >= proc_private->regions_num ||
+			proc_private->regions[ar->region] == NULL) {
+		memif_msg_enq_disconnect(pmd->cc, "Invalid region index", 0);
+		goto error;
+	}
+
+	/*
+	 * The ring and its descriptors must lie inside the region.
+	 * Require natural alignment of the ring for atomic load/store.
+	 * Existing DPDK and VPP put it on cache line boundary.
+	 */
+	r = proc_private->regions[ar->region];
+	ring_size = sizeof(memif_ring_t) +
+		sizeof(memif_desc_t) * ((uint64_t)1 << ar->log2_ring_size);
+	if ((ar->offset & (sizeof(uint64_t) - 1)) != 0 ||
+			ar->offset + ring_size > r->region_size) {
+		memif_msg_enq_disconnect(pmd->cc, "Invalid ring offset", 0);
+		goto error;
 	}
 
 	mq = (ar->flags & MEMIF_MSG_ADD_RING_FLAG_C2S) ?
 	    dev->data->rx_queues[ar->index] : dev->data->tx_queues[ar->index];
 
+	/* Takes ownership of the fd, so nothing to close after this point. */
 	if (rte_intr_fd_set(mq->intr_handle, fd))
-		return -1;
+		goto error;
+
+	if (ar->flags & MEMIF_MSG_ADD_RING_FLAG_C2S)
+		pmd->run.num_c2s_rings++;
+	else
+		pmd->run.num_s2c_rings++;
 
 	mq->log2_ring_size = ar->log2_ring_size;
 	mq->region = ar->region;
 	mq->ring_offset = ar->offset;
 
 	return 0;
+error:
+	close(fd);
+	return -1;
 }
 
 static int
@@ -658,17 +726,11 @@ memif_msg_receive(struct memif_control_channel *cc)
 		return -1;
 
 	size = recvmsg(rte_intr_fd_get(cc->intr_handle), &mh, 0);
-	if (size != sizeof(memif_msg_t)) {
-		MIF_LOG(DEBUG, "Invalid message size = %zd", size);
-		if (size > 0)
-			/* 0 means end-of-file, negative size means error,
-			 * don't send further disconnect message in such cases.
-			 */
-			memif_msg_enq_disconnect(cc, "Invalid message size", 0);
-		return -1;
-	}
-	MIF_LOG(DEBUG, "Received msg type: %u.", msg.type);
 
+	/*
+	 * Collect any passed fd first; a short message can still carry one,
+	 * and it has to be closed on every path out of this function.
+	 */
 	cmsg = CMSG_FIRSTHDR(&mh);
 	while (cmsg) {
 		if (cmsg->cmsg_level == SOL_SOCKET) {
@@ -680,10 +742,23 @@ memif_msg_receive(struct memif_control_channel *cc)
 		cmsg = CMSG_NXTHDR(&mh, cmsg);
 	}
 
+	if (size != sizeof(memif_msg_t)) {
+		MIF_LOG(DEBUG, "Invalid message size = %zd", size);
+		if (size > 0)
+			/* 0 means end-of-file, negative size means error,
+			 * don't send further disconnect message in such cases.
+			 */
+			memif_msg_enq_disconnect(cc, "Invalid message size", 0);
+		ret = -1;
+		goto exit;
+	}
+	MIF_LOG(DEBUG, "Received msg type: %u.", msg.type);
+
 	if (cc->dev == NULL && msg.type != MEMIF_MSG_TYPE_INIT) {
 		MIF_LOG(DEBUG, "Unexpected message.");
 		memif_msg_enq_disconnect(cc, "Unexpected message", 0);
-		return -1;
+		ret = -1;
+		goto exit;
 	}
 
 	/* get device from hash data */
@@ -736,7 +811,9 @@ memif_msg_receive(struct memif_control_channel *cc)
 			goto exit;
 		break;
 	case MEMIF_MSG_TYPE_ADD_REGION:
+		/* The handler owns the fd from here, on success and on error. */
 		ret = memif_msg_receive_add_region(cc->dev, &msg, afd);
+		afd = -1;
 		if (ret < 0)
 			goto exit;
 		ret = memif_msg_enq_ack(cc->dev);
@@ -744,7 +821,9 @@ memif_msg_receive(struct memif_control_channel *cc)
 			goto exit;
 		break;
 	case MEMIF_MSG_TYPE_ADD_RING:
+		/* The handler owns the fd from here, on success and on error. */
 		ret = memif_msg_receive_add_ring(cc->dev, &msg, afd);
+		afd = -1;
 		if (ret < 0)
 			goto exit;
 		ret = memif_msg_enq_ack(cc->dev);
@@ -774,6 +853,14 @@ memif_msg_receive(struct memif_control_channel *cc)
 	}
 
  exit:
+	/*
+	 * A peer can attach an fd to any message, but only add region and
+	 * add ring take one. Close the rest, otherwise a client could
+	 * exhaust the file descriptors of the server.
+	 */
+	if (afd >= 0)
+		close(afd);
+
 	return ret;
 }
 
-- 
2.53.0

