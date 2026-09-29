Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDF2CA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 07:08:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 753AD40276;
	Tue, 29 Sep 2026 09:08:10 +0200 (CEST)
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net
 [178.154.239.81])
 by mails.dpdk.org (Postfix) with ESMTP id 99D9B4013F
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:08:08 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:290e:0:640:f317:0])
 by forward501a.mail.yandex.net (postfix) with ESMTPS id 351EB82D3C;
 Tue, 29 Sep 2026 10:08:07 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id a7cWxixi4iE0-0egYwEJc; 
 Tue, 29 Sep 2026 10:08:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1790665686; bh=EGET107tep3oGozIZUKRQ4uoF3ijswIa0u3bP1EylJk=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=etQq1DqGliami7zHw3vpZhYPO1aMjhT8RM2GbmA9zHf3ZSD/sZvoMFWiCKKU9Sipj
 GRtOQkVABPwntTROXgGetzH/nlL/TFdzBTstDIzHK4N09lRgs20oxXwpn2DaIUlGYl
 QuTcbmsNzR9xKSCvipIsLN9nnJG5FnFKPJ6AzbI0=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 0/6] ethdev: add API to decode module EEPROM
Date: Tue, 29 Sep 2026 09:07:28 +0200
Message-ID: <20260929070734.1106134-1-roma55592@yandex.ru>
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
for pluggable module EEPROM (SFP, QSFP), ported from ethtool.
They are reachable only through the telemetry command
/ethdev/module_eeprom, which reads the EEPROM of a DPDK port
and returns the result as a telemetry dictionary.

An application which needs to show transceiver information
(vendor, part number, serial number, optical power) in its own
interface cannot reuse this code and has to duplicate it.
It is also common to have some ports managed by DPDK and others
by the Linux kernel; the kernel returns the EEPROM through the ethtool
ioctls with the same module types and layout, but there is no way
to decode it with DPDK.

This series exposes the decoders through a small experimental function:

  int rte_eth_module_eeprom_parse(uint32_t type,
          const uint8_t *data, uint32_t length,
          rte_eth_module_eeprom_field_cb cb, void *arg);

Each decoded field is reported to the callback as a pair of strings,
the same names and values as in the telemetry output.
The function does not access any device and does not require
EAL initialization.

Patch 1 fixes an out-of-bounds read in the telemetry command
and is intended for stable.
Patches 2 to 4 prepare the decoders to be called by applications.
Patch 5 adds the API, patch 6 adds unit tests.

v3:
- move the SFF-8636 thresholds fix to a standalone first patch
  against the current code, with Fixes and Cc stable
- rename ssf_add_dict_string() to sff_output_field() and move
  the generic declarations from sff_telemetry.h to sff_common.h
- decode the SFF-8636 thresholds when the length is at least 640 bytes,
  not only exactly 640
- new patch to avoid the unaligned float access in the SFF-8472
  calibration
- document that field names and value formats are for display only,
  document the SFF-8636 length rule, name the ethtool ioctls
  and the netlink difference, use "pluggable module"
- tests: add SFF-8636 with page 03h and unaligned SFF-8472 with
  external calibration, rename to ethdev_module_eeprom_autotest

Not changed in v3: the callback keeps returning void. Decoding one
module is a pass over a buffer of at most 640 bytes reporting about
a hundred fields, so stopping early does not seem useful.
A numeric API for diagnostic values could be added later
on top of the same decoders if needed.

v2:
- do not read the SFF-8636 alarm and warning thresholds from page 03h
  when only 256 bytes are available (out of bounds read found by ASan
  in the new unit test)

Roman Khromenok (6):
  ethdev: fix out-of-bounds read of SFF-8636 thresholds
  ethdev: decouple SFF module EEPROM decoders from telemetry
  ethdev: check module EEPROM length before decoding
  ethdev: avoid unaligned access in SFF-8472 decoder
  ethdev: add API to decode module EEPROM
  test: add ethdev module EEPROM decoding tests

 .mailmap                                |   1 +
 app/test/meson.build                    |   1 +
 app/test/test_ethdev_module_eeprom.c    | 334 ++++++++++++++++++++++++
 doc/guides/prog_guide/ethdev/ethdev.rst |  50 ++++
 doc/guides/rel_notes/release_26_11.rst  |   8 +
 lib/ethdev/rte_ethdev.c                 |  21 ++
 lib/ethdev/rte_ethdev.h                 |  57 ++++
 lib/ethdev/sff_8079.c                   | 204 +++++++--------
 lib/ethdev/sff_8472.c                   |  32 ++-
 lib/ethdev/sff_8636.c                   | 280 ++++++++++----------
 lib/ethdev/sff_common.c                 | 103 +++++---
 lib/ethdev/sff_common.h                 |  45 +++-
 lib/ethdev/sff_telemetry.c              |  81 +++---
 lib/ethdev/sff_telemetry.h              |  14 -
 14 files changed, 876 insertions(+), 355 deletions(-)
 create mode 100644 app/test/test_ethdev_module_eeprom.c

-- 
2.47.3

