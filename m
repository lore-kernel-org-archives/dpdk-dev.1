Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3748C02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 16:45:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D826400EF;
	Tue,  4 Feb 2025 17:45:31 +0100 (CET)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54]) by mails.dpdk.org (Postfix) with ESMTP id EDA6C400D7
 for <dev@dpdk.org>; Tue,  4 Feb 2025 17:45:29 +0100 (CET)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-ab2c9b8aecaso12816866b.0
 for <dev@dpdk.org>; Tue, 04 Feb 2025 08:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738687529; x=1739292329; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OmfAW6Cg7xLaLdjFbw1Pf+ugw/RsL/qUIlgHbMTNxzk=;
 b=Jswr0tHx9Z0/ZIFIQzqsv1TKH0aKOzS2whQhaKY2FCnV0O3fkas6nrEqdZ649X8qV6
 N70Hg8mUpQCs63sUmW63h6LyagX/vwzLYTjl/rfpG4FZ7ASYTMy45rPpT996aDIa0T5b
 vJgDzAxFcn0KodriOlmXkLAvdI7EIFZ0aL2PR21qk4pRE3BC52gy9bZcZq1kt6k4GPss
 Jg9l88QUfwYlT3riRY2I5JPzWJOFtIyFvBVft0esLdKU9oqrdNYBzLpUdxNKvf/2SsVX
 Xt9DUasGhYhHj4e62WvxlHPosr6I6SDpurWsA9XDePhRoS5cLTm4scStrBm1VCTrzb8n
 aQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738687529; x=1739292329;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OmfAW6Cg7xLaLdjFbw1Pf+ugw/RsL/qUIlgHbMTNxzk=;
 b=gDNdhg33GMFDkI54uy2rNapH3pjcdXhPID9SKywrUstjpf8K7zjDTJh7ASpbQEhyEw
 qf00r0jDW4VC+ltUfBVg/vom45/YJkgJKqJ7AEqIPpuh65V1flWPJQ7fAq84TVXXkjd3
 jt9SQvLbPAK3TgtmMOCRxREUamHUFVs5FRcXDAHtop6kBN0JuKfAg8r15o85e9tjqXHI
 Dt+XhAjxRvAH2fNmPxTLsoWfsTn5IIss6CnQ8Ht6KHy0DnUTIxkSEzVjEz4tb/VEd64b
 IPRz8tf474guk5es94XiI7uuK2uYuuiYnPG+Ex0u9pUU5kH3vjqBzRnSwFA/wENtaYo7
 F0lg==
X-Gm-Message-State: AOJu0YxQFH5Lvh/8xIDZxooWYug+XauG86S4Y8DBOQJd2MKcoHzGwfun
 KomJp9BL+jk9oQtXm2UBoIZD4Jq6yGLnRWyMbVW5vNL3znB5ryJk
X-Gm-Gg: ASbGncufIU989l6KXETc0ay0+Fb3CC4td9KhlbrnOx/JO6s2OE/mngBm6jhL3Ko2h/E
 tADJ/D8eX4I16s0abTX3jYpsp/aAGuK4HRpU2bHloLaSQthuOAGa/WUiboMuxPAIfF+1iD7GJw1
 WXGj2xJfahDSJgDeKCpcKHupvW+mB4//DOacBAGraDwCFy089WVmbERKDgI3XSwW1pIUtGBLnPK
 w1mv1myNGs9Sz9pi4cdEnT39TdTTywfvfEmves5JCFFdmSlRBFUDO0lsSWLXC2yUUugA9uhLXVS
 FyjSXwdF3RR0ouTxKzLh8Uk4iCcHgWEDi+xq1pq+r8QD/TmYk03hUDiiqxe1vgReZ49ZVxk6
X-Google-Smtp-Source: AGHT+IEoLeE3XGd1KcFNwnbRbUfIRIti7oTzdPzpZA/novhKaDH+wM6x8wdz6X3nwtN+R5ErwzON2g==
X-Received: by 2002:a17:907:7f28:b0:aa6:88c6:9449 with SMTP id
 a640c23a62f3a-ab6cfceaa79mr2371803566b.19.1738687529282; 
 Tue, 04 Feb 2025 08:45:29 -0800 (PST)
Received: from tucornea-pc-virtualbox.buh.is.keysight.com ([213.249.122.236])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e4a320e0sm946638566b.151.2025.02.04.08.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 08:45:28 -0800 (PST)
From: Tudor Cornea <tudor.cornea@gmail.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Tudor Cornea <tudor.cornea@gmail.com>
Subject: [PATCH] net/af_packet: fix socket close on device stop
Date: Tue,  4 Feb 2025 18:45:08 +0200
Message-Id: <20250204164508.864080-1-tudor.cornea@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Currently, if we call rte_eth_dev_stop(), the sockets are closed.
If we attempt to start the port again, socket related operations
will not work correctly.

