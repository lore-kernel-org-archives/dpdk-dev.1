Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D6ECD98F2
	for <dpdk-dev@archiver.kernel.org>; Sun, 21 Jun 2026 16:25:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B3C64028A;
	Sun, 21 Jun 2026 18:25:30 +0200 (CEST)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by mails.dpdk.org (Postfix) with ESMTP id 21FB840270
 for <dev@dpdk.org>; Sun, 21 Jun 2026 18:25:29 +0200 (CEST)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-139aff562e1so941912c88.1
 for <dev@dpdk.org>; Sun, 21 Jun 2026 09:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782059128;
 x=1782663928; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ro0OfsJ2KUOQcosIl//As+7W5NMhbL/E32BjrXxLF+M=;
 b=m0Zw+elxaLjmpGya6dCZLMRaxc/o6zgvlvkrc7GW3Q2o0TffQJ8s5xixIkCmLZHoTv
 GQLTAPxFpCHzbWeJ6s38Zv0M3/g1oDYrmxCbOb5j5YW32B1c1hOvGWeyfmBqys/mTQnx
 QI/uBI1uEfwq3+xDUc8T2I5TfHUyk776VempgYESUroMK8pkpeHeje6zuqsdyiUixpIB
 v2JGoIVDwJjiSp85oAzT1TfLZNB4R9iVXMFu3wAGfsjQKmyq8yNommXoQcgYS/uVB8S9
 UIJtZD1oPeTXiNxXYM2f8rBbtDVpUsXophDqRViSQebaLxTzS1miPte9r3raqm0Uss9m
 PO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782059128; x=1782663928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ro0OfsJ2KUOQcosIl//As+7W5NMhbL/E32BjrXxLF+M=;
 b=FxOVKw9HQIEY4V26mJWjO4vgLiPEy/LT02lKGmW97RqIvC95rUlH3/dALCm+PgKtrQ
 GawczX1j0pHndvW9Q3G6ejQhuRaFBa0Y1Q2ak8b9k2Islo9TL6rOE3o+iizVLbwAcdF7
 Xeun1n4qHlx1JwhMYQiVgg/buKOGkEEp+QBx6j9+0CLkHQ4tloJf0jZVl0xbcwS+nkwU
 5cmpQO+O0GTQeyeXhZ6om0MxjD/LWLVjFGCc/Hf3NhtxQOLfUXsNHzyBv11/Ng5OFUwJ
 ff/C240Tt2YdKtMUvl6dqoydTppIY3cy10QL/woV4S8icWZJhZV0ua+oSqFxMwrhZlxt
 74fQ==
X-Gm-Message-State: AOJu0Yzk23Gb0/DW7x+GonnDkXSihKAPgfbhVwN2dZtOTzcC3PiQh1D2
 RjQS1AWnFBFZLDDmieU3PpvkgmsjFxlyx0GiJuTZ0O+ZqEIsBixBavy6SWitXpzxSKKK6uwzKgd
 ul5mJo8A=
X-Gm-Gg: AfdE7ckGtXDVTVQ2teCOg2SjA66fslfz876wsO51rS1gTHms81lAvhIl2bDsnP8wyf6
 ffbomV6TwGQVq1p7j0c34PoYD6sPvjJM16mAVciFgWEquNW9yAoLOIVgpI64vNwg7G/hOBPpOy1
 kF8wn6b6cnlqhPw7Nu9fM5bkPQrAJwXe3NxXyQ6bOJRDNxUCXXtwMrm4T+O4jVhpPSU29RaLLpD
 YFFz6ZE0ks7mLPLaxsm6XQaZgP3fLKViQ6arXgYYvIkeB0HDO9n9gLt8ru6W/I/d47W81iHCOd6
 mO+fXKVCHzuLKPZFlrIdZLv6yJDwhkrr190THorxdXCMiY+6Jg4cwWm1Y3rPmphDxtxJPf3sfaJ
 y7KQ36BpYBXNKehPgQZD/4UBUJq3J3vOrfpJlAjlB732cCflF0CV9k3H6O38YjFFpoIF109UDDQ
 3kg7C6/QPKtfyy23KURBaeHGV8qUNkp1VCUVw9kfzMsPZqOqItTgI=
X-Received: by 2002:a05:7022:490:b0:137:567:14c4 with SMTP id
 a92af1059eb24-139a21526c7mr6182843c88.29.1782059127579; 
 Sun, 21 Jun 2026 09:25:27 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm5141593c88.13.2026.06.21.09.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 09:25:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/6] bpf: JIT related bug fixes
Date: Sun, 21 Jun 2026 09:23:53 -0700
Message-ID: <20260621162524.82690-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608203322.1116296-1-stephen@networkplumber.org>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
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

While implementing JIT for packet capture ran into several issues:
  1. x86 JIT had pre-existing bug which would crash
  2. ARM64 BPF JIT was missing instructions for packet access.
     Which had been discovered previously [1]
  3. Tests related to JIT were not being run or missing coverage.

Fixed all of these. Patches are ordered so that most urgent fix
is first, follwed by the test that should have caught the problem.

The arm64 epilogue branch fix (patch 3) was originally posted by Christophe
Fontaine [1]; that series stalled, so it is carried here with his
authorship.

Changes since v1:
 - add x86 BPF_JSET encoding fix and a regression test (patches 1-2),
   found once the convert test ran generated code through the JIT
 - carry Christophe's arm64 epilogue fix with his sign-off (patch 3)
 - convert test now runs the converted filters through the JIT, not just
   loads them (patch 6)
 - kept Marat's ack (patch 4)
   Since tests change enough, decided to drop his ack for that part.

[1] https://inbox.dpdk.org/dev/20260319114500.9757-2-cfontain@redhat.com/

v3 -- found a couple similar places where x86 JIT was generating
      invalid op codes.

Christophe Fontaine (1):
  bpf/arm64: fix offset type to allow a negative jump

Stephen Hemminger (5):
  bpf/x86: fix JIT encoding of BPF_JSET with immediate
  test/bpf: add JSET test with small immediate
  test/bpf: check that JIT was generated
  bpf/arm64: add BPF_ABS/BPF_IND packet load support
  test/bpf: check that bpf_convert can be JIT'd

 app/test/test_bpf.c     | 184 ++++++++++++++++++++++++++++++++++++----
 lib/bpf/bpf_jit_arm64.c | 153 ++++++++++++++++++++++++++++++++-
 lib/bpf/bpf_jit_x86.c   |   6 +-
 3 files changed, 323 insertions(+), 20 deletions(-)

-- 
2.53.0

