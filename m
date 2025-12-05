Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C07AD2F7EE
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 13:08:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B0B14027D;
	Fri,  5 Dec 2025 14:08:39 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id CA74B40156
 for <dev@dpdk.org>; Fri,  5 Dec 2025 14:08:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764940117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HZVoUKu7C6srGze2c3K8R9W4hg0VbqHQgQZjDIRluzE=;
 b=FhWBitTpkVAiqUmjXtM7f/YC+U+8u0VbAS/ngATG1I61ichAzcL0xZ5LN59TjLJIBGPEAf
 wHpP39tnL48JoelkICqdEx48RjZ125muGm6XNYkDVdtf3PW7N0S4dbU2iiQ5J8Lnii2mSp
 n2Sz0mBoNJ4BSeNBneTMQWxcQsHmWUQ=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-w6IAW9bhPXeT8HgDMiM2ew-1; Fri, 05 Dec 2025 08:08:36 -0500
X-MC-Unique: w6IAW9bhPXeT8HgDMiM2ew-1
X-Mimecast-MFC-AGG-ID: w6IAW9bhPXeT8HgDMiM2ew_1764940115
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-37a46c5d929so23215471fa.0
 for <dev@dpdk.org>; Fri, 05 Dec 2025 05:08:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764940114; x=1765544914;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZVoUKu7C6srGze2c3K8R9W4hg0VbqHQgQZjDIRluzE=;
 b=pEtwQk00g8u3f2Rg+fxRbOd39m64uf/sFSh9XeHiZ92RDiGP9cRYwZrF9xwJeBBUVQ
 MK8SpfWLOM/vGZzrgczRKhxR2bmiV+lXPV4f0EUCh0i0GqlPr4qXSpZVDRy13JN9c+Bm
 maQ7qC9d89pBolXVLJpXUpszmrU4t7V9xvLQZ5f/AObOdB2uX3UnGCgFZ9IolhJtwOHE
 OmHgLm8Myvcseu3HKPI0BsPmkt/KVtj533Vhv9/mG79mQLE+Tae/8pC/Xew5uVvwSjA4
 dtQc8E7D4v7EmXbPLs+QfzxHefFBXBKSTn/wPf3nlBaPLbG0gJPUy6sgMoo2hxgVyhTT
 2Xng==
X-Gm-Message-State: AOJu0YwRMxcBOr4EhmT/0h1d9hg86JdC7667QVrfqf39nTRwfDPiJAJh
 LY2gQOIpUZYPw4fXMrk2lksE6VVanJO4S4gZcTixcTyaurS16VgKz938EO49wvmgb8JIm6O8HPM
 W+6fYRJVS/l60OVvRRobzoxzMKbkbdZfLaxiTfnPtUHOxNi8GCcmR7Ek98/sf2ha2Uh27CkTose
 LnMpSNKPMOOtJDzB4BflssHqha0eUkUQ==
X-Gm-Gg: ASbGncsIxUM5ohgdgpFYDXYdH8PxZ9/BwRJrjSAS29lwvpzHTkP6pBCPipVZa4JMoWL
 aAECExe7LeHITgW3go/nw/A26iLEpxWIbO4j31ixPUi+Bq9pV7I0fJWwLvPDV7RexSM4kSjorzt
 FEIJKdZlaz3tgPU/RN/c/9ZpjEneOO0i9cemDN58Vkul36Y0gcEs08CY5nZaiT/iPXLmST
X-Received: by 2002:a05:6512:238d:b0:594:35c4:fed1 with SMTP id
 2adb3069b0e04-597d668d604mr2183873e87.13.1764940114507; 
 Fri, 05 Dec 2025 05:08:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFA7Axo4r7GkDqMOToWq7Ylgu6EIPvaLLrmrcsANaPFB6g2zS9tbP5G8uSyglvqg1BD5fZBA9OmsninC50FyP0=
X-Received: by 2002:a05:6512:238d:b0:594:35c4:fed1 with SMTP id
 2adb3069b0e04-597d668d604mr2183868e87.13.1764940114056; Fri, 05 Dec 2025
 05:08:34 -0800 (PST)
