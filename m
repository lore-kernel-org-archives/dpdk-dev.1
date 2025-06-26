Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51540C7115B
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 08:11:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5B134275B;
	Thu, 26 Jun 2025 10:10:00 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id F310240ECF
 for <dev@dpdk.org>; Thu, 26 Jun 2025 10:09:57 +0200 (CEST)
X-QQ-mid: zesmtpsz9t1750925393t7108ec0a
X-QQ-Originating-IP: ILob/Rqjbi0ZA5YthvSCZzNArJE173NhaF+Z4/KV5ug=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.27.0.255])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 26 Jun 2025 16:09:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7567884965860849541
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v3 15/15] doc: update for txgbe
Date: Thu, 26 Jun 2025 16:02:20 +0800
Message-Id: <20250626080221.22488-16-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250626080221.22488-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250626080221.22488-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NlS/C0FXcHUSGqjytOKzzvika4QiRcgxVr9B1WHqga3Ci5MLFEEicpA4
 QEtmVPX98WMrCuvTNLhoMmocSHHvzBT1RypraiOZVpi2H7WIc/keiqKbL8YwV9ncH9X8wdG
 OjufTpD4BZtalmteQo8cv3twY+K58gLbSs/6KCCjvU5jffjSsgTB3OopCQZQW91bjNRvbgK
 IutJDt2rjGHqKWOiH4ziVY5XPXwhdsxdJCc39Vxn968cEQFsdqGHVMZ9l1mP/6uBPLRHdjU
 1SsoJ/LfQGZKeZ3FspbwzWAGs+MVaTlOkuNDdoJKI0g2EVaWpRXqP4C6GtUyL+wehFRsY6Y
 78wrrHE6nDPSaohIGR5LY+FdBFnpx1cvLHpQ2Q66M/vTkHcBlnQUBLLwAFpgiCeu0q+Zfbx
 jBIDUu+rnvwcH6jIiCzAByynk9SXQg83Q5PGHX0dddAqNXv7GocVyHcy2emw3/gcTnE0Uip
 CDThjYjtXNYgHJ6CMmVNDJBzlYVbQl1mF4U/ltgNTDZnJi1yELKpowtypO5M7KBdBsPiIya
 ENiNA1yKPf2dCuGargmLmv/wX9HWvENPaqyJRVDD5wxKMc5LWMUKRO1QnFygiPL/BD7jdKu
 kRXDJaKy7LZNkKRX9dmqIaR4a/w8+VyWouoFy7Myj18IHdD4dDOboW4AnTIWNznTlogq2FU
 Ye0Jdg2Ba7tNsF6fxYwj391F+1M2lyfGM5JVR+EVRVsxHr7wJ4svRyAvk7ZV+6Pz8GbR8DP
 eWGiZz2Jt4TsJxrlg0eIEnilG4XMO3F5SiHhz97YTPLFE++kg+746tHCWGCm2Z3Rkm5ckrW
 hS3fHtyNAOvshHSL79XSjSoaFBzH8gb8xmpUxlaI/mjWnrW5lkfBLntCxt4X8Hck1aKvr4L
 VjIK2eftyTbWf80YJ2GkeL9f2BV1q3xhIVji77DjRAZkbpwNHgypPv0UCsQCQ+JfK73AQrZ
 6WrLlcF+kkr6lOZAYlSyWPjI3GctJ+g1+8z5nXuALzKm3BsjPZjswC0AxX+tuP2EnsdKdT5
 upIlf+M5CvT4Puegw3BiindpP7hM35G7ao1oSY9kmtgaQkYHu5rDmlZsSxX7+16FODMve+X
 w==
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

