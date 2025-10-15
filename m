Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AA9CCD199
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 16:11:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C96B04069F;
	Wed, 15 Oct 2025 18:11:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 11F9C40273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 18:11:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760544680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sP0RU1O/hnRaIo2+lveozpzhwNg7RpHMxv+cFkdKsMk=;
 b=OfOgT2p3dl2Zua3i55YqLgkNYhF9JL9x2Q7t2u2JOX92hA/RGmYrOlbiUpEEyzPB54MEzK
 vubAqc8oCjNNhV85w6BcRXPNj/+sOZWXo7tFUj1sYGegAnoi5xPgbvMiq9TcbsK3i0Km+J
 4H0G2WTA2+h5HQRQT/IOqJ/n1zno6Rk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-rAipxpAQM-OQtQttuUiwbg-1; Wed, 15 Oct 2025 12:11:13 -0400
X-MC-Unique: rAipxpAQM-OQtQttuUiwbg-1
X-Mimecast-MFC-AGG-ID: rAipxpAQM-OQtQttuUiwbg_1760544672
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-58af844137aso4305039e87.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 09:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760544671; x=1761149471;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sP0RU1O/hnRaIo2+lveozpzhwNg7RpHMxv+cFkdKsMk=;
 b=j9/L4gXN3Ctid0lg8HVSPDOmRIgSbU+M1twBNPWp7n1O566pGT0h2rq2leQdU1bbPo
 3Oa99uYPRfUWKwRGQin9hCaNKl5c1/X4EHrDezq+4Lz1/Y+7+AZp97tvtBFfSBrOu0n2
 8hcdCS4qLocIsapSbXhCAxqAcU6pCrVWpQlXVwcNj87GYBlM4wcm8Z2Abujxhrq19S9b
 aEOsxUJIhLJZ9KA9Egf5AyVPrPAlQd9TiSAPaO+DD9YnwIMxH1eEyMJEPtm98VB1zwTT
 ZHFKonek1k6G2psxf/z80V4/EHrok1KvVGs6Cu78gLjpYz5unOfzchZE5t3UtAkFj0rM
 63SA==
X-Gm-Message-State: AOJu0YxnXEFQMJv+3xVKrARtivQMyVtirXQd5tbCcEyZjpBZ8zMcqg1l
 eUOIl0D+XPyWgf5MDlOQec6QbdfuxTJZi28OxhPSZljQXEXs3KvQfqBRbbxvAIeS7fZ4d7GcbBu
 LrmtyJ4GPn7GNx3jOSlDA3KC/IRXGJ1310p1BqqKysqXbSWrG/1N1R08dbor1fMuXIyVBd1yaxk
 xz4foJ590Fwcx+J0BIQw8=
X-Gm-Gg: ASbGncvXYyw2cncYSErcE6ZadLHikqdCsd3HEmCs6UVj2CBVuj9ojASeCGfIySJvBzm
 4qF67BUD225tcDKfepiK8Pq9doCijoW+I6KLkqKnmpEfdj/2B8Q3vUk75Zoi4fv6/3kBNmWvPvo
 fIFBQ8Ujgz7nTPlMveT2EX8J4=
X-Received: by 2002:a05:6512:39c8:b0:577:184a:460a with SMTP id
 2adb3069b0e04-5906dd7d4f4mr8766253e87.38.1760544671508; 
 Wed, 15 Oct 2025 09:11:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsuHq0MrAp3f9nh/i6vcUfvGOD6aunSdJNXwTp46SmgzWTMavaFKwrtVpU65WM6Du25sBlXn/DRc0PGmWF6zs=
X-Received: by 2002:a05:6512:39c8:b0:577:184a:460a with SMTP id
 2adb3069b0e04-5906dd7d4f4mr8766242e87.38.1760544670939; Wed, 15 Oct 2025
 09:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251009130056.2630343-1-bruce.richardson@intel.com>
In-Reply-To: <20251009130056.2630343-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 15 Oct 2025 18:10:59 +0200
X-Gm-Features: AS18NWBzj7-yC0mDaPA8235R7qe-2FWgl1b7yk73SnFgE7vBz9iGk4lmlPMxxtg
Message-ID: <CAJFAV8y+cWnMr0QNrsvtBKLOsRq-1QN3tcRP75LERj9b4-eBYw@mail.gmail.com>
Subject: Re: [PATCH v11 00/21]
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>, 
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZrH6PPXiFZqBunO3jRKUADhOdlqqgtnHCv-G-hv3XRI_1760544672
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

Hello Bruce,

On Thu, 9 Oct 2025 at 15:01, Bruce Richardson
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
>
> V11:
> * fix issues flagged by unit tests in CI and subsequent testing:
>   - when passing in an lcore >= MAX_LCORES, return error rather than
>     ignoring it. (compatibility issue)
>   - return error when an invalid lcore set of "1-3-5" is passed in,
>     rather than just treating it as "3-5".

I did some tweaking on the series (and put my sob for taking the
bullet if I broke something ;-)), namely:
- squashed the init arg list patch into the initial patch that
introduces eal_option_list.h,
- inverted order of the patch on coremask rework with the one
introducing lcore remapping,
- I updated patch 6 as Chengwen requested, and I fixed return codes
for parse_arg_corelist(),
- I updated the doc for patch 8 as Chengwen requested,

I fixed a few reintroductions of socket-mem (should be numa-mem) in
intermediate patches.

I noticed that the leak reported earlier on patch "eal: gather EAL
args before processing" is still present when stopping at this commit,
and it is fixed in the next commit.
We could have avoid this transient issue, but I did not spend time to
fix as it is just a leak in the event wrong EAL options are passed.

There were some little checkpatch issues I fixed (plus some spurious
empty lines/spaces).
But I left the options definitions as is (wrt line length warning).

Wrt storing the cores as a fixed size cpuset, this storage is internal
and we can change in the future (no ABI concern afaics).

Series applied.

Thanks Chengwen for the reviews on argparse.

Thanks Bruce, this was kind of an unexpected long road.
This is a nice cleanup and I like this auto magic option and the debug logs.


I have two questions which could be addressed in followup patches but
seem more risky than what I touched, and require a new round of CI:
- are we missing a build check on RTE_MAX_LCORE < CPU_SETSIZE?
- should eal_clean_saved_args() be called in rte_eal_cleanup()?


And finally my dumb idea:

Do you think it would be feasible to extend this remapping mechanism
for multi process?
I would like to start all processes with only the -R option (and each
application has a dedicated cpu affinity, set by an external mechanism
out of DPDK).
Then some exchanges between primary and secondary processes are done
at init, with secondary announcing a number of lcores it needs, and
the primary replying with a lcoreid base for remapping.
One problem is that it would require tracking life and death of the
secondary processes to that primary can reallocate unused lcores
ranges.


-- 
David Marchand

