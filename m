Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17242606A31D
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 18:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=S51AKywY
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FC2540151;
	Mon, 26 Oct 2026 19:38:56 +0100 (CET)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 970AF40041
 for <dev@dpdk.org>; Mon, 26 Oct 2026 19:38:55 +0100 (CET)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-ccca948203aso1024983a12.3
 for <dev@dpdk.org>; Mon, 26 Oct 2026 11:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1793039934;
 x=1793644734; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SrUL0djQ25tHPUZMC4LUGc7E9HYNiF2etZHNdwtguy4=;
 b=S51AKywYuYFYlJgRp0+Kp5bd75MlrcZ1Jh0NZ9xhxaaFeOiKcQ5mlD6yxboK5tZu0/
 8vgk/J72D9Fi46dIAkSsjuG84s8PmWHYczdjo01Hpys8bELVWRrB5ZSnsJ91IfHsOWie
 sCCOq2afmp60zUoftVVzXioODrp2/bp98y8O6H6BhxeVOSJW4yJIyms+SZ5rkoto2OIT
 BK4Obf0p0/JYlWDpf65hEfr3/V6SdUznygnPe9J0JKhLhafavYlH+9LTHOEAWnWTugXp
 iif9tO9otQYoR/CbnNPPxeO7rqp1lk85yhomastGRNybAuOlckJbRYie9yeSrrVT8Jmq
 SbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793039934; x=1793644734;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SrUL0djQ25tHPUZMC4LUGc7E9HYNiF2etZHNdwtguy4=;
 b=NdJlm55yIDFX5F6Bd5oBKYL7RWoFBhKJ5BTJm3o9uELLmYcBUlUzYmQstLEJn2Kjx1
 StAcD57NItr+3id+nQ8Ohtus8tM+HjBW1GLr2DpS2wnv5zkxejD4Q4vldtlPgebVq9dg
 ZaD4ahWd328MR0zIjdLcltq6KLzIxE4NQFNQblieXRiK7PFM/oaWv2Vu16hgX3cX0mK8
 3b9+YFIsUAYLV1hziry/lNkI6AJfmUXJT/2fRKeuUMobyGgi9aygEp5Cb3/GLOgNdAqG
 ed/yEyek5ViPRgY9n3H82ygTXaGVtAIDMD4puorZJiGlvotYZzDJvMlvd0N1RZr+Y7r5
 UKEA==
X-Forwarded-Encrypted: i=1;
 AKwUvByumNzSdQOsIKTl/nCiSAr9qxf3qkC3qPkenCdRA3cvBb0jXVQAq0QhFEKRY2Ncvi2LQcY=@dpdk.org
X-Gm-Message-State: AFq9FYIlWbDlVTprQzGlcrzzlGdgVFmBeD0n1Ys3RhuRpzspdd8lJjx4
 fKK8vqx+4iPrBnbg6HSNydFT0GiOJG2xDdAp+HdOeJHQb9FH+zESRSsFmwiBpv4eIHw=
X-Gm-Gg: AYBFou3Kr6jLXjSdXYFOGp603/C0BunPCkYMdGKdMFm1Hesm1BEYzpMIl2YdEyzKxtO
 ABVFt88UDo/1zupn0VjinggRvaJggak2ukBRWQj8MvTo7bVqptweWeITHxPt2Nxiwz+ojuObolC
 0KsDkGGEiBfKARGdhcHoe4aftZ/eHildRe4gAVmywTM1TYpxjULgULNumYS4T39+dV9w3COPsNw
 3kMZlqgVv6QEMgiiDKQ9CRSYSJbf4GfSktXyG3ECTwc8UOGjlxo0k9/bYzRXj4sDnoYEMXZF30z
 I4KU18yEtJC18fmcvVpt44/IUEkN/QStjqdXtpTFQ2U8Wks+Yn5Mvqwte+KJzjLUkAKO2skDlan
 5/FQey/SsMnbUARp5ohJAupf/5pOobrlEIlfTx866O0ejP6sEZzzD7Sih4SbsaRPSVBNrgyyfFY
 WiePiRkng4aC+yXzfMB738DXmNjpON216JN1tY0F4Ax5TqHJ1ZG6mA5dOWQE4vAnt+jBSzDoVky
 soCS96u6hA7DuZxBCExhYj8Z27hQLdjjtHfrMvttTeySHmkyM3NStHmpIvSDqnorAoixQfqvyZL
 JPsI5vyM+DXifoanCeN2Og==
