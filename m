Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC9FCA601E
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 19:22:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5D4540274;
	Fri,  9 Oct 2026 21:22:22 +0200 (CEST)
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net
 [31.44.14.17]) by mails.dpdk.org (Postfix) with ESMTP id ECC084026A
 for <dev@dpdk.org>; Fri,  9 Oct 2026 21:22:21 +0200 (CEST)
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net
 [IPv6:2a02:6b8:c0e:500:1:45:d181:d500])
 by forward501d.mail.yandex.net (postfix) with ESMTPS id C881F89ADB;
 Fri, 09 Oct 2026 22:22:20 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:8a97:0:640:ac66:0])
 by forward500a.mail.yandex.net (postfix) with ESMTPS id B1C51C0065;
 Fri, 09 Oct 2026 22:22:20 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net (smtp)
 with ESMTPSA id 6MVKhnThESw0-8kvfVtH7; 
 Fri, 09 Oct 2026 22:22:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1791573740; bh=WZDReZiUyUlwa4r7IC7UdW2UKEtpBivr3n+U+RfS2mc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=cd+t4et0yWCtx32VqRHCBLdwxgToJJj84TQwHh40wHcHLpULWdQPiEpaL+mXNGodJ
 2sv3u7jEyMLQUBjD9kHt4by+hX0GcWvyv9Hyh+cz9L9/QWtARxaeLNXD9y2/WVVR8I
 AHlVxIYDWScnt9dRBOJLR0QmsMjITROZ0+EIr4Oo=
Authentication-Results: mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru
Subject: Re: [PATCH v2 0/4] ethdev: report module signal status flags
Date: Fri,  9 Oct 2026 21:21:13 +0200
Message-ID: <20261009192113.534604-1-roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261009112259.2bd9debc@phoenix.local>
References: <cover.1791447600.git.roma55592@yandex.ru>
 <cover.1791482259.git.roma55592@yandex.ru>
 <20261009112259.2bd9debc@phoenix.local>
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

On Fri, 9 Oct 2026, Stephen Hemminger wrote:
> Applied to next-net.
>
> I wonder if the eeprom really belongs in its on library, really it is not
> part of standard ethdev.

Thanks, Stephen.

Agreed, the decoder does not need a device: it only parses a buffer
and works without EAL. Only rte_eth_dev_get_module_eeprom() and the
telemetry command are really ethdev.

If Thomas and Andrew are fine with it, I can send an RFC for 27.03
moving the SFF decoders into a small library with its own API, with
the ethdev telemetry command on top of it. rte_eth_module_eeprom_parse()
is experimental, so it can stay as a thin wrapper or be removed.
A separate library would also be the place for CMIS (QSFP-DD, OSFP)
decoding later, which does not fit the SFF naming, so a neutral name
like lib/xcvr may be better than lib/sff.

I am willing to maintain this library.
