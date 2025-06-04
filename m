Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4ED7C5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 20:01:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACD3A4029D;
	Wed,  4 Jun 2025 22:01:47 +0200 (CEST)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47]) by mails.dpdk.org (Postfix) with ESMTP id 26E9D4025D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 22:01:46 +0200 (CEST)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-6fafc79bca8so3565016d6.1
 for <dev@dpdk.org>; Wed, 04 Jun 2025 13:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749067305;
 x=1749672105; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v30mR9UUGxxOJJ5oUR8KdvAQyuefSlq6nve/LYBFgyU=;
 b=0wEX89MjuGGdAhAmkqfVjVQkrkJ+v0xqvVGU6VpQ/TSOa6kFyX1ZDPl78CKWtQNrqE
 OWo71/2BJ2Ri4DjXJi85WJyNXlRBCcmpTipov6iq5UWSH+6krN+es6Unru0Luc7PAAn5
 LJBGLBMShDSbT2dJHQ7VePBaJBtQ1E683GkLqhDejC92syyRPxTvzGlgfd+yldjE1ziY
 1i+SK25+/vD8rVmQOJgzkSbWZMpOJi/djUwTLwzpgxAie6JXNLhrW2b6vj8pmaaJbt8I
 4lUpBGcsEXNOV/E3FmFeF7/Bh66uVsQGmTryy/9CpG478NFwR81qbvA5OA8TMJIN2sgv
 3eQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749067305; x=1749672105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v30mR9UUGxxOJJ5oUR8KdvAQyuefSlq6nve/LYBFgyU=;
 b=SYmGdIlZKCT67LQAX4p2AO9eCaUugWzWEzrzxPa54BMJe/aP5cvocPgWNqG/1LJsEe
 GaxfQsG1hTE6y9fettvUPxPIbto6BE+DPTnnT/ocrNfafI6EB9WgKHrGqQQQheifUpP5
 DZsNHZ4WN+qUOrDBJv+l7RToaIp5CHot/RCC4NTv3PGFsxpcEo1GOjwjL8nput62a7DD
 e1YmIQbD2d/z2+hNaPrRWasee7MeVVWCp0ewXqNCsOHbFRe4TSlDf0oGa6uoLbZSKwk2
 kPWarmIgSPSQQ5ydfqjJfKYG70QzMyrtQFB837xKR3YsPKtIRIGuwUZnyPArZm0JC5uE
 rtEw==
X-Gm-Message-State: AOJu0YzYGzEHzwc8l1gGOgeTSuZ2FVHaa/qUF0hizjcE9wfRZMMvd8YJ
 RXO+ICUGfIaFatU6H1KCcr6hIuiSfuoTMqH41BCrVUGBIaDq3UDjfdzl7M7yyJLQ8bA=
X-Gm-Gg: ASbGncuhYwqP3Kse6RqHuFHGDP0KwyuMHKJYKajgjUdyqiDUoWPdokEenWOdndq5Edz
 1hI6pGhIkm70km4HzsQubEMzJirZhl50lPXKQcJO+Rr4YJGX+ImX2LE5Qxs58OhJQjG1Vc17HgB
 CMKCbHhD10sT92/oRFeJ8hX9lgmh48FpI/W5+R4vHXrakG4KD7e1UQG8zcEeXIN4z1Z2MqSEDZa
 NhRyrRp0sbnL8n0lS6j+g4iSqx84klAW0vFBwsYbQH208w3BATwViOCJLwLVRbHXyc2fHVix3lw
 nE63eBsyBri9xxJQCXuwvGqb3tDqnGuFfI66XPgAIbV9PPUh1G8WlJga0BTpWXuk0EKWe3/V3fv
 k1VbA0NXWoFE6z5f9l3Xobump8q0R
X-Google-Smtp-Source: AGHT+IFhVfijV7lEoiF43tnjd4qMsmrwkCUuBpz7tnbj2oNg7xy9fRmQyArS6BJRHflbUwdz9alpww==
X-Received: by 2002:ad4:4ee8:0:b0:6fa:cd9e:7fe1 with SMTP id
 6a1803df08f44-6faf7033693mr52865766d6.24.1749067305392; 
 Wed, 04 Jun 2025 13:01:45 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fac6e00cebsm104902036d6.73.2025.06.04.13.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 13:01:45 -0700 (PDT)
Date: Wed, 4 Jun 2025 13:01:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Apeksha Gupta <apeksha.gupta@nxp.com>
Subject: Re: [PATCH v2 05/11] net/dpaa2: add dpmac MC header file
Message-ID: <20250604130141.43dddd6f@hermes.local>
In-Reply-To: <20250602104041.3322164-6-g.singh@nxp.com>
References: <20250530071344.2939434-1-g.singh@nxp.com>
 <20250602104041.3322164-1-g.singh@nxp.com>
 <20250602104041.3322164-6-g.singh@nxp.com>
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

On Mon,  2 Jun 2025 16:10:35 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> From: Apeksha Gupta <apeksha.gupta@nxp.com>
> 
> This patch upgrades the MC firmware release API compatibility
> to 10.39.0. Added mc/fsl_dpmac.h file.
> 
> Signed-off-by: Apeksha Gupta <apeksha.gupta@nxp.com>
> ---
>  drivers/net/dpaa2/mc/fsl_dpmac.h | 490 +++++++++++++++++++++++++++++++
>  1 file changed, 490 insertions(+)
>  create mode 100644 drivers/net/dpaa2/mc/fsl_dpmac.h
> 
> diff --git a/drivers/net/dpaa2/mc/fsl_dpmac.h b/drivers/net/dpaa2/mc/fsl_dpmac.h
> new file mode 100644
> index 0000000000..c4f16f6113
> --- /dev/null
> +++ b/drivers/net/dpaa2/mc/fsl_dpmac.h
> @@ -0,0 +1,490 @@
> +/* Copyright 2013-2016 Freescale Semiconductor Inc.
> + * Copyright 2018-2022, 2024 NXP
> + *

File is missing required SPDX license information.
We use that instead of the older legal boilerplate style
