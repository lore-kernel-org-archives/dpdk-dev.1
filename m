Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D49CA5FD4
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 12:53:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 409E840294;
	Fri,  2 Oct 2026 14:53:04 +0200 (CEST)
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net
 [51.250.60.161]) by mails.dpdk.org (Postfix) with ESMTP id 032604026C
 for <dev@dpdk.org>; Fri,  2 Oct 2026 14:53:02 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:49a1:0:640:3edd:0])
 by forward101d.mail.yandex.net (postfix) with ESMTPS id 1B04EC0082;
 Fri, 02 Oct 2026 15:53:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net (smtp)
 with ESMTPSA id fqkvm6Ydb8c0-1wtIKFyT; 
 Fri, 02 Oct 2026 15:53:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1790945581; bh=iOcvZU9PQDToplgAjyH4uuzIW2qaAqKMhnoULnoYRqk=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=GSnEj4yPQpkuMYc/O63FUmRRGRDInNDwlXyxc9ocQLYb80vLyhU5HoaUCh5wXDKLu
 YDvIKFQwiijhGlue/0BsQJlQLL0q4PRlGziCKiiX3FiLaTy1LSMTk3ZDG+fFz0yiQv
 jdDv7C/rM1VnY7byI1AzwuANBvaaiGh/rdoIovc0=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 0/3] ethdev: fix SFF-8472 calibration overflow
Date: Fri,  2 Oct 2026 14:52:34 +0200
Message-ID: <cover.1790935333.git.roma55592@yandex.ru>
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

This follows up on the review of the SFF-8472 Rx power calibration fix,
where the automated review pointed out the remaining issues in
sff_8472_calibration().

Calibration formula 1 (temperature, voltage, Tx bias, Tx power) scales
the 16-bit fields in place by a slope of up to 255.996 and adds a signed
16-bit offset. A result out of the field range is undefined behavior
for the float to integer conversion; a negative sum wraps around.
UBSan reports float-cast-overflow on randomly generated externally
calibrated SFP dumps.

Patch 1 computes formula 1 in double precision and saturates the result
to the field range, as already done for the Rx power. It is intended
for stable.
Patch 2 rounds the calibrated values to the nearest integer instead
of truncating them: RX_PWR(1) = 0.7 is stored as 0.69999999 and
a raw reading of 1000 gave 699 instead of 700.
Patch 3 adds unit tests for saturation at both ends and for rounding.

Based on dpdk-next-net for-main.

Depends-on: series-39455 ("ethdev: fix SFF-8472 external Rx power calibration")

Roman Khromenok (3):
  ethdev: fix SFF-8472 calibration overflow
  ethdev: round SFF-8472 calibrated values
  test: check SFF-8472 calibration saturation and rounding

 app/test/test_ethdev_module_eeprom.c | 96 ++++++++++++++++++++++++++++
 lib/ethdev/sff_8472.c                | 55 +++++++++++-----
 2 files changed, 134 insertions(+), 17 deletions(-)

-- 
2.47.3

