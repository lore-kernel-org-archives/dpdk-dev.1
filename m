Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8E2CD6E57
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 14:19:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E19D4025F;
	Mon,  1 Jun 2026 16:19:39 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id 981FC4025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 16:19:37 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id A08801D004A3;
 Mon,  1 Jun 2026 10:19:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 01 Jun 2026 10:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780323576;
 x=1780409976; bh=x/EEmQcDCCLdVmiV1VFX2nn9SCQ25XiE2EtA2sYCaUE=; b=
 CKMfKDGhCghJ3GY6WqCU2f6++wikF99w7TtMQusn04QbJKwY1m860bOvFtKBPsB4
 RSVsgh7z+npOiGLO1AwsmAxgZ6fgiVtHT4QeIWkQSDIVLYuXQUJT5XbOyJAvZxuT
 8EkCPURXCM9d6+taO7a2PMZxcsfsFADOLscRi1SfaTJkKJSxVBRfJGc8wzDpko45
 xPrvsqwnm2pqirvWeeddu/D4xEYlG95nYoh8toZfDvsd4aOqbrFxT8VzN1IdF+T7
 RmlFOrjGqodE/gh6zlWQh7kXTVYEO8sjdEUSbAW0OeF8l052yBc33CeWDQV2y7cA
 asnsr6ne+n7MD4diZJa9Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780323576; x=
 1780409976; bh=x/EEmQcDCCLdVmiV1VFX2nn9SCQ25XiE2EtA2sYCaUE=; b=I
 1Jaf3ULcCJ4HPQTRvjdLpHK6PCaFvy+8dTtxmjCilG87Ic33T3dRcy3hshltuvf3
 JE5ELFS9DAdd92qv2HzeW5cEkn0+7N57SrcTZaUFy4sOlb9jG68i+qpUDrfsi89R
 U8upAWbJzNPhqw6gNc0gy9acB3zloPQhUIAVHQFgF0lRrq0PnwdHYuEdc22mP4Zr
 oiJhdKxgnjTYx+v4QYRHprJLKoL1WB0NqZppA7YwzsM3niMJem6tLPa103qgpBYw
 o4efk7PDJvAb10AcTj/4fApeRbjhLvXPwC0rBQIif116VVkpfWTUt4SI8E1AE11H
 DJMP+WHq2uXds701IDbkA==
X-ME-Sender: <xms:95Qdan-DGZ4GupyR4EOtcYCds5dlUKljECbHrX1o8pu0_9UWTekA0Q>
 <xme:95QdaiwSfibe1cAVEURfgVGcAnvKD3NiiZx0UiXJ8gx8m3VBOs0lh35havlVIgxQ4
 sbIa4ntKFw8GoqnN2CqLybzGxJeaK3yRsPwt9c2u-rvJp55Sf3H>
X-ME-Received: <xmr:95QdarMCHiRV-wYi4CqQFTk92uV6-2Q6BTYXFlqYnU9b0_8phLEAbGPptU3yulimfwaBtk6LwTbnWtnMIA-a4CZYvQ>
X-ME-Proxy-Cause: dmFkZTEmQf9pNSF7mHTgunptbNreUGIktO7k4kN4MI7Iuj4lKp0wcKE8hQb9+zm1IuVsyg
 VqfVoWBElkWsvX3Vfdgwjp/BKMCIwXrZAIHfXu+0gKUZ9iS6Au7rQ5Lg75jQDplIjOnW0U
 0EwY0yB1ZUUjgSoUi+cIKbZ4kroKerrAMz8ux2hoXQeLMJZXTRJckQYhyUgPfUWHAgnE4g
 y2xERudjF63PufrAyVPvWx8WSk8Da0B74jvYVz5QsiOnqBZCe/ro1G2GaS+ZnH6o5RDQFd
 6mjmWTxSsSaW/vaHGqFntzS3RNiy1gNalMVh4uWdZy/3dtV+WvHtOQvEO+PfbjUrP+dHtZ
 C5lKtx3ZylrqEXZUZjNjwonFXqBLWb/Hinag3Ws6H7uuskFaeUhk4k2ZVMSVIbxoMcqj8g
 S2d3P4RYwWgPXtXkRPpmJ+vdnYavzkTZ6RLjgA+f80WpIv8i2BQbHsvcr9Bq8VQ3nJ7vKC
 aXQ5w18HG4QiJmf7cQjF1bFDEBxI8gqCm8+NP68Kqgcutlr/FZPNUBo8dJ24+mvyEpLSz+
 sDLWGjJFDNtLO2H1+eVMMVFxdweNEz/UYvWc5ZKLCGqiJ50DXzcUFC30D5+Ogdc2TrGju9
 2Qx4h6gG0Ov/VXGkIFK93zYFHBBeOIKk4XcCIGIrGyUuUxQFLra2DOcosyeg