This can be alleviated by closing the socket at the same place in
which we currently free the memory, in eth_dev_close().

If an application calls rte_eth_dev_stop() on a port managed
by the af_packet PMD, the port becomes unusable. This is in contrast
with ports managed by other drivers (e.g virtio).

I also managed to reproduce the issue using testpmd.

sudo ip link add test-veth0 type veth peer name test-veth1

sudo ip link set test-veth0 up
sudo ip link set test-veth1 up

AF_PACKET_ARGS=\
"blocksz=4096,framesz=2048,framecnt=512,qpairs=1,qdisc_bypass=0"

sudo ./dpdk-testpmd \
        -l 0-3 \
        -m 1024 \
        --no-huge \
        --no-shconf \
        --no-pci \
        --vdev=net_af_packet0,iface=test-veth0,${AF_PACKET_ARGS} \
        --vdev=net_af_packet1,iface=test-veth1,${AF_PACKET_ARGS} \
        -- \
        -i

testpmd> start tx_first

Forwarding will start, and we will see traffic on the interfaces.

testpmd> stop
testpmd> port stop 0
Stopping ports...
Checking link statuses...
Done
testpmd> port stop 1
Stopping ports...
Checking link statuses...
Done

testpmd> port start 0
AFPACKET: eth_dev_macaddr_set(): receive socket not found
Port 0: CA:65:81:63:81:B2
Checking link statuses...
Done
testpmd> port start 1
AFPACKET: eth_dev_macaddr_set(): receive socket not found
Port 1: CA:12:D0:BE:93:3F
Checking link statuses...
Done

testpmd> start tx_first

When we start forwarding again, we can see that there is no traffic
on the interfaces. This does not happen when testing with other PMD
drivers (e.g virtio).

With the patch, the port should re-initialize correctly.

testpmd> port start 0
Port 0: CA:65:81:63:81:B2
Checking link statuses...
Done

Fixes: 364e08f2bbc0 ("af_packet: add PMD for AF_PACKET-based virtual devices")

Signed-off-by: Tudor Cornea <tudor.cornea@gmail.com>
---
 drivers/net/af_packet/rte_eth_af_packet.c | 30 +++++++++++------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index ceb8d9356a..efae15a493 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -357,27 +357,12 @@ static int
 eth_dev_stop(struct rte_eth_dev *dev)
 {
 	unsigned i;
-	int sockfd;
 	struct pmd_internals *internals = dev->data->dev_private;
 
 	for (i = 0; i < internals->nb_queues; i++) {
-		sockfd = internals->rx_queue[i].sockfd;
-		if (sockfd != -1)
-			close(sockfd);
-
-		/* Prevent use after free in case tx fd == rx fd */
-		if (sockfd != internals->tx_queue[i].sockfd) {
-			sockfd = internals->tx_queue[i].sockfd;
-			if (sockfd != -1)
-				close(sockfd);
-		}
-
-		internals->rx_queue[i].sockfd = -1;
-		internals->tx_queue[i].sockfd = -1;
 		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
 		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
 	}
-
 	dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
 	return 0;
 }
@@ -474,6 +459,7 @@ eth_dev_close(struct rte_eth_dev *dev)
 	struct pmd_internals *internals;
 	struct tpacket_req *req;
 	unsigned int q;
+	int sockfd;
 
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return 0;
@@ -484,6 +470,20 @@ eth_dev_close(struct rte_eth_dev *dev)
 	internals = dev->data->dev_private;
 	req = &internals->req;
 	for (q = 0; q < internals->nb_queues; q++) {
+		sockfd = internals->rx_queue[q].sockfd;
+		if (sockfd != -1)
+			close(sockfd);
+
+		/* Prevent use after free in case tx fd == rx fd */
+		if (sockfd != internals->tx_queue[q].sockfd) {
+			sockfd = internals->tx_queue[q].sockfd;
+			if (sockfd != -1)
+				close(sockfd);
+		}
+
+		internals->rx_queue[q].sockfd = -1;
+		internals->tx_queue[q].sockfd = -1;
+
 		munmap(internals->rx_queue[q].map,
 			2 * req->tp_block_size * req->tp_block_nr);
 		rte_free(internals->rx_queue[q].rd);
-- 
2.34.1

