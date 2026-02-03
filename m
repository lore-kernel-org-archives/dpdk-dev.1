Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CCEE83059
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 06:36:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4938940281;
	Tue,  3 Feb 2026 07:36:13 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id B05284026D
 for <dev@dpdk.org>; Tue,  3 Feb 2026 07:36:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1770100572;
 bh=zqK0Eh55C5vDAF/r4eO59oDPf9v2FwJg9K13uWrIjOs=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=MmkElUUOBM3/oUmwBlkTQteXpxOCirQmEK56JmbuNPjGHADE6n5k6bvn3sSj37UaF
 Fk3BfquFUhQ9ZS7zGZH42TO8F7GhwAfmKuyyxAWCm2FiVSlHxbvjw+KZNhqlCySSkx
 Vg33Fhr+qs55OWvl/Xzse5zwuBebbnDzQ6KdEJkWIO1AxKSzql6UtBvgg4HUlkpd9+
 pUX2MUXG/o8wGdN0QBpNZkM857cfIcPkqLvH8ESrXW5qvMmm3QtLQtX5scewVM9tnA
 HozX3LdW9enr0m65fiPoIdUumSOTFURyqJEwEiC/3HdyihDIT3y7MrXPfZRDuPtYl0
 9Ji/eVp0upcrg==
Received: from [IPv6:2001:718:812:27::107] (gtx107.cesnet.cz
 [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 3D6DC1180072;
 Tue,  3 Feb 2026 07:36:12 +0100 (CET)
Message-ID: <79cb695001cfe5022def4bb339d56e88f9e3ccc7.camel@cesnet.cz>
Subject: Re: [PATCH v5 0/6] net/nfb: code cleanup
From: Martin Spinler <spinler@cesnet.cz>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Date: Tue, 03 Feb 2026 07:36:11 +0100
In-Reply-To: <20260202175013.64da846a@phoenix.local>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260202193330.3324681-1-spinler@cesnet.cz>
 <20260202175013.64da846a@phoenix.local>
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

> > Patch 2: The new queue iteration still doesn't NULL-check the per-queue=
 pointer before dereferencing. Given the commit message specifically calls =
out the pointer validity problem, this seems like an oversight.
> > Patch 4: rte_zmalloc_socket for a small control structure of file handl=
es is using limited hugepage memory unnecessarily =E2=80=94 plain calloc wo=
uld suffice.
>=20
> Patch 4 raises a good point, file handles are per-process so doesn't need=
 to be in hugepages.

I'll keep that in mind for future changes.

> Not sure about comment about Patch #2. The queues are set to null on clos=
e. So there might be small race with another process getting stats.

Oh, I see. The original problem (described in the commit message) has
been solved, but in the case you described, checking for null is still
not enough and some rte_spinlock_lock should also be used.
