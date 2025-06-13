Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA39C61CE8
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 00:35:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 207F1402E6;
	Fri, 13 Jun 2025 02:35:53 +0200 (CEST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id C91D14021E
 for <dev@dpdk.org>; Fri, 13 Jun 2025 02:35:51 +0200 (CEST)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-6fafb6899c2so18325256d6.0
 for <dev@dpdk.org>; Thu, 12 Jun 2025 17:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749774951;
 x=1750379751; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MpabjlTQF+Hi1gb+O4wATUxK9y+vVY8MLKr0hUpAkHA=;
 b=I/nT21rx+mXLYadt20i1LLl4UW7JSLd8qVL3FgtchMCCfiPXHjqnKHi+sLEVPc+BaY
 vTzTYBYqUpSqEJz8R1yzCo78YLCj0V3DJAcDUh2YSlJ/5hOujFAzd3xNcTcVi7dQU2XI
 F9ivhTXEfETd40hvB0d6mHXQSY9Cq5O7pqLQpGzSIn1945zF6PXwFdIEvnlEfzXviXYg
 61G446DCZ1PIkFv6nUOA/yKjDpIiawNw+SNn3hJiPWt2NvBYY+x6L9MOUajAY3HMwl2s
 xNvcHO+PoY/j4l/oOaT6WBY1UVqMreVDRwZ6wFcydzBbKKxpLsalQqltvRcAKTsj11M/
 i7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749774951; x=1750379751;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MpabjlTQF+Hi1gb+O4wATUxK9y+vVY8MLKr0hUpAkHA=;
 b=vuJ4qTDPCXD32c4HdQAI/EJ/kUrz5wDAOMIxPf42n2izpNPJ8ZxwJ+hMBW+xeJDEeS
 N3fYu9s6j3WJDEVJrs00XqHkUgD1gyYPmSRCEGf4+wYKOCT4FE8OT0BWStkxp7QtkFy0
 ee6GSOPivsl1KB4UcPxd6APPdnhxyS4qgD+tpimY2lJ0NRkTxgUm0d7P+L50uBzR/GbF
 8PIxBqqcgQauRf8IiAXd1+6oDpthiDjMKd4sBLnUY+e+Jx+o9eDHDRnSW3WeAFb6fsrC
 GlpDaSm+WzMqdUJEDhPljF6lLDhYHWJDVRGcCcd1A4C9f3rmIWyoKk8I6q2lxHO0nqtr
 Q5yQ==
X-Gm-Message-State: AOJu0YyVGZhzGNYYtDPki3geoEWXU5D5Cr4ouvi8bHNUDFLQxKxTGx0j
 2y0c8wjwb01anKEUz/+tNYiAMjGPQ4P/ww/1MxMYPVmjLs5Vn1BmM0RSnW/3GIAV26f7wl2WAWg
 ut6cv
X-Gm-Gg: ASbGncsVxkaeZFd9/or/Q12CV7hWkDfWgNsgJHkLgOCs6JRCZtUV0zrKnP+Xbk6i3QZ
 B4cXAlzMtTFjYoaTg6lElHSciJ9nPEcF0X/zctPCqVsY/BIxohXQZQpYwIjmX2cAfh6GlHYm8Ki
 AK0uJSuTL6xwDJpTeeU7PTIoTsh7LzgnQtUs4pteHPCduVv3dt/F1pmZr9PqsDCr8aZ2N5053pu
 QjhsM9VayG2ElL49jYxTr6C4XQ6Q347HjfvMxfohYySn8esUsMNoIaDUNO34Hx3ZjLNFSI02wIw
 J06UnIuJT2X6bO+WPmcT0B0Whuavf/M/1devJ9GtCeIglkagTKl9YBSsJPMCPgvDdDWZGYckHXn
 5a2v/tUEJHQpfbIplPx9hjtgggGrsPHNnjrhk
X-Google-Smtp-Source: AGHT+IHXUci3HJXvfxUwQeP9XL414OcFQnw3jQliuQ8UbUeKdEoXv00WRN8L0GYQ6CZ0avKBLw0/lA==
X-Received: by 2002:a05:6214:f6b:b0:6fb:265:a2c3 with SMTP id
 6a1803df08f44-6fb4019004emr8539276d6.17.1749774950981; 
 Thu, 12 Jun 2025 17:35:50 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb35c31566sm15691856d6.61.2025.06.12.17.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 17:35:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/2] Latencystat optimization and fix
Date: Thu, 12 Jun 2025 17:34:24 -0700
Message-ID: <20250613003547.39239-1-stephen@networkplumber.org>
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

After investigating latencystat test failures, discovered it poorly
designed to handle bursts and multiple queues.

Stephen Hemminger (2):
  latencystats: fix receive sample MP issues
  latencystats: optimize locking on transmit

 lib/latencystats/rte_latencystats.c | 64 +++++++++++++++++++----------
 1 file changed, 42 insertions(+), 22 deletions(-)

-- 
2.47.2

