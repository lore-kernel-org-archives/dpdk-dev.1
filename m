Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EB7E909AE
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 15:22:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F220A40261;
	Tue, 17 Feb 2026 16:22:34 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id B0DB1400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 16:22:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1771341753;
 bh=mrrdgoqvuNaIiMBZ+zh4pUIAC3Pym9pLOaNCGmShXxo=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=W138oqYzKEs9Vu7dp2AAnJvsccvb5RWQZ/Ks59bwSLEaI/keV4fHG/hptcr/umVtv
 NDyjTkb4QBHX4a9p6ZHy1OZrlKyrv3YavUveND5PojFJY+m5uqNxaUWwJ4jWkIbXwK
 9apR2txPdyVX/GtlxPwHkCqYQHTQQVgMHGFgubCz276zjC1nEow+OxRd3+0P8yG0te
 2lhS3JVZRtKSAaabLhlW7GSuKPNNpZckA2CgrI5CXrF1WR/jyK8/F2mMpXeSnjedRO
 ITrE+sb37Ga/Vh3uoiDVCdgnWpkMSn7K/zPYdbN2HqnCpTLAV0rYJcoQWRMtvJWOj8
 AIH6Sr5pr0LsQ==
Received: from [IPv6:2001:718:812:27::107] (gtx107.cesnet.cz
 [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 722071180072;
 Tue, 17 Feb 2026 16:22:33 +0100 (CET)
Message-ID: <ecd859ac3fc04dc259d55e3cdb0ce4d39648f393.camel@cesnet.cz>
Subject: Re: [PATCH v10 0/8] net/nfb: rework to real multiport
From: Martin Spinler <spinler@cesnet.cz>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Date: Tue, 17 Feb 2026 16:22:33 +0100
In-Reply-To: <e1a63b5ea5fe3c535c56054b4602cb3a8481a171.camel@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260217071040.2855133-1-spinler@cesnet.cz>
 <20260217065839.49e044ee@phoenix.local>
 <e1a63b5ea5fe3c535c56054b4602cb3a8481a171.camel@cesnet.cz>
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

On Tue, 2026-02-17 at 16:05 +0100, Martin Spinler wrote:
> > Does it still depend on this patch? It looks like the release note chan=
ge
> > is in this set.

Sorry, just to clarity: these are additional release note updates for this =
set.
(And these are the last standalone ones; the new "net/nfb: ethernet
enhancements" series has release note updates for each patch.)

>=20
> Yes, it made sense to me because there would be no git conflicts.
> I didn't see a problem as the patch-37245 is currently Accepted.
> Am I missing something?
