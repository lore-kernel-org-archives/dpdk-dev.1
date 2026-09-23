Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5901C98304
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 15:44:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C05AE42EFA;
	Wed, 23 Sep 2026 17:44:38 +0200 (CEST)
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41]) by mails.dpdk.org (Postfix) with ESMTP id A2D9D42E82
 for <dev@dpdk.org>; Wed, 23 Sep 2026 17:44:36 +0200 (CEST)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-85469d249c5so712373b3a.3
 for <dev@dpdk.org>; Wed, 23 Sep 2026 08:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790178276;
 x=1790783076; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8WrPyyOWkhuHzk6dyU87/g195Pe0lBtk/R9RhxTloPE=;
 b=YoTYd4nL1sTpwj/1Uwl1kdo1qbusZ5c+4wndrx/Sd0VRpIkxiKiI5nuchl3MuHuUjV
 d3gqQSz46q+365axS0e5yWt2i4yCdjV+Thr6BnsreWLMNGVSIxtF7zeMysjooDesr04w
 5WHhXHRzEaruN7w9JTtmIPhg27Tporzi3TjkBHj3al8Nrha5+P/A7oZjcmhCtKwlr8Wu
 Pr5XALBW6wbKEdeggLCCBa7BiZC6xTo9UIc05a3IVQLODLGcA0gFsvshGS76Hj65NO68
 kzkSwTvpQNk35yXCRrZy3P2J0ZDbUs+pEsT8G3Nv3tkmeW++55bvvhWVuRZ7GpVofLL1
 zpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790178276; x=1790783076;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8WrPyyOWkhuHzk6dyU87/g195Pe0lBtk/R9RhxTloPE=;
 b=MHndiYMITqBdW5x91ZCa2xUZAWAGjlCvQ3b+Pnpr6bX/KrPEwNLxY6GS9oiUGJod0M
 wegqdNPAHKpdysha+2lEIQVAT1myoKw4CYKSXlsp/+0j2vViZdVih+/Y5Mk9nEGwpS1N
 0rgNLojvZ8d0W0XorJyQqHCLdORFFAxq4t1xLOUX+c5KngT71c1Q9p4cupNq3lIYWEGg
 obM6dl0nA+bZGMIHGffcxrV9CYXdoFk0BVyrnKemKBgAcLFRdf/gGlIdSPLEUgjNSPul
 Dwn7wgc9sBh/dCXYdPTI0qBbSOQ6DBg26T5SaDb2TXrqECxkvkj6EEpKhUlWRO9/mOwf
 EeDw==
X-Forwarded-Encrypted: i=1;
 AKwUvByh2MXXPP1k+hmcYld7IIdl4vU/+u3y1fXvhEOg8TS8AEzG5JE5khrt6PaCCx+l7DLnPaY=@dpdk.org
X-Gm-Message-State: AFuF++k95sU72U3QsDox3bUGilVpPQpjMHZtq5Ja9ihMPPprgw4FzBVN
 6jb3ZdbwhAPHDyaahgzIEkD9GdaopF7sVWIhTDEnFHj350zZaaBjIkqaSP5VizqfiCo=
X-Gm-Gg: AYBFou1ZksjHDZgb/xx43ML3kh53+qncZJwINOIGsWRhrz+qnOE/plwpZexYdfzuYmk
 b9EieOAn9cUA04I9zcfNIzpr1SFc0fVQKMpSQqMZX9vneGx96shQV7m1k0meKre0ORiZ+lYJqog
 f5qWWpQkEnXLRNPtm2VfGr10pDS32YZAwI8yqb1h1c+dhEKDQajpJTNAPo1JgnvLxG0Mg1HpddQ
 zqctxDY50gOv5tJRM9kFs0oJvB+vlVgb+AV6+dex3cS+14wQSgyM1sMih1Tg4DFbpVN5AhfFUzP
 1s5XDwD/cBc6VMXEB98PBVkU+VD1IdkQVkxKS06UMpuaLtHI8G6hHMAe8F4p4vcjPFi8ZKBpRib
 wEorLsJRtZaVQ4BNb9l1rlTSaPdRvGVG3vw1u1nBxHVJ6EQNCBT0xhXMJ6k7oAb/gjZVB9zdFNw
 hRWCteGqDTD0umrq8BXmurka7CBy1/R17JJqwYsJbq8hwzbZThVn3rjoyWnz1sfEkNNRZJ1giom
 nB5qOajDX4S1oSwkOsTYSzrkr9dExoH1jLG7+UR
