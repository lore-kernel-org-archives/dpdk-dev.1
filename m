Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C367CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 11:54:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C89240671;
	Thu,  2 Oct 2025 13:54:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1372F4013F
 for <dev@dpdk.org>; Thu,  2 Oct 2025 13:54:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759406076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=112g1ccoXHCeTpTCFHXevupf9p2j7H3c/MvqIcSWHNo=;
 b=bFaQl86fF1DKy+BYsVbtMcV3rAcKUIvh/e7a5V20aGPFpBCizPYtOs3B+GwljZuyydxW2N
 cnKhwj4zm+0RP64qXOpagvTDvT+lExFfbPqvWLixtXFP2xFmoPRIcJj/KzFh+rmZQNe7Q/
 fzduZcEHSrmmIi5EZMZuRiyjWPCY5PY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-OUT5kuHvPi-BKjzHnHTeYg-1; Thu, 02 Oct 2025 07:54:35 -0400
X-MC-Unique: OUT5kuHvPi-BKjzHnHTeYg-1
X-Mimecast-MFC-AGG-ID: OUT5kuHvPi-BKjzHnHTeYg_1759406074
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-336a6070642so3172691fa.0
 for <dev@dpdk.org>; Thu, 02 Oct 2025 04:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759406074; x=1760010874;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=112g1ccoXHCeTpTCFHXevupf9p2j7H3c/MvqIcSWHNo=;
 b=arTQRQHn7yg/xj1bbXQxClnXN0CKfKYVvOUp/6ysM9ZpibdHBTW+VHUMoaPGm3MNs3
 sFlEAnE+Z5pqfj2kHM8rKPerJ+eUwoAL1PVL6PKkTRlmNFs5STcgktiS7kqUuXDVH9ax
 8tdZj43de7B8HZAQjk3pzdSaXrv241WamHLwHbflThFZ4tmz2etYd7sh3H3rPMrb+pYE
 FZ8ZrpSeAPNZeprCC6Ht6DhQQ+VxWJTq48eikg4LMFRll0/Sa7lfdq0lgNsdSaXh+WJy
 LvXRxyb/oI6yoaUT1l09+Frdy91eBjPsVSCEWWFA+Hl4kwK2FI0V8KN5pAueqSxO5Jgq
 L6rA==
X-Gm-Message-State: AOJu0Yxi5WoDtZ8HZugHWPVPwrACKVMzMKvKwxPewDfYhiIKeCjXI6nB
 4ZceCuzcj93wvoHtKlcit0ROEI9Jkt5Wn/ouupKbCfcYhFU9YE09lmyXaoNURdIe9yQLuch5d2o
 zDLfTlIstuJkfS8cOUnX6NMn9FQmka8FzYTAVTrM9qKJAN4fgC0j9Idke/XyerMUolKoLRLdBnp
 3ZxWPXeeu70c6Kcnx1tWU=
X-Gm-Gg: ASbGnct0+9f8tfleFGHcIh4HwHux+JMXdMGmvFazOQXk6uQAn1gwHDL6R08vSCuxi90
 B63vxIDeYRopZllzpDuXMHih9ph8/6YVgk3xCHkguMs6sgY4zWP6dZmmMS/kKutLtvPbDI3r2M5
 99ECfIWHYDW4v8k4smhV4WOl1pgi0n
X-Received: by 2002:a2e:a542:0:b0:372:9453:3173 with SMTP id
 38308e7fff4ca-373a748c2femr23746791fa.40.1759406073828; 
 Thu, 02 Oct 2025 04:54:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECQFHw/O2DeJ1GP5grHFaKqUpULIw9eJz73VScIcE2FWu7bTeyCMLEZxEWceEU8Y5xO6XmODLmOESnmFhWrPg=
