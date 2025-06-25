Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEEAC7EE30
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 12:53:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD33740F16;
	Wed, 25 Jun 2025 14:52:35 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id F2F3A40E4B
 for <dev@dpdk.org>; Wed, 25 Jun 2025 14:52:33 +0200 (CEST)
X-QQ-mid: esmtpsz21t1750855949te638f4f2
X-QQ-Originating-IP: c6fte20klDnDtentnOHVQj9+AP1ycssrz4Z59t77cMI=
Received: from DSK-zaiyuwang.trustnetic.com ( [60.186.80.242])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 25 Jun 2025 20:52:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18311408740715137751
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v2 15/15] doc: update for txgbe
Date: Wed, 25 Jun 2025 20:50:47 +0800
Message-Id: <20250625125047.18072-16-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250625125047.18072-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250625125047.18072-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: M0qzrJwwKu7jJ8jSi7FBRxI/x0Kvcm3KPDJueQDSjcSjScpj26qrUa8v
 LxHTRlcgVHoC8C00q+y3DQ8m/AFVnSWrn52ZRd4DotEUHCPoBTnluKS4fjjmQXsBcNIM2Pu
 dw9ngX0nwqwW9msTQH4tHOTp1BAUuI00cx4q4LH90+NfUicdwxFWIdCgD141+DUNBcSLoHp
 +Zei8SKSswgwwPghWQNBn2rgjpupYqRclG9Z2IxMU7OMo4g+NBh9mZf1Q8TeictfTU7j9Ml
 /Vph40e/Gty1BZ0HsE7yCBi+93ySYPuDYhuU+X6/l1OA6BM+g/dj+RVUae+k9+aSSDu5gZa
 Axm7vgpUrh5BnOlYzTBO+rnk/R9ERV4ex/ZpN6oVUEsnZrX8zUdvXqW4Fk2IHGIreSHdo5p
 TTTkDHujnDk0qS27WBcV8iENhfKErEjMUQaBU4FC+M4XbzANzY4f0dTfP7eJsEXirFGC+Cs
 wMlRnbFTB4rzD8b9MLgOCVdbLmx0ykv/Ve2j6RTvJo7wTtvaJ4FYSgYoGBZrJqF4UNZzguP
 +CYCUJDTnC52fbOmaFdfsfav1gChQifbr8idhX1H1JNmKwFY4ID+/1ROebRANUg1sC6sgCC
 qnRtk0ZzoHlkaicV1qqrKIHHrPiAdUG7eXXg0sot1t6Zw8FaxR2+o0dlhAwGltkB4/06oZN
 vZykJ/nNEnoLoZJuLtDiAIBYTe1K5NTCfYD4L1/muM4VUU+wqIl0AkpCy0FyHllIPN2kyfY
 ByW5RIruJU+Z4gYpwHhZgxeh7MuoLAES9ahI2PiAhIpbNcaVFHKOUXI4hawPkITnt1mq1qp
 Ue8hnZCKOm2ilTtgZEmCeKo9DrFghLOkYPqVghi91tLYGitPlq5Y/fKZu/7OI8pEZN/xXom
 uza3B0WHjEkMKcWynQb7zb1rmboLrnrybBv26ahFPYNdp0ZmLBoPBT8A9rl4tr3ZIZ5DjCE
 5iAIRhiwmgOb3hVbsrhPl5xTdKhHBjB78O2fObRvTUIONLICaUXKWfay7QgW5F6f5GHmGFI
 GePBB0w7oVpllZtXoKkWPEUFuJNgjN0FWgu3+i4Q==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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

Add new types of Wangxun NICs into txgbe supported NICs list.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 doc/guides/nics/txgbe.rst | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/txgbe.rst b/doc/guides/nics/txgbe.rst
index 93fb592759..ccf645d51f 100644
--- a/doc/guides/nics/txgbe.rst
+++ b/doc/guides/nics/txgbe.rst
@@ -4,8 +4,12 @@
 TXGBE Poll Mode Driver
 ======================
 
-The TXGBE PMD (librte_pmd_txgbe) provides poll mode driver support
-for Wangxun 10 Gigabit Ethernet NICs.
+Supported NICs
+--------
+
+- Wangxun 10 Gigabit Ethernet NICs
+- Wangxun 25 Gigabit Ethernet NICs
+- Wangxun 40 Gigabit Ethernet NICs
 
 Features
 --------
-- 
2.21.0.windows.1

