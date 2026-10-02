Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C957CA5FE0
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 19:44:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31F9342DD6;
	Fri,  2 Oct 2026 21:44:10 +0200 (CEST)
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net
 [51.250.60.162]) by mails.dpdk.org (Postfix) with ESMTP id AF54A4003C
 for <dev@dpdk.org>; Fri,  2 Oct 2026 21:44:08 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:31a0:0:640:75ad:0])
 by forward102d.mail.yandex.net (postfix) with ESMTPS id 6C427C0121;
 Fri, 02 Oct 2026 22:44:07 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (smtp)
 with ESMTPSA id hhroUtamROs0-4TwpFD0f; 
 Fri, 02 Oct 2026 22:44:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1790970247; bh=eYXgtfybDR6U2XwoZ3G1MgJ0e9iVfcwAMOu40++pEhA=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=IJl01VEJmIz7n2LJLcJMjqpCMzwNK6Xo5JlN1zkd4d2sShMeCymn7sGoLcqgPpzye
 eeX6fa+PNItXTnA+lhEa4LTH9msooEdvkR2wdtFujDGtAlswQ4TUnjNjlu9NOrMmmY
 npRMp8cBZegNH6NAdpDKI2P8Hyyuc12ll+n4hPf8=
Authentication-Results: mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/3] net/intel: make link state configurable on device start
Date: Fri,  2 Oct 2026 21:43:35 +0200
Message-ID: <cover.1790970122.git.roma55592@yandex.ru>
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

Starting a port always brings its link up, so the link partner sees
the port as soon as the application starts it. An application that
enables ports only after its own configuration is applied, such as
a firewall or a switch, cannot keep a disabled port dark: it can only
bring the link down right after rte_eth_dev_start(), and the link
partner may still see the link flap.

The ice driver already has the link_state_on_close device argument to
choose the link state when the port is stopped. This series adds its
counterpart, link_state_on_start, to the ice, i40e and ixgbe drivers:

  -a <pci>,link_state_on_start=down

With "down", the port is started with the link down, and the
application brings it up later with rte_eth_dev_set_link_up().
The default "up" keeps the current behavior.

ixgbe has no firmware command to bring the link down, so "down" leaves
the port in the same state as rte_eth_dev_set_link_down(): the laser
is kept off on fiber links, the copper PHY is powered off right after
the link setup.

Tested with testpmd on E810-C (ice, firmware 4.60) connected to
a network packet broker: with link_state_on_start=down the link stays
down after the port start and the link partner does not see it until
"set link-up"; without the device argument the link comes up on start
as before. i40e and ixgbe are build tested only.

Roman Khromenok (3):
  net/ice: make link state configurable on device start
  net/i40e: make link state configurable on device start
  net/ixgbe: make link state configurable on device start

 doc/guides/nics/i40e.rst               | 13 ++++++
 doc/guides/nics/ice.rst                | 13 ++++++
 doc/guides/nics/ixgbe.rst              | 13 ++++++
 doc/guides/rel_notes/release_26_11.rst | 13 +++++-
 drivers/net/intel/i40e/i40e_ethdev.c   | 58 +++++++++++++++++++++++++-
 drivers/net/intel/i40e/i40e_ethdev.h   |  2 +
 drivers/net/intel/ice/ice_ethdev.c     | 36 +++++++++++++++-
 drivers/net/intel/ice/ice_ethdev.h     |  1 +
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 44 ++++++++++++++++++-
 drivers/net/intel/ixgbe/ixgbe_ethdev.h |  2 +
 10 files changed, 187 insertions(+), 8 deletions(-)

-- 
2.47.3

