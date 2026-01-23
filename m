Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C309D72372
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 11:08:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71C544026F;
	Fri, 23 Jan 2026 12:08:32 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id EEB9340269
 for <dev@dpdk.org>; Fri, 23 Jan 2026 12:08:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769166510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eS1Cbf/xSZ3eKGpbnAIX597QmlgGT6djp0EntBYpeAM=;
 b=QMrmkDoVO/XNTmtznl+n7bvZCf1Abwc0Pq3zFFAfO0ZGP0cnkvzkErrb0Q4rFlkiMmLfUZ
 Qsa/YPdpzJApQxLzIM4HPNxWYxzca8CsxLL9yltO4yhVsSvpV9QkFSX2HOoQQc+74DVw0x
 1MHiPvdr7LUuT5XI/ur/RFHI0nII01Y=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-h0_tj6OxNQyw-QZxqervmg-1; Fri, 23 Jan 2026 06:08:29 -0500
X-MC-Unique: h0_tj6OxNQyw-QZxqervmg-1
X-Mimecast-MFC-AGG-ID: h0_tj6OxNQyw-QZxqervmg_1769166508
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-59b6dfc0cbaso65556e87.3
 for <dev@dpdk.org>; Fri, 23 Jan 2026 03:08:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769166508; x=1769771308;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eS1Cbf/xSZ3eKGpbnAIX597QmlgGT6djp0EntBYpeAM=;
 b=Lz4y2Rfirljqg4JXjsLutr/GnPmjkHJMxMv9taZ0gTsYBF6MsmJiqW9lkCnCfb6ESu
 KTXgOMmr6aHZ+W0e62hlZXfZOf2Xg2X5JhE2S6+X4Y92y+kia+gG1M2BP6MZM6SpGTZg
 +dJCRhtwCKroZkxFE5Sv1ib6o6eXvHEBZDfxOm8LC+kuVGiRMqsfwNp4A3lGQBw8G/ka
 ZkN9Y1LvkaKec08BC9YtSYk2fn0zS3G3hfM3jpmIzsfXyFY98LZMHxrpGGJrYD6Qzn+a
 i9Dg0E+N2StQYVQSP2SalOWirVZbePLpYjugaV+T5KAAdbEVubLkK7QuwGoQ6KxTlBSa
 0/mA==
X-Gm-Message-State: AOJu0YywqXII3uVHWZHmuAb1mA/A87mkNGV7tyTcF4YMCG/SkEKX3i19
 9ZY59EnbvyBcZQ9JwEFhFWtfzszOANUzprfdsBq3IRP8gleD2ErV/roXDQ087oqT8ouaBXT19yX
 SEildokz8JbxrEpHnnqTF2bw0KBW+6C/6FNlK6lp5iykeuFa6xJ4lWLv+ORVtVGpqN0gVfgOCT6
 A712F58HA7iea9BHbiTL4=
X-Gm-Gg: AZuq6aIcsLcMG6fNk2mRiii0CdfCmqgHYhBalZVhCbffUUx4rY2tIDeLzXWeN9c0Zn3
 utnIkuQu/FpRupEqCx6lexPpunZYJNJ2CHmwNe3k62zGF6WDHhkUKqv0InTt01K9XB/Va7pHnEY
 0dgUIZw8/SOQQ899hL/Eg2pn2iWkQITjTBvplb92WWlpXN4dgjYpLfzG2xpSPSjtRhao+e
X-Received: by 2002:a05:6512:b23:b0:599:cdb8:58b6 with SMTP id
 2adb3069b0e04-59de4a2fec6mr949054e87.47.1769166507491; 
 Fri, 23 Jan 2026 03:08:27 -0800 (PST)
X-Received: by 2002:a05:6512:b23:b0:599:cdb8:58b6 with SMTP id
 2adb3069b0e04-59de4a2fec6mr949040e87.47.1769166506932; Fri, 23 Jan 2026
 03:08:26 -0800 (PST)
