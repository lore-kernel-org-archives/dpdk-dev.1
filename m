Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978EBCA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 16:55:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF2DF409FA;
	Mon,  5 Oct 2026 18:55:16 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id 9F1AA40374
 for <dev@dpdk.org>; Mon,  5 Oct 2026 18:55:15 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-39dacf053eeso945189a91.2
 for <dev@dpdk.org>; Mon, 05 Oct 2026 09:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791219314;
 x=1791824114; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=f7fGs1ZGdMimmoU8QKJxcvdnEPfad+h07OlOyssQ/xY=;
 b=kgGLqiHbLkLmXYsUcW7FRRtuhaPfFqAoGHEqVHYIKGBuCzS2Lo+tCdVSnyTLHzvfoG
 vjrBXb5Hobl5vpnOJt4V1JGihtXp2pYSNos/YCGs1rVdTqVJ6sfXLelV3bqohmQOwVtd
 LuOycuWjIiOHwXE7739RWWXrYn2uUipKkhNdnxonzO39Y3nEYc3xgHKRNsW60lsgFpMx
 /DrEAaHCJNZzHy91MOZ6E+ADf02FFwpWn1apyTQsa84sqV4f4oKm6dLfI4qVGlzx8jJh
 zyDpa6UWpmJgzkR6U0aCfmMsjYEy6Yhz8EjgompRDoZ/lcfoQlYH0i/dd1evn/WLV6fq
 8ElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791219314; x=1791824114;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f7fGs1ZGdMimmoU8QKJxcvdnEPfad+h07OlOyssQ/xY=;
 b=Iuli2JNkUjFhyt/BdibH3y/SQzf25jd/jrMyaGVoKp5pDG5I3brwi82szrsf0CUtcm
 x+38sb5rKh3zSotBhx1hOXlDVQyCWIbOzixHipOGSWb+F2b2SeVHabesgdC1TZ9aUmGE
 EZOBDJ1yd+1jjBWkcmNvDVAY1mFFrVS/v9HL2ocpfuUiCxvBtecoHqbrQKxU5I7uK6xT
 Fv2utO6scmmQfSl99OIuDxVki9HGKr0bVueqgRV276Pt7cSz0my+yqEsk60ZmJ9FtojN
 QnzBkplVQleowj+wyjZP20yFJgpetV3nl8k62gIqvG7hL/6TxIdnrbM/z/GpE6i1XZNs
 BETQ==
X-Gm-Message-State: AFq9FYJ8TowYi2Kt288H8V2OXYGgn8bvP4fTV4q62yAiceI6FKj5EWrE
 tEKsvMoRn22ac29daY5w2O/Tlxwwn9RqpaE/Qg0OTWh9Ub9d7/yF7HlQUmbxjW7I569yHMrf9w5
 2rx2T8R0=
X-Gm-Gg: AYBFou0n98Vq8HtgGExLza/bQoIyaS7jMepEPBxzJ4BuXYw1qsFPT5ngwVn93+r96cl
 TTcPTgWfjWkgN0Rp8AyfZCvpgOKZaVn4OAEd1ueVnqe+4mhw7TfvD6Y2OIHxcpthYh4l58siAAD
 vb1tL536YVwdqIjfqGglj18dZ0zrT5mxKTgAwYxn4LeY26wfP8/soByfQ8/5XGgLBCU/FWgGMXV
 BFDAaCYk+BgjyUa4tpIAoSyOC4LeUyA0FY1FuAPKPJeopPqKQtT6DBJW7gb57MKnmf91zgCYcQC
 FEU6PH9C5ShjV3IZu1V+3hoG7xZVGYEAOBURnBA9+qkfK+TuHxikOWOgENoqx5gjUd7Xmh6eYvU
 vU5YSDEPRTFLjrP5jqZd53gNUQQtlGFI+xPk4w0J8z3/ve+RygZ2w6hUqQv7W/32hcgDBPU0fRg
 OcoQn6zQXVALix6xqHG9gZvYL3CSx6BjmtD+kt6u8U93OeXjiE3755AZbdafxd0gH5LQS/dzUQC
 RxZAqCDMFCyKXyyy1U9SOt7vd3R8VXyIhIebA==
X-Received: by 2002:a17:90b:4a0a:b0:3a7:82ef:a8a9 with SMTP id
 98e67ed59e1d1-3a782efb176mr5821157a91.26.1791219314486; 
 Mon, 05 Oct 2026 09:55:14 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a8533aba95sm289414a91.2.2026.10.05.09.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 09:55:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/4] fix crash on device args with no driver options
Date: Mon,  5 Oct 2026 09:53:46 -0700
Message-ID: <20261005165512.334085-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

A device given in the global syntax with no driver layer, such as
"bus=vdev,name=net_af_packet0", leaves devargs args NULL because
drv_str shares a union with it and is never set.  The legacy syntax
always sets args, to an empty string when there are no options, and
drivers rely on that.  Passing the NULL to rte_kvargs_parse() crashes
in strdup().

The first patch makes the global syntax match the legacy one by
defaulting to an empty string.  The second hardens rte_kvargs_parse()
so a NULL gives an empty list rather than a crash; NULL is not
excluded by the API documentation, and an empty list is the sensible
reading of "no arguments".

The last two patches add the missing coverage.  There was no test for
a device string without driver arguments, which is how this went
unnoticed.  Converting the devargs test to the unit test suite runner
comes first so the new case is reported on its own rather than
short-circuiting the rest of the file.

Verified both new tests fail without the fixes: the devargs case trips
its args-NULL assertion, and the kvargs case faults in strdup().

Bugzilla ID: 2049

Stephen Hemminger (4):
  devargs: fix NULL args with global device syntax
  kvargs: harden rte_kvargs_parse
  test/devargs: use unit test suite runner
  test/devargs: add tests for missing device arguments

 app/test/test_devargs.c             | 101 ++++++++++++++++++++++------
 app/test/test_kvargs.c              |  16 +++++
 lib/eal/common/eal_common_devargs.c |   4 ++
 lib/kvargs/rte_kvargs.c             |   6 +-
 4 files changed, 106 insertions(+), 21 deletions(-)

-- 
2.53.0