X-Received: by 2002:a17:90a:e705:b0:3ab:c80:9365 with SMTP id
 98e67ed59e1d1-3adeae772f3mr6055788a91.42.1793039933795; 
 Mon, 26 Oct 2026 11:38:53 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae40427bf1sm544643a91.6.2026.10.26.11.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 11:38:53 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:38:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>, "thomas@monjalon.net"
 <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v27 00/25] NXP DPAA driver enhancements and fixes
Message-ID: <20261026113850.47e25a8d@phoenix.local>
In-Reply-To: <CAJFAV8xx=ZM3M-DKWRtn-08zyTFhp5FC-2UptcLpZzrK7+7L1Q@mail.gmail.com>
References: <20261015141144.3140281-1-hemant.agrawal@nxp.com>
 <20261016111958.163060-1-hemant.agrawal@nxp.com>
 <20261016093848.7dbe6c73@phoenix.local>
 <GV1PR04MB10750670E599D034FA89E627A899B2@GV1PR04MB10750.eurprd04.prod.outlook.com>
 <CAJFAV8xx=ZM3M-DKWRtn-08zyTFhp5FC-2UptcLpZzrK7+7L1Q@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 26 Oct 2026 14:27:53 -0400
David Marchand <david.marchand@redhat.com> wrote:

> > > Series applies cleanly to 26.11-rc1 and every commit builds with -
> > > Dwerror=3Dtrue. The fixes are now first. 08 cherry-picks cleanly onto
> > > v24.11 and v25.11, and 06 applies there once 01-05 are in.
> > >
> > > v26 Warnings on 12 (now 14) and 20 are addressed. The 24 Warning is o=
nly
> > > partly fixed.
> > > =20
> >
> > I see only one warning in this patchset 24/25 -   is it possible that y=
ou drop this patch and apply rest of the series? =20
>=20
> IIUC, next-net does not build in GHA since this series was merged:
> https://github.com/DPDK/dpdk/actions/runs/38964568382/job/117187710778
>=20
>=20

CI shows:

 FAILED: [code=3D1] drivers/libtmp_rte_bus_dpaa.a.p/bus_dpaa_base_qbman_bma=
n.c.o=20
ccache powerpc64le-linux-gnu-gcc -Idrivers/libtmp_rte_bus_dpaa.a.p -Idriver=
s -I../drivers -Idrivers/bus/dpaa -I../drivers/bus/dpaa -I../drivers/bus/dp=
aa/base -I../drivers/bus/dpaa/include -I../drivers/bus/dpaa/base/qbman -Ili=
b/eal/common -I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/eal/in=
clude -I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linux/inclu=
de -Ilib/eal/ppc/include -I../lib/eal/ppc/include -I../kernel/linux -Ilib/e=
al -I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/m=
etrics -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/argparse -=
I../lib/argparse -Idrivers/common/dpaax -I../drivers/common/dpaax -I../driv=
ers/common/dpaax/caamflib -Ilib/eventdev -I../lib/eventdev -Ilib/ring -I../=
lib/ring -Ilib/ethdev -I../lib/ethdev -Ilib/net -I../lib/net -Ilib/mbuf -I.=
./lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/meter -I../lib/meter -Ilib/=
hash -I../lib/hash -Ilib/rcu -I../lib/rcu -Ilib/timer -I../lib/timer -Ilib/=
cryptodev -I../lib/cryptodev -Ilib/dmadev -I../lib/dmadev -fdiagnostics-col=
or=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -Werror -s=
td=3Dc11 -O2 -g -include rte_config.h -Wvla -Wcast-qual -Wdeprecated -Wform=
at -Wformat-nonliteral -Wformat-security -Wmissing-declarations -Wmissing-p=
rototypes -Wnested-externs -Wold-style-definition -Wpointer-arith -Wshadow =
-Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-strings -Wno-packed-not-=
aligned -Wno-missing-field-initializers -Wno-psabi -D_GNU_SOURCE -fPIC -mcp=
u=3Dpower8 -mtune=3Dpower8 -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -W=
no-format-truncation -Wno-address-of-packed-member -Wno-cast-qual -Wno-poin=
ter-arith -DRTE_COMPONENT_CLASS=3Dpmd_bus -DRTE_COMPONENT_NAME=3Ddpaa -DRTE=
_LOG_DEFAULT_LOGTYPE=3Dbus.dpaa -MD -MQ drivers/libtmp_rte_bus_dpaa.a.p/bus=
_dpaa_base_qbman_bman.c.o -MF drivers/libtmp_rte_bus_dpaa.a.p/bus_dpaa_base=
_qbman_bman.c.o.d -o drivers/libtmp_rte_bus_dpaa.a.p/bus_dpaa_base_qbman_bm=
an.c.o -c ../drivers/bus/dpaa/base/qbman/bman.c
../drivers/bus/dpaa/base/qbman/bman.c: In function =E2=80=98bman_release_fa=
st=E2=80=99:
../drivers/bus/dpaa/base/qbman/bman.c:289:51: error: =E2=80=98bm_bufs[0].<U=
6b48>.be_desc.hi=E2=80=99 may be used uninitialized [-Werror=3Dmaybe-uninit=
ialized]
  289 |         r->bufs[0].be_desc.hi =3D bm_bufs[0].be_desc.hi;
      |                                 ~~~~~~~~~~~~~~~~~~^~~
