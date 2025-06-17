Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29545C71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 15:03:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35ED740E3A;
	Tue, 17 Jun 2025 17:02:59 +0200 (CEST)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48]) by mails.dpdk.org (Postfix) with ESMTP id AD77340BA4
 for <dev@dpdk.org>; Tue, 17 Jun 2025 17:02:57 +0200 (CEST)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-6facf4d8e9eso62682336d6.1
 for <dev@dpdk.org>; Tue, 17 Jun 2025 08:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750172577;
 x=1750777377; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ehsWFFeulGJaUAeZgWdcWMRDzVv/NvUdBO4WQZD2fqM=;
 b=sPZ91T403Sy4bThjH4+Hu3WvDAyT0OlnIG/Rt5Ke7lQe5NndecqBFa+hzIjHL0PErf
 aFoaAl7tjxlT/RqRoz93xz07uFHENx6E++GmH9Tbm63WpIrpWjAr53bqtAvdbWY3ahvE
 /y1jGLtiKkWWN+E7E7Zr/7Bo/NACn8SsSAK70+uqm4gD2EqAqSWpBYvrepu9xeGpoWNH
 Yh9hpHswbx7Wn4U3Rp2Lqgn7Hd2D6lEQy1HGHoEewpUSlC76V85YHA2FCm5hqE75VesU
 CeOKYiwShd6bmURTWeXpGIWbmyQz6GuW55i3M9loQlNBYyIjzuoSq9BIzLvsUxH7pgVw
 IUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750172577; x=1750777377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ehsWFFeulGJaUAeZgWdcWMRDzVv/NvUdBO4WQZD2fqM=;
 b=JtL8OdTvqkMC8aw97+Ry2isBRXzvlAiKQjlytUAebVfrRbIobz3A8LckONapIUYmCS
 g0P4ZOC7bML8z7iVeFCfeSiflzCVLWW2fHEXNpryASIqE//qVxyPS/fPgTwpZckqxWk1
 F1k6ZtRTRDNWjcXiueoQcMBjcV5z947DVGX4fSHVfV8bb/sNfjy/1+05hNLGABYou6R0
 nKgLJ6Z15+45LTQcYE2ggrkiKdrZlP9GX58I1E0q5KV+4ceBYyXSG+3U0cRyzTBxzuta
 XMW46s2ANn0Ni8kK62j/SZOjtVzi9EP9fs+NoErOTwbFCgqcJsc2czdT4HNhQsoKSfyx
 IWMg==
X-Gm-Message-State: AOJu0Yx1pUxUEUPSEmkIUB5dmUzACUcsuTik1XZId1UrIj3B5YucPOmO
 FdL0wYy2nD6aZ8UHicOpHOGMQrPEZEfIWp4j5vEHkbqx/CIJkyZu0DkFqljtwNQHJsYu0+q9Dh7
 hL2vz
X-Gm-Gg: ASbGnctcTqgIkZIc0KsrxgsmrQtcP5nid7KTR02SWnlrCsmUxUUUFY/SXngFc2BrwfP
 oO1Kk2XCVzDvDlZ7YRjZiumRfO1SNJpTJ7itn5IfCIxQsKIf2WJnJj2TYkBU5gVpWO+CMvWN2QD
 NuqoDpCvFxTzxlTMTrs1/X07oWWM7MByTv3DZ7kqYiOYdJX1m74gGRA4fpam77mJBsGyr2Zj9et
 I+N/wwPN4yjwxWht/liPWdcvMXIPibtmFJuUWZM/izWEZq+xpyCs8cjVMpnQZvU4AHMENE/HFzP
 swWzVNRL7RotzmFtMSW5RQ6Cl6vkWcR7bUFm/YMJuivqdqDsAV/Inu9v4o9nM3EDjKA073IvBt9
 LiqKuvrwWpvM0oYiagveQAI6pzBTRL1WlkgNJ
X-Google-Smtp-Source: AGHT+IFE2H/LlIflnIzD6AvnFFw4k6pyk/sZhiW41+4yLlkxw1B5BpXv5olYAxV9C3abRKOcSJsnpw==
X-Received: by 2002:a05:6214:629:b0:6f5:ea0:3c07 with SMTP id
 6a1803df08f44-6fb47735c91mr226522056d6.8.1750172575982; 
 Tue, 17 Jun 2025 08:02:55 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb5a9dbf8csm13051046d6.106.2025.06.17.08.02.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 08:02:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/2] latencystats: fix receive sample MP issues
Date: Tue, 17 Jun 2025 08:00:15 -0700
Message-ID: <20250617150252.814215-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250613003547.39239-1-stephen@networkplumber.org>
References: <20250613003547.39239-1-stephen@networkplumber.org>
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

v3 - reduce patch changes, break a line that was too long

Stephen Hemminger (2):
  latencystats: fix receive sample MP issues
  latencystats: optimize locking on transmit

 lib/latencystats/rte_latencystats.c | 64 +++++++++++++++++++----------
 1 file changed, 43 insertions(+), 21 deletions(-)

-- 
2.47.2