MIME-Version: 1.0
References: <20260120112552.921243-1-bruce.richardson@intel.com>
 <CAJFAV8waN3mZeSd=KX7C_N-DR_SpnR3afo=UwcOUeZy1+bP5hQ@mail.gmail.com>
In-Reply-To: <CAJFAV8waN3mZeSd=KX7C_N-DR_SpnR3afo=UwcOUeZy1+bP5hQ@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 23 Jan 2026 12:08:15 +0100
X-Gm-Features: AZwV_QhJBXsMTRhSgs_CxNOERhGV9VN-6-LC-sj4RqwWRncQQFtqMcdIHltHlGQ
Message-ID: <CAJFAV8woYXc-UC6UZYjpYZRSV5_mruXZfxYUBhXui2TcLSNLiw@mail.gmail.com>
Subject: Re: [PATCH 0/3] improve debug output for EAL flags unit tests
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, anatoly.burakov@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pB4Fs2bSL5Q86CaaFaGsrdxnhj1a0vpDje6N5VdMucc_1769166508
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

Hello Bruce,

On Wed, 21 Jan 2026 at 10:14, David Marchand <david.marchand@redhat.com> wr=
ote:
>
> On Tue, 20 Jan 2026 at 12:26, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > If issues arise in the EAL flags unit tests they can be trick to debug
> > due to the lack of debugging output when running recursive instances of
> > the test binary with different EAL flags. Try to improve this situation
> > by adding extra debug output for recursive dpdk-test calls in general,
> > and to some of the EAL flags tests in particular that are proving
> > problematic.
> >
> > NOTE: there are intermittent failures seen in github actions with the
> > file-prefix EAL unit tests. The problems seem less frequent, or possibl=
y
> > "gone", with this set applied, but even if it masks the problem, this
> > set does give us greater visibility to debug if they do re-occur.
> >
> > Bruce Richardson (3):
> >   app/test: add extra logging for recursive calls
> >   test/eal_flags: add line numbers to error messages
> >   test/eal_flags: add extra logging for file prefix tests
> >
> >  app/test/test.c           |  14 +-
> >  app/test/test_eal_flags.c | 373 ++++++++++++++++++++++----------------
> >  2 files changed, 224 insertions(+), 163 deletions(-)
>
> Series applied, thanks Bruce for looking into this.

We got one occurence in the CI.
https://github.com/DPDK/dpdk/actions/runs/21214407393/job/61031333760

Here are the logs:

