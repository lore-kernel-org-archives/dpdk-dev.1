Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1241C61DB2
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 08:43:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7CD042EF6;
	Fri, 13 Jun 2025 10:42:36 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 5B68D42EDF;
 Fri, 13 Jun 2025 10:42:33 +0200 (CEST)
X-QQ-mid: esmtpsz18t1749804143t5118a062
X-QQ-Originating-IP: x1ayPBz8guFWbUGHWq+OmAmUYxBKLEI4uq5J2p08Phg=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.60.58])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 13 Jun 2025 16:42:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 175500433390924812
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH v3 05/17] net/txgbe: fix to create FDIR filters for SCTP
 packets
Date: Fri, 13 Jun 2025 16:41:47 +0800
Message-Id: <20250613084159.22184-6-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250613084159.22184-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
 <20250613084159.22184-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OezpMYl8oadHswCDhjxjrOkRExpN8dt8ZYVi/4uXUEmgYP24/jL1pQNr
 xXb71E6WrqGuBGkJEYEc+DlaxCTvxzFEe1lH2SdyfBmqrd/kJAsob9Spyz51jnXCesecUBE
 FPOttFHuj2gQiCaLQGnpR+2ThRqkY6Tn1wrLxxJyVHJh77zRLXTQcxnLo2Ew2yhTq1zDhOr
 m81VuAxy+FiDMkFZtOa3W2h7mRb3MK1JVialzKZ/DGFrsmqbGg+khyBnxdnipziaKSLmCHP
 LxXttWryBrIW6oC1hKNl/PA1Z1NWqwX4uoSmKbahODVSLXP8LAd7gyxYQ8B8YzWLtN0kj5I
 dnkQlB9JwhD7yTgEiPQWaBY83oZ/jr+P1zza5JqZ/XR2vA0Woh0eBBFchBdGsGotT1hqJNX
 Sj/CCzpHQvzO3I7TcxRGLf4g6mKrj6Opq5w/OYVTZADgNhiQedMcKpxGs8RFMXuViRJyqkb
 ciKIQtfKsNpDSxRoic9uN/TVIvwVffNTNt1Gr0NW8a1wJSTWqfFASRjaEUO0ZLMUwRrzHZf
 snodlZEAQFHTE2Lhl7Galqxl6AGatmu53nqxpWGM6/N7m/A46fEGy1SrW2Ao1Xe9IheW8nW
 EEDkYYjA6vW4QZ6B5I2tAePBXASAnTXXmY67pFu9YV+/PD6b2YQRUlxKcCEDoMNkPtPym6J
 onWPVokMdyICzI/o3zuAz2CzvI/1f7QTbloxwQJsSk6Cs8tDq45ln+zldHoHN9cfw+3VmsA
 0oYGY4NX5L4nn5Q+m0hKPiyH/gR3+EAA+RkDWhG8hjifltRe0WKECPmUJE/eFbm/+ipUHmQ
 KaZpyNX4U+WIToI9GhQqgdhHT05h986fV3cR2YI2CDm7XNYcV0ijUiO9EQUL6dOM8Bxl9Fv
 mNPjXPqlX2UrMSu9XZ9j2rAouez3T2+AmpjvTdx1tle8OmbcHyc7IqKc+Cg6QQvfI8TmWri
 +ms0Z7yffkg4VL4ZiVXEBLtps00Pg/vyaAe9SGMjQhfa4A7MJJypII5WMvkAEOeDqac0Fuu
 D8ziZAqBslih+NmfUfdQpu530lROcLOvbpvxr4zABbUxddA9uuzij2wdNUEE8=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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

The check for the mask of SCTP item is repeated and wrong, fix it to
make it work.

Fixes: b973ee26747a ("net/txgbe: parse flow director filter")
Cc: stable@dpdk.org

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/txgbe_flow.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index bce88aebd3..c7cbf96a46 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -2067,19 +2067,6 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 			rule->input.dst_port =
 				sctp_spec->hdr.dst_port;
 		}
-		/* others even sctp port is not supported */
-		sctp_mask = item->mask;
-		if (sctp_mask &&
-			(sctp_mask->hdr.src_port ||
-			 sctp_mask->hdr.dst_port ||
-			 sctp_mask->hdr.tag ||
-			 sctp_mask->hdr.cksum)) {
-			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
 
 		item = next_no_fuzzy_pattern(pattern, item);
 		if (item->type != RTE_FLOW_ITEM_TYPE_RAW &&
-- 
2.48.1