X-Received: by 2002:a2e:a542:0:b0:372:9453:3173 with SMTP id
 38308e7fff4ca-373a748c2femr23746611fa.40.1759406073376; Thu, 02 Oct 2025
 04:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <20251001081825.2638077-1-david.marchand@redhat.com>
 <9acb2557-1f42-4880-ba93-020b14e6a0f5@intel.com>
 <CAJFAV8ynhCwV76W+1QVwDrzXFLiRWv+x9FiQkCGq+fw2f0CLJw@mail.gmail.com>
 <CAJFAV8wcEgvqdCiPefmxUSyP=QjfYoWiJ846EZKsDDnwa-b45g@mail.gmail.com>
 <99b9882b-d5a0-467a-be09-5bc88af2cba8@intel.com>
In-Reply-To: <99b9882b-d5a0-467a-be09-5bc88af2cba8@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 2 Oct 2025 13:54:21 +0200
X-Gm-Features: AS18NWARPLfUV6A8e45oSyGc7Cjv3roxgP8KiAOMKRqhIBO9qMWKZT6Q3Hro870
Message-ID: <CAJFAV8wed4TtWKeD5D7dpxZB074NPLfOPhNvK7G8hXPZCeV2iQ@mail.gmail.com>
Subject: Re: [PATCH] ci: configure Coderabbit
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, rjarry@redhat.com, Aaron Conole <aconole@redhat.com>, 
 Michael Santana <maicolgabriel@hotmail.com>,
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RUi0tTrNScfY5donKPBsOC10IVxF9nI1JPrWXb-0kUY_1759406074
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

On Thu, 2 Oct 2025 at 12:34, Burakov, Anatoly <anatoly.burakov@intel.com> wrote:
>
> On 10/1/2025 4:23 PM, David Marchand wrote:
> > On Wed, 1 Oct 2025 at 16:12, David Marchand <david.marchand@redhat.com> wrote:
> >> On Wed, 1 Oct 2025 at 16:04, Burakov, Anatoly <anatoly.burakov@intel.com> wrote:
> >>> Can you provide a little more details on what exactly you are proposing?
> >>>
> >>> On the back of this patch, I installed CodeRabbit in my IDE (VSCode),
> >>> and did a review of one of my recent patchsets - it's quite interesting,
> >>> actually, and the comments provided were basic but meaningful, alas the
> >>> free version is limited to like 1 review per 30 minutes or something so
> >>> it's a bit limiting. On top of that, I found the tool a lot more usable
> >>> than GitHub Copilot reviews, which are attached to GH pull requests
> >>> rather than Git branches, and they take a lot less time to boot, so I
> >>> feel like this tool has potential.
> >>>
> >>> That said, I'm not sure what this patch is supposed to do - is it to
> >>> have it set up to review patches automatically?
> >>
> >> The ovsrobot creates pull requests in its dpdk github repository, and
> >> Coderabbit and sourcery are invoked on them.
> >> Look for a link in patchwork, under the name "ci/github-robot-post".
> >>
> >> For example, this exact patch got a branch and pr in ovsrobot/dpdk:
> >> https://github.com/ovsrobot/dpdk/tree/series_36267
> >> https://github.com/ovsrobot/dpdk/pull/124
> >
> > Btw, you'll notice a bit of noise, due to how the PR is created
> > against ovsrobot/main, and not the exact DPDK main branch at the
> > moment the patch is submitted on the ml.
> >
> >
>
> Wow, I didn't know this was a thing! Sourcery actually seems like the
> more impressive one in terms of summarizing the changes and aiding in
> review, but those two in tandem look pretty cool indeed. Makes me think

Well, Robin gave better feedback on Coderabbit than on Sourcery so far.
Coderabbit seems less picky on credits when it comes to opensource
projects (I did not check in details, that's *my* feeling when looking
at reviews in DPDK PRs where I see sourcery complaining we consumed
too many credits recently).

One important difference between the two is that it does not seem
possible to tweak sourcery with settings stored in your repo like what
is done in this patch.
This may be a problem for the DPDK github org, where we have DPDK and
grout starting to use AI bot for reviews, and may have different
opinions on how to configure the tools.


> of an alternate reality where we use GitHub (or something else more
> modern) to review code :)

Erm, my personal opinion, the github PR webui is a *mess*.


-- 
David Marchand

