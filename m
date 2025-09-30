Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72A6CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 10:02:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABE7840DCB;
	Tue, 30 Sep 2025 12:01:14 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id 665A040ED3
 for <dev@dpdk.org>; Tue, 30 Sep 2025 12:01:12 +0200 (CEST)
X-QQ-mid: esmtpgz13t1759226466tf45d875d
X-QQ-Originating-IP: ivnSXICBGpUW6OrFupakm+gpGl1Hzy6Sv2mK+qYXl+A=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.164])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 30 Sep 2025 18:01:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5034430558205167727
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v4 20/20] doc: update for txgbe
Date: Tue, 30 Sep 2025 17:59:52 +0800
Message-Id: <20250930095953.18508-21-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250930095953.18508-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250930095953.18508-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NJ9rhV+1Ugrh49xN3tAyifElDRi+oK41cxWUCkE/QVbl2iWf3gxJN8yc
 du8BAnjuthrEHOPtet8huTql3eT0uCic9utsLQlChNTM9iKzXqhZ2oAyDQQTxgiYWAHtYbE
 Om3Y9C4ffn+MCPiSgMHs9Y/JEI/K0G8v4uKeYznV7XFOxQ2CLLeCeSrZbkN5DpC+qBpKwjs
 qTMbXrKV7HKwBlLamljuBpPR2D9xLGJAJ331NhO1aIvbT2+xEM/mwsVltyislb2UYsXwGIN
 mjPRWsZjt23LykUS46MNGGACSBRVeBy9tGsRYzIMg5ZVU2x+3Q5g2HA3kp1To52p5uKOwFE
 45SVxpeOH3cQBxBSkj60Sle9bdSEvM6fiN3ueiW14fPdysgsnR4s539H6H9exZlDlZbKkqx
 yQ/9Lp7vVblCvHwZUh1N3aqijqSlc6krF8yBsoyuPsvmUwu+CS+OxMqWhPiq9o7ECPfHkTY
 Llw8HyMCUXNlzsjF3ZlQ/WokSVLbK1VTJXwmR40d7utvPv+umKknnOdObzosPjgBkKEdXm9
 NfO0eonFpd2RMSc+ag2MlaeNTLvqirwg/BtHDHqySx3kvVsXEwTyJYom/bequXbxBRVrXmc
 Sf2A2rxxeuSNksYoYXtiRsHW3kmdt6YU3vMQ0i8hz/b8n+myS10NhAWK5xD0xiZ9MxMNJ7N
 p9ObtYq3mInAa67gCsyPwH7z5vrzneB61WTurveGYv1sIBkw00wcOVZXYrpZn+S0R5u/aXc
 WSovlUG7Qj0oHm3eJpRW1XYWl1NF0SHqOgBmWho6py0eGE6/AaTij1/PHzoEBJO2g8BWpan
 wdiZrCfEibmYcWJyB5xNhhENe1Z5D+L4VTEVojQoFuYFK3+UYO7TItTW+GclZx1YS4uKhXK
 Xn2EW1jR0e39Yel00+yzncjQRIV7nl5LS8jO32gmTQmDs4G478ndHzbvMsFPqSlpWGDadMN
 M6mqJx9MNwZQ0LtJFk2FqowwnzCrq2GB9X2Ehwm49W3oq+FaCUh/wt2AjH6k7HfpMbB67go
 TwGFRFYThhk4nGToGXJ3QWdzgZgWlww0+MAtle8xza76b49CQ65nisL10djW32Me92sPFst
 Q==
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

Add new types of Wangxun NICs(Amber-Lite NIC models) into txgbe
supported NICs list.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 doc/guides/nics/txgbe.rst | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/txgbe.rst b/doc/guides/nics/txgbe.rst
index 93fb592759..e7b657f9a0 100644
--- a/doc/guides/nics/txgbe.rst
+++ b/doc/guides/nics/txgbe.rst
@@ -4,8 +4,12 @@
 TXGBE Poll Mode Driver
 ======================
 
-The TXGBE PMD (librte_pmd_txgbe) provides poll mode driver support
-for Wangxun 10 Gigabit Ethernet NICs.
+Supported NICs
+--------------
+
+- Wangxun 10 Gigabit Ethernet NICs
+- Wangxun 25 Gigabit Ethernet NICs
+- Wangxun 40 Gigabit Ethernet NICs
 
 Features
 --------
-- 
2.21.0.windows.1

