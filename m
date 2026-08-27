Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E2CC61DB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 14:57:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBDF340280;
	Thu, 27 Aug 2026 16:57:32 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 09D594003C
 for <dev@dpdk.org>; Thu, 27 Aug 2026 16:57:31 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2d530328efbso8537515ad.0
 for <dev@dpdk.org>; Thu, 27 Aug 2026 07:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787842651;
 x=1788447451; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/QU+JFjApJwdpnGI59K6tOW0My+iisb0n9c/v1/4Pss=;
 b=frbiQFGdiaxPdNcDVOoW75hIkut26+4JI2X8CI8ZGrrrelxDGn2FDOq39QHpWRZEQT
 aK2MUTpUOECzJVIzkJqIfiZCOrgtk3+z6n/b0j5eJfAOif62K//9/KLMwsOygbodm6xJ
 5ZUG24Rn7IR3qpxlrFzoEI817TkqBV6nMmPcs0757d8jjP4nsYgTrF89OhD24pG6aA8X
 FPchTnKWiHFdw+AqIj46DKQVlpPT88Pz9ZmEN+tFFbMVwX2yGwUI5x8clpmaFhjD9cas
 2UggICIhVvJ8fA9t/HPOjdlSyBydGSrF6ze011OyP/77nBatznxZqMBuQFWNS+qbhFIX
 hPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787842651; x=1788447451;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/QU+JFjApJwdpnGI59K6tOW0My+iisb0n9c/v1/4Pss=;
 b=czfMLZR/JYxAxv2bBYY7QYXHHYRXcQ3x7FOYfXoRkqv21BywuHIH6kVMoxsFkPVJ95
 hYBC8Vau2iGY2i3jW5rXNv8mJQ+FaBVmFwqPcvkpmEAZUZlUQjUh1h8SmtwS3bWt3t8c
 vCxPnUHmAJr2tDEZnCgYnboNabBCQLQJe77peWqi6r7nKj1sUkG4smpWY+e00Z3HcWI7
 TF0ZiXjpMDJ6mSgXmP8EwNhWTYNYJ7Dd0uKXbJVMj7laTyave/2Ip4Q6KxU0hFTNKqd0
 VM+Pbvld93C2YbAXv5gRNTOLwY8OKTxsO7dIBj52pa5DUNsf9+RhEaWeh//xpIfC5JQr
 uSIg==
X-Gm-Message-State: AFuF++lqCA8Vh3sAwmXCSZjY32xT8T7imSdmbF32hq5cVIbv4CIMgp14
 V79Wi9WnjLO/EwjgVthuJiSyla7UoJ3eiwxGVSahT2Z01fwD5ghS+Ew67CVtkPMXBN8=
X-Gm-Gg: AR+sD11G8VmDIopQZiJADNYd73SayqEfr5JR27ngaFdrugPgpbaJxCjhXxuTBZ6H7tr
 stsb4zmuqFGwAsEWmBJauxX51IYmgg3EuoUIpdolI9lkEQR49Jg5raGhRu9JeDNb1VCnpPxB2/F
 ZPAwc5503TUOWB2zcX43CwHHF4mZqaloerPc48F+zV5jpoMVESQ0zOJw4I826hlbzjGP4CpsKpc
 DxWnnJmFMRtU6Gs+kntwdl25e0rgrwS2jWn9643XKG3u1hQyAaAo+r2+SK0F5es5N70AanXPiHG
 MG+Zki0Vu45XQg6jXmUWgx0oFgYoxl4Jsjix1l2pH/xzshdI15WJIxFe9dcoWeObRWcmBN36i+h
 NXDx4+du+0VGUzP8aEhuilpnUksE5Jo/HOyOhHRointDggK9AyK//ypzF4DsjUvslot3DHixm4M
 j+Bd6cZkBA51wFAoOXg8MM8HdhgwRIMHZa3p0aOA/RrnM8WSwqLy0JB8wTrQ70CD0hjiw+4SByY
 2jE1F/Oc10eOhkr1pJ4BEZXZtNA6Qk=
X-Received: by 2002:a17:903:b45:b0:2cf:afe8:b722 with SMTP id
 d9443c01a7336-2d707af1729mr307904415ad.11.1787842650914; 
 Thu, 27 Aug 2026 07:57:30 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d60b59dsm20599909eec.3.2026.08.27.07.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:57:30 -0700 (PDT)
Date: Thu, 27 Aug 2026 07:57:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: Re: [PATCH 1/4] common/dpaax: fix unused variable warning in
 non-debug build
Message-ID: <20260827075721.1344582e@phoenix.local>
In-Reply-To: <CAJFAV8x62b_zeyF5P-X4KSMxaD4Sd=XanED-7PitDztxtnUFFw@mail.gmail.com>
References: <20260826235933.194681-1-stephen@networkplumber.org>
 <20260826235933.194681-2-stephen@networkplumber.org>
 <CAJFAV8x62b_zeyF5P-X4KSMxaD4Sd=XanED-7PitDztxtnUFFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 27 Aug 2026 11:07:50 +0200
David Marchand <david.marchand@redhat.com> wrote:

> On Thu, 27 Aug 2026 at 02:00, Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > Fix compiler warning on clang-23.
> >
> >   dpaa_of.c:14:12: warning: variable 'alive' set but not used
> >         [-Wunused-but-set-global]
> >
> > The 'alive' flag is only read by DPAAX_HWWARN, which expands to an empty
> > statement and discards its condition unless RTE_LIBRTE_DPAAX_DEBUG is
> > defined. Make the empty expansion consume its argument so the condition
> > is still checked in a non-debug build.
> >
> > Fixes: 8c83f28cc8a4 ("common/dpaax: move OF library from DPAA bus")  
> 
> Not that important, the issue probably predates this commit.
> And looking at this change, it seems DPAA_BUS_HWWARN is dead code since then.

That is when the device-tree warning was added.
The history scan looks right.

It seems like it should either be removed as irrelevant or made into
a regular warning. But that is up to Hemant and Sachin to decide;
I just want clean builds for now.
