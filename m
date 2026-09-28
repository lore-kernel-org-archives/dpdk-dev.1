Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BD6C9832F
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 08:48:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8678040431;
	Mon, 28 Sep 2026 10:48:01 +0200 (CEST)
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net
 [178.154.239.144])
 by mails.dpdk.org (Postfix) with ESMTP id 17DC44028C
 for <dev@dpdk.org>; Mon, 28 Sep 2026 10:48:00 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:1199:0:640:2d84:0])
 by forward500b.mail.yandex.net (postfix) with ESMTPS id E184DC2908;
 Mon, 28 Sep 2026 11:47:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id klcb2Uifv8c0-TpAx4XSz; 
 Mon, 28 Sep 2026 11:47:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1790585278; bh=LTI1Tt0jsw1Y8jFU/UdyTW9W49rdnQfl15gDJ/d9B84=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=g5xTZ8VSkkkejnqh7H/7Pf7KMJ9uI18Gc44iTve1N5imWYr6VsGQeOutE3riCu8dG
 Qx5d5OH0uv4Pk7tRQVBTfR7tQ2eGRKA8LMi+peuxFjlZ/h8CoHe/tj3WsnWTPtyVdD
 mBSRIxmeJryX/ckplJxkm7FyaXcDuqtgcomEGCGg=
Authentication-Results: mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 0/4] ethdev: add API to decode module EEPROM
Date: Mon, 28 Sep 2026 10:47:25 +0200
Message-ID: <20260928084729.973192-1-roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260927112041.775972-1-roma55592@yandex.ru>
References: <20260927112041.775972-1-roma55592@yandex.ru>
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

v2:
- patch 2: do not read the SFF-8636 alarm and warning thresholds
  from page 03h when only 256 bytes are available (out of bounds read
  found by ASan in the new unit test).

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
 lib/ethdev/sff_8636.c                   |  74 +++---
 lib/ethdev/sff_common.c                 |  14 +-
 lib/ethdev/sff_common.h                 |  14 +-
 lib/ethdev/sff_telemetry.c              |  94 +++++---
 lib/ethdev/sff_telemetry.h              |  25 ++-
 14 files changed, 552 insertions(+), 99 deletions(-)
 create mode 100644 app/test/test_ethdev_module_eeprom.c

-- 
2.47.3