X-ME-Proxy: <xmx:95Qdav8VIYMzy_-_5dSEkxw_fX3MhOrr6Ptm8_bjmeQKox6UKycfTg>
 <xmx:-JQdag4GLCBYMgaYxswiFaNQINKTfOqBtl1u27da0wDpkiNHkiGcXQ>
 <xmx:-JQdat4lz9kCFIwMOfm4Vl3yaP45MDzcBkkcL1PqaxcMx8oaSjgJjg>
 <xmx:-JQdahrko8i5taGRyrAorQc8BRZMQKK-1DsbQTy2LDtqBVIeEtqtAw>
 <xmx:-JQdauTlhpE4b51KydHgEZ7J4pscGGqZ8amqo-CX72oWzJ2kCw9bAD3X>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 10:19:34 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@oss.nxp.com>
Subject: Re: [PATCH v6] mempool: improve cache behaviour and performance
Date: Mon, 01 Jun 2026 16:19:33 +0200
Message-ID: <6w4sxDwSRYyFMvKExI5ztQ@monjalon.net>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F658CC@smartserver.smartshare.dk>
References: <20260408141315.904381-1-mb@smartsharesystems.com>
 <0b8SMRhASVKQeU9e_kqJHQ@monjalon.net>
 <98CBD80474FA8B44BF855DF32C47DC35F658CC@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

