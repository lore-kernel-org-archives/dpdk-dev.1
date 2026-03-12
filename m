Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975FA106ACE3
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 19:57:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C0BE402AC;
	Thu, 12 Mar 2026 20:57:27 +0100 (CET)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by mails.dpdk.org (Postfix) with ESMTP id 47FFB40275
 for <dev@dpdk.org>; Thu, 12 Mar 2026 20:57:25 +0100 (CET)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-1279eced0b9so1944055c88.0
 for <dev@dpdk.org>; Thu, 12 Mar 2026 12:57:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773345444; cv=none;
 d=google.com; s=arc-20240605;
 b=X1PCaUayuhiwaX5hrLUsHtpIxoVYV8ysqcZqYbQjxMrdkBx0K2fPpKJE/5AXO2xMkW
 OVFrrI6JoulzPeNHhH+WbctLarnFBd1w1rCGskDK4KusaQyyf7+/3wh7HVjTGVOE9OxS
 PtUGc+dHrJnPWokmUqYN7umGWqMysCdgULNf5F2xXbr7OSADay5/Sc+thZ6/lmKwfsJc
 i3i/SRdIIHwn8CNF/jol99eWQ8jE6Nlz9ZeueDZdh8DLT0HL9xjn+wnAAL9LpmfoMpTh
 rRYvwmvhlhAfT4JVqA0jOdgUKgcsFEVgdqrcaNLEDKG3hY6SjuN+plO9xTXCHmO3n29M
 WE1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gxsC5d1vV/qhoBSPKdmeKewpCVQcEnR+SR7PKMRUTmA=;
 fh=3DlKQUBkh3BvmM9EBvBbtQsbHO0icDdrV2qCF6YN1d4=;
 b=IjVwK+YFs9zikYTn6+XTE/fM3WhueHy5CUhgQjJg+4B1I/32adn1Gi4PEh31CFW+iR
 NDcbqXBgQWK0DI9ecP/RJ6atqYcPbTlIXhaGvywP7euL8KuiGd9wOTtMW50wWHfwlm9d
 yVYRYgnIMD7mucqUKX9C9Lh0L1HlSf95hetV7vMqA9Gmgpx5e2QD3U87XAAVzW/60SHa
 KDsSELSZjsNwVHRkg1O8E+5eR2djG6LvkvcAkaNrs3iAh1ze9LZAyO3oeJ7nAL8hcxua
 2239tI0/8VIGy4jTsuiei/M2hR4XkPjyZUBp2LS62oVN905Ioy4jP74rsO48YBxJLkAh
 TMJA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773345444; x=1773950244; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gxsC5d1vV/qhoBSPKdmeKewpCVQcEnR+SR7PKMRUTmA=;
 b=HXBhIh8IaHE75E4VGB1clN0U0ZcjgJ5eYLQYON3wGeEbwPn/3GXH3M9yTSEUmJ32Er
 ruVk7JI15l1KFfwsG9ucpvPystRHzarOhus/AWME8+CQ9p3/ZvtScIbzjJCxcFN7fZml
 8RrSesSt8NJ+VruLlUbVUNvfnz4dWyYDNSuLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773345444; x=1773950244;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gxsC5d1vV/qhoBSPKdmeKewpCVQcEnR+SR7PKMRUTmA=;
 b=cDa93XzuIC1+WnoGo/IPwQs4Gg5Hucdl86EXC0d6Xt2O8SdPHY0lzXf/6wi6Lx8tpz
 On2uSJeDn166mG6M6r8UW9bVa2A/1USS0Rr21qfCelGWhTvFSHI6DYW+lYFEeaTE76yL
 qh4brIuHKdZu8AbowQi2RVDm1sfBnoVyDPJ6XAeWa66Tn0ZG9fKDoEi8bU6bLOfnDOG0
 6Q0RhWymt8z2xf+lIQG/Ub47ryH7slS3eflD6e6TAMigNVjkRJ+3LiToo87yZgYy1w0G
 lrN5qCz27k7J9yiGoukRLx1UoF2kVVvBo5heDT770ZxTezP3BBjhXJdq+NRy56moTDaD
 UgcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyhSUIWpao4vaRO/Z458S0XQs+oaKlH1jFhq600aHg59TXArHd/4TfL/50hYn3M50vkJ0=@dpdk.org
X-Gm-Message-State: AOJu0Yy0p4LwfD/JpYEcVtQPbtODzZNfWzWTzzjmktYKKUmdBv0WgCTw
 CzB5OMhDjsDCKDW+krkYghmB0hYygrEy0iFgt2IXJqcvo4TaRc+EIdbWUASmRq83joyvmYG7nW5
 aa6ld4O/vsZhaGbh3dGqGCqTEGiLon1FdQIe0GeGLOQ==
