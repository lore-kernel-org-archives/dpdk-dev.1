Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DC9CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 16:27:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F14DD4021E;
	Fri, 24 Oct 2025 18:27:28 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id 23D4F40151
 for <dev@dpdk.org>; Fri, 24 Oct 2025 18:27:28 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-7a2754a7f6aso2830447b3a.1
 for <dev@dpdk.org>; Fri, 24 Oct 2025 09:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761323247;
 x=1761928047; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WQnsd9GYL1DsD+6jY9SRN8bLVjZhOpkRsKXCf5w+miY=;
 b=lh8my3/71M1y/jBgRJTVWRYZpzHKZF0JjJYhCCLo7wr2n8hj5FHdCKwK9y1swxOd0e
 6MEcGMPUbrFqtw+ad/2jbUt7yCJxnBOd5m6JB5iKSnxKNOLFqHJUYh27ofeeydKH7/xP
 vHufMlUxl90G7L3E2dypYhPbwpyO8IS2gqrih+/UJnOQW+EU2ktq8SCjqDu39oQ28Bd2
 CPhHMtjpQ0g9SUeTHDp+6rBRuWABEgc6490YvvgxbKoMvp6HpH6Rh5dk0tMY0Xz2hvKr
 yo/qkn6PKa+mw2Zt/UZNudHIGnMrnMXXa1bU8wJ4kbMQkXmoYqBQcroJETSeXxO5PkVs
 tGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761323247; x=1761928047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WQnsd9GYL1DsD+6jY9SRN8bLVjZhOpkRsKXCf5w+miY=;
 b=o3SGbf0TM4wbKIs3S4y1GbE1gjpnN7HqomHKZ54etfIYDxQZCzbuM9Jw6K5SRKo8qo
 GYkmjDOzpJdOLi646eUwXvF/88aSDAJ4EPm7OdQ/YmQ1oWUYcrOm1YLqC/vSTE+vXf/Z
 VF6ZdoWnWoewSxhD35u1csxB/4FRp+h8X/EV7VjsjOqucSxd0SYX1CGlfkMqt0xNhYWd
 IqhEnEdnbGsBkothA5CT/u31QdBw1wD2KxpF1u6taF15ak8cxp8cyDrj3kaJcrWZzgST
 VPFfdQwK16/n/w0S+0/5tVDiMqP1Ykn8LTuIsY6N4kpB1Su/VH0xn6f5k/USCgfU13PL
 b6MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqPF8oaKhPumuPns8ykzpi4+mIKFDwud1JRCFg6LU92Nf9qu1D+U+MjbBwlaS1XJM/IE4=@dpdk.org
X-Gm-Message-State: AOJu0YyZcAQFS+Ntdd5bd0K45H3meDo5xiFcuhD7joJ1roKbjD7YllNW
 HSRAc7BLMZP4dKHWQUSu/t9S6T9IR1qdloyoltK9cqiu5xkIaIbCejDUmiTjZEsJ7UM=
X-Gm-Gg: ASbGnctJX6PJGxlsotHRcTQDBHo+5Sbx5JXdhEp544CI/2qHHS1A41k5qncR5P46mZ4
 ivcBfG/VFCCzPejVO0ny9Prkos56n2FcVSr02cYAgi0OwVuBTGKVK4aTqVzQovJZOZHqNthJIEW
 TN/b3tDFUwqaWeceq9Wrl0DYutdxyD2MSwEVoRLXxSnN4FMDIxxLF09Xc80rzLYwBoUW5DqcSgE
 oL29zsYXHaAUJ7MKSjhD02oKuD29emBCNzsvV0QgTz8s05g/YX+fxUQAULmBL+Tto2+GopoEhy8
 ajjiiwzgGb1wQDHZlFJu44pVe5t2bwTOyn2Mp1QGWBRampHBoeAVwh224jkBg+iJez95zBCpo98
 Ex2AaAwwG0VOV9hf3B6QR3SbtJKF8IzDdkog5dbdwZYriDy3fn48Ji27poyBsKNveJBWlFJvJsv
 4eZtE+vN5tq04cLFL6hAL9A0wiu+Jd9ZBGpA==
X-Google-Smtp-Source: AGHT+IHo1r/74bK3KsJQcrL5D4dpO+F8Qx0L1tGEIWAg1CyF5OQu02V7QjYPlVimySaaGjN4IZh4XA==
X-Received: by 2002:aa7:8043:0:b0:782:7052:5167 with SMTP id
 d2e1a72fcca58-7a220a574f9mr25204183b3a.6.1761323244803; 
 Fri, 24 Oct 2025 09:27:24 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a274bb3d5dsm6328126b3a.54.2025.10.24.09.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 09:27:24 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:27:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Qiguo Chen <chen.qiguo@zte.com.cn>
Cc: sunyuechi@iscas.ac.cn, stanislaw.kardach@gmail.com, dev@dpdk.org,
 bruce.richardson@intel.com
Subject: Re: [PATCH v5 1/1] eal/riscv: optimize rte_memcpy with vector and
 zicbop extensions
Message-ID: <20251024092722.6c623afd@phoenix>
In-Reply-To: <20251024054128.1569133-2-chen.qiguo@zte.com.cn>
References: <20251021065607.1418203-2-chen.qiguo@zte.com.cn>
 <20251024054128.1569133-1-chen.qiguo@zte.com.cn>
 <20251024054128.1569133-2-chen.qiguo@zte.com.cn>
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

On Fri, 24 Oct 2025 13:41:28 +0800
Qiguo Chen <chen.qiguo@zte.com.cn> wrote:

> This patch uses RISC-V vector instructions and zicbop prefetching to
> optimize memory copies for 129~1600 byte ranges.
> 
> Signed-off-by: Qiguo Chen <chen.qiguo@zte.com.cn>
> ---

Is there any possibility of build environment being newer than
the run time? The Intel builds already have to deal with that problem.
