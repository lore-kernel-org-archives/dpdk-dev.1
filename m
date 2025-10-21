Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384A0CCD1A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 16:53:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A429402D8;
	Tue, 21 Oct 2025 18:53:23 +0200 (CEST)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id 3B5B2402A1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 18:53:21 +0200 (CEST)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-816ac9f9507so6497385a.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 09:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761065600;
 x=1761670400; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wb1Q9K5Q1tprZG08zzLM1ZITVqDdi/D5MonGOXRP6F0=;
 b=gMCCcRvxrbbPyPsAW31/F1L2S0+/RdYgh8VoO0WyJDau+zTHtjkdgHIXVEIA4jVP8q
 EK9EzoF5veuTAIEm61ZFjXAbGnuVbM5Pmv7FmQ190FemaYzyM0xHMqjKe31+n8/KSWls
 OkUII3qXJCEhv41upHc9G2gaEabVZ2s8h5s5D/v3ElPmeoIIJvqk6bzQCt+xcbqeyUpk
 k3Kd/zSARsjix1l6Omfo57Au/VP8/F1eoVBWETIgCSq9UJWf2r1+y1JTUkWbFhRZDOm2
 RqEh4qoJY1gSU7fR7eBcsC0cMXAkr30XwDoiOThb13+fadvzGEuM5DfhRxByI0DSE0Hg
 bJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761065600; x=1761670400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wb1Q9K5Q1tprZG08zzLM1ZITVqDdi/D5MonGOXRP6F0=;
 b=AYLHd4kcwgvRhjMd439vFF/VOrFGD+/rjIHVJZ5YwgBS3+871LYXEXm3q/rNW13t+Q
 0NCiaahDkBaZOPKy6S1jFT2FnVOymd5rV9DjmgoKetDr4IcvPxIPUtdrUQeV6eDANScE
 ZuIFGUIPXkffWhLaTzBjMUyQYtqpUo1lTOAdk3SB168itP3T0buRVfccd9y/8E/z8t7Y
 iMLB373ylcI/omUQZ+XjVDwO/wq0QzPUY9pTQDiRCIliY/++SZgESNVZ9dGzZjR1v4Ij
 SKwTSsSraZmzBTOmyD36AD5fllSc3Tx0UqrjzjQ1eYCHQrs2A9Fh2EajVqQa5EXYC5+b
 5Mzg==
X-Gm-Message-State: AOJu0Yz+cdRFZvjo6aq1077MEXsqxUysnO5GEVgb9frezREHyHx7EN+v
 WWEYofHOO9rWDJtNxzRAhKc3ITvSXwxN7/RgoFrJLnq2mNsG4tbYNfwEim/nhIlFBi4=
X-Gm-Gg: ASbGncuhyN5gq03pJU9+8kOeLyz0Do3Qf96sFph8OeR/Y+K0dNZm4m+Y/BgmJcWaOJm
 IcTViCkxmUwwvpjdmqVII85c0VJgvR15pkosJJzG072QKW/meJMzIcQFDB0/7ak0nflxbNzKY+u
 bl2OWRIViqaLpXGgXX3PYAJ2ezsR1V9/XMYFOnBTKj2uIDFtbClgLyAvielrbj810NljTQ1qm/g
 sEnpM34vlq1CCVrEH737VivgoypOqpcBO0rYOZYuLrnF50dV1FHoPBE5d66DfhYtSzf1WOXeGko
 W6uQp+ckL0V6w+6Dzx+KdFyjyouWp4gUub1SNQ8I5JkZCao9YX0ZMZVxxVCAQXHz4SbPc9XeGQ2
 BanrGGG+DWB88L9aQS59He8Wit/Eml8oxZpMcvqp+/pEw3BBuVSxaeKTzKJCwEI5QcMrfLuvV0+
 9cI+w48HykcLE3c+954bGmnO6XYW3fksGzYJb0mkc=
X-Google-Smtp-Source: AGHT+IEFzxBmvc95xRyJIWvZu8T1JM3P71I+Klw3mARLNuRVmu4UE8IVHKUwYpXsE8rAqZ4UIE0d0A==
X-Received: by 2002:a05:620a:4102:b0:893:1d2d:4ecc with SMTP id
 af79cd13be357-899dbd70c56mr68585385a.7.1761065600301; 
 Tue, 21 Oct 2025 09:53:20 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-891cfa62309sm797746085a.57.2025.10.21.09.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 09:53:20 -0700 (PDT)
Date: Tue, 21 Oct 2025 09:53:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, thomas@monjalon.net
Subject: Re: [PATCH v3 3/7] ethdev: remove queue stats from ethdev stats
 structure
Message-ID: <20251021095316.4c459aa2@phoenix.lan>
In-Reply-To: <20251003110201.1541183-4-bruce.richardson@intel.com>
References: <20250923141207.10403-1-bruce.richardson@intel.com>
 <20251003110201.1541183-1-bruce.richardson@intel.com>
 <20251003110201.1541183-4-bruce.richardson@intel.com>
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

On Fri,  3 Oct 2025 12:01:57 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> The queue stats part of the rte_eth_stats structure has been deprecated
> for many years now, since 2020 [1]. Therefore we look to remove these
> fields from the stats structure.
> 
> Unfortunately, the flag introduced by the deprecation,
> "RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS", means that for drivers using it we
> still have to return queue stats from the driver stats_get function.
> This means that we need a new parameter for those stats as part of the
> stats_get interface. The autofill flag is set for 35 drivers, which
> means that if we didn't do so, users of those 35 drivers would lose all
> ability to get per-queue stats.
> 
> [1] Commit a72cb3e7656a ("doc: announce queue stats moving to xstats")
> 	https://github.com/DPDK/dpdk/commit/a72cb3e
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

This patch needs to be merged with next patch because each commit
must build cleanly. Committing something that doesn't build will break
future bisection.
