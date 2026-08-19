Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FA7C5DF85
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 19:10:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C490402DD;
	Wed, 19 Aug 2026 21:10:47 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id 69E1A402CE
 for <dev@dpdk.org>; Wed, 19 Aug 2026 21:10:45 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-ca12086c06eso925583a12.0
 for <dev@dpdk.org>; Wed, 19 Aug 2026 12:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787166644;
 x=1787771444; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s+J1FI1YOwKkHMsPYGu+d6AcHKLUOdpl78nf63D/23U=;
 b=sxht2vrt2WNJp85a+92zrCwzJBi7jd6V8VlsWAAyEqhUYqR0NnBX8swnArfm+Fuaq1
 bi2kKLh0vShE1453Ecur9WW0f/BlrZ6x79sASQprxHbk7pt7m/8KYFx2QoKqvn8qOvBX
 rYXGBNTxvHDZFRopg+1oqwuXFExR2+djZA6MInLYEbDlgVj2wXZ2tWok8QnHupfEnn72
 83vrRPhsbff0XmWGDQP4uTObTSNYm3yAOcqhijhc5lX9fLVhZEbAqX9VH4TFUmPCZry3
 QKrfZRXOjAxjBDPQFNvep8HhKZl7f2SQB56XUjxaq5oPU8CC3g1+IyQYvREc8eBq2Nxp
 vmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787166644; x=1787771444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=s+J1FI1YOwKkHMsPYGu+d6AcHKLUOdpl78nf63D/23U=;
 b=HsQ7Ys37zJh1wlinZVKV8Jd9AAHrJ3K7n9Kug8CmY43Zx5L2F3zre3cMFcf2/qLi9v
 WCLw2velZKbe5a73V2+EQFFtw0daLUndD3cba3nJ6CKXeJZroy1adADF0mfqZhIcBt+S
 rUfRWd+w5iqJ7CxiQ+pXi7qXA++2VklNij7b/MEGPag1pBskowiKX6QU+213vXi/TqSJ
 JYlZJvdjm6AUvEj+gBmuoiAy66yDIQdNMY9N5qv3tEbpdqWqAi85cLVP0A2n8ad9yaCt
 GJeDZld819a0kb1M1dPqssIPlSep8m0hqPW8d77qTCVZ0Mu2clIQyiAwNdAlmzZQJmQs
 HnnA==
X-Gm-Message-State: AOJu0YxpAUrB42mvkkSrnLCxuOhlgD1QVMTImXa335xvZI9Why7Gix4O
 Q0OA+RtAwmj+JUsogGzw+lpAiVnAL86mu5HR9y2z2lCWv42xhQ36seXhrkS/uqCtMewrfs6YuhV
 4tGYh
X-Gm-Gg: AR+sD13kMhADk1sHAoBbOt9SehyKdV7FxVP9uCZlqgKSW1GpR1hZ6cfhJQboj6iRjVw
 neNUUbxjA3jGSb8ZsexMYnubc5UbCWYaqdUB43DKoiL5y9pTuVGM2FSnh/d6lyhnpSBODck5Yty
 osGGWjqlyGuf5p091vSv/rNAGpuN7VIBhQnPKx1mwQaqv8jBqt8cDHQXxpQg6vlvsG79HlopUpM
 pl7x+2ckI5+EcSnTts8FH6FCOQTz395GqkXqHstw3OXUC1FHwHZcON33VmvxggzAg7biX8Pgt4O
 D4bhNqMNmuEMVfLCZrf4InZJWKR6Ky9PPqxeUPhI9z5MrA7l7U7ZOa0uZtYAdS+ldrsdZpIVsX9
 bhxgfcJItDQmBGsCkm79Vu5UKkDH0lZJHcZMwmCSo83b7M7xE8B5WV2Bl0dDvjom75aRT784HB0
 F9FRylYmmgjOH50BZ/vM46PUJhnkV7bzmue5rJcU+wHebGMPDf40Q8rShZ+XqYhuiMlmnlutU5L
 O3O5uh3lAolf9C/0Un+YcKDRmY=
X-Received: by 2002:a05:6a20:7f92:b0:3c3:a3f4:5485 with SMTP id
 adf61e73a8af0-3cd00e53f45mr12784034637.6.1787166644204; 
 Wed, 19 Aug 2026 12:10:44 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef77fc0sm17305416eec.8.2026.08.19.12.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 12:10:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Long Li <longli@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 0/4] eal: uevent overrun mitigation
Date: Wed, 19 Aug 2026 12:08:49 -0700
Message-ID: <20260819191036.679330-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817201602.120526-1-rtice@cisco.com>
References: <20260817201602.120526-1-rtice@cisco.com>
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

This set of patches is an extension of the proposed patch
to handle netlink uevent socket overrun reported by Randy Tice.
Mostly impacts users of Azure VF events (MLX5 and MANA).

DPDK uses netlink uevent to track hotplug events reported
by the kernel. Since this is a one-way non-blocking channel
there is no fool proof way to prevent missing events if DPDK
interrupt thread does not keep up.

What this series does is:
  - use netlink group to only receive events from kernel
  - increase socket buffer to have more headroom
  - report the problem more clearly in log
  - document requirement for control threads

Stephen Hemminger (4):
  eal/linux: filter uevent Netlink in kernel
  eal/linux: increase uevent socket buffer
  eal/linux: report uevent socket overrun
  doc: add warning about control threads

 .mailmap                                      |  1 +
 .../prog_guide/env_abstraction_layer.rst      | 14 +++++
 lib/eal/linux/eal_dev.c                       | 56 ++++++++++++++++---
 3 files changed, 62 insertions(+), 9 deletions(-)

-- 
2.53.0

