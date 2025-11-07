Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED68CCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 14:33:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB0A540264;
	Fri,  7 Nov 2025 15:33:39 +0100 (CET)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52]) by mails.dpdk.org (Postfix) with ESMTP id 15A9B4021F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 15:33:39 +0100 (CET)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-594270ec7f9so841426e87.3
 for <dev@dpdk.org>; Fri, 07 Nov 2025 06:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762526018; x=1763130818; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e/56gntotyDQuvWKlEg5h3GjzwZxyLzzYrSA8jVeyyw=;
 b=JvfKo4DX3Ot2DhHN6UdbNODhi5krBI+Sb11uVtP4MkqfvQGRNLpmVNp4zyoFhWcGvo
 2ymEd8a14I3O4NlAODFX1sRGN/f+2VI+zlHb7S8CxMf6T6j6Vk+VR0wAbzoy6Y5zN3Yu
 t7hTU6MZpyQN5Wd2onOuJkXrSdpYXXiaS/DtDcdxJ2/jaBQOZI47/m3BbeZx/MSMbMzl
 9FpLvGdL8ItEd49Xb56+J7IJUScOv7iwX5E368Q/Hohh7DVqaXOSCR+ffAzAgsdBFdrk
 vgYTObFH0RH2AzbgCUhB3/XNCc/XrWgztGPV+uAPuCR/BlQAwzAYR/6jHrEX9ydQgLqA
 AV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762526018; x=1763130818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e/56gntotyDQuvWKlEg5h3GjzwZxyLzzYrSA8jVeyyw=;
 b=ov6VutaezvL1d6Nfn/i1zCtgA3olkPVo2FiFksuU0AxptjukusMZn7EHC4vDMpthzj
 caS6XmvRahyeeOfoTMAmIQ+CmomWhGFwF8uRg6hdQ3pNOAkMd/Oiiyso8RQIiDU7zgi9
 gKYtBOUZ8tMtgLvWl0etc/nYYkf+MqluXyj2dRpA9GCYQkLy27/275/6tXbyuwC+ELks
 fhJ9xHOxzLvSAYpgjkGLhBL8dIeGtip7rfHeM69lwwdnI5oCbsQ/AkvQ1yM/tM9r8oBo
 pFzgPWmYw50bkCXwq9JyGV5eOHevBafbTlf5MgoC0WRKQmXQKehkkU5g0gG9ysbAn9y9
 fHzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3dOFBCYu/f8zYUXmKHZ0JDClmP9A5xq3J1Ul931Xuul35ZaJl88HlMrrRtXwwtWbtQkI=@dpdk.org
X-Gm-Message-State: AOJu0YyGXz7JFxSKna706S2EY3DpkACpuT0T3QrVTyhX9H8K+dMje8w4
 1hLamOeCrspNc0zoKm0kR7INhV/bE7bgOOPcB9zxL1jes1xala5TwuLx
X-Gm-Gg: ASbGncu95YWdhXZn3niEtWs4T64SyQWOp1Eokq5CQf6uKijpz/tNJbAYPLTlZb4sCM8
 D2y5T1/oecyxY+0UCLT99nkQrvPkcfiOS/KFZAIu/ZhXfv23CvmKBC4ewWu17eF7QKg3ZvU4LZ9
 l6kVeiZfNjBaQ+NbhWR+Ts8WxmJcLoJ4Zde40Mka8M6JnNHi86jY7NcoR1AXF+AaU7RRxRQNMmd
 LmBST1qeWc52P33gunt8BOhgiahaPYLpvC36MKz6as5ILFtq13Nh/zk97MpWTf+wYFmeoCUCtOW
 HE0BjAcChmJn5TIungOsOMSpRmXs5L6cKhTq9nNNwCwfLiBSAE7JVX8OfeC8Bg0cdMJiWZRDzUG
 wMwwf9y9etohFZt+DRs6M2WlC7mrZ62yxwHegqog1AiYime/hQ3EXGbIdpZ4xDL7bhL+FMA==
X-Google-Smtp-Source: AGHT+IHT6Q32b+RMrPjdDG7ssNwkKU01FlaPEiSMcnNtBJiL4DVdR29v4IEQrWNSvtE/rbOuA/rGeA==
X-Received: by 2002:a05:6512:3b0d:b0:591:ec11:7f93 with SMTP id
 2adb3069b0e04-59456b845e8mr1181360e87.23.1762526018065; 
 Fri, 07 Nov 2025 06:33:38 -0800 (PST)
Received: from arch.lan ([91.230.99.135]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5944a0b7692sm1468736e87.51.2025.11.07.06.33.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 06:33:37 -0800 (PST)
From: Tomasz Duszynski <tduszyns@gmail.com>
To: david.marchand@redhat.com
Cc: Ruifeng.Wang@arm.com, bruce.richardson@intel.com, dev@dpdk.org,
 jerinj@marvell.com, konstantin.v.ananyev@yandex.ru,
 mattias.ronnblom@ericsson.com, mb@smartsharesystems.com,
 roretzla@linux.microsoft.com, stephen@networkplumber.org,
 tduszynski@marvell.com, thomas@monjalon.net, wathsala.vithanage@arm.com,
 zhoumin@loongson.cn
Subject: Re: [PATCH v11 0/9] lib/pmu: cleanups and trace integration
Date: Fri,  7 Nov 2025 15:33:35 +0100
Message-ID: <20251107143335.36300-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <CAJFAV8xDK1Ub_1NWHRErMXsM1Hp4_OFnguoTcdMNDVXoehDr8w@mail.gmail.com>
References: <CAJFAV8xDK1Ub_1NWHRErMXsM1Hp4_OFnguoTcdMNDVXoehDr8w@mail.gmail.com>
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

On Wed, Nov 05, 2025 at 02:38:44PM +0100, David Marchand wrote:
> Strange output in the cover letter.

I think I let vimdiff copy to much from previous cover letter.

>
> Shortlog shows 10 patches:
> > Tomasz Duszynski (10):
>
> Followed by 8 lines:
> >   trace: change scope of conditional block
> >   lib/pmu: export only necessary arch headers
> >   lib/pmu: reimplement per-arch ops as callbacks
> >   lib/pmu: do not try enabling perf counter access on arm64
> >   lib/pmu: use build system defined RTE_LIB_PMU macro
> >   test/pmu: enable test
> >   trace: add PMU
> >   lib/pmu: fix out-of-bound access
>
> But the series has 9 patches.
>
> In any case,
> - patch 2 "trace: change scope of conditional block" is unneeded, I
> see nothing wrong with current code. I tried stopping at various
> points of the series, no build issue,

I'll take another look because I cannot recall at this point all
specifics of this change. Most likely thing was some CI build issue.

> - patch 7 has a comment from Morten,
> - patch 8 has comments from me,

Ack.

> - patch 9 is vague, what is this about? Fixing coverity or some static
> analysis tool bug report?

Most likely that was from some coverity report. I don't have access to
corporate mbox so I'm not able to track this down at this point.

Regardless of that, this fix is about making string NUL terminated.
Otherwise strtol() may go haywire.

>
> I applied the rest of the series, as other patches look valid fixes / cleanups.
>

Thanks!

>
> --
> David Marchand
>
