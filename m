Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57680CCF9E5
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 22:17:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D050340431;
	Mon, 27 Oct 2025 23:17:48 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id CB58F402F0
 for <dev@dpdk.org>; Mon, 27 Oct 2025 23:17:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761603467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zq95QJN54xLtBTTrV8NMouiShMhgsnHxgHi+XYjhFjY=;
 b=AMBUhopumbO9wItEw3sQLQCGRAoBHkGb9JnZNAvIGXFBxtvBAvSi0yy73Y1pXI/vdmDzi1
 f5OZ+Sjdls27L6KASKQRLZfodxUIvhmgbXoh8tCvw/LW6D6Cw+L4qq3OJIIZoHlDv1p3HC
 D2GrCatPd0f9pIbbCyICloDFuyNQbIY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-JGPRNTmsO5S9OiSkJVnWbg-1; Mon,
 27 Oct 2025 18:17:44 -0400
X-MC-Unique: JGPRNTmsO5S9OiSkJVnWbg-1
X-Mimecast-MFC-AGG-ID: JGPRNTmsO5S9OiSkJVnWbg_1761603463
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A5CF1800378; Mon, 27 Oct 2025 22:17:43 +0000 (UTC)
Received: from ringo.home (unknown [10.45.224.27])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4682F30001A7; Mon, 27 Oct 2025 22:17:40 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH dpdk v3 1/3] net/tap: add netlink helpers
Date: Mon, 27 Oct 2025 23:16:23 +0100
Message-ID: <20251027221622.494080-6-rjarry@redhat.com>
In-Reply-To: <20251027221622.494080-5-rjarry@redhat.com>
References: <20251027153750.445275-6-rjarry@redhat.com>
 <20251027221622.494080-5-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IC25ZDISMI_xczdgRED2zsAd2PdNeRNfLugvdI4gSao_1761603463
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

Add functions to get/set link flags, MAC address, and MTU using netlink
RTM_GETLINK/RTM_SETLINK messages instead of ioctl.

These will be used in the next commits for a more robust solution that
does not rely on interface names.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 drivers/net/tap/tap_netlink.c | 291 ++++++++++++++++++++++++++++++++++
 drivers/net/tap/tap_netlink.h |  10 +-
 2 files changed, 299 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tap/tap_netlink.c b/drivers/net/tap/tap_netlink.c
index 5ff60f41d426..0682ba87e0da 100644
--- a/drivers/net/tap/tap_netlink.c
+++ b/drivers/net/tap/tap_netlink.c
@@ -6,6 +6,7 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <linux/netlink.h>
+#include <net/if.h>
 #include <string.h>
 #include <sys/socket.h>
 #include <unistd.h>
@@ -411,3 +412,293 @@ tap_nlattr_nested_finish(struct tap_nlmsg *msg)
 
 	rte_free(tail);
 }