2026-01-21T15:18:20.4304709Z  33/125 DPDK:fast-tests /
eal_flags_vdev_opt_autotest    FAIL            0.92s   (exit status
255 or signal 127 SIGinvalid)
2026-01-21T15:18:20.4307907Z >>> DPDK_TEST=3Deal_flags_vdev_opt_autotest
MALLOC_PERTURB_=3D42 /home/runner/work/dpdk/dpdk/build/app/dpdk-test -d
/home/runner/work/dpdk/dpdk/build/drivers
2026-01-21T15:18:20.4309736Z =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95
2026-01-21T15:18:20.4310450Z EAL: Detected CPU lcores: 4
2026-01-21T15:18:20.4310882Z EAL: Detected NUMA nodes: 1
2026-01-21T15:18:20.4311249Z EAL: Detected shared linkage of DPDK
2026-01-21T15:18:20.4311730Z EAL: Multi-process socket
/var/run/dpdk/rte/mp_socket
2026-01-21T15:18:20.4312208Z EAL: Selected IOVA mode 'PA'
2026-01-21T15:18:20.4312639Z APP: HPET is not enabled, using TSC as
default timer
2026-01-21T15:18:20.4313094Z RTE>>eal_flags_vdev_opt_autotest
2026-01-21T15:18:20.4314397Z Running binary with
argv[]:'/home/runner/work/dpdk/dpdk/build/app/dpdk-test'
'--file-prefix=3Dvdev' '--no-huge' '--vdev' 'eth_dummy'
'--driver-path=3D/home/runner/work/dpdk/dpdk/build/drivers'
2026-01-21T15:18:20.4315613Z EAL: Detected CPU lcores: 4
2026-01-21T15:18:20.4316012Z EAL: Detected NUMA nodes: 1
2026-01-21T15:18:20.4316432Z EAL: Detected shared linkage of DPDK
2026-01-21T15:18:20.4316872Z EAL: failed to parse device "eth_dummy"
2026-01-21T15:18:20.4317298Z EAL: Unable to parse device 'eth_dummy'
2026-01-21T15:18:20.4317770Z EAL: Unregistering with invalid input paramete=
r
2026-01-21T15:18:20.4318225Z Error with EAL initialization, ret =3D -1
2026-01-21T15:18:20.4319381Z Running binary with
argv[]:'/home/runner/work/dpdk/dpdk/build/app/dpdk-test'
'--file-prefix=3Dvdev' '--no-huge' '--vdev' 'net_ring0'
'--driver-path=3D/home/runner/work/dpdk/dpdk/build/drivers'
2026-01-21T15:18:20.4320519Z EAL: Detected CPU lcores: 4
2026-01-21T15:18:20.4320904Z EAL: Detected NUMA nodes: 1
2026-01-21T15:18:20.4321312Z EAL: Detected shared linkage of DPDK
2026-01-21T15:18:20.4321831Z EAL: Multi-process socket
/var/run/dpdk/vdev/mp_socket
2026-01-21T15:18:20.4322354Z EAL: Selected IOVA mode 'VA'
2026-01-21T15:18:20.4322817Z Calling recursive action for test_invalid_vdev=
_flag
2026-01-21T15:18:20.4323483Z Returned from recursive action for
test_invalid_vdev_flag with 0
2026-01-21T15:18:20.4324455Z Cleaning up
/home/runner/work/dpdk/dpdk/build/app/dpdk-test recursive instance
2026-01-21T15:18:20.4325093Z
/home/runner/work/dpdk/dpdk/build/app/dpdk-test recursive instance
returning 0
2026-01-21T15:18:20.4326091Z Running binary with
argv[]:'/home/runner/work/dpdk/dpdk/build/app/dpdk-test'
'--file-prefix=3Dvdev' '--no-huge' '--vdev' 'net_ring0,args=3Dtest'
'--driver-path=3D/home/runner/work/dpdk/dpdk/build/drivers'
2026-01-21T15:18:20.4326783Z EAL: Detected CPU lcores: 4
2026-01-21T15:18:20.4327017Z EAL: Detected NUMA nodes: 1
2026-01-21T15:18:20.4327252Z EAL: Detected shared linkage of DPDK
2026-01-21T15:18:20.4327550Z EAL: Multi-process socket
/var/run/dpdk/vdev/mp_socket
2026-01-21T15:18:20.4327845Z EAL: Selected IOVA mode 'VA'
2026-01-21T15:18:20.4328110Z Calling recursive action for test_invalid_vdev=
_flag
2026-01-21T15:18:20.4328475Z Returned from recursive action for
test_invalid_vdev_flag with 0
2026-01-21T15:18:20.4328998Z Cleaning up
/home/runner/work/dpdk/dpdk/build/app/dpdk-test recursive instance
2026-01-21T15:18:20.4329492Z
/home/runner/work/dpdk/dpdk/build/app/dpdk-test recursive instance
returning 0
2026-01-21T15:18:20.4330341Z Running binary with
argv[]:'/home/runner/work/dpdk/dpdk/build/app/dpdk-test'
'--file-prefix=3Dvdev' '--no-huge' '--vdev'
'net_ring0,nodeaction=3Dr1:0:CREATE'
'--driver-path=3D/home/runner/work/dpdk/dpdk/build/drivers'
2026-01-21T15:18:20.4331077Z EAL: Detected CPU lcores: 4
2026-01-21T15:18:20.4331303Z EAL: Detected NUMA nodes: 1
2026-01-21T15:18:20.4331530Z EAL: Detected shared linkage of DPDK
2026-01-21T15:18:20.4331832Z EAL: Multi-process socket
/var/run/dpdk/vdev/mp_socket
2026-01-21T15:18:20.4332134Z EAL: Selected IOVA mode 'VA'
2026-01-21T15:18:20.4332468Z Error (line 490) - process did not run ok
with valid vdev value with valid args
2026-01-21T15:18:20.4332815Z Test Failed
2026-01-21T15:18:20.4333029Z RTE>>
2026-01-21T15:18:20.4333385Z
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95
2026-01-21T15:18:20.4333623Z

