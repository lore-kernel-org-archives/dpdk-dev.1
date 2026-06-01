Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF72CD6E55
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 13:36:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 628444025F;
	Mon,  1 Jun 2026 15:36:33 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id CC3CE4025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 15:36:31 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.stl.internal (Postfix) with ESMTP id 795DA1D00548;
 Mon,  1 Jun 2026 09:36:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Mon, 01 Jun 2026 09:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780320990;
 x=1780407390; bh=UqQMQYdk7Zd/xfuuU92Oxjftd5Ry19NZRMe1xStityE=; b=
 aOA2sKL8ScR29qHXMnB9AOq4NDrQXICGbPS6XKqC+iY8NDVRGOjVWT090fR3nFNY
 9WLvGPEZNF8rhgFvpZemtWxROhSA1qn59DBO28iUDfU34oJ7iYKikIyALgnggvW5
 MseObe/j8o5KhkrbqALHHHVAlTfd0HTyJklELsuZXfKDGpXAxKx3+nmitQXW5QTX
 lG/RHRtyVWo+E4WKeqy6EA1qiphQ5jtqrXLe+eqSI1wQX/QTi5i73AJHMjiZ/SRj
 9LgBqefbS88kPK67Je5dVHVndr5hN8KVu5mjXIYURttQlZ1QfJdyHzz9+QbWWxO7
 L0b84BUiiZ9O/gRermA63A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780320990; x=
 1780407390; bh=UqQMQYdk7Zd/xfuuU92Oxjftd5Ry19NZRMe1xStityE=; b=X
 aA9r9YrX4yUtA+uiMDazA8kpAUmwhrHt8kfWIC5MfHHv9WYtCpGc9HV+l3hSSNvR
 jQ68ndGo1bGZRKHT1o3kseuHuRArXAr5lKhj3fcp2J/f12Bgd4EDDQt8BeROTrkQ
 afYqB22aV5fVTdu4WPaGD2u+jvDMWXxoNxurHut+w8H/Xar9jpvYw5ARxZlTuEYr
 M+Lkpc1TB/G9/FpMZ+O1SuZVTqMfRzF9phSKphkvUrlplS+MphIN8fcav8byu5zD
 ROE0+YqHe1Mz66QvhDB7Iu3zjhTfJiecVj4TJAeKgBcoXz9QtNdbf8l3IrEIQZWI
 MN6OdUIN9uex6qsMcSl0Q==
X-ME-Sender: <xms:3YodauEDcMBWt1Yq6Qxph-kSfH8LG_71IKaEyVXkElsvu-U_o-YKRQ>
 <xme:3YodaubHAtMBVD2pdjQelhal08ce3kcVfCaMkQWalf-zdAiD7C8PiYDHabl7Kosup
 91f7jCW43IeYUGloAQP72eBHGmm0jFrJdXC_DDOjBC-e9yD7m4IeA>
X-ME-Received: <xmr:3YodauV-XKeNqFor8B9cKIziIwJyTrI4GhOKa9XwMnbCmui-qpQyiyhd243cTBaTOpxRPqHL12D1js7bxOvi5e34OQ>
X-ME-Proxy-Cause: dmFkZTER0e09ErAZatlrmVns9Lv6CGgWMpx6cvKT+E90qejKAQfjweGyN8gyvwg6LrMcj7
 RiaA6+59FQSOJDWoUzp5Sp5OyJooLSXNpnmL9kK3PjQsQSgO8KZf9BbLfiFQiaXgu7T5jN
 AcfYp55Cfv/6yVCK2Q3OumQvGQu3NgeFEBxllWHxjuVn+ko9beTX3MPtyYRxRnHXSGn48z
 +J5toK+1fR6GPEnB3Zc5JOmbcZmODYLu4SVy+VjgDgxxImsouFNncleXsbjNvOaiX6uy3n
 rPJvtK9PP5jre2G4P6WY554sqq6/XI4Ouz0/WjImI3R0nEmP76+OGmyGsDdLZFgDSmbtA2
 dI0dyMw20EOpmOXdCWhEFXVhEshel7CBXDy1P6mNQAra3vssUg/vHY6QmxndFCz86RVR0J
 vCi1DWZwdD0VTWef5oSHi0udmmsp8hI0ev3HwwIaFPA63JyG+1g8ZRVoBoGOc8cLVKAmXB
 XpUuN0AUGDoA1NKNudo5ihxjjC4ZuWncbJ1wjVjgEgEGxq1t5fE+PTX9k8vo7u2cHfymmR
 E11OZHQYU4X8LZ/LvhjmGZmf/zk3RTNXimHmHGuQxvN1wxLXIVGDy0dcdsViPndKhfk0La
 Eb99VbhLI20ejd07oY1It/umgV+s45rFUNkMGzFwqz9BO/pEhfnIcluVkf3g
