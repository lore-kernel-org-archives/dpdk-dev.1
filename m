Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FC6CAC598
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 21:17:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E34F0402A9;
	Tue, 16 Sep 2025 23:17:37 +0200 (CEST)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50]) by mails.dpdk.org (Postfix) with ESMTP id B5AA940288
 for <dev@dpdk.org>; Tue, 16 Sep 2025 23:17:36 +0200 (CEST)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-77623a63dc5so19006896d6.0
 for <dev@dpdk.org>; Tue, 16 Sep 2025 14:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758057456;
 x=1758662256; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GSa8eYF8iYvLZB/71jwgQvg5LDflhdic3b+G8B6XuHo=;
 b=a0PYyQMOox33UW80C49G6bTAmzlGPozo10pyGsAcwDwqmlhePfmcCeI5xWhWRgCWjM
 tELQ4gIjxfneDt0piRuNin9FuxaOHPEpOFiciHQyiL7eIwWBAh9iV1V0EdeVFzeAZsQH
 rA9+GRhc1g09pfCaeH8djfnI6CXWDL//5+tBbzu1sXIt6tAsIOKB9YO6snNLBfUer8rG
 sFgHilAMrV+Yb2RBBkX2c4sSpws/zRO9Bbxw3lJTwWyEFtI6XPXHXiOUXGGUt3n+pr8c
 9Npo5v+nf2+i5IbbZsQWCUu5ZvjEHlcWthye1W6iNPVYQ7arHyMCx0vAwNxdP1w7dfnV
 CaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758057456; x=1758662256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GSa8eYF8iYvLZB/71jwgQvg5LDflhdic3b+G8B6XuHo=;
 b=cFVr8zn9rwsEnLxHjK0AgrMVUpAuLRFHI+FIAGLESGpjpQ4GKekhVFYq2FOG0zf56r
 sHL4x8dFBAovANIX1OgYmC5lQxDysZUn715HYgUvXxP6ncjFcHq9JIeHLfU2CgCXnXia
 oYu2yySMJudLD3Gd4b8dPanz/udFd0kkm+2aB3R4whNjB5zpM0K9QAl8QhPQF5BmYLIl
 Yx3PSuXKNQb6FTPzhmm7VqkUJnCSf8VaWc9DkGmkaQENhnnoSjGqA6C4yShGVR/bPZHW
 Vx04Xa4kzjq3mx73VmJiUFh2heEQ3gzr+z+2qgBoKJymHnpsaCcMqrEDMqe526ffknVP
 DQ7g==
X-Gm-Message-State: AOJu0YwIVbtQy/omTq6Zvk01IfCnBy+BgFLuFowhI0OrPwl+LQYMLsUM
 ByVWQpCiqcnijmP3R1uppztTu9Zp4F+zspqq5jL8djP/xikdkzWL8yv0S1idsqSXmbE=
X-Gm-Gg: ASbGncsWRWu/N0sdl5n/B504+Oy30a1JD+dLxBz4BSmweSkTb75SpzuhIcZAS//eUAe
 WBoeRRlHVun+ZE8qwmqKp2FWL47cdBM0DPSTvn3XVok/l9SkfDKRFhIT8OB8YKxjsHKSKrrTffr
 h4pYxulK6kAdc91SJeW8pSjdgwE80JsOq+rVobdlrspRKiupZSXAvIq2N6Y4ZwvsVqRIFD0567d
 wxeU8rFJMFAgTpykVte2QRmC0IgClvIdv5RDfXdQfGX+Tq3JXUTkdEg7rSbMXVZoq8mdqckSHyt
 BNQMrl0s9nIg+9cII+biQoMlVriXNerKkruRjIGeidO+MiQO2s+55VzYWq8KFnoetFm4diBaBAX
 +INc/yIbTSf70/SkYYTwRTmJKb6TxX4oOrgNEwTiIH5V9YBTz7cTC0/urCwc5JRiZYR/lprFxPt
 g=
X-Google-Smtp-Source: AGHT+IHvxg1tZTb98OLXj6ZQTjh41EXYjNeDF+g/B3Gd8OTTtjcwLJxaFNPkD4ZeN4V2FCcFVqIEGg==
X-Received: by 2002:a05:6214:202b:b0:70d:6df3:9a88 with SMTP id
 6a1803df08f44-767c5060d6fmr174209356d6.56.1758057455902; 
 Tue, 16 Sep 2025 14:17:35 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-787f7ee380csm34250656d6.11.2025.09.16.14.17.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 14:17:35 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:17:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shani Peretz <shperetz@nvidia.com>
Cc: <dev@dpdk.org>, <mb@smartsharesystems.com>,
 <bruce.richardson@intel.com>, <ajit.khaparde@broadcom.com>,
 <jerinj@marvell.com>, <konstantin.v.ananyev@yandex.ru>,
 <david.marchand@redhat.com>, <maxime.coquelin@redhat.com>,
 <gakhil@marvell.com>, <viacheslavo@nvidia.com>, <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v2 1/4] mbuf: record mbuf operations history
Message-ID: <20250916141731.4e140fcf@hermes.local>
In-Reply-To: <20250916151207.556618-2-shperetz@nvidia.com>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20250916151207.556618-1-shperetz@nvidia.com>
 <20250916151207.556618-2-shperetz@nvidia.com>
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

On Tue, 16 Sep 2025 18:12:04 +0300
Shani Peretz <shperetz@nvidia.com> wrote:

> @@ -607,6 +608,9 @@ static inline struct rte_mbuf *rte_mbuf_raw_alloc(struct rte_mempool *mp)
>  	if (rte_mempool_get(mp, &ret.ptr) < 0)
>  		return NULL;
>  	__rte_mbuf_raw_sanity_check(ret.m);
> +#if RTE_MBUF_HISTORY_DEBUG
> +	rte_mbuf_history_mark(ret.m, RTE_MBUF_ALLOC);
> +#endif
>  	return ret.m;
>  }

If you made rte_mbuf_history_mark a dummy function if RTE_MBUF_HISTORY_DEBUG
was not defined, then you could remove most of the #ifdef clutter and
would get type checking on normal builds.
