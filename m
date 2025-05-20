Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708C1C54E65
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 15:06:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33FBC4069D;
	Tue, 20 May 2025 17:06:31 +0200 (CEST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 0E72A402AE
 for <dev@dpdk.org>; Tue, 20 May 2025 17:06:30 +0200 (CEST)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-442ea95f738so47448085e9.3
 for <dev@dpdk.org>; Tue, 20 May 2025 08:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1747753589;
 x=1748358389; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=grZriWFVVoNu5R6t6V0t5y0CspsUBpNgQqSrmPVt26Q=;
 b=bzSs3P787c3Nhv1Tzj0X76WZnmAEkscctXPQOl+CsT7vOcWSHCH45jQaNC95OPss/f
 suP6mQvjlLzPoKg/0DDeu6Ult+2LM5gRfc4+aU9DIyaRc9EaZQEx6CztTNE8J1GTU2Wk
 hMHJNubPqk/cybHff4Ovwti++vnNP4c21hvRCZMy1MjgxhzgJK0+N7Y4SukHtMZcn0pj
 hYqBnphLP3tibNnbsH9kDzMsTZ5hRVX76UbxRt7UUvbs5rXYOE8cSRIX2mwhg4dmWeZ2
 3aJGcL40cZJ/DhZEO9GMHWtd/Z1zVuayRLQ1uNixdidCVoSXZk2ZrXZCmzPj3u4Xbrzl
 eW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747753589; x=1748358389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=grZriWFVVoNu5R6t6V0t5y0CspsUBpNgQqSrmPVt26Q=;
 b=N9Y1gNZsM4bKMjXD8L6tjktzooqj56ylEjdQ+iKZjcjFppXYO1EUWxlmHbx67E5GzN
 AefZUNH3/DvcvrgT7/1w122F5NIFvuFiQ2GLhI7qqaBg63XpwCuZKSVP42rTN0+wR7Ey
 kQOg+jW4PBC0il/KQL9OS9jMWsXUGSIwLoTdc+XtzgK78Xj+G8jhrNHLU9nA9UaV9z4I
 f6iIiOcyw2o49BdtUQFqFScBEQcc534Y1uG6sWQV5wtpapIOyHqNUgIh2v+vHGN+1IIQ
 kOj9G5ZZNIgynox34r8GorbGr9XoxCOLCV+iOkVULsy1g+3NaUljLjyyxUrhmMxcusjV
 uFyA==
X-Gm-Message-State: AOJu0YywQko6UO3vQNObd00yfk4mrCyzi0co/LDNWMwfN/dIXtmcwH9y
 9lnMvm51esre4Tl4hppU3ZkytUvOW+i5jpZyeYbN0oQiP+/S1jOkJh6tLqtun7Ys2/wIgqTxZde
 xU+Z0qOM=
X-Gm-Gg: ASbGncuPDiJHpBRQ/11QIptoEUKAunJuL3XvJgOS+BSAZtJdF3tmxtm14x3R38vlFAT
 aU83KeKJMkzL4i56Sh1CDqFdZ60qEnhgdujyGpE8Lw6GSCaqfep++9sz12OZszBOEH/syHGCBGu
 cu3GOl0CRD5UhAxX9DwXU5zPVjq8pmO+esnOoQOgGfXkb1dfUyo1VmXQkFr7GNUjPrDTTc3SFEs
 zj65Mp9ADsPzIVYFDvavUvhMjWBUReJL1/WwcjDZHcZhJ1Ie/V1AcIPywoWpTqlmRfaMz3+Hxfi
 0pwJcQKhsMu6lCYiitSsLiNEn0/Mo3NVrzmrsYWmKs2Nz5FPCjm+uQbzmVma0gpsa8dVSXQJVDo
 dnu0WzDJCsW3Uwt3Xdsvf4LqCIo3i
X-Google-Smtp-Source: AGHT+IHTfyv1eQNv5JLVX7LJnlEmAKESeH47hs9sVQhqi5FWLYmeMqh5aTRXurQUZfVcPoykaBX4sw==
X-Received: by 2002:a05:600c:1c0a:b0:442:e03b:589d with SMTP id
 5b1f17b1804b1-442fd665745mr139220665e9.24.1747753589180; 
 Tue, 20 May 2025 08:06:29 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6f04334sm32966515e9.10.2025.05.20.08.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 08:06:28 -0700 (PDT)
Date: Tue, 20 May 2025 08:06:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kyo Liu <kyo.liu@nebula-matrix.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 1/1] net/nbl add doc and minimun nbl build framework
Message-ID: <20250520080619.0718a950@hermes.local>
In-Reply-To: <20250424114919.10349-1-kyo.liu@nebula-matrix.com>
References: <20250424114919.10349-1-kyo.liu@nebula-matrix.com>
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

On Thu, 24 Apr 2025 11:49:19 +0000
Kyo Liu <kyo.liu@nebula-matrix.com> wrote:

> Signed-off-by: Kyo Liu <kyo.liu@nebula-matrix.com>

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9b8bb60023..4cf891a312 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1020,6 +1020,15 @@ F: drivers/net/sfc/
>  F: doc/guides/nics/sfc_efx.rst
>  F: doc/guides/nics/features/sfc.ini
>  
> +nebulamatrix nbl

Pleas capitalize the company name.

> +M: Dimon Zhao <dimon.zhao@nebula-matrix.com>
> +M: Kyo Liu<kyo.liu@nebula-matrix.com>
> +M: Leon Yu <leon.yu@nebula-matrix.com>
> +M: Sam Chen <sam.chen@nebula-matrix.com>
> +F: drivers/net/nbl
> +F: doc/guides/nics/nbl.rst
> +F: doc/guides/nics/features/nbl.ini
> +
>  Wangxun ngbe
>  M: Jiawen Wu <jiawenwu@trustnetic.com>
>  F: drivers/net/ngbe/


Good start, but you need to submit the full series of patches
for the driver before it can be reasonably reviewed.
