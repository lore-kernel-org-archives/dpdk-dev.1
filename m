Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE39D2ECF8
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 00:08:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2061140274;
	Tue, 20 Jan 2026 01:08:08 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 10B094026D
 for <dev@dpdk.org>; Tue, 20 Jan 2026 01:08:06 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-430f3ef2d37so3785230f8f.3
 for <dev@dpdk.org>; Mon, 19 Jan 2026 16:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768867685;
 x=1769472485; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dGaU+G3EhOW2eo57kK7EVEu/hxZ98xba9SxTR8p/Ucg=;
 b=R/Z0tRt2UkxYTMRVI4CvPHMTDzWHC9czk99kuitrabpGSFclAVjIfvax7AKepEEBeW
 T28IfkzMRTkAZdQR1YShLDzAN4eP9hC9C6GVeUl8wIGL1H9F37tbll5h4E5P639DyDTA
 HqkZi0tPdLPVvS3n5rk5PZEW7l/17KnuT4WXAQ9fWcz9Lt/yaH05quhFfbeIJMAMCgVd
 uef7qTUaB8FrTqL5fI5KdXjeqMZbz1mB1fubEKfJ41hCwNRpltBuWu5XyW5aqkDy9Abc
 hAaxUhJVnDvN7Zr5FcDs3QyDI3qMcFs52LdMcJxUPRF/cShmKtKpymv2+lKvD2lqCqCl
 8Rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768867685; x=1769472485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dGaU+G3EhOW2eo57kK7EVEu/hxZ98xba9SxTR8p/Ucg=;
 b=cf6DbcyR8Id8LLamdX8aPp4c5RbcHnlTZfwoqld0MHWF1EFsi4InllU9skEFHM5WeD
 S9Kz67yRAyP/KWaRY9G4UKOjRqtrbbK0YCFb+3D5VRQ5ySoPE5sba4hnyh8yw/7NIsuy
 ON7jlSKlhVkajuT2GaJ1O24xKJBfvMwPWal2a3nCMQBCsfcKvGTya4GBpSP3eSslr9g4
 n3cGGKxH1XYpj7a8ur0D8D/oijGP8vO+YLtq3oxcdvsbetmu4MMBoDMQ1Z9+1ZIUhB2X
 TmG108RYlAgiICnGKT6JgQD3g1GLNv2ELK4TViJRza5lBScNKYaAGtlqjPrXMxsgOntW
 qoRQ==
X-Gm-Message-State: AOJu0YwpT3RJB1o5CMyd+x829/Uc9NdeaoEMrrzdrmjVYuMoTk3yAHQ5
 CnW3uuuZUkpv8DRi+wwb48VvcOEAQFUrsDbC3xMaMn1Jvdreno/7W2/dboHC5ROr7Ew=
X-Gm-Gg: AZuq6aLdZoNNIht4jBn8rK6jqmzcVOrRqXA4JbCGiZ0XnjXxLMpSiUBo3Dkt3ii/V/q
 IFAWn/KiSn9gmt0JIxPFaj8ag4d3uJH86TB8IK6QfcR7dfK0ngsJXpOXntrBFRz1DDao58tMgS0
 9tYVPKb1OAeWAtlBabHwvboNuTYoVsa52kbzjYFCRIei0JRSDP7d3UGGXkO3/PwDgRSSFkxMFdV
 3pExsNpg+1UgRtW/qytAO+d7+HHl2s55wC74zP/qqsBlcS7M5+MDhaJsSdc8MJg5vOCenG2cxoU
 ZRGLV2wLcVNAz2J2Ie83oqSFkckS2RxeS+6Ir5z07ECbxoMnbYgcVQO8mJXOC10LS72eC5A1mbi
 XryDb4NigPHFMYwAO6t/WzWebTXGpdKKD7/6Fmo/JXQvd0vcA9gq3KmRyP9u51dmYJMZbAWqdpK
 FVzgUnrWcJcGxIxMjD0U22dBeiwbhEXU9ZCz59MAoSFf08zuXIxkiN
