Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0545E606A31A
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Oct 2026 18:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=ejZtM3mO
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65B814025A;
	Thu, 29 Oct 2026 19:20:47 +0100 (CET)
Received: from forward504d.mail.yandex.net (forward504d.mail.yandex.net
 [31.44.14.20]) by mails.dpdk.org (Postfix) with ESMTPS id 6987F40151
 for <dev@dpdk.org>; Thu, 29 Oct 2026 19:20:46 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-45
 (mail-nwsmtp-smtp-production-main-45.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:fbcb:0:640:9ab5:0])
 by forward504d.mail.yandex.net (postfix) with ESMTPS id 0025A1003F0;
 Thu, 29 Oct 2026 21:20:44 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45 with ESMTPSA id
 aKoGkwTghOs0-RRI5LBT8; Thu, 29 Oct 2026 21:20:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1793298044; bh=fA533xzJghFDbsy3s9wcqLR/ewd5KQxXXxUQF3br2do=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ejZtM3mOubvAZZnz+YHhaloH5aTvVjfw4LYUOsa/F9iV1exwFaECretgggTsCa3PW
 tYc6jXXolT6Ts6569l3ZKde12WLkrAIcr5VYX4q05yuWZ+nM00csMYVs0uAKr+cpD1
 QSndq7A8iUXV+sjLoitlZ9BtE5QR2bDyx4l9i3R4=
Authentication-Results: mail-nwsmtp-smtp-production-main-45;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: reshma.pattan@intel.com, stephen@networkplumber.org, thomas@monjalon.net
Subject: [PATCH v2 0/2] app/procinfo: decode module EEPROM
Date: Thu, 29 Oct 2026 20:20:31 +0200
Message-ID: <20261029182033.1738436-1-roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <e6d262613a145c7e850a526b03070bad38c40a92.1791609796.git.roma55592@yandex.ru>
References: <e6d262613a145c7e850a526b03070bad38c40a92.1791609796.git.roma55592@yandex.ru>
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The first patch fixes the --show-module-eeprom option, which stopped
at the first port whose module EEPROM could not be read. It does not
depend on anything and can be applied alone, also for 26.11.

The second patch adds --show-module-eeprom=decode to print the decoded
module EEPROM fields, as the testpmd command does.

v2:
- Decode with rte_transceiver_decode() from the new transceiver
  library, as rte_eth_module_eeprom_parse() is removed by that series.
  The release notes will be added with the 27.03 ones.
- Patch 1/2 is unchanged.

Depends-on: series-39866 ("move module EEPROM decoding to a transceiver library")

Roman Khromenok (2):
  app/procinfo: fix module EEPROM dump of multiple ports
  app/procinfo: add option to decode module EEPROM

 app/proc-info/main.c           | 54 ++++++++++++++++++++++++++++------
 app/proc-info/meson.build      |  2 +-
 doc/guides/tools/proc_info.rst |  9 ++++--
 3 files changed, 52 insertions(+), 13 deletions(-)

-- 
2.47.3

