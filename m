Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1785C55ABA
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Aug 2026 09:13:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88DC140144;
	Wed,  5 Aug 2026 11:13:06 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id CA6B74003C
 for <dev@dpdk.org>; Wed,  5 Aug 2026 11:13:04 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 18EF11D0002D;
 Wed,  5 Aug 2026 05:13:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 05 Aug 2026 05:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1785921183;
 x=1786007583; bh=f+AHfh1s9QXi5wXapvKSzJaeRObFNC5cdrXILDSz9B4=; b=
 Q9uVqpzm8qHMNAu4Cyv3Hn7qdRjhZGb9ZxxyAsQKIPhjwBIFoSLD9XQsWiW2WZoP
 17dS/mXWmiAoAc32qD58hYBSb7OfZbpxBrd+t6/H1sZqWbkyiBUvEfQ8YNeQhjHl
 nmkWf0QkL9TCbCcQcOlXx7KPrceZOfv3bzhBscY87HwZqxIyQGRHpAdvJj6e3uqu
 wXxe5SaIQGlC4PosePbjZr92agW7z7S3xls9+EDwaTKIrZZROyqVXlTuY+E5myiL
 U3hUpHNvtjKYFuuzILz8Uu2RFKlwSZxnxSvudYmIt7oaYFpQFPdJzAhWgf8pFPmS
 uSqmSRgX5012r0dl535RhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785921183; x=
 1786007583; bh=f+AHfh1s9QXi5wXapvKSzJaeRObFNC5cdrXILDSz9B4=; b=C
 wBoxLm2Uu2cMXQSGz8p4IeFEVZlOYv0ZcsKfGFQCBYGBUPkMqaCa8x3Wx8n2xzol
 GeTZBR3VM1Mz7m0Tib3CUQfYRZWsvsE9ovffHvOfkJXxn3PS3FDW8pPCb7FxepHd
 uX5zTGT+ubQUJ0ggJLbE/o4Qpw7zpLM9XOoHius50jsyYD/xkVUFOwyNsHLjjfGB
 eQ+Y5xthMHpW2g+ZF9ki5inGOI1gCSV/LsYQ5ZJz6p8tUEUSf2IJ1dEPEh1gsaTP
 aGtwM7tDeisJGC+902FQ9QrEoSEqgSeT22CvJqHSkB0lJERn5Y4eagSYxPk3Xh42
 r5Ho9e0ntuSly6l0Fr7tQ==
X-ME-Sender: <xms:n_5yarH_13q8EkF2w3p0_70_D_kkmQ8yny3EGcpJdYiZw3cBHP8j2w>
 <xme:n_5yatnt26FI0UVAcEUcYCKz6QIcSc-vfipMKT0L4rXagsb4CeWRUYSbw7CGYVh5P
 _e5QTP5jsRrEHpWxrlgczLhasBDwE8ul5t8gzqG9c_eBvCv7ER_srs>
X-ME-Received: <xmr:n_5yau3a9Mx-A4hGtXMyK_3z7tNG9F12jKh__R9Jjxfunrh_wmQlkL5Qu2uO3VJMg_wwNK_DSu8teVuJ1vdTg0WVFg>
X-ME-Proxy-Cause: dmFkZTG2rCQwW5ZDvKwVvFsKeLDdQU9BolbVnaesPeeoYzS4KAB/fKgxvbMMytVAfcdnoE
 HEtfv1cRn1ueI5o8B3Z/9LZKwOrmWm5njFwV+gxka5jKnRNV96gEzSaTZ8O49hdMnsJmDF
 g9J2sFDKNUEW1ZiGjVqJFoIT4Sd4t+d7root+9YruprPJ0FDtE6k5uaqAv4E642ZuGST2P
 gfP0ZCaMDVgA0r+W32ZZHfS7M3tdU0ZJdtLDW59Qy2YruJkccbHb53ejMYDUAuxX7M/+Mj
 wJrq/XlBThFxtuiJkFHo244fvuR8z//6AcAcIdJzzPd3yNKiHukeVhHNq/5VJsPrTyrGZo
 Fw9m0CjzoBht6k6JO23f1ksIeG+LJBcf8jwnGVziAjwEzIo6f6Ec+2rEGLo94GqZIYwwq3
 D9TONo3L6HRaV8sAS0CsPe9SUvY7IiZQMJDZt2vyI2k1dz8Q+mXnbZnV61bjC8dXkkDk0y
 oGYmtzoEHiPYHjaYhvjWLo61Psp7iXui090jTfS7YDyU6svjVlnf2ClUakfhmCiHmU+jQG
 HeHTkGuGIVY3ILBjYyT5xpMEAryj9PXJ3m5n/cCvP2A9LAqSHnXDKi26fIrHWnOjCv3ILM
 vk+zUSvuLTBDzp4Df1zY/DbnmM7IDpJDSt2fmlrbYamrFckaAPLr6v6pVzUQ
X-ME-Proxy: <xmx:n_5yahQbt83f7qGIdYG81OMWlpesIV-Mgljp-4WONVLbyw-ea_pnYA>
 <xmx:n_5yaovIlI9DqFNtbgy6EFBUAsEkBH7tFCbqAZuXplI3o5sAcG5RTA>
 <xmx:n_5yaubCcCLMj8C_ahk_LGIKRJz10sQzHRB-cI3_UHgm72ytmOQUkQ>
 <xmx:n_5yaluLvbbrpSfcKIrbWNWRT9iXin0GEntd7Q3lcH9YjG97OhFfpw>
 <xmx:n_5yah2GdRtFHsQ14n_iDGcYIswD7qGZ9u5zRQyreWtGM80eKfyTS9um>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 05:13:03 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Khadem Ullah <khadem.systems@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] mailmap: update Khadem Ullah email address
Date: Wed, 05 Aug 2026 11:13:00 +0200
Message-ID: <nW132F6YTPOmhQeN9yqNNw@monjalon.net>
In-Reply-To: <20260730094249.74189-1-khadem.systems@gmail.com>
References: <20260727062821.42394-1-khadem.systems@gmail.com>
 <20260730094249.74189-1-khadem.systems@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

Hello,

30/07/2026 11:42, Khadem Ullah:
> Update my email address to my personal account for
> all future and past historical DPDK contributions.

In general we update mailmap alongside contributions.
The idea is to avoid too much noise in the git history.


