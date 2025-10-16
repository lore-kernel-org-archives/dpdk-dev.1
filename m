Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC71ECCD194
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 11:21:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 249EE427E7;
	Thu, 16 Oct 2025 13:20:17 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id C6BF540A71
 for <dev@dpdk.org>; Thu, 16 Oct 2025 13:20:14 +0200 (CEST)
X-QQ-mid: esmtpsz17t1760613610tf4136d5b
X-QQ-Originating-IP: ONCsgyL+oDFFhYHGxOMMLC70Aum2efGv6aFao810h98=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.206.160.146])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 16 Oct 2025 19:20:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16775871077727449001
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v5 21/21] doc: update release notes for Wangxun txgbe driver
Date: Thu, 16 Oct 2025 19:17:35 +0800
Message-Id: <20251016111736.25372-22-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251016111736.25372-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20251016111736.25372-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NBplAH1p/X/dNdoewJxu5CjHoI4dDYaw77eBRoYKKaIyTptbTCZJQbYe
 FEpoz8Z4xDUpEHbZhbn/FBlwmqmmzqkvUydu5yU0xM5TCDEpNhLShD85hUqgbZqgeWdo6/d
 N36M9eRUDHgPETs/C0Cpc2+/ajhrKQRoD4ONLol3WdpaymxjqGRElljS0CCP5yiunSBppxq
 yxTCVlYDGVeBNNoCfteIKHgFJiAwCLuNVzDJk1EjoLZ6lYQYuIxqlR0eJ562OUJqBB1mVFo
 hJsKtCoYaUbImheHmq7oEhHbjhjs0o1aXjFQubBXt0366c8lfrudKhDPkfU+6UDhP6M0SKq
 K3gXtYZXC+qVsPRCklDU7GBX8DxlJ7d68xnwPuoXNV2IYV6Wrazf8p2HsjJLkXWuLNRVMDN
 NJ+lFC94R1CMuaNyWQXwPtMrq+e5Tx8oWIi+e1OHbFN6avXbj9F8t2pJt5TpwezlxeyhBYn
 pRd1/01vNO1d4TcLarD30v4MYO8JmBhq+2Av1K45fHd560O18pUbfeV1DUSehYEr4l/j1LX
 LbOC63iVoYqTaZ9y9TzXF1WuxmcZSklQlUmC5GvxmZ5FN/0Eg4i5WWpgul+K7uOSJvxwyC+
 Ke7PPv/L3rkTxaWj2bPsko9xALHyKw4qA5KznoHZ6gmle+h8v6OI5ibk6r1ac+Q0dfdfNQ7
 7iYH9hkE4Rmx3cSDiKUlhS58AaEFH6FYXBWi/A+yJMIw7eyMNXE5ENyzaLx3Tp+JccoloFT
 8NsuG4hLpRR+vtxneB+C4YJeEJqTH0aVAaqd+TmkUCnjTmofkBV3lS/9G0gvbYrZWeSzkvv
 fwbpR1fcWJpHdQ5fA3cTY3RKpCxBV21xxmlfDhpTLTRlPWrp2kwWeh6b6fJ/JL43oP3ME3F
 21AvlE5kwA/XsBme3+T3g3FUVZ3cTWdTd6W3sqHsUCMTvnBEfSOVhuw1WKvVAXHxr+Tgdf+
 WjPReu1WaOMR+wFlBuXU1wm9OJRlmWB9hyzjvGHrtshbWS1hDFc/jnMvU6vdGBQV4UrifmX
 cKebtjczfnD/80o+lS+bs66cGrBoOE6aMlYrFldv1tWRca6+k3XpITFNnxybcdpxdLT1c8r
 Q==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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

Add recent updates of Wangxun txgbe driver to 25.11 release notes.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 doc/guides/rel_notes/release_25_11.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index 3c32b26e3b..ebb15428e8 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -87,6 +87,13 @@ New Features
   * Added multi-process per port.
   * Optimized code.
 
+* **Updated Wangxun txgbe driver.**
+
+  Added support for Wangxun Amber-Lite NIC series, including FF5025 (supporting
+  10G and 25G) and FF5040 (supporting 40G). As these new models share hardware
+  similarities with the existing 10G Sapphire NICs, many of the existing
+  configurations and practices are expected to apply.
+
 * **Allow overriding the automatic usage/help generation in argparse library.**
 
   The argparse library now supports overriding the automatic help text generation,
-- 
2.21.0.windows.1

