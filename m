Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F29606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 20:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=ekPNi3GK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A7EB40151;
	Mon, 26 Oct 2026 21:10:04 +0100 (CET)
Received: from forward502e.mail.yandex.net (forward502e.mail.yandex.net
 [93.77.172.87]) by mails.dpdk.org (Postfix) with ESMTPS id 2C93440041
 for <dev@dpdk.org>; Mon, 26 Oct 2026 21:10:03 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-66
 (mail-nwsmtp-smtp-production-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:451a:0:640:32c4:0])
 by forward502e.mail.yandex.net (postfix) with ESMTPS id 8845E100072;
 Mon, 26 Oct 2026 23:10:01 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-66 with ESMTPSA id
 r9nMjk1hHKo0-V0syUcn0; Mon, 26 Oct 2026 23:10:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1793045400; bh=KVY0Ynh9FqDA03HBNhwDHx0CNH57YDQP2tVGtE14o1Q=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ekPNi3GKuKA2L+TnVvrkfKn3p7LzNbF0jVkwswbsggjdcqQer41gX9pd8KsxqZf3i
 oNTt1tIYKia51/vJv5gpil1RFKEgFi8dMqEbqGD7592jUk7SMUE+qfmBozZZWSxBXJ
 KfCHM04TIecaQAkHucKCRKBu9nn239Le3XJv26lY=
Authentication-Results: mail-nwsmtp-smtp-production-main-66;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 stephen@networkplumber.org
Subject: Re: [RFC 0/2] move module EEPROM decoding to a transceiver library
Date: Mon, 26 Oct 2026 22:09:50 +0200
Message-ID: <20261026200950.1094549-1-roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261014071245.2323258-1-roma55592@yandex.ru>
References: <20261014071245.2323258-1-roma55592@yandex.ru>
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

Gentle ping on this RFC for 27.03.

I would like to agree on the direction before working on the next
step, CMIS decoding, which I plan to add to this library. The open
points are in the cover letter:

1. The library name: "transceiver" or "xcvr".
2. Whether rte_eth_module_eeprom_parse() stays as a wrapper
   or is deprecated in favor of rte_transceiver_decode().

The code moves with git mv, the ethdev API added in 26.11 does not
change, and the CI passed on the series.

Thanks,
Roman
