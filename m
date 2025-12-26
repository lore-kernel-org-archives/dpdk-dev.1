Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5733CE8FDAC
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Dec 2025 21:05:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17D4240267;
	Fri, 26 Dec 2025 22:05:33 +0100 (CET)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54]) by mails.dpdk.org (Postfix) with ESMTP id D0D1740262
 for <dev@dpdk.org>; Fri, 26 Dec 2025 22:05:31 +0100 (CET)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-b72b495aa81so1259474366b.2
 for <dev@dpdk.org>; Fri, 26 Dec 2025 13:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766783131;
 x=1767387931; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:subject:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=YWNnXe7UTq8Gbj+ZUYh5wc5zQaUdnZ+wYYCrnUEylK8=;
 b=zN1sX+sgmX69wX4doivAOK2kcel6duk+sHSkS/LmuTq7lluuME44ggTOzME+RTvZ6t
 xsgLNcQHLzvm7Lf+6e0NRwsgK4Gu+gg6P1DkYzS9KDxPk9EnCNW67igbChKWC+ElL9Iv
 xLRgZuZ9KF7hwvW+DrO2c8SwJTOQfsxInXWfx2unKU9oQciAAowRTXpmk+7B8dleMdzK
 U0tFRGsv9ArLACeTPFBZjyAhxZvyrFjLy7ISaAuPTDOs+kugdTGdaR1JNve/p8kRnH05
 hOmVMBElHJbM3PCBDS2Dn/5wP6N8dIrAFDmygmhrGxhTsVFLuQqdjw8Xx2DxwrXSlEFo
 dO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766783131; x=1767387931;
 h=content-transfer-encoding:mime-version:message-id:subject:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YWNnXe7UTq8Gbj+ZUYh5wc5zQaUdnZ+wYYCrnUEylK8=;
 b=hXkFki9c42PW0KcNdSGh35yVMwUVKOkCHMBc28jtJO/cI6jlXh77B/Uanto6DdIwbJ
 2bfBe0vweogi8F9R8aqSKTzsVa3Oip1TDhb1vMP6DCtJG+EFfUa26wFWx0zL9D+tJDkb
 xe74kOd5ZAM6tTHVZHZZlEJXe+1jKBktjthkQCwazGfcmR1ORO+FD3xQMdcaf857KFMp
 kGF55mHQ08FuHdLzRvCKWA7Flqn9zm5T92JRSbWxfTX9nLTlivlxP9AFeRFZd+BvWR4g
 YoKSVn09zkUl8FRFWEEbfHsKrpC270vujednc73yIt21HdLOUNdYvXE58rh16CUA3zba
 fCJg==
X-Gm-Message-State: AOJu0Yx/6eRvpSd3KSzzGZY23jhGRpqGiJ1qRp1cpc0pTQy8xEiK/LHx
 bzpYb5LKImwjEM7M5V3fus4yC6JIKVk6gbE5vgeBZM1qi/d0ie7EddqcjZLo0Uph9FKsG1O2N4K
 8nY2Q0Og=
X-Gm-Gg: AY/fxX5lDxL7wOzz93Fwqg1DUYNwIN8wiPckwgs7zH4OA1L4AhcMFhNoCmrDUTpQkrG
 CfiKmO01l3i9z0KkP+HL+nZuSkHtTiBW71jtnDdjfYyc/qISIp7I8Cq4PCczn3ZA+XtUgElWLQH
 mwmM2Kz+KlM6kIouxJxfkGFtU8Zf+UOuEIodwFLWKBohFnmEWLsMCMZl0PcGD65aQUXbKKKcHHo
 oRwb/adyUpHQomanvmBiF9O4OZcAdXjvJbfQ20P/t/wnsrXZXFWItUUe7UdQoP74rhu/eVScuiY
 c5rkAqL3F/aJB895aLox73lngQN9Ia15zLPhDMjgpMkTvz8A6e+8M6gVTQddX4IUyPPV4lARWHr
 UniFlvAt3m0CJogdaQGjNCAhKwAsk6wiB/w1AvqTdo/wU+fxUSVXW5rQOcGz+Xm3nCUCr1EuKgy
 5sGSAzdLI7CFrFboAWYA/SbN7R5nAsSEbhWenG7tSRlze4gDmNznzx
X-Google-Smtp-Source: AGHT+IFpyVlGEmxaRZZUXhCW4lBwQIIq+Z9aJ+UL03o/O6h9iXnhQswrj1MOZPDiFJnOSCr+xbCOuw==
X-Received: by 2002:a17:906:c147:b0:b73:6b24:14ba with SMTP id
 a640c23a62f3a-b8036f31e99mr2327760366b.8.1766783130939; 
 Fri, 26 Dec 2025 13:05:30 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037f3ffbasm2499963466b.61.2025.12.26.13.05.29
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Dec 2025 13:05:30 -0800 (PST)
Date: Fri, 26 Dec 2025 13:05:24 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: github build mingw version
Message-ID: <20251226130524.00263a6d@phoenix.local>
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

Recent test build of patch series is failing on ubuntu-22.04-gcc-static-mingw

The version of Mingw in the github build needs to be updated.
The minimum version in DPDK doc's is 10, and version 10 has afunix.h.


How can the build environment be updated?



