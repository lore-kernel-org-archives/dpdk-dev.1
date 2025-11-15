Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196C6CEBF80
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Nov 2025 19:37:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3434B40E13;
	Sat, 15 Nov 2025 20:37:55 +0100 (CET)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 6693D40A89
 for <dev@dpdk.org>; Sat, 15 Nov 2025 20:37:54 +0100 (CET)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-b55517e74e3so2440228a12.2
 for <dev@dpdk.org>; Sat, 15 Nov 2025 11:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763235473;
 x=1763840273; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cd/b2KcIoJeOxi36VEY2AzV1B2CkfXDKMcI/TPsONcA=;
 b=y5vtGmKCvV4KWUpFMKtFxD6076BlVMFbBhUUqqxgQ+rlM1Yz8XErkWmK0MOP9eWwYL
 XrASo0aEgYs2DtJr6s+aUhPh/n+DD5m3eGBfx0Hr9jNnP6T9JO58qrz7k8dE96ESp+0X
 5Qm7yZhdG5N/hzURRHEE5eiJthdu2y5808CGrRHRxshKCe8U/MTZi3JDfSuwogKdairq
 BgwgHOGSH9ex7cBmNhIIJCd0xxdLAyzcYEPTKTGlw7enWYhpkOAIpNgA7OPzTZakqqiL
 usSIcBYvRAO/QitFycPsYD/ncA7zE9/62zCC0pD4vJWU3+XrTcp8pIFQKp+dGQMG8zyS
 m9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763235473; x=1763840273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Cd/b2KcIoJeOxi36VEY2AzV1B2CkfXDKMcI/TPsONcA=;
 b=ieCpEp6+7Kgh6iEXn94x+qgpipeWNYWpsBtwuOwSZguE4r2MAvYYQyeEfNYJuFrLp2
 xwOroepzVf07cEk2Vgp2tImz9t08I42Qsd3+Uu35YiRUdo+VA6UWwZb3JnygHScCq9AK
 Wo/am+McUf+Yt4pr4zzkRMgYcKrLyP8jA01Z4/bOv6mOgACj1hc1ghd4KExlY43gd8wZ
 PC7GY2PeZPp/YIzldnaf5rMAEBiI//+uEGuZk/ic6QloLsuMz8UuI87zhb5/ZvBVdWSl
 jZTIwpW2liG/GLT+piEQzDrTiC2mJKwGaJ6TiguHMRmZU52b/pGMbc/XKa9nMFIEvr0f
 aJ7Q==
X-Gm-Message-State: AOJu0YygNjIhsh3xoN5ic9a+CmoPeeeg03BONsHusAeay6OO/vy1pn8c
 YS24KtGGlIC9Czo+rizTNdgwKq29EHKUos38p0TfL1yBIsCZkPUsqW8CmwsxvOx/4m5dXvY6AED
 T0C9u
X-Gm-Gg: ASbGnctRXh6hCIYogG6ga+U8jzkmIcNNHTsW0otjS9DwcfC2Y148zk+6hEMY3cpSXJP
 xn/HGE0197Icp40RjiAWTHRqbLHsnEBHr2kVzxlBUQd0xK51ddhTBWKBTkCsZL61VlnWhumc9wy
 1Jk8Gra0VZu6IwNuA49dlAooNlnuG76BtZioNx0nxAFEhjbopBGTIAz1YZrfLPOn2bsejWad+oc
 9+0iTtg4FkKayd+CIU1CGhBsOWw2MkdOdGQPJvLxJbboKv+Cr9DeFxvDMvDUDNiB0HUHfK9TDGR
 UHmEEh3kAEmHlmGkWRSdRPEKh8PrkuxFhRXcTTiBrWW84fyaTM93IQ1+dWNnvs8Tk/UZ6vZvs8S
 LnZhFEwKPRY/R5dby1hz+i0DqikTszDlhwIBkNi1xS0E7oWDuAImNTA7OCWxtmg9e/sZObHTB2c
 M76NT+yBYOoIp1S6Wy+YtTv/rS2VPS8/IMMGepQCaz2ISqHcQzE4jxk7oR/LyT
X-Google-Smtp-Source: AGHT+IEPoLY+fs6Keeeb9hZ3SJkU38CYueFQh1FlScIYNIo/EVTP1cP3hYQm1YLWGT0Q7Y6m94z+JQ==
X-Received: by 2002:a05:693c:8207:b0:2a4:3593:c7ce with SMTP id
 5a478bee46e88-2a4abab6441mr1985980eec.14.1763235472848; 
 Sat, 15 Nov 2025 11:37:52 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49d695821sm28753833eec.0.2025.11.15.11.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Nov 2025 11:37:52 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/4] examples: fix format-truncation warnings
Date: Sat, 15 Nov 2025 11:36:35 -0800
Message-ID: <20251115193749.101355-1-stephen@networkplumber.org>
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

Enable and fix format-truncation warnings in examples

v3 - examples only, update commit messages

Stephen Hemminger (4):
  examples/server_node_efd: fix format overflow
  examples/vdpa: fix format overflow warning
  examples/ip_reassembly: add check before formatting name
  examples: enable format truncation warning

 examples/ip_reassembly/main.c              | 7 +++++++
 examples/meson.build                       | 5 ++---
 examples/server_node_efd/efd_server/main.c | 2 +-
 examples/server_node_efd/shared/common.h   | 3 ++-
 examples/vdpa/main.c                       | 9 +++++----
 5 files changed, 17 insertions(+), 9 deletions(-)

-- 
2.51.0

