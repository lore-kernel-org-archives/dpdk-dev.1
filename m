Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C821DCA9EBE
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 20:58:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F24040274;
	Fri,  9 Oct 2026 22:58:02 +0200 (CEST)
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net
 [31.44.14.17]) by mails.dpdk.org (Postfix) with ESMTP id A71024026A
 for <dev@dpdk.org>; Fri,  9 Oct 2026 22:58:00 +0200 (CEST)
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net
 [IPv6:2a02:6b8:c0e:500:1:45:d181:d501])
 by forward501d.mail.yandex.net (postfix) with ESMTPS id CBEAC875C9;
 Fri, 09 Oct 2026 23:57:59 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c22:d15:0:640:87c2:0])
 by forward501a.mail.yandex.net (postfix) with ESMTPS id B349C80619;
 Fri, 09 Oct 2026 23:57:49 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id jvWWRVcdAGk0-6M7Eb49k; 
 Fri, 09 Oct 2026 23:57:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1791579469; bh=h4PQTK2MkSUVCAw4v2nVAeMQGuAOIyd+BcODGvxSI7M=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=tFQjQ776C0RHFBlconjIV4kfGb5fjFE+295HuS8k2mJGfOTXDXjFq0BWEQgjIY/Il
 N6FpQ2In9r5QmhmqCc+pl4Wd6TjFNvkpoolwgSWXacSxSQ1x2W5FwN3CPGL/lvmEUm
 B89oZhLFFJYWCzMhilR6S4M8wTwbxJ0Dbn9UnqCg=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 andrew.rybchenko@oktetlabs.ru
Subject: Re: [PATCH v2 0/4] ethdev: report module signal status flags
Date: Fri,  9 Oct 2026 22:57:41 +0200
Message-ID: <20261009205741.550421-1-roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <QfuRvLIpRPi5pHmcYtqGrA@monjalon.net>
References: <cover.1791482259.git.roma55592@yandex.ru>
 <20261009112259.2bd9debc@phoenix.local>
 <20261009192113.534604-1-roma55592@yandex.ru>
 <QfuRvLIpRPi5pHmcYtqGrA@monjalon.net>
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

On Fri, 9 Oct 2026, Thomas Monjalon wrote:
> This is specific to networking devices, right?
> So it has to be linked with ethdev probably.
> But if it is not specific to any driver,
> we may consider moving it to separate library.
> I'm not sure which place is best.

Yes, these are the pluggable transceivers of network ports, but
nothing in the decoding is driver specific. Drivers only return
the raw EEPROM bytes through the get_module_eeprom op, and the
decoding follows the SFF specifications. The decoder (about 2700
lines) uses ethdev only for the RTE_ETH_MODULE_SFF_* type values
and the callback typedef.

So ethdev would keep linking it, the same way it depends on net
and meter: ethdev depends on the new library, not the other way.
rte_eth_dev_get_module_eeprom() and the telemetry command stay
in ethdev and call the library.

The decoder is also useful for ports which are not ethdev ports:
in our firewall, the kernel ports are read with the ethtool ioctls
and decoded with a copy of the same code. This already works with
rte_eth_module_eeprom_parse(), so a separate library is mostly
about keeping ethdev smaller, especially when CMIS is added,
which is about the size of the SFF-8636 decoder.

Keeping it in ethdev is fine with me too. If you prefer that,
I will add CMIS there.
