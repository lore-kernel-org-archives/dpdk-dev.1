Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68598606A324
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=vsu+258c
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D22574042F;
	Tue,  3 Nov 2026 15:07:29 +0100 (CET)
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net
 [31.44.14.18]) by mails.dpdk.org (Postfix) with ESMTPS id 1DE7B402DE
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:07:28 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-63
 (mail-nwsmtp-smtp-production-main-63.yp-c.yandex.net)
 by forward502d.mail.yandex.net (postfix) with ESMTPS id E817EC0331;
 Tue, 03 Nov 2026 17:07:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63 with ESMTPSA id
 L7M34ITdXuQ0-B0giaCwa; Tue, 03 Nov 2026 17:07:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1793714846; bh=GnX1DEJ6y8QejqLyH4o1tsiov3/2aiMoSdnJJR301DQ=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=vsu+258c5f5gM3jN0FPQig7KYL5z2uOG8rNP5ZJiToDcwm/55vN9g1BGeKBhIjPuC
 6qkWQ24GoNZdKncvsKROJGHCwX9DK9ntBbGNp9HXp53PuMFn106CKfnwUxs/im/VID
 usR3dNSOlDRf13z2eU000cVASkG7adUlEFjVkmXc=
Authentication-Results: mail-nwsmtp-smtp-production-main-63;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: thomas@monjalon.net, reshma.pattan@intel.com, stephen@networkplumber.org
Subject: Re: [PATCH v2 0/2] app/procinfo: decode module EEPROM
Date: Tue,  3 Nov 2026 16:07:18 +0200
Message-ID: <20261103140718.485324-1-roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029182033.1738436-1-roma55592@yandex.ru>
References: <e6d262613a145c7e850a526b03070bad38c40a92.1791609796.git.roma55592@yandex.ru>
 <20261029182033.1738436-1-roma55592@yandex.ru>
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
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Thomas,

A gentle reminder about patch 1/2 of this series:

    app/procinfo: fix module EEPROM dump of multiple ports

It is a self-contained fix with the Fixes: tag and Cc: stable,
independent of the transceiver library series, so it could go
to 26.11 as is. Without it, --show-module-eeprom stops at the
first port without a module.

Patch 2/2 depends on the transceiver library (series 39866,
deferred to 27.03), so this series cannot be applied as a whole
before the release, and only 1/2 is intended for 26.11.

Thanks,
Roman
