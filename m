Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BA9CCF9E5
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 03:17:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F44440676;
	Mon, 27 Oct 2025 04:16:18 +0100 (CET)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id D40A540673;
 Mon, 27 Oct 2025 04:16:15 +0100 (CET)
X-QQ-mid: esmtpsz16t1761534972tdb14db44
X-QQ-Originating-IP: OdqSlJTPXzNAHN7ZxrUT4JMg1FPs8b1r1Q6eigI7EIs=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.107.118])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 27 Oct 2025 11:16:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14136163287597553646
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH 12/19] net/txgbe: fix to create FDIR filter for tunnel SCTP
 packet
Date: Mon, 27 Oct 2025 11:15:35 +0800
Message-Id: <20251027031542.10512-13-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251027031542.10512-1-jiawenwu@trustnetic.com>
References: <20251027031542.10512-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NpE4FRFHkRiPv/a9kIi9QnZaLlwG90jACbqKjAamtDS77MTP7GvEFc8E
 f7N+Fjvc6Z6ebibN7WhaWgImU4HWqqQBAcTTeHtl76f/rgJtmo/eAH4+wmeeAidT2I69j4k
 0+R64l66xGxt/IOwZAiIxaVYmXfaMpAwR/lfAhKyn2hYrk/q8+oQaUCNxFvSVd4ok/hIw+j
 7cfcRFX8VsKgVyA9llZbDAJ79kmPmjVS9Nwp5mmMKxhBrSdZxH7QehtCXBiPI62W46z+DMs
 s62fsoaSMKzAXdXSi8WzJH2yvnC1aGMEtTHGI9gEW13AEGhs7TzbDULRVJ6Gx5fyzWZlfho
 vP7OWxdbmfEr2oMynRZonUCSEtRQxXtuirnTQ+G5S3vl7oPfR/jJ4qZmLSzzd3hzYlrPqS6
 AqRt1CAKlAof6C53bNJyeyNxXwiJG7W7t5RYjqFth+aJZ506niD7tBISISKGu5UTm4fmApl
 gWc+VvXFOEuwOc0Kw6u0IaYkrDfil4FiCskStFvEptze3SiGqF2zCHs7fZfhE/rkO0oJz8m
 mPTsKUXsfzhGgDVGb+2r0vfJZeKptEvLtJPE8bp+zJgNeNrw8Yqlp9Bi75pR2LkImi8lfww
 UdqXXeWqZsP4pgssd8Uizhc1VDcFobO5yaZhsfhvVbGtZFQlqWm6ne0I+/hvHZ3eUX/evK4
 IhTGx8MWJcQAujYB3rha94qlGjet3bwzp9WU3ieal2Ymgp4r4cFTA5pKpQoM7O0t5hFeN3R
 zfg7GbQiw65LBeirGZ2Dw4bN1uvaH9Jtec392KZ2u0I4YfdzVqyyAl4w3hwLnxtqDLFcAvJ
 ZWn/3/DnwvNL+7FB6qHJ3mPKAZylUzhu7f7U6SNOV2mp0xU3WdP6CqJoy+RzntKy2lXOlNa
 EaThACPPP493pxsy1a9RyTILo8xyttRU321pLYDgFM0GKrDtUl5w5DBloI1v6bUBhvE0vNl
 mu+n8qKalg1T8ek62hAMV8A2bXeuJ4prWe+33DBnvToQZAJvWB1xcMAxRii0Bv4eXhPjPpN
 m7JdwUWvH1XXBctCqEqvhvmC4MGwx7csrxiTbhgQ==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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

This commit is the same as commit 0db38d54b57a ("net/txgbe: fix to
create FDIR filter for SCTP packet").

The check for the mask of SCTP item is repeated and wrong, fix it to
make it work.

Fixes: a1851465f825 ("net/txgbe: fix to create FDIR filter for tunnel packet")
Cc: stable@dpdk.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/txgbe_flow.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index 7cf079a1cf..5b03a35949 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -2798,19 +2798,6 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 			rule->input.dst_port =
 				sctp_spec->hdr.dst_port;
 		}
-		/* others even sctp port is not supported */
-		sctp_mask = item->mask;
-		if (sctp_mask &&
-		    (sctp_mask->hdr.src_port ||
-		     sctp_mask->hdr.dst_port ||
-		     sctp_mask->hdr.tag ||
-		     sctp_mask->hdr.cksum)) {
-			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ITEM,
-					   item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
 	}
 
 	if (item->type != RTE_FLOW_ITEM_TYPE_END) {
-- 
2.48.1

