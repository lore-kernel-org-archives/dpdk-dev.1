Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE7EFD8FF4
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 19:24:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C153F4027F;
	Thu, 26 Feb 2026 20:24:48 +0100 (CET)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id D759A400D6
 for <dev@dpdk.org>; Thu, 26 Feb 2026 20:24:47 +0100 (CET)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-8cb7edbcde6so155597885a.3
 for <dev@dpdk.org>; Thu, 26 Feb 2026 11:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772133887;
 x=1772738687; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hFknBvdq1w3kEK+LR5RT+ly4MV8uDaYqrGCSme6yzuU=;
 b=hDl5tk6GTaUvDx5i+7p6ir52TyJgI7Ku6pudp5kK0R7Q60jDHmomNS2Z9M5PWu8rJ+
 b3+FD5y+KCbRmEewoucgs0k5Xd+ufB/tJf7kyF+fPUs2dmONE/UEF0zYBz1e69HDex7j
 bWXK9AwssPCAON4S6myGlK6jXZsGyuT2XUNPMQ8W1J1ZePiJddH6mD7MnPuqpExS76kZ
 51s3NmvPTo8njDD0p1MqHbpKxvlru0wgBLP7KEChQiKXr4qzNB9iL0Xmxpx0NWsM65q8
 WcRrk5N6URKDMg1oNixYDD01QajYScbYq1JMh3/wvVNmEjalklfc71eqmGUISO/lhojA
 ImzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772133887; x=1772738687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hFknBvdq1w3kEK+LR5RT+ly4MV8uDaYqrGCSme6yzuU=;
 b=quIMx9Q0c1OVIU0KPKjCD2AUtDyup9D44NmBeo6+wmoNKR1VsuhhwEmtTZZAQN03j4
 ijMzhKOuslAAMK0xTN8F9/QzMggQmt5HhBg/o1pafUAil2tzJ3lNsjiWEK6yMi5VqiA8
 PBLCely8MfMxh08LA3mXkhYawX5m6eHoD3BVImWvFYHWVhvcjaUKgZySGIvrCAjn6Ape
 G2/ksSMZjtK6ncG69k8+X0RUoOL/TrO/Ww4+S1xp4+Tq3On3auYxTEegTfH1sySx9pO4
 zh9V9azCSwUIppKkd0XedwhXF0ybKIyaJSDuJnMGYCM2uZpjUIA2ADEz95BlxEMgGn3c
 oyAA==
X-Gm-Message-State: AOJu0YzDq8F0goP/TuBkkLsO9iWkK7X6nreMPQGB+XMiaHLCHsfXxm9i
 RCNmxeBCHE4zYxRNBuuTOCP+5VaFSVgT4WvQRY6j3ghiT8QrEjM5WXETmbFcA4XjBwo=
X-Gm-Gg: ATEYQzzyysuyP+zVXdi5BhNdbPBlCyb2+0W2lYA4IFax63Mt2HltXvcOeYrazeouFv7
 WExFzwqOZLXUPakBOxnJfSrgnI9eETSMklBAGpstsAoycf7skMzfpS564fmuNO2135QOTGxxAA1
 AUAtlTBZdKniWfP7fOgOjY0+UhQ7wyZtapPYAZhwtcfD7Gk77wtwBwKGshIK/u8vwe0r8Xiu3pb
 ulqIjNmvaN0zHtka300FAdswcVgTebGHJoNTqnRPcNfoqW63JKBLAWk/pjGdf7Gei0KVK6aNm/h
 /X9xw3PV/7k8jAzEXz6OtHm3A1qM9HerjnlXS/4hsn+lEW5B3QSOJ1RKLdr6WOz0QmiUQCqVek1
 9/OEGpe4yhwuooq1qub9VRr1zuI454KNOFJ+fP8tox277Uw7WLs2viPeL8Nl4DcoqYLE84rPmoO
 0xw2mZDwcp6a25siEUlG0u68xLuxFc2GQ7Lj6mzFCik+B3gvSyMf1Yb0azmhou9omNmNpEQY5fv
 AA=
X-Received: by 2002:a05:620a:192a:b0:8ca:3175:cc72 with SMTP id
 af79cd13be357-8cbc8e55353mr12146085a.15.1772133887064; 
 Thu, 26 Feb 2026 11:24:47 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf64efafsm278441585a.6.2026.02.26.11.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 11:24:46 -0800 (PST)
Date: Thu, 26 Feb 2026 11:24:43 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Leroy <maxime@leroys.fr>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com, david.marchand@redhat.com,
 stable@dpdk.org
Subject: Re: [PATCH v2 03/17] net/dpaa2: warn on rx descriptor limit only in
 high perf buffer mode
Message-ID: <20260226112443.19f5593c@phoenix.local>
In-Reply-To: <20260226143341.282188-4-maxime@leroys.fr>
References: <20260218160453.142311-1-maxime@leroys.fr>
 <20260226143341.282188-4-maxime@leroys.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 26 Feb 2026 15:33:27 +0100
Maxime Leroy <maxime@leroys.fr> wrote:

> The Rx descriptor count warning fires unconditionally when the total
> exceeds 11264, but this limit only applies when the DPNI is created
> with the high performance buffer option (0x80000000). When using normal
> buffers, there is no such limit and the warning is
> misleading noise.
> 
> Check the DPNI options to only warn when the high performance buffer
> mode is active.
> 
> Fixes: 35dc25d12792 ("net/dpaa2: warn on high Rx descriptor number")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

DPDK check git log wants shorter Subject

Headline too long:
	net/dpaa2: warn on rx descriptor limit only in high perf buffer mode
	net/dpaa2: fix L4 packet type classification in slow parse path
	net/dpaa2: fix burst mode info to report active burst function
	net/dpaa2: fix MAC stats DMA buffer allocation per xstats call