X-Received: by 2002:a05:6000:2dc5:b0:430:f3fb:35fa with SMTP id
 ffacd0b85a97d-4358ff6f669mr108188f8f.57.1768867685577; 
 Mon, 19 Jan 2026 16:08:05 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cf33sm26745859f8f.25.2026.01.19.16.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 16:08:05 -0800 (PST)
Date: Mon, 19 Jan 2026 16:07:59 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>, Bruce
 Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH 6/6] test: fix trace_autotest_with_traces parallel
 execution
Message-ID: <20260119160759.1f4b325a@phoenix.local>
In-Reply-To: <e895dd4222bd487f84d80241028cf951@huawei.com>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260118201223.323024-7-stephen@networkplumber.org>
 <e895dd4222bd487f84d80241028cf951@huawei.com>
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

On Mon, 19 Jan 2026 13:13:40 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> > -----Original Message-----
> > From: Stephen Hemminger <stephen@networkplumber.org>
> > Sent: Sunday 18 January 2026 20:09
> > To: dev@dpdk.org
> > Cc: Stephen Hemminger <stephen@networkplumber.org>; stable@dpdk.org; Mo=
rten Br=C3=B8rup
> > <mb@smartsharesystems.com>; Bruce Richardson <bruce.richardson@intel.co=
m>
> > Subject: [PATCH 6/6] test: fix trace_autotest_with_traces parallel exec=
ution
> >=20
> > The trace_autotest_with_traces test was reusing the test_args array
> > from trace_autotest, which already contained --file-prefix=3Dtrace_auto=
test.
> >=20
> > Fix by building trace_args from scratch for the _with_traces test
> > variant instead of appending to the existing test_args array.
> >=20
> > Fixes: 0aeaf75df879 ("test: define unit tests suites based on test type=
s")
> > Cc: stable@dpdk.org
> >=20
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >  app/test/suites/meson.build | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/app/test/suites/meson.build b/app/test/suites/meson.build
> > index 38df1cfec2..e62170bebf 100644
> > --- a/app/test/suites/meson.build
> > +++ b/app/test/suites/meson.build
> > @@ -106,10 +106,18 @@ foreach suite:test_suites
> >                  is_parallel : false,
> >                  suite : 'fast-tests')
> >              if not is_windows and test_name =3D=3D 'trace_autotest'
> > -                test_args +=3D ['--trace=3D.*']
> > -                test_args +=3D ['--trace-dir=3D@0@'.format(meson.curre=
nt_build_dir())]
> > +                # build separate args list to avoid duplicate --file-p=
refix
> > +                trace_args =3D test_no_huge_args
> > +                trace_args +=3D ['--trace=3D.*']
> > +                trace_args +=3D ['--trace-dir=3D@0@'.format(meson.curr=
ent_build_dir())]
> > +                if is_linux
> > +                    trace_args +=3D ['--file-prefix=3Dtrace_autotest_w=
ith_traces']
> > +                endif
> > +                if get_option('default_library') =3D=3D 'shared'
> > +                    trace_args +=3D ['-d', dpdk_drivers_build_dir]
> > +                endif
> >                  test(test_name + '_with_traces', dpdk_test,
> > -                    args : test_args,
> > +                    args : trace_args,
> >                      env: ['DPDK_TEST=3D' + test_name],
> >                      timeout : timeout_seconds_fast,
> >                      is_parallel : false,
> > --
> > 2.51.0
> >  =20
>=20
> Instead of duplicating some code and hardcoding values for trace_autotest=
,=20
> which is error-prone, can we make adding file prefix the last thing we do=
 to=20
> test_args (perhaps doing it right in the `args : ...` expression) and re-=
use=20
> the previous value and logic like we did it before?

Not sure, what would it look like. Having special case args for test
looks like a kludge anyway.
