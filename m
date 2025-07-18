Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BB9C83F1A
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 15:20:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCA10402DB;
	Fri, 18 Jul 2025 17:20:57 +0200 (CEST)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTP id 57A0C40144
 for <dev@dpdk.org>; Fri, 18 Jul 2025 17:20:56 +0200 (CEST)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-4ab58105261so42996791cf.2
 for <dev@dpdk.org>; Fri, 18 Jul 2025 08:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752852055;
 x=1753456855; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nc6mH/rMsHyDG8mQGaDpY9ZrxAphUZaTWJMnyBOLWaA=;
 b=vmzkp4hrZM0QYZPwsRi9zPj6mQJzlzhvPcuUYctF5Zbk9wl6Cv50/rYldhy29XgNaF
 TD03+cEkO3YIcdk2uMThcI2qhshxyC+2/vmadaPeZVcAeCm3TcpC2M4d0gNZa3oNW1gN
 1KCBLr6r126GDOcnZ5oCWnp1LjgxDw+joL9lMJo0iUOD3om4M8/76XDmp8CZjfGLpohs
 B9MWcTsG3DRCCeN8qnZ3Hya3ppYkov2KTQGVbeHdxDEktNOvhO4tRmniNposDPiGObNo
 ty2f7DsqavV3rgMy4dhyTbm5XT17DLv6wi7p91j4cyUzoAUPLxCRFDalM+x1hImX/LVf
 OowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752852055; x=1753456855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nc6mH/rMsHyDG8mQGaDpY9ZrxAphUZaTWJMnyBOLWaA=;
 b=clpDeQuRZ+ipQl3456xkkr9YE50of+q/GdX7TqMdKYeIV56EW5u6cmdigxZQl6Ugdz
 TuBItGM7pEsYoEYhwdZbNsEAuPF0wW4H9Tz81ORzuO9YWD6kyUJBgFSTkvQnQvI9LQnB
 nfpsXBCu3wDhD6KxgLf0eea1YeAR707peNu58q1CIOdTOY1u/aNgBao0TtoiUqaPNckQ
 o4T1P9Mv9CIjU9/6zY2pZvXwE67A+MepIxoErJJtmBZADS3+sxJQRaFNq9+uUrAuUEeB
 cavMhPhADHw4Yp21KUlcqAkI1z3iT3JQoHr8rBUBMUTAs2//wvjhOil8HtrKV3S0xwAv
 Ad7A==
X-Gm-Message-State: AOJu0Yzn5FMf/HvfWlWBAHzWOPjwuiGGSyxUP3ad3q3fXDEpkHdjFO4y
 rChU/3RLeb8hmSOwKFd39QbxjXk+G+3Z4jo4XK9fan04qR5yMVBOtRUY6IRmKiXaa6Q=
X-Gm-Gg: ASbGncvb36/KG6dVYSBAZ2uiGnpBSofDVmMxXQ6s3UWjAji1KdGObezvh0bCgSxDpaK
 AI/+MFhOQA3qhdVMzYNERrI6QEYcJSFES3lxMojT1NgIJGfoKQMfvZYJMATwx8v2owmk1RWR/B+
 Il9X22DO/OhCMldv5aYKxeR7rg4a1D7xCg6Gn5KyDz2ylNj69rxV2Hz0i3aoxHEyAPCtBxgUsRK
 npWP+IEJYlOicAGN6xKO6UteM7c35/jT6WnhStMPe78hQxNcmea5TalZOa26EF0nIzOg5k1DhgL
 MSzGIhIHO3bz7O1qK6O4V0/jvb5yuYNOFKbHFKhbfs/BQSqF664UhcoLjcJrEUgGE051Zt880HH
 nRw1V5dE4Sj7TSd2oBtZ/FuE1Qe2qL5y44eCsFIG1HB3O76PtWwlifXITHn3fCBVaDfBz2HrOmn
 c=
X-Google-Smtp-Source: AGHT+IF99Y5yF49G7kTVDy6tpd5RmFKSr1v/XXYYZbQ0QKX5RXrtURd04nMPHsSj0BfMYAYsASxJVg==
X-Received: by 2002:a05:622a:260a:b0:4ab:7e22:8553 with SMTP id
 d75a77b69052e-4abb2ca84f4mr42816051cf.12.1752852055040; 
 Fri, 18 Jul 2025 08:20:55 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4abb4b4a544sm8098841cf.70.2025.07.18.08.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 08:20:54 -0700 (PDT)
Date: Fri, 18 Jul 2025 08:20:51 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav
 Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: Re: [PATCH 3/4] doc: rework mlx5 guide per features
Message-ID: <20250718082051.53534122@hermes.local>
In-Reply-To: <20250717220912.376503-4-thomas@monjalon.net>
References: <20250717220912.376503-1-thomas@monjalon.net>
 <20250717220912.376503-4-thomas@monjalon.net>
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

On Fri, 18 Jul 2025 00:05:43 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> The documentation for net mlx5 is reworded and re-organized.
> Design, configuration, requirements and limitations
> are grouped per features for easier reading.
> 
> New details are added, and more will come later.
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---

Fix spelling errors (found by checkpatch).
Other than that looks good.
