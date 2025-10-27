Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02447CCF9E9
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 03:17:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19C6A40695;
	Mon, 27 Oct 2025 04:16:21 +0100 (CET)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id B6FFC40672;
 Mon, 27 Oct 2025 04:16:17 +0100 (CET)
X-QQ-mid: esmtpsz16t1761534974t0291bd51
X-QQ-Originating-IP: Hu1HPEBYQm74vr+2ggwJpq3WT6bz8iOhr5jvECFEo5s=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.107.118])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 27 Oct 2025 11:16:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11286506588268912656
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH 13/19] net/txgbe: filter FDIR match flex bytes for tunnel
 packets
Date: Mon, 27 Oct 2025 11:15:36 +0800
Message-Id: <20251027031542.10512-14-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251027031542.10512-1-jiawenwu@trustnetic.com>
References: <20251027031542.10512-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MG198VGnokamRynhHzeX6lSJMApVnSLUuhm0CqMTNXKBSL0AiFp6hjko
 XD/C/ll0hZtvqPHPzbh5xrNSYFMsX1oXfqhKJKk5ahKP4DNRePkYUhoogXmbHGACn6/h4Qn
 9+M7JH+u3j5h3EmiQNiV7LspL0f7bjR9m9Q5iN4rZJ69DRxTHJRMoUYfHYAMasBBFCinx5S
 ZHRlCDc46g85QgfzTR+ssDcxcTNa+ZNY3exbYKwMe0UE45ISw8/tryoz/h587jP5vZIROAi
 hGsnh8UDdFkV2Ul97zn+0a1UWgEFRFE7WMwZc8hpT2fTbWyc2MG+V68XEj4GfT+jiYg5DRC
 HeLwOCKUHCiUi7deaTCWuiSh/bfwOvcsgy5vZMwskrBxGSdmYrJC3869XwajAHgGoVFBCYz
 3KfwznRBpLIxx0wFwGOy7tNTU7oTtF3ie4IjpwsCy+6kQ5C0rHiruCjfxApNznyPmSbQDx/
 ih75ToxjTf/9eqv/dqzC+9NSwWyBNZmDqPossPAS2r2CdXPmxnlId7DOppvRALkrhArtlDM
 xHYtx2lwna7qkwYL05rUADb2/29e1jB6fErUjQcUBnan2eL0Rm8q9NRTGFj700+inZ0Zmik
 BcufE/FREVKB4Jd7vEUY75VhbN6iyS9SeU28vS4A0sAvFZS1q5ZyJWUKJODhmsY0XCzV2t/
 3ODjNxENbrotpWLPe1SXLfCsMB2N98c8pegexzeMxO+gLxJxwdmYr7fIUApCrkYAwoHGWkG
 w1t2KwuHCCHqAvhAJP2nuHEHNDJ7vXODv8TVehJD/987LA0CTsP1oZuDAX+I62zSwD1wpH/
 CZDqCiKy0z5pdhH5wRLNsO0BsVAHQOeb+yjEnxzgvgN60g9Sj5urXmRNirCl6wW1yYB9cIK
 vP/zgZ8L1g7nyNlJGOZkyronE8Vu+9cWZLqfeNy23T8VjReqoxJumWkNsCabd9uRejTLhaY
 vxUGvbXIYku+D8giXWlhDOux58ZoAQ9zImpDYVaEGxEE9/1QhppHaqJfdJutr2MCRHVy2v4
 bIn2rNTZ9K61B3nb4O/Iy8CHM3PL2jPPhcUVStQONtRAQgv5Euxa1JbdEPh/4vHywRQ1rtW
 A==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0
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

For tunnel packets, pattern RAW is also supported to match in FDIR
rules. Fix to process this field.

Fixes: a1851465f825 ("net/txgbe: fix to create FDIR filter for tunnel packet")
Cc: stable@dpdk.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/txgbe_flow.c | 125 ++++++++++++++++++++++++++++++++-
 1 file changed, 123 insertions(+), 2 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index 5b03a35949..095c84823f 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -2222,6 +2222,8 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 	const struct rte_flow_item_udp *udp_mask;
 	const struct rte_flow_item_sctp *sctp_spec;
 	const struct rte_flow_item_sctp *sctp_mask;
+	const struct rte_flow_item_raw *raw_mask;
+	const struct rte_flow_item_raw *raw_spec;
 	u8 ptid = 0;
 	uint32_t j;
 
