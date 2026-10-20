Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0466F606A319
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 17:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=cjuMTYIA
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 514D640430;
	Tue, 20 Oct 2026 19:57:37 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 29DD940151
 for <dev@dpdk.org>; Tue, 20 Oct 2026 19:57:35 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2e8fe8e343fso19126625ad.2
 for <dev@dpdk.org>; Tue, 20 Oct 2026 10:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792519054;
 x=1793123854; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZZGsvO1WLC30dqTUovAxwfvc11wSh0fm3J1KehBvfj8=;
 b=cjuMTYIArau6msllbca8XAf54RhtT9LIvDHCo8UqArYbpxoJX/DEPel2ggTsjwgbFR
 SWsZlCcYUY+3yVJCUj5qzlh2JqNLdvEcK5qUa2qcMv8S/gfhYJE5mKVPFNPvKqG4aYTK
 YAuvgFYIyQdW5XhFtOe0jEAhZawCiYLyw9ikuvILdHpYe2eeag2mTamSjFnXUalnSHd8
 NEH3T8fxpPuco0POgtrNjwwQTGV/AtGStOjQsI4LlH6l1rJPRVN6zxGlnV6ICa3NBB2u
 p//uePEjhs+Qqd7i+RDJYE1YezXvJcsHnQlNRw40ZWurIS24aqvCFHUXOjIbzM+ajgX0
 VOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792519054; x=1793123854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZZGsvO1WLC30dqTUovAxwfvc11wSh0fm3J1KehBvfj8=;
 b=vIV9rCtDGDrJup3QoFTD20FhKlxa/wKJ9eO1m9oPEa1h0B96+HA4RxBX2Z+r9DOJD+
 XzfpCwVDhSuBoMHICF1nidsIcCdR9g5cNsP80tj1bKBQsxBZL0pIDZz6rBUFloHCXpTk
 a9EImdYgL6fBSYMIc7ph1AfMQQEmaom4G1X6+dRAdFmk+TahEdpBgg8dDdChxR7LIi16
 MVltIgckvqugWlu+thLlctQdK5L71m1wwWRUqO4zItsfSCAkfvUXmwI+/zVd5qXL6/Id
 b0eh7vGfMIG6Shfwn6ViDKKiRG2ulGQxexmwfcDD3rCFgcfqhCwJk+BdNtUCk0Xrkx0U
 zJtg==
X-Gm-Message-State: AFq9FYLSUgTk7cBSyV/82AwUZzukSVHD4h+y1tuKSNgS9NEQTdVg/WyA
 yLqE+L6K0ghO6Lv2WhleRoYfGqyEILg/dneFeISyB4iS/SFcXs8uVql2fc6CZ9LoI6TEIw2j6JR
 n5MY5F1U=
X-Gm-Gg: AYBFou2Yp3q4nXmdMXgTZiV7lDahXHiwo/zdjQNlIEVmRCdaTgQ4CgJ4l342E/FAqoB
 aSTn8cplvuI+LnS8TevbCb6jdQ3rik1hMSudeUWqqQvXOJ0ZHVJnhrJ9wyrr9UhFF+tpjm2OHGB
 nOvSr1nImK102ff8fVIO/sKiGSEw17/ieCYknNqHWVphYo/dp/UZIXSVk5YB99gciJaKWFNJ3tv
 l615Iz+POKQ1JuWwu5f+aBDacSLp0EcJBNlQ+mqOssvSWl/hcZFUk2FPRJB+eqLhIpNUwhAFBQH
 /OL2q7+zNO5xx9/oGFayPVxVDE3IpT1YPjnr1UqBIJCVMViMJsXody0R3TE7iHcanLsy0PeUo4U
 8juhyVb02a3qz1zOQTamOZTfL+32gZO1e/sKXRyEsZkjzlZ5FkQLD5J5x/+YZeNquyJJmTAtmZD
 L2DMeE9hpH4bPmvBov1tuRAESIsmKKCbCHaOPMj2VvQnWuj+UXfZmQbK1x6bGnJ4O7oKTkmalHo
 0NeKoTTwYYy6ycw+sy6iPLnjDjoDTRMh4+cj9EqxIEhQF1iVsdOpZeX1INOlUlAKHgDZs90mZYy
 9F5Nuy55rUP1tCBWSyM=
X-Received: by 2002:a17:902:eccc:b0:2e9:87a1:98b8 with SMTP id
 d9443c01a7336-2e9a6d37420mr101827025ad.73.1792519054218; 
 Tue, 20 Oct 2026 10:57:34 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea3b43236esm1997875ad.29.2026.10.20.10.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 10:57:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/3] pcapng timestamp conversion and user-supplied timestamps
Date: Tue, 20 Oct 2026 10:55:41 -0700
Message-ID: <20261020175732.1552406-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020152907.2607513-1-dawid.wesierski@intel.com>
References: <20261020152907.2607513-1-dawid.wesierski@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This extends the proposed user-supplied timestamps.

The pcapng library converts the TSC into nanoseconds since 1/1/1970,
because that is what the pcapng file format records. Make that
function available for more general use.

The third patch is Dawid's v8, rebased on the first two. 
Some rework was needed to fit in because because adding
new parameter to existing function creates lot of API and deprecation
headaches so rte_pcapng_copy_ts() is added as a new experimental function instead.

Dawid Wesierski (1):
  pcapng: add user-supplied timestamp support

Stephen Hemminger (2):
  eal: add function to convert TSC to epoch time
  pcapng: use EAL TSC to epoch conversion

 app/test/test_pcapng.c                 | 108 +++++++++++++++++++++++++++--
 doc/api/doxy-api-index.md              |   1 +
 doc/guides/prog_guide/pcapng_lib.rst   |   4 ++
 doc/guides/rel_notes/release_26_11.rst |  13 ++++
 lib/eal/common/eal_common_timer.c      |  59 ++++++++++++++++
 lib/eal/include/rte_time.h             |  34 +++++++++
 lib/pcapng/rte_pcapng.c                | 122 ++++++++++++++++++---------------
 lib/pcapng/rte_pcapng.h                |  54 ++++++++++++++-
 8 files changed, 333 insertions(+), 62 deletions(-)

Dawid Wesierski (1):
  pcapng: add user-supplied timestamp support

Stephen Hemminger (2):
  eal: add function to convert TSC to epoch time
  pcapng: use EAL TSC to epoch conversion

 app/test/test_pcapng.c                 | 108 +++++++++++++++++++++-
 doc/api/doxy-api-index.md              |   1 +
 doc/guides/prog_guide/pcapng_lib.rst   |   4 +
 doc/guides/rel_notes/release_26_11.rst |  13 +++
 lib/eal/common/eal_common_timer.c      |  59 ++++++++++++
 lib/eal/include/rte_time.h             |  34 +++++++
 lib/pcapng/rte_pcapng.c                | 122 +++++++++++++------------
 lib/pcapng/rte_pcapng.h                |  54 ++++++++++-
 8 files changed, 333 insertions(+), 62 deletions(-)

-- 
2.53.0

