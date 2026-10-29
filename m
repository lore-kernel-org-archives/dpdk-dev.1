Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9138606A31A
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Oct 2026 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=OP5+PeCj
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 446BC40262;
	Thu, 29 Oct 2026 18:42:08 +0100 (CET)
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net
 [31.44.14.18]) by mails.dpdk.org (Postfix) with ESMTPS id 412FE40151
 for <dev@dpdk.org>; Thu, 29 Oct 2026 18:42:06 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-78
 (mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65c5:0:640:924c:0])
 by forward502d.mail.yandex.net (postfix) with ESMTPS id 0FCFBC0150;
 Thu, 29 Oct 2026 20:42:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-78 with ESMTPSA id
 tfnVY6TcZSw0-Bg217A5B; Thu, 29 Oct 2026 20:42:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1793295724; bh=C2JfkUyEHymh01xw0JqE/yRDj3k1I9unXpWemDQ7McU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=OP5+PeCj/y5e3yJoivaz0iGLaFWezq9VCAyyLQ44ZsV2eJWc41TaKVjJ79nVzUgGv
 2l3InvXNE61PPR5k/31C3vzDl8x0filg9JMgNDP6rl3QQHTvhO+HI8BKoj4UJtt4E4
 /b61srJSFifiivjWYo/4hToPTZC+PxjZAo0xdKyk=
Authentication-Results: mail-nwsmtp-smtp-production-main-78;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 stephen@networkplumber.org
Subject: Re: [RFC 0/2] move module EEPROM decoding to a transceiver library
Date: Thu, 29 Oct 2026 19:41:51 +0200
Message-ID: <20261029174151.1527906-1-roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <1jOljJRtTQqpabyIXToQtw@monjalon.net>
References: <20261014071245.2323258-1-roma55592@yandex.ru>
 <20261026200950.1094549-1-roma55592@yandex.ru>
 <1jOljJRtTQqpabyIXToQtw@monjalon.net>
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

29/10/2026 17:11, Thomas Monjalon:
> 26/10/2026 21:09, Roman Khromenok:
> > 1. The library name: "transceiver" or "xcvr".
>
> "transceiver" reads better, but "xcvr" is shorter.
> I cannot decide.

Then I would keep "transceiver": it needs no explanation in the
documentation, and the function prefix rte_transceiver_ is not too
long. If Stephen or Andrew prefer "xcvr", I will rename it.

> > 2. Whether rte_eth_module_eeprom_parse() stays as a wrapper
> >    or is deprecated in favor of rte_transceiver_decode().
>
> rte_eth_module_eeprom_parse() is experimental so it can be removed.

OK, the v1 for 27.03 will remove it:
- testpmd "show port <id> module_eeprom decode" will call
  rte_transceiver_decode(),
- the ethdev telemetry command keeps using the library internally,
- the removal will be listed in the 27.03 release notes.

The patch 2/2 of the dpdk-proc-info series 39575 uses this function,
so I will send a v2 of it based on the library. The fix 1/2 does not
depend on it.

Thanks,
Roman
