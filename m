Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACCFCA600A
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 08:23:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CAE24027B;
	Thu,  8 Oct 2026 10:23:40 +0200 (CEST)
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net
 [51.250.60.161]) by mails.dpdk.org (Postfix) with ESMTP id CFD5A40274
 for <dev@dpdk.org>; Thu,  8 Oct 2026 10:23:38 +0200 (CEST)
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net
 [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
 by forward101d.mail.yandex.net (postfix) with ESMTPS id CDF82C00F9;
 Thu, 08 Oct 2026 11:23:37 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c22:d15:0:640:87c2:0])
 by forward103a.mail.yandex.net (postfix) with ESMTPS id B630480720;
 Thu, 08 Oct 2026 11:23:37 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id UNJ0VOBd8Cg0-j5vSItzA; 
 Thu, 08 Oct 2026 11:23:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1791447817; bh=tV0Oye/ekUQE6bokLZFdXraMH1j9nLRklozPSfgDeB4=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=rh+F4mowbPNDGhTPnZIUYjpIoX5mijMgfpvOZTaEBKTPNAnIFu1QvQp2LbMeLIQ6G
 1qNLBxUMsGDR4KFsT/RgO6nYDE/XXWmiS+f30Lzo6iUQUQoXrUHKNT5hOt9vLgPYFf
 i6PSnqxP3/DjJNiiiS+MO+OIB7bb4NJSojLalssg=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 stephen@networkplumber.org
Subject: [PATCH 0/4] ethdev: report module signal status flags
Date: Thu,  8 Oct 2026 10:23:22 +0200
Message-ID: <cover.1791447600.git.roma55592@yandex.ru>
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

The module EEPROM decoder shows the identity and the digital
diagnostics of a module, but not the signal status, which is
usually the first thing to check when a link does not come up.

Patches 1-2 report the SFF-8636 per-lane loss of signal,
CDR loss of lock and Tx fault flags, as ethtool does since
commit 045d8db ("sff-8636: report LOL / LOS / Tx Fault").
The code is written for DPDK, not copied from ethtool.

Patches 3-4 report the SFF-8472 Rx_LOS and TX_FAULT state
from page A2h byte 110. ethtool does not show it, so it is
split out and can be dropped independently of patches 1-2.

The SFF-8636 flags are latched and cleared on read,
so they report the events since the previous read;
the SFF-8472 bits are the current state of the pins.

The series is based on next-net/for-main. It extends the same
release notes entry as the testpmd patch 170851 ("app/testpmd: add
command to decode module EEPROM"), so whichever is applied second
needs a trivial context fixup there.

Roman Khromenok (4):
  ethdev: report SFF-8636 lane status flags
  test: check SFF-8636 lane status flags
  ethdev: report SFF-8472 Rx LOS and Tx fault state
  test: check SFF-8472 Rx LOS and Tx fault state

 app/test/test_ethdev_module_eeprom.c   | 117 +++++++++++++++++++++++++
 doc/guides/rel_notes/release_26_11.rst |   3 +
 lib/ethdev/sff_8472.c                  |  16 ++++
 lib/ethdev/sff_8636.c                  |  35 ++++++++
 lib/ethdev/sff_8636.h                  |  12 +++
 lib/ethdev/sff_common.c                |  25 ++++++
 lib/ethdev/sff_common.h                |   2 +
 7 files changed, 210 insertions(+)

-- 
2.47.3

