Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CE5CCFA02
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Nov 2025 17:21:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8873B40270;
	Sat,  1 Nov 2025 18:21:27 +0100 (CET)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 471BD40261
 for <dev@dpdk.org>; Sat,  1 Nov 2025 18:21:26 +0100 (CET)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-27d3540a43fso32729585ad.3
 for <dev@dpdk.org>; Sat, 01 Nov 2025 10:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762017685;
 x=1762622485; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fvgmH4t8h2Whu18EHPSTWRscqDeIjE0SntuxSBsJ9Vc=;
 b=lx7jr1ZHpd7PxMZltNSZjpiwVo5MmpAu0dLjho6hnKODmhhwUUEboCIEvMJqMpWRRh
 cHNH8O3MRfEVpPCiJzBV1Etf7V00Pq71ic7iBV/j8A3dAIw0R81Qni+ViqbNffqQQOCf
 LyDNdJ0dbCm22we2EWFmJuDySKWC7FzGeM/kNXVFu1xHhIUOLti6t04Ytnl+vugdq4D6
 rajee/i7pTUObhKdFp593E/jS6Zn/z4WDQkfWNiLcbSXZkO+n5z2NkDrWIJdu2DqMcLt
 22BCd2vONtMCAdwImvMHenA0SAeW28Zyh6r411v7RuIzunMy4x6O2bKPBmNTGcrITDOt
 w8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762017685; x=1762622485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fvgmH4t8h2Whu18EHPSTWRscqDeIjE0SntuxSBsJ9Vc=;
 b=E3+6ivPdDGBZYD4Hi2inbmOOYauFA9bwbsmmAy/wUyhukgpXD4hlLEYagxaYgvHOkd
 LsNq4ZOXphaxLKscq1deeDIXJbJubXuIlQxh6D8ySzcPJM864CeRUEOgvtj3GhQAAxAq
 0QCB7WUs6dV4UXV+okd0L7ppVAiOVTJLAUiUnzx4Fd0HtHZQhEUAorLlBX477AarG+ty
 Vm0boS2JKRcOkCUj88QX2F7e1AyDHy8LvFc7x9n8vwDV/KuJe4G5nbxu0wIWgxma/8Nz
 jCxpalh708j1kWntOALQKa5LjSsGJpadSj1FjsVsoHnImwNWoBdS0dzzg05Bm051mNDD
 sTcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4FRgb2RDgS3/4yvQcWssl0TZ6TJ2tnl4e5kbnBMYATFl9P3txricXCTICTaovs5BFmCs=@dpdk.org
X-Gm-Message-State: AOJu0Yx3Uq5PP6rr1W0o+T2jkC76h83LdM69vGlZocJqclznfrNMru/T
 /6DPA0+tgf2tVj43swFVzgRWgpeMknWNOTtYRI3WARnSL32i+D3RkdEf3oYMYS7kpfQ=
X-Gm-Gg: ASbGncs95zEyhmUD5pIHShjj+o9B8GTeiIRTyLKaqY+QSgX7uz87dzblRRItCiUnBu7
 +2NwySNVjqF40yiJQ7mRaWtcuSF/kVFvMSoGQzvxja00ovZD7IeTVpAH+utlRnAcbnMn3Yi01+c
 KgS6MCP7tAweWp6Z3Z9PAQS+v1eM4dvlC8pfZUWbg4Z8wUAg8WlG0uDJHCRHkmRI1iGz8hNppQB
 tR465bl06MzznK/uXdQixjGuugzlBj7FZV99oyaG4teuk1eWUeMZOgQYsxxJOuPL1v6mFM9UvGz
 1+4jXTL6uDzyaDYARsqgGeVxSGphC6WF7KmhXtiRBRYAGwBPWmjaFJrInapccZF5SBMqI3FCCgv
 dc++8CQJzjO/UfGvi239jjCgnb+V9JHqPx5H7+mHHuaRAZLs/N182j2ctYSYp5d3uVYBAj+nwM2
 lsc3pJhAXjOcfsHxDWqCaaaOnT7olhOuIQlQ==
X-Google-Smtp-Source: AGHT+IFQ8SQzJTK0PSlv6tZ4XO+aKM685QayTuNayGW/8/aNE1qK9X4vMBADxpYnsz9VvvLanCRg1g==
X-Received: by 2002:a17:903:41c4:b0:295:557e:746a with SMTP id
 d9443c01a7336-295557e7b2fmr45577285ad.13.1762017685089; 
 Sat, 01 Nov 2025 10:21:25 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29570cb027bsm12529515ad.92.2025.11.01.10.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Nov 2025 10:21:24 -0700 (PDT)
Date: Sat, 1 Nov 2025 10:21:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
Cc: Jochen Behrens <jochen.behrens@broadcom.com>, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v3] net/vmxnet3: disable RSS for single queue
 configuration for ESX8.0+ versions
Message-ID: <20251101102121.127af268@phoenix>
In-Reply-To: <CAL+mCpMB4aZuqkX_zzDea9uyUf1qQp-5JdoeEPxWnfk=u8XqRQ@mail.gmail.com>
References: <20251022155651.9818-1-amiyaranjan.mohakud@gmail.com>
 <20251023083019.18792-1-amiyaranjan.mohakud@gmail.com>
 <8e750656-787c-4dce-8cbe-241e7929d2a0@broadcom.com>
 <CAL+mCpMB4aZuqkX_zzDea9uyUf1qQp-5JdoeEPxWnfk=u8XqRQ@mail.gmail.com>
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

On Sat, 1 Nov 2025 08:31:21 +0530
Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com> wrote:

> Thanks Jochen.
> I see that the state is "Awaiting Upstream".  Will it be changed to
> "Accepted" post upstream or Is it already accepted ?
> 
> Thanks
> Amiya


I periodically have to manually go through the awaiting upstream list
on patchwork. Usually happens at each rc.
