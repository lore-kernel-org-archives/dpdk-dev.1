Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638B4CCA471
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 14:11:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67B1C402E2;
	Mon,  6 Oct 2025 16:11:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1CB83402B1
 for <dev@dpdk.org>; Mon,  6 Oct 2025 16:11:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759759869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vp182qIQV25i5rr1Q9WyEqUYQlkikcxFrFcT8waksNw=;
 b=e9x2vgP3mljszdMBboGNjceZtrtKHVMML67rwAt0B2pkzgR+pJwR5D4fetC6M/yevnu1xM
 KPdIIlFoOnui00AlsOiqUJAgufiqcq3vp9hzqgOoMZhFQnvI9GqxuwaNd5ho7CeZFRHeqP
 DjJRMzunxbwtIogw/ZK8oI2xQexbH7s=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-pcgWaI5HNCadv8N0ZbvwWg-1; Mon, 06 Oct 2025 10:11:07 -0400
X-MC-Unique: pcgWaI5HNCadv8N0ZbvwWg-1
X-Mimecast-MFC-AGG-ID: pcgWaI5HNCadv8N0ZbvwWg_1759759865
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3654fd1a668so18950871fa.2
 for <dev@dpdk.org>; Mon, 06 Oct 2025 07:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759759865; x=1760364665;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vp182qIQV25i5rr1Q9WyEqUYQlkikcxFrFcT8waksNw=;
 b=XLA/aA7pRuVdbS2a/IscsnWPHbKwkupAzWr4tV3KWQD9M2GbVbHEMXRCtXl9Q+px8V
 NTGpQcMN1UJwWk5wZdEfc6e2zCqJiYr6gmnQLG6LfjqCymKSvmPEp0XYtHjskedEa11r
 w/qYvNBJxljfG5y+yiYMP8vETXrPGKQUM0HHDHB0ooUtdS//8HhM227BgdvP+yE975ql
 jEm3Slgy3D9Widk5wo0E4v8FMEO5aOTsGvcnYwKIPSaqBcX+0mog4EhofQ1vVCYRVhWq
 aU4B9Wwbf9ETXpQD3jVZr3qvx3bSUv0iVgPjJHnXKdaqGXa7GSElWwQFhLUKn+72qkYa
 4AQg==
X-Gm-Message-State: AOJu0Yy4Qlhn4ciU9wseKTaoyajPRjEBJZgFZsMvDXLHmSBE37MbEufs
 Ey4F80rwLxoicXLUg7zDtK7/JZ8SIHSYbJrvt3eVGS7RurFPJ2UTkXknbR1sxEFfrg6LKVw8qCH
 Zh7KndE9bTvbRVrQ/yi1goXYks6aeVmxPrY5XSMimEB/vPdyaCG+Bryr/CGU29kKwlRXPMn3I3B
 UHarfpJfNykzSewdHtTKI=
X-Gm-Gg: ASbGnctaTnlo+eGolBsaaJ2q/cpJGWF2sB7BNQ0z3TR1y1Y1KINZxUgz+1PRgARqWM0
 E6AqGHd+xNWgmHAhxH2xYk2hY5c/gZVix+Vo4oJ7IiJQcKaVX11qDm45Ygm8pT2zQ/h/3vLzMPa
 JIBHGCf1mzvCDO0CM86tbs5tX7bXOL
X-Received: by 2002:a05:651c:504:b0:336:ceac:f3bf with SMTP id
 38308e7fff4ca-374c36fe0a3mr35421401fa.13.1759759865089; 
 Mon, 06 Oct 2025 07:11:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIOJTG/6XOMzGRZbLS8H1bzZFGxRw+5FsYsa+MF9ZH30iVToP1Sum4KJUeVCopa8JsFDgr26nk/7tKElwYJ6M=
X-Received: by 2002:a05:651c:504:b0:336:ceac:f3bf with SMTP id
 38308e7fff4ca-374c36fe0a3mr35421201fa.13.1759759864447; Mon, 06 Oct 2025
 07:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251003081510.1197166-1-bruce.richardson@intel.com>
