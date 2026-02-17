Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40751E909C0
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 15:05:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8418740261;
	Tue, 17 Feb 2026 16:05:48 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 823D9400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 16:05:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1771340747;
 bh=1ts//wWACIYPUXujbiKwRU1J+9FzNEkacPbN+ExzyCs=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=OjwQvE7AIL0EBoACTemSAgKPkv9KtQ3SmU7U5eBmg1MDARRDFJykRHhQZlKggBI7s
 wvp1bVahGX/uEL467ScqhREUiNG81P+qSleYpPaLXQPU9miqqmOfuqUfOHmpJs8VoV
 T1pzIOaNGCoOiJESmHl2UFRTX3c1eFMxKYwy2ZrTMYiFqrYgh1ONrsk61FZz7TBZyq
 TFPeMyYMqs9MtLQMJqi49Dq53MtOui244AvC0bnOOzYv1J8R8cEu0kB1SlkMmfJCk/
 6KGueeZpTpmrtqKk7JQDDVz8m8BGOxCDbQZEc3k2t03j87XLvFg43dgfwP+kaQ8Rew
 MJv42YY94xf5A==
Received: from [IPv6:2001:718:812:27::107] (gtx107.cesnet.cz
 [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 31DF211800E6;
 Tue, 17 Feb 2026 16:05:47 +0100 (CET)
Message-ID: <e1a63b5ea5fe3c535c56054b4602cb3a8481a171.camel@cesnet.cz>
Subject: Re: [PATCH v10 0/8] net/nfb: rework to real multiport
From: Martin Spinler <spinler@cesnet.cz>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Date: Tue, 17 Feb 2026 16:05:47 +0100
In-Reply-To: <20260217065839.49e044ee@phoenix.local>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260217071040.2855133-1-spinler@cesnet.cz>
 <20260217065839.49e044ee@phoenix.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
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

> Does it still depend on this patch? It looks like the release note change
> is in this set.

Yes, it made sense to me because there would be no git conflicts.
I didn't see a problem as the patch-37245 is currently Accepted.
Am I missing something?
