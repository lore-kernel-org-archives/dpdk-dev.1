Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B352FE92FE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 22:07:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC1A7402B3;
	Mon, 29 Dec 2025 23:07:44 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 634BA4025A
 for <dev@dpdk.org>; Mon, 29 Dec 2025 23:07:43 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so60766505e9.0
 for <dev@dpdk.org>; Mon, 29 Dec 2025 14:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767046063;
 x=1767650863; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tk9/I8BcSV6kfK6QeqYN1WAIKwkr/1+qGFk53vo/I9E=;
 b=iweccfLVI6BnpyrpJVQzfq1djLoiN5G2IP6EJ6DMKTwWnsZrYiLC2njwMFT7Ms9Fn6
 2uOxZeiaSZVy35juKnYAMbTPIUgLLB2MFJ5QCeaFp6/Bl20YmpP9jJX8ka1tF8+9JGVr
 +iAXXtp+RQ4qIWioR4QCH2fi48sa8YcHxCCQ/mjNFa6nmum8TnWg2r0V5VitT9zpOcrz
 OwlUxA9grvTGsCrxfR+5Ag/BvgVQqeFT4/XNghS6eTOpcqYLiE038Fq46td4Fou2PysF
 Ev0GpL62glp+tHxURDEYbmMtTCA3/pi9XoURe7bDj4rkjTtOXa1zZnZCK81pMUodzhIf
 LAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767046063; x=1767650863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tk9/I8BcSV6kfK6QeqYN1WAIKwkr/1+qGFk53vo/I9E=;
 b=SATyIhf+rVOFR00ovZ0Qct3978wKha0jQNWdo0IZBS469SF/icJ76lCsvQnUzNIyya
 PsFvm8yLgJRaW07oxATdzsuCHv0bijNGiQzelFFNvM5O5WW5G0Dv3d7wo+2+JczPXasL
 t4EJ5MlkPbcpUeY16Z9QgkBMoxw1rvF2d1rQkT2uzLDH0F+SBHWRe/bZg4pcvwFx+xGq
 w1LwAlGWAPY5T0i8R1mwfiF/OeDqtSvxpvzFfw9KfI31kv4Gzwf/n15b8HVtO/8NwyGX
 4vbbL+JWUesAKiM8Stew7eYv/3xQkoDSCCj48mmBRLAJoBK3PluQW/RYiW8qdCpnWAN1
 2ycg==
X-Gm-Message-State: AOJu0Yz6WeR69BF9EgJUACprQQF9+gjzW6/URvW92lFA3gBVFjwOcgXJ
 clc5ok6fQG2XW8/uLtsKpbFbuklIbSM4JCvXw6G8uHWqigBAb+U8qqpCaGtm7jpWv5U8897wTNO
 bL/7CtcU=
X-Gm-Gg: AY/fxX4TH23q/ENdZnmE1al7+k1rnKT1r7WuXNJ00attQ1ywhawgObmc1KHdlMDs7ea
 qOsQYYpLuWVZl17PuppGjWVGk3WVvql7mNHxhUKJ33rMGgrZu4ggV2YG+J+KFO59FvGbN1/MleJ
 h1D8vCuAoNThFxggq0Z6ECoLgskeQlD9sIJpLUm12F3ojqmm+OIR734Hz3qiKxb6eUdoWMlhx9b
 K+iEFmabfzKAFBEZCHyPq4uryT6zoOMKscV0tJVmHb3RchsQh3SfqNZeuIU5MoGp4/05LE9Nvh6
 WZupLrtGcmVu5pWTndExpTI7ntFCIe0IJs8HwPTINLGBACrig19nYjn6geDyJLzRFPp7ZfZwkXw
 8+NSA2BRODai0IYmFZxp5Jq6Z8Vcig2PLDNhDT2WFZbzMIs2Iy2g2m2RmYlm3h90iGnQBVs50W0
 OA76lQp3DMmxakwGT3JotUYLw2nghXlcg02vJUqpFldToTP4cK7iAO
X-Google-Smtp-Source: AGHT+IGnWLk0o5xmDkCxx6Lx7gjHUPjNDRArogFqFk24gVY9XtaF7L10Udrfzb+cKmesdD5frQOrCQ==
X-Received: by 2002:a05:600c:4fce:b0:477:9a28:b09a with SMTP id
 5b1f17b1804b1-47d194c5bffmr328023215e9.0.1767046062830; 
 Mon, 29 Dec 2025 14:07:42 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be279c637sm585578555e9.11.2025.12.29.14.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 14:07:42 -0800 (PST)
Date: Mon, 29 Dec 2025 14:07:37 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Yipeng Wang <yipeng1.wang@intel.com>, Sameh Gobriel
 <sameh.gobriel@intel.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v2] test: skip hash tests from other CPU
Message-ID: <20251229140737.6bed7d22@phoenix.local>
In-Reply-To: <20251205213646.293166-1-stephen@networkplumber.org>
References: <20251205002536.192437-1-stephen@networkplumber.org>
 <20251205213646.293166-1-stephen@networkplumber.org>
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

On Fri,  5 Dec 2025 13:36:46 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> When running hash tests there are lots of warnings about
> unsupported CRC32 algorithm requested. This because on x86
> it is requesting ARM algorithm and vice/versa. The fallback
> is already tested elsewhere, so can be skipped.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Recheck-request: iol-unit-amd64-testing
