Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13110CDE001
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 17:32:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BE5740299;
	Thu, 25 Jun 2026 19:32:36 +0200 (CEST)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id 4C2F84025F
 for <dev@dpdk.org>; Thu, 25 Jun 2026 19:32:35 +0200 (CEST)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-139aff562e1so164242c88.1
 for <dev@dpdk.org>; Thu, 25 Jun 2026 10:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782408754;
 x=1783013554; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cs0HU9lcVGiuC8LyoEJBfIoJQaQJYOygtK7C+2sMaI0=;
 b=yumXM6torimOWbLnb/9vbqp7M147Wv1rXVVLvowCChzLEUP+gFZeoB+ayrrpYNxRC6
 92OfoIboGanXXkN9Jc2b2jcbhi90Tirewp4r6+k5iUp/opEZRBqD2eAMwkzQeopMfyYC
 /msh85It87N8pSBawWEFISkp36Iohwl1YuPTMBN9nJLPMHcBEoH5eIWh3SmOUVgl3hse
 U1+9v2uoHH7cdvqXXPyeAcMjpXZKR73Ag3tUKVab+c87HmimdDMRz/TbzdDM68qLDDpU
 KYw5HeV2nw84meoBP7S3fwmQnDByCzfDGCB9VK+6EGa3r99tpyM/VTetHHE7/N+0/6A/
 vYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782408754; x=1783013554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cs0HU9lcVGiuC8LyoEJBfIoJQaQJYOygtK7C+2sMaI0=;
 b=hiXZK4fmeOj5N6udQ7O9TtUbE0nKbiXb1cN9gacs6kNGVeL+CfGyIOQEZw/ZjGT7ok
 6zWzlauOzx3zsmQuIdSdBpYaQM1qvoHGDF84HcQrFJVtyOp8mtgNFoRay6/JGYCsU3n+
 qS2lbjKB3rBuXsIvmuOypteTaGl9WUNIzh0o8icjeGeoRG8HnGHNjhj4VhxvAJK83Kbt
 J5F/9YX5aeou2uPjVWXNpRINDlM+z3bJnpm/SNr2QRGze0Olhm969pw7tGjY0FLnunrL
 MNF9BSMHXB5hWXknCSqBYtvARhWy0HX02dKjKRaetAI3HvT8X1dKQ1IPo6ZBGyNHVnSN
 qLnw==
X-Gm-Message-State: AOJu0YwXcuQNIqXHmtazL9Mtc2Jq8JACwCI/0oRMjVvKgeJ2xTbvEUCT
 gToGhzbautEDD4xoxYXWezCxojwU27jMVONWr2qGgIQSqjw+Tjqh5Bkh9MPbM43Nns290v9gUNH
 SJG/Y
X-Gm-Gg: AfdE7clhgJAC10r6gKbCQwT83TjlZb0aV0EBwW9aVvX/YiOog2tYI2WBdfTdfmTBLXu
 VqU0TAWW9C5RiGYuYAD+Kb8l7WuB73fMITnt8An+cSHycdL6Et5WBWe3CQItGtCekG6fGlEJkbV
 3+zJzUO47CTaWU6ZsHEpWzUDNiARVyKba1HXwKfslhToYaiXG61UWIyRfR21TpjuA71iB1mFYDO
 SNsHPu/74paUq+RHFHW5KvW5GDZS3GlE2h8lRWphoYYVr+JbkvN9QeAdQavmyKfgLP/OAE4MNR0
 9CSlbtwzASBDV3jfT/yNQA7sw5RS9+KOEE8ozt1fCHaT7Sq1tuKEdSdZE/kCV3DP3+yv5kNuOfe
 iISKIf9DJhG3HimBRlQjEGrBl+nq2oDOovImLpk1NRjEl+L3WuIyL6b8QmO/1H/EzjEFs771Quc
 GcVL5wNpgImniiE+8BSD9vBTgDyI39a2PojATQLQbVfcfawZyIM5A=
X-Received: by 2002:a05:7022:117:b0:138:407c:1d17 with SMTP id
 a92af1059eb24-139dbac81f5mr3206641c88.33.1782408753525; 
 Thu, 25 Jun 2026 10:32:33 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6acf9sm10218165c88.6.2026.06.25.10.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 10:32:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 0/9] bpf: JIT related bug fixes
Date: Thu, 25 Jun 2026 10:30:10 -0700
Message-ID: <20260625173231.216074-1-stephen@networkplumber.org>
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
  1. x86 JIT had a pre-existing bug which would crash.
  2. The arm64 JIT was missing the packet-access instructions, found
     previously [1].
  3. Shift counts were not masked to the operand width as RFC 9669
     requires: undefined behavior in the interpreter and an encoding
     failure in the arm64 JIT.
  4. Tests related to JIT were not being run or were missing coverage.

Fixed all of these. Patches are ordered with the most urgent fix (the
x86 crash) first, each fix followed by the test that exercises it. The
arm64 packet-load support is kept ahead of the "check JIT was generated"
patch so the series bisects cleanly on arm64.

The arm64 epilogue branch fix (patch 6) was originally posted by
Christophe Fontaine [1]; that series stalled, so it is carried here with
his authorship.

[1] https://inbox.dpdk.org/dev/20260319114500.9757-2-cfontain@redhat.com/

v6:
 - address Marat's review ARM64 JIT of LD IND instructions
   need to handle offsets outside of 32 bit range.


Christophe Fontaine (1):
  bpf/arm64: fix offset type to allow a negative jump

Stephen Hemminger (8):
  bpf/x86: fix JIT encoding of fixed-width immediates
  test/bpf: add JSET test with small immediate
  bpf: mask shift count in interpreter per RFC 9669
  bpf/arm64: mask shift count per RFC 9669
  test/bpf: add test for large shift
  bpf/arm64: add BPF_ABS/BPF_IND packet load support
  test/bpf: check that JIT was generated
  test/bpf: check that bpf_convert can be JIT'd

 app/test/test_bpf.c     | 320 +++++++++++++++++++++++++++++++---------
 lib/bpf/bpf_exec.c      |  31 ++--
 lib/bpf/bpf_jit_arm64.c | 185 ++++++++++++++++++++++-
 lib/bpf/bpf_jit_x86.c   |   6 +-
 lib/bpf/meson.build     |   2 +
 5 files changed, 456 insertions(+), 88 deletions(-)

-- 
2.53.0

