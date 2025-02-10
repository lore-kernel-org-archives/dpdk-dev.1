Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708C5C0219D
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 22:34:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C3DE402AB;
	Mon, 10 Feb 2025 23:34:34 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 649EF40156
 for <dev@dpdk.org>; Mon, 10 Feb 2025 23:34:32 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-21f44e7eae4so79547835ad.2
 for <dev@dpdk.org>; Mon, 10 Feb 2025 14:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739226871;
 x=1739831671; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CA8eICeujxDOq5U5NSuVVOoEr3pctugrfxO4IIw7rC4=;
 b=xLaug+DRkUn8+Mkixl0QzPf+7P+6WOXJNxWZDnV5Cfm+97kGuixBYH+hjI5pMhtXi8
 BJTmd2jvrdFW6IuSS2WxnSpCN/mglnqx1P/K7T0fyrl7iuk5JyeSGX6QBy3V+UCVXkYg
 ++JXNpzkoh5RatE7KKr0CFuqnMnVDUN9ZMOk19GLf3Po7+xEulk5i7iCE1afslb4RYVo
 L2oK6C4PEmkwTz5pIxO6E3x3+fNY7InZTAanRVrhaRY1fBFM/tvYs1O2WSNbzuN+r/RF
 gCVPJKutyF5ZF37wSmWX+8JGHRar65qKZhkzgm7JWWcwcVszBoVRuPvaH2xMWUBx9bty
 0UGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739226871; x=1739831671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CA8eICeujxDOq5U5NSuVVOoEr3pctugrfxO4IIw7rC4=;
 b=PLo/Z6rFbQPZE/7FYpgNVe8ALaw0+FWJToO6SARZF4557bA9k1bjkkQScsKLON/3uZ
 60s/RM9rtlJVqK1ZYFPB8+Y1J/dzykyZl+Zt7Xpu2AjIK1hNkOIs1CFyKmcO2tva4hnj
 5nLLcYLV8kXJ1wm5NKAf+L1pg4NbMEQp/TxF7Bi5kXDXw2EMKsfJb7vnE5+EgnkeH3Ix
 1/YSYX2pBRkzYSxRQGRFY1LnANaUuY97Hpk9fTSXYDl6NLS/KOVcAz4HOkTyU9nE7/4X
 reIcbjE4AkC55uZOe7LrOC+CLhQ/nWhZRNO1r2ntZr4t2CqEQqbgriUk1QWwGN9mIZ6J
 VE1g==
X-Gm-Message-State: AOJu0YwEjZOx0s9XPA+PZIyVL36wzX/UMGfVZCmYaz4cy3ZFyJZXIyDj
 vqibNs456+JHwbybIVyuFbOyZSpwE6kaO7vD3nNJC0HrUQsWBFKslhv/QE5jAks=
X-Gm-Gg: ASbGncs2HtKwJMHLzyBvQIoR4BGLLwcEhm6ZvoFgtiYd5zrJjB7Nq/Qc7prNyJSvfS3
 hEKiWcyRBuEm1oOR8L/D2OHszKmKd/LXiRo4RpM0/y1D7QGIjPD/z/gNKWhYbFPAcMR1+5BL/qn
 8JMJ0waJ3c4XzAgWHmCdA3Z2YP7I8Z01AsNbWD2brNWgp7mh49T1vmBCtN5uPiSX+e8dV4MaD8E
 5dzl1w9ER7aoaNwHHlkF69tcNV9qm4RnKzD6gAhX83kHproeVZLHWvEBbxRM/DPm80Q/xW4MhqU
 s9NJwR5KiwS5LwS2fHdaVQdI5j+MEo5qtJqQRSKYaOtom2L1B4MI0LuRX9N1ZK37kgdc
X-Google-Smtp-Source: AGHT+IEWQ3It/v5gaPWN0j4zsAkGtE3r60DHco2HE0k0jI/fKF2rXb9IsFVoAtjSM/S8c7u1WeUySA==
X-Received: by 2002:a17:903:228b:b0:216:7926:8d69 with SMTP id
 d9443c01a7336-21f4e7832d9mr211952875ad.47.1739226871208; 
 Mon, 10 Feb 2025 14:34:31 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f368b4bd6sm83840535ad.229.2025.02.10.14.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 14:34:31 -0800 (PST)
Date: Mon, 10 Feb 2025 14:34:29 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] mbuf: enable to be compiled with MSVC
Message-ID: <20250210143429.5ec26d17@hermes.local>
In-Reply-To: <1739224265-4158-1-git-send-email-andremue@linux.microsoft.com>
References: <1739224265-4158-1-git-send-email-andremue@linux.microsoft.com>
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

On Mon, 10 Feb 2025 13:51:05 -0800
Andre Muezerie <andremue@linux.microsoft.com> wrote:

> Now that the issues preventing this lib from be compiled with MSVC
> are fixed it can be included in the compilation.
> 
> The "net" library will automatically get compiled as well as it
> has a dependency on "mbuf" which will now get fulfilled.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---

Getting close to building test-pmd on Windows?

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