X-ME-Proxy: <xmx:3YodaknjaGImD_CTss-Wi8aGC0p-tvNHEkXYzgyLK0qgDv_Por-OCw>
 <xmx:3YodapDqZiBL5E2MG27FYWEtvLQQJjCj6wZBtn7QKZwSmmhs0_Oi1A>
 <xmx:3Yodajg9B0CHQM60l6S8tLiahsRq4DImRhgoam1Du7fbLMmhoSeRdg>
 <xmx:3YodamyxeEYTsLZft1hI3j-2i-NvaXitJqJKjzW15_MHQ8dgufl4gA>
 <xmx:3oodaqaqIhjgF-BGimSc17MmtubT-C59g2ZMVFy3KJZWg-4CPCl0_y7E>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 09:36:28 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@oss.nxp.com>
Subject: Re: [PATCH v6] mempool: improve cache behaviour and performance
Date: Mon, 01 Jun 2026 15:36:26 +0200
Message-ID: <0b8SMRhASVKQeU9e_kqJHQ@monjalon.net>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6589E@smartserver.smartshare.dk>
References: <20260408141315.904381-1-mb@smartsharesystems.com>
 <20260526140000.175092-1-mb@smartsharesystems.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6589E@smartserver.smartshare.dk>
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

26/05/2026 18:00, Morten Br=C3=B8rup:
> > From: Morten Br=C3=B8rup [mailto:mb@smartsharesystems.com]
> > Sent: Tuesday, 26 May 2026 16.00
> >=20
> > This patch refactors the mempool cache to eliminate some unexpected
> > behaviour and reduce the mempool cache miss rate.
> >=20
> > 1.
> > The actual cache size was 1.5 times the cache size specified at run-
> > time
> > mempool creation.
> > This was obviously not expected by application developers.
> >=20
> > 2.
> > In get operations, the check for when to use the cache as bounce buffer
> > did not respect the run-time configured cache size,
> > but compared to the build time maximum possible cache size
> > (RTE_MEMPOOL_CACHE_MAX_SIZE, default 512).
> > E.g. with a configured cache size of 32 objects, getting 256 objects
> > would first fetch 32 + 256 =3D 288 objects into the cache,
> > and then move the 256 objects from the cache to the destination memory,
> > instead of fetching the 256 objects directly to the destination memory.
> > This had a performance cost.
> > However, this is unlikely to occur in real applications, so it is not
> > important in itself.
> >=20
> > 3.
> > When putting objects into a mempool, and the mempool cache did not have
> > free space for so many objects,
> > the cache was flushed completely, and the new objects were then put
> > into
> > the cache.
> > I.e. the cache drain level was zero.
> > This (complete cache flush) meant that a subsequent get operation (with
> > the same number of objects) completely emptied the cache,
> > so another subsequent get operation required replenishing the cache.
> >=20
> > Similarly,
> > When getting objects from a mempool, and the mempool cache did not hold
> > so
> > many objects,
> > the cache was replenished to cache->size + remaining objects,
> > and then (the remaining part of) the requested objects were fetched via
> > the cache,
> > which left the cache filled (to cache->size) at completion.
> > I.e. the cache refill level was cache->size (plus some, depending on
> > request size).
> >=20
> > (1) was improved by generally comparing to cache->size instead of
> > cache->flushthresh, when considering the capacity of the cache.
> > The cache->flushthresh field is kept for API/ABI compatibility
> > purposes,
> > and initialized to cache->size instead of cache->size * 1.5.
> >=20
> > (2) was improved by generally comparing to cache->size / 2 instead of
> > RTE_MEMPOOL_CACHE_MAX_SIZE, when checking the bounce buffer limit.
> >=20
> > (3) was improved by flushing and replenishing the cache by half its
> > size,
> > so a flush/refill can be followed randomly by get or put requests.
> > This also reduced the number of objects in each flush/refill operation.
> >=20
> > As a consequence of these changes, the size of the array holding the
> > objects in the cache (cache->objs[]) no longer needs to be
> > 2 * RTE_MEMPOOL_CACHE_MAX_SIZE, and can be reduced to
> > RTE_MEMPOOL_CACHE_MAX_SIZE at an API/ABI breaking release.

I'm not sure why waiting?


> > Performance data:
> > With a real WAN Optimization application, where the number of allocated
> > packets varies (as they are held in e.g. shaper queues), the mempool
> > cache miss rate dropped from ca. 1/20 objects to ca. 1/48 objects.
> > This was deployed in production at an ISP, and using an effective cache
> > size of 384 objects.
> >=20
> > Bugzilla ID: 1027
> > Fixes: ea5dd2744b90 ("mempool: cache optimisations")
> > Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
>=20
> Forgot carrying an Ack over from v5:
> Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
>=20
> > ---
> > Depends-on: patch-163181 ("net/intel: do not bypass mbuf lib for mbuf
> > fast-free")
>=20
> This dependency seems to cause CI apply failures.
> The dependency is based on an older snapshot of main,
> and this patch is based on a new snapshot of main.

The dependency should be resolved now.
Please could you send a v7?


