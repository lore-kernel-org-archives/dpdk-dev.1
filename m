Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0684CA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 11:22:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BC6E4279B;
	Tue, 29 Sep 2026 13:21:53 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id 0617C42793;
 Tue, 29 Sep 2026 13:21:49 +0200 (CEST)
X-QQ-mid: zesmtpgz6t1790680898tb5462d7b
X-QQ-Originating-IP: oxj/h/VElKeEQVxRYORAiXvqoQ+6/V2DUHUuJt2e7ac=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.38])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 29 Sep 2026 19:21:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13508320511632234058
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v5 03/15] net/txgbe: fix e56 PHY configuration error
Date: Tue, 29 Sep 2026 19:18:03 +0800
Message-ID: <2FF3C32C7313AA16+20260929112119.4516-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260929112119.4516-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260929112119.4516-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mv3l2S4IM5FYWmokZKW5QWEHXTizcez7NvSVtTcJFv2lkXujFj+W4ztm
 xF+pTMW8YbqIiPvRmTPlcWVTV7e2OHJZ9uOEyTf8wHUOhYtnKOlsSHqpk/lwNomxLN12jjd
 OP+13jiWEl6CWYIU8m+iM8YH8H6u+eJKtCmgyh/VJOIMO9PRhipECNNGyx0+arrGx7q03oY
 NCZ+h+v142vO2a1guSQrj7cpwtOJk4VzNcCbcr4IkwcLikPi7avExN2cQtMYKwdqc6cD4Ru
 PjJf6FH10k27RfjJPrVCiXUgrTR2vub30B275p+R0YghcvjcE6ocpOOHZmEZw8RTf+bM4y/
 /a1B4RZSi4j8CiIlKZaorw166sir6Q8P98/5Br9xYdxYZzMrpX8I9w0b2GxfRkwqBkLUcui
 7cDrkW3v8xTWuRs6zH3VvKecECHId5ksO6N8xdwENHk8ZG3fDEoju2lKfieBs01N+mM1EbY
 l+QOJIjQnFPOP9DnBfTw/D9pq12mixSeMZMsS390jzTGlyCAW+wq5ccOb0X7qgsg/2GkAt/
 OsWjRiUOIZJIF2cMhezLLJWcy7FTDJCt2ooxcO7MPW4S3FryyVjJQb4LqwWsxhfgL1jGCnQ
 75I0Z/N8dU4+R3PbHJOKVkU1EgG/QnzcRRnJnB4utTEHFXyM5ZiffOBFT5Wfekk/5WSLquQ
 sQBpx3/6etyJGYB9Ma1keURrcR2jqiHNNgDpkyEbjW/ckJNMnyCbU0QForLUQOJ/ykV7WJz
 Bezs7EIx5KinjJhpyCxqaGWqjDQoeboglqYVAA7DO+aauGY+dgbMZjjXwtVCNZAAfWf3KHJ
 wavofMkW352gqehQQ4SUE35GzCxuN76G6Tfji8A9R95+KZwmMNGWW9827zQgoACL31qyMyT
 Q0QKK7zOrBi3h0BMU31xW1pFr2XcL1EUEjkZcvLeQFXK8GjzXy1V4KrRSbIJtWoT/7NpMFf
 Qh4HEnciwEIQkOo1KhnWVXPEo4+5uUFdUkSEJE2c4vojC/uKo7jkBipssa/IcqNNVWk1OWI
 PcdDRBC8xrmlw7uPnnHjrfmXZWEe1ehdVXicfn4HlN1Ys7bvgh+BaGWvTozUUo/1Fk205WX
 Q==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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

The e56 PHY RXS ring equalizer/tap configuration is written to the
wrong bit field: set_fields_e56(&rdata, 9, 4, 0x366) targets the
unrelated lower bits, so the configured tap values are never applied
and the equalizer stays at its default setting, which can degrade
the received signal on both the 40G and 10G paths.

Fix the field range to (21, 12), so the equalizer/tap configuration
takes effect.

Fixes: f7cfc21e9f75 ("net/txgbe: fix link stability for 40G NIC")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_e56.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/base/txgbe_e56.c b/drivers/net/txgbe/base/txgbe_e56.c
index cbcc05333e..2711863f2c 100644
--- a/drivers/net/txgbe/base/txgbe_e56.c
+++ b/drivers/net/txgbe/base/txgbe_e56.c
@@ -423,7 +423,7 @@ u32 txgbe_e56_cfg_40g(struct txgbe_hw *hw)
 
 		addr  = E56PHY_RXS_RINGO_0_ADDR + (E56PHY_RXS_OFFSET * i);
 		rdata = rd32_ephy(hw, addr);
-		set_fields_e56(&rdata, 9, 4, 0x366);
+		set_fields_e56(&rdata, 21, 12, 0x366);
 		wr32_ephy(hw, addr, rdata);
 	}
 
-- 
2.55.0.windows.2