+
+/**
+ * Helper structure to pass data between netlink request and callback
+ */
+struct link_info_ctx {
+	struct ifinfomsg *info;
+	struct rte_ether_addr *mac;
+	unsigned int *flags;
+	unsigned int ifindex;
+	int found;
+};
+
+/**
+ * Callback to extract link information from RTM_GETLINK response
+ */
+static int
+tap_nl_link_cb(struct nlmsghdr *nh, void *arg)
+{
+	struct link_info_ctx *ctx = arg;
+	struct ifinfomsg *ifi = NLMSG_DATA(nh);
+	struct rtattr *rta;
+	int rta_len;
+
+	if (nh->nlmsg_type != RTM_NEWLINK)
+		return 0;
+
+	/* Check if this is the interface we're looking for */
+	if (ifi->ifi_index != (int)ctx->ifindex)
+		return 0;
+
+	ctx->found = 1;
+
+	/* Copy basic info if requested */
+	if (ctx->info)
+		*ctx->info = *ifi;
+
+	/* Extract flags if requested */
+	if (ctx->flags)
+		*ctx->flags = ifi->ifi_flags;
+
+	/* Parse attributes for MAC address if requested */
+	if (ctx->mac) {
+		rta = IFLA_RTA(ifi);
+		rta_len = IFLA_PAYLOAD(nh);
+
+		for (; RTA_OK(rta, rta_len); rta = RTA_NEXT(rta, rta_len)) {
+			if (rta->rta_type == IFLA_ADDRESS) {
+				if (RTA_PAYLOAD(rta) >= RTE_ETHER_ADDR_LEN)
+					memcpy(ctx->mac, RTA_DATA(rta),
+					       RTE_ETHER_ADDR_LEN);
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * Get interface flags by ifindex
+ *
+ * @param nlsk_fd
+ *   Netlink socket file descriptor
+ * @param ifindex
+ *   Interface index
+ * @param flags
+ *   Pointer to store interface flags
+ *
+ * @return
+ *   0 on success, -1 on error
+ */
+int
+tap_nl_get_flags(int nlsk_fd, unsigned int ifindex, unsigned int *flags)
+{
+	struct {
+		struct nlmsghdr nh;
+		struct ifinfomsg ifi;
+	} req = {
+		.nh = {
+			.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
+			.nlmsg_type = RTM_GETLINK,
+			.nlmsg_flags = NLM_F_REQUEST,
+		},
+		.ifi = {
+			.ifi_family = AF_UNSPEC,
+			.ifi_index = ifindex,
+		},
+	};
+	struct link_info_ctx ctx = {
+		.flags = flags,
+		.ifindex = ifindex,
+		.found = 0,
+	};
+
+	if (tap_nl_send(nlsk_fd, &req.nh) < 0)
+		return -1;
+
+	if (tap_nl_recv(nlsk_fd, tap_nl_link_cb, &ctx) < 0)
+		return -1;
+
+	if (!ctx.found) {
+		errno = ENODEV;
+		return -1;
+	}
+
+	return 0;
+}
+
+/**
+ * Set interface flags by ifindex
+ *
+ * @param nlsk_fd
+ *   Netlink socket file descriptor
+ * @param ifindex
+ *   Interface index
+ * @param flags
+ *   Flags to set/unset
+ * @param set
+ *   1 to set flags, 0 to unset them
+ *
+ * @return
+ *   0 on success, -1 on error
+ */
+int
+tap_nl_set_flags(int nlsk_fd, unsigned int ifindex, unsigned int flags, int set)
+{
+	struct {
+		struct nlmsghdr nh;
+		struct ifinfomsg ifi;
+	} req = {
+		.nh = {
+			.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
+			.nlmsg_type = RTM_SETLINK,
+			.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
+		},
+		.ifi = {
+			.ifi_family = AF_UNSPEC,
+			.ifi_index = ifindex,
+			.ifi_flags = set ? flags : 0,
+			.ifi_change = flags,  /* mask of flags to change */
+		},
+	};
+
+	if (tap_nl_send(nlsk_fd, &req.nh) < 0)
+		return -1;
+
+	return tap_nl_recv_ack(nlsk_fd);
+}
+
+/**
+ * Set interface MTU by ifindex
+ *
+ * @param nlsk_fd
+ *   Netlink socket file descriptor
+ * @param ifindex
+ *   Interface index
+ * @param mtu
+ *   New MTU value
+ *
+ * @return
+ *   0 on success, -1 on error
+ */
+int
+tap_nl_set_mtu(int nlsk_fd, unsigned int ifindex, unsigned int mtu)
+{
+	struct {
+		struct nlmsghdr nh;
+		struct ifinfomsg ifi;
+		char buf[64];
+	} req = {
+		.nh = {
+			.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
+			.nlmsg_type = RTM_SETLINK,
+			.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
+		},
+		.ifi = {
+			.ifi_family = AF_UNSPEC,
+			.ifi_index = ifindex,
+		},
+	};
+	struct rtattr *rta;
+
+	/* Add MTU attribute */
+	rta = (struct rtattr *)((char *)&req + NLMSG_ALIGN(req.nh.nlmsg_len));
+	rta->rta_type = IFLA_MTU;
+	rta->rta_len = RTA_LENGTH(sizeof(mtu));
+	memcpy(RTA_DATA(rta), &mtu, sizeof(mtu));
+	req.nh.nlmsg_len = NLMSG_ALIGN(req.nh.nlmsg_len) + RTA_ALIGN(rta->rta_len);
+
+	if (tap_nl_send(nlsk_fd, &req.nh) < 0)
+		return -1;
+
+	return tap_nl_recv_ack(nlsk_fd);
+}
+
+/**
+ * Get interface MAC address by ifindex
+ *
+ * @param nlsk_fd
+ *   Netlink socket file descriptor
+ * @param ifindex
+ *   Interface index
+ * @param mac
+ *   Pointer to store MAC address
+ *
+ * @return
+ *   0 on success, -1 on error
+ */
+int
+tap_nl_get_mac(int nlsk_fd, unsigned int ifindex, struct rte_ether_addr *mac)
+{
+	struct {
+		struct nlmsghdr nh;
+		struct ifinfomsg ifi;
+	} req = {
+		.nh = {
+			.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
+			.nlmsg_type = RTM_GETLINK,
+			.nlmsg_flags = NLM_F_REQUEST,
+		},
+		.ifi = {
+			.ifi_family = AF_UNSPEC,
+			.ifi_index = ifindex,
+		},
+	};
+	struct link_info_ctx ctx = {
+		.mac = mac,
+		.ifindex = ifindex,
+		.found = 0,
+	};
+
+	if (tap_nl_send(nlsk_fd, &req.nh) < 0)
+		return -1;
+
+	if (tap_nl_recv(nlsk_fd, tap_nl_link_cb, &ctx) < 0)
+		return -1;
+
+	if (!ctx.found) {
+		errno = ENODEV;
+		return -1;
+	}
+
+	return 0;
+}
+
+/**
+ * Set interface MAC address by ifindex
+ *
+ * @param nlsk_fd
+ *   Netlink socket file descriptor
+ * @param ifindex
+ *   Interface index
+ * @param mac
+ *   New MAC address
+ *
+ * @return
+ *   0 on success, -1 on error
+ */
+int
+tap_nl_set_mac(int nlsk_fd, unsigned int ifindex, const struct rte_ether_addr *mac)
+{
+	struct {
+		struct nlmsghdr nh;
+		struct ifinfomsg ifi;
+		char buf[64];
+	} req = {
+		.nh = {
+			.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
+			.nlmsg_type = RTM_SETLINK,
+			.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
+		},
+		.ifi = {
+			.ifi_family = AF_UNSPEC,
+			.ifi_index = ifindex,
+		},
+	};
+	struct rtattr *rta;
+
+	/* Add MAC address attribute */
+	rta = (struct rtattr *)((char *)&req + NLMSG_ALIGN(req.nh.nlmsg_len));
+	rta->rta_type = IFLA_ADDRESS;
+	rta->rta_len = RTA_LENGTH(RTE_ETHER_ADDR_LEN);
+	memcpy(RTA_DATA(rta), mac, RTE_ETHER_ADDR_LEN);
+	req.nh.nlmsg_len = NLMSG_ALIGN(req.nh.nlmsg_len) + RTA_ALIGN(rta->rta_len);
+
+	if (tap_nl_send(nlsk_fd, &req.nh) < 0)
+		return -1;
+
+	return tap_nl_recv_ack(nlsk_fd);
+}
diff --git a/drivers/net/tap/tap_netlink.h b/drivers/net/tap/tap_netlink.h
index 5eff6edbb1cd..b85be166245e 100644
--- a/drivers/net/tap/tap_netlink.h
+++ b/drivers/net/tap/tap_netlink.h
@@ -6,12 +6,11 @@
 #ifndef _TAP_NETLINK_H_
 #define _TAP_NETLINK_H_
 
-#include <ctype.h>
 #include <inttypes.h>
 #include <linux/rtnetlink.h>
 #include <linux/netlink.h>
-#include <stdio.h>
 
+#include <rte_ether.h>
 #include <rte_log.h>
 
 #define NLMSG_BUF 512
@@ -39,4 +38,11 @@ void tap_nlattr_add32(struct tap_nlmsg *msg, unsigned short type, uint32_t data)
 int tap_nlattr_nested_start(struct tap_nlmsg *msg, uint16_t type);
 void tap_nlattr_nested_finish(struct tap_nlmsg *msg);
 
+/* Link management functions using netlink */
+int tap_nl_get_flags(int nlsk_fd, unsigned int ifindex, unsigned int *flags);
+int tap_nl_set_flags(int nlsk_fd, unsigned int ifindex, unsigned int flags, int set);
+int tap_nl_set_mtu(int nlsk_fd, unsigned int ifindex, unsigned int mtu);
+int tap_nl_set_mac(int nlsk_fd, unsigned int ifindex, const struct rte_ether_addr *mac);
+int tap_nl_get_mac(int nlsk_fd, unsigned int ifindex, struct rte_ether_addr *mac);
+
 #endif /* _TAP_NETLINK_H_ */
-- 
2.51.0

