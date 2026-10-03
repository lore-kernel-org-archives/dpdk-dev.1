Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9921CA5FDD
	for <dpdk-dev@archiver.kernel.org>; Sat,  3 Oct 2026 21:54:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C4D54028C;
	Sat,  3 Oct 2026 23:54:25 +0200 (CEST)
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net
 [37.230.175.130])
 by mails.dpdk.org (Postfix) with ESMTP id 0F93340275
 for <dev@dpdk.org>; Sat,  3 Oct 2026 23:54:24 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:3c89:0:640:a3ad:0])
 by forward502b.mail.yandex.net (postfix) with ESMTPS id 4864080790;
 Sun, 04 Oct 2026 00:54:23 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net (smtp)
 with ESMTPSA id rru58scfI8c0-K95WjH2M; 
 Sun, 04 Oct 2026 00:54:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1791064462; bh=iS8gcuXFmbkDNwuIsYbu47VpOx5Bj2PJFB2Rrr/nnoE=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=jCtRcvITFUe4UFvzfEevKVzBEw3+W7JsVia/WTapHofy2EZoucmW+sIDQiqkeLKKi
 Wxgh6PiBmBD+/izVijMJ1E31ykzWOCNzOEjovyg8Z2qI2UlXb4XRZWa+zfNAudqARF
 qVV59dccG2gzRTnDbph8IVIvm5YJBY8nhk+YXH7w=
Authentication-Results: mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/3] net/intel: make link state configurable on device
 start
Date: Sat,  3 Oct 2026 23:53:45 +0200
Message-ID: <20261003215345.1774614-1-roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261003091832.2ee5b91c@phoenix.local>
References: <cover.1790970122.git.roma55592@yandex.ru>
 <20261003091832.2ee5b91c@phoenix.local>
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

On Sat, 3 Oct 2026, Stephen Hemminger wrote:
> If you want something done better it must done at ethdev layer
> and you must coordinate across all existing devices.

Thanks, understood. I withdraw this series.

The problem behind it: a firewall starts its ports at boot but must keep
the ports that are disabled in its configuration down, so that the link
partner never sees them. Today rte_eth_dev_start() brings the link up
on most drivers, and the application can only bring it down afterwards.

Would an RFC along these lines be acceptable?
- ethdev keeps the administrative link state (RFC 2863 ifAdminStatus)
  set by rte_eth_dev_set_link_down()/up(), including before the port
  is started;
- rte_eth_dev_start() honors it: drivers that support it keep the link
  down on start, and for the others ethdev calls dev_set_link_down()
  right after dev_start(), so the semantics are the same for all devices;
- a new feature in the features matrix to track driver support.

Or would you prefer a separate API for the administrative state instead
of changing the behavior of rte_eth_dev_set_link_down()?

Roman
