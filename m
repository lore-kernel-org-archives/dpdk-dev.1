Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF0C606AE02
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=CadrcY5M
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADE9F41153;
	Thu, 12 Nov 2026 15:19:31 +0100 (CET)
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net
 [37.230.174.41])
 by mails.dpdk.org (Postfix) with ESMTPS id 8C94D402A2
 for <dev@dpdk.org>; Thu, 12 Nov 2026 15:19:28 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-81
 (mail-nwsmtp-smtp-production-main-81.yp-c.yandex.net)
 by forward501a.mail.yandex.net (postfix) with ESMTPS id B137D80779;
 Thu, 12 Nov 2026 17:19:27 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81 with ESMTPSA id
 vIVDQdbg64Y0-sU5XrT4e; Thu, 12 Nov 2026 17:19:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1794493167; bh=sT7VJSQka23vKepdl2/8JRf4mEqyZp8VI8pMzuqiwWw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=CadrcY5Mmg+XSpfCRLhTuBH/PWzTFCRfde/Jr+GQC7Jhr8rQdxcBTscxWao3teP/+
 qksAfw04+vgvpjWZ2dHDKRr8TIzIsC2cCG+q2Yldj7bFITkXx3uoMQ4+KPU01Kb6O7
 ofWzJKGaKOVsC47ZKf/zP3oFQtTC44+Fis8aDNk8=
Authentication-Results: mail-nwsmtp-smtp-production-main-81;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH] devtools: ignore context lines in check-symbol-change.py
Date: Thu, 12 Nov 2026 16:18:52 +0200
Message-ID: <20261112141852.305720-2-roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261103140411.484629-1-roma55592@yandex.ru>
References: <20261103140411.484629-1-roma55592@yandex.ru>
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

A gentle ping on this one. It only touches devtools and fixes
a false "removed from stable ABI" report, so it might still fit
into 26.11.

Thanks,
Roman
