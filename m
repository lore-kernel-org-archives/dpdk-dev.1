Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1538CA600D
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 18:03:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86A0E40294;
	Thu,  8 Oct 2026 20:03:05 +0200 (CEST)
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net
 [31.44.14.17]) by mails.dpdk.org (Postfix) with ESMTP id 434C940284
 for <dev@dpdk.org>; Thu,  8 Oct 2026 20:03:04 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c43:4c85:0:640:11f5:0])
 by forward501d.mail.yandex.net (postfix) with ESMTPS id 412FA8A4A4;
 Thu, 08 Oct 2026 21:03:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (smtp)
 with ESMTPSA id n2ThKgHdI8c0-fLDdC9Hi; 
 Thu, 08 Oct 2026 21:03:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1791482581; bh=EsqoTEIV5u5XJamE61i75iNipMMl7GQsGFdHzyet2nc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=mT6YSAdRGa9id3IsZuN0aF1sQo3eeTMiRQOGp+P6TGd0nCGTRcQ3sZJh9mn0YOz4M
 YMwdSD576iKuY6I0eDKNPryupLZDLX9HG9Bdpo3lrufN0MrHUEidmMkkqNqzKp0qqO
 WbiGDOtCl7oH8ydflsMfOER0rzvjRdET+XlLPZtg=
Authentication-Results: mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 stephen@networkplumber.org
Subject: [PATCH v2 0/4] ethdev: report module signal status flags
Date: Thu,  8 Oct 2026 20:02:34 +0200
Message-ID: <cover.1791482259.git.roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1791447600.git.roma55592@yandex.ru>
References: <cover.1791447600.git.roma55592@yandex.ru>
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

The series depends on the module EEPROM decode API series and on
the testpmd decode command, which are in next-net but not in main
yet. It is based on next-net/for-main with patch 170851 applied,
so the release notes entry no longer conflicts.

Depends-on: series-39436 ("ethdev: add API to decode module EEPROM")
Depends-on: series-39455 ("ethdev: fix SFF-8472 external Rx power calibration")
Depends-on: series-39480 ("ethdev: fix SFF-8472 calibration overflow")
Depends-on: patch-170851 ("app/testpmd: add command to decode module EEPROM")

v2:
- 1/4: always report the Rx loss of signal instead of gating it on
  the Tx loss of signal implemented bit. SFF-8636 Rev 2.12 Table 6-5
  lists the Rx LOS flags as optional, but there is no implemented
  bit for them, and a module without them reads as not flagged.
- 2/4, 4/4: set the option bits with |= in the tests.
- 3/4: use the SFF-8636 format with a single lane ("None" or
  "[ Yes ]") for the same field names, which also removes the
  multi-line ternaries; "also reports" in the release notes.
- rebased on next-net/for-main with patch 170851 applied.

Roman Khromenok (4):
  ethdev: report SFF-8636 lane status flags
  test: check SFF-8636 lane status flags
  ethdev: report SFF-8472 Rx LOS and Tx fault state
  test: check SFF-8472 Rx LOS and Tx fault state

 app/test/test_ethdev_module_eeprom.c   | 118 +++++++++++++++++++++++++
 doc/guides/rel_notes/release_26_11.rst |   3 +
 lib/ethdev/sff_8472.c                  |  19 ++++
 lib/ethdev/sff_8636.c                  |  34 +++++++
 lib/ethdev/sff_8636.h                  |  12 +++
 lib/ethdev/sff_common.c                |  25 ++++++
 lib/ethdev/sff_common.h                |   2 +
 7 files changed, 213 insertions(+)

-- 
2.47.3

