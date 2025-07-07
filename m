Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014CCC83F07
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 15:00:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31B7140287;
	Mon,  7 Jul 2025 17:00:46 +0200 (CEST)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com
 [209.85.160.51]) by mails.dpdk.org (Postfix) with ESMTP id 56C6F4025D
 for <dev@dpdk.org>; Mon,  7 Jul 2025 17:00:44 +0200 (CEST)
Received: by mail-oa1-f51.google.com with SMTP id
 586e51a60fabf-2eb5cbe41e1so2736067fac.0
 for <dev@dpdk.org>; Mon, 07 Jul 2025 08:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751900443;
 x=1752505243; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tYiGyac2XiY1UgI7YUFcWOmMeOx73PLmHwajyQQo0K8=;
 b=ePpNuGu/Oy5Rrz4ixAR0lohiomxU3RR9gktLtgde8hPK5yt1YVYyk4Nd0Kzil5a4Zt
 tyPxBDBx+o0Pv63ldqzOeOZUwWQvh94KoLjrP0vquCtUs85Ik2Ojh7/1bEV1iHlU+6wy
 3oahh8E1iH1CGKEOEtTaC+aU9AJ4dowkksRIdCfRq4gZK/dPzbC9bAiupCLrTQDURn3z
 0leiHyiYElUiNVRiQRWUhU0elVb199SSSL/6TNC8YFMbbF68rjATKk8f09bT79ulfgc9
 SRyFi8RZiK8Rfyz3R5WB8u9x2MoR89QF9CluTlZU9SDcw4sumz5C1pzOEvlTKPZqPuln
 9P3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751900443; x=1752505243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tYiGyac2XiY1UgI7YUFcWOmMeOx73PLmHwajyQQo0K8=;
 b=T7gJxg1yaxqrFAUmZQyk91OACR4KFCYmW5hgqR+pKkHrqsKLM3is1MBFio1BEvb/eS
 ESyIOek/VbrRQvJ08AZ3ydj1wtFr1viEOYq18Bj5SwdtIaVNgTAW5ENAD1cE4oKIHCEi
 XLQAafh5lF+yVlU2xOaDVuyhtNBTsWak7iWNxJzgw5PZhH03k0qt0FupQyT4Vi6rX2L7
 Rl+7wkcbLMAU6Fzs2cFqjCPmwmnyf7/QAyPFPI4UglCBF3Y9UlwM/q/XZACOi7MzDK4w
 48AKx6xOlzxzB7ohWBOC4WizVTC246ocBubWACAwifsgdGGD8jmpoXV1qVCwNYgbd1xc
 l24w==
X-Gm-Message-State: AOJu0YxrI+9iEZZ25CW50TbS5e1KLCxFeMYpI/az0p3teFvssToQsuOS
 pl/Sg+nn12+/TV+qSiEdE5lvLql7i3gkrK1oi2c6Du1jOk4YQYLyoSI03SUsm9hXUGlbvubxM3l
 jGfdi
X-Gm-Gg: ASbGnct7fmzbNBIqwY2b8wlUNWgT2MW8hmAvjP8CH9QS7A4bpOqjFWbzvNQoNwJaI4A
 B3Ha6x+Bl+1H6zkXpezIeiT7xnY8lH1Dx779RMnLcn2Aq43XGSrXC37tHmgB1pKp9AYyN4xhEUm
 xhTJg5xSq2iqKyQcYFVAwufudWCLTekx+tZm9coIhUvNyCxk/uTWXvVSqFic+c6FTq4bmo5WZZs
 5y3i6egXc7XBDXe2F8SSnNnx7jHb26I8RfuuDTIguxPtgtLjqddKpzMJkSJUPDt3/9kzpodJ3FK
 sFkExAT08X1Up6hi2Kjmuf6SXX0tIMtnvrgorKzpLmqcr6mpDrn0HcSKsLw34+ZRF+nB3Y6gx0f
 8tDvBEkEDpR0KS2H6iNs76C6+ORgzZCpONEVf1Vk=
X-Google-Smtp-Source: AGHT+IFMfV7tDg0c48/EFcRRyoGEuNFw/jVTty2Waak3IdTV+iBC41LwJo8wEEz5rsSpm/0ZubVioQ==
X-Received: by 2002:a05:620a:2682:b0:7d3:c4c7:75d6 with SMTP id
 af79cd13be357-7d5f16ecd30mr1303828785a.47.1751900424921; 
 Mon, 07 Jul 2025 08:00:24 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d5dbeb6813sm614832685a.108.2025.07.07.08.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 08:00:24 -0700 (PDT)
Date: Mon, 7 Jul 2025 08:00:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 01/14] net/sxe: add base driver directory and doc
Message-ID: <20250707080021.2f78877c@hermes.local>
In-Reply-To: <20250707115819.12826-1-liujie5@linkdatatechnology.com>
References: <20250704025401.301617-1-liujie5@linkdatatechnology.com>
 <20250707115819.12826-1-liujie5@linkdatatechnology.com>
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

On Mon,  7 Jul 2025 07:58:06 -0400
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> +Dynamic Logging Parameters
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +One may leverage EAL option "--log-level" to change default levels
> +for the log types supported by the driver. The option is used with
> +an argument typically consisting of two parts separated by a colon.
> +
> +SXE PMD provides the following log types available for control:
> +
> +- ``pmd.net.sxe.drv`` (default level is **DEBUG**)
> +
> +  Affects driver-wide messages unrelated to any particular devices.
> +
> +- ``pmd.net.sxe.init`` (default level is **DEBUG**)
> +
> +  Extra logging of the messages during PMD initialization.
> +
> +- ``pmd.net.sxe.rx`` (default level is **DEBUG**)
> +
> +  Affects rx-wide messages.
> +- ``pmd.net.sxe.tx`` (default level is **DEBUG**)
> +
> +  Affects tx-wide messages.
> +
> +------------------------------

Other drivers default to INFO or NOTICE level.
Having a default of DEBUG implies the driver is not tested enough.
