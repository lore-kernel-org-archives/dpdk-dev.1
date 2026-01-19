Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD560D29C4B
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 17:05:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDDD640299;
	Mon, 19 Jan 2026 18:05:28 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id B42E740297
 for <dev@dpdk.org>; Mon, 19 Jan 2026 18:05:27 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-47f3b7ef761so24791815e9.0
 for <dev@dpdk.org>; Mon, 19 Jan 2026 09:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768842327;
 x=1769447127; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZPJQ12xi/WBladO6uUm9Dk5lT4kEBac3S8PTknTiAd4=;
 b=BTevSt+hDivsfC38ZcElRBUQVVa+uwmYfaWA9zPEGB+zHQ3RFQ5AivdtxhnUDGhNOL
 Ua7x21Pg72NFJkh4C5ccJe1jjL+QGnxgTi1RqOTHBaZeQNk83rOzspsAFyDTZOYGELl0
 Nfa8L1CC+z/fLUJcDVhA1GG/ARIxjKCAdVtubLKawT24nudATqzsi44uCoYWqu92FX/u
 jNEL80rZB9HI/nUEp4dJePm4J0BroVyRIieNFShRI4O4LuM/RDpSRhevYxxqpLB5mrm0
 W3pE0UOotctNK98BJRzphhIh/NS0VZBI4+oj/XY6MtS3MYSSy3tCJS/lxwb6SA1toPH/
 YSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768842327; x=1769447127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZPJQ12xi/WBladO6uUm9Dk5lT4kEBac3S8PTknTiAd4=;
 b=TWaO81lC8vJlEcaPIs9+ncJK/uQK0F44ak71WUOR5MMStyT1xZoDFc8bQsxqvDyf4P
 IonJOHjGbhaCiqF/HW9a/wHktrDB3c10o83IWemJD33bW/5DrQsFZuinsejqCqbaZMiv
 olWYxuKBSUmNljLqGVgyxk/Mo2fFKLQ3aNZc9OnlNTXwPLewRFIdswW6SfkafY0bFbW7
 Pcboixl6f8rIYkGAQDjZtjQi6ZgnVcD2AZDnbo5QrYrSBt2mGJwa8lRnH6pDYQoUsVBS
 xI9Pz+X9n+7eVM6GDtB/bKZxun4WmmLpiTd9mY4t51JqU6FR/OLd2KQBQhdSc6LL136m
 Ydiw==
X-Gm-Message-State: AOJu0YxjSQOXgCN4B9W4tYYKsRSkWl5RYLkb5UPaV1GdO8Qk1z2obyyC
 LBh4baj05mtPb/snXDSp1FooT/hDdRIPttaApEkIbuiGnZxe4tw9g4vfPJIepIuq5YM=
X-Gm-Gg: AY/fxX4Vnd9pmzDmiu3jFu2nZrXqQrITaL2qI4rbG92WrvazASIkScDrmsUBOVB9oZf
 4DPKN2vF7uGZzF4HwOp7+Lnk42X7ouHc16gas7tCR6tlW73iCvipok5T8LuB4z/we6rqwrfKm9A
 WjcsYS+p8eu0XYXy9JFk6LKv4+W9A0dAuSA5GMKUKMTa0hesphwKfUFi/yQMmJjjTricW/WTb82
 UXT72wnTOyG9MC+WQ4k7U7XI4MhlA2CLZOcJcCfFvQ9Z23/i0P33cBPGUPwSMpZKCvSgTGNbIVS
 sI19iFyghaqYvsSMsrTrG9a6wJ//Tezd49o+Ww5tqUxxURDqy0Ds2PtIyD4Gy0Jplg/2xwDQWDI
 ivXvOf/gclmCr8/UIu+WOwlmKkWnYbDxSZP8+ZUIgoEtYarJu6YN64sgXQ/3ifVcCpAk2XaAXn4
 3iMguvdhR3JvVAiiVlfFegPBXAR0FQMFSfvyoxbaQKEm7xXf6weZuE
X-Received: by 2002:a05:600c:8208:b0:47e:e076:c7a5 with SMTP id
 5b1f17b1804b1-4801e309c76mr144000665e9.11.1768842327146; 
 Mon, 19 Jan 2026 09:05:27 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe2c2a2sm83321935e9.10.2026.01.19.09.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 09:05:26 -0800 (PST)
Date: Mon, 19 Jan 2026 09:05:20 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Radu Nicolau <radu.nicolau@intel.com>
Cc: dev@dpdk.org, nkaithakadan@marvell.com, kai.ji@intel.com,
 anoobj@marvell.com, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>
Subject: Re: [PATCH v2 2/2] test/crypto: add tests for 256-NxA4/5/6 algorithms
Message-ID: <20260119090520.2442bf56@phoenix.local>
In-Reply-To: <20260119113000.2176714-2-radu.nicolau@intel.com>
References: <20260107105649.1708347-1-radu.nicolau@intel.com>
 <20260119113000.2176714-1-radu.nicolau@intel.com>
 <20260119113000.2176714-2-radu.nicolau@intel.com>
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

On Mon, 19 Jan 2026 11:28:56 +0000
Radu Nicolau <radu.nicolau@intel.com> wrote:

> +struct nxa_256_test_data nea4_test_1 = {
> +	.key = {
> +		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +	},
> +	.iv = {
> +		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +	},

Could all these test vectors be declared static and const to avoid
any possibility of link mixups and corruption by crypto.
