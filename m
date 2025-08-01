Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D143C87FCB
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 Aug 2025 22:51:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F9D440298;
	Sat,  2 Aug 2025 00:51:06 +0200 (CEST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id 862704028F
 for <dev@dpdk.org>; Sat,  2 Aug 2025 00:51:05 +0200 (CEST)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-3b78d13bf10so2160145f8f.1
 for <dev@dpdk.org>; Fri, 01 Aug 2025 15:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754088665;
 x=1754693465; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6oTSuP+vZ4aKcO813gvrF7uytVx0xR35S2BwoVJsDTY=;
 b=spBmsu4B/piKfaQQ89qDJDFZKkcIDveGxIeHHZFz8U+ISwFTURRs8hk9fOEL6gRqxW
 oP2E5ZeY02xU1aWyo7wJ4MAX1RyVRPSB1OFuNqBtyQr0qxjAFEo1CN39lRX816WgkfJL
 gvULEyeJgMuc6pgpMQLYbT2udD/UBYegdwHEQGZUYBo1pnZej1Xz5D7dt4TEZz0Ny44+
 41l1O8YHLn+OJNeI5lUoCEHhfrRtSWPPf7kVD9ii+m2rkhCuKE2qiGH3isXFTh44m6dJ
 QlJw3xHrIOGHUohydYfV/nrRQEOVdQXrh4n7OTvjspecaxfcpmhDj47zxZViPbD0X6C+
 rL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754088665; x=1754693465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6oTSuP+vZ4aKcO813gvrF7uytVx0xR35S2BwoVJsDTY=;
 b=EPWRfCAAyJxBRSic0dxNv0r+RkqvsWSsBx/RIiaQlAFKVkrYmt26Klv1ncJpSniTh+
 4QSC3AnoMMtgcvog2lOUBSTyqyqFJoNjm0dutW15RmDWpmOrwJce37i1Med+OjzLmGKM
 bkrKbBssugJa3NDKLCN5oQpTxfhcRuece4PTt0v0fs68unlHPOvEKoCZrkCM9lD0JDuD
 p1T1rmFDXujFp0tWl6uQMZ/fi9DFuZixJXiuqH0ZF/vV8ZHvGZ5uHDrtjhuViMqkVvhp
 wGyO0aWp9tnKL+NsRXn3P6tQ1uwWfwIBWsx9zraEcdjyaX8vYTgXJQjJwrM3zXWQ4BDl
 3vBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOOfhmbd3SrYUUmrITpbgvPsi45Rrc3P5+QjKjpoRHH7vBDq/w2cfSf8gALHzxcFGoxgs=@dpdk.org
X-Gm-Message-State: AOJu0YwL7dosF3XGk71KnpxUftngY8BDgVTTRsCNX5AupstvAQGGJ1/L
 ogIXi5S3aVKUzCKWe2vmr6j6DuxGwfKZobU4IPoHym6mFBbDbkqLOhC+xUPmhe4UhmA=
X-Gm-Gg: ASbGnct/gBj3zE1++6Q5pNPx88HdNoPp9E1Toi/MVlNL3QSMmg0ShZFUhVtscybV3AQ
 osJLiZDU2JHPlFKAgcwOxC0F3gwhkh6p/1PszNE88b8yhnd7Vr63f0JFPKer3OxpPervFXCeHM3
 4Q5iYgCLxPjoujj8xXv5XK6CBmQgZH7KO6S/KqmDsqneowD7TE6aRxzBK6HUd6hgHWu4cmHsFy0
 8rk1AxZHR3K0090oxuhn5Sd7cqJzLZVSHxDYo6Vmuxc5G7Q4bdm1qBwkRtPF00bZxVVtYgzYsv4
 c8daCmJogg4CHblc4xFyWiDgEAdah9EvK9RvH5/ihYFEYT8vRuaITMGytae7Wo/Kcq+c0lVVqnm
 FdPgaO0djmZLDLx6RS+z2pdJ2FXW8S3XioVbkFsb3017DXXR5i01EMBbjwJwGAui+rjZPsNxI+v
 g=
X-Google-Smtp-Source: AGHT+IG11ABjQkDZW089HW4WTCZYha0qgiRZtwvWan80AEXG5xzb68KSMiVaaayGOBMP57OV2IgR5g==
X-Received: by 2002:a5d:5d0c:0:b0:3b7:6828:5f78 with SMTP id
 ffacd0b85a97d-3b8d946ad7amr1130349f8f.4.1754088665044; 
 Fri, 01 Aug 2025 15:51:05 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4530b3sm7540184f8f.34.2025.08.01.15.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 15:51:04 -0700 (PDT)
Date: Fri, 1 Aug 2025 15:50:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Cc: thomas@monjalon.net, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v6] app/testpmd: monitor state of primary process when
 using  secondary
Message-ID: <20250801155057.0a7aee2a@hermes.local>
In-Reply-To: <20250730060818.141022-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250729063919.3554143-3-14pwcse1224@uetpeshawar.edu.pk>
 <20250730060818.141022-1-14pwcse1224@uetpeshawar.edu.pk>
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

On Wed, 30 Jul 2025 02:08:18 -0400
Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:

> In secondary processes, accessing device after primary has exited
> will cause crash.
> 
> This patch adds a mechanism in testpmd to monitor the primary process
> from the secondary process.
> When primary process exits it forces secondary to exit avoiding
> issues from cleanup logic.
> 
> Fixes: a550baf24af9 ('app/testpmd: support multi-process')
> Cc: stable@dpdk.org
> 
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

The problem with this patch, is the build now fails on Windows
where there is no primary/secondary process support.

Either add stubs for Windows or #ifdef the code in test-pmd
as necessary.
