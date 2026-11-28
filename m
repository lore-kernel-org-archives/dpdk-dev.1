Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99795606A31C
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Nov 2026 05:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=ovy9/RJY
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1F60402D4;
	Sat, 28 Nov 2026 06:44:31 +0100 (CET)
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net
 [31.44.14.18]) by mails.dpdk.org (Postfix) with ESMTPS id A6D5C402C1
 for <dev@dpdk.org>; Sat, 28 Nov 2026 06:44:30 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-84
 (mail-nwsmtp-smtp-production-main-84.yp-c.yandex.net)
 by forward502d.mail.yandex.net (postfix) with ESMTPS id 8B70CC01A2;
 Sat, 28 Nov 2026 08:44:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84 with ESMTPSA id
 GhcEfrlcXuQ0-Goseayau; Sat, 28 Nov 2026 08:44:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1795844669; bh=ffuG7n/Cex0Q7XumI/Z8QE9LXD2iobeBOK4fkWgXLTc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ovy9/RJYAs7c8lFu7lUziQmFdSiBPWY8t88ANXyJiHAARQ2DzERRCs+deVDD4lFmM
 y6iid9Ywqj2W+hnX/1f4jRu5KTpTH8CPLoRoM6T25PHgBClfmvTKFchn8bhNatS+LR
 IOFDp7eDUEH3vS5SB4iY4/rgJNbAUBpXEHn2s0NQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-84;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/4] move module EEPROM decoding to a transceiver library
Date: Sat, 28 Nov 2026 07:43:11 +0200
Message-ID: <cover.1795844373.git.roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795810230.git.roma55592@yandex.ru>
References: <cover.1795810230.git.roma55592@yandex.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is the follow-up of the RFC, for 27.03.

The SFF module EEPROM decoders do not depend on any device or driver,
and they are also useful for ports which are not ethdev ports, such as
kernel ports read with the ethtool ioctls. This series moves them from
ethdev to a new transceiver library with the rte_transceiver_decode()
API. ethdev depends on the library for its telemetry command.

Changes since v2:
- Focused the New Features release note on the new transceiver library.
- Added a Removed Items release note for the ethdev API removal in
  patch 4, as requested by review.

Changes since v1:
- Rebased on 27.03-rc0.
- Added the release notes suggested by Stephen and the reviewers.

Changes since the RFC, as discussed with Thomas:
- rte_eth_module_eeprom_parse(), added as experimental in 26.11,
  is removed instead of being kept as a wrapper.
- testpmd calls rte_transceiver_decode() directly.
- The tests no longer depend on ethdev.
- The ethdev guide links to the library guide instead of
  duplicating the example.

The library name is still "transceiver", as it reads better than
"xcvr". It can be renamed if preferred.

The dpdk-proc-info module EEPROM decoding (series 39867) is based on
this series.

Only documentation changed since v2. The documentation builds without
warnings, and check-git-log and checkpatches pass for all four patches.
The code is unchanged from v2, which was tested with gcc -Werror and
clang with ASan and UBSan, including transceiver_autotest.

The v2 github-robot failure comes from the last ABI compatibility step,
which runs the 26.11 testpmd binary with the new libraries. That binary
requires the removed experimental rte_eth_module_eeprom_parse() symbol.
The ABI check itself passes, as experimental symbols are excluded.

RFC: https://mails.dpdk.org/archives/dev/2026-October/348542.html

Roman Khromenok (4):
  transceiver: introduce module EEPROM decoding library
  test/transceiver: move module EEPROM decoding tests
  app/testpmd: decode module EEPROM with transceiver library
  ethdev: remove module EEPROM decoding wrapper

 MAINTAINERS                                   |   7 +
 app/test-pmd/config.c                         |   3 +-
 app/test-pmd/meson.build                      |   2 +-
 app/test/meson.build                          |   2 +-
 ...dev_module_eeprom.c => test_transceiver.c} | 132 +++++++++---------
 doc/api/doxy-api-index.md                     |   1 +
 doc/api/doxy-api.conf.in                      |   1 +
 doc/guides/prog_guide/ethdev/ethdev.rst       |  39 +-----
 doc/guides/prog_guide/index.rst               |   1 +
 doc/guides/prog_guide/transceiver_lib.rst     |  86 ++++++++++++
 doc/guides/rel_notes/release_27_03.rst        |  12 ++
 lib/ethdev/meson.build                        |   6 +-
 lib/ethdev/rte_ethdev.c                       |  21 ---
 lib/ethdev/rte_ethdev.h                       |  57 --------
 lib/ethdev/sff_telemetry.c                    |  13 +-
 lib/meson.build                               |   2 +
 lib/transceiver/meson.build                   |  11 ++
 lib/transceiver/rte_transceiver.c             |  24 ++++
 lib/transceiver/rte_transceiver.h             | 102 ++++++++++++++
 lib/{ethdev => transceiver}/sff_8079.c        |   2 +-
 lib/{ethdev => transceiver}/sff_8472.c        |   0
 lib/{ethdev => transceiver}/sff_8636.c        |   4 +-
 lib/{ethdev => transceiver}/sff_8636.h        |   0
 lib/{ethdev => transceiver}/sff_common.c      |  28 ++--
 lib/{ethdev => transceiver}/sff_common.h      |  10 +-
 25 files changed, 353 insertions(+), 213 deletions(-)
 rename app/test/{test_ethdev_module_eeprom.c => test_transceiver.c} (83%)
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
