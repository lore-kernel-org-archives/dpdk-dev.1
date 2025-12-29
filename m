Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654B0E92FD7
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 21:54:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1960F402B3;
	Mon, 29 Dec 2025 22:54:59 +0100 (CET)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52]) by mails.dpdk.org (Postfix) with ESMTP id 77B844025A
 for <dev@dpdk.org>; Mon, 29 Dec 2025 22:54:57 +0100 (CET)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-b7355f6ef12so1817316166b.3
 for <dev@dpdk.org>; Mon, 29 Dec 2025 13:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767045297;
 x=1767650097; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KeQcrs8XYcGrdeJW7WczACA+2VTEFXUUjUG7ChsWkkc=;
 b=15tNbl9KukHlzyd5vvX7gIG+i8EYEGTMUGg8fBfHjdMOP7Jo75gRkGuKq7HJyywtr0
 0N4EF/DQnINLEuJwLgBuNmj+XPwJMDV+7PSvHxH8LTo6WfwV33dYr74yFwKMj5U+FRfR
 x9VHyB2M2u+qdQmJ6JQmXBmirl1dzsqPr5fyzhZyjLAxJvXcbTWsswK9GQKhBKfp+wQK
 xeB5B9G257Ot/LKmCJbPJTQVz6Daomy/74oS7nlJz+TvmodOl/ReSWt14qyvQoCONE8k
 IqjsoGFOBrwFYxxEqrBoZ3mEfdzlhkWiBfR7yow6iU4ICng7CszJZ6k45yeCgbQe9633
 jqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767045297; x=1767650097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KeQcrs8XYcGrdeJW7WczACA+2VTEFXUUjUG7ChsWkkc=;
 b=qulFaXjqVTNZU5s93kHAH35Elk2IYiW8vxcK5/8FZUD7q3m+iTjbbcd7M8MQYCSbMp
 1EL/wSJwrxkKk0fCyDHpjpL8jZdA4xGRxNft0xJyd+mSamTm0XGRDuVg40Ikhpi6efmd
 pWJo+RWY3pdB+9k8tSSjs5d23AM/oGG9mZ/50m/GUtcFz0cnnFGK+R5z6MlzBAems+rD
 iWH0NxBeliuZVZOpaEn2rijDHJp/GVuRPGdDdCN4o8GyKlKD5P3sMfYvzIeNBkhyTV5w
 GShWRUp6xSmEth4adw3Euk92OgoU6sjooNUXNvXkCmZtyNhohihS6rRhaqDY11U1DGWS
 HIsA==
X-Gm-Message-State: AOJu0Yx0rYRBlHpxgCszslgT6q3I6U08tbBH9pAtSm3KF5xgFIPK7V+R
 RamgZSjxZwqM0L/wTlOz/VPCEGS8JfEYcmDP4KyTnUbl8JT3byryUmMN30nlDcKRz54mHRiOAs+
 lA9taaes=
X-Gm-Gg: AY/fxX6H1DVZ5neSPmFEAOa9Ymv1uicKebwHg0C7Pae9mg7t2mEKFMOxnA05EE+AxiF
 hJlwrt8nfBlPvcLGU016flrdQ5kZeuZDKLK+ldqTDNX6Q7V6AXKZ57ByiBqxXiUtVxWckonThTV
 UU3nOkr+BQZbEQBdfY1RoWNvvJMe3YswNPTlkM/V8Ck1w3DMkA9UF2aSVFMbbrLZmy9Q4KUiXkO
 0/8cnZko43JEtXtbVzBlf1G3F1X5QYOh118dQ9P4sTUox7z9tFML1FdVUIpQVyndJ9e8rri/aLT
 awucMGCk02s4xp1EBD+UWvpg4sD5qpVTFqR92Fdzf4JSGlLoSx4WHcNGk/gGPVsTZ0vy/m990Ev
 LogsUOTj7QcXv0aY/oEnrHLP+VtWZddKe/MkNb5ewgii17ki0pLjW7go/7wkNtlhiG/CFwnrOIn
 RfQQWKWs0VBYnJ/d0E9anvXxaB0zqwS8eH4V3oejcCUsHP46dELAI2
X-Google-Smtp-Source: AGHT+IEk7ikQKyFNWrCIp5OZO6ddzMq670ABuGuS+DOxhmoNgcfCyxpqBtvCpuk5CkEYKiLcYh+Hew==
X-Received: by 2002:a17:906:6a2a:b0:b76:e6bd:7bcd with SMTP id
 a640c23a62f3a-b8036f107cdmr3455843366b.20.1767045296975; 
 Mon, 29 Dec 2025 13:54:56 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b80426fc164sm3274794566b.30.2025.12.29.13.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 13:54:56 -0800 (PST)
Date: Mon, 29 Dec 2025 11:07:14 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>
Subject: Re: [RFC] net/virtio: avoid global variable name conflicts
Message-ID: <20251229110650.6df093d5@phoenix.local>
In-Reply-To: <20251222004446.62076-1-stephen@networkplumber.org>
References: <20251222004446.62076-1-stephen@networkplumber.org>
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

On Sun, 21 Dec 2025 16:44:46 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> If PMD is statically linked, all global variables are visible and
> can clash with application or other drivers and therefore should
> have a consistent prefix.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Recheck-request: iol-intel-Functional
