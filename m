Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ACCCAC592
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 07:31:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC6ED4060A;
	Mon, 22 Sep 2025 09:30:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E4FA2402EF
 for <dev@dpdk.org>; Mon, 22 Sep 2025 09:30:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758526258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mCUA3sgT7AlfG3Deh+BdLXDeZN4TfQ0mcyo6tQykMFo=;
 b=Pc4vDtSilBtbGN10SCAJ7bj0rZxMFMjVLzz/CIXpA74Ay38aUTGQF7g+OSOUZs5HUlNWqp
 QgQFIV80PEj1RTLGqaGEeo0qDys/0i3/Likc+1dYyQ+i5ojBFJLUqLiw//Olg0NIwQv8FR
 KROcvJ1j/fISpdXAivU69NVRXJPJIe4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-V5JTb4-HNGOPjuO6mBoFQw-1; Mon,
 22 Sep 2025 03:30:54 -0400
X-MC-Unique: V5JTb4-HNGOPjuO6mBoFQw-1
X-Mimecast-MFC-AGG-ID: V5JTb4-HNGOPjuO6mBoFQw_1758526253
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 776801800343; Mon, 22 Sep 2025 07:30:53 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.72])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F96A18004A3; Mon, 22 Sep 2025 07:30:51 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	alialnu@nvidia.com,
	stable@dpdk.org
Subject: [PATCH] net/tap: fix build with LTO
Date: Mon, 22 Sep 2025 09:30:43 +0200
Message-ID: <20250922073043.2394557-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U3xr_UTC98nNSYJLdcWCyOaXFw3an9WTx4m01L3YqZY_1758526253
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

The compiler has trouble understanding that the code is actually pointing
at the data in the message past the nh struct.

Update the tap_nlattr_add* helpers and the NLMSG_TAIL macro passing a
pointer to msg.

Bugzilla ID: 1511
Fixes: 7c25284e30c2 ("net/tap: add netlink back-end for flow API")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/tap/tap_flow.c    | 117 +++++++++++++---------------------
 drivers/net/tap/tap_netlink.c |  24 +++----
 drivers/net/tap/tap_netlink.h |  10 +--
 drivers/net/tap/tap_tcmsgs.c  |   6 +-
 4 files changed, 65 insertions(+), 92 deletions(-)

diff --git a/drivers/net/tap/tap_flow.c b/drivers/net/tap/tap_flow.c
index 373b773e2d..9d4ef27a8a 100644
--- a/drivers/net/tap/tap_flow.c
+++ b/drivers/net/tap/tap_flow.c
@@ -430,20 +430,16 @@ tap_flow_create_eth(const struct rte_flow_item *item, struct convert_data *info)
 		return 0;
 	msg = &flow->msg;
 	if (!rte_is_zero_ether_addr(&mask->hdr.dst_addr)) {
-		tap_nlattr_add(&msg->nh, TCA_FLOWER_KEY_ETH_DST,
-			RTE_ETHER_ADDR_LEN,
-			   &spec->hdr.dst_addr.addr_bytes);
-		tap_nlattr_add(&msg->nh,
-			   TCA_FLOWER_KEY_ETH_DST_MASK, RTE_ETHER_ADDR_LEN,
-			   &mask->hdr.dst_addr.addr_bytes);
+		tap_nlattr_add(msg, TCA_FLOWER_KEY_ETH_DST, RTE_ETHER_ADDR_LEN,
+			&spec->hdr.dst_addr.addr_bytes);
+		tap_nlattr_add(msg, TCA_FLOWER_KEY_ETH_DST_MASK, RTE_ETHER_ADDR_LEN,
+			&mask->hdr.dst_addr.addr_bytes);
 	}
 	if (!rte_is_zero_ether_addr(&mask->hdr.src_addr)) {
-		tap_nlattr_add(&msg->nh, TCA_FLOWER_KEY_ETH_SRC,
-			RTE_ETHER_ADDR_LEN,
+		tap_nlattr_add(msg, TCA_FLOWER_KEY_ETH_SRC, RTE_ETHER_ADDR_LEN,
 			&spec->hdr.src_addr.addr_bytes);
-		tap_nlattr_add(&msg->nh,
-			   TCA_FLOWER_KEY_ETH_SRC_MASK, RTE_ETHER_ADDR_LEN,
-			   &mask->hdr.src_addr.addr_bytes);
+		tap_nlattr_add(msg, TCA_FLOWER_KEY_ETH_SRC_MASK, RTE_ETHER_ADDR_LEN,
+			&mask->hdr.src_addr.addr_bytes);
 	}
 	return 0;
 }
