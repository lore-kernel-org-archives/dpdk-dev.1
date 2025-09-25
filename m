Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175ADCAC5A5
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 10:23:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBEF640698;
	Thu, 25 Sep 2025 12:23:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id DA7A2402AB
 for <dev@dpdk.org>; Thu, 25 Sep 2025 12:22:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758795779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=evyOwlVJKx+/ayaXBUP8/4nENsFzwdtlgxPEqnx8hgA=;
 b=QUUra91jlYr7BknCy2g+5wBzE+3V9ubbeZCb/28Hwr/KN6Fcron+/4JS98UDkpYJkOkvH7
 VIbomGLty6u/4hE19IQoASMmmQWMJloYhCWoyRHmvZofDr3WLjJnDWze5PTfd09xsV+fgb
 NTE5eXaBckonf/q0x/Du5zsLHDmRPLc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-MbpDRVkIMim-8imM5MhkSQ-1; Thu, 25 Sep 2025 06:22:58 -0400
X-MC-Unique: MbpDRVkIMim-8imM5MhkSQ-1
X-Mimecast-MFC-AGG-ID: MbpDRVkIMim-8imM5MhkSQ_1758795777
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-36306eec0d4so3202031fa.3
 for <dev@dpdk.org>; Thu, 25 Sep 2025 03:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758795777; x=1759400577;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=evyOwlVJKx+/ayaXBUP8/4nENsFzwdtlgxPEqnx8hgA=;
 b=gHFOq87xjUek9MhXZeC6reb8wX8Ce164B094rNWfZQLIqExkTN6v4WX4yCdDWVBYuB
 HYRt74JlmUzt1NxKnjm3Yek5GDQVLzraJzdmMCco9/AtXdGq7FdoorJx2JprhvXbylP6
 sfwPe9hDXGLY3YjsevFATPP3jJs5dy9i6lv0Of6RAV7/YiOldocmxFwzIOu0934+9gGQ
 LHTk9RIRkUKLWP/smSbEhTwBpBcQEa/GU+4eI67vlCB7h1JO0OWKXsues462s5IZvcrC
 zZARXNfe+P5to1cL/VwhaLLa0TitfiYARkmy04cIh+efJkP/ReiCnIAtnI5+8EWAcn5D
 BvEA==
X-Gm-Message-State: AOJu0YwLWf5mcF8iQaVl0xLVDa4KyXIHM5iyf13Qp9b4q2/x7LIcLRS8
 KywvlGPNZ2YS9o7nJelYgpNFDg6hVH5kSWFocFEcxpyAYLDOqWLYjYVVfSPJcYtouRm8PdTlt6q
 OjAuTy0dOfkIMRIqYiXpa/py2JYfDlQ5kNPsLnwHYTfAOnhJBvwCj2FPLuDwRG3qIhTsHmZshe7
 2rjuHfUWgR3id4q3uNWEM=
X-Gm-Gg: ASbGncudBBU0n2B3huv3ldzBcazQlKpRVKy/vwcXuSMDLwKpnIA8tubeGtm4+8BjAfL
 sZq5SoTg5fOYR3jLTn50idf+ALqN/3/s4cUFSHRXKPhzHihcSZopnIvilRVT5OncXXY6ri1oarL
 rcdkb2bpXkee7GgiZIpE57D1U=
X-Received: by 2002:a05:651c:3257:10b0:36d:6ae3:813d with SMTP id
 38308e7fff4ca-3707c1b8c1cmr455811fa.8.1758795776576; 
 Thu, 25 Sep 2025 03:22:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBtMMyo/HJL5TdPXmsPCpKmMJ2Fq2uOyN4NG8kCKhsIkSNDx7FA4pZ067ewwo0eYCILVpdLFfqh/+UCjFxA8M=
X-Received: by 2002:a05:651c:3257:10b0:36d:6ae3:813d with SMTP id
 38308e7fff4ca-3707c1b8c1cmr455721fa.8.1758795776108; Thu, 25 Sep 2025
 03:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250924172536.2447183-1-david.marchand@redhat.com>
 <20250924172536.2447183-7-david.marchand@redhat.com>
 <aNT2gMD4BH44UB3i@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8z7pnVm51HmfNDTr7=xsALPcKN9fRh7rVGgKgM2sWY8mQ@mail.gmail.com>
 <aNUL_Pl6Hf2bmcJJ@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aNUL_Pl6Hf2bmcJJ@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 25 Sep 2025 12:22:43 +0200
X-Gm-Features: AS18NWADG5P5jseJKNtHtiyJtasMaPf0RWIIiOcO7r4fUqsbRHWdl51myyBwDuw
Message-ID: <CAJFAV8zBxax08GOBDqyL1ZC=S_DzitNA=isrir7RCA5iehiwWw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] buildtools/chkincs: use a staging directory for
 headers
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b5HNd5454ruNFGFzRLPlQrArgmaHvbvkxh2nJUrde30_1758795777
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

On Thu, 25 Sept 2025 at 11:32, Bruce Richardson
<bruce.richardson@intel.com> wrote:
> > > In general looks ok to me.
> > > One small comment though - can we not have "staging" as a top-level
> > > directory, but instead hide it inside the buildtools directory, or even the
> > > chkincs directory? I dislike having too many subdirectories directly off
> > > the root of the project, especially ones purely for internal tooling.
> >
> > Well, at first I was trying to change the whole build process iow rely
> > only on the staging directory and remove all the include_directories:
> > directives from the declare_dependency() objects.
> > Libraries and apps were ok, but there were a *lot* of complications
> > with drivers (what a *huge mess*, especially for NXP drivers with
> > "compat.h" includes, and Marvell drivers to a smaller extent).
> > I may retry in the future with some AI tool that will brute force this :-).
> >
> > For now, I gave up but did not reconsider the location of the staging part.
> > Moving to buildtools is indeed saner as it is only for the check now,
> > and I can also make this staging stuff dependent on the check_includes
> > option now.
> >
>
> I wonder should we just consider making chkincs an install-time job rather
> than a build-time one? We could look to build chkincs using a custom
> install script (meson.add_install_script) after the header copies are
> already done for us. That should cut down on the complexity within the

Not sure I follow, what would this install script look like?
Is it not similar to the makefile solution I proposed previously?


> build system, but it does mean an additional install step to a temporary
> directory to get it to run. However, for use in our CI I don't see why
> having an install step with DEST_DIR set to /tmp shouldn't be feasible.


-- 
David Marchand

