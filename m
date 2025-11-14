Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908B9CE8D70
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 18:18:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6383440A70;
	Fri, 14 Nov 2025 19:18:21 +0100 (CET)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id 8CB9940151
 for <dev@dpdk.org>; Fri, 14 Nov 2025 19:18:19 +0100 (CET)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-7ba55660769so1078146b3a.1
 for <dev@dpdk.org>; Fri, 14 Nov 2025 10:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763144298;
 x=1763749098; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0+Em9H8JbaVtB+hMY4WoQDycq4WqzPJ/fJ4TIhjJkTs=;
 b=ZNSqnQ2SSnks542EfafG/JqwqsCDj3ghdDsmvVPnSJJ0wRe3pbk5UHmwNz2VfOQvHo
 va1/eXAmKN7V0JMxyPQoHhQM+usmsMXFO3azRnKFvrOJcimu/0VEAlSXztReLrR21E92
 HsXf3u6W03mMUS65gxyvi2urD/uFdV2+DPKRLeTVOGK7c2es0NqWmCZlJJSil+JI5zxH
 ARXmE8otcz0Fe6NszFOLXVdhcOia8WJtIIPiFLaC+5TMIUF8xEtDo1UzhZ5PnA+OUbA4
 Zq7BgJ5iIYhnjZ25XVfo7bLCFxTeM+qzBStrlHqjj3EVD2ZMg3BaGQbLX1vDf7MsAMWs
 lWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763144298; x=1763749098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0+Em9H8JbaVtB+hMY4WoQDycq4WqzPJ/fJ4TIhjJkTs=;
 b=aza1NqWCQgWFWF3dmtSLTCXVEFX3g5cw7KfnDUnaROr/p39EE8cnMEReKuAQ6ityuX
 +W91VC6/yx8yzpL/8XvLx8iqoqeYPZTejP6qodTDH/GCNtCgjAF/6M9QGDvPGOqiRsL0
 j9gdQcu2gJjt5I3vKRT7W1wCgkbbVzWIrqc1J/YOhHWONA4sHia8du0upg1EWjCOvXZz
 GUf5G1sWX5ZiE/n7i3qlut7z3XhE1LD7iGUI2qRrdVnBqFwNpQG81daSEDW9ro8N39ry
 3NSYn/5gBroXnZgEfbIYYwOcoT5GaN80m9O2GZcq+OAMZkQLVwQM8uUZB3kxFNIFJi+Y
 jO0A==
X-Gm-Message-State: AOJu0Yyu6ePbyvaL5x0uvQRcZfZOMe2UN0u/fvnNHy+pYR62AEIn+h8N
 fktJ/DsJ7FWZMRJwzP6n0I8DQVN93FwM8THvsz+yJOzRiELoxNQQsKh4ANZdf3poqFA=
X-Gm-Gg: ASbGncvxaHetJGgXSU1EhcWAMMDH6xcP8WYbMQJumYQ/FirX0vIOPviJOtcym+IqfDP
 mgHFYyXPR5UjYtpNFpnTdq5aEG/cHz5/q+XKp7YbBChPu5LraWaM7XvyuXLuusEONRpGAn0qTvY
 oX9Bl9OQ0af7Xoivb9iN/GYtpBBCf0YV8l5c69/JDQJygMx0SfbZEt+H/OFQknkXn0flgUk0fvH
 uf8rX9b3MJHQR0q8gSpkERaQvGcMzgmSd/EAtKzyusDu4Qr6Glzvba3ceomF7yeEXwmRJgbmE+U
 s9iI4OQJcndtYE8iQQjYiO/wrX3TvzgcNUaP1q3XcrmMaiBkmU7ltaoBAsPV2Bb7QGxlEnwyFpM
 ryeCFA0r/C21/w3amWcf5GCbB1SPf1A+66mP1EDG7VqnhzQYr64wF79MJA8ynwiTlDWq6+69H0D
 s1wH4YgcNF2vADAwAqxSMQiYTi5p0EhBw66mK4016jlD+H
X-Google-Smtp-Source: AGHT+IFA3khPjRs2QUtvy7P/dVEVY/oYBbXQJS+q+Z0gWbQBuH27KqPM/+YzgdqR7A3lg2zFrD7gxA==
X-Received: by 2002:a05:7022:3b85:b0:119:e56b:91d9 with SMTP id
 a92af1059eb24-11b40f98615mr1362809c88.10.1763144298420; 
 Fri, 14 Nov 2025 10:18:18 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11b060885eesm12127479c88.1.2025.11.14.10.18.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 10:18:18 -0800 (PST)
Date: Fri, 14 Nov 2025 10:18:13 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, Tyler
 Retzlaff <roretzla@linux.microsoft.com>, Dmitry Kozlyuk
 <dmitry.kozliuk@gmail.com>
Subject: Re: [PATCH v2 04/19] vfio: make all functions internal
Message-ID: <20251114101813.453550ac@phoenix>
In-Reply-To: <c32da3e93a0e093e4aaf2f7ec68202cdbb2140c4.1763142008.git.anatoly.burakov@intel.com>
References: <cover.1763142007.git.anatoly.burakov@intel.com>
 <c32da3e93a0e093e4aaf2f7ec68202cdbb2140c4.1763142008.git.anatoly.burakov@intel.com>
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

On Fri, 14 Nov 2025 17:40:14 +0000
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> The VFIO API is an externally exported API because the original intent was
> to offer DMA mapping facilities to applications. However, practical usage
> of this API seems to be centered around drivers, so keeping this API
> exported to applications only creates needless API/ABI stability surface
> that has no added value.
> 
> Make the entire VFIO API internal-only and visible only to drivers.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

Rename the functions maybe to avoid issues?
