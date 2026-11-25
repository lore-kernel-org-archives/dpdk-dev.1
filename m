Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BDD606A32C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=W7Ftw7JD
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3975840B8C;
	Wed, 25 Nov 2026 18:06:00 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.5])
 by mails.dpdk.org (Postfix) with ESMTPS id 88B4D402EE;
 Wed, 25 Nov 2026 18:05:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=e/zWo/t/niQ07jyxnesmctfvqKys/+H/rK6LTCEOCNo=;
 b=W7Ftw7JD4qb0B55by9rhdIl+4KkJYd3Pb7us8StRKQOGifLxOsvQiPAkuuCU1u
 nzpb3tvaOUEXDyC5GXDCNV0Vv7SYpIpY4KMwwNRGAbaKaYufj6pLL5oUZy4hIvMW
 QeHghGdNI3p1abNE6QkFUKa9SQUEI+nqdb2oUcXrST8Sc=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org
Subject: [PATCH v9 05/30] net/hinic3: fix wildcard IPv4,
 ICMP and UDP flow items
Date: Thu, 26 Nov 2026 01:03:59 +0800
Message-ID: <20261125170425.5430-6-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.56.0.windows.2
In-Reply-To: <20261125170425.5430-1-yejiacheng4@h-partners.com>
References: <20261125170425.5430-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDn77FiFQdrEdNeBQ--.6538S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF1DuF45WF4UJFyUuFW7Arb_yoWrZr13pF
 s8G3s8Zrs7Wr47GwsxGr4IgF45Gw1xtry3uFZxGa43GryDJr97Cay5CFy5WF1xKr95JFya
 qr4Y9FWDu3Z8J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jewZcUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNwn7BmsHFWkfvQAA3x
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Accept a wildcard IPv4 item, such as eth / ipv4 / udp, that has neither
a spec nor a mask, so the L4 item alone constrains the rule. The fdir
parser required both fields and rejected such a rule with -EINVAL.

The ICMP item was not translated, so an ICMP rule with an IPv4 spec or
mask matched every IPv4 packet that passed the IPv4 fields, and with the
wildcard above it would also match when the IPv4 item is empty.
Translate the ICMP item into the IPv4 protocol key, as the TCP and UDP
items already are, and reject a mask that selects fields the TCAM cannot
match: the ICMP type, code, checksum, identifier or sequence number, and
the UDP length or checksum. The TCP item already rejects its unsupported
fields; the ICMP and UDP items silently ignored them.

Fixes: efa3b9b36fc7 ("net/hinic3: add flow control and filters")
Cc: stable@dpdk.org

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/hinic3_flow.c | 60 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hinic3/hinic3_flow.c b/drivers/net/hinic3/hinic3_flow.c
index 1f686d4675..3fbed5497b 100644
--- a/drivers/net/hinic3/hinic3_flow.c
+++ b/drivers/net/hinic3/hinic3_flow.c
@@ -230,6 +230,14 @@ hinic3_flow_fdir_ipv4(const struct rte_flow_item *flow_item,
 
 	mask_ipv4 = (const struct rte_flow_item_ipv4 *)flow_item->mask;
 	spec_ipv4 = (const struct rte_flow_item_ipv4 *)flow_item->spec;
+
+	filter->fdir_filter.ip_type = HINIC3_FDIR_IP_TYPE_IPV4;
+	filter->fdir_filter.tunnel_type = HINIC3_FDIR_TUNNEL_MODE_NORMAL;
+
+	/* A wildcard IPv4 item leaves the L4 item in charge of the rule. */
+	if (!mask_ipv4 && !spec_ipv4)
+		return 0;
+
 	if (!mask_ipv4 || !spec_ipv4) {
 		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
 				   flow_item,
@@ -252,8 +260,6 @@ hinic3_flow_fdir_ipv4(const struct rte_flow_item *flow_item,
 	}
 
 	/* Set the filter information. */
-	filter->fdir_filter.ip_type = HINIC3_FDIR_IP_TYPE_IPV4;
-	filter->fdir_filter.tunnel_type = HINIC3_FDIR_TUNNEL_MODE_NORMAL;
 	filter->fdir_filter.key_mask.ipv4.src_ip =
 		rte_be_to_cpu_32(mask_ipv4->hdr.src_addr);
 	filter->fdir_filter.key_spec.ipv4.src_ip =
@@ -381,3 +387,11 @@ hinic3_flow_fdir_udp(const struct rte_flow_item *flow_item,
 	}
 
+	/* Only support src, dst ports, others should be masked. */
+	if (mask_udp->hdr.dgram_len || mask_udp->hdr.dgram_cksum) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
+				   flow_item,
+				   "Not supported by fdir filter, udp only support src port, dst port");
+		return -rte_errno;
+	}
+
 	/* Set the filter information. */
@@ -393,6 +407,42 @@ hinic3_flow_fdir_udp(const struct rte_flow_item *flow_item,
 	return 0;
 }
 
+static int
+hinic3_flow_fdir_icmp(const struct rte_flow_item *flow_item,
+		      struct hinic3_filter_t *filter,
+		      struct rte_flow_error *error)
+{
+	const struct rte_flow_item_icmp *spec_icmp, *mask_icmp;
+
+	mask_icmp = (const struct rte_flow_item_icmp *)flow_item->mask;
+	spec_icmp = (const struct rte_flow_item_icmp *)flow_item->spec;
+
+	filter->fdir_filter.key_mask.proto = HINIC3_UINT8_MAX;
+	filter->fdir_filter.key_spec.proto = IPPROTO_ICMP;
+
+	if (!mask_icmp && !spec_icmp)
+		return 0;
+
+	if (!mask_icmp || !spec_icmp) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
+				   flow_item,
+				   "Invalid fdir filter icmp mask or spec");
+		return -rte_errno;
+	}
+
+	/* Only the protocol number can be matched, others should be masked. */
+	if (mask_icmp->hdr.icmp_type || mask_icmp->hdr.icmp_code ||
+	    mask_icmp->hdr.icmp_cksum || mask_icmp->hdr.icmp_ident ||
+	    mask_icmp->hdr.icmp_seq_nb) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
+				   flow_item,
+				   "Not supported by fdir filter, icmp only support protocol number");
+		return -rte_errno;
+	}
+
+	return 0;
+}
+
 /**
  * Parse the pattern of network traffic and apply the parsing result to the
  * traffic filter.
@@ -464,6 +514,12 @@ hinic3_flow_parse_fdir_pattern(__rte_unused struct rte_eth_dev *dev,
 				return -rte_errno;
 			break;
 
+		case RTE_FLOW_ITEM_TYPE_ICMP:
+			err = hinic3_flow_fdir_icmp(flow_item, filter, error);
+			if (err)
+				return -rte_errno;
+			break;
+
 		default:
 			break;
 		}
-- 
2.33.0

