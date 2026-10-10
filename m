Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7025CA9EBB
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 02:28:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC992402B4;
	Sat, 10 Oct 2026 04:28:55 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id 1E83E4027C
 for <dev@dpdk.org>; Sat, 10 Oct 2026 04:28:54 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-3ab62a8250aso133998a91.1
 for <dev@dpdk.org>; Fri, 09 Oct 2026 19:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791599333;
 x=1792204133; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L60a2gEcAwiO0UDabODfao/kCGl4eZ4KU9VyGOIsTkc=;
 b=jgp8bQ8bk8Y4e2MoCkK/pomwtpkoHpcJqSlhg6L2cAYR6dlY4Fi1GKK4l0jIjR/kp+
 bFCP0EEsuFVjiE6r45uKplvFVlFpMjxBJMWVdUgI0Y5uwH19OaGua+YqmYcIKMcN+BPV
 hSrEWLTYz9aiWVcfRzO7uU9yidNfMo9Pcj/e/vSsOKTuVFMaqziUZtAYbMLk10b0F17F
 3/mfK77oegcPIUHXLfWbNC0GJ0JSGPkLgKMowWSCxy79/BYTyfoZ3tuxDnCDpnBdbini
 ivNb1MFjaH2IY1zYF4JbyZp/bE8xnswl4HtPR80l0P/DAkGQTa79sSuQulLvYQgLjYuN
 m1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791599333; x=1792204133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=L60a2gEcAwiO0UDabODfao/kCGl4eZ4KU9VyGOIsTkc=;
 b=PPS9M0adDqBVXgI4Rgg21IljM9s09Z/RurYlJdKbHZAbHThGUN211vV+5JcAuuUFg7
 JD6z2HpSaP+05DWOxnoNZ9sgUrmqVcNnOlcHV8jgLUyd5SuBxZRZxujdnGoC2knhpp3n
 5LLEkWSnarSVn64pZ+sAf7aDNFhkGctc0GulT3eC0rWuQMxoPVW97Rog6iqneduwzUWT
 1BEuTrThBv8YZWOUqWqLVl0SAG47Tzged9+g7eO2cP+CdqkmRuqDD++xGqI52N0RdU2A
 duX21eEsmQl+6sUuNZ2bfF6ZalAqrpiyElsHYKm6g7rXr3N5Xq5SDNzNdwtQS/U0DXGE
 02dQ==
X-Gm-Message-State: AFq9FYIYc17Sdo6mLmO2Npt951vF5y987wTITHDa9zmDvl70WPT4sUCO
 /jHYsLdoZfRXdsBY6Qt1lHkI4pWTHBkYVAgn+EVcuY3atPY3TFE0ENTnkhhNU27j0zKGt9e90Mi
 8S1PAVUI=
X-Gm-Gg: AYBFou3W8Upcj03EkVbIH95sjMl8P3MSCfcHMveBwrpW+cOFmuV2At3PDGCnyL2DJmV
 f36AdF0CSzxxiTVyw+9frI/Ia5xlI7p6m8DSvcSzp1bnsvdUIG5quSV+48f9rJXTALRk6AbNAfl
 rGT6KacqTpeoZEAeg2WkIEmLHE4R9KBvnh/Tth3vucwYp7XeC8ZE6btUPfxG4aa3L47eGWLpq5M
 nepB0NP/oIJdMe3vK19IsCTVGqOiOiGIrkDTElNvfVVDwKsdZBDo7JbfnpN6q+ufOQ+zkg3z1Sv
 UkffzG5/fO58YoPjH3A9zD1N0KDcHTtVad3fH1iZjMuWkG0lFA/mbrwZycsGdNZukoMuzfDqIGK
 0rKKLhYbzv9MMPTBl2lnFRad/DvIYOqVqKnDq0WvsAHKgGF5YyILG0XH+5AYXvXSPKlCfF5vEEp
 GObH8sVLTxJSiyRQzn8rzdmxnOHwy/umWa4RgOSdhcWGyPYcV48OFRgjm1Xdrf7otm/L4BkdsIK
 +G9KT6OhJYmyWdBcPJbuf59vrke9UNYH5+8Eg==
X-Received: by 2002:a17:90b:4d02:b0:3ab:8a06:1b0c with SMTP id
 98e67ed59e1d1-3ab8a061d3fmr329774a91.36.1791599333116; 
 Fri, 09 Oct 2026 19:28:53 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab3690474esm6202882a91.0.2026.10.09.19.28.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 19:28:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/5] random: fix initial seed entropy
Date: Fri,  9 Oct 2026 19:27:02 -0700
Message-ID: <20261010022851.1872825-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915192207.3926217-1-stephen@networkplumber.org>
References: <20260915192207.3926217-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series is about how the random number generator is seeded: where
the seed comes from, how it is expanded into the generator state, and
being able to pin it for repeatable test runs.

The build detection of getentropy() does not work, so DPDK has been
seeding its PRNG from RDSEED or the TSC on systems that do have
getentropy(). cc.has_function() probes with -std=c11, but glibc hides
getentropy() behind _DEFAULT_SOURCE, so the probe always fails.

A TSC derived seed only varies by process start time, which a local
attacker can determine.

  1/5 adds a Windows getentropy() shim over BCryptGenRandom(), so the
      EAL can call getentropy() unconditionally.
  2/5 drops the broken probe and always uses getentropy(). The TSC
      fallback remains but now logs at ERR with the errno, so a
      blocked syscall can be told apart from other failures.
  3/5 expands the seed with SplitMix64. The two halves of the seed
      were folded together and run through a 32 bit LCG, so only 32
      bits of the seed had any effect and the five state words had
      correlated low bits. Per-lcore seeds were the seed plus the
      lcore id, leaving neighbouring lcores with nearly identical
      state; that sum now goes through SplitMix64 as well. A given
      seed therefore produces a different sequence than in previous
      releases.
  4/5 removes the RDSEED fallback. It is unreachable once getentropy()
      is always used, and RDSEED has known reliability problems and
      errata. The kernel already mixes RDSEED into the pool that
      getentropy() draws from.
  5/5 adds a DPDK_TEST_SEED environment variable to the test
      application, so runs that build input data with rte_rand() can
      be made repeatable. Unset behaves as before.

Bugzilla ID: 2035

v2: - rebased
    - reduced patch series to only seedinr related changes

Two checks warn deliberately:

  1/5 carries Cc: stable@dpdk.org without a Fixes: tag. 2/5 is the
  stable candidate and does not build on Windows without the shim, so
  1/5 has to go back with it. The commit message says so.

  3/5 has a Fixes: tag and no Cc: stable. It changes the sequence a
  given seed produces, so a backport would change output for anyone
  relying on rte_srand() reproducibility on a stable branch.

Stephen Hemminger (5):
  eal/windows: add getentropy shim
  random: always use getentropy
  random: use all 64 bits of the seed
  random: remove RDSEED fallback for initial seed
  test: allow setting random seed for tests

 app/test/test.c                        | 48 +++++++++++++
 doc/guides/contributing/unit_test.rst  | 15 ++++
 doc/guides/rel_notes/release_26_11.rst | 10 +++
 lib/eal/common/rte_random.c            | 98 +++++++++++---------------
 lib/eal/include/rte_random.h           |  7 +-
 lib/eal/meson.build                    |  3 -
 lib/eal/windows/include/rte_os_shim.h  | 30 ++++++++
 lib/eal/windows/meson.build            |  6 +-
 8 files changed, 155 insertions(+), 62 deletions(-)

-- 
2.53.0