@@ -498,11 +494,9 @@ tap_flow_create_vlan(const struct rte_flow_item *item, struct convert_data *info
 		uint8_t vid = VLAN_ID(tci);
 
 		if (prio)
-			tap_nlattr_add8(&msg->nh,
-					TCA_FLOWER_KEY_VLAN_PRIO, prio);
+			tap_nlattr_add8(msg, TCA_FLOWER_KEY_VLAN_PRIO, prio);
 		if (vid)
-			tap_nlattr_add16(&msg->nh,
-					 TCA_FLOWER_KEY_VLAN_ID, vid);
+			tap_nlattr_add16(msg, TCA_FLOWER_KEY_VLAN_ID, vid);
 	}
 	return 0;
 }
@@ -544,20 +538,15 @@ tap_flow_create_ipv4(const struct rte_flow_item *item, struct convert_data *info
 	if (!spec)
 		return 0;
 	if (mask->hdr.dst_addr) {
-		tap_nlattr_add32(&msg->nh, TCA_FLOWER_KEY_IPV4_DST,
-			     spec->hdr.dst_addr);
-		tap_nlattr_add32(&msg->nh, TCA_FLOWER_KEY_IPV4_DST_MASK,
-			     mask->hdr.dst_addr);
+		tap_nlattr_add32(msg, TCA_FLOWER_KEY_IPV4_DST, spec->hdr.dst_addr);
+		tap_nlattr_add32(msg, TCA_FLOWER_KEY_IPV4_DST_MASK, mask->hdr.dst_addr);
 	}
 	if (mask->hdr.src_addr) {
-		tap_nlattr_add32(&msg->nh, TCA_FLOWER_KEY_IPV4_SRC,
-			     spec->hdr.src_addr);
-		tap_nlattr_add32(&msg->nh, TCA_FLOWER_KEY_IPV4_SRC_MASK,
-			     mask->hdr.src_addr);
+		tap_nlattr_add32(msg, TCA_FLOWER_KEY_IPV4_SRC, spec->hdr.src_addr);
+		tap_nlattr_add32(msg, TCA_FLOWER_KEY_IPV4_SRC_MASK, mask->hdr.src_addr);
 	}
 	if (spec->hdr.next_proto_id)
-		tap_nlattr_add8(&msg->nh, TCA_FLOWER_KEY_IP_PROTO,
-			    spec->hdr.next_proto_id);
+		tap_nlattr_add8(msg, TCA_FLOWER_KEY_IP_PROTO, spec->hdr.next_proto_id);
 	return 0;
 }
 
@@ -599,20 +588,19 @@ tap_flow_create_ipv6(const struct rte_flow_item *item, struct convert_data *info
 	if (!spec)
 		return 0;
 	if (memcmp(&mask->hdr.dst_addr, empty_addr, 16)) {
-		tap_nlattr_add(&msg->nh, TCA_FLOWER_KEY_IPV6_DST,
-			   sizeof(spec->hdr.dst_addr), &spec->hdr.dst_addr);
-		tap_nlattr_add(&msg->nh, TCA_FLOWER_KEY_IPV6_DST_MASK,
-			   sizeof(mask->hdr.dst_addr), &mask->hdr.dst_addr);
+		tap_nlattr_add(msg, TCA_FLOWER_KEY_IPV6_DST, sizeof(spec->hdr.dst_addr),
+			&spec->hdr.dst_addr);
+		tap_nlattr_add(msg, TCA_FLOWER_KEY_IPV6_DST_MASK, sizeof(mask->hdr.dst_addr),
+			&mask->hdr.dst_addr);
 	}
 	if (memcmp(&mask->hdr.src_addr, empty_addr, 16)) {
-		tap_nlattr_add(&msg->nh, TCA_FLOWER_KEY_IPV6_SRC,
-			   sizeof(spec->hdr.src_addr), &spec->hdr.src_addr);
-		tap_nlattr_add(&msg->nh, TCA_FLOWER_KEY_IPV6_SRC_MASK,
-			   sizeof(mask->hdr.src_addr), &mask->hdr.src_addr);
+		tap_nlattr_add(msg, TCA_FLOWER_KEY_IPV6_SRC, sizeof(spec->hdr.src_addr),
+			&spec->hdr.src_addr);
+		tap_nlattr_add(msg, TCA_FLOWER_KEY_IPV6_SRC_MASK, sizeof(mask->hdr.src_addr),
+			&mask->hdr.src_addr);
 	}
 	if (spec->hdr.proto)
-		tap_nlattr_add8(&msg->nh,
-				TCA_FLOWER_KEY_IP_PROTO, spec->hdr.proto);
+		tap_nlattr_add8(msg, TCA_FLOWER_KEY_IP_PROTO, spec->hdr.proto);
 	return 0;
 }
 
