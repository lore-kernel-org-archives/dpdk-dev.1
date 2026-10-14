Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADCDCC6B24
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 07:13:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13AAE402A4;
	Wed, 14 Oct 2026 09:13:32 +0200 (CEST)
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net
 [51.250.60.163]) by mails.dpdk.org (Postfix) with ESMTP id 2A58D40272
 for <dev@dpdk.org>; Wed, 14 Oct 2026 09:13:30 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-17.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-17.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:5a3:0:640:5b8e:0])
 by forward103d.mail.yandex.net (postfix) with ESMTPS id 78001C0824;
 Wed, 14 Oct 2026 10:13:27 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-17.klg.yp-c.yandex.net (smtp)
 with ESMTPSA id uCORNqZtq0U0-LNHlRc67; 
 Wed, 14 Oct 2026 10:13:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1791962006; bh=Gth8e+uU8fAxu/EAOVJK9VyC5G4uJSim+3BF+oCgi1A=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=N1sl0MowPWkdHpKeW88iV+JAeIgxlWScL25Jq3iDGEbixa0FSrr5bBtahZLMV1vfr
 SZNAy68M2Ew679tgvPG+0SIG9xNjvrNQPXS6S15NJpIdTA/Sw1WkcgXPGKy2Lv0+1W
 yeI8TJ+RjKyLMP699fcC/pjfnZjoHmkSuO1EiJxo=
Authentication-Results: mail-nwsmtp-smtp-production-main-17.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 stephen@networkplumber.org
Subject: [RFC 0/2] move module EEPROM decoding to a transceiver library
Date: Wed, 14 Oct 2026 09:12:43 +0200
Message-ID: <20261014071245.2323258-1-roma55592@yandex.ru>
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

As discussed in the module signal status flags thread [1], the SFF
module EEPROM decoders do not depend on any device or driver, and
they are also useful for ports which are not ethdev ports, such as
kernel ports read with the ethtool ioctls.

This RFC moves them from ethdev to a new transceiver library:

- lib/transceiver/ has the SFF-8079, SFF-8472 and SFF-8636 decoders,
  moved with git mv, and a new rte_transceiver_decode() API.
  It does not include rte_ethdev.h: the module types and the callback
  type are defined by the library, with the same values as the
  RTE_ETH_MODULE_SFF_* types, which is checked at build time.
- ethdev depends on the library, as it does on net and meter.
  The telemetry command /ethdev/module_eeprom calls it, and
  rte_eth_module_eeprom_parse() is kept as a wrapper, so the API
  added in 26.11 does not change.
- The tests move to transceiver_autotest, with one test of the
  ethdev wrapper.

Questions for this RFC:

1. Name: "transceiver" is used here as it is self-explanatory;
   "xcvr" would be shorter.
2. Should rte_eth_module_eeprom_parse() stay as a wrapper,
   or be deprecated in favor of rte_transceiver_decode()?

The next step would be CMIS (QSFP-DD, OSFP) decoding in this library,
starting with the lower page and page 00h, which are read like the
SFF-8636 ones and need no ethdev API change.

Release notes will be added when the 27.03 release notes exist.

The pending series 39575 (dpdk-proc-info module EEPROM decode)
is independent of this one.

The series is based on next-net/for-main and depends on the module
EEPROM decoding series already applied there:

Depends-on: series-39436 ("ethdev: add API to decode module EEPROM")
Depends-on: series-39480 ("ethdev: fix SFF-8472 calibration overflow")
Depends-on: series-39555 ("ethdev: report module signal status flags")
Depends-on: series-39580 ("ethdev: decode newer SFF compliance codes")
Depends-on: series-39579 ("test: check newer SFF compliance codes")

Tested with gcc, and clang with ASan and UBSan: builds without
warnings, transceiver_autotest passes, the documentation builds
without warnings, and the telemetry command decodes a module.

[1] http://mails.dpdk.org/archives/dev/2026-October/348102.html


Roman Khromenok (2):
  transceiver: introduce module EEPROM decoding library
  test/transceiver: move module EEPROM decoding tests

 MAINTAINERS                                   |   7 +
 app/test/meson.build                          |   2 +-
 ...dev_module_eeprom.c => test_transceiver.c} | 138 +++++++++++-------
 doc/api/doxy-api-index.md                     |   1 +
 doc/api/doxy-api.conf.in                      |   1 +
 doc/guides/prog_guide/index.rst               |   1 +
 doc/guides/prog_guide/transceiver_lib.rst     |  83 +++++++++++
 lib/ethdev/meson.build                        |   6 +-
 lib/ethdev/rte_ethdev.c                       |   9 +-
 lib/ethdev/rte_ethdev.h                       |   3 +
 lib/ethdev/sff_telemetry.c                    |   7 +-
 lib/meson.build                               |   2 +
 lib/transceiver/meson.build                   |  11 ++
 lib/transceiver/rte_transceiver.c             |  24 +++
 lib/transceiver/rte_transceiver.h             | 102 +++++++++++++
 lib/{ethdev => transceiver}/sff_8079.c        |   2 +-
 lib/{ethdev => transceiver}/sff_8472.c        |   0
 lib/{ethdev => transceiver}/sff_8636.c        |   4 +-
 lib/{ethdev => transceiver}/sff_8636.h        |   0
 lib/{ethdev => transceiver}/sff_common.c      |  28 ++--
 lib/{ethdev => transceiver}/sff_common.h      |  10 +-
 21 files changed, 353 insertions(+), 88 deletions(-)
 rename app/test/{test_ethdev_module_eeprom.c => test_transceiver.c} (82%)
 create mode 100644 doc/guides/prog_guide/transceiver_lib.rst
 create mode 100644 lib/transceiver/meson.build
 create mode 100644 lib/transceiver/rte_transceiver.c
 create mode 100644 lib/transceiver/rte_transceiver.h
 rename lib/{ethdev => transceiver}/sff_8079.c (99%)
 rename lib/{ethdev => transceiver}/sff_8472.c (100%)
 rename lib/{ethdev => transceiver}/sff_8636.c (99%)
 rename lib/{ethdev => transceiver}/sff_8636.h (100%)
 rename lib/{ethdev => transceiver}/sff_common.c (95%)
 rename lib/{ethdev => transceiver}/sff_common.h (96%)

-- 
2.47.3

