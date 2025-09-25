Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71929CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 10:29:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2D15402E7;
	Thu, 25 Sep 2025 12:29:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7638E402AB
 for <dev@dpdk.org>; Thu, 25 Sep 2025 12:29:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758796166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/DzvWd06QqjTfer7DT1uTrA8P63jHIEa5TCUuJQvEmk=;
 b=TwwygrfpxnidCpoR0cq3my3F6pEVMlJ8jCWtFnOrMP3FxiCJg2txnbqX07ZvCBCJCLvUPV
 OOv1CLTq/7Zk2EviI4v4GcYcBpplh4+hZLwQnFbhRHARo6DDakqmKXhAiuf4YJBja0rcrw
 NreHyLrnaApDwYVesRQ6WM13c9D0TNc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-HcPnmsXBMnOcSrP5ryRLDg-1; Thu, 25 Sep 2025 06:29:23 -0400
X-MC-Unique: HcPnmsXBMnOcSrP5ryRLDg-1
X-Mimecast-MFC-AGG-ID: HcPnmsXBMnOcSrP5ryRLDg_1758796162
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-57a898f0932so424393e87.2
 for <dev@dpdk.org>; Thu, 25 Sep 2025 03:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758796162; x=1759400962;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/DzvWd06QqjTfer7DT1uTrA8P63jHIEa5TCUuJQvEmk=;
 b=QruGv2CrLETGvRWaS9YpCuQ98iYkEJeqWmdhIcrfM3ZOZI5nMRHWPN97Ui3XJwl2Vm
 8gxtukGEifNsca9tqdH7ZQIIfGXH5HPQbdcPytGbFzt+PO6j9ww//C9rzeB3u1CXbZHK
 CUsFqwSLXSVdKmgT1jKxdprTvyXZaNadqz/JoIP5yza0ZIQGYymEgeRVTgyBB8o/VKs6
 5k7UBVGwbY7HUAkaWh2+sao8UXkmdhs34aBFl2sZkcjtw+VSlfNHsESv2aCmt0bMZdRz
 q1eIE1rK5fG23X6KVAT0Bd7IbNnzw78gKcl0nRQxspZgApo+AU8aGN6F9ux9Oys+sWb0
 Iu7A==
X-Gm-Message-State: AOJu0YzSDyyhzLKgVOCbuXwPrmxrZfsFJOdeW2GESBUzMRaC+Ce+gDN4
 GbsjagOEcJeX1KJjRxWunDS04/8QxeQIIguLBNdSOfXVCwI0anE1FKkfT94Pj45Y/VQ0pT2ybD9
 za0BV/6bMBw415e6HjeHIUHW49FqEe0sGTNf5/q+7apSaRiSQc6astIxE3LNVEOfbDQJ5yLdm1o
 5Zbrg0ovU0y/zNyyh4RrQ=
X-Gm-Gg: ASbGncs+m29hfcBpntzuyBwU2ez9kMb5C8sGQf6vWpZPSmf8u4cWmqZmdQbVMbvrXZ8
 0oYj9F7UzN7OzzZjUWxFWbAIfuWFPjgsMSjyDhgHXYMIthP9ibmfQ9ZNKsjElQRQkDjwhnZN1KA
 HM4xOTk7tz81+Hf2YqTgeTCp8=
X-Received: by 2002:a05:6512:2c0a:b0:579:ac00:1f20 with SMTP id
 2adb3069b0e04-582d092eb70mr801164e87.2.1758796162125; 
 Thu, 25 Sep 2025 03:29:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa9hw9YE/dE/gt0hQk9L8ODfnHriDJxK5HahdNrQDLXgyBY7/obnrMPERgqprmYpviCSwqKbE+Iufc4xPsdZA=
X-Received: by 2002:a05:6512:2c0a:b0:579:ac00:1f20 with SMTP id
 2adb3069b0e04-582d092eb70mr801155e87.2.1758796161637; Thu, 25 Sep 2025
 03:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250924172536.2447183-1-david.marchand@redhat.com>
 <20250924172536.2447183-7-david.marchand@redhat.com>
 <aNT2gMD4BH44UB3i@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8z7pnVm51HmfNDTr7=xsALPcKN9fRh7rVGgKgM2sWY8mQ@mail.gmail.com>
 <aNUJ3yFwNVpZdGzk@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aNUJ3yFwNVpZdGzk@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 25 Sep 2025 12:29:08 +0200
X-Gm-Features: AS18NWB7W4_fTZKzbMglYJjqgErs_gcB5v2mSVZXdO9948q803B4hHI68N0TATE
Message-ID: <CAJFAV8xY74d7-W1AGxYAKGAgcX4Lwd5KDaX493kkjPLZ-TOXZA@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] buildtools/chkincs: use a staging directory for
 headers
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RwlYgunWRwc3Zl97mH811fxb7cbFo5VquC1O5KauW_Q_1758796162
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

On Thu, 25 Sept 2025 at 11:22, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Thu, Sep 25, 2025 at 10:42:47AM +0200, David Marchand wrote:
> > Hello Bruce,
> >
> > On Thu, 25 Sept 2025 at 10:00, Bruce Richardson
> > <bruce.richardson@intel.com> wrote:
> > >
> > > On Wed, Sep 24, 2025 at 07:25:34PM +0200, David Marchand wrote:
> > > > A problem with the current headers check is that it relies on meson
> > > > dependencies objects that come with their include_directories
> > > > directives, and all of those point at the library / driver sources.
> > > >
> > > > This means that we won't detect a public header including a private
> > > > (as in, not exported) header, or a driver only header.
> > > >
> > > > To address this issue, a staging directory is added and every header
> > > > is copied to it.
> > > >
> > > > Drivers and library headers are staged to two different directories
> > > > and the check is updated accordingly.
> > > >
> > > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > >
> > > In general looks ok to me.  One small comment though - can we not have
> > > "staging" as a top-level directory, but instead hide it inside the
> > > buildtools directory, or even the chkincs directory? I dislike having
> > > too many subdirectories directly off the root of the project,
> > > especially ones purely for internal tooling.
> >
> > Well, at first I was trying to change the whole build process iow rely
> > only on the staging directory and remove all the include_directories:
> > directives from the declare_dependency() objects.  Libraries and apps
> > were ok, but there were a *lot* of complications with drivers (what a
> > *huge mess*, especially for NXP drivers with "compat.h" includes, and
> > Marvell drivers to a smaller extent).  I may retry in the future with
> > some AI tool that will brute force this :-).
> >
> One note of caution here: if doing this, you may want to consider using
> run_command rather than a custom_target to copy the headers in order to
> avoid potentially slowing down the build.
>
> We used to do this copying of header files in the old make build system,
> and one downside of it is that it means that the build of ".c" files in one
> directory cannot be started until the copying of headers from the dependent
> components are completed. The decision to use the include paths in the
> dependency objects rather than copying the headers to a central location
> was a deliberate decision when moving build system because it means that
> when you run "ninja", every single .c file can be compiled to a .o file
> in parallel, because all dependent headers are available at their original
> locations. For most components, it's only the final link stage that has any
> dependencies, the compile commands are all independent.
>
> On the other hand, using run_command is not necessarily a good solution
> either, because it means that all changes to the headers require a re-run
> of meson, which will also be slower because of all the copying. :-(
>
> Therefore, I'd tend towards keeping things as they are here, in order to
> minimise reconfiguration and build times.

I am sticking to the headers check update atm.
The slow down should only concern developers using check_includes,
once I properly gate those deps to the meson option.

Is it still a concern for you?

-- 
David Marchand

