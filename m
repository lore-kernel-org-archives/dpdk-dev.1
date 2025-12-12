Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F25D59F52
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 23:23:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8100F4027D;
	Sat, 13 Dec 2025 00:23:20 +0100 (CET)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mails.dpdk.org (Postfix) with ESMTP id 82CC440268
 for <dev@dpdk.org>; Sat, 13 Dec 2025 00:23:19 +0100 (CET)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-7b80fed1505so1749252b3a.3
 for <dev@dpdk.org>; Fri, 12 Dec 2025 15:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765581798;
 x=1766186598; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Slz5OQAT3KQeakwfXvmPxfQCjB7+nlDxDqpjuyUQ1kQ=;
 b=uzE2p5yspjMqZcvGnvMuKaTkg2J3jQn7z5jg43Nb9hsTwQaFKTKyo3LD86LxFL3EPx
 6jvKOy1v97fnsASH9hzikeYABErvCub41n3bFCjGFAFqyC3I9Z9OA1Bjkngh1mSBRXiY
 mb7EwnlBScQIdNKxFqt8HA8FDybsn+D4zrme7NIoJumMMICaPVkAkZXp/E7kFgzfsEvg
 tO7+eMAdPeCUVGlpOgr/NKHMwwnXSvGncrq/cqJLu49SE1W2GYKMu9bweGez6kqnOFd7
 z5V6mRu0fKj86YwZGIHOAEHuJ4om9mtbZGbY4ne6jCrnISQLVIk8B+DGD538riTdESqt
 kAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765581798; x=1766186598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Slz5OQAT3KQeakwfXvmPxfQCjB7+nlDxDqpjuyUQ1kQ=;
 b=KrgTQlBiR/9UaaIb1eyi97TvJN6Xr4m0JFPGpHslOaNdVH4/8loDKBENZSeskArVv+
 VBgRjr3SfU4v11eoPoLfBPRuX89HTlUKURID/XKWGd+Pr2nsd00CHE8iDAnaBNGJwnyW
 G2pjcLuCSrfohec+Ke4qkwVRSiJO73FYG//cH4PhPau+gOuXG4vrcoX4j7/Rxx0zhZjp
 NXwoy5NGESebhV2H73gOAKHTCnDaUbDHV1dljMU9vB4IKCNmU3D/xokWb8ty31jIn6tx
 R7pxK9NeNZi1rOeoK5zhu/0l7AAkNr+BxPtmFMlknpp4Ca6x2Mswr2edZ1m4r2tvP1l0
 auTg==
X-Gm-Message-State: AOJu0YyG5jxDYrqFldWJlyaDuSRj2D7PEvkbdBCV2HenHPkioC3r4sn4
 65d2SRcjFoFYKdvPQsr6p0/shDoO/axhlMei27rvpCvhwFPNvrXI5Dghg3SXtLOXcHIlWyN2qNK
 XrftOTMU=
X-Gm-Gg: AY/fxX7eWiuCDdurL8FZm8ax71aU9imBSoOGNmmuDV8GTuwuovQIHTRLpEcDJnSzKYK
 8sCLDHzSwJBYukZviqcYYOr2tmZmaqLARBelUKl+pOqIcqdoqOJ3o5Rn+H+gebOmKKeFNq3P/SO
 P9QXqQyaEkO/4af3QfpAUQfLWKr5bGCc8WDxg6X5Axer5uq/V3XY2UIMP2UMyoscWCQc1NkncLo
 sf9w8XbVUxW7nk0IzBhRo9RuPyRh6aoPZ2tZ/0EaxQJxqLnw9GsFqh+M6Kjf9bldZOBcEUq3DmN
 IeNUcOTbkLO9oJb544p0odE4H4GgYbjSTS6O1Vo/aptF9DZfUZrXkRgTjLgcqeWtFUsvgOJNmMD
 8vZwbdkljyFj9ou7bpS5zeX1uZTnQ3VDb4HhHSBTAxbp2aUEDVNpqi9T2Usqk/3lM1L1CZ7m6CX
 4LttVP3s+p2Gl+ZyzVotvpw18wKE72OVkq+uOnful4KPDyrSSvUvb3VvFL1xw=