01/06/2026 15:51, Morten Br=C3=B8rup:
> > From: Thomas Monjalon [mailto:thomas@monjalon.net]
> > Sent: Monday, 1 June 2026 15.36
> >=20
> > 26/05/2026 18:00, Morten Br=C3=B8rup:
> > > > From: Morten Br=C3=B8rup [mailto:mb@smartsharesystems.com]
> > > > Sent: Tuesday, 26 May 2026 16.00
> > > >
> > > > This patch refactors the mempool cache to eliminate some unexpected
> > > > behaviour and reduce the mempool cache miss rate.
> > > >
> > > > 1.
> > > > The actual cache size was 1.5 times the cache size specified at
> > run-
> > > > time
> > > > mempool creation.
> > > > This was obviously not expected by application developers.
> > > >
> > > > 2.
> > > > In get operations, the check for when to use the cache as bounce
> > buffer
> > > > did not respect the run-time configured cache size,
> > > > but compared to the build time maximum possible cache size
> > > > (RTE_MEMPOOL_CACHE_MAX_SIZE, default 512).
> > > > E.g. with a configured cache size of 32 objects, getting 256
> > objects
> > > > would first fetch 32 + 256 =3D 288 objects into the cache,
> > > > and then move the 256 objects from the cache to the destination
> > memory,
> > > > instead of fetching the 256 objects directly to the destination
> > memory.
> > > > This had a performance cost.
> > > > However, this is unlikely to occur in real applications, so it is
> > not
> > > > important in itself.
> > > >
> > > > 3.
> > > > When putting objects into a mempool, and the mempool cache did not
> > have
> > > > free space for so many objects,
> > > > the cache was flushed completely, and the new objects were then put
> > > > into
> > > > the cache.
> > > > I.e. the cache drain level was zero.
> > > > This (complete cache flush) meant that a subsequent get operation
> > (with
> > > > the same number of objects) completely emptied the cache,
> > > > so another subsequent get operation required replenishing the
> > cache.
> > > >
> > > > Similarly,
> > > > When getting objects from a mempool, and the mempool cache did not
> > hold
> > > > so
> > > > many objects,
> > > > the cache was replenished to cache->size + remaining objects,
> > > > and then (the remaining part of) the requested objects were fetched
> > via
> > > > the cache,
> > > > which left the cache filled (to cache->size) at completion.
> > > > I.e. the cache refill level was cache->size (plus some, depending
> > on
> > > > request size).
> > > >
> > > > (1) was improved by generally comparing to cache->size instead of
> > > > cache->flushthresh, when considering the capacity of the cache.
> > > > The cache->flushthresh field is kept for API/ABI compatibility
> > > > purposes,
> > > > and initialized to cache->size instead of cache->size * 1.5.
> > > >
> > > > (2) was improved by generally comparing to cache->size / 2 instead
> > of
> > > > RTE_MEMPOOL_CACHE_MAX_SIZE, when checking the bounce buffer limit.
> > > >
> > > > (3) was improved by flushing and replenishing the cache by half its
> > > > size,
> > > > so a flush/refill can be followed randomly by get or put requests.
> > > > This also reduced the number of objects in each flush/refill
> > operation.
> > > >
> > > > As a consequence of these changes, the size of the array holding
> > the
> > > > objects in the cache (cache->objs[]) no longer needs to be
> > > > 2 * RTE_MEMPOOL_CACHE_MAX_SIZE, and can be reduced to
> > > > RTE_MEMPOOL_CACHE_MAX_SIZE at an API/ABI breaking release.
> >=20
> > I'm not sure why waiting?
>=20
> Because the rte_mempool_cache structure holding the array is part of the =
public API:
> https://elixir.bootlin.com/dpdk/v26.03/source/lib/mempool/rte_mempool.h#L=
113
>=20
> abidiff complained about it in v1, so I reverted the array size reduction=
 in v2.
>=20
> >=20
> >=20
> > > > Performance data:
> > > > With a real WAN Optimization application, where the number of
> > allocated
> > > > packets varies (as they are held in e.g. shaper queues), the
> > mempool
> > > > cache miss rate dropped from ca. 1/20 objects to ca. 1/48 objects.
> > > > This was deployed in production at an ISP, and using an effective
> > cache
> > > > size of 384 objects.
> > > >
> > > > Bugzilla ID: 1027
> > > > Fixes: ea5dd2744b90 ("mempool: cache optimisations")
> > > > Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> > >
> > > Forgot carrying an Ack over from v5:
> > > Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
> > >
> > > > ---
> > > > Depends-on: patch-163181 ("net/intel: do not bypass mbuf lib for
> > mbuf
> > > > fast-free")
> > >
> > > This dependency seems to cause CI apply failures.
> > > The dependency is based on an older snapshot of main,
> > > and this patch is based on a new snapshot of main.
> >=20
> > The dependency should be resolved now.
> > Please could you send a v7?
> >=20
>=20
> I'm not 100 % sure, but I think the problem is CI only...
>=20
> This patch is based on main, so it should apply as-is.
>=20
> Bruce has already applied the other patch (that this one depends on) to t=
he intel-next-net tree.
> The other patch is based on an older snapshot of main, so when using "Dep=
ends-on", I guess the CI bases its series on the other patch; and then the =
CI fails to apply this patch (because it's based on a newer snapshot of mai=
n).

The patch is in main since last week.

So you could send a new version with the ack and it will run in CI.


