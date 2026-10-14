Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277A2C3DA7A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 16:39:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7190640272;
	Wed, 14 Oct 2026 18:39:41 +0200 (CEST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTP id 9833D40144
 for <dev@dpdk.org>; Wed, 14 Oct 2026 18:39:39 +0200 (CEST)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso2402362a12.0
 for <dev@dpdk.org>; Wed, 14 Oct 2026 09:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791995978; x=1792600778; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vTSQt7jjmdk/eIcbFRPy4pIn8EY7qTeZ+vODXjF79eg=;
 b=G4rBoJrRjvHC1uAQpVkORXGEp/RaruJFJcVWJeeUQQ89m89TM/XRH3Yvfvh7H7g81N
 ydjF22rPi4KB3kr4IzrRdktK0hJ5QMw/KV4I7p9CAqst5R8pmbKAXmkI9CI7BlvVJ+Td
 x+JQknUmSJRDIIcZyCxMIZzJ5orqoHlmDQk5BVGzpAniX694aUE1p4XFiebo4Plfi8AO
 0ZbOeNq027NM2mgYi5vh9JgkNcdYNbu6NacdDcG4BYJIi6cNx+Cm+nGXyEgUUOd0d6sW
 T4Yy75dMcWRY/vkCdVltKYIAEsgfK2iLdo+usoLDKJppXbvFQmQ5z+DYYvMMCm6S3kJQ
 EUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791995978; x=1792600778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vTSQt7jjmdk/eIcbFRPy4pIn8EY7qTeZ+vODXjF79eg=;
 b=g1Q5jG2sbKA5d6GBequQ6LTHBpF2nfPMv+1FhAYufLc0jMbCclJD4ZJt09vMHD5Ufc
 E6gtOao/jUc7EjYQqoov1FhNKLemEHdn3p5AwbInzqelMxDzd7MWjRbjB/aeEWdirtL+
 8JdCailrO4r175if0kzBOJ/844didBdy+tjFjPaOU8CfpLmtXhuKSOY1DVIuzHnmT+mz
 phu8MVR0uQwLJpRsvz4EDzpxBifA/Hrb8UgygnzZ6b8MmO7ZTXEWM26pzUcToe/UUHST
 uxL5fsT7rIiQxvk+aQwTDBmOrfItgRwEPoJid1t0fzg8giOZoNliB7RIamM4MpWRpuHn
 AObA==
X-Gm-Message-State: AFq9FYL5jHVwytU34wMZBzjsJt4slZDnbN5kZqo5vRBWvmQmehZI0ubM
 N06N6Faydl9kpn0e5RlrEtfv1YXyTUXsDo/g35Oaun47/UaKUtlqXU4OtLJDrHpe
X-Gm-Gg: AYBFou0dQFWv9/6hpMrH+thNgr5e4JFT3q3v23wOSYhx6PhAShRtVfB52UWjO7wyGOO
 y+zhp6OyCDzjVwMIPV0sPOMAPps0Y3itORFkDmHNra+tO6NOeTwkGxjcTEMTCJyFwWNsEzXb7ru
 CD7WjLcg5IvBJBwQimjVrjFmtguta8ZZcChQPttu3thlR355Vjnr10LPG+fbNk9+4bRCOs7cxaf
 tT+J6d+Vki0ILtFc/VwLcWXSv/LJppDWZIEwVNOCMgFWYmQd+/ia/VxFpOpHBRQs9W7WUVh73mI
 rUo+uoFLL8NQexS5io4RetcnNfgXIdykTGHPc5Erzi26nLD/+/J02OIeEAoEgqyQ732MQnh4SXT
 D9n0hS6qS5cO17aBtllnXP9k3+LrBxFMTSZGKJqlRhc/zNdRuyN93zGvJm7HcwYVylZqsc2m9H1
 pzxTbWJV/xDo/7zWvJ09+BSPvA9vLqS1oHHzHtKjUW5tchoLNqg+X9tYjlqkhRhRvxk4Ywz9mB6
 le5CmUe
X-Received: by 2002:a05:6a21:498:b0:3e1:e6b1:fc25 with SMTP id
 adf61e73a8af0-3e1e6b235f0mr531174637.9.1791995978358; 
 Wed, 14 Oct 2026 09:39:38 -0700 (PDT)
Received: from OptiPlex (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd635cd3b34sm83677a12.28.2026.10.14.09.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:39:38 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: dev@dpdk.org
Cc: Zhang Tengfei <zhtfdev@gmail.com>, jiawenwu@trustnetic.com,
 zaiyuwang@trustnetic.com, stephen@networkplumber.org
Subject: [PATCH v2 0/3] net/txgbe: fix FDIR Rx packet buffer handling
Date: Thu, 15 Oct 2026 00:39:21 +0800
Message-ID: <cover.1791995192.git.zhtfdev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1791898970.git.zhtfdev@gmail.com>
References: <cover.1791898970.git.zhtfdev@gmail.com>
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

Enabling Flow Director reduces the Rx packet buffer 0 to reserve memory
for the filter table, but the size was computed from the current
register value and never restored when FDIR was no longer used. Since
the FDIR mode is reset when the last rule is removed, on flush, or when
enabling FDIR fails, the next rule enabled FDIR again and shrank the
buffer once more, until it underflowed. Validating a rule also enabled
FDIR.

Patch 1 computes the buffer size from the default packet buffer size,
which alone stops the repeated reduction.
Patch 2 stops enabling FDIR from flow validate and rolls back the mode
when the first rule fails. It also rejects a mode other than signature
or perfect while parsing, which configuration does not implement, so
validate and create fail the same way.
Patch 3 disables FDIR and restores the buffer when no rule is left.

The same issue was fixed in ixgbe:
<https://patches.dpdk.org/project/dpdk/patch/20260927042545.45152-1-zhtfdev@gmail.com>

Compile tested only.

v2:
* 2/3: reject modes other than signature and perfect while parsing,
  so validate no longer accepts a MAC VLAN rule that create rejects.
* 1/3 and 3/3 are unchanged. Restoring a single packet buffer on
  disable matches what enabling FDIR already does, including with
  DCB. Rejecting FDIR when DCB Rx is configured can be a separate
  patch.

Zhang Tengfei (3):
  net/txgbe: fix Rx packet buffer size with flow director
  net/txgbe: do not enable flow director on flow validate
  net/txgbe: disable flow director when no rule is left

 drivers/net/txgbe/txgbe_ethdev.h |  1 +
 drivers/net/txgbe/txgbe_fdir.c   | 36 ++++++++++++++----
 drivers/net/txgbe/txgbe_flow.c   | 64 ++++++++++++++++++--------------
 3 files changed, 66 insertions(+), 35 deletions(-)

-- 
2.53.0

