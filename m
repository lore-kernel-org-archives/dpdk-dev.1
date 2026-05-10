Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E04CD3427
	for <dpdk-dev@archiver.kernel.org>; Sun, 10 May 2026 15:21:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AAEC740272;
	Sun, 10 May 2026 17:21:26 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 705BC40270
 for <dev@dpdk.org>; Sun, 10 May 2026 17:21:25 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2ef38cf04f0so5053558eec.1
 for <dev@dpdk.org>; Sun, 10 May 2026 08:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778426484;
 x=1779031284; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EzxLdq2nnEqFKdLj/qC9rTLt7YUff+ubTJAOd70JS3g=;
 b=RROU8jl1xzgz3tWehbcIK4kD2bkG1OnjYc+R4E2uWZwkQPIKhX1YyZJXS3bafnhI9+
 iu+lCDB91Kmse/aC30/T6t4++6js8CIAFYhI/Sui+U0EBH2jyH4dSC3Tcf+p+Io+rLOC
 Vgg+RaTE+whPixBPdSZLPNitC/uO+4nGwY/zp0T6SGqju++g7tfhxt+V/MizwHfC99ch
 2FbJD2jRk3mP4G5wjMfcDfKX7DETfcyiEoN0d8iFBgIoj//0TZIBvL4aNriFS0R07hV7
 GaHtDui2fSMbSewWX5Xw686kXx+RoPke9k290+8qD4WwLL1Bg0qfI8dW4eOeJradxrnD
 9A0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778426484; x=1779031284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EzxLdq2nnEqFKdLj/qC9rTLt7YUff+ubTJAOd70JS3g=;
 b=RETHNfC6CMkKV2b5u0EqK6rsTsEp+PFnKxHji1Jh2mCX7S6TNqtBieH1V+A54JZOQh
 kV7ByNcuOFSG/yU1SDQcOB7JgsZPWPfaVijWTNx/IpmR1UNRnrKiovLnLgqTZtgBTnaN
 dR9jG5kdxIDQ/9OIMZ7SIkgNuyf6dEMT46P8KCNre+uIHJC+fc13Xdi82hRO1I4H/iu7
 6ibxa1KuDi10Zja6SBgSBMLXIDXfC2HHltY0RvlBjBZKqtJDLWA0kuH8wsUkZoN4FFLG
 1Y4XvD04YU5G+msnJ32RSRqKXPI4rsfkMPaOO4Ix4Fu9zHSqXm9/Z2AHJzeRxy9gynYp
 iUwg==
X-Gm-Message-State: AOJu0Ywmo+sf5p7ItNARgR1Qg3wS2IdtXO3qpf+14ZxY0LWbafeY484w
 +m1tsoHNtib5UqV1roTabsC4VtXHCO1NMhRy8viro9fl/jTEw0cC5R8xpsRxxHTOKNyuWryH8jb
 zUfKgkF4=
X-Gm-Gg: Acq92OGkJei/3T9foiI0u+Aizm7fIlnqfuwZrGt7ikgUewaTZ+SrhsJwiiLAJpiVwis
 jComxN8uf7GRMJ0sKNzaxucEZVQEiO4bSWum2BjsVgTzDqqPF8Ws4im9cDKi44GdmAP7C60TZoZ
 qyZKoYUSItjI/Ro7AAKKh5YM4Qfk/W/nrc+aIkGOxiKvtNoMd+HbhMoGroRbXi+huRUKIapuGLs
 8eSMcQl0qY85q7YM0+VRs0rGXtBWwoQBtEKlAXuqJZ2VX6pV1iWqSw8mu7udIPYiRxxcnrYdpEF
 EgVbRPHiHwZ4Xxh8dcA45IIEdRY24hKuAG1LFrN/BcF/XZRqsLb43RGieREfoMY1ahXRRBpriTY
 jRc9wO4GOpVWlRZFu/OeY1gUd7nv8gMgRBR8L2Zr0RqmZPercB46i42IkmpSOYimAJpDG86PhlG
 s9qKbpbth/E+F347ESiHDGPMR5XaeIgewJlsRRoACU0Teebg==
X-Received: by 2002:a05:7301:1292:b0:2e2:3381:2fba with SMTP id
 5a478bee46e88-2fb3dbf9968mr2500841eec.3.1778426483986; 
 Sun, 10 May 2026 08:21:23 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8864c37basm9843665eec.13.2026.05.10.08.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 08:21:23 -0700 (PDT)
Date: Sun, 10 May 2026 08:21:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH 13/20] mbuf: allow NULL array in rte_pktmbuf_free_bulk
Message-ID: <20260510082121.7da55e33@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6586C@smartserver.smartshare.dk>
References: <20260508203607.1003036-1-stephen@networkplumber.org>
 <20260508203607.1003036-14-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F65869@smartserver.smartshare.dk>
 <20260509084657.598eebfb@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F6586C@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Sun, 10 May 2026 14:31:57 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Saturday, 9 May 2026 17.47
