Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F61CE7FDCD
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 20:15:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A53A44027D;
	Mon,  2 Feb 2026 21:15:00 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 2C0134026D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 21:14:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1770063298;
 bh=MVTMvN7T0xNTpAC1/0/kUVpczQMrqPDv1nM/FaKBL5I=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=gJACavzeOboksnOhjQMFkOTHNATBflFiSegkxWl0NI2lSIcfHmx2Cgmc60mSx4LtR
 yb6QvvYRTtULYiUrjBSRPoSwofKqCdDCEeUozOEUrT7Y1kTHAbwWwgXSkac5TltSiB
 e2w4ekWH7CNlqvw4nIwkOdJs7qICdHTky9XtuheFbKOVWqNw4LILWb3kMaJHp8/OrV
 QynfWKH3l+QCcMZZQZ0AhPSU0n1xWzWZty5iqY+PIUkQVVOnU+Y6e6VaZ0DpEHSxea
 ix3qZ6mDgLN6qSf8RQt92C1E8ee5Jt6q4hu7L1eTnNHLgvDD8+iTKsjtRNidOAtaSo
 B2TMRzmlNPDvQ==
Received: from [IPv6:2a00:1028:83a6:8aa::305]
 (dynamic-2a00-1028-83a6-08aa-0000-0000-0000-0305.ipv6.o2.cz
 [IPv6:2a00:1028:83a6:8aa::305])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id AE7D01180072;
 Mon,  2 Feb 2026 21:14:58 +0100 (CET)
Message-ID: <811bfe37111be369a9aba35c49d705fd74f4ea54.camel@cesnet.cz>
Subject: Re: [PATCH v2] doc/nfb: update release notes for nfb driver
From: Martin =?UTF-8?Q?=C5=A0pinler?= <spinler@cesnet.cz>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Date: Mon, 02 Feb 2026 21:14:58 +0100
In-Reply-To: <20260202201207.3326331-1-spinler@cesnet.cz>
References: <20260202151521.3245438-1-spinler@cesnet.cz>
 <20260202201207.3326331-1-spinler@cesnet.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
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

On Mon, 2026-02-02 at 21:12 +0100, spinler@cesnet.cz wrote:
> Update the release notes for the NFB driver
> with the timestamp value changes.

This release notes update should have been in series-37064 ("net/nfb:
code cleanup").
(And certainly not in "net/nfb: rework to real multiport" series, as
you pointed right).

But as the "net/nfb: code cleanup" was already nearly upstreamed, I
didn't dare to modify them with this patch.