In-Reply-To: <20251003081510.1197166-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 6 Oct 2025 16:10:52 +0200
X-Gm-Features: AS18NWBLgemdR-lMf0_H4KlUG4s1INkeijLDVILC4-7VfV9YEPaEqkgVLLYuvMw
Message-ID: <CAJFAV8yuo6vVSGKx4Cbs6Qqv9Y9dPsLteZtmN+Kr79BmnMqCbA@mail.gmail.com>
Subject: Re: [PATCH v9 00/18] Simplify running with high-numbered CPUs
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Stephen Hemminger <stephen@networkplumber.org>,
 dpdk-techboard <techboard@dpdk.org>, 
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: A3M-xjVoU7SO2LHN3NLumaGwCTqrfUyscOiKU5grygI_1759759865
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

On Fri, 3 Oct 2025 at 10:15, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> The ultimate of this patchset is to make it easier to run on systems
> with large numbers of cores, by simplifying the process of using core
> numbers >RTE_MAX_LCORE. The new EAL arg ``-remap-lcore-ids``, also
> shortened to ``-R``, is added to DPDK to support this.
>
> However, in order to add this new flag easily, the first dozen or more
> patches rework the argument handling in EAL to simplify things, using
> the argparse library for argument handling.
>
> When processing cmdline arguments in DPDK, we always do so with very
> little context. So, for example, when processing the "-l" flag, we have
> no idea whether there will be later a --proc-type=secondary flag. We
> have all sorts of post-arg-processing checks in place to try and catch
> these scenarios.
>
> To improve this situation, this patchset tries to simplify the handling
> of argument processing, by explicitly doing an initial pass to collate
> all arguments into a structure. Thereafter, the actual arg parsing is
> done in a fixed order, meaning that e.g. when processing the
> --main-lcore flag, we have already processed the service core flags. We
> also can far quicker and easier check for conflicting options, since
> they can all be checked for NULL/non-NULL in the arg structure
> immediately after the struct has been populated.
>
> An additional benefit of this work is that the argument parsing for EAL
> is much more centralised into common options and the options list file.
> This single list with ifdefs makes it clear to the viewer what options
> are common across OS's, vs what are unix-only or linux-only.
>
> Once the cleanup and rework is done, adding the new options for
> remapping cores becomes a lot simpler, since we can very easily check
> for scenarios like multi-process and handle those appropriately.
>
> V9: rebase to latest main. CI complains cannot apply v8 patches.
>
> V8:
> * dropped the final two patches from the series, dropping the new -L
>   option in favour of the -R modifier.
> * reordered patch 11 to be with the other argparse patches (now patch 5)
> * added patch 12, which uses macros to initialize the args structure
>   from the arguments header file, avoiding potential issues when we add
>   new args.
> * simplified and consolidated lcore mask and core list parsing to always
>   work off cpusets rather than arrays of uint8
> * enhanced debug printouts to also work better with cpusets and handle
>   core values in those sets >= RTE_MAX_LCORE
> * for completeness, ensure the new -R option works for coremasks, and
>   for cases where no explicit core-list or coremask is specified.

I was planning to merge the first part of the series (before reaching
the cpuset rework and addition of remap option).

I am facing two issues for which I prefer other's opinions.


- First, I see a change in how non-option arguments are handled with
the switch to argparse.
$ ./build-mini/app/dpdk-test --no-huge -m 2048 -l 0,1 func_reentrancy_autotest
ARGPARSE: too many positional arguments func_reentrancy_autotest!

Passing the test name after -- does work, but it was working without
-- before the patch, so we are introducing a regression here.


- Second, stopping at patch "eal: gather EAL args before processing",
I see a crash in this same func_reentrancy_autotest unit test.

Here, I would fix the unit test itself, as it passes a NULL argv[0]
which is invalid according to the C standard.
I fixed this unit test not so long ago (978ead0144c1
("test/func_reentrancy: fix EAL init call")), but the fix is
incomplete.
And if you wonder why the CI did not catch this, the next patch hides
the issue for the unit test, as the run_once flag gets set earlier,
which makes rte_eal_init fail before evaluating argv[0].

On the other hand, even if DPDK does not really care about argv[0]
content (well, until eal_save_args is called and crashes), we are
introducing a change in behavior for (arguably) non standard argv[0]
== NULL, and some programs, which are not passing C library argv[] and
instead building a argv[] array, may rely on this... ?



-- 
David Marchand

