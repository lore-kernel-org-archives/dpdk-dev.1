Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B312DC982ED
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 16:40:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB87642E60;
	Mon, 21 Sep 2026 18:40:03 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 22E8842E4B
 for <dev@dpdk.org>; Mon, 21 Sep 2026 18:40:03 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39d654f02baso2703050a91.3
 for <dev@dpdk.org>; Mon, 21 Sep 2026 09:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790008802;
 x=1790613602; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L4WUzovuQzSOdzJuC/129vx81qzX1aqJncSY42whCcs=;
 b=Xu5gSJE2jvpMDrlxtpPimUYPSBnEe93tn6zJZRGBLuQOx1tPnXPeyzRNEL2SH8Zc8j
 U2cF3GxIvSeLpUOetgft0QPWci9wQhLwCd62t8g49nVqtJ5KdjS8yEvLiDhgZ0Yvf7a0
 UJrPulqe5JN1lNzmfy6j0Z5By1IVg/55ZtqNNCsh6NqlMWVaP/KtU6KYvbcHNrYwDo8p
 wvejNg5UgohfFQrwWxmuqZyHK+yxZc4UDzXDWMYFmg0RojT0qCmL01BoYr8uYOqTA/Wn
 Mz/U0acPioHS5b/+Fko9XYgmD+04a5sY1rGHsWZXK/DmU6tUL1iV2m9FDCMPngfddcHK
 xVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790008802; x=1790613602;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L4WUzovuQzSOdzJuC/129vx81qzX1aqJncSY42whCcs=;
 b=aqcYudaK2TzoQgiVYkon2ugb9knsRjKWAH2UU2W5PzeDmsUTSEVM0py6VVcyy2UumL
 rJTkupMyvvFjTtaIFcuOp6cNXSzV7rKhlP+Xen1RhQK1bTwQ/BQKQ1mY/RlZ7nu39E0A
 txeXGL8oY7rX+WCVLas0VytJ5sTDKoppdj9S6Raaj0ZFv/kkfHWJiQAsnoyAYu4IN0ul
 qRgJPkTPod+XEGu4obdNnAG+twqVAAon88pfAwZ/1+6TPfzYixAF7LrWnb8sD869u4v9
 hBLo4+Ro32TdlrwbbwWCZ54ZOmRrnbBOi/zo31QPYJg9mMKmJYq8rsbWwhnzyBNoF4lJ
 2vEQ==
X-Gm-Message-State: AFuF++kZ/MSQezeJbTzTmZ9zpMW2E30zwI5xUeWjjmqMYEI14MGBvbN5
 BpkKuLMjUXGV6h1eU8fX5getGZ5/cGUJCcU0islYmSvngGYipd8Oaijr6+Spgei78c0=
X-Gm-Gg: AYBFou3CLwZOEeDBUAF9cUsORHg91UbRKM4XbNRAErdZSR/iSnHybWPkh7LKZ9viZ2v
 F47IkZDgbExGdLFIbqcBCOMunZY8SzFaHuX7AaA/7z/3NBej+2VGYwqwcFN0mv7xI4Dg8LaXMXP
 uxiPuz9d67bt89XwGQN8Ml5MJuqazk/86nEOnkneI6YWp1ig8D6j2P4h+31BsqWzq78bxAtXmiP
 2RFgPQYpEtyuRCRgXNT4DiHvyJNKmEzISqWEN4Le00MoT8nHq0S2+dRUe+/j/ZNsU1/69KYlqxB
 XzLW7cNXufD33pOvGUPjES41i5ARdVw8ez3NofGR0emzmuLzQpTBUYDg7LM6PtdFcNppJtezOQW
 wMiGiDETtAhNx9qNy/HPwSD0nwu/nOrbYwQN77H1uMt2lKQk5NEfnSvMq2SAd4QMasPD+J6xvkJ
 Jvd8h3w6nXeUIR7lL265ANYIb5dkk6nw75pz8oQZfcOBUDJfyMkxo04NDQ9mQAR+waNFbso6l1t
 J9ETmNU+2gyJO8N8oC94RZk3ptaVFFoSx8qHyXR
X-Received: by 2002:a17:90b:588e:b0:39e:6c69:34de with SMTP id
 98e67ed59e1d1-39e6c693711mr10706081a91.66.1790008802047; 
 Mon, 21 Sep 2026 09:40:02 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0670b410fsm134148a91.9.2026.09.21.09.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 09:40:01 -0700 (PDT)
Date: Mon, 21 Sep 2026 09:39:51 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH v3 9/9] ci: run reference binaries against current ABI
Message-ID: <20260921093951.61ffe6b7@phoenix.local>
In-Reply-To: <20260921114737.2334589-10-david.marchand@redhat.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260921114737.2334589-1-david.marchand@redhat.com>
 <20260921114737.2334589-10-david.marchand@redhat.com>
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

On Mon, 21 Sep 2026 13:47:36 +0200
David Marchand <david.marchand@redhat.com> wrote:

> Let's check if a testpmd and unit tests from a reference build can run
> with the current release libraries/drivers.
> 
> This gives another level of ABI checking, like catching regressions on
> experimental or internal ABI symbols that get promoted to stable without
> providing an alias for existing users.
> 
> We may need to skip unit tests that were added since the reference.
> So add a ABI_SKIP_TESTS environment variable in preparation.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Patch 9/9 (ci: run reference binaries against current ABI)
Errors:
- The new DPDK_TEST_SKIP computation in .ci/linux-build.sh never
  skips anything, defeating the mechanism the commit message says
  it adds ("We may need to skip unit tests that were added since
  the reference"):
 
      DPDK_TEST_SKIP=$(grep -vxFf reference/tests.txt build/tests.txt |
                       sed -n 's,DPDK:.* / ,,p' | tr '\n' ',')
 
  The sed pattern assumes a "DPDK:<suite> / <test>" format, but
  `meson test --list --suite fast-tests` never produces that. I
  built the tree and ran the exact command; with meson 1.12.0 the
  output is "fast-tests - DPDK:acl_autotest" (dash, no slash). I
  also checked meson 0.57.2 (DPDK's stated minimum): with a single
  --suite filter, get_pretty_suite() takes the `else` branch and
  returns the bare test name only ("acl_autotest", no prefix at
  all). Neither format contains " / ", so the sed substitution
  never fires and DPDK_TEST_SKIP is always empty, regardless of
  meson version.
  Consequence: once this lands, any future series that adds a new
  fast-tests unit test will fail CI when ABI_CHECKS and RUN_TESTS
  are both enabled -- the new test name is not filtered out, meson
  test invokes it (DPDK_TEST=<name>) against the old reference
  dpdk-test binary, which does not implement it, the command exits
  non-zero into failed="true", and the trailing
  `[ "$failed" != "true" ]` fails the `-e` script. This is exactly
  the scenario the DPDK_TEST_SKIP logic was added to prevent.
 
Info:
- The commit message says "add a ABI_SKIP_TESTS environment
  variable in preparation," but the code implements DPDK_TEST_SKIP.
  Possibly a rebase/rename artifact worth squashing before merge.
 