@@ -649,15 +637,13 @@ tap_flow_create_udp(const struct rte_flow_item *item, struct convert_data *info)
 	if (!flow)
 		return 0;
 	msg = &flow->msg;
-	tap_nlattr_add8(&msg->nh, TCA_FLOWER_KEY_IP_PROTO, IPPROTO_UDP);
+	tap_nlattr_add8(msg, TCA_FLOWER_KEY_IP_PROTO, IPPROTO_UDP);
 	if (!spec)
 		return 0;
 	if (mask->hdr.dst_port)
-		tap_nlattr_add16(&msg->nh, TCA_FLOWER_KEY_UDP_DST,
-			     spec->hdr.dst_port);
+		tap_nlattr_add16(msg, TCA_FLOWER_KEY_UDP_DST, spec->hdr.dst_port);
 	if (mask->hdr.src_port)
-		tap_nlattr_add16(&msg->nh, TCA_FLOWER_KEY_UDP_SRC,
-			     spec->hdr.src_port);
+		tap_nlattr_add16(msg, TCA_FLOWER_KEY_UDP_SRC, spec->hdr.src_port);
 	return 0;
 }
 
@@ -694,15 +680,13 @@ tap_flow_create_tcp(const struct rte_flow_item *item, struct convert_data *info)
 	if (!flow)
 		return 0;
 	msg = &flow->msg;
-	tap_nlattr_add8(&msg->nh, TCA_FLOWER_KEY_IP_PROTO, IPPROTO_TCP);
+	tap_nlattr_add8(msg, TCA_FLOWER_KEY_IP_PROTO, IPPROTO_TCP);
 	if (!spec)
 		return 0;
 	if (mask->hdr.dst_port)
-		tap_nlattr_add16(&msg->nh, TCA_FLOWER_KEY_TCP_DST,
-			     spec->hdr.dst_port);
+		tap_nlattr_add16(msg, TCA_FLOWER_KEY_TCP_DST, spec->hdr.dst_port);
 	if (mask->hdr.src_port)
-		tap_nlattr_add16(&msg->nh, TCA_FLOWER_KEY_TCP_SRC,
-			     spec->hdr.src_port);
+		tap_nlattr_add16(msg, TCA_FLOWER_KEY_TCP_SRC, spec->hdr.src_port);
 	return 0;
 }
 
@@ -810,37 +794,30 @@ add_action(struct rte_flow *flow, size_t *act_index, struct action_data *adata)
 	if (tap_nlattr_nested_start(msg, (*act_index)++) < 0)
 		return -1;
 
