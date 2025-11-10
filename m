Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D6FCCFA13
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 17:08:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6A33402EB;
	Mon, 10 Nov 2025 18:08:41 +0100 (CET)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id B39A04026D
 for <dev@dpdk.org>; Mon, 10 Nov 2025 18:08:40 +0100 (CET)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-782e93932ffso2700179b3a.3
 for <dev@dpdk.org>; Mon, 10 Nov 2025 09:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762794520;
 x=1763399320; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dt7V+Fj/3sXzypfS7eHJ490nU+7ABaMai4e3ZrE0pVg=;
 b=DFtwkqVcWEMEKspDK6puD3xSOR5N982Xv9aERb8xxr+z35o9a0aB8pQwlT0hbgXiIx
 eqDDL6KYEf1qIDLoLsgE8zdxjpNc3355kJN8XeqLaxZ/pyhCYSFVuDkScObgP88tJn1h
 EfCYrfL/acQEiymDXNP6Lr9TsemaizkF0kV13B7xTualniFP7hUvEz0Na7YuySuSHFur
 CDjoIdxZ2sKWXrzV+iy/dUuTlXoOBDo8+wO8uMRzn8oZmG5QCLAxQljSmQrg8WYAMsEo
 lexNTYhQGjxgSDmKZwkbTYpQYBYI+6A/9tPhERLhRF+OujVkGHsu6pfmN7LQ8tWhCm8m
 LWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762794520; x=1763399320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dt7V+Fj/3sXzypfS7eHJ490nU+7ABaMai4e3ZrE0pVg=;
 b=OD/FnOiVSDre9hOmQoTe9ufjpG4TGt5KUAueclbf+cgBFbLE2viLFvJnpJD21YT+Bq
 GePs9LTz2a2ylvgwP7hDy8MjMRyVLmMCDyhSn/5YfBXsEl7yyENcarlkpvEl094E3fPS
 hYBuKxQsN+Mm9EzqsdsA82ZT0oL+zlrn8WpK8N8Y95fliaWgBctUZFOxXlGl+Ua+2cdj
 IPeSljHsOblWYyYQdnhcK1v0RHDTgls6OKtyPmXfTC7Xyo9loXrwhCMQF+cTRbgrYpzx
 emnl5b0/fPqdXZMU0j7nS83LTimpzB94GBPUkoiVeo2WEig7r29DJBD31wqGu669KOg6
 /RHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzZBlKufaRm/2H73Wu+GUKZ/ezJ8YiV0Ccf9w64fGdTZ6xA0+Q8PH3Ov+kWnoglAn2ocA=@dpdk.org
X-Gm-Message-State: AOJu0YwwbUeWwMYhpZxSIQfGDVcXDnEYWzOY1BrrU45McRCn+Q1P8WcW
 r+jM9aAUvX0zunahSALfIPFTLhG9bzQ78qn7Xv+vCYNBN499Ge6QhdH6lrr/ARwxakY=
X-Gm-Gg: ASbGncueAuLHytQw0vV+ysaTFSFNRagllFcfp00aiqbxl59/fMz54/7MionjpIb5Yao
 1FHI+PJQ/M9bjUKDEjpDO3emfwrrAizh6RjiP0IXYQXPMqxZ8cE/aD6dwseQLuI5RL8fqJs4CAU
 GydxHFrQkiLwj5RSv6Zy1R3WNXtU7LQQYqtMkI2hkrFiHncl47kjMdPvbXmFPfboYAB+gxzJoNu
 fftQb7AtUdrzkD+I2PkIuGjw6vEvv9/pgNewuvYNyiQK2XYaqukd/I6wyMwayRAZ8PtZCmELhXf
 MIbVsihqp5osE/jRHp60lJdQZlOqKx7+UEgR49eaptjdb5CCWi2WB0vem7EIlnoutppDXbCzAgZ
 h8trWCggORcpdX8K0h+A4ZDe2jkAblwS0DU96MQ7twSQulwClShU7msExhF0wK/IuTPxWd/udev
 coc5wzzLEu+nACVofJFoSvyuQGAxgnqKWyAg==
X-Google-Smtp-Source: AGHT+IEDE+GvX4axE0wpEKModknE9MsjWD8nBX8jJhufI7ZTkz63+hUocRl3qB/aoQCSq82Jk4CCMA==
X-Received: by 2002:a05:6a21:4ccc:b0:340:db9b:cffa with SMTP id
 adf61e73a8af0-353a11b1731mr8688156637.9.1762794519799; 
 Mon, 10 Nov 2025 09:08:39 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7b0cca5fd74sm12320735b3a.58.2025.11.10.09.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 09:08:39 -0800 (PST)
Date: Mon, 10 Nov 2025 09:08:33 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: Re: [PATCH v5 3/5] bpf: add a test for BPF ELF load
Message-ID: <20251110090833.0fb95c2c@phoenix>
In-Reply-To: <34f3ae46b0744bcea63bd4031cb8d4a5@huawei.com>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251109200854.45942-1-stephen@networkplumber.org>
 <20251109200854.45942-4-stephen@networkplumber.org>
 <34f3ae46b0744bcea63bd4031cb8d4a5@huawei.com>
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

On Mon, 10 Nov 2025 16:38:08 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> > +static int
> > +test_bpf_elf_load(void)
> > +{
> > +	static const char test_section[] = "call1";
> > +	uint8_t tbuf[sizeof(struct dummy_vect8)];  
> 
> I still think alignment may become an issue here.

This was copied from earlier part (run_test).
