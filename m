Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701A8CA0EC4
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 21:36:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 593994029C;
	Mon, 11 Aug 2025 23:36:40 +0200 (CEST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id E3EC0400D7
 for <dev@dpdk.org>; Mon, 11 Aug 2025 23:36:38 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-45994a72356so38481985e9.0
 for <dev@dpdk.org>; Mon, 11 Aug 2025 14:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754948198;
 x=1755552998; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qu3/QhFTrU55oTjX8EhZQCdGMCtZBXebv7eon7sKqqA=;
 b=cUAQVMb+NL3EY/WBjg9gO9HYcXqLjuBsMTJHXtmYeIzvAPj6Z0ZxvqyO3Cp9Zta23E
 aqTjMmkb4PK3p7N5AkZ57rWxyojyAA6Q8NcBr+ap8hbfwBt4oLAXZOB957DnUot7P2iM
 FtpMlYb1EQoVe3nhoKGw1bI4NVZAAXOuei5DcfEYB37KnJHRHydXUBQ9rTNsiBAmjsHp
 /jv5tvpYLM/DwslyU/iH8sK7026Yb0YuLA7YcTvKNKrNRLeZHL0D5XNdVbT55sywm7rF
 af18OQ6RuwKZ6efchutskMyJU/R9z+orkhJpLqXjB1kvWBpOAYsZ7jFY13lC5qa10XDX
 QbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754948198; x=1755552998;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qu3/QhFTrU55oTjX8EhZQCdGMCtZBXebv7eon7sKqqA=;
 b=VixhOZPpTlkIabSJ3Am3ulWu+l5aAscMzofynofZlLGPnFL2FjNLLIzc5RJ9FKWnXr
 lhrhfCDGAL1Tq9h2wgEmQOsHuxLShv/V6sk77V8o8/UscR5MsB4daC7Yx7vhmnxE8Qxg
 NQWUZCl+978MjSizl8+OxDLMg+VUormYqwXr1An/kYmQ5oaAKdMpA4U1HUNaqZxMj3mm
 L7D9841coDhQR38jnhye98+3t9iez27wN15lFdU2X6quPM7yRn+sCu0GJSt7LJm9atfZ
 v0ZtMCUbOAFUCV66TROEdkwLP20DT6VtDrhZWu4Jb6aFGfQ0U+9ZdMABOq95RdWRrJJ6
 2grA==
X-Gm-Message-State: AOJu0YxSVJstOtbrZ0LrYOj5IhjqRBB0VVFUs86EM8JzyD4GFmsUAZRh
 4y/Vlnmy0UQFmKGiEff07ojoLWLGvQCpoVFtWnBGpcGu5+qY1Rpuo38376WORJuB8/Uj8jh8wXu
 +5ze1
X-Gm-Gg: ASbGnctku7nf9WyBZTFyuQyzzFEo+iQYIoApbRME68NEiOr4Gg9Xe6ONGauGJjLI0Rr
 IUrtZwL4Xgeh6ij8q38ljvr3GWrunXqO326ErIjCWOaz+dHIRp6eDXl50Wu3A9K42KPXwriErzL
 C+5Xc+IpJ3mZ2a+uZYhSGI6Bpox9xxFRqcV5CfyhtMowFb5M43eNQHB4jEiIbIoTWnFumWCfmXC
 F91J4v2wlh4PzkVvtSE7xkIFKwJ7LnSkwN5CsUZIFcviesP4raXb0Yh/iwnRXGiKD6OpPK1JAA0
 0M5ZWtAlXq12tRZnvWcKxnMwDRrkz/tveXSLjG2jsyK0oE6n+knh4AsxxKgu+8ryhROFI28RJpz
 +SfnMta5yYF/sJPWzzNwNQAliuQ8pEsX4JoCULmEBTE1IHvnYf6lvtgMfOazPHB8PWgCdG2dx
X-Google-Smtp-Source: AGHT+IERv5LMHULiqDZGAt7uEh9ECXoRdUynGR/MoOAcKl3ODiYO8WhU01Z7ojJiidDXH+YSfFwqHQ==
X-Received: by 2002:a05:600c:c492:b0:456:1281:f8dd with SMTP id
 5b1f17b1804b1-45a10d97209mr9366845e9.12.1754948197977; 
 Mon, 11 Aug 2025 14:36:37 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a053a9019sm84661445e9.21.2025.08.11.14.36.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 14:36:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 0/6] Packet capture fixes
Date: Mon, 11 Aug 2025 14:34:58 -0700
Message-ID: <20250811213632.16023-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

This patch series addresses the problem of packet capture when
the secondary process is sending/receiving by using the same
mechanism as hot plug.  It also fixes some bugs on shutdown
of dumpcap (and pdump).

In draft form at this point, works but needs more testing.

Stephen Hemminger (6):
  dumpcap: handle primary process exit
  pdump: handle primary process exit
  pdump: fix races in callbacks
  dumpcap: handle pdump requests from primary
  pdump: handle pdump requests from primary
  pdump: forward callback enable to secondary

 app/dumpcap/main.c    |  14 +++
 app/pdump/main.c      |  16 ++-
 lib/pdump/rte_pdump.c | 261 +++++++++++++++++++++++++++++++++++++-----
 3 files changed, 256 insertions(+), 35 deletions(-)

-- 
2.47.2

