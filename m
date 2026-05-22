Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D039BCD5BB3
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 14:45:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D66B44029F;
	Fri, 22 May 2026 16:45:45 +0200 (CEST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id 6F51C4003C
 for <dev@dpdk.org>; Fri, 22 May 2026 16:45:44 +0200 (CEST)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-135e88b8e55so1098021c88.0
 for <dev@dpdk.org>; Fri, 22 May 2026 07:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779461143;
 x=1780065943; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+1EYhWc/9IMPKnJ+dlI/YORFVeVToFnq3tnl1YsB8Ds=;
 b=hzyh2hRRt/YB8wzAVXy1GY1pU5XpDhTJZ9mo6v9L5BFaZPYey/egC/bWG1jJFTiYgv
 Pdf4Q6zpSUetfyqm2sNqTa9eGWzkGIL5VKCHOQxgI7/MzrWggdcsCeNLOpkof/dYWyyk
 fYQrzGmYgMP/ga9YwDepXTHiC1YDW2avy9veqVbmWf1ccDfnqlEwLyL5mpuL7sUmwUDA
 kdwmSkj+W8Mf5cVesUTh+qL6Ox9ol9lGUDg2Ul96A4RiiaF42CjsQPH2lxDZOxsYAWXM
 cYeGcI1UOoMjrXeSos1ElEM0yY7sKWLeHmi8jhuNPnOf47N/5e/ottMMNjKne01kbBLK
 oy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779461143; x=1780065943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+1EYhWc/9IMPKnJ+dlI/YORFVeVToFnq3tnl1YsB8Ds=;
 b=h1dQy5cYDtegEWMPvNtDrMYn+2QEtfIz0HGf6dyQVAOHmyc67mFLdsdFpvpxLZe5kK
 qoO6RnWAxYc53YPUiperi46DkT85O5/n8EOkmrf0zZiv8d1HorD7vCvdWYgRvs0DwPTj
 lytGDkdHtn0wloBH5+aPAGsY6uMEXrOS9wGuCU9O7vJFYCqV4K5nupAVDX1G9Bwk1IH4
 C5U6h9wX9yEmxT0PTKsjJX7W3ppxjbM/ROTFxm+aAhqj057aXwOMvTLziRKYODz3Fm+p
 MQC2MaUzFgYXvomH2xXPLhND1MtI3M2nv2GNKUy4x9Cqnzk/I82OFEwABZ+dUnbiZPIS
 uz3A==
X-Gm-Message-State: AOJu0Yz3upDtgt/xDeDG3s7bLEuNYh6G5lzZAWxhGHNzj5XSBKz6TPt4
 X+W0rSTVTDDha959ACi2C+fZijk/ABMNny9yPN6XoJl+cXKBIyJir7XnjUoZ3uvzyJE=
X-Gm-Gg: Acq92OGfkV0mJWAn1Sq8/YI/d3tP4aerwZdoGE/xoFzsRwi7fhC1HIpARpvMsUFH3w9
 S1uGiQ9s9VAesTV+myiy4RHb5MULpztjinouNLGv+ojTnvvtfGfv5o4rq6UdPapU7n9Qf39FIFs
 T+rH6ti5MGXfxwBBXX/ka39Yh5H1HW3dDQvIxWTjv6uwrF41C1BjkAEzv7rse3aIAYmVy/NJ8i1
 wxGeKieQthNYBQ4D5MAHWXR8xB9qAUWlDQUwGTh4O2XnlXDUX1DXd9FMKzyTjQVgShkPCIKFkWp
 PlqBnkTQsAixEwHS14FWUg+MSdW8XhEaa11KDRjHQV3pcajzVOAUgit5HfX/0uuzOtBHdWqnJrO
 EseW+6JIioXS05C9qNv87k2oROI1WtfnqyemNttEVWS4nQZ1MjeCIyjDvSleBZrYZfvbPnTuZjU
 2gHaEDhLJjVx6Nl6l19we4pnvI8tviN6HDIKyDZPjkcuy36FcfsqxElufGcTJgA+JUph0mdoyCC
 9Y=
X-Received: by 2002:a05:7022:1605:b0:132:1e01:8737 with SMTP id
 a92af1059eb24-1365fb403b8mr1505903c88.26.1779461143252; 
 Fri, 22 May 2026 07:45:43 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1366a40187fsm1284516c88.5.2026.05.22.07.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 07:45:42 -0700 (PDT)
Date: Fri, 22 May 2026 07:45:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>
Subject: Re: [RFC v2 00/11] prepare deprecation of rte_atomicNN_*() family
Message-ID: <20260522074540.35029d69@phoenix.local>
In-Reply-To: <ahBl1GytfB3f17hV@bricha3-mobl1.ger.corp.intel.com>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260521180706.678377-1-stephen@networkplumber.org>
 <ahBl1GytfB3f17hV@bricha3-mobl1.ger.corp.intel.com>
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

On Fri, 22 May 2026 15:19:00 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> >   
> I decided to test this patchset with the ring_perf_autotest (using only two
> cores on same socket) to see how performance may be affected on x86 with
> this change. On an initial once-off test to compare performance
> with/without this patchset for MP/MC cases, it looks like smaller enq/deq
> burst e.g. 8/32 are slower after this set, while larger bursts e.g. 128/256
> are slightly faster.
> 
> I then ran two more tests with the patches applied and again without, and
> got AI to analyse the set of 6 results to come up with more meaningful
> conclusions after a little bit more numeric analysis. Below is some of the
> summary.
> 
> While not necessarily a deal-breaker, the regressions seen are cause for
> pause. We probably want to benchmark on a few other x86 (both Intel and
> AMD) systems to see if this is a consistent picture.
> 
> /Bruce

Could you see if problem is the use of intrinsics on x86 or the
changes to rte_ring_pvt?

I am not convinced that deprecation of these function is hard requirement.
This patchset is more of a what-if experiment.
The other alternative is remove the deprecation notice and just leave
well enough alone.

But some of the places actually benefit from the change over because
the are using flags as lock and using other memory orders should
be faster on Arm.