@@ -2548,7 +2550,8 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 		if (item->type != RTE_FLOW_ITEM_TYPE_TCP &&
 		    item->type != RTE_FLOW_ITEM_TYPE_UDP &&
 		    item->type != RTE_FLOW_ITEM_TYPE_SCTP &&
-		    item->type != RTE_FLOW_ITEM_TYPE_END) {
+		    item->type != RTE_FLOW_ITEM_TYPE_END &&
+		    item->type != RTE_FLOW_ITEM_TYPE_RAW) {
 			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
 			rte_flow_error_set(error, EINVAL,
 					   RTE_FLOW_ERROR_TYPE_ITEM,
@@ -2637,7 +2640,8 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 		if (item->type != RTE_FLOW_ITEM_TYPE_TCP &&
 		    item->type != RTE_FLOW_ITEM_TYPE_UDP &&
 		    item->type != RTE_FLOW_ITEM_TYPE_SCTP &&
-		    item->type != RTE_FLOW_ITEM_TYPE_END) {
+		    item->type != RTE_FLOW_ITEM_TYPE_END &&
+		    item->type != RTE_FLOW_ITEM_TYPE_RAW) {
 			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
 			rte_flow_error_set(error, EINVAL,
 					   RTE_FLOW_ERROR_TYPE_ITEM,
@@ -2699,6 +2703,16 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 			rule->input.dst_port =
 				tcp_spec->hdr.dst_port;
 		}
+
+		item = next_no_fuzzy_pattern(pattern, item);
+		if (item->type != RTE_FLOW_ITEM_TYPE_RAW &&
+		    item->type != RTE_FLOW_ITEM_TYPE_END) {
+			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   item, "Not supported by fdir filter");
+			return -rte_errno;
+		}
 	}
 
 	/* Get the UDP info */
@@ -2748,6 +2762,16 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 			rule->input.dst_port =
 				udp_spec->hdr.dst_port;
 		}
+
+		item = next_no_fuzzy_pattern(pattern, item);
+		if (item->type != RTE_FLOW_ITEM_TYPE_RAW &&
+		    item->type != RTE_FLOW_ITEM_TYPE_END) {
+			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   item, "Not supported by fdir filter");
+			return -rte_errno;
+		}
 	}
 
 	/* Get the SCTP info */
@@ -2798,6 +2822,103 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 			rule->input.dst_port =
 				sctp_spec->hdr.dst_port;
 		}
+
+		item = next_no_fuzzy_pattern(pattern, item);
+		if (item->type != RTE_FLOW_ITEM_TYPE_RAW &&
+		    item->type != RTE_FLOW_ITEM_TYPE_END) {
+			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   item, "Not supported by fdir filter");
+			return -rte_errno;
+		}
+	}
+
+	/* Get the flex byte info */
+	if (item->type == RTE_FLOW_ITEM_TYPE_RAW) {
+		uint16_t pattern = 0;
+
+		/* Not supported last point for range*/
+		if (item->last) {
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+					   item, "Not supported last point for range");
+			return -rte_errno;
+		}
+		/* mask should not be null */
+		if (!item->mask || !item->spec) {
+			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   item, "Not supported by fdir filter");
+			return -rte_errno;
+		}
+
+		rule->b_mask = TRUE;
+		raw_mask = item->mask;
+
+		/* check mask */
+		if (raw_mask->relative != 0x1 ||
+		    raw_mask->search != 0x1 ||
+		    raw_mask->reserved != 0x0 ||
+		    (uint32_t)raw_mask->offset != 0xffffffff ||
+		    raw_mask->limit != 0xffff ||
+		    raw_mask->length != 0xffff) {
+			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   item, "Not supported by fdir filter");
+			return -rte_errno;
+		}
+
+		rule->b_spec = TRUE;
+		raw_spec = item->spec;
+
+		/* check spec */
+		if (raw_spec->search != 0 ||
+		    raw_spec->reserved != 0 ||
+		    raw_spec->offset > TXGBE_MAX_FLX_SOURCE_OFF ||
+		    raw_spec->offset % 2 ||
+		    raw_spec->limit != 0 ||
+		    raw_spec->length != 4 ||
+		    /* pattern can't be 0xffff */
+		    (raw_spec->pattern[0] == 0xff &&
+		     raw_spec->pattern[1] == 0xff &&
+		     raw_spec->pattern[2] == 0xff &&
+		     raw_spec->pattern[3] == 0xff)) {
+			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   item, "Not supported by fdir filter");
+			return -rte_errno;
+		}
+
+		/* check pattern mask */
+		if (raw_mask->pattern[0] != 0xff ||
+		    raw_mask->pattern[1] != 0xff ||
+		    raw_mask->pattern[2] != 0xff ||
+		    raw_mask->pattern[3] != 0xff) {
+			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   item, "Not supported by fdir filter");
+			return -rte_errno;
+		}
+
+		rule->mask.flex_bytes_mask = 0xffff;
+		/* Convert pattern string to hex bytes */
+		if (sscanf((const char *)raw_spec->pattern, "%hx", &pattern) != 1) {
+			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+			rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM,
+				item, "Failed to parse raw pattern");
+			return -rte_errno;
+		}
+		rule->input.flex_bytes = (pattern & 0x00FF) << 8;
+		rule->input.flex_bytes |= (pattern & 0xFF00) >> 8;
+
+		rule->flex_bytes_offset = raw_spec->offset;
+		rule->flex_relative = raw_spec->relative;
 	}
 
 	if (item->type != RTE_FLOW_ITEM_TYPE_END) {
-- 
2.48.1

