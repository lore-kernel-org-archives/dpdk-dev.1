Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E31CD343F
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 May 2026 12:36:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 101D740611;
	Fri, 15 May 2026 14:36:23 +0200 (CEST)
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com
 [74.125.224.53]) by mails.dpdk.org (Postfix) with ESMTP id 4C4F3400EF
 for <dev@dpdk.org>; Fri, 15 May 2026 14:36:22 +0200 (CEST)
Received: by mail-yx1-f53.google.com with SMTP id
 956f58d0204a3-65c21049dafso10643248d50.2
 for <dev@dpdk.org>; Fri, 15 May 2026 05:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778848581; x=1779453381;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4zbUdBwqqUzYsEFATOi2cnSFUTuwz9jI0g7M37Uj/mA=;
 b=pIoa/4eoRuqjpcGFv393aD3uB8MWJjbOzy7IVSPLBm9dyIkgjC/D0iRN+C6FC4XpA1
 I1ED+d2fZ4lkFDE6AsLokWKQxDZkweq7l57033Q5Kn2KnDxOXsxkP6cFIzfg98RBlOk0
 8b/s+LKEPJKdY937BthLW8xO8gub1taQqiCcNCmplOPysDv+c1/EnNpIfuU9Wy2n93ij
 8WJobwHCTKr0H2RdGalZiEn6qDfj9k2wnhcQVd9ympQ2EWsK8OMSwVAWWBMaQNMbEt4m
 vuT7KuvFOguzqvFOeBPckiTckZidK+JoVNbU7+RXYyC7gamr1nS8UmsDXHCv9He59ti4
 oAhg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/b9AQgok7B6luKiWicXcHeGvLQgx0iIlV2F0wFjpE3Qa2whfsOws1dw+EvAkg1ie9LK0E=@dpdk.org
X-Gm-Message-State: AOJu0YzB38cNDhtr5bmYdN/5V2Vf4GhbyWpcf5DOfrVaqXRv9xo+st6N
 oaPruEwxs81i089Ga6rnCwvfw0W3T9T8LNzcAb6pk7v/MFoAYzdWsfKg350x/pob
X-Gm-Gg: Acq92OEcZHOARwqLnwdvEL+zOXBNpm2z/GY0lAIqnHrEqqNW8fi0D7+qDSR8bftljJ+
 F2CogD0M6WqD8tXxY1VoEknu/CTOOkf+0Xl9CxwcoKqgTjJ54PYYrimRIsxC7RG0qPa5R9uUvhz
 bUFgdEjEmKIqcEr+Tb7G6w1/NdxLu7Fxes86bAA68EDCQPZ3MmgebLjyBKklaM7mYYB83pwdv37
 LpybDJbfwpSz0uAOiDWqjd+I5Mdo4rUF9somq0tCymBAr4hi+Wq/0BLvOvZWuVbmoFOAZOjOSvr
 RvFBfQBNH53R7mzc/sbop+lJu0mV7PeXPCYWOA9lRJMfgcAkYSQUYSrV/JYtIVV2BjyxAs0vbeK
 woOYPmODO4tL7sNPZBawkCXKwUykpS4FDnOwyjNls+bdMGRCUjXhVJ2EiBitFad6QyUn8QKtzNJ
 Nj+WoDowEIogFQmbKwRWXMBrrGgpTfBaz5WILK74jxngu5wFOVN2aanMo=
X-Received: by 2002:a05:690c:7681:b0:7ba:154:87d1 with SMTP id
 00721157ae682-7c95be1331bmr31204477b3.33.1778848581423; 
 Fri, 15 May 2026 05:36:21 -0700 (PDT)
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com.
 [74.125.224.52]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7c7f55ba65fsm28220557b3.36.2026.05.15.05.36.20
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 05:36:20 -0700 (PDT)
Received: by mail-yx1-f52.google.com with SMTP id
 956f58d0204a3-65c364b893aso11327354d50.0
 for <dev@dpdk.org>; Fri, 15 May 2026 05:36:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/iIXWhYqc4zWQXJ+x4/3/F7kisUL629D2aReRUrrZm3a9JVnJHTFx7IZTp7hBzGrIrDFQ=@dpdk.org
X-Received: by 2002:a53:d015:0:b0:65c:391:4553 with SMTP id
 956f58d0204a3-65e2264f62amr3305006d50.2.1778848580599; Fri, 15 May 2026
 05:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260421064637.2506152-1-shperetz@nvidia.com>
 <73da1ec3-d1cc-4efb-bedf-89b0f951ec5d@redhat.com>
 <2787587.q0ZmV6gNhb@thomas> <f27bd211-66c0-4a87-9d11-de6d83cae4c9@redhat.com>
 <91a6d5df-57c8-4045-9cc4-4ea0f5170f52@redhat.com>
In-Reply-To: <91a6d5df-57c8-4045-9cc4-4ea0f5170f52@redhat.com>
From: Luca Boccassi <bluca@debian.org>
Date: Fri, 15 May 2026 13:36:08 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnSLnz8uxwPJgZThKUm4fpsge_dvb8+o4grBeNYYsmuBMw@mail.gmail.com>
X-Gm-Features: AVHnY4IA7XfzMgR-tQjJlSU_9e4o3mCecLEjYHGRErruTc5F9WBeT6RANlb-47U
Message-ID: <CAMw=ZnSLnz8uxwPJgZThKUm4fpsge_dvb8+o4grBeNYYsmuBMw@mail.gmail.com>
Subject: Re: 23.11.7 patches review and test
To: Kevin Traynor <ktraynor@redhat.com>
Cc: Shani Peretz <shperetz@nvidia.com>, stable@dpdk.org, dev@dpdk.org, 
 Robin Jarry <rjarry@redhat.com>, David Marchand <david.marchand@redhat.com>, 
 Thomas Monjalon <thomas@monjalon.net>
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

On Fri, 15 May 2026 at 11:32, Kevin Traynor <ktraynor@redhat.com> wrote:
>
> On 4/30/26 12:02 PM, Kevin Traynor wrote:
> > On 4/30/26 10:58 AM, Thomas Monjalon wrote:
> >> 30/04/2026 11:32, Kevin Traynor:
> >>> On 4/21/26 7:46 AM, Shani Peretz wrote:
> >>>> The planned date for the final release is 30 April 2026.
> >>>
> >>> As discussed on thread [0] there was a quite serious regression caused
> >>> by "net: fix packet type for stacked VLAN"
> >>>
> >>> As discussion on the fix is ongoing, I would suggest to just revert this
> >>> patch for your release.
> >>
> >> I agree the revert is the best option here.
> >>
> >>> It doesn't require a new RC and re-validation as it's an isolated issue
> >>> (and there wasn't test cases to catch before Robin's new patch anyway)
> >>
> >> I suppose 24.11.5 and 25.11.1 are also impacted?
> >>
> >>
> >
> > Yes, I was hoping we would have a fix in a few days and we could add and
> > re-release. Given that there's now discussion on the patch and what
> > functionality is needed, it's probably best to just revert and release a
> > new 24.11/25.11.
>
> Hi Luca. Are you planning to do a 24.11 release with revert for above
> issue ? If you have a time issue, let me know and I can help out.

Hi, is it strictly necessary? Could it wait for the next one?
