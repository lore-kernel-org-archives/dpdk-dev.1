Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759EFCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 17:22:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B57E542D8C;
	Tue, 29 Sep 2026 19:22:55 +0200 (CEST)
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net
 [31.44.12.176]) by mails.dpdk.org (Postfix) with ESMTP id 564FB4026E
 for <dev@dpdk.org>; Tue, 29 Sep 2026 19:22:51 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:4021:0:640:30fc:0])
 by forward100b.mail.yandex.net (postfix) with ESMTPS id 820EC8093C;
 Tue, 29 Sep 2026 20:22:49 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id CMmjX34iT4Y0-XaDDhph7; 
 Tue, 29 Sep 2026 20:22:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1790702569; bh=uAIxoFwBUFwLn8IvKz/QryeghJpNaDIZD95tojyfacc=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=YKuK+bCaNb+9oygU3SuXZJT6fsGrzVolJDO5h4aUmV9v99pZssa/bY14krR9HJ+DZ
 uakIZOfp0X5Xegrt4Dpjcl9L0PNNdZnS4Dmv26Xb75FswhMGuuscQs6O0OiWV86BoZ
 bLcVd650ZF9PCY53XhbfLffGmOiJVbP/i3mGsdVI=
Authentication-Results: mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 0/2] ethdev: fix SFF-8472 external Rx power calibration
Date: Tue, 29 Sep 2026 19:22:08 +0200
Message-ID: <20260929172210.1212967-1-roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
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

The SFF-8472 decoder does not apply the external Rx power calibration
as defined by the specification: the fourth order polynomial is reduced
to RX_PWR(0) + x * (RX_PWR(1) + RX_PWR(2) + RX_PWR(3)) and RX_PWR(4)
is never used. The code came from ethtool sfpdiag.c.

This was pointed out by Stephen during the review of the module EEPROM
decoding series; this series is based on it (dpdk-next-net).

Patch 1 fixes the formula and is intended for stable.
It also clamps the result to the 16-bit range, as the polynomial
easily overflows it with unexpected coefficients and converting
an out of range double to an integer is undefined behavior.
Patch 2 adds a unit test with all coefficients set.

Note: the calibration formula 1 (Tx bias, Tx power, temperature,
voltage) has the same out of range conversion issue; it is left
for a separate patch.

Depends-on: series-39436 ("ethdev: add API to decode module EEPROM")

Roman Khromenok (2):
  ethdev: fix SFF-8472 external Rx power calibration
  test: check SFF-8472 external Rx power calibration

 app/test/test_ethdev_module_eeprom.c | 37 ++++++++++++++++++++++++++++
 lib/ethdev/sff_8472.c                | 27 +++++++++++++-------
 2 files changed, 55 insertions(+), 9 deletions(-)

-- 
2.47.3

