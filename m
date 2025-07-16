Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B80C83F1B
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 20:36:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46044402F1;
	Wed, 16 Jul 2025 22:36:02 +0200 (CEST)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47]) by mails.dpdk.org (Postfix) with ESMTP id CE4AF402DF
 for <dev@dpdk.org>; Wed, 16 Jul 2025 22:36:00 +0200 (CEST)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-6fad79433bbso2968186d6.0
 for <dev@dpdk.org>; Wed, 16 Jul 2025 13:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752698160;
 x=1753302960; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cf3igkpZwz6wMg0Ptk91uDU5AMse1CTIWH+DyeUAMDY=;
 b=HsNVS6t8lIJ6BlNxqF7Oxlczf82RTMYthNQRSpKG5jOWPqLYG+vvTK5ALgrhAqyOH5
 dVob81pFkm8mkSy1E66wmzMvlNQXGlVzDBtPbQO0FWcJaptGC5MiL653/V9lGhY5hLeb
 nv0mQa+aXx2tChZURqCWExHSM7GRH0nBlIKCPy9so1Uq1FenR1dXL0Hd3qajPK2yVuW7
 EmUxGN/8XWP3wXHp4fUnlGko5HAvepqz4XmZSRwjq6bIkLnBQoceX4ODZg8gVU+50EDE
 9XeOMWkhrmyyWSlP9Ft7ztdJDr7tcPHEBWPH1LQ0JCqp5zhbdH7BEuSgVt1FWG5HYuYp
 ya5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752698160; x=1753302960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cf3igkpZwz6wMg0Ptk91uDU5AMse1CTIWH+DyeUAMDY=;
 b=xPnavYEYq7f/t0w4Mcif8NOP/M87ZIDag1YUuzOErUPTPslPEdrNpJwo/Ljo9HGfen
 NVCLZySz10OCEpNaacGTOJz8dffdH74eiuyOAwFTn6bVS0Wv5fFNrUCdI6EfBwNyFLBg
 gh6DXpjdo1IAoDtx47sYqP/v24oDuZBbQA5j8NVla3QbpMPTPl6Zu3hPFzPyhtMuCpl3
 d1MgRW2wuUyYkE1bZYNDkj2FE8l66QZfjHZ0PKAuTzpKz1P+ldicLu9Vnap9vCQAOv6i
 3+Mfmt2/cYb9lsYlvN8iXey00G6VmVfer53Otxtxk/bkuy200FAtYkFy/Uvw/Aam9+rC
 9Okw==
X-Gm-Message-State: AOJu0Yx8oxXW9w0Z4H0rlevEEg3bLgo5q78gCNxOa8YNC508liTa3ivB
 sfu1/7NAtx7T0v8r6lw10/1DcDphBPSTYSoSuPF8f9jf0Dw+Zbjp1RyMTvdjp/k7lR89bOV1OZl
 iRQ2o
X-Gm-Gg: ASbGncvnADXVy7hHV8LbrEwZQsWzmPnPce9Pd/0VPEDQdBwTC3BQx4rKsxR7esdocCr
 GMVNWY7tWcFxMk/OwiDyM+wnwknfp+I8R8QepaCCfNA2FcrE0dIjMe2IzMsw82sr6ahq0bxteiD
 lFTE6x0X6e5krbczm/rIDeOLQ9dcQHqan/jevTuGuXfXM2J2EtNrs8CVQMrswtibPjfWT26OWuE
 4kTIkE4jDaPjoCGazUrpbWxtD6gOF3htYLblMMDP/9mCr7kStUkmlixfATmLbmIoBXKkwHq15zZ
 foDWhQpIU3S0ZPGXMIq3EX72osWG9vuo3SrMy/kgF6q6V+BPsqP9XJ6C7X8y4dTeJXYIsf83j80
 KBoq11za4fkkA0EoEPTGvZqwITqqWVJ2pPFwMxLwkKG5+g+aqa1WJNsS48SF1HMRJICGVgSLb2k
 A=
X-Google-Smtp-Source: AGHT+IG7mqkQOPFZBEaOPTCvyiBoWsLnt3YhyovPMz3z4T/2+TrZOyBkKEGrJ4PEs+SZhCF+0NB+ug==
X-Received: by 2002:ad4:5f8d:0:b0:702:d822:f9f6 with SMTP id
 6a1803df08f44-704f6b34b8dmr68633016d6.37.1752698160042; 
 Wed, 16 Jul 2025 13:36:00 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ab6de94c3esm35476961cf.36.2025.07.16.13.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 13:35:59 -0700 (PDT)
Date: Wed, 16 Jul 2025 13:35:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 02/14] net/sxe: add ethdev probe and remove
Message-ID: <20250716133557.061b8a09@hermes.local>
In-Reply-To: <20250716082930.83026-2-liujie5@linkdatatechnology.com>
References: <20250715034152.7020-14-liujie5@linkdatatechnology.com>
 <20250716082930.83026-1-liujie5@linkdatatechnology.com>
 <20250716082930.83026-2-liujie5@linkdatatechnology.com>
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

On Wed, 16 Jul 2025 04:29:18 -0400
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> +
> +#define  false 0
> +#define  true  1
> +

Bad idea, conflicts with stdbool.h
