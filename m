Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82636CC6B08
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 09:02:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6796D40272;
	Tue, 13 Oct 2026 11:01:59 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id 64B89400D6
 for <dev@dpdk.org>; Tue, 13 Oct 2026 11:01:58 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id C6ACD1D00085
 for <dev@dpdk.org>; Tue, 13 Oct 2026 05:01:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 13 Oct 2026 05:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791882117;
 x=1791968517; bh=+aUkvx59KErFGnZV02apZ2LVTehYsQNwH3VgN9Dc9uU=; b=
 Q5oIIslTvF1Ca4WDEK3ZnshGiRi+LL5Jsn8i0CCVdeXv/NWIjdoREi4aDi2rEOJ8
 aa6jnN17erPbXB3hrI0CG+C2pIaI+ood6qvtHDH6gIICFlPTiA+ZCvMZp451Kq9F
 kExOspgqGmgwbtXUVifP3+PQgeSSJhDFLxHk6Gh0/lHcwYvpjqS732QysyMpOv0o
 mm0M3npKdFoWvD+7K3SyxMNIhiUOzta6XOxNO5WiHL4hKvbDb2lN2YJ3RdshjyDo
 nfOK44zlowAYzeyRZO/2e+RgxKqH6DASWDjZqiEGA6p7joKgAKbs2rOjJ9AS6dU6
 6VdrE9W0aE/hlsnf7Qi4PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791882117; x=
 1791968517; bh=+aUkvx59KErFGnZV02apZ2LVTehYsQNwH3VgN9Dc9uU=; b=a
 Cpn0fqLCyncJ9FZtL9bdMLjhPP5F8HLCTqWIeoJFBspZV16LeM/KRSx/vqbaMgeL
 jIYnGCs4jH+XhSp8atQ+0ZYdaxn7j/6dzxpgXXFzsE77OLs92hifJwY25LAS2Hmd
 EJhPzMl0TC6WJJCY7vIoqZlSG1SbmWLf+nepoi6Eb5GUzMygkhVI2yJVUPfBF7nD
 3eOxuu+h24lmPxikd4O8iicHycPtg6mfTcnonh6WaNMvwjw1bitZUz3Lg8QwF5L6
 DCcduK7DJVDEvuZWnanb6ttTaxYUxnNBOtjNf8SlfuAfVFU5cGXpXlti9RZUkuDD
 LNZWg+RHA/QGWomf5hGKA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791882117; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:FXht+OTrDgDB2s9851/MjjK2+OVlxj3Ak+q4XonUpsmo0wr
 y17GPvm95H20wVLgPpqprRKLdoW/5gEPoRKbPctnz3TejeF66kYFFjpzo22sTCv2
 aMMsXojRDM7PSvY1OZjoxXSvlNwMTR3j12gEKBwHlUq8z88ciBi9xWmjd3e9DmS/
 25+8jJBsrRZd7Tz59X2wzMSvIvafvshtTwCQYPVvVrXZwzJRv3VzGZo7w8QEWjgt
 L0WYeXCxSLCQdGKJwlZDbwapzY1EVsNn7IO3OF31a/izrGbSAtob+zrF2ejpLW3e
 ieY7xWRMF/XgJVVbmYUbT7sEdOb2VeOJHahJZIA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:/4RvimRyP/82SqoYwWO9lUPV2BgrgTaNRW3P1hcApkQ=:GiuvAXXdsoycuA1DtJ2kDBq9OlHBmK2lD96rMexdhSE=;
X-ME-Sender: <xms:hPPNajLNWjSjIuR30Xm03HRdwpTiOia4bW5pZrBfyr_Uml8LbMMf1g>
 <xme:hPPNaiFpTPRuVdl2XXtcW4Yz--XaC1hcJdHbLMTrlWlL0nYqn47TimJh5EPVQ-oYh
 jBKSqUfLt36rsRyJ759ALEhkbcefw9gzQ-eqPnSlW3ZnNz00faK-hk>
X-ME-Received: <xmr:hPPNaqvfcEGCxnOCuPVfFZsgonkomVtd14g_I363xSg2RhNruC8yYoh3UdFW8cnrobIJk78fLkyXA5uhkgezAZk>
X-ME-Proxy-Cause: dmFkZTFwjhQ9BY25zxFK5dVN/W/ccgZ/lSL3AUb7E+h9isRI4ZlMReW0NMVmvWnlbECbtN
 OImDc0xrbK5C2c24Al1KcEoMpZeVO9O2UvWKs60VBMMcqdttnZrLHAVrOudIHhNclKwvZ+
 MZGNUUbRWO5vR7Z0aVDdBl0Bu6a5HqQk1zlqy1+qulopm7DQ7UsC6GRiqekxlsw50On+rw
 Dbyc5XVuYMCIrrRRo5Ackf8hkR39gv+jgne4yfvgCtluemk7X0QOfvNW7rlMoMdNT6X6ge
 ztO1+hqxuRhjzMCk38uu9+B8y9A40Gl9qf6oArH8/Xgw1VExmAJX+WEr1d5Q4sk22oIPrn
 8nKhntnOtMrHI2PeTVJ39a03eryiKlfgzTNW1by6SnvLcWGdzDWET62Q6GkIRAzUyhwmQq
 0I/yFA8sQbsspYqcWYrmUns3vWl0+ZOCHINOiz+fWuXdUNESt0fXPxKhU/mABDhXyi9HNS
 UKN0ew71TGLYttMis7WTpgDbz8r504J+PqlkkdaASbJpcgSzvE2Nl5inHcW4BxuvPeo23v
 Mcc656ubL/BrVcEUu/ztvm5Iy2p4dPBk7IgW3NjJlKHIbBC1yA6Arq0RrlODw/oZTCh8io
 kEJNvpTY19BdxxWiICHwsDkZif/URyjZJpINDjOP2AMvp5kPZ/MAgByedFPA