X-Google-Smtp-Source: AGHT+IGFErmwJN4/FuigXulCpc8NsrqS7j+6M1nsrZnNLlJlU0BCX88nAUrJbeek0CzKSgMfe6Aftw==
X-Received: by 2002:a05:6a20:914a:b0:35e:1a80:464 with SMTP id
 adf61e73a8af0-369afdf6213mr3143003637.46.1765581798177; 
 Fri, 12 Dec 2025 15:23:18 -0800 (PST)
Received: from stephen-xps.local (p99250-ipoefx.ipoe.ocn.ne.jp.
 [153.246.134.249]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34c1dce7603sm389511a91.12.2025.12.12.15.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 15:23:17 -0800 (PST)
Date: Sat, 13 Dec 2025 08:23:11 +0900
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>
Subject: Re: [RFC PATCH 0/7] Add script for real-time telemetry monitoring
Message-ID: <20251213082311.7d44e4c1@stephen-xps.local>
In-Reply-To: <aTxWTww_gHjwQfBw@bricha3-mobl1.ger.corp.intel.com>
References: <20251210165532.103450-1-bruce.richardson@intel.com>
 <20251212143249.2fdbeaab@stephen-xps.local>
 <aTxWTww_gHjwQfBw@bricha3-mobl1.ger.corp.intel.com>
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

On Fri, 12 Dec 2025 17:52:15 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Fri, Dec 12, 2025 at 02:32:49PM +0900, Stephen Hemminger wrote:
> > On Wed, 10 Dec 2025 16:55:25 +0000
> > Bruce Richardson <bruce.richardson@intel.com> wrote:
> >   
> > > TL;DR
> > > ------
> > > 
> > > For a  quick demo, apply patces, run e.g. testpmd and then in a separate
> > > terminal run:
> > > 
> > >   ./usertools/dpdk-telemetry-watcher.py -d1T eth.tx
> > > 
> > > Output, updated once per second, will be traffic rate per port e.g.:
> > > 
> > > Connected to application: "dpdk-testpmd"
> > > Time       /ethdev/stats,0.opackets /ethdev/stats,1.opackets        Total
> > > 16:29:12                  5,213,119                5,214,304   10,427,423
> > > 
> > >   
> <snip>
> > > 
> > >  usertools/dpdk-telemetry-watcher.py | 429 ++++++++++++++++++++++++++++
> > >  usertools/meson.build               |   1 +
> > >  2 files changed, 430 insertions(+)
> > >  create mode 100755 usertools/dpdk-telemetry-watcher.py
> > > 
> > > --
> > > 2.51.0  
> > 
> > 
> > The TUI patch was
> > https://patchwork.dpdk.org/project/dpdk/patch/20220831115250.362189-2-conor.walsh@intel.com/
> >  
> 
> Took a look at that patch proposal, and here are some of the main
> differences between the two scripts:
> 
> * the telemetry-tui is a full-screen app which is a lot prettier and
>   probably much more suitable for non-experts.
> * the script I provided is FAR less user friendly and operates at a much
>   more "techie" level
> * on the other hand, it's more flexible because of that:
>   - can be used to display any numeric stats - the tui is hard-coded to show
>     particular NIC stats - including e.g. cryptodev, or dmadev ones
>   - can show deltas and totals as desired
>   - can quit after a certain fixed amount of time
> * my script is probably more limited in terms of what can be displayed,
>   since it assumes that you want one-line of output per update. TUI
>   displays lots of (fixed)stats simultaneously
> * TUI as proposed has a few glitches - got a divide by zero error when run
>   against a testpmd instance that didn't have traffic running, so all stats
>   were zero. (That's an easy fix though)
> * The new script I propose has one major feature that I would look to add
>   to the TUI if we merged that - the reconnection support. I find it very
>   handy to run the watcher script and leave it running while I start and
>   stop whatever app(s) I'm using.
> * My script has no additional dependencies beyond stock python, while the
>   TUI requires one additional dependency "rich" to manage the TUI. It also
>   can use a second dependency "plotext" (not Ubuntu packaged) to display
>   charts if so desired.
> 
> Just my quick assessment of the two from a quick try of the TUI one.
> 
> /Bruce

It is not a case of A or B. Both tools are useful.
I can see uses for both. But original submission of TUI seems to have
been a one off patch with no long term followup
