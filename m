Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B57CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 16:30:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95BE7402C9;
	Mon, 27 Oct 2025 17:29:59 +0100 (CET)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id 3C1C74028B
 for <dev@dpdk.org>; Mon, 27 Oct 2025 17:29:58 +0100 (CET)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-88f239686f2so478218485a.0
 for <dev@dpdk.org>; Mon, 27 Oct 2025 09:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761582597;
 x=1762187397; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OsnQVF9l6890hPZ5DWWPQeBPEARBlsj1Mvyb1pL5DzE=;
 b=jmQ8tc5SvJdeYRmwNnL/wzm35EiMj/Jki018dwV0LNe18MXtGmUIsBf+63PhKVisrk
 GWyWnw0n8nrGPhsEaVxZZzBo2AGFNQcCvuEjR4ugGXoZuejhbKkpU6r6EjhHMBi551F1
 8aI4015JcN17jOqKaESd6D5LGKfVUQD2zoZRo8uPag4V3Jci7UWH86j2Yv2Jo+JIXa3o
 kpSwPEGQIF/NGzBEFe1z/ISXTGCtZP+7dZlYEbnrg2LffgNULwRE1Dcsvv6+SwPohHI9
 fjd8lEyH666QdfFCuwxqqFCeiWAkwSZzamEQLZ9zsqsX9r18emqlKbf78NOw3o/+gRnh
 Yl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761582597; x=1762187397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OsnQVF9l6890hPZ5DWWPQeBPEARBlsj1Mvyb1pL5DzE=;
 b=ZU5j0+dydAXz+trb/tM0sUawiXmzbz4rZahxGeuYUKcPJNM38y2yAqiH5le6rigXv9
 /Llz6mEbnoVdVdwsH7KZ25NL2ilMeCyFDToCRrVCkCRVd1UnbPw8Mtk69SXqdDwJQ/10
 GAugNPKgnwEjS7rLqxgMSKUF/l1lREKYU27wBvxibwm0ctr0K4RhMYEeIZAEUeEb+Ss6
 XOUMJBcnGXQq/lGE82q2cl8aEcR+By0pi4wHfnUz6H6fEf49JtVyAtFDFsKeJ89l20hb
 mZPzM1s6fJdwt49icj5f9egHqLZQI5r2fB1dto+tm9ovwFxK9uDK9HwyR7Z6cgnOLE96
 CaLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBoSEMbyOOv5cVxfWceLixvgZ4a6SLznMDdbNl9pM6U3RJL9o4ZrT6OlF9hKK2tFlLST4=@dpdk.org
X-Gm-Message-State: AOJu0YyMKb9Xy9LuMfKAHUMc4ThJdS/SpAzVynqH8xE54oHXGu41Oo/j
 qAonC8k6uv3QO+s/w8+bgYwWoFPcrCYoYLNuR78xfYe4pjHQX7UlxFkaNB/rCZBeNpo=
X-Gm-Gg: ASbGnctAm7EIOTLm31MU6J1r6RxO8Z5CmJ7jwUZAHB2otO4zCPKESGLOlIzd+rXd56d
 TQ5KMzm8KGEV+MWgjmH+caWMpfLjxAAvs7x6vRDiHg4JopH28ISJ7rdxDNnX83NEud84wNW39yU
 OuPDU+iwZseRoqW1MhvlOw6W7zCrpDx6uomc3IztdoPKooumL3RL4YWaFUsLng4oozoEheYCeRz
 yNhkn0xUYAelnJzBq7WuMoNQQd5s6gKIFqX9oDghRctypak13slKLMZzNPRCnpeo7OqiPcDCwgK
 A6+mna+DhPDvYQ+B1XtVlzpLfrj3chwSjQaxY49if1rfrVuUo62oN+zFZNlRxNu164gSNSII3/z
 iZS9K87p3PbLO3sag0rfqoPs+rLAVrb1Gy+rbyYB5z0mYQnNJc0YTTk5k1FNMInwQduaWQGBLKZ
 nC7snstYJx8PjFZa49gX6/A+VOw7trCBjTWA==
X-Google-Smtp-Source: AGHT+IH3vXakT35gvcFNnSIbXup6Fqi21zUUCij4Oumlc6ME+x4jQlLdRt74w4Ltyydir6ktBNcSNA==
X-Received: by 2002:a05:620a:1996:b0:82f:10ac:450b with SMTP id
 af79cd13be357-8a7009d57b2mr50300885a.65.1761582592978; 
 Mon, 27 Oct 2025 09:29:52 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f261747efsm617569485a.55.2025.10.27.09.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 09:29:52 -0700 (PDT)
Date: Mon, 27 Oct 2025 09:29:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <thomas@monjalon.net>, <dev@dpdk.org>
Subject: Re: [PATCH 2/2] ethdev: support hide zero when telemetry regs
Message-ID: <20251027092949.4af149e1@phoenix>
In-Reply-To: <20251025094239.4915-3-fengchengwen@huawei.com>
References: <20251025094239.4915-1-fengchengwen@huawei.com>
 <20251025094239.4915-3-fengchengwen@huawei.com>
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

On Sat, 25 Oct 2025 17:42:39 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> Support hide zero when telemetry regs, and also modify filter usage.
> 
> Now the usage:
>   /ethdev/regs,0,hide_zero=true   --hide zero values when dump regs
>   /ethdev/regs,0,hide_zero=false  --don't hide zero values
> 
>   /ethdev/regs,0,filter=ssu       --filter ssu module when dump regs
> 
>   /ethdev/regs,0,filter=ssu,hide_zero=true
>           --filter ssu module and hide zero values when dump regs
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>


Recheck-request: iol-unit-amd64-testing, iol-sample-apps-testing
