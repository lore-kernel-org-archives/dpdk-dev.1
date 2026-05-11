Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0EDCD37AC
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 10:36:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C4D640653;
	Mon, 11 May 2026 12:36:33 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id E0900402D5;
 Mon, 11 May 2026 12:36:30 +0200 (CEST)
X-QQ-mid: zesmtpsz3t1778495788t0a37aff0
X-QQ-Originating-IP: r2PgvGdzi3d3Jr2gq37l0DuzKTcQ/aM6JOXNCHjsR08=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 11 May 2026 18:36:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13123843796800898486
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v4 02/20] net/ngbe: remove duplicate xstats counters
Date: Mon, 11 May 2026 18:35:44 +0800
Message-Id: <20260511103604.19724-3-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260511103604.19724-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OCnNLGxuhE2oiHaWs3cl6OIuFKPHb/n8VRu2RmINh4pBIZzC57ErvOAU
 fg5dwAv0FU1JXfQ3Subf8ZjRvss3ZM1VJtJTy8BD3L8WWmMEQc/PfvlfaiFn7Qk5rYXkH7y
 Khe6JqOs8Pu9opPtOfUqP3YHSZ/wW+jGX7IxFgqvupAaeOJ9V+eNqYf4U+cCbb+fc4j8tor
 j9Ac3akpQWKEKVPueVVUUzQTRbSM595iI+g/007BjUBiWVAJ0j7Asn8NiHmlOOF03ZR72aI
 TG5CPk4f20CGhC8YsX9yhiVQbrObl8y57xAx3b1pzb/RBVMqNb4oAsW5QcRFcMRuqylnSL3
 XKyGRnRlRPGecsZ7RXJ/EOuUxeAC9qbXfYN33bPQeUHvrDreGp6zKcptJ84Cn5Y5rLkF03h
 pkB3smJevjbOJAhVB5m1obwdOjYGvAikFYvQqYvy/ptEMUhMCz4E2U9Ue4VzKSuMeiJ+c6d
 MPo4eMZvofMrOq0ltHrVprvX8sWSMyMUZM9/3tfyzw/LdCvFo3wmRuMzDzKxENpHoNhwseE
 wsKjoEux3K3SNn0JC79VZOnLWtTatCj/Nmjwn1tBeDiRtyckY69K6ZXi3iM7s7vwZJpN/cw
 wOsTqWH7jwHMDHx6UKg8ecN0Ideq8XsxpY/XNrc190NH/wZyFTkZIlIel+BKYa/kOXcSEDG
 IEk8HI/UObXglwa6N9SrIz1yHg/TN5rLC2LKrKKZQ1Tn6EBKKHAC0tdPqvCXc2XdFXkOzTH
 1l75z6Da522x8wnfG2ylq2tyBFfJlhFdvmW6nyggna1xvpyVgVD93W/R/8ReMpqzV3dAtXI
 PhqAuH/6ZpVP5c/4GEuDoXAzoC9lmVpYr+wiHS2u4OQANkNP8fZNtPSsgahXw85lrBdATvn
 NNQ5J+rNEyw8D2BHXx/EDbF9nFbQf6p9jpeCv6dtnzFkbk2RXfucQRUFrBSlO62TjCTmjAA
 y7hLL4U+6BUZZ9e09DSBJOut9MPSpHTww/6A5lofcCQ0SZcPbHBOB/eyfiDSWXbxMkaYXza
 +1+H/c0URUXyOxkYYj7zpdC1Kf/Ha28QPjl+0oIVp+47klE8w9zLtfohTdgRAYfdo4p6Us+
 LGn16UJ+UYwkiMShD2cOMKS/li3DJcV29uzsF4srLLP
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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

Remove four redundant counters (tx_xon_packets, rx_xon_packets,
tx_xoff_packets and rx_xoff_packets) from xstats, as they were duplicates
of tx_flow_control_xon_packets and others. Both sets were reading the same
registers but being output twice under different names. After removing
these entries, the flow control counters in DPDK now align with those in
our Linux kernel driver.

Fixes: 8b433d04adc9 ("net/ngbe: support device xstats")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/ngbe/ngbe_ethdev.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ngbe/ngbe_ethdev.c b/drivers/net/ngbe/ngbe_ethdev.c
index 8b9d6371fb..6df53f3266 100644
--- a/drivers/net/ngbe/ngbe_ethdev.c
+++ b/drivers/net/ngbe/ngbe_ethdev.c
@@ -227,11 +227,6 @@ static const struct rte_ngbe_xstats_name_off rte_ngbe_stats_strings[] = {
 	HW_XSTAT(tx_size_1024_to_max_packets),
 
 	/* Flow Control */
-	HW_XSTAT(tx_xon_packets),
-	HW_XSTAT(rx_xon_packets),
-	HW_XSTAT(tx_xoff_packets),
-	HW_XSTAT(rx_xoff_packets),
-
 	HW_XSTAT_NAME(tx_xon_packets, "tx_flow_control_xon_packets"),
 	HW_XSTAT_NAME(rx_xon_packets, "rx_flow_control_xon_packets"),
 	HW_XSTAT_NAME(tx_xoff_packets, "tx_flow_control_xoff_packets"),
-- 
2.21.0.windows.1