> >=20
> > On Sat, 9 May 2026 10:47:53 +0200
> > Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:
> >  =20
> > > > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > > > Sent: Friday, 8 May 2026 22.34
> > > >
> > > > This allows callers to avoid NULL checks and just call
> > > > rte_pktmbuf_free_bulk, similar to rte_pktmbuf_free.
> > > >
> > > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org> =20
> > >
> > > I disagree with this patch.
> > >
> > > The parameter is an array of (pointers to) mbufs.
> > > We already accept that the array can contain NULL pointers (no mbuf =
=20
> > present). =20
> > > This is extremely forgiving, considering that other fast path =20
> > functions don't allow NULL pointers in arrays; =20
> > > e.g. rte_eth_tx_burst(), rte_mempool_put_bulk().
> > > But since it's a "free()" class of function, I don't object to it.
> > >
> > > However, this patch changes the parameter type from "array" to "array=
 =20
> > or NULL (no array present)". =20
> > > And I don't think we should change the parameter type; it should =20
> > remain "array" only. =20
> > >
> > > If there are any scenarios where a non-present array (NULL) is passed=
 =20
> > to the function, the count should be zero too. =20
> > > And when the count is zero, the function does not dereference the =20
> > array, so explicitly checking for NULL is superfluous. =20
> > >
> > > We have a convention of not checking parameter validity in fast path =
=20
> > functions. =20
> > > And I consider it invalid parameters passing NULL with a non-zero =20
> > count. =20
> > >
> > > You might argue that this is a "free()" class of function, which =20
> > warrants checking for NULL; but since it already accepts NULL with zero
> > count, it is already covered. =20
> > >
> > > We could change the function declaration for clarity:
> > >
> > > void rte_pktmbuf_free_bulk(
> > > 		unsigned int count;
> > > 		struct rte_mbuf *mbufs[count], unsigned int count);
> > >
> > > Or add a debug assertion at the start of the function:
> > > RTE_ASSERT(mbufs !=3D NULL || count =3D=3D 0); =20
> >=20
> > Ok, it was more motivated by common pattern in driver cleanup paths
> > like:
> >=20
> > --- a/app/test-compress-perf/comp_perf_test_common.c
> > +++ b/app/test-compress-perf/comp_perf_test_common.c
> > @@ -83,11 +83,9 @@ comp_perf_free_memory(struct comp_test_data
> > *test_data,
> >  {
> >  	uint32_t i;
> >=20
> > -	if (mem->decomp_bufs !=3D NULL)
> > -		rte_pktmbuf_free_bulk(mem->decomp_bufs, mem->total_bufs);
> > +	rte_pktmbuf_free_bulk(mem->decomp_bufs, mem->total_bufs);
> >=20
> > -	if (mem->comp_bufs !=3D NULL)
> > -		rte_pktmbuf_free_bulk(mem->comp_bufs, mem->total_bufs);
> > +	rte_pktmbuf_free_bulk(mem->comp_bufs, mem->total_bufs);
> >  =20
>=20
> Skimming comp_perf_test_common.c, it looks like mem->total_bufs is initia=
lized to the number of wanted buffers, and then mem->decomp_bufs is set up =
afterwards. In other words, total_bufs can be non-zero while comp_bufs is N=
ULL.
>=20
> IMO, removing the NULL comparison here would pass invalid parameters to r=
te_pktmbuf_free_bulk().
>=20
> Train of thoughts...
>=20
> On the other hand, it does provide a good example where considering rte_p=
ktmbuf_free_bulk() a "free()" class function accepting a NULL pointer would=
 be helpful.
> And the added performance cost of checking for a NULL pointer is per burs=
t, not per packet.
> I'm not as strongly opposed as I was initially.
>=20
> However, looking at it in a broader scope gets me be back to being oppose=
d:
> This patch is for freeing mbufs.
> If we consider freeing mempool objects, the cleanup function would call r=
te_mempool_put_bulk() to free the objects, which is the function for freein=
g previously allocated mempool objects. It just happens to not have "free" =
as part of its name.
>=20
> The mempool single object "free()" function, rte_mempool_put(), doesn't a=
ccept a NULL pointer.
> Similarly, the mempool bulk free function, rte_mempool_put_bulk(), doesn'=
t accept holes (NULL pointers) in the array.
> I certainly do not want to introduce holes into mempool object arrays.
>=20
> Maybe it was a bad decision to allow holes in mbuf arrays being passed to=
 rte_pktmbuf_free_bulk(). Such holes are not accepted in any other DPDK API=
s.
>=20
> At this point, I'm still not in favor of this patch.
> It's defensive coding (with a performance cost, however small) in a fast =
path function.
>=20

More thoughts.
- allowing NULL array is not worth it; not a big win, and only one place ma=
ttered

- allowing holes in array seems odd, and not that useful. Probably can't ch=
ange now.
  Not sure why callers would need it.

- Probably should add RTE_ASSERT() into free bulk. Should allow rte_pktmbuf=
_free_bulk(NULL, 0)
  for consistency with some other API's that take array and count. But asse=
rt should trigger
  on rte_pktmbuf_free_bulk(NULL, 1)