X-Received: by 2002:a05:6a21:ed0c:b0:3dd:a196:5397 with SMTP id
 adf61e73a8af0-3ddf8296864mr2888530637.57.1790178275656; 
 Wed, 23 Sep 2026 08:44:35 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc75f03eaa2sm1400363a12.0.2026.09.23.08.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 08:44:35 -0700 (PDT)
Date: Wed, 23 Sep 2026 08:38:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Raslan Darawsheh <rasland@nvidia.com>
Cc: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, dev@dpdk.org,
 matan@nvidia.com, suanmingm@nvidia.com, dsosnowski@nvidia.com,
 stable@dpdk.org
Subject: Re: [PATCH] common/mlx5: fix overlapping memory ranges
Message-ID: <20260923083855.495da028@phoenix.local>
In-Reply-To: <c45432ff-fa4c-49c6-b443-c43e0d99e42c@nvidia.com>
References: <20260721121337.1608660-1-viacheslavo@nvidia.com>
 <c45432ff-fa4c-49c6-b443-c43e0d99e42c@nvidia.com>
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

On Mon, 3 Aug 2026 12:18:50 +0300
Raslan Darawsheh <rasland@nvidia.com> wrote:

> Hi,
>=20
>=20
> On 21/07/2026 3:13 PM, Viacheslav Ovsiienko wrote:
> > The mlx5 driver requires special objects named Memory Regions
> > (MR) to perform DMA operations with network data. The memory
> > pool(s) is used to provide memory and to cover pool addresses
> > the mlx5 PMD -pre-creates the appropriate MRs on Rx queue creation.
> >=20
> > The pool memory can be non-contigous and split into segments.
> > The PMD created MRs on the page alignment segment boundaries
> > and it could cause the overlapping MRs (in case if the end
> > address of one segmend is aligned to ceiling and the next
> > segment start address is aligned to the floor).
> >=20
> > The MRs overlapping could cause the wrong MR fetching from the
> > cache for the mbufs in the overlapping area if the starting
> > mbuf address falls into overlapped area and raise the
> > hardware memory protection exception.
> >=20
> > Fixes: 690b2a88c2f7 ("common/mlx5: add mempool registration facilities")
> > Cc: stable@dpdk.org
> >=20
> > Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
> > Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com> =20
>=20
> Patch applied to next-net-mlx,
>=20
> Kindest regards
> Raslan Darawsheh
>=20

More detailed AI review found problems with this patch.

 Finding: f718141d6c "common/mlx5: fix overlapping memory ranges" =E2=80=94=
 incomplete fix

  The change from !=3D to < correctly merges the page-alignment overlap case
  (chunks[i-1].end > chunks[i].start). But the merge body still propagates =
the
  previous chunk's end rather than the maximum end seen so far:

  for (i =3D 1; i < chunks_n; i++)
      if (chunks[i - 1].end < chunks[i].start) {
          chunks[contig_n - 1].end =3D chunks[i - 1].end;   /* mlx5_common_=
mr.c:1507=20
  */

  That is only safe if ends are monotonically non-decreasing after the sort.
  mlx5_range_compare_start (mlx5_common_mr.c:1351) compares start only, and=
 qsort
  is not stable =E2=80=94 so two ranges with equal starts but different end=
s can sort in
  either order. Equal starts are reachable on the regular-chunk path:
  mlx5_range_from_mempool_chunk (:1372) floors the start to a page, so two =
raw
  mempool chunks in the same page both yield start =3D P, while their ends =
ceil to
  different pages.

  Concretely, for raw chunks producing [P, P+2pg] and [P, P+pg] sorted in t=
hat
  order, the merge yields a final end of P+pg =E2=80=94 the last pg of regi=
stered memory is
  dropped, which is the same class of MR-coverage bug the commit sets out t=
o fix,
  just in the opposite direction (under-coverage rather than overlap).

  The extmem path is unaffected: mlx5_mempool_get_extmem_cb (:1447) emits u=
niform
  single-page segments, so equal starts imply equal ends there.

  Suggested fix =E2=80=94 track the running maximum:

  chunks[contig_n - 1].end =3D RTE_MAX(chunks[contig_n - 1].end, chunks[i -=
 1].end);

  applied at both the in-loop assignment and the post-loop "extend the last=
 chunk"
  line. Alternatively, extend the comparator to break ties on descending en=
d, which
  restores the monotonicity the current code assumes.
