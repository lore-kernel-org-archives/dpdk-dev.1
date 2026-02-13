Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82823EF99C9
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 18:54:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFE5F40659;
	Fri, 13 Feb 2026 19:53:45 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 65C5440664
 for <dev@dpdk.org>; Fri, 13 Feb 2026 19:53:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1771008824;
 bh=jB2v8oMQLTkIJVnW/p0qNBrCgE/B7QpnQVj+1jIlZ84=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=JdFMmVD169vJ8DmE7Q5EH420d6c2WnkrVVLebzX+vgszQWzpoCmRJe370mCM5ri0I
 WOwV+whswgnfUe1DnWLvNoUQcdAvxXfwykTGAZZHuTW1TMM7svvWoChdrinz2AxPGB
 BlcO+e6CyuaEHvIqlC/45G4VHTSELjGp5tEnsu2TQxRXhfbZFjTZvwB5/H5aguxV5J
 955H0yL9DYB6COFO3h3b7pBFxbJA0tVoUhh65XFIr4wjq+GJqaSe+gHRJBy5/XPomP
 +a9TlF12I7pY24aKy/ArOKZWa1y+4vJ/sf/wWqJyeC2BhQl6LvOnxGkc6JDmP0GB5J
 TwiD+do0g1k2Q==
Received: from [IPv6:2a00:1028:83a6:8aa::305]
 (dynamic-2a00-1028-83a6-08aa-0000-0000-0000-0305.ipv6.o2.cz
 [IPv6:2a00:1028:83a6:8aa::305])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 187C01180078;
 Fri, 13 Feb 2026 19:53:43 +0100 (CET)
Message-ID: <e27fbd0736cd88af1c36ea95db2fbc8f44870fb9.camel@cesnet.cz>
Subject: Re: [PATCH v7 0/8] net/nfb: rework to real multiport
From: Martin =?UTF-8?Q?=C5=A0pinler?= <spinler@cesnet.cz>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Date: Fri, 13 Feb 2026 19:53:43 +0100
In-Reply-To: <20260209163503.4c7a20e2@phoenix.local>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260204123137.123171-1-spinler@cesnet.cz>
 <20260209163503.4c7a20e2@phoenix.local>
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


> Patch 1/8 (Queue Mapping):
> =C2=A0=C2=A0=C2=A0 Missing NULL checks before accessing queue_map_rx/tx a=
rrays
> (could crash in secondary process)

Fixed with the new "ready" bit in device private struct.
However, I'm not sure, if/how the secondary process can pass init
before the primary.

> Patch 2/8 (Core Refactoring):
> =C2=A0=C2=A0=C2=A0 Resource leak: nfb_dev not closed on error path

Nonsense, the nfb_close is already exactly there.

> =C2=A0=C2=A0=C2=A0 Partial device cleanup missing on errors

The title and partially the description doesn't make sense.
The cleanup in nfb_eth_common_remove() for failed
nfb_eth_dev_create_for_ifc() is clear in my opinion.



All other problems fixed in v8 and mentioned in cover letter, thanks.