MIME-Version: 1.0
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251204182047.3154429-1-bruce.richardson@intel.com>
 <20251204182047.3154429-9-bruce.richardson@intel.com>
 <CAJFAV8yatWvS8OhOJM1yXw1T-RBerjE2psNH0um5KG88T6jnYg@mail.gmail.com>
 <aTLTj4uppv01kT7T@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8x5fScFgdSzH91-L+M6KTdYXP-NaMWPd5CaeG8L08QbSw@mail.gmail.com>
 <aTLVxOo_f1QcBPs7@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aTLVxOo_f1QcBPs7@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 5 Dec 2025 14:08:21 +0100
X-Gm-Features: AWmQ_bkjEwfjFrLecd__8C3eSi8apVrDJwVQdGKaWLBJuB4Tnmao3JxC06iIN6M
Message-ID: <CAJFAV8zZrCtpD9tW2=CcZYWO1xTisk_5dPzbpiefCtyfKZrHYA@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] app/test: add some unattached tests to fast-test
 suite
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UNBk4xyB2uQyE_sc6m_XQEOeGOy-8L8zLPTaavqytAM_1764940115
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

On Fri, 5 Dec 2025 at 13:53, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Fri, Dec 05, 2025 at 01:50:03PM +0100, David Marchand wrote:
> > On Fri, 5 Dec 2025 at 13:44, Bruce Richardson
> > <bruce.richardson@intel.com> wrote:
> > >
> > > On Fri, Dec 05, 2025 at 01:37:06PM +0100, David Marchand wrote:
> > > > On Thu, 4 Dec 2025 at 19:22, Bruce Richardson
> > > > <bruce.richardson@intel.com> wrote:
> > > > > diff --git a/app/test/test_red.c b/app/test/test_red.c
> > > > > index 7f38ed1469..4b17173999 100644
> > > > > --- a/app/test/test_red.c
> > > > > +++ b/app/test/test_red.c
> > > > > @@ -1872,6 +1872,6 @@ test_red_all(void)
> > > > >
> > > > >  #endif /* !RTE_EXEC_ENV_WINDOWS */
> > > > >
> > > > > -REGISTER_TEST_COMMAND(red_autotest, test_red);
> > > > > +REGISTER_FAST_TEST(red_autotest, NOHUGE_OK, ASAN_OK, test_red);
> > > > >  REGISTER_PERF_TEST(red_perf, test_red_perf);
> > > > >  REGISTER_PERF_TEST(red_all, test_red_all);
> > > >
> > > > The commit 50823f30f0c8 ("test: build using per-file dependencies")
> > > > removed some context on why some tests were not part of a testsuite.
> > > > -# Tests known to have issues or which don't belong in other tests lists.
> > > > -extra_test_names = [
> > > > -        'alarm_autotest', # ee00af60170b ("test: remove strict timing
> > > > requirements some tests")
> > > > -        'red_autotest', # https://bugs.dpdk.org/show_bug.cgi?id=826
> > > > -]
> > > >
> > > > I would prefer we don't put an unreliable test in fast-tests.
> > > >
> > > Agreed, but for many cases for developers running these on their systems,
> > > it's probably worth having them in. What would you think about having
> > > checks in the tests themselves to detect if they are running in github CI
> > > and to skip themselves in that case?
> >
> > rte_red API has been left without tests for years.
> > I would prefer we remove the library completely rather than having to
> > work more on it.
> >
> >
> > IIRC, the issue was seen at UNH, not in GHA and it was quite random.
> > If the goal is just about removing a build warning, let's put this
> > test in a "attic" testsuite.
> >
>
> Attic is it so. What about alarm autotest? I still see possibility of value
> in having it, but I get the fact that it is timing dependent. Attic also?

Stephen stabilised it: 31fcb7d7dbf0 ("test/alarm: make the test more reliable").
And it was re-added to fast tests.
app/test/test_alarm.c:REGISTER_FAST_TEST(alarm_autotest, true, true,
test_alarm);


-- 
David Marchand