../drivers/bus/dpaa/base/qbman/bman.c:265:26: note: =E2=80=98bm_bufs=E2=80=
=99 declared here
  265 |         struct bm_buffer bm_bufs[FSL_BM_BURST_MAX];
      |                          ^~~~~~~
../drivers/bus/dpaa/base/qbman/bman.c:290:51: error: =E2=80=98bm_bufs[0].<U=
6b48>.be_desc.lo=E2=80=99 may be used uninitialized [-Werror=3Dmaybe-uninit=
ialized]
  290 |         r->bufs[0].be_desc.lo =3D bm_bufs[0].be_desc.lo;
      |                                 ~~~~~~~~~~~~~~~~~~^~~
../drivers/bus/dpaa/base/qbman/bman.c:265:26: note: =E2=80=98bm_bufs=E2=80=
=99 declared here
  265 |         struct bm_buffer bm_bufs[FSL_BM_BURST_MAX];
      |                          ^~~~~~~


AI analysis says:

The loop at line 282 starts at i =3D 0 and is bounded only by num. Without =
RTE_LIBRTE_DPAA_HWDEBUG nothing guarantees num >=3D 1, so GCC sees a num =
=3D=3D 0 path where bm_bufs[0] is never written but lines 289-290 still rea=
d it. The warning is real, not a codegen artifact; ppc/riscv inlining just =
exposes it. bman_release() and the main version of this function both write=
 entry 0 unconditionally, so restore that:
diff


bus/dpaa: fix maybe-uninitialized in bman_release_fast

The conversion loop is bounded only by num, which is not checked
unless RTE_LIBRTE_DPAA_HWDEBUG is set. GCC on ppc64le and riscv
therefore warns that bm_bufs[0] may be read uninitialized when
copying the first entry into the RCR.

Convert entry 0 unconditionally, as bman_release() does.

Fixes: <sha> ("<subject of the next-net commit>")

--- a/drivers/bus/dpaa/base/qbman/bman.c
+++ b/drivers/bus/dpaa/base/qbman/bman.c
@@ -279,7 +279,8 @@ bman_release_fast(struct bman_pool *pool, const uint64_=
t *bufs,
 	if (unlikely(!r))
 		return -EBUSY;
=20
-	for (i =3D 0; i < num; i++)
+	bm_buffer_set64_to_be(&bm_bufs[0], bufs[0]);
+	for (i =3D 1; i < num; i++)
 		bm_buffer_set64_to_be(&bm_bufs[i], bufs[i]);
=20
 	/* bufs[0] overlaps the verb, which bm_rcr_pvb_commit() writes last
