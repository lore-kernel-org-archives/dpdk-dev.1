Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413EAC282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 17:21:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30A0140263;
	Fri, 14 Mar 2025 18:21:37 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id EC3C6400D6
 for <dev@dpdk.org>; Fri, 14 Mar 2025 18:21:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741972895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8AlZMUtiNjMhLBr7H+9412Z+D1tZLI5gnum7KXcXLLQ=;
 b=JBLUApbyuy0HHC4BVfqSCZ5LONcSOmdccN9gnqarcZeCTnpzZ60m+4r/YGCPQkmUoejg3U
 gNZjK5F3sl69nguSDk/VFp7h8N13iH10Fd/OSlwlUdSocY1HpXdjHQ6r4dbO2KptGtYm4K
 16PINWpGL7LxQ5qP6Ejcu1ZMDS0OGL8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-BbaRb0ZfPzSWt0SZV1Qaww-1; Fri, 14 Mar 2025 13:21:32 -0400
X-MC-Unique: BbaRb0ZfPzSWt0SZV1Qaww-1
X-Mimecast-MFC-AGG-ID: BbaRb0ZfPzSWt0SZV1Qaww_1741972891
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-549971b3247so1178223e87.2
 for <dev@dpdk.org>; Fri, 14 Mar 2025 10:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741972891; x=1742577691;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8AlZMUtiNjMhLBr7H+9412Z+D1tZLI5gnum7KXcXLLQ=;
 b=sZbx3mKmt6bUD2yc26gxljW0Ezft3FQyXoFJ+Y+LvouekOxWAE6lgEI7PM1+5XmhKE
 DcP7BSJN7ZEzobe0h2aetBnsTD+5D3oImGAOhpqbtf9OvkVosMf6CJuBkpTejiPej7R/
 3FJxUBmFuQXRYDUDvVrT5UREEdIBHLtO8yyeAyfeUpRvXpj25Io8M+6Y6HuC8ANDx+yi
 Rzt9yDUGqqVTW7nDk218oADCbBKVLCAaXg218AMZW2we3L4Q3zigigbiAoFRz8X9h4IU
 tWWwm/3dQFEtsB0AbfD6Jeek/kKuR86ep52aP++/76f1qTtQbt/SUPEJyrTC5kkV5vxS
 gfMA==
X-Gm-Message-State: AOJu0YzW9qXH/LFd2K2ByvMfkQvbzLUnI8Z6/cOFcWtM3zJ+/TbmYT0u
 NNKD8Kvvo/BTg0N9YygXHLJ47OPt2MlgviwCaWpDELbxQ7BdKKPokSfy0iV0ssAoc2R7LfzrJ9l
 TgML49yY4HxKEGq4uxg2yfAkMWu0Vl+QrfCu1D4IWU9eFdgLtpkqrNYRSwLwxV7KrLLh7GdFgAq
 rbEdwa+sz0HRVNkOM=
X-Gm-Gg: ASbGncveyw6Uulax+raDBKr31nVpINt0k61IhV+U1tnMevr3J0f2XPDXUbouAeEW9S8
 W4mWl0HQ/YmcbPCs4Xp0Inh7Pza39cvs2mKHW6XPXj0eoi0Mb/XKWYUZl/uKG75EbNQjCXjRfQF
 0=
X-Received: by 2002:a05:6512:1282:b0:549:8b94:9b93 with SMTP id
 2adb3069b0e04-549c39afa83mr1335328e87.49.1741972890646; 
 Fri, 14 Mar 2025 10:21:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhX9esVSFWF2RRoAYaIbqV0jZt8S4eui15vR9WauuckdU/jtUgqtcgFbOda7ok0h5Txs7O39vimuEbCuxbzCE=
X-Received: by 2002:a05:6512:1282:b0:549:8b94:9b93 with SMTP id
 2adb3069b0e04-549c39afa83mr1335262e87.49.1741972890072; Fri, 14 Mar 2025
 10:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250311095609.194523-1-david.marchand@redhat.com>
 <20250311095609.194523-7-david.marchand@redhat.com>
 <Z9MWQR_o3m4T_rFt@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8w0MPV7XQpMyiGTsSVDGuW1LctGyrXZ6n52O7AYzij7Zw@mail.gmail.com>
 <Z9RYCXF6Ag23k8Uy@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8zsgxW7goppOjNariu_oA+ET5HeNTOeepDSHsE31KmkNA@mail.gmail.com>
