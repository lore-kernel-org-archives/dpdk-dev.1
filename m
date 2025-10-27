Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DDBCCF9E9
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 03:17:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0ECCE406B7;
	Mon, 27 Oct 2025 04:16:26 +0100 (CET)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id 029DD40668;
 Mon, 27 Oct 2025 04:16:21 +0100 (CET)
X-QQ-mid: esmtpsz16t1761534976t2962432e
X-QQ-Originating-IP: m6qTekT4iAEQ7O3JPHLdT/FB/l+AZ8bJ/pU3iWKWkpo=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.107.118])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 27 Oct 2025 11:16:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8297292478387811053
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH 14/19] net/txgbe: fix FDIR rule raw relative for L3 packets
Date: Mon, 27 Oct 2025 11:15:37 +0800
Message-Id: <20251027031542.10512-15-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251027031542.10512-1-jiawenwu@trustnetic.com>
References: <20251027031542.10512-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NKv2G1wnhDBnxF2WKbT1pvNz/7xY8fxNqr9ljqKgR2a7rlzu+lYWkJ1G
 Wd83PyhJ2RyHFSvnsV1eWmnnotWq+B0NI8acGiaY+7RI9DlcRT5BYiAOyMCB5sOM7AaJUM+
 XRdRkSKXfnc/Gfgf3rk3yA/q66jeTzpnhi/ikmwqqlznLHgUyq6bNKRXsRL4Bjc3Fnj1XtA
 pvvXnSZEbnf/VIcFgNxwBWQQdOln+bWR+BIij3Xh7BxtpXhMqFjoGeMCB7j0cs0TbgTBzWN
 yKM1uAGqTrnjAfP2NB43zqmLTHZ62vpPmC7L9qNb9c/+aV25y/9lxnOl37FG0KEd54sM+76
 V7Iq9jETVPd7FxFdrLz65GZaNqQhKfn0EEZhHbQjNfgonxl2JflDOdjZ43N6Io8fOV3OvRO
 qxOftjFOj5naaIfh3FXeIzSasARP3UkzLEZKthibWLd9+Vx0BHsUlOvD6ycy3qJTPuGeoH7
 YX1aQzppldvtNnwtCH9Gjk0zl/hquh6pOQa48D/8WyRAwXYQE3JlrB3geyTQTcvEsRuJ9pg
 0bf9JDksFIDZa9ApKtU0yHVGtBMr1xGqyoCVwTsiQut0pLxs16cOMK2pgEWJQqBasbNEnve
 znlhznAjGKPIVACu76Yyvf0eZc+mD9rYVT1szq9m6e9skGdx743BHleFXzNQS2OQYYc6ATc
 WAmGLScZnKucvEwKweQBxs9UzA4jiVlmhV2ArsVs0n8+K9B3Aq1+Bj3xdHpDgsfQ+xNUOUN
 /pXEgXNz5XHCKGmwhw6i41KUOhfFHSX8FRJrRTlzoNeIr9ad8mUxvNUd/3Vw9boQnKc16TU
 dxvMkc5GfsW2VEbGqV9gHySM1plgMkSOuDd5IMN4hE1+Qy8m+FqWLtz04KFL5RqvayhsT+a
 8ZbNaTjgxrDBHPbwkaf5T0KBB+mTtGALhOQtLm4ye3VkgvXGCHmfJdz6r4U7VsK/zIwT6zK
 Il7PVqGSS4R/EU0ZxZkNt7Z002igJR2bbgINny8RU0p66cKnudyCvRV3g+ZB6OOLNWArygR
 1FS6OVbNH7lNecmhXyBljNYqZCMDDHh3rVpCeoYX1hAOpqPyCt
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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

Hardware supports FDIR flex field base setting from start of MAC header,
IP header, L4 header, L4 payload. So for IP packet which has no L4 header,
it cannot match the raw bytes with relative offset start from L3 payload.
And FDIR flex bytes rule cannot match L2 packets.

Therefore, we will declare that the relative offset is only used for
matching the L4 packets.

Fixes: aa4974765499 ("net/txgbe: fix raw pattern match for FDIR rule")
Cc: stable@dpdk.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/txgbe_fdir.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_fdir.c b/drivers/net/txgbe/txgbe_fdir.c
index 77d0cc4c30..8d181db33f 100644
--- a/drivers/net/txgbe/txgbe_fdir.c
+++ b/drivers/net/txgbe/txgbe_fdir.c
@@ -258,10 +258,7 @@ txgbe_fdir_get_flex_base(struct txgbe_fdir_rule *rule)
 	if (rule->input.flow_type & TXGBE_ATR_L4TYPE_MASK)
 		return TXGBE_FDIRFLEXCFG_BASE_PAY;
 
-	if (rule->input.flow_type & TXGBE_ATR_L3TYPE_MASK)
-		return TXGBE_FDIRFLEXCFG_BASE_L3;
-
-	return TXGBE_FDIRFLEXCFG_BASE_L2;
+	return TXGBE_FDIRFLEXCFG_BASE_L3;
 }
 
 int
-- 
2.48.1

