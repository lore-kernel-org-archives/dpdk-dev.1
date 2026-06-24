Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E10CDB47F
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 17:58:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10E9D402C6;
	Wed, 24 Jun 2026 19:58:22 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id 74CAD402BC
 for <dev@dpdk.org>; Wed, 24 Jun 2026 19:58:20 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-30c6874d295so91357eec.1
 for <dev@dpdk.org>; Wed, 24 Jun 2026 10:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782323899;
 x=1782928699; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d4In3mUMOliJuaoeNuXxG0KbrykbaVrOyM83QYJvfpg=;
 b=ACVwR0Hvs5d0oYFSL8EyRS4SHvBNicoBmvwvrIogmHcoPSFEotKeuTK+547VDzUgQ1
 dVBIzYl+FgfjAY4+tNa4gMP9YoVWL2+k2kq451qgCV3zEzzyl9cgy8IADDGDX1cbRDjK
 R76lhGhv5umrG5q1a3fR9MwE33QvvChaoljahS1E816qtVzETcv4ilnJsCKolOo1RlXj
 w1axra6jRAIZBGCEdeMc+zMRvdeLHvKHB1Pwg24q4SF7FADcsHkprrOA8DySYswWoZf7
 O3j4kvP6jYg/kYBZKsx8uckPmcQPMcf1AmI4UdHc56NMIDJwrhnUEbDvZQtsswuaJeAM
 3dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782323899; x=1782928699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d4In3mUMOliJuaoeNuXxG0KbrykbaVrOyM83QYJvfpg=;
 b=aGPz5LrKrNjPum7ShP69sjFKND2bTKLjxai4SLVCj0GPfN3AkSOSJr2Z4H4HFMfCJn
 rRtsuVIBIqXZuG6Vj8jkuTcrXl1Ul/sDA/UccPPhN1MPUfJsHHD/1sZ9MPe1dui1rTQl
 5IdOknTw1IPb4VcQklzVdicy7e0t+7kGncLyefLDD+DmP+xNGYAL2h/uYczcuVVdzZMS
 dyROdxYIAnEk4/2dGJNUnoOz0tHJN7sHfCEF98eBLhWZpzx9cvdlZ1rg9QtYyt3sugRw
 ZheKac6a0mfbeqbTYcZs41ilowpVpmXjJEEpoArYZEZJ+zXdMcXWAKx0JGclvFoQv+n5
 k+NA==
X-Gm-Message-State: AOJu0YxVI7Aq7JBnSNSA74vOp7WWETy76S5rPkh59vClhnpb1DBdvERj
 h4r7kMA/y/nf8JQKbPdw49YvbgIt/Xjl5nG/iygbo4veXLL1eY2s9DIPPHyHPAH5V+BQ4EpFqgR
 Y5vi5
X-Gm-Gg: AfdE7ckbWyL6OK2hMzshzPb2t/UWrnYx4ME6SIjzoKuLo2jj2hilFy5RMn9kTgGQz/o
 tHsPKtyT4BlG9ENNinnEzafdiPt9OeEJpU0DPPGaYCr4bbOcO1wshb+mEciPXu8/Uflqk/EWaCq
 F7jZvTct0J3meKz7xBabuQyZKpRooGAF79OaYj67mt6QvFPmPGWik/8sdD+uqLvb2Qj6c+yHWlm
 SGdp15uPsBJEnOjXDI93KUcawEbtSrOysHPDaNh1qKSz6Pts3vN4hBkkZjNs3SujDE7HErmIQwQ
 fQU2/V4iapROf+S2jJZGBa0ZLcsZEAc60vVcPtfrBgF8C1eE7OT0//IAilGMoO/Ho7z/QHbVLcm
 m4HRWnsd4Q9ck6sJlg2gHl2uH5Ysk7fMHBI6k5UBhj4Ud3KU+zaoX7aU7XB9C+g7y3SsvryOfxg
 HtlMtGi+ekeGikU5TWAR7mJqPu0vz0eS7JOPU9KWX38G2iGWkvwIc=
X-Received: by 2002:a05:693c:83ce:20b0:30c:378a:5d96 with SMTP id
 5a478bee46e88-30c55606957mr5278410eec.12.1782323899117; 
 Wed, 24 Jun 2026 10:58:19 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7cab08c2sm696325eec.29.2026.06.24.10.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 10:58:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 0/9] bpf: JIT related bug fixes
Date: Wed, 24 Jun 2026 10:54:59 -0700
Message-ID: <20260624175815.673064-1-stephen@networkplumber.org>
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

Changes since v4:
 - address Marat's review of the large-shift test: it now checks the
   RFC 9669 masked result instead of a sentinel, which surfaced two more
   bugs fixed in this version
 - mask shift counts to the operand width: the interpreter shifted by
   the raw count (UB, trips UBSan; patch 3) and the arm64 JIT overflowed
   the UBFM/SBFM immediate (patch 4)
 - reorder so the arm64 BPF_ABS/BPF_IND support precedes the "check JIT
   was generated" patch, keeping the suite bisectable on arm64

[1] https://inbox.dpdk.org/dev/20260319114500.9757-2-cfontain@redhat.com/

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
 lib/bpf/bpf_jit_arm64.c | 165 ++++++++++++++++++++-
 lib/bpf/bpf_jit_x86.c   |   6 +-
 lib/bpf/meson.build     |   2 +
 5 files changed, 436 insertions(+), 88 deletions(-)

-- 
2.53.0