In-Reply-To: <CAJFAV8zsgxW7goppOjNariu_oA+ET5HeNTOeepDSHsE31KmkNA@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 14 Mar 2025 18:21:18 +0100
X-Gm-Features: AQ5f1JqdLk6ThwU8UbWZWRaknjhBfCVn04vIYEGiAj8W4jtKutM-EReVWx7Ao2Q
Message-ID: <CAJFAV8xcNXBSCmcayGJshsTQBXC7raSYELSoCYGtigKr8-044g@mail.gmail.com>
Subject: Re: [RFC v3 6/8] build: mark exported symbols
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, thomas@monjalon.net, andremue@linux.microsoft.com, 
 Nicolas Chautru <nicolas.chautru@intel.com>, Parav Pandit <parav@nvidia.com>, 
 Xueming Li <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, 
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, 
 Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@intel.com>, 
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>, 
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>, 
 Wei Hu <weh@microsoft.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, 
 Anoob Joseph <anoobj@marvell.com>, Andrew Boyer <andrew.boyer@amd.com>, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, 
 Matan Azrad <matan@nvidia.com>, Liron Himi <lironh@marvell.com>, 
 Chaoyong He <chaoyong.he@corigine.com>,
 Nagadheeraj Rottela <rnagadheeraj@marvell.com>, 
 Srikanth Jampala <jsrikanth@marvell.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, 
 Ankur Dwivedi <adwivedi@marvell.com>, Tejasree Kondoj <ktejasree@marvell.com>, 
 Gagandeep Singh <g.singh@nxp.com>, Kai Ji <kai.ji@intel.com>, 
 Vamsi Attunuru <vattunuru@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>, 
 Shijith Thotton <sthotton@marvell.com>, Pravin Pathak <pravin.pathak@intel.com>,
 Ashwin Sekhar T K <asekhar@marvell.com>, Igor Russkikh <irusskikh@marvell.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>, 
 Chas Williams <chas3@att.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Ian Stokes <ian.stokes@intel.com>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, 
 Jingjing Wu <jingjing.wu@intel.com>, Praveen Shetty <praveen.shetty@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>, 
 Maxime Coquelin <maxime.coquelin@redhat.com>, David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Akhil Goyal <gakhil@marvell.com>, 
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Fan Zhang <fanzhang.oss@gmail.com>, 
 Ashish Gupta <ashish.gupta@marvell.com>, 
 =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>, 
 Kevin Laatz <kevin.laatz@intel.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>, Jerin Jacob <jerinj@marvell.com>,
 Harry van Haaren <harry.van.haaren@intel.com>, Min Zhou <zhoumin@loongson.cn>, 
 David Christensen <drc@linux.ibm.com>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>, 
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Byron Marohn <byron.marohn@intel.com>, 
 Yipeng Wang <yipeng1.wang@intel.com>, Ferruh Yigit <ferruh.yigit@amd.com>, 
 Abhinandan Gujjar <abhinandan.gujjar@intel.com>, 
 Amit Prakash Shukla <amitprakashs@marvell.com>,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>, 
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>,
 Elena Agostini <eagostini@nvidia.com>, 
 Zhirun Yan <yanzhirun_163@163.com>, Jiayu Hu <hujiayu.hu@foxmail.com>, 
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Reshma Pattan <reshma.pattan@intel.com>, 
 Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, 
 Srikanth Yalavarthi <syalavarthi@marvell.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>, 
 Gaetan Rivet <grive@u256.net>, Volodymyr Fialko <vfialko@marvell.com>, 
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oCDFkdNjbzErABSDdmIMB8aKtdJv2eAd1C6RLDpdNEc_1741972891
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Mar 14, 2025 at 5:53=E2=80=AFPM David Marchand
<david.marchand@redhat.com> wrote:
>
> On Fri, Mar 14, 2025 at 5:24=E2=80=AFPM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > On Fri, Mar 14, 2025 at 05:14:34PM +0100, David Marchand wrote:
> > > On Thu, Mar 13, 2025 at 6:31=E2=80=AFPM Bruce Richardson
> > > <bruce.richardson@intel.com> wrote:
> > > >
> > > > On Tue, Mar 11, 2025 at 10:56:04AM +0100, David Marchand wrote:
> > > > > Annotate symbols with newly introduced export macros.
> > > > >
> > > > > For code not compiled by lib/meson.build or drivers/meson.build (=
like AVX
> > > > > separate libraries, or sources in /base/ drivers), the exported s=
ymbols
> > > > > are added in some file listed in the sources so they get caught b=
y
> > > > > lib/meson.build or drivers/meson.build.
> > > > >
> > > > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > > > > ---
> > > >
> > > > Just checking: for the AVX2 and similar instruction-set-specific fu=
nctions,
> > > > we don't get errors if those are not present in the actual link pha=
se, e.g.
> > > > when building on non-x86 platforms? We don't need to put an #ifdef =
around
> > > > the exports?
> > >
> > > We are not there yet, but it is likely MSVC linker will complain, ind=
eed.
> > >
> > > #ifdef around the exports won't work, we would need a precompiler pas=
s
> > > (and exclude rte_exports.h inclusion).
> > >
> > > Another option would be to provide stubs for those symbols when the
> > > additional AVX512 (for example) libraries are not compiled.
> > >
> > > But I think the simpler is to let a driver/library provide a set of
> > > sources to parse for exports... maybe via an extra variable?
> > > WDYT?
> > >
> > Yes, something like that could work.
> >
> > What I'd actually like more, but never have had time to actually try ou=
t is
> > to generalise the instruction-set-specific build stuff into the higher =
level
> > drivers/meson.build code. After all, much of the code for doing so is j=
ust
> > duplicated - check for AVX512 or AVX2 and if present build these files =
with
> > the extra flags for that instruction set.
> >
> > Something similar with the base code. Most base code builds follow pret=
ty
> > much the exact same routine.
>
> Having those separate libraries require special cases every time, so
> yes, it would be great if those could be factored in some shared
> mechanism in drivers/meson.build.
>
> Putting the AVX stuff aside, and back to why we need those separate
> libraries for base drivers... I think the main use is to waive some
> build warnings, is there something else?
> If so.. I think some drivers could already be cleaned (like net/e1000,
> net/ngbe, net/octeontx, net/thunderx, net/txgbe, raw/ifpga at a first
> glance).
>
> The AVX stuff seems a bit more complex, as there are multiple combination=
s...

CFLAGS_file.o +=3D -Wno-stuff was so handy ... :-)


--=20
David Marchand