X-Gm-Gg: ATEYQzw7se00ej5yYNTjEpBWWaRlxJHwDGVAv2BcvlAVZWx1iF+gZtuGlXK6baYTs3g
 C1QjHOGYUjM/OVLgCs/5dGZWtBmWbbEQJdUYZWMXLV9QvCcTPn3xB4IkPtR6AJFFHPjILlTC2y2
 6hll0dI/SIA5gOJcw8R+ueCyiswICOaqpWoCppDUWu97hFZfvyOUlqqg1iQ4H9I/5lfH5CCJLyS
 m0O6TnwBuvDy6e4wGpYhL/5XHHYBZeVcbtcMqwZolZm1S5vWCdrpiTh1D/N12xVF3jWLmdiWcQV
 ydyPoHXY2riYcwSOM7pQWDXq83If38iER9P9y9qd7LKGVf++E7Sd1SROvO34OdJku2RJkXeStlr
 FkKBOOAU=
X-Received: by 2002:a05:7022:4397:b0:128:cf70:9042 with SMTP id
 a92af1059eb24-128f3dc1edcmr410619c88.18.1773345444117; Thu, 12 Mar 2026
 12:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <20260306164027.171723-1-abailey@iol.unh.edu>
 <20260306164027.171723-6-abailey@iol.unh.edu> <8652174.T7Z3S40VBb@thomas>
In-Reply-To: <8652174.T7Z3S40VBb@thomas>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 12 Mar 2026 15:54:18 -0400
X-Gm-Features: AaiRm52kx-cEqASeS7XslEKg9EeyUTc9iCh-L55pP6-WtF_pswTSb0BLzZXL8m4
Message-ID: <CAJvnSUDXGacdubwUaWWK3zZNx6zXPmoJLQm5_AdT7=u-mEqiWQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] dts: add crypto test decorator
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Andrew Bailey <abailey@iol.unh.edu>, dev@dpdk.org, luca.vizzarro@arm.com, 
 dmarx@iol.unh.edu, kai.ji@intel.com, dharmikjayesh.thakkar@arm.com, 
 david.marchand@redhat.com, gakhil@marvell.com
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

On Thu, Mar 12, 2026 at 2:08=E2=80=AFPM Thomas Monjalon <thomas@monjalon.ne=
t> wrote:
>
> 06/03/2026 17:40, Andrew Bailey:
> > Currently, a test case is decorated to signify whether to use Scapy or
> > TREX. This change allows test suites that do not use a traffic generato=
r
> > to avoid the overhead of initializing either one.
> [...]
> >                      if (tt.test_type is TestCaseType.FUNCTIONAL and se=
lf.func)
> >                      or (tt.test_type is TestCaseType.PERFORMANCE and s=
elf.perf)
> > +                    or (tt.test_type is TestCaseType.CRYPTO and self.c=
rypto)
>
> That's a bit strange to read,
> because a crypto test can be functional or performance.
> I suppose we can re-discuss the classification of the tests.
> If the only need here is about the traffic generator,

In my opinion this is not quite true. There is another (and more
important) need associated with the test categories, which is allowing
users to run only a sub-category of tests according to their interest
or hardware setup. I.e. we can expect some people to show up and
desire only to run functional testcases (perhaps they have a minimal
hardware setup which is not good for performance, or they are only
working on resolving functional issues) and the test type categories
allow the users this flexibility with regards to what kinds of DTS
tests are run.

> we could make it "raw input" or something like that?
>
>

In any case I agree with Thomas and Andrew that the situation with
regards to test type classification/organization could use a review
and a tweak in the 26.07 release. Right now every single crypto_test
is a performance test (i.e. it runs a crypto workload, compares the
Gbps output against the Gbps baseline the user set in
tests_config.yaml for each testcast). But, some open questions for the
future:

1. Is there a need for users to select only functional crypto cases vs
only perf crypto cases? Or we can just leave all crypto cases in 1
bucket?
2. If the above is true, should we switch the testcase decorators over to:

    a. ethdev_func
    b. ethdev_perf
    c. cryptodev_func
    d. cryptodev_perf

and every testcase gets one of these decorators

OR

We apply multiple decorators to each testcase (i.e. add both
crypto_test and func_test to a testcase) and have the framework code
read the whole set of testcase type decorators and setup accordingly.

Thomas, is what we have right now in terms of testcase classification
okay for the 26.03 release, and we can tweak it in 26.07, or do you
want us to do something in the immediate term?
