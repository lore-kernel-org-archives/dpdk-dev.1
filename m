Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558D6FEE4F4
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Feb 2026 17:56:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4374B402C5;
	Sat, 28 Feb 2026 18:56:06 +0100 (CET)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 012374013F
 for <dev@dpdk.org>; Sat, 28 Feb 2026 18:56:04 +0100 (CET)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2bd9a485bd6so6508737eec.1
 for <dev@dpdk.org>; Sat, 28 Feb 2026 09:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772301364;
 x=1772906164; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ayF0COSuhjbGQe00Lej7pcMyoYC5ulFVeef2rsmqBSs=;
 b=1UfAbOh2mSQ0R1XoPaadfLsPAJvY290wzF0XuuLJ3c8OZvklrPDqJpxl1Loxg69POM
 LHjyQrbRLJD07NYssFSz4bfNxMD9ak+9DLMYw0oquRI4Hw07H1arGxHVUjNF4NCgGEBz
 6mmgxasQezSR8qaj3W3Vhqrd7cT1Dd5XGZG9VfzfwbXrMu46vFoosaq3u7KiDiUAHcg+
 NoDK3jQbCWvuGHs3RnqOGDl/FsJugGiw5F2kHhj9u914ZPXtXXr3MmPMIngSY85NJsgG
 /V7QDwqZhTcMOf9oX3Qk7meJtaVjiUanHccXu/U9qGkoYmVPk5y91jD1hme5N1pYJXfr
 hx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772301364; x=1772906164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ayF0COSuhjbGQe00Lej7pcMyoYC5ulFVeef2rsmqBSs=;
 b=bprpgcnXuDxNEYepQDkH47fVThA0YTyWOxqG+RPv4XntsCxBj423RSxUKg6SjIsRUp
 9tHWim2M5Q1FivXcZI2N+wMMCw7iQOHOgrBmmpzbz/o5Fe3sl6aSVEiUMFH1e1u480Ku
 m1fiE/ttEmIVFL94sO8lV1FzMcvbIvgAcTcHvOJUYvF6M7eJ2UTLFs1O3kdIq5RGfYGa
 9uhfpl7lT5Jw+368J/cBHAB41LyCiyq51GfTl0/qXWL9x23NcsmKh5deLri7J90LMoEB
 LqikVuCziHMiyR9iM3ze3npLW47PwJ0N15CmktLbH0TyG8Al5Hd0HvzKYgqrK5P1Bdss
 KJrQ==
X-Gm-Message-State: AOJu0YzLrogklNyjXtp86qs0v0Q0MGTSzH1Dgt8LYzWNj4edFDC4GiWh
 YGXYqEtHCSYwIR1O2bUp6HjEyxmpzzAptHePOIKhHytEHaOPtJ/zy9AukROuMOSbxEpX4oogHfk
 xF0Q7
X-Gm-Gg: ATEYQzwNJUjW3yPfSyyhQOCwl/yPpito0iQ0cwhQPSgJnc8hlNgQLnQp/kjU1Z6iGgb
 y99tbp6l+6rIepJhVbsVrPc1vvyvzOc3mG1U0nvW5E2OmoZEcOa6f0D7x8nYkWfFNX0hrr+JGQf
 bcHC7L2Uh+hNVGdRokW6BV6/TYpLOD3pO9asIcZ30JAX6fwxppSVCyN9COSU81iOo/otBYo1wNh
 uScg2cUTH1zGgtBSkTbOe+c11AxUH7Tqz6rIANNsWsr39RBsIO6JFZUi3y9wugmXifo/AWv8DmO
 Nmd6EAk6lNW+hqSfo0tw7SGhRbeJi+HFjrWGaxI/xytnkzFC7vbM15EzY4JgpFYprolSpdn/Qlu
 l2kF/nsil0Ka8B7p3qAyKajTB657aZfRuGCBQMOrifTuZHRLqFpv/bYr12vFOlqFMPBRiaRsC6X
 L/gATXmJwmSwwipnsf3Pdf++1muQHEm+ZwhQ8qG3DCC9BI6bBX4jUiGcKeyYcBxA==
X-Received: by 2002:a05:7300:72d0:b0:2b7:32a6:82d1 with SMTP id
 5a478bee46e88-2bde1b574e2mr3043536eec.13.1772301363792; 
 Sat, 28 Feb 2026 09:56:03 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdfb3f898asm824584eec.29.2026.02.28.09.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 09:56:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/5] pcapng: fixes for Windows and timestamps
Date: Sat, 28 Feb 2026 09:34:59 -0800
Message-ID: <20260228175601.585102-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220184255.306368-1-stephen@networkplumber.org>
References: <20260220184255.306368-1-stephen@networkplumber.org>
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

Fix pcapng test and library issues:

The test did not build on Windows because it used POSIX-only
APIs (clock_gettime, mkstemps, unlink). Add Windows wrappers
and use portable alternatives where possible.

The test timing was tied to TSC frequency which could make
it run excessively long on slow emulated platforms. Use a
fixed time bound instead.

The test was mixing stdout and stderr making CI log analysis
confusing. Consolidate on stdout and switch to UTC timestamps.

The library timestamp conversion produced bogus values if
rte_pcapng_copy() was called before rte_pcapng_fdopen(),
since the unsigned TSC delta wraps. Handle the case where
the packet TSC precedes the clock baseline.

Add a regression test for the pre-open timestamp fix.

v3 - improve test log output

Stephen Hemminger (5):
  test: fix pcapng test to work on Windows
  test: use fixed time length for write packet test
  test: better logging for pcapng test
  pcapng: handle packets copied before file open
  test: add pcapng test for copy before open

 app/test/test_pcapng.c  | 224 ++++++++++++++++++++++++++++++++++------
 lib/pcapng/rte_pcapng.c |  10 +-
 2 files changed, 197 insertions(+), 37 deletions(-)

-- 
2.51.0