-	tap_nlattr_add(&msg->nh, TCA_ACT_KIND,
-				strlen(adata->id) + 1, adata->id);
+	tap_nlattr_add(msg, TCA_ACT_KIND, strlen(adata->id) + 1, adata->id);
 	if (tap_nlattr_nested_start(msg, TCA_ACT_OPTIONS) < 0)
 		return -1;
 	if (strcmp("gact", adata->id) == 0) {
-		tap_nlattr_add(&msg->nh, TCA_GACT_PARMS, sizeof(adata->gact),
-			   &adata->gact);
+		tap_nlattr_add(msg, TCA_GACT_PARMS, sizeof(adata->gact), &adata->gact);
 	} else if (strcmp("mirred", adata->id) == 0) {
 		if (adata->mirred.eaction == TCA_EGRESS_MIRROR)
 			adata->mirred.action = TC_ACT_PIPE;
 		else /* REDIRECT */
 			adata->mirred.action = TC_ACT_STOLEN;
-		tap_nlattr_add(&msg->nh, TCA_MIRRED_PARMS,
-			   sizeof(adata->mirred),
-			   &adata->mirred);
+		tap_nlattr_add(msg, TCA_MIRRED_PARMS, sizeof(adata->mirred), &adata->mirred);
 	} else if (strcmp("skbedit", adata->id) == 0) {
-		tap_nlattr_add(&msg->nh, TCA_SKBEDIT_PARMS,
-			   sizeof(adata->skbedit.skbedit), &adata->skbedit.skbedit);
+		tap_nlattr_add(msg, TCA_SKBEDIT_PARMS, sizeof(adata->skbedit.skbedit),
+			&adata->skbedit.skbedit);
 		if (adata->skbedit.mark)
-			tap_nlattr_add32(&msg->nh, TCA_SKBEDIT_MARK, adata->skbedit.mark);
+			tap_nlattr_add32(msg, TCA_SKBEDIT_MARK, adata->skbedit.mark);
 		else
-			tap_nlattr_add16(&msg->nh, TCA_SKBEDIT_QUEUE_MAPPING, adata->skbedit.queue);
+			tap_nlattr_add16(msg, TCA_SKBEDIT_QUEUE_MAPPING, adata->skbedit.queue);
 	} else if (strcmp("bpf", adata->id) == 0) {
 #ifdef HAVE_BPF_RSS
-		tap_nlattr_add32(&msg->nh, TCA_ACT_BPF_FD, adata->bpf.bpf_fd);
-		tap_nlattr_add(&msg->nh, TCA_ACT_BPF_NAME,
-			   strlen(adata->bpf.annotation) + 1,
-			   adata->bpf.annotation);
-		tap_nlattr_add(&msg->nh, TCA_ACT_BPF_PARMS,
-			   sizeof(adata->bpf.bpf),
-			   &adata->bpf.bpf);
+		tap_nlattr_add32(msg, TCA_ACT_BPF_FD, adata->bpf.bpf_fd);
+		tap_nlattr_add(msg, TCA_ACT_BPF_NAME, strlen(adata->bpf.annotation) + 1,
+			adata->bpf.annotation);
+		tap_nlattr_add(msg, TCA_ACT_BPF_PARMS, sizeof(adata->bpf.bpf), &adata->bpf.bpf);
 #else
 		TAP_LOG(ERR, "Internal error: bpf requested but not supported");
 		return -1;
@@ -975,7 +952,7 @@ priv_flow_process(struct pmd_internals *pmd,
 				TC_H_MAKE(MULTIQ_MAJOR_HANDLE, 0);
 		}
 		/* use flower filter type */
-		tap_nlattr_add(&flow->msg.nh, TCA_KIND, sizeof("flower"), "flower");
+		tap_nlattr_add(&flow->msg, TCA_KIND, sizeof("flower"), "flower");
 		if (tap_nlattr_nested_start(&flow->msg, TCA_OPTIONS) < 0) {
 			rte_flow_error_set(error, ENOMEM, RTE_FLOW_ERROR_TYPE_ACTION,
 					   actions, "could not allocated netlink msg");
@@ -1015,15 +992,11 @@ priv_flow_process(struct pmd_internals *pmd,
 	}
 	if (flow) {
 		if (data.vlan) {
-			tap_nlattr_add16(&flow->msg.nh, TCA_FLOWER_KEY_ETH_TYPE,
-				     htons(ETH_P_8021Q));
-			tap_nlattr_add16(&flow->msg.nh,
-				     TCA_FLOWER_KEY_VLAN_ETH_TYPE,
-				     data.eth_type ?
-				     data.eth_type : htons(ETH_P_ALL));
+			tap_nlattr_add16(&flow->msg, TCA_FLOWER_KEY_ETH_TYPE, htons(ETH_P_8021Q));
+			tap_nlattr_add16(&flow->msg, TCA_FLOWER_KEY_VLAN_ETH_TYPE,
+				data.eth_type ?  data.eth_type : htons(ETH_P_ALL));
 		} else if (data.eth_type) {
-			tap_nlattr_add16(&flow->msg.nh, TCA_FLOWER_KEY_ETH_TYPE,
-				     data.eth_type);
+			tap_nlattr_add16(&flow->msg, TCA_FLOWER_KEY_ETH_TYPE, data.eth_type);
 		}
 	}
 	if (mirred && flow) {
diff --git a/drivers/net/tap/tap_netlink.c b/drivers/net/tap/tap_netlink.c
index 8a57c9242c..5ff60f41d4 100644
--- a/drivers/net/tap/tap_netlink.c
+++ b/drivers/net/tap/tap_netlink.c
@@ -293,18 +293,18 @@ tap_nl_recv(int nlsk_fd, int (*cb)(struct nlmsghdr *, void *arg), void *arg)
  *   The data to append.
  */
 void
-tap_nlattr_add(struct nlmsghdr *nh, unsigned short type,
+tap_nlattr_add(struct tap_nlmsg *msg, unsigned short type,
 	   unsigned int data_len, const void *data)
 {
 	/* see man 3 rtnetlink */
 	struct rtattr *rta;
 
-	rta = (struct rtattr *)NLMSG_TAIL(nh);
+	rta = (struct rtattr *)NLMSG_TAIL(msg);
 	rta->rta_len = RTA_LENGTH(data_len);
 	rta->rta_type = type;
 	if (data_len > 0)
 		memcpy(RTA_DATA(rta), data, data_len);
-	nh->nlmsg_len = NLMSG_ALIGN(nh->nlmsg_len) + RTA_ALIGN(rta->rta_len);
+	msg->nh.nlmsg_len = NLMSG_ALIGN(msg->nh.nlmsg_len) + RTA_ALIGN(rta->rta_len);
 }
 
 /**
@@ -318,9 +318,9 @@ tap_nlattr_add(struct nlmsghdr *nh, unsigned short type,
  *   The data to append.
  */
 void
-tap_nlattr_add8(struct nlmsghdr *nh, unsigned short type, uint8_t data)
+tap_nlattr_add8(struct tap_nlmsg *msg, unsigned short type, uint8_t data)
 {
-	tap_nlattr_add(nh, type, sizeof(uint8_t), &data);
+	tap_nlattr_add(msg, type, sizeof(uint8_t), &data);
 }
 
 /**
@@ -334,9 +334,9 @@ tap_nlattr_add8(struct nlmsghdr *nh, unsigned short type, uint8_t data)
  *   The data to append.
  */
 void
-tap_nlattr_add16(struct nlmsghdr *nh, unsigned short type, uint16_t data)
+tap_nlattr_add16(struct tap_nlmsg *msg, unsigned short type, uint16_t data)
 {
-	tap_nlattr_add(nh, type, sizeof(uint16_t), &data);
+	tap_nlattr_add(msg, type, sizeof(uint16_t), &data);
 }
 
 /**
@@ -350,9 +350,9 @@ tap_nlattr_add16(struct nlmsghdr *nh, unsigned short type, uint16_t data)
  *   The data to append.
  */
 void
-tap_nlattr_add32(struct nlmsghdr *nh, unsigned short type, uint32_t data)
+tap_nlattr_add32(struct tap_nlmsg *msg, unsigned short type, uint32_t data)
 {
-	tap_nlattr_add(nh, type, sizeof(uint32_t), &data);
+	tap_nlattr_add(msg, type, sizeof(uint32_t), &data);
 }
 
 /**
@@ -379,9 +379,9 @@ tap_nlattr_nested_start(struct tap_nlmsg *msg, uint16_t type)
 		return -1;
 	}
 
-	tail->tail = (struct rtattr *)NLMSG_TAIL(&msg->nh);
+	tail->tail = (struct rtattr *)NLMSG_TAIL(msg);
 
-	tap_nlattr_add(&msg->nh, type, 0, NULL);
+	tap_nlattr_add(msg, type, 0, NULL);
 
 	tail->prev = msg->nested_tails;
 
@@ -404,7 +404,7 @@ tap_nlattr_nested_finish(struct tap_nlmsg *msg)
 {
 	struct nested_tail *tail = msg->nested_tails;
 
-	tail->tail->rta_len = (char *)NLMSG_TAIL(&msg->nh) - (char *)tail->tail;
+	tail->tail->rta_len = (char *)NLMSG_TAIL(msg) - (char *)tail->tail;
 
 	if (tail->prev)
 		msg->nested_tails = tail->prev;
diff --git a/drivers/net/tap/tap_netlink.h b/drivers/net/tap/tap_netlink.h
index 466c47a6d7..5eff6edbb1 100644
--- a/drivers/net/tap/tap_netlink.h
+++ b/drivers/net/tap/tap_netlink.h
@@ -23,7 +23,7 @@ struct tap_nlmsg {
 	struct nested_tail *nested_tails;
 };
 
-#define NLMSG_TAIL(nlh) (void *)((char *)(nlh) + NLMSG_ALIGN((nlh)->nlmsg_len))
+#define NLMSG_TAIL(msg) (void *)((char *)(msg) + NLMSG_ALIGN((msg)->nh.nlmsg_len))
 
 int tap_nl_init(uint32_t nl_groups);
 int tap_nl_final(int nlsk_fd);
@@ -31,11 +31,11 @@ int tap_nl_send(int nlsk_fd, struct nlmsghdr *nh);
 int tap_nl_recv(int nlsk_fd, int (*callback)(struct nlmsghdr *, void *),
 		void *arg);
 int tap_nl_recv_ack(int nlsk_fd);
-void tap_nlattr_add(struct nlmsghdr *nh, unsigned short type,
+void tap_nlattr_add(struct tap_nlmsg *msg, unsigned short type,
 		    unsigned int data_len, const void *data);
-void tap_nlattr_add8(struct nlmsghdr *nh, unsigned short type, uint8_t data);
-void tap_nlattr_add16(struct nlmsghdr *nh, unsigned short type, uint16_t data);
-void tap_nlattr_add32(struct nlmsghdr *nh, unsigned short type, uint32_t data);
+void tap_nlattr_add8(struct tap_nlmsg *msg, unsigned short type, uint8_t data);
+void tap_nlattr_add16(struct tap_nlmsg *msg, unsigned short type, uint16_t data);
+void tap_nlattr_add32(struct tap_nlmsg *msg, unsigned short type, uint32_t data);
 int tap_nlattr_nested_start(struct tap_nlmsg *msg, uint16_t type);
 void tap_nlattr_nested_finish(struct tap_nlmsg *msg);
 
diff --git a/drivers/net/tap/tap_tcmsgs.c b/drivers/net/tap/tap_tcmsgs.c
index caca9445c8..c32f0ff815 100644
--- a/drivers/net/tap/tap_tcmsgs.c
+++ b/drivers/net/tap/tap_tcmsgs.c
@@ -123,8 +123,8 @@ qdisc_add_multiq(int nlsk_fd, unsigned int ifindex)
 		    NLM_F_REQUEST | NLM_F_ACK | NLM_F_EXCL | NLM_F_CREATE);
 	msg.t.tcm_handle = TC_H_MAKE(MULTIQ_MAJOR_HANDLE, 0);
 	msg.t.tcm_parent = TC_H_ROOT;
-	tap_nlattr_add(&msg.nh, TCA_KIND, sizeof("multiq"), "multiq");
-	tap_nlattr_add(&msg.nh, TCA_OPTIONS, sizeof(opt), &opt);
+	tap_nlattr_add(&msg, TCA_KIND, sizeof("multiq"), "multiq");
+	tap_nlattr_add(&msg, TCA_OPTIONS, sizeof(opt), &opt);
 	if (tap_nl_send(nlsk_fd, &msg.nh) < 0)
 		return -1;
 	if (tap_nl_recv_ack(nlsk_fd) < 0)
@@ -152,7 +152,7 @@ qdisc_add_ingress(int nlsk_fd, unsigned int ifindex)
 		    NLM_F_REQUEST | NLM_F_ACK | NLM_F_EXCL | NLM_F_CREATE);
 	msg.t.tcm_handle = TC_H_MAKE(TC_H_INGRESS, 0);
 	msg.t.tcm_parent = TC_H_INGRESS;
-	tap_nlattr_add(&msg.nh, TCA_KIND, sizeof("ingress"), "ingress");
+	tap_nlattr_add(&msg, TCA_KIND, sizeof("ingress"), "ingress");
 	if (tap_nl_send(nlsk_fd, &msg.nh) < 0)
 		return -1;
 	if (tap_nl_recv_ack(nlsk_fd) < 0)
-- 
2.51.0

