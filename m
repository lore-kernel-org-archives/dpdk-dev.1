Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9DDD2F7CC
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 12:50:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 652054027D;
	Fri,  5 Dec 2025 13:50:19 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8D32140156
 for <dev@dpdk.org>; Fri,  5 Dec 2025 13:50:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764939018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lZ7hlc3iW+q1ckrmp2uPAU/uADd8er228tl6KHIHeGc=;
 b=b01KA5rKJph/INyXBrivo1SD65kFqTzaNVbhiaQ0LsvLVqkylBiYQglY94F15AG9PXPITd
 1uG6j2VuNuEIT5jjamASX/jUbGxY4FLFzr7aOnIQKq2PN3x4coXpiv/Nn1oUSJGSIlhrCp
 zfWR5HJPlXFE6Ibh6uT5Pu1e2eVRk74=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-RW7QPypuMYipgoC-LEjU1g-1; Fri, 05 Dec 2025 07:50:16 -0500
X-MC-Unique: RW7QPypuMYipgoC-LEjU1g-1
X-Mimecast-MFC-AGG-ID: RW7QPypuMYipgoC-LEjU1g_1764939015
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-59578f8468cso1309803e87.1
 for <dev@dpdk.org>; Fri, 05 Dec 2025 04:50:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764939015; x=1765543815;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lZ7hlc3iW+q1ckrmp2uPAU/uADd8er228tl6KHIHeGc=;
 b=DPZNlF58TbzQHoa0Tfxlb6TKVQfOTcTGIVVdTUjf45dBJFsjmYSsl+Z8LHWCmu/JIc
 hCqbUA4c4+veD4iQe9AoHAwNH+0grAcgQga2afOR2qO/E6xdSgfCfZOVd9K44DwZYj2O
 yOqs7vOuipfES/824DNvrJvC/SkyqHfQ4+6JizeMevrsRHQrinKFetZmmAON+koy7xkI
 bGm+paePiX2GM6N7Mh6ooNINrfitFqm9XhvNE4Beyve6BR8NIJCz6jm/pwViLhX1Nzn0
 9vMwlrquzaZYfyLJaV2r5od7YHRfyq2/Kgv4wqX9OoOJ+6019DwqMyL3BZOyM/IErUd2
 Osww==
X-Gm-Message-State: AOJu0Yy/I9zbi3AAR3mQmJlx1LG5lNLxgm8Z2LM7xyll2VyZC8B3O69/
 FUEDGA4TypBi2UhKG+CWpOxcn9Wy7SJPs019nh9sioY4cOnYMZDo8kSVO6r/22a0Q3fyovThMby
 1uUbBLOUcHR2gFD1Ue3dIKch9R4VYc19oXrlTmpzqDVRNtNqKfIkA9tXAJh2PcE3hfU7v3iWTnt
 tgqZSziq/UFKmiexMWOe8=
X-Gm-Gg: ASbGncs2M8LEX27MjB+7Ac13mfETPHiao541DbuflPBpmt/ujldi1Ut8RPBwLVdX0zp
 VM7VLzZIv+bxx3dBlxz/3OvtVdiH3yEN+7sC77OS88gh14lkPnYYUPGxCIt19CFiL5VZvZFcNlh
 HCM9Lw26q1NNDOk9niqN1I+a4367qAAi4xcHXiLViTuyqNlbNWdBnCfxWXjoe/tdzmVtH+
X-Received: by 2002:a05:6512:b27:b0:594:2cfe:368f with SMTP id
 2adb3069b0e04-597d3f0236cmr4332433e87.11.1764939015259; 
 Fri, 05 Dec 2025 04:50:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7UCNaPhlSwE4PmbjWBAJI2gTfAYsha4whvuds5pX40VMEf9b1DNfo9ZgHmPuZLya0WXoPbsFHgy3HcVKZfw8=
X-Received: by 2002:a05:6512:b27:b0:594:2cfe:368f with SMTP id
 2adb3069b0e04-597d3f0236cmr4332421e87.11.1764939014874; Fri, 05 Dec 2025
 04:50:14 -0800 (PST)
MIME-Version: 1.0
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251204182047.3154429-1-bruce.richardson@intel.com>
 <20251204182047.3154429-9-bruce.richardson@intel.com>
 <CAJFAV8yatWvS8OhOJM1yXw1T-RBerjE2psNH0um5KG88T6jnYg@mail.gmail.com>
 <aTLTj4uppv01kT7T@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aTLTj4uppv01kT7T@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 5 Dec 2025 13:50:03 +0100
X-Gm-Features: AWmQ_bkpe19E6y63bOy5y-SOU1HtvLo3IG9Jww5-dIXuRKpJtGQiQnEzOxbXiUU
Message-ID: <CAJFAV8x5fScFgdSzH91-L+M6KTdYXP-NaMWPd5CaeG8L08QbSw@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] app/test: add some unattached tests to fast-test
 suite
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: POT2KhQHNROswD8Cs9zXjY1KljempB4W0iuF3HbS4Og_1764939015
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 5 Dec 2025 at 13:44, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Fri, Dec 05, 2025 at 01:37:06PM +0100, David Marchand wrote:
> > On Thu, 4 Dec 2025 at 19:22, Bruce Richardson
> > <bruce.richardson@intel.com> wrote:
> > > diff --git a/app/test/test_red.c b/app/test/test_red.c
> > > index 7f38ed1469..4b17173999 100644
> > > --- a/app/test/test_red.c
> > > +++ b/app/test/test_red.c
> > > @@ -1872,6 +1872,6 @@ test_red_all(void)
> > >
> > >  #endif /* !RTE_EXEC_ENV_WINDOWS */
> > >
> > > -REGISTER_TEST_COMMAND(red_autotest, test_red);
> > > +REGISTER_FAST_TEST(red_autotest, NOHUGE_OK, ASAN_OK, test_red);
> > >  REGISTER_PERF_TEST(red_perf, test_red_perf);
> > >  REGISTER_PERF_TEST(red_all, test_red_all);
> >
> > The commit 50823f30f0c8 ("test: build using per-file dependencies")
> > removed some context on why some tests were not part of a testsuite.
> > -# Tests known to have issues or which don't belong in other tests lists.
> > -extra_test_names = [
> > -        'alarm_autotest', # ee00af60170b ("test: remove strict timing
> > requirements some tests")
> > -        'red_autotest', # https://bugs.dpdk.org/show_bug.cgi?id=826
> > -]
> >
> > I would prefer we don't put an unreliable test in fast-tests.
> >
> Agreed, but for many cases for developers running these on their systems,
> it's probably worth having them in. What would you think about having
> checks in the tests themselves to detect if they are running in github CI
> and to skip themselves in that case?

rte_red API has been left without tests for years.
I would prefer we remove the library completely rather than having to
work more on it.


IIRC, the issue was seen at UNH, not in GHA and it was quite random.
If the goal is just about removing a build warning, let's put this
test in a "attic" testsuite.


-- 
David Marchand