And:

2026-01-21T15:18:22.3440177Z  36/125 DPDK:fast-tests /
eal_flags_file_prefix_autotest FAIL            0.50s   (exit status
255 or signal 127 SIGinvalid)
2026-01-21T15:18:22.3442376Z >>>
DPDK_TEST=3Deal_flags_file_prefix_autotest MALLOC_PERTURB_=3D162
/home/runner/work/dpdk/dpdk/build/app/dpdk-test -d
/home/runner/work/dpdk/dpdk/build/drivers
2026-01-21T15:18:22.3443273Z =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95
2026-01-21T15:18:22.3443617Z EAL: Detected CPU lcores: 4
2026-01-21T15:18:22.3443875Z EAL: Detected NUMA nodes: 1
2026-01-21T15:18:22.3444115Z EAL: Detected shared linkage of DPDK
2026-01-21T15:18:22.3444453Z EAL: Multi-process socket
/var/run/dpdk/rte/mp_socket
2026-01-21T15:18:22.3444751Z EAL: Selected IOVA mode 'PA'
2026-01-21T15:18:22.3445036Z APP: HPET is not enabled, using TSC as
default timer
2026-01-21T15:18:22.3445333Z RTE>>eal_flags_file_prefix_autotest
2026-01-21T15:18:22.3445927Z Hugepage file /dev/hugepages/rtemap_2
exists, matching prefix rtemap_
2026-01-21T15:18:22.3446300Z Hugepage file /dev/hugepages/rtemap_2 is locke=
d
2026-01-21T15:18:22.3446599Z Hugepage file /dev/hugepages/rtemap_1 is locke=
d
2026-01-21T15:18:22.3446897Z Hugepage file /dev/hugepages/rtemap_0 is locke=
d
2026-01-21T15:18:22.3447615Z Running binary with
argv[]:'/home/runner/work/dpdk/dpdk/build/app/dpdk-test'
'--proc-type=3Dsecondary' '-m' '18' '--file-prefix=3Dmemtest'
'--driver-path=3D/home/runner/work/dpdk/dpdk/build/drivers'
2026-01-21T15:18:22.3448304Z EAL: Detected CPU lcores: 4
2026-01-21T15:18:22.3448532Z EAL: Detected NUMA nodes: 1
2026-01-21T15:18:22.3448758Z EAL: Detected shared linkage of DPDK
2026-01-21T15:18:22.3449106Z EAL: Multi-process socket
/var/run/dpdk/memtest/mp_socket_59707_2a8a22b91bd
2026-01-21T15:18:22.3449778Z EAL: failed to send to
(/var/run/dpdk/memtest/mp_socket) due to No such file or directory
2026-01-21T15:18:22.3450297Z EAL: Fail to send request
/var/run/dpdk/memtest/mp_socket:bus_vdev_mp
2026-01-21T15:18:22.3450673Z VDEV_BUS: vdev_scan(): Failed to request
vdev from primary
2026-01-21T15:18:22.3450972Z EAL: Selected IOVA mode 'PA'
2026-01-21T15:18:22.3451326Z EAL: failed to send to
(/var/run/dpdk/memtest/mp_socket) due to No such file or directory
2026-01-21T15:18:22.3451706Z EAL: Cannot send message to primary
2026-01-21T15:18:22.3451967Z EAL: error allocating rte services array
2026-01-21T15:18:22.3452224Z EAL: rte_service_init() failed
2026-01-21T15:18:22.3452473Z Error with EAL initialization, ret =3D -1
2026-01-21T15:18:22.3452809Z Hugepage file /dev/hugepages/rtemap_2
exists, matching prefix rtemap_
2026-01-21T15:18:22.3453173Z Hugepage file /dev/hugepages/rtemap_2 is locke=
d
2026-01-21T15:18:22.3453470Z Hugepage file /dev/hugepages/rtemap_1 is locke=
d
2026-01-21T15:18:22.3453764Z Hugepage file /dev/hugepages/rtemap_0 is locke=
d
2026-01-21T15:18:22.3454168Z Hugepage file /dev/hugepages/rtemap_2
exists, matching prefix rtemap_
2026-01-21T15:18:22.3454524Z Hugepage file /dev/hugepages/rtemap_2 is locke=
d
2026-01-21T15:18:22.3454816Z Hugepage file /dev/hugepages/rtemap_1 is locke=
d
2026-01-21T15:18:22.3455110Z Hugepage file /dev/hugepages/rtemap_0 is locke=
d
2026-01-21T15:18:22.3455938Z Running binary with
argv[]:'/home/runner/work/dpdk/dpdk/build/app/dpdk-test' '-m' '18'
'--file-prefix=3Dmemtest1'
'--driver-path=3D/home/runner/work/dpdk/dpdk/build/drivers'
2026-01-21T15:18:22.3456554Z EAL: Detected CPU lcores: 4
2026-01-21T15:18:22.3456775Z EAL: Detected NUMA nodes: 1
2026-01-21T15:18:22.3457003Z EAL: Detected shared linkage of DPDK
2026-01-21T15:18:22.3457319Z EAL: Multi-process socket
/var/run/dpdk/memtest1/mp_socket
2026-01-21T15:18:22.3457625Z EAL: Selected IOVA mode 'PA'
2026-01-21T15:18:22.3457959Z Calling recursive action for test_file_prefix
2026-01-21T15:18:22.3458291Z Returned from recursive action for
test_file_prefix with 0
2026-01-21T15:18:22.3458715Z Cleaning up
/home/runner/work/dpdk/dpdk/build/app/dpdk-test recursive instance
2026-01-21T15:18:22.3459202Z
/home/runner/work/dpdk/dpdk/build/app/dpdk-test recursive instance
returning 0
2026-01-21T15:18:22.3459656Z Hugepage file /dev/hugepages/rtemap_2
exists, matching prefix rtemap_
2026-01-21T15:18:22.3460017Z Hugepage file /dev/hugepages/rtemap_2 is locke=
d
2026-01-21T15:18:22.3460310Z Hugepage file /dev/hugepages/rtemap_1 is locke=
d
2026-01-21T15:18:22.3460608Z Hugepage file /dev/hugepages/rtemap_0 is locke=
d
2026-01-21T15:18:22.3460975Z Hugepage file /dev/hugepages/rtemap_2
exists, matching prefix rtemap_
2026-01-21T15:18:22.3461339Z Hugepage file /dev/hugepages/rtemap_2 is locke=
d
2026-01-21T15:18:22.3461640Z Hugepage file /dev/hugepages/rtemap_1 is locke=
d
2026-01-21T15:18:22.3461933Z Hugepage file /dev/hugepages/rtemap_0 is locke=
d
2026-01-21T15:18:22.3462316Z Hugepage file
/dev/hugepages/memtest1map_8 exists, matching prefix memtest1map_
2026-01-21T15:18:22.3462788Z Error (line 1396) - hugepage files for
memtest1 were not deleted!
2026-01-21T15:18:22.3463100Z Test Failed
2026-01-21T15:18:22.3463268Z RTE>>
2026-01-21T15:18:22.3463597Z
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95
2026-01-21T15:18:22.3463824Z

For the latter, I suspect that now passing --driver-path exposes some
driver leak.
But strange that it is not systematic...

--log-level=3D*:debug could help...


--=20
David Marchand

