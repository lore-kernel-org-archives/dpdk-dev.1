Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E579C369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 09:41:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91C45400D6;
	Fri, 18 Apr 2025 11:41:47 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id 918D4400D5
 for <dev@dpdk.org>; Fri, 18 Apr 2025 11:41:43 +0200 (CEST)
X-QQ-mid: esmtpsz20t1744969298t7b37f53e
X-QQ-Originating-IP: zRSJ7tNt+ak2FLm6WTpxJNEf95iC0l6h6415GRi34M4=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.64.252])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 18 Apr 2025 17:41:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10364503122513548306
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH 0/2] *** Wangxun new NIC support ***
Date: Fri, 18 Apr 2025 17:41:28 +0800
Message-Id: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MxFGxfvJcqjGheEYlEPQLoUJY/SRdMoGjr3iWAUFLXVZndwG1qvDF0UI
 BMR7TKQPM7iZHJ4eWjRqoQfkt9kxsCxLVu/lE36jP3qtKADqhCVQe30bfIkDUEs3gqLovGZ
 rWJ1JbXzhQIk101W4HANLAGGLXB4NpXvrGuWAyBGQo1e/QxDhFiMu/PcUTx8P2WzrHrG4EM
 sf4W5gKO/scNGGQ7woTVB2F0rQOT1smBV9zo85qXBmlK+DFlGzNGtJXjCi7W6L0Dd+pMw5L
 slPoBktg8utHgSsSBluKuxdUkY7GswVDo1ohfn1rOjQNCJsSLcFgn9mNBMhibvIrgowGwkN
 JfQR/DIXrKhunc/HOnqXDw6cS7ldMeAafUN8DG8DZjPL8l2A7bVR04/QQwmv3wgrDVn8TJ9
 tjr9hFkkMb9NUI3NkFLP/skRv+7w8FK4Kngj32ooiP/TYKiQoAeHndrO6wjlkVsfwY5BNoB
 BSG4opb4/lYjQe/HSudt75gO9gFyiM5zV15JLQhX88aZrAppK4Ppxaoc49XFpVpL3p3RH+Q
 mGHmdOGV5Zb9SRoIBX8OL+0ncQpn/DWR8evj1QV7N/pLeMtgFEndylHIzEWqS1jELudQbw4
 uDUvZPs1MQQQeq4IJVRJnUE5KHJMju6BgEjGYo6wV0ZfJFsr69QG9Q7frjlRG6jwYj7FfWl
 po/1RqYp4FEiMTz0G9jPmvDbj7vmIZlFYHG/y03NIvMGp0OriFQPT8GmBQDmHOuZm9mdNt7
 YMjGST19BKFpkBVEVDnnrjCOBKr5DtBpjzLFxrayT3zokTHwj0eFvc5njOSwe2BDprEQj9D
 9w8CVnb7E0ncQlWE17pBpgAwYtjAt+x2L/NpRE0MCqHmtS6AGxhQMtYI6cUmHISGe4UdV0E
 uh0qbJS8yU1DmwF4IIK/UtswmiKjqF3PU0LL0UQISJQhtnd5iYsDzuXbutqodciPShYZlDA
 7PozNZZi8OqaJN7Ux+9ptVslcooK5MZxCpP6S3a9QCia/Git81Z9dBSk2cC0fMKm+tRo7iq
 XNw5DHVQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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

We have released a new NIC series: Amber-Lite, with two models supporting
10G/25G and 10G/40G rates. Due to minimal hardware differences from 
existing 10G NICs, it remains supported within the txgbe driver.

Zaiyu Wang (2):
  net/txgbe: add support for Wangxun new NIC Amber-Lite 25g/40g
  net/txgbe: add basic code for Amber-Liter NIC configuration

 drivers/net/txgbe/base/meson.build    |    4 +
 drivers/net/txgbe/base/txgbe_aml.c    |  345 +++
 drivers/net/txgbe/base/txgbe_aml.h    |   11 +
 drivers/net/txgbe/base/txgbe_aml40.c  |  196 ++
 drivers/net/txgbe/base/txgbe_aml40.h  |   11 +
 drivers/net/txgbe/base/txgbe_devids.h |    9 +
 drivers/net/txgbe/base/txgbe_e56.c    | 3371 +++++++++++++++++++++++++
 drivers/net/txgbe/base/txgbe_e56.h    | 1784 +++++++++++++
 drivers/net/txgbe/base/txgbe_e56_bp.c | 2238 ++++++++++++++++
 drivers/net/txgbe/base/txgbe_e56_bp.h |   13 +
 drivers/net/txgbe/base/txgbe_hw.c     |   23 +-
 drivers/net/txgbe/base/txgbe_hw.h     |    2 +-
 drivers/net/txgbe/base/txgbe_osdep.h  |    4 +
 drivers/net/txgbe/base/txgbe_phy.h    |   17 +
 drivers/net/txgbe/base/txgbe_regs.h   |   25 +-
 drivers/net/txgbe/base/txgbe_type.h   |   36 +
 drivers/net/txgbe/txgbe_ethdev.c      |   35 +-
 17 files changed, 8110 insertions(+), 14 deletions(-)
 create mode 100644 drivers/net/txgbe/base/txgbe_aml.c
 create mode 100644 drivers/net/txgbe/base/txgbe_aml.h
 create mode 100644 drivers/net/txgbe/base/txgbe_aml40.c
 create mode 100644 drivers/net/txgbe/base/txgbe_aml40.h
 create mode 100644 drivers/net/txgbe/base/txgbe_e56.c
 create mode 100644 drivers/net/txgbe/base/txgbe_e56.h
 create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.c
 create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.h

-- 
2.21.0.windows.1

