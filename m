Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFC9CF8875
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Nov 2025 16:23:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52E4A4026F;
	Thu, 20 Nov 2025 17:23:33 +0100 (CET)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id E020E40262
 for <dev@dpdk.org>; Thu, 20 Nov 2025 17:23:32 +0100 (CET)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-298039e00c2so13953695ad.3
 for <dev@dpdk.org>; Thu, 20 Nov 2025 08:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763655812;
 x=1764260612; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pXkuhtuv4l3tz4KJPYHCiAOaIo0xa/yq1GYzjuoAFUc=;
 b=sMurmBdsFaFhsMu2RUwqAAI9qBUOuBrq1Bv6qrmlagf3I6W1HsfLy2sjz9yapBaLlD
 RGYjfnUMwkdT39TLnSEL7jQMuOTXH8jddi7j6/9uMEGJrZaQAcJaqwiJSdi52JH5o17/
 uz53HsOZ0vO2xiP67eIyrOVrwPwcsKcDHOpvmCdX38gxYo76pSCgYf96FXoSnez8BQ3r
 jKC3uFEXXmzIc0ifP8zDbAfsao1l5+4jzeTguGJc5KQ7aTqfwaYEpOH/4D9rlJswkbJD
 TGbKzzA6XAavKY3MLm4sBIRtyaiqQglBHz+pK7CGTLvrWp2OuOQ5atAqd4oDrGF4RPAP
 wKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763655812; x=1764260612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pXkuhtuv4l3tz4KJPYHCiAOaIo0xa/yq1GYzjuoAFUc=;
 b=Nf76uScBp8w/BBrhsYpJTyw36DbcuBFsmXvfkEmNeTKHYsKyJ8balvHGAsMTm2HQNh
 RaKentbGlx6pv/r90hrPYWsMjXyGrOy20S/JxXDoiQ4aVPWgzQgQqarnpzRHiUJcR4il
 OtQs4tUZyyOwf7/ov7CjkpHva4JtzmfWVnqWeIvvtRQPZI+WdlCheUvnWzugObt8UMHh
 Eswm/E4g+51B4zNj1+beazn9EkvfU5iSQJ/oX9XGHMHax1+GFxiRrMtS50ftq/HEitnv
 Qsfrt581iblcE7SMe1dyu9HiGnRCHANB6ycrndYDgcNKT6rrY7CgRjk7Lnm9QYQ5WJe1
 ysCQ==
X-Gm-Message-State: AOJu0YzqKlUj9C5ENJwuwotKEwz811+oYEgpn6GSTrNC/V2OHf7KWuQ6
 56AYnzS88su9b3njBp5R873QRnvT0C+Nh7EMbVXb1EXzbDvDFWLjcaDpLZPCMNfipFWSW7qdYdK
 ubXHa
X-Gm-Gg: ASbGncssF85L6rgrkYsTEciR/VP2zdyR0X7PcqSBlyQlfWKJ5vyfV+Tq0fan7hEgN0k
 Sdq4LZjocZMDqJIFBMj7IPFfOP0FPZHkycQH6c9ueTZqipbrTOp9GRTUS4DxIitkwgZ70gflKuq
 vpdb2J2+x/vAQtA08qp2Wei8QAQctb5FSLkKxqzOdizWHuwZeND5taCHAH8Nl1O2Y0lutSHkyyv
 LQdOljSrIaXBcAmH8nZ8HSGowZV+cE8/yYPaogkX8ZqTkpJy41tG0UKT28STxSa5z55LFacaTIM
 xH8JctmE6RAT5QvpaqapP8lv9vQHyvxUYY2RdARK4KjOtUApY5vrlCEHsJFKIrDuwiVQZLvxdp7
 NWQ64Gatf8hqjm81rRgwGyikOh2wuu35MQxFq5fCh/7h/b5Lam6ACN2Hjk5ySq9K7MGg6LgxBSP
 zoOOZEGB4e5bNM8NxxRXeDAvbt54N7uNsaX+YVuDNQFjbrmmN++2xTHBbXJuwW
X-Google-Smtp-Source: AGHT+IHpYSeq0NW0MqohWoBCin1TMsb7B2sMUuNEifkd4r6LS8PN6ZdTTp/oYJga7g9HcSNa67y8Jw==
X-Received: by 2002:a05:7022:fc0a:b0:119:e56c:18b8 with SMTP id
 a92af1059eb24-11c947fe1cfmr915346c88.32.1763655811710; 
 Thu, 20 Nov 2025 08:23:31 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11c93e3e945sm12096427c88.6.2025.11.20.08.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:23:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 0/4] examples: fix format-truncation errors
Date: Thu, 20 Nov 2025 08:21:58 -0800
Message-ID: <20251120162327.78062-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110182209.104087-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Enabling format-truncation warning in examples show several
possible overflows that are easily addressed.

v4 - use RTE_STR()

Stephen Hemminger (4):
  examples/server_node_efd: fix format overflow
  examples/vdpa: fix format overflow warning
  examples/ip_reassembly: add check before formatting name
  examples: enable format truncation warning

 examples/ip_reassembly/main.c              | 7 +++++++
 examples/meson.build                       | 5 ++---
 examples/server_node_efd/efd_server/main.c | 2 +-
 examples/server_node_efd/shared/common.h   | 3 ++-
 examples/vdpa/main.c                       | 8 ++++----
 5 files changed, 16 insertions(+), 9 deletions(-)

-- 
2.51.0

