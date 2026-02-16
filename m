Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97131E83841
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 23:04:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3A57402A7;
	Tue, 17 Feb 2026 00:04:43 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id 3BE474029D
 for <dev@dpdk.org>; Tue, 17 Feb 2026 00:04:43 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-437711e9195so2529625f8f.1
 for <dev@dpdk.org>; Mon, 16 Feb 2026 15:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771283083;
 x=1771887883; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zEIQOWpj4nVPfXGWa0jRSx4asmPCe3+9O/keCQVrNyU=;
 b=Rq/MjC/UFanXPjGebrDVNadF3RcLKlW1VJ8NJsJ57Dy90dAPynhuPFtO/ZbnzZISZ6
 002xoDgZteS/lILNJKu+d9YpYeXe10IMmiXfyhk4b/OcrcYp0nSkXCfbMYoT3LrobZbo
 ZEvQzH5dCvQv29PaHBAUUgisz4G/lT7w1zvsSILttfm003zQz5RZsCwJHMSzvmLyFN1T
 SVUq3vVbLPpV5LLEynrYs/z3adoypVtMpjkq00Kejjg7nc7JJqhc2VKD6nizoQo95CXI
 N77EZcPIIB18xMn43FCeIawQDwu2zHY3dZds+7ytmDE/ALvivNU0ee6WyLtxuxvLVGVd
 1T9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771283083; x=1771887883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zEIQOWpj4nVPfXGWa0jRSx4asmPCe3+9O/keCQVrNyU=;
 b=wDDQqIoEilR5/6qCPZjbUSJge5eIK5hr2OziR3hXgTjw5mQPhpcy54zZnYx15gPeeR
 GngkH9ImQhBWMdg3YCDN06C2N2DeNG/vETYPvdyR4rugf7p34XM9PqlQUK783UtDi0Bb
 NmEvfQWnA1232QHTDPG2hC54ss44IfvksreKBkKX2rhsCvW/0WNk7+VN6HR5CEy0dqOI
 W8GppofGI5jnWFU/RBbUpozAMpuQ0HeD3mIzYwEDr01rZ8n/wctbgXVPdnYqWDgQdclN
 BUEH1cyQyzUSazdgOfvudbS5wkdwMUD4TaLLqxcu4YTy6FVF1hjsbtCXzRvGrDUNDhL4
 8TIA==
X-Gm-Message-State: AOJu0YwJo1NBZO4pmJUMSWfgFLRGcSw8e+qe4+ax9lHCAoCQ/6Smnxx2
 HpLwNOP5+oFdHSLsYaMZpXcLe/3gww2xg10U9dluoNiiNOMSvfyfGb56lC2omqZlcFGxR4c12gd
 Y4Y22bRM=
X-Gm-Gg: AZuq6aJEKxJYDuZ2f/wTH/eyUTiFFRotBOoqumbn28B2gnAc5Z6jK8pzcBPkY5zkuzu
 ljgtkuP+itQgHjEUb+SnJ6ObrHHZPr53u9xm3vkjNhH9hVwQVBu6bWLwW9buHPe6KxcZuXo+Q0c
 yocU9fItwbf459schWYor2tk3MfK+oauYSgURGW3dc8J2w99KEDVT3UQr3NdDDSMa9UtS2l0SdE
 zdsmsgnxvHHJXsV5u0xM1jizWHRL8/cZj9t2rBOlKNHsFgXlqCsWtyyU5vjnnwQ8wyL1QazKbg0
 7p1FMopvpXhYi4Dx/sBj0i6ipFfXwfZHB84ZjdYfr1mB2V4fkFHDa6RpVrq5ZKlQvBbh+mTKkbB
 oz/jjT6lPcgsKEhI9tZUsNT23BLe18fzdQ8namkR9+COaUiw9/HJjidUMHo2bN5HCldUixcXk+h
 fj3hyw3fygKntEPh+CdfoxpUD67c/7mfl6P2TpIby1U1FC0al93fBAYJWtCwT8dg==
X-Received: by 2002:a05:6000:1865:b0:431:1d4:3a8a with SMTP id
 ffacd0b85a97d-43796ab1669mr20728737f8f.7.1771283082575; 
 Mon, 16 Feb 2026 15:04:42 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac82f7sm33158867f8f.28.2026.02.16.15.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 15:04:42 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 00/11] net/tap: test, cleanups and error path fixes
Date: Mon, 16 Feb 2026 15:02:24 -0800
Message-ID: <20260216230437.847578-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215195348.557945-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
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

Add a unit test suite for the TAP PMD, clean up minor code issues,
and fix several resource leaks and a use-after-free on error paths.

v2
  - fix typos in previous version
  - preserve same fixed MAC address as original

Stephen Hemminger (11):
  test: add unit tests for TAP PMD
  net/tap: replace runtime speed capability with constant
  net/tap: clarify TUN/TAP flag assignment
  net/tap: extend fixed MAC range to 16 bits
  net/tap: skip checksum on truncated L4 headers
  net/tap: fix resource leaks in tap create error path
  net/tap: fix resource leaks in secondary process probe
  net/tap: free IPC reply buffer on queue count mismatch
  net/tap: fix use-after-free on remote flow creation failure
  net/tap: free remote flow when implicit rule already exists
  net/tap: track device by ifindex instead of name

 app/test/meson.build          |   1 +
 app/test/test_pmd_tap.c       | 901 ++++++++++++++++++++++++++++++++++
 drivers/net/tap/rte_eth_tap.c | 291 +++++------
 drivers/net/tap/rte_eth_tap.h |   2 -
 drivers/net/tap/tap_flow.c    |  23 +-
 5 files changed, 1069 insertions(+), 149 deletions(-)
 create mode 100644 app/test/test_pmd_tap.c

-- 
2.51.0

