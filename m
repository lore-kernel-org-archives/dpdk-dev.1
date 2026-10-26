Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE57606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=qPqjdyeB
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AB984025A;
	Mon, 26 Oct 2026 21:05:45 +0100 (CET)
Received: from forward502e.mail.yandex.net (forward502e.mail.yandex.net
 [93.77.172.87]) by mails.dpdk.org (Postfix) with ESMTPS id 2EAAB40151
 for <dev@dpdk.org>; Mon, 26 Oct 2026 21:05:44 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-62
 (mail-nwsmtp-smtp-production-main-62.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:5724:0:640:b7ee:0])
 by forward502e.mail.yandex.net (postfix) with ESMTPS id 06426100018;
 Mon, 26 Oct 2026 23:05:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-62 with ESMTPSA id
 M5nUHo1iEqM0-HT0VHUAo; Mon, 26 Oct 2026 23:05:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1793045141; bh=ym9jd8OQzMXAinmfo3eWU/mDvi03K0is07MXZRPiE6o=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=qPqjdyeB2Sp5Qbwvu3GaIhl3ez7lSrWexUr2p1dHVFn6b34JYDNqnWk9HrxF6b21Y
 3dVuqCjqu4T3YJMtSK5b5JW5pHTkJ/XTXl/wfdH4RQSGVMom+hhKcLVej42xwtZocg
 F8KT6N+iJN2pYQu2fYenzSd4wIFgi4v+eaCWcp/4=
Authentication-Results: mail-nwsmtp-smtp-production-main-62;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: thomas@monjalon.net, reshma.pattan@intel.com, stephen@networkplumber.org
Subject: Re: [PATCH 1/2] app/procinfo: fix module EEPROM dump of multiple ports
Date: Mon, 26 Oct 2026 22:05:18 +0200
Message-ID: <20261026200518.1093815-1-roma55592@yandex.ru>
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

Gentle ping on this series.

Patch 1/2 is a fix for stable: --show-module-eeprom stops at the
first port whose module EEPROM cannot be read, and the EEPROM is
read into a fixed size buffer without checking the length reported
by the driver.

Patch 2/2 uses rte_eth_module_eeprom_parse(), which was in next-net
only when the series was sent, so the Intel CI failure came from
its base. The API is now in main, and the series applies to the
current main and builds without warnings.

Patch 2/2 is a new feature, so if it is too late for 26.11, I can
send it again for 27.03 with the release notes moved. Patch 1/2
does not depend on it.

Thanks,
Roman
