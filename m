Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2377DD2595D
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 08:12:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00FB940B9F;
	Tue, 27 Jan 2026 09:12:15 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id CF08B40A77
 for <dev@dpdk.org>; Tue, 27 Jan 2026 09:12:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1769501533;
 bh=XCGaEjXa1+gVI7qrY2jgvE5GabeDaL+JihssQhQyWrY=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=V0Wgak3UjdFsf3kyorVtKBhjBlR6SPdxLhaoLXvQp1jiE1yO9/C9wkKofACL0xUSs
 9ru2rRjHEnp+4MaREuGpl6pUT2nBW+wkevk44mmZsVYYCxiOzmdqkkIrcFHWYlyHgi
 tUMG3WP2jqfavOIDbXgi1j0HxW0efm6z94A6VrPpPvzWirI7rHnYvXiPoRuuDKmema
 ZUuJpOLiAUDP1EW6U0vSefa9k0ijU6b9brfuC0Pvu23bWdpdMfAz5bRo62nNynDml8
 g6w1oYOchg3aldcvXqBG0mIBISu7c8a7E/wB8/w31BKrPKfIgAVjHz+4fKHiF1UJq7
 pzhLRj7b010Xw==
Received: from [IPv6:2001:718:812:27::107] (gtx107.cesnet.cz
 [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 72A59118008B;
 Tue, 27 Jan 2026 09:12:13 +0100 (CET)
Message-ID: <1256ecfe661fd3ddf7e8913bd82b02cb16085486.camel@cesnet.cz>
Subject: Re: [PATCH v4 3/6] net/nfb: update timestamp calculation to
 meaningful value
From: Martin Spinler <spinler@cesnet.cz>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Date: Tue, 27 Jan 2026 09:12:13 +0100
In-Reply-To: <20260121093307.299c84f0@phoenix.local>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260121170120.268553-1-spinler@cesnet.cz>
 <20260121170120.268553-4-spinler@cesnet.cz>
 <20260121093307.299c84f0@phoenix.local>
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

On Wed, 2026-01-21 at 09:33 -0800, Stephen Hemminger wrote:
> The patch is ok as far as it goes.
>=20
> But the best practice in DPDK for drivers doing timestamps is for
> the driver to only put a timestamp on if timestamp offload flag
> was set when configuring that device. For the case of multiple devices
> that means that one device may have timestamp and other not.

Ack. I'll work it in.

> Also any driver that supports receive timestamp must provide
> a read_clock operation. Otherwise the application has no way of knowing
> what units the timestamp is in. I added that to the AI review
> script so new drivers will get rejected with out it.

Ack.

> I suspect that in this drivers case it is only used in systems where:
>  - only single instance of device is possible
>  - your application is just assuming a common unit like nanosecond.

You're right.


More responses in another email thread.
