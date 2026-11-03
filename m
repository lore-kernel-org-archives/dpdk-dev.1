Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D34606A324
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 04:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=Yk34B8Nu
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF3824028B;
	Tue,  3 Nov 2026 05:20:01 +0100 (CET)
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net
 [31.44.14.18]) by mails.dpdk.org (Postfix) with ESMTPS id 4E4E040278
 for <dev@dpdk.org>; Tue,  3 Nov 2026 05:20:00 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-72
 (mail-nwsmtp-smtp-production-main-72.yp-c.yandex.net)
 by forward502d.mail.yandex.net (postfix) with ESMTPS id EC5D1C008E;
 Tue, 03 Nov 2026 07:19:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-72 with ESMTPSA id
 bJCpOYNhCKo0-gju3VUhx; Tue, 03 Nov 2026 07:19:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1793679598; bh=7a793DDzi1YUVLYJEJkYgfGvHJdfechy851nokKqmQs=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=Yk34B8NuR5AsbAHOlArQZ7jCGqxpQ7Q0HZCgAGkwwBMuWrUeWn+foba4dEIzgJ/Ah
 9fLkKgU783ttdYDd5ddciBBdYv3f38aJx5MY9qyhBA99uPmKCrBVne4b8mfIsIXHf+
 /3aC8/kwfhdxGaGsxnDnBXa0tgkUflyFOkJjOjyk=
Authentication-Results: mail-nwsmtp-smtp-production-main-72;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, thomas@monjalon.net, stephen@networkplumber.org,
 andrew.rybchenko@oktetlabs.ru
Subject: Re: [RFC 0/2] move module EEPROM decoding to a transceiver library
Date: Tue,  3 Nov 2026 06:18:50 +0200
Message-ID: <20261103041851.447193-1-roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65AEC@smartserver.smartshare.dk>
References: <20261014071245.2323258-1-roma55592@yandex.ru>
 <98CBD80474FA8B44BF855DF32C47DC35F65AEC@smartserver.smartshare.dk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

02/11/2026 12:07, Morten Brørup:
> Are there any APIs to tell if a transceiver module is plugged into the
> transceiver module socket on the NIC, either in the ethdev library or
> under this new transceiver library?

There is no dedicated "module present" API in DPDK today.

Module presence is only detected indirectly: rte_eth_dev_get_module_info()
and rte_eth_dev_get_module_eeprom() return an error, for example -EIO,
when no module is plugged, but only for drivers implementing these
operations (ixgbe, i40e, ice, hns3, cnxk, ...). The link state is not a
reliable indicator either: a plugged module can be down, and some
modules (DAC cables) report link without optical diagnostics.

The transceiver library cannot detect presence by design: it works on
the raw EEPROM bytes only and has no dependency on any device, driver
or even EAL initialization. This is also what makes it usable for
kernel ports read with the ethtool ioctls.

Physically, module presence is a MOD_ABS pin of the socket, not
something that can be read from the EEPROM, so it belongs to the
driver level. If an explicit presence API is wanted, I think it should
be a separate ethdev device operation, for example
.get_module_presence, so drivers could report it without attempting an
EEPROM read. That would be a follow-up series, independent of this one.

Thanks,
Roman