X-ME-Proxy: <xmx:hPPNahvidMCICUZ_EgW3L3t11NiWGXoHUSXF8e0gvMB8GHmkBSMlTg>
 <xmx:hPPNaoBjELtTdBPcj6JlrIjLnvlGFXfM5w4VeMORwqWZfVOuVGLCig>
 <xmx:hPPNarPLDqgjRHyeaM_VFgbZntOLaVNtJ156CFiZeKOxiCOpjtNaGw>
 <xmx:hPPNapxhCCSUw2q5dke9HPhfm54NudSJhj8yCorDhgbCc8To3WjZfg>
 <xmx:hfPNalGjkuNpJfuDc0pFaRYmOea_0I69yloisWZEQrCYRCB_vGoDp1ao>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 05:01:55 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Subject: Re: [PATCH] eal: increase memzone name size to 64
Date: Tue, 13 Oct 2026 11:01:53 +0200
Message-ID: <0ZnoHtjRTOGafUSZQedaXA@monjalon.net>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65A5C@smartserver.smartshare.dk>
References: <20260921215733.404686-1-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F65A5C@smartserver.smartshare.dk>
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

22/09/2026 12:42, Morten Br=C3=B8rup:
> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > --- a/lib/mempool/rte_mempool.h
> > +++ b/lib/mempool/rte_mempool.h
> > @@ -230,13 +230,11 @@ struct __rte_cache_aligned rte_mempool_info {
> >   * The RTE mempool structure.
> >   */
> >  struct __rte_cache_aligned rte_mempool {
> > -	char name[RTE_MEMPOOL_NAMESIZE]; /**< Name of mempool. */
> >  	union {
> >  		void *pool_data;         /**< Ring or pool to store
> > objects. */
> >  		uint64_t pool_id;        /**< External mempool identifier.
> > */
> >  	};
> > -	void *pool_config;               /**< optional args for ops
> > alloc. */
> > -	const struct rte_memzone *mz;    /**< Memzone where pool is
> > alloc'd. */
> > +	struct rte_mempool_cache *local_cache; /**< Per-lcore local cache
> > */
> >  	unsigned int flags;              /**< Flags of the mempool. */
> >  	int socket_id;                   /**< Socket id passed at create.
> > */
> >  	uint32_t size;                   /**< Max size of the mempool. */
> > @@ -257,7 +255,9 @@ struct __rte_cache_aligned rte_mempool {
> >  	 */
> >  	int32_t ops_index;
> >=20
> > -	struct rte_mempool_cache *local_cache; /**< Per-lcore local cache
> > */
> > +	void *pool_config;               /**< optional args for ops
> > alloc. */
> > +	const struct rte_memzone *mz;    /**< Memzone where pool is
> > alloc'd. */
> > +	char name[RTE_MEMPOOL_NAMESIZE]; /**< Name of mempool. */
> >=20
> >  	uint32_t populated_size;         /**< Number of populated
> > objects. */
> >  	struct rte_mempool_objhdr_list elt_list; /**< List of objects in
> > pool */
>=20
> I have submitted a patch introducing a new "sizeof_cache_per_lcore" field=
 [1].
> This new field must be close to the "local_cache" field.
>=20
> Also, for mempool cache misses, the "ops_index" and "pool_data" fields sh=
ould be close together. Optimally also close to the "local_cache" field, so=
 they have been fetched with it.
>=20
> [1]: https://patchwork.dpdk.org/project/dpdk/patch/20260910103613.808038-=
7-mb@smartsharesystems.com/
>=20
> AFAIK, only these four fields hot in the dataplane:
> - local_cache, sizeof_cache_per_lcore (new field):
>   Used for access to objects in cache.
> - ops_index, pool_data/pool_id:
>   Used on cache miss for access to objects in backing store.
>=20
> The other fields are not used in the dataplane, and can be moved down bel=
ow these four, which should be first.
>=20
> Note: The cache_size field is currently hot, but my patch makes it cold.

These changes in mempool are marged in main.
So this memzone series needs to be rebased.


