Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAFFCA5FC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:50:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A558432BC;
	Thu,  1 Oct 2026 00:44:56 +0200 (CEST)
Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com
 [74.125.227.166])
 by mails.dpdk.org (Postfix) with ESMTP id B269A4327F
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:51 +0200 (CEST)
Received: by mail-pj2-f38.google.com with SMTP id
 98e67ed59e1d1-3a4bb1ed012so1332121a91.3
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808291;
 x=1791413091; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kbQo0z/RJi8lW+mTkufHclNOGOiBw3Ap2EcMq1yeIf8=;
 b=TdUo5swE0FSu0pHItrJlLE8EPq5nYhi+PcO2IqXd/NB36TQ6W8PxJu+hiP9heHcjcR
 D1V2mRFNYplbXM88Z2RML6awDghcAKVeM4YIe4krNYw+9RBK4kcMKdSFWRqAM0Muj4tI
 R6LgU0lWA0zovLFjDEBGtVPQHZhZRtvSOFoNKsrVZaLHAMlGG1wvt4Bx+DtgcLpOVPCd
 iRIGVMcDnR9yG/a+rHJNilrMc4L0AvYQimJE6J0wwuo2g6z1wikbwbkVW4staUuNUK9s
 gwCxWfRsGwvb1KGpL2OKLejEQNgOngnJBlY3Rx79foXMwiy6te2VN1aNkxZQWMSMZHpg
 TsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808291; x=1791413091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kbQo0z/RJi8lW+mTkufHclNOGOiBw3Ap2EcMq1yeIf8=;
 b=lTYqGanMPtPTMuNCZXPQA0trQzlj59z+AAEmr4lFuC/hvQiOiUKI54QZykYbxol+Pb
 X5XNYQEDN33AQovjis0qjK4Ml3lWjoIl7E1EWsKC5iGMEelAPgql1VmJAhp170hXl7wY
 PAsSYZdZdK2ijBHYgCH3ylbvEMNB6tap09myqZ84wpOd+iDWUfNg6jMxwUGCKLOEM1wE
 tQZwjyKJcDZq20SmHv9pDCsvaZTJLCXIw+J+CSxM5tjhlA7bS64F3zy1Sqk07L7zQNc/
 ZCO6z1GZw6Y1yn0PRLeeoZQE8ga62/MYEdKAsSePNsqJlu3+3GiQGxDfVHb0pZC9RqHD
 yq1g==
X-Gm-Message-State: AFq9FYIt4kivfJAJlrb924rFfoTKje6msStQp7rM9bjnJ0+afcCskaug
 vgOc7Wc8wpMpCmLfNz+CmJwKZ6u6aWifk6eGGm+aZ31azPi17Cq99/xwVY+ISVwjZ6+bmHhtUWZ
 WASyYbPE=
X-Gm-Gg: AYBFou2JG91e3xcQhMTlT5c5ZqmCRY/EjE3tUGd9+tEkxfBW3nk8GTKaES6vffxZDwI
 Ao6Xe/smA4OHl3+MVESAAeHJlIjy7K9V9RT57aGTtDYJGiolmq5bR15ASNCWMt3eaGdlKgy3ZpQ
 hHAZ3BNouatqiBuV1T9Z2R0cXd3yfWQElhF/aPhIyP6C/yJK2gshU/a14oWuSRS9zFmES4ZXWtl
 8vzFWowQwoAl8yiulv97LIPNkXdjgo6fu58U2sR3YT4u6GJXMo2NRHCALCXuRwl/f3HK6jRyoKc
 48r3umR/fRmjVnYC87HCLyRtwjH50XiorW1NdxIr05Ejyo8Nm4l803nboYEU3KmiK68xaJhQ+YJ
 stqf+mMD0GBCbfY4NEHfJHPIiX3E0EExUiI3w3D5zD7uEgHoNOiGTXcpEJjDljYr2mA6pEwlnmY
 1QwopMmeDKUYE1OjTN9MjXZWegeJqSY/33DirqxsyzftTP+7LjmLn+ArvlPB11gYT+c7yzbYmyr
 K3cIC1SD3fDNBdsy2wog7mLPrzwJDkh0mTcyg==
X-Received: by 2002:a17:90b:5404:b0:3a0:b959:4479 with SMTP id
 98e67ed59e1d1-3a4d18a28a5mr2350554a91.38.1790808290891; 
 Wed, 30 Sep 2026 15:44:50 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 65/65] doc: note kvargs devargs conversion in release notes
Date: Wed, 30 Sep 2026 15:41:23 -0700
Message-ID: <20260930224340.58580-66-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

Record that the drivers were converted to the new kvargs helpers, and
what a user should expect to change: a device argument which is
malformed or out of range is now reported and rejected, where before it
was commonly truncated, wrapped around, or taken as zero.

This is kept as a separate patch at the end of the series rather than
folded into the last driver, so that the note does not depend on any one
driver patch surviving review.

The individual drivers are not listed. At 52 entries the list was too
long to be useful, and it meant a third of the driver patches touched
the release notes only to append a bullet.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index e2cab9a484..3404c476c3 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -171,6 +171,25 @@ New Features
   needs a handler of its own, and a value outside the range is reported
   as one which does not fit a whole type already is.
 
+  52 drivers were converted to use these helpers. A device argument which
+  is malformed or out of range is now reported and rejected, where before
+  it was commonly truncated, wrapped around, or taken as zero.
+
+  The device arguments which are booleans were converted along with them.
+  Those now take any of the spellings above rather than only ``0`` and
+  ``1``, and ``key`` on its own means true. A value which is not a
+  boolean is rejected, where several drivers previously read it as false.
+  That includes an empty ``key=``, which ``net/pcap`` used to take as
+  true for ``infinite_rx``.
+
+  Two of these change what an existing argument means. ``event/dlb2``
+  only looked for a leading ``y`` in ``vector_opts_enable``,
+  ``default_ldb_port_allocation`` and ``enable_cq_weight``, so ``=1``
+  used to mean false and now means true. ``net/virtio`` compared
+  ``vectorized`` against ``"1"``, so ``vectorized=y`` used to mean false
+  and now means true.
+
+
 Removed Items
 -------------
 
-- 
2.53.0

