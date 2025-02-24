Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63C8C021A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 10:03:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3667140A6F;
	Mon, 24 Feb 2025 11:03:51 +0100 (CET)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id 44FC5406BA;
 Mon, 24 Feb 2025 11:03:48 +0100 (CET)
X-QQ-mid: bizesmtpsz5t1740391426trn69l4
X-QQ-Originating-IP: mXM07E1z8WB2wETpWTWfFSLYKrSUTP5sv8ZLS1CT7No=
Received: from DSK-zaiyuwang.trustnetic.com ( [218.72.40.164])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 24 Feb 2025 18:03:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14778325907079984156
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: stable@dpdk.org,
	Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH 0/2] Wangxun bug fixes
Date: Mon, 24 Feb 2025 17:59:06 +0800
Message-Id: <20250224095910.27384-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NQzH8pzEc5hGpXyVxJwNIiJdxRN+th01IwitT64U6IMTxTTE0JCqkidL
 2mrZo/ACG0uhvANOc5a/q82D99wSJ72/2kAcx52tlFHkouKVGvgZ6vUqwadp+He/7qq13d3
 PtvH5336E6QMmzXZVhmJuraLheUns9txN0tTtw+xEJ9CnPQKYP5iQTLpLUS9ZCv5otgse3d
 Mb9FGShIho+AVzFYvmGrtyrIoz5id/MH+cbOLteyQMlswc5tN1QCHny4leGfD5lPmfkH9Vq
 qI23+NFZ3pZkavklVsTVmJA1UV45orTOs6wlgFdRJvZOzx1lFDRW+1mLzalpzTRGo0fSE5O
 5hmkS4BTMQlBy42mfgCzpMoG77UfajHqYgaKSFHQ3e3L8tegzKECDMxe3tsjgkEadW00EKb
 Gu2lOk+Ug8dZr2U3ONs0r4QuCn0FrH2SIQoD8chP+0JkkZxkgDDbL/hEJSCldy9dl8cLUMF
 ImGOPmTHTHFHxvYIMLsYtaWj6MhaqsNwfrdLWzqYBuE3xrhqH90i4B5Qg478Zd8TxHIQVSD
 hqdFhY//k1eQB2leSi646jsvVGzHlpW9hJm1cwq/MPtiegaghVskYQ8r34QIAmuilrLA5cN
 riw/4q25yAEuLYSm2ETqjXlA7TetKSnQh4Ro/rSJATyJBpdNHwbtuMlBh3FfDwCkgg5TceQ
 WyUo2Z1nenzgRQV9z0hNK3Ydda1OT6EwwWXh51mOmhVWCMs26ECAupxKczITxxBDZJdhBe4
 LYRdFd2qFehtN9nbrguiLrLRUZV8oAEln4OMvlV17ma3+KklrYRmidFqMaWx5TmLTsXlaOm
 M7X5SUq/KkKHlwbbgU5UMTcXACD8QjbytdJVGefA4eRxQmn9JVlC3Gigoo7mgZ8+g99mJbM
 K/xZDfnAO+CLfa5N1g0C+JUdbRWNxa00mEKJH3P0mv8uniGZNkBycoNmxwwkVoxPGAmuxPy
 z5FyRO6l1EnknRDq+acrEQGDAEt9lKT61Pns=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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

Fix some bugs for txgbe and ngbe.

Zaiyu Wang (2):
  net/ngbe: fix WOL and NCSI capability error
  net/txgbe: remove meaningless choice for SW-FW sync

 drivers/net/ngbe/base/ngbe_hw.c    | 8 +++++---
 drivers/net/txgbe/base/txgbe_phy.c | 8 ++------
 2 files changed, 7 insertions(+), 9 deletions(-)

-- 
2.21.0.windows.1

