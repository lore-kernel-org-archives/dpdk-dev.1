Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C64EE645E
	for <dpdk-dev@archiver.kernel.org>; Wed, 31 Dec 2025 18:58:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 108CB402A0;
	Wed, 31 Dec 2025 19:58:12 +0100 (CET)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46]) by mails.dpdk.org (Postfix) with ESMTP id F111B40267
 for <dev@dpdk.org>; Wed, 31 Dec 2025 19:58:10 +0100 (CET)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-b79e7112398so1943194666b.3
 for <dev@dpdk.org>; Wed, 31 Dec 2025 10:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767207490;
 x=1767812290; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XWbDvYME+yR2x7b8xw/xF9w6aXupZvXB4RxIheuIdfk=;
 b=yyMrKad+Rhvwnd7JlTrDTzcq8xA10CvpT9a6brcR1rZXpnNd7dPM450A2YjU+dgS3b
 Iy8V6etKOT9kgjVJ8VbkYCifDEcTlte6TNgs4I37Fc0EMC0Go4n6+kxl+Az5JxKgUX9h
 G6IBD3VBRWwS69+aojdZCMiB0wfpRTtNQArbOfnSZ6d1ly4GWabulQnqf722cZQ1zvZd
 xbroVi8hFvJx3FphxVJKl0lV0wu9WPzFRxfo3cJS48wnLAoJE9fz4KqFXz7vduBAjRa5
 AWrQDqMY8Oo7DlYmFv235tcdYeAW8ainbpXYsMW4Zs8ZRO2gXdvbkwKKlU4/IlEUIQ26
 TYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767207490; x=1767812290;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XWbDvYME+yR2x7b8xw/xF9w6aXupZvXB4RxIheuIdfk=;
 b=YfI+woePsLtxYLMqCcVRzuJp20fikPh3r0ozBfiDtGSykyF5quYc74XJqodXqRoEqT
 Nl7JB+0tdeUuvADruz7xBDoAuIANWTjBgtHKKAOY7rWzDQt0y8wJT0nm7NwpDkq8gAUe
 OnGk5Idb3pcMjcHJhuP9gvBXWMlA+nbDIbN7H4Lid1UWcNJSl1qaLLZp113NmbVvKLy+
 A7DG/9I3EVaDMmv4hwai6BqfYQkUsLL97jp+5Oi03mBAQwbEs2i2j9CRcCkm18XHR1Ty
 IT6caLyEmIA4BFk9m93wbJKrwJz3vfCzVciFKvmOUnLzYyp+Xvxkgp5/NxgJx8E3bMYX
 GZGQ==
X-Gm-Message-State: AOJu0YwqW0FN33pXuML/yr4V6y6Zzd7WftrmMPJcVemlHdue1/8qmsvk
 qmEeQk4gIOmJJHVZKwF6hFjS0Pi623QqYOu967+zN1zKaWSv0FTvG4gC6ouEDO2AgYhZA0dIqnj
 7MFoq2dw=
X-Gm-Gg: AY/fxX7o2JxvhSEvkicz2m5X3VJrH46JnRd4nNLmhRJPhVzjcUhvl2ebyeE9IsKyZMI
 zFS7dTSJVbbk26HV8mZuaFf04FbVQxGFKepGqemX9aYu00IkrejBbmmQpkXahdK13RS30ndz/IK
 BWQ0Q17zOYk6d5LqeQLNd4ePsViEqcXjLr8k4YHTh77p+qdOalL5UT+1u1z6SaprEO4/ietVZkX
 lNsyhm3LA1kHoRoDTC/U92k/Ab6g111aPKqL6uFeMKT40JrPU+BZQ+7BdpR5miQXTg88ixwPA/2
 Whf0BjRwKf6lF/mIFnr29iRicct2SBEcledP1+qMdIM7PJHCKjfm3Fs7nXHkvMWIriA0eymmi+K
 DYpdaoahpRYf6H5jUWFhrXhe92/y8YJIfjcItjciBOoUMVM/7anVcuNilLCCi1B1SmTchaZ2UGA
 uMieAVrbncNLrPAPHLejJQ5r8/jDgFXl+qti0PRwj0/GnKhhjBmg==
X-Google-Smtp-Source: AGHT+IEMymX4lCyAaOco7sAgKXNTa1HZiosneEywM9lGlEk2kRe9QeShI7cTEu2GLOWywD1L9wkdsg==
X-Received: by 2002:a17:906:9f92:b0:b2b:3481:93c8 with SMTP id
 a640c23a62f3a-b8036f1d812mr3669552866b.19.1767207489901; 
 Wed, 31 Dec 2025 10:58:09 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b91494dd3sm39000103a12.21.2025.12.31.10.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 10:58:08 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 0/4] move unix domain sockets from /tmp to /run/dpdk
Date: Wed, 31 Dec 2025 10:56:24 -0800
Message-ID: <20251231185803.90528-1-stephen@networkplumber.org>
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

Current best practice is not to use /tmp for Unix domain sockets.
Move the socket communication to DPDK runtime directory.

To quote systemd:

    /run (traditionally /var/run) where privileged daemons can store
    runtime data, such as communication primitives. This is where your
    daemon should place its sockets.

See:

    http://0pointer.net/blog/projects/tmp.html
    https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard
    https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html*

Stephen Hemminger (4):
  net/af_xdp: replace /tmp with /run/dpdk
  examples/vm_power_manager: replace /tmp with /run/dpdk
  net/nfp: replace /tmp with /run/dpdk
  net/cnxk: move socket from /tmp to /run/dpdk

 doc/guides/sample_app_ug/vm_power_management.rst | 13 ++-----------
 drivers/net/af_xdp/rte_eth_af_xdp.c              |  2 +-
 drivers/net/cnxk/cnxk_eswitch.h                  |  2 +-
 drivers/net/nfp/nfp_cpp_bridge.c                 |  4 ++--
 examples/vm_power_manager/channel_manager.h      |  2 +-
 5 files changed, 7 insertions(+), 16 deletions(-)

-- 
2.51.0

