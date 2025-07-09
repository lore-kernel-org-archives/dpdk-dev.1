Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C602EC83F03
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 08:32:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3184402D7;
	Wed,  9 Jul 2025 10:32:47 +0200 (CEST)
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com
 [203.205.221.190])
 by mails.dpdk.org (Postfix) with UTF8SMTP id A977E4021E
 for <dev@dpdk.org>; Wed,  9 Jul 2025 10:32:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1752049959; bh=a1E8wk6BFEA643cY7OxB4IJy4+UbWPDG9tsVngbnGbI=;
 h=From:To:Cc:Subject:Date;
 b=qLdbTFmPQzbMe8FXmz36TjP94gu1qLTjQXRrdOT176NNyVYU3SbNn7+rzC1DRwlb4
 FIYa81d1u2BmlbV7cdyCK4VwPQjN8tLVzKuAm69M2VkbxkGJInqsuvUkpTCVteSiqh
 mw/ARKTlziOABfqIsjIYdgE0abmchhDAA67DCryo=
Received: from localhost.localdomain ([218.2.97.92])
 by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
 id 81E8B6A1; Wed, 09 Jul 2025 16:32:30 +0800
X-QQ-mid: xmsmtpt1752049950tps03flym
Message-ID: <tencent_51BB4368612AB46A24214A53B97AD8A3CE09@qq.com>
X-QQ-XMAILINFO: Mfa2ogpi8We7RGbvVPmFkNy1u/cvYFeI2vnzPav0bNyQo67UrkafLmYPeSEtBV
 /T/JTngjM/SDVzV9xh+i0PYRGpWSpeOWt/vbhW0SqS5qjgGOJaHwBaNTkPLsFBEXqXj7753QnTqw
 IT/xeTkdihhN9wEO86f894Doz3qLZK9bFWTb2oslV5AdBKPzBZq4kf5LTWEte/cS+78UqPnOU/SY
 MPBAvsJDQBcg8gdzvMKGfiHCxsU68jnpTaMPUL92hQl+bWqKOLNhyRo+wFuPmoABPNUyOtVriSYc
 v07UEl07HHb+1If8RAPcyij31gydK1gRYVbzgW5ssX3oAw6WJlaFUM5KU62TrxZChYGxve9c5PE7
 93f25/4CbwtNnFIPI2GANLRh0VCwUJU6AMeOckqD+iv2W0WVNRfYqZ2tLS8IV2rTZXypI8f1qYI0
 aVdEQHMF2A7/Wpz8f8BQidyyJLqgsAN6oTwIE6iRf5IDCyeukRG5aB1+ral9IXQRpWnNj7ZbDafp
 6KmhfSAsEcbTYKEr8CQdMFR3YDAkzwF0QSrwBxQCtk49TORhnrhba3NfNOhNcWSRNOndU9g6Vraw
 ezr1Y2ZI47sm7qdzGtspyv/kWMuypSC97aZD6r6xseEu4NA6STHR4vsUwBhTj1YXJTM5yVSzhwKz
 B53KVhZKF7Aa+N0VTpk9nWj03z7vpSh++RXjEZV/rzeJ269ThWTzP8toNDnOvVZYnTUbRFCQayyG
 Mj/exXS/qHyOjUTMOREsywHxPmllvuxS5lGnLiLk780JAlv81PO1cz4HUMHS2ObSVQLbfcFjJbtN
 eh8Zasz2jYZeXJqpnpaky0NCHJktEoNkChfCO/mJbhlrvE1DcJmRj8a/tFML2hx6ZnR8A7HPw68M
 6WYGxcYSEuZwWRZiCwWmtG/BCbxK5L1W2ZLUYfRcOKpeqseicK2W9JzVE/mXvU/w6zUcvw0Kl5
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Yijun Geng <1204565380@qq.com>
To: bruce.richardson@intel.com
Cc: dev@dpdk.org
Subject: [PATCH] net/i40e: support GTP in tunnel parameters parsing
Date: Wed,  9 Jul 2025 16:32:14 +0800
X-OQ-MSGID: <20250709083214.1959-1-1204565380@qq.com>
X-Mailer: git-send-email 2.45.2.windows.1
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

i40e I40E_TX_OFFLOAD_MASK indicates that all tunnel types are supported,
but gtp type is not considered in i40e_parse_tunneling_params(),
tunneling parameter: L4TUNLEN is not set. During TX checksum offloading,
the incorrect L3 header offset was used when calculating the inner IP
checksum,  resulting in modifying the length field of the GTP header.

Signed-off-by: Yijun Geng <1204565380@qq.com>
---
 drivers/net/intel/i40e/i40e_rxtx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index aba3c11ee5..d59d81474e 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -274,6 +274,7 @@ i40e_parse_tunneling_params(uint64_t ol_flags,
 		break;
 	case RTE_MBUF_F_TX_TUNNEL_VXLAN:
 	case RTE_MBUF_F_TX_TUNNEL_GENEVE:
+	case RTE_MBUF_F_TX_TUNNEL_GTP:
 		*cd_tunneling |= I40E_TXD_CTX_UDP_TUNNELING;
 		break;
 	case RTE_MBUF_F_TX_TUNNEL_GRE:
-- 
2.45.2.windows.1

