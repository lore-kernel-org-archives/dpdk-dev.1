Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA5CCCFA18
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 22:57:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A226C40281;
	Tue, 11 Nov 2025 23:57:24 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 53DEB4026A
 for <dev@dpdk.org>; Tue, 11 Nov 2025 23:57:23 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-298039e00c2so2285595ad.3
 for <dev@dpdk.org>; Tue, 11 Nov 2025 14:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762901842;
 x=1763506642; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dJvEZhxm/dQcXCvUakT6XcTrD9RgWOJRION2gTHVSTA=;
 b=CVmh2sx8o1dkdE8h+CSwWqvlFMhv7PPKlDo5IM1BHALKj5tOBkPhJ4Pkr2Av5YXm5M
 9VUnhxa7itMlh2ZSUNB2Hs79DHNZWh9hL/s1oZiGwsCgM2NU1tl04s1W49kdene5feTt
 Ojr44lJWrooZcmMF+wj8uAStEXGwse/BdMvZG77NMNhVQzTPK/yHRLxs2q0+fBBvFNXW
 iFLVdYU7PP1u9Hxblky1IqgHVluYchkpeedEb4i5dqTdsLho6Q/4Aw6aUMjrai+wwBKP
 adlhp3G+S58XoXoP/9c7i8sh0v3MI5qH0W9q2pvqGUqKHcKqFW0cWL+Vp82jYdjp5WTA
 8owQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762901842; x=1763506642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dJvEZhxm/dQcXCvUakT6XcTrD9RgWOJRION2gTHVSTA=;
 b=IWyaV3u4apBxOHg9Uolo6McW3Aq9S/akfzIRVgUhCOrolOAPON56MWKcQuVVl3drzH
 s2Llsk8Cs6jNXL+C+cB9hP2ARv132w4/nqbicVHhulK/ZZYqgP/Yobr1xiRxK5Aa3etJ
 YNb7vP7lKgp4uhrII0UgFr7CMJ503209cY5dGQMcaDDIE2uCXziDOFliwDRlcIs3Mj+M
 OiL7z7K8MvRJ1qXTtbIM4zxHemsKw96M5/6Ewyuo6ghinw5idX6FWlKg69uzD9Ok8lIj
 RTkxlIKlGjEJZbua0qg4Tv+wOkBkb88+FO2k9nnPEFJ09aeH4VVqFqAfxzUr+ORFy/H8
 /+vw==
X-Gm-Message-State: AOJu0YzkM+y6kD8vNF4tJp33jJ9kWHd9rO099LMYVhQED7bhuWfQeXcT
 svMO73TD3H4XuV/BP/XpQ/oBzVaHU/9FPZXTIu5b1J0he7ZhLfIrCEE7W7l4TRJ61aG3e/5LjHy
 gMO0i
X-Gm-Gg: ASbGncuYXQaIy9mIQhlbEmTgjcYZ38LKtUY9OjPWBvfIf1M8laeQM45ni62OaFRMM86
 FG9dzYop6kVnZ0Qsv9QZeLR07HrdU9erw4fZgdNtBjlG6rDJsa49yqZlgHW1C9MhS71/Mq4ojZr
 Uw87LJMK1VyhFPI5NG3IA71O7vgNsLOCVjubyH/50SQBYl3l9EOc8HwQSv6G4zbxJXdpghslpDe
 lgHSePVDXlPSs71tObbkrY6rWAupODgLSRLQcK/La34J0AJlD0EkVzGHFX/bZTAjviUkJTqOCiR
 c/e+1+AuVJytGgrrUJ5jGROVjSJEvEwwOeC9S2PXhETxhOVGZ9RBBEO0jQUHindh+nmIZnNBVZD
 xtbleqpc1WLKYN4JKACBaqODgWWQwkkjby21miz1m3ot+LBv1tMs0mfThDwRPjR/BxXJmN79DJc
 B6ht2z9vzWljhwUtaaraTwc2+TFmoyUmUYUhWjYJ3mSf00wSoNOCl/84yY8ezO
X-Google-Smtp-Source: AGHT+IHK8nTHD6iMeZF0pZg2WMW+mTKQSEY4kxYdyryPg02JT+Xkl8iTSkFyPatD3iVbVfFLrpn8RQ==
X-Received: by 2002:a17:903:230b:b0:298:1f9c:e0a2 with SMTP id
 d9443c01a7336-2984ee23774mr10583925ad.54.1762901842322; 
 Tue, 11 Nov 2025 14:57:22 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-343c4f6f78bsm1920831a91.3.2025.11.11.14.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 14:57:22 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 0/2] BPF tests
Date: Tue, 11 Nov 2025 14:55:45 -0800
Message-ID: <20251111225719.540140-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109200854.45942-1-stephen@networkplumber.org>
References: <20251109200854.45942-1-stephen@networkplumber.org>
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

Add missing tests for BPF file loading functions.
This is subset of earlier patch.

v6 - rebase to main
   - make sure that -ENOTSUP is handled
   - remove duplicate includes
   - combine all of the elf tests into one test instance

Stephen Hemminger (2):
  bpf: add a test for BPF ELF load
  bpf: add test for Rx and Tx filtering

 app/test/bpf/filter.c    |  53 +++++
 app/test/bpf/load.c      |  51 +++++
 app/test/bpf/meson.build |  53 +++++
 app/test/meson.build     |   2 +
 app/test/test_bpf.c      | 476 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 635 insertions(+)
 create mode 100644 app/test/bpf/filter.c
 create mode 100644 app/test/bpf/load.c
 create mode 100644 app/test/bpf/meson.build

-- 
2.51.0

