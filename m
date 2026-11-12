Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B388C607115F
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=AWVczBlC
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDB8A40682;
	Thu, 12 Nov 2026 15:19:28 +0100 (CET)
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net
 [37.230.174.42])
 by mails.dpdk.org (Postfix) with ESMTPS id A9092402A2
 for <dev@dpdk.org>; Thu, 12 Nov 2026 15:19:27 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-81
 (mail-nwsmtp-smtp-production-main-81.yp-c.yandex.net)
 by forward502a.mail.yandex.net (postfix) with ESMTPS id C797D80B86;
 Thu, 12 Nov 2026 17:19:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81 with ESMTPSA id
 vIVDQdbg64Y0-m9BWbNoc; Thu, 12 Nov 2026 17:19:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1794493166; bh=82urOgJ/R7cQn8dg0BzZJjfMB8hlkpPq3ld1qBwJ/gw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=AWVczBlC3zVeeTVpQZyokeJnDjeYvhjIB99XxevSOxjoP/PXuOvxZLIrCQRybK1VX
 Sk1/tD7q0V+uzMVr9ysW+5idUeqK5//9frB37iar12DqEtzh5DL8UcEOYPBVMrVPx0
 Ncze0MQsEUcKX3w4jsa2VDOkeshmADu1NZTvfmSI=
Authentication-Results: mail-nwsmtp-smtp-production-main-81;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v2 0/2] app/procinfo: decode module EEPROM
Date: Thu, 12 Nov 2026 16:18:51 +0200
Message-ID: <20261112141852.305720-1-roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261103140718.485324-1-roma55592@yandex.ru>
References: <e6d262613a145c7e850a526b03070bad38c40a92.1791609796.git.roma55592@yandex.ru>
 <20261029182033.1738436-1-roma55592@yandex.ru>
 <20261103140718.485324-1-roma55592@yandex.ru>
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

Another gentle reminder before 26.11 is out: patch 1/2
(app/procinfo: fix module EEPROM dump of multiple ports) is
a standalone fix with Fixes: and Cc: stable, and it still
applies cleanly to the current main.

Patch 2/2 can wait for 27.03 together with the transceiver
library.

Thanks,
Roman
