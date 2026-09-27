Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3ED5C9832F
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 07:02:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBB7340E39;
	Mon, 28 Sep 2026 09:00:25 +0200 (CEST)
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net
 [178.154.239.84])
 by mails.dpdk.org (Postfix) with ESMTP id 4543E400D6
 for <dev@dpdk.org>; Sun, 27 Sep 2026 13:20:55 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0f:39a:0:640:15c4:0])
 by forward101a.mail.yandex.net (postfix) with ESMTPS id 6ACEF80C00;
 Sun, 27 Sep 2026 14:20:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id kKeTQKZfsSw0-9FIPPDPP; 
 Sun, 27 Sep 2026 14:20:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1790508054; bh=smxAP8+aletm0O2fHDc7e9LX/WiMPtodHNXm5U7XEng=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=Z80u0XBDbfdEmd1fkZzlTO/8ujyAOC/TAQZFNoAQ2boR02NvOfeAFU2Ou+/JObOY1
 e7ObART3vqCHJQftFN5S7xcMP92NPXI3zQHaaHQ3xUkCmkdz/FLWupVPFcL17NJgdy
 ch0TiOTMgPD+P1F10zUu94EaF/649R7VaOwcsSvE=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 0/4] ethdev: add API to decode module EEPROM
Date: Sun, 27 Sep 2026 13:20:37 +0200
Message-ID: <20260927112041.775972-1-roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:59:12 +0200
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

Since 22.07, ethdev contains SFF-8079, SFF-8472 and SFF-8636 decoders
for plugin module EEPROM (SFP, QSFP), ported from ethtool.
They are reachable only through the telemetry command
/ethdev/module_eeprom, which reads the EEPROM of a DPDK port
and returns the result as a telemetry dictionary.

An application which needs to show transceiver information
(vendor, part number, serial number, optical power) in its own
interface cannot reuse this code and has to duplicate it.
It is also common to have some ports managed by DPDK and others
by the Linux kernel; the kernel returns the EEPROM through the ethtool
interface with the same module types and layout, but there is no way
to decode it with DPDK.

This series exposes the decoders through a small experimental function:

  int rte_eth_module_eeprom_parse(uint32_t type,
          const uint8_t *data, uint32_t length,
          rte_eth_module_eeprom_field_cb cb, void *arg);

Each decoded field is reported to the callback as a pair of strings,
the same names and values as in the telemetry output.
The function does not access any device and does not require
EAL initialization.

Patch 1 makes the decoders write to a callback instead of
the telemetry dictionary; the telemetry output is unchanged.
Patch 2 adds the buffer length checks needed by a public API:
currently SFF-8079 and SFF-8472 decoders do not receive the length.
Patch 3 adds the API with documentation and release notes.
Patch 4 adds unit tests.

Roman Khromenok (4):
  ethdev: decouple SFF module EEPROM decoders from telemetry
  ethdev: check module EEPROM length before decoding
  ethdev: add API to decode module EEPROM
  test: add ethdev module EEPROM decoding tests

 .mailmap                                |   1 +
 app/test/meson.build                    |   1 +
 app/test/test_ethdev_module_eeprom.c    | 285 ++++++++++++++++++++++++
 doc/guides/prog_guide/ethdev/ethdev.rst |  44 ++++
 doc/guides/rel_notes/release_26_11.rst  |   7 +
 lib/ethdev/rte_ethdev.c                 |  20 ++
 lib/ethdev/rte_ethdev.h                 |  50 +++++
 lib/ethdev/sff_8079.c                   |  20 +-
 lib/ethdev/sff_8472.c                   |   2 +-
 lib/ethdev/sff_8636.c                   |  22 +-
 lib/ethdev/sff_common.c                 |  14 +-
 lib/ethdev/sff_common.h                 |  14 +-
 lib/ethdev/sff_telemetry.c              |  94 +++++---
 lib/ethdev/sff_telemetry.h              |  25 ++-
 14 files changed, 525 insertions(+), 74 deletions(-)
 create mode 100644 app/test/test_ethdev_module_eeprom.c

-- 
2.47.3

