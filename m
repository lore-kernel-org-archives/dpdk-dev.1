Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9130BCD98F2
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 20:58:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73A384028F;
	Fri, 19 Jun 2026 22:58:17 +0200 (CEST)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by mails.dpdk.org (Postfix) with ESMTP id 4458D40289
 for <dev@dpdk.org>; Fri, 19 Jun 2026 22:58:16 +0200 (CEST)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-139a5f4ca15so960927c88.1
 for <dev@dpdk.org>; Fri, 19 Jun 2026 13:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781902695;
 x=1782507495; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hkQAEyZVlIxfxykvUgBnI+zctxQ53eUqrCFBUnhgB5E=;
 b=VgYFB0FsM5JEPvm8rT7Sx9bhK4q4y8HR2YG6+vPOY0ivfYu//cNZAK+QPJb/NurQSw
 p65M4JdUQFxz5C0DPR2AyGsGCiiHr69CH2Pchoue5e7KUoZUuW2usR7zjutg8E9WGUj7
 GPH8W3ypkl8z4LNOaQ8kZc9CNlVjO15wThjiuuAwnrn5AehwSHkJBrG1pGxYlozJFBhG
 LVeWHyxadAwezXkZ2ZXnOf4NV0WC8RitL3lIUED/8Pgkek0puqQDO6r7oGX/bth6cDLW
 Gkyp2kGNtBvyQFxBfBzvb7QucKH7rvjIkwl0hP8HSg8a+Er3n1sBqj4k3SHR49pztH6U
 zTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781902695; x=1782507495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hkQAEyZVlIxfxykvUgBnI+zctxQ53eUqrCFBUnhgB5E=;
 b=lisnTCa5M7+s+rWne9z6oPJgpH6A/FmDsiXBZaOmgKhRTeNcdHs5V6akqn8aVxP1Zz
 UaDfxGtaqoLVzBQUR1Azs9t4nSh69/vh6UBPE9H9YSfPHtEAmK1VFfLdCvjPmNjAkJ1d
 DCA5YYQJ798+BS/zMTg1eCitaRkvUEzX14IpiGoaluNaZZNI9UnFYUPLi5LefjLQQCVd
 /Howt9Eyzu6riDRlEb08JjrOf9+mWHi9psYNYAeCij2NSS8B/fxPAfEq6+yutJfV2QPQ
 ywoIWYZ/Okh4NKP4x8jraE7IkKYAq6PZqFv3B+PprYjVZC2yllX1R2MxfiRhOl8/60fq
 7Avg==
X-Gm-Message-State: AOJu0YzlK9fG9d31PdYtnUbty3vSZCB97Sk/szOGA85YquOFDGp3H95B
 VEBNOnWBzKPQQ0U1rRbm6vO3gIlrhEpY0fODyTuHpiYNsCBbovkINk4j5jl8PwK4vsHx+Aj3WFe
 3n+iE
X-Gm-Gg: AfdE7cn/YkhPfZs4rBiXNpVCxt0GW976heH3R3c26sBUzHA8kGJTE/lKwIzV4sCUi9V
 qZbjN3jBp0IDO6c0YTDocIMAWcl6IHBq3rS64/NuJdx52AYuz5INltjDvG8aFe07g0uhGR3Deup
 AJ2q3YDSpaMEk6MaES2swWm0J5uw560G4n3NZIiVBsb8XsFo1oP54hW6Tx3lfhc58RZqSqZefXW
 j8g5jZ2+KgXSIdEhj1EWDOt093GPphbAFhowbYsgCH17tKtKgFJ+Vtxx7eMPo/d1z7f/5HgNvcS
 5yB1pi00QEyYPG3E6E3ekEpMUfLslqpvEGtGZv1LvuFxMUX+uJA5Sp4SGd4xEqAJZeJZYKgc0Kr
 6Stx5SAAWVdupQjbji1GuCtcNxm5jYDsY/H2j5h0QXx2+WZ6oZs+DdTG30Q9Bns4nSy+Ro9MbKo
 z9LsrahlepuvdgS8hRnA+f8sfS1SBk2l70NbJRHHleA5fiTebH6ZHMHQ==
X-Received: by 2002:a05:7022:f20c:b0:137:fa50:a242 with SMTP id
 a92af1059eb24-139a34dbebdmr2198243c88.1.1781902694929; 
 Fri, 19 Jun 2026 13:58:14 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139adcaad8fsm417318c88.1.2026.06.19.13.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 13:58:14 -0700 (PDT)
Date: Fri, 19 Jun 2026 13:58:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 00/23] et/sxe2: added Linkdata sxe2 ethernet driver
Message-ID: <20260619135811.4d04cfdb@phoenix.local>
In-Reply-To: <20260619080156.1539964-1-liujie5@linkdatatechnology.com>
References: <20260618082723.571054-21-liujie5@linkdatatechnology.com>
 <20260619080156.1539964-1-liujie5@linkdatatechnology.com>
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

On Fri, 19 Jun 2026 16:01:56 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> This patch set implements core functionality for the SXE2 PMD,
> including basic driver framework, data path setup, and advanced
> offload features (VLAN, RSS,TM, PTP etc.).


Looking over the driver overall, I noticed you are adding cflags for -g.
This is not necessary, meson supports this via -Dbuildtype=debug or -Dbuildtype=debugoptimized

Remove this in meson.build
cflags += ['-g']
