Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D067CCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 19:30:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D67640285;
	Mon,  3 Nov 2025 20:30:45 +0100 (CET)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id D012C40270
 for <dev@dpdk.org>; Mon,  3 Nov 2025 20:30:43 +0100 (CET)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-33be037cf73so4889371a91.2
 for <dev@dpdk.org>; Mon, 03 Nov 2025 11:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762198243;
 x=1762803043; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iA7XEaUDZ+h5esjaUlUZG267oMXkk7A0GNCTEbFpTvs=;
 b=YiTe8MWvjuMS7H7mejexKMKBSB7RKb/MqLEQnsoer1mStHjBjmoLVHWbnVJfa9NFeh
 3m4rW72sG/rBFIWsh8FJYXcYw23a97DLgbxNBSijQTRz2CvZtS1L7bNUO/dSkVH6mdkk
 Lr7EPbiqIftREzuog7VELBJJsrH3P3no0yQ61IdjaTdyVou+sXd62rvPyGWY65NIpLDB
 k6GONSEkRrrpUroYYNQomsfUu85beHIEvI+QxE+FQ3DNi7r2StSaMEcUit1F7vp4wY/0
 od4Mfbko+tGwlJYWYvEDookTM4WowdywzzazkcS6D/pn2q7udl1s1roQMGbaVfbavhpF
 CuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762198243; x=1762803043;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iA7XEaUDZ+h5esjaUlUZG267oMXkk7A0GNCTEbFpTvs=;
 b=MXqvJuTE2oCP79I7Li7yTUHsDoiAYIU4SWO8qRCoYcbrV6QzVlGiQzs/2W683/WGCG
 TVi0SgKGGdwKEpDXrKqEzmio7aVUAiHuBJoqEzj/X0aTqIFnY4aL4zwt0ygT3j8AF7Bg
 rjv+nHs4ppArN8XjAZSWfm5+tRcYI19fRyy9rPTjOgwa5UbDHpblriO6EaDHHMOlebac
 J4wP1ueRYDHiFRg2wT3brutetyUr6rv9QkgPZ0Fi7ocmnLs/2gkr/5fumsVQfuLpLWZj
 WF0TVhigBB8jxVzYpSUGylkr8hoWD1hKjC1/cGd5rC0Ir7Fs61UY5Bol8JMMwP2bZGhN
 OM4g==
X-Gm-Message-State: AOJu0YyMmHPR0cautPXfudBTfXJsPhogkvk7acv1yBHdoX5/LfgpaxXZ
 iiFcFVGLvv/IcmX6p/j471xz7LP61amXudlUJW8CKzl3I4D9qZm5bgzJEdpgft5XeICbPWETf4M
 5GJ4y
X-Gm-Gg: ASbGnctwF9h0et4iuuIKtL0Aye+i2qmImLZgYy4wrH4t802rVJaB4VDwBYgb6Vbckjm
 dfGPdTJEj59/3HRLShDfvUwcD9E5eFCaFop1TchZhz+HzZ++vL1yewCn1mYwisHqXOv1vpBy4QO
 K0EDDJU4qbHZexnoxn5jsbpl8zOmHb5UjCkRwjGuGnoFKmYTBz8Nviqrmnem6VkR/aq1SO8VpQz
 ZsSLiIyv5eaI0qB7H2PZkC+Brsi12NfaVlbSiQS8MwxVkxqCHatidPHrjyhli2ZUtjLV9YNjlyy
 lKck5i2ASCv4VG80RR8pMtXwiD6vsWrZdsu+ww1FmIjZA5pT7bOp37COkGHYrX2D50Pa8uFHNtK
 vlu15zsdyzVuub2HPNAbCxTLn7aTb/JDfczRrCDJF7cVLCaXGXkpNq/MWXxcHJOInH9+gHEvnmF
 9DXFYAyuhsXjkFlH3+mLqcDEx34G7g7BUqhBK9gk4xjYez
X-Google-Smtp-Source: AGHT+IH9nFxz4pS1OV5KAeT1xF1M/ZeBtSt3isL4iD6SthVTVN3E/aRNrGVBbicYCzfCX1TxSqUfJQ==
X-Received: by 2002:a17:90b:1a8b:b0:339:cece:a99 with SMTP id
 98e67ed59e1d1-34082fc2ca5mr17394971a91.13.1762198242770; 
 Mon, 03 Nov 2025 11:30:42 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-341599f13fdsm1901246a91.12.2025.11.03.11.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 11:30:42 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] doc: update FreeBSD python version
Date: Mon,  3 Nov 2025 11:30:38 -0800
Message-ID: <20251103193038.135022-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

The version python used in current FreeBSD stable release 14.3
is now 3.11. Update documentation accordingly.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/freebsd_gsg/build_dpdk.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/guides/freebsd_gsg/build_dpdk.rst b/doc/guides/freebsd_gsg/build_dpdk.rst
index f98292bf41..c8b2964a4b 100644
--- a/doc/guides/freebsd_gsg/build_dpdk.rst
+++ b/doc/guides/freebsd_gsg/build_dpdk.rst
@@ -16,16 +16,16 @@ The following FreeBSD packages are required to build DPDK:
 * meson
 * ninja
 * pkgconf
-* py38-pyelftools
+* py311-pyelftools
 
 .. note:
 
   The specific package for pyelftools is dependent on the version of python in use,
-  Python 3.8 being the version at type of writing, hence the ``py38`` prefix.
+  Python 3.11 being the version at type of writing, hence the ``py311`` prefix.
 
 These can be installed using (as root)::
 
-  pkg install meson pkgconf py38-pyelftools
+  pkg install meson pkgconf py311-pyelftools
 
 To compile the required kernel modules for memory management and working
 with physical NIC devices, the kernel sources for FreeBSD also
-- 
2.51.0

