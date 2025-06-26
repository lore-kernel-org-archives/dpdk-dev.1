Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE59C7EE31
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 14:10:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14A5A40287;
	Thu, 26 Jun 2025 16:10:27 +0200 (CEST)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7062A40156
 for <dev@dpdk.org>; Thu, 26 Jun 2025 16:10:25 +0200 (CEST)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-748ece799bdso794129b3a.1
 for <dev@dpdk.org>; Thu, 26 Jun 2025 07:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750947024;
 x=1751551824; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lWpWVEmFCxOn+q+PRrNamAuYcCeRYte4gy64Qi33YPw=;
 b=f3uMO7Dfh9HFsRmXUW9SmD0zYdqz08qF7p1SyPuaE4ocznEvHTZgBU2AMZI2efTaA8
 yi2nxh7RecawnfaT0PEZ86IOCspspGJvgygnYg3Slx+Am+zudbHFH7307aM5DhxgvdHu
 Z1Et6XN5L5uA3/DqjBxU9MuwCDJAMwGvtonQfaN45msbDTA9t2NVMBzOsh31WEC7++VN
 xo/de6Ey1e+FoN8GEsfcopyq1WEhkNB6sW18pLpNG1kyoLCUoTHSljuOgIqR0fXgTvmg
 nGLjb2cGRlugk6RwNCQTfYh/ho3duMf9Skh7bXcMWYP4ih52v771Lj15+xeXJKOtduDx
 u47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750947024; x=1751551824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lWpWVEmFCxOn+q+PRrNamAuYcCeRYte4gy64Qi33YPw=;
 b=nAf6Z83c41tMh6nPocHc1yPdLvNxPpNnKvOCGQRb4BNUE1x5qYhmywNuFjnzBb5VB1
 3bJTKSI1dtUBP4HOWud+B16RCLkdGuPtxwx/cpnQkFc3V54/3j90kMrKe0XS553qPiGz
 wlELRr0ny0JjedLEuwrB1hnnhn02Z9+WGodvEhvYuWo5dXDTTvTDLhnwrffK8ZaNuRnY
 SBONSN6ttDemsHjTPOaOpVrUOWDKLpneVKxIUayJvURmw+voKXycEXX9CQn3P8TM8pfc
 bViR4IhvB9jo7fuHofaj2h9f6YgG6u5c1nLS58jZfCEPSQx6O+ZQsc0/lb4qkaYar34T
 w2Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvEmVLr/UO3H1jlY19LKdg0iI5rgfDaYWZYXpviJ3kjOALnKjPtWKR/hIyecU5sWS5XYM=@dpdk.org
X-Gm-Message-State: AOJu0YyeUAliX7XMaF4PJRLKPR+Rx+WOKYX4NiM+8iZRP8O7+TJ3/kdb
 kiD8njkBzkvCxowA040a6RnbT0+FdHWpLsR/SvDyWFcloqoU3Fu0cLofIaP/KbbYvd0=
X-Gm-Gg: ASbGncuwoblPFTfAJ9Jn7Q1bbE19X8G8n/8xZtyXA9fa+ec/nprkaWtzCbiavKePo7g
 cSVgRB1Ptw9RSTrk/CTNO6Uhle7Bmy3/aWwr0VSYxKNlin2cl9sVHquMtTnVZyiryJA2J5CBaJK
 nci+neQMBHHu9Qb+YamYUFLWov7lDTZanD5i5mBPV+SfnyicRC6XjFr7H7MVR+/MOY9EZoliZvz
 PPm9PoXjn3Qpz8KvG8FOhkbSzILdPfqCTf5RcpLOAxuMq9mA/zCSH7hSVhQwFMksTK5nTelRRGO
 e0YN6TxE5wmKEkk7SIxtmDNVTCbwYHjYcjCdrYN2qPDYTChTjPA1R2zG/QL5bCB7p9HrotuvAR4
 +8KefYH8A49KbOnE7D9rh9zKPqPJ6sNXd5IZOOFQ=
X-Google-Smtp-Source: AGHT+IGFyydtmdby/rC23yZIawPnrgENLxh9sl5pJECq8cIT7ZbT6aCch47ZHMYF3HHfFmAFDO60NA==
X-Received: by 2002:a05:6a20:cc0a:b0:220:96:11f6 with SMTP id
 adf61e73a8af0-2207f31b70cmr9812471637.37.1750947024438; 
 Thu, 26 Jun 2025 07:10:24 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749b5e09b1dsm7009911b3a.31.2025.06.26.07.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 07:10:24 -0700 (PDT)
Date: Thu, 26 Jun 2025 07:10:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Jasper Tran O'Leary" <jtranoleary@google.com>
Cc: joshwash@google.com, dev@dpdk.org
Subject: Re: [PATCH] net/gve: support gve driver on FreeBSD
Message-ID: <20250626071022.232b146b@hermes.local>
In-Reply-To: <20250625182751.1936925-1-jtranoleary@google.com>
References: <20250625182751.1936925-1-jtranoleary@google.com>
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

On Wed, 25 Jun 2025 18:27:51 +0000
"Jasper Tran O'Leary" <jtranoleary@google.com> wrote:

> This commit adds small changes so that the gve driver can build when
> FreeBSD is the host operating system.
> 
> Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
> ---

Looks good, fix the feedback and resubmit.
