Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D8BD3B7E2
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Dec 2025 19:09:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2587A4060F;
	Mon,  8 Dec 2025 20:09:29 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id BBE3640395
 for <dev@dpdk.org>; Mon,  8 Dec 2025 20:09:27 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so41961135e9.1
 for <dev@dpdk.org>; Mon, 08 Dec 2025 11:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765220967;
 x=1765825767; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+8WphyRB8wGC2FwL7FPpP5PCLorAqU19jWGlBr+ETRg=;
 b=Ejg56M4j0u5waW9I+r3aUe/tZ9lXRc7Z9q+3XZnhzdFo+XCasW0icnqU8Pul12dS1g
 9ei5sD2t3Y3+9qx+PeV/3utS1tYHLHebx6SRad4qzvini92NKJnxChxR/LEwr1WebGSf
 FnIKc15NsouePpXWVHr8Vv5Oa6XQVw5tbasJM9eRMbMHh7XkFi9zhH5JA9+5pltkJiaQ
 8SzaJCMuPmqfXt6A9FTZC/9+cfiKQrHaoXTj2UKviWJ/gjCRhMTz1JW/J4tYoF/msWYh
 A8y9WtiwosS1VIR3kWvvYPX+f1F42C3lAZpXrVxhyCJ/XtOwfCkUpvkWjj/hxsZNoTw7
 Fwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765220967; x=1765825767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+8WphyRB8wGC2FwL7FPpP5PCLorAqU19jWGlBr+ETRg=;
 b=n+JujiCMlxGbFj17zZYncESeIqXRwxb8u+wfHRVrlZnKN/cIYuTa90u6OEVN3UzU0Z
 IfNcPWnrhaaK2uYlvOfzxPoLhfJ1+Pbgfk2EWKYF0sKNPreks+wjSq/vmzCItrrJV0o4
 94aDBaTECZxyuEM3AWXYkyDrf4rsfEVhtJqR2zH3Xtnsgc5rXRM2pGHBz5CKkFEC74aw
 IDjft9d1ejUKDgFZBiwIu3hZpHWV1nmx9/GBXXzenJEovhStuxYwBHDhAxcpAa3qz0jt
 g7UYAZmJTCVGaheXGN72d/RU35SmOsj6eOiN7mTgOQS0YT54tXcPeb8i8QR6CiiBENwr
 uVlw==
X-Gm-Message-State: AOJu0YyaTs/s3KFQ2aek12le0aB7tLa6SLNDm0GhwJ/JfbdsMK69ypEE
 fEVzcoAuJdD1MEslQ4KvkI39nnraZRoZSh+XSt/LlRd6EteUdwBoTU44bx8fJgwQMiQ=
X-Gm-Gg: ASbGncsZ/dP1WzlInDzrzeKByuIOILM4csLsLIQlsA+T0SlWYLmOZ48mlNkZfaLXMH7
 HHh4rxDNXzQJi1s1D7tDSyQ4g2p1Gx1hiMvRYL9DqM/siLpEaBirPRD+fQh158KfINopf+7lgch
 k0Jdyfr1m5Sru+sYCbDIeMx4pVRQZ7E+Gc5pw9aQFqDNa/wE2TRg2rCH1qHc+1f7Y+r9v1agdx5
 7NcXOLch21u7FX6lIekrkPGu5RCxIw8OMKYZuJDH1a68aOjhCzXyW3Wc3mA1l08+cXyVVLcTnE5
 Bj2sGW026mj3SktrMi8YeuwT7zaUInWgyKZP1hqZgW5EDwoIeE5em2KjQTEr9M0R0breldI2zVk
 6q06LxBGCioPeJfbP4vuzhallz7EZBk1NH2HvX8WG3upAdyxAPGv7ESNiPfwvimftXZoglj6rgG
 aXz/YXznuYlO//p8NG0GqvGHDXSnyvUNJJFlYcPK7ftSt9rXqbcJ51
X-Google-Smtp-Source: AGHT+IE6DLUN4F7kRZc6c1iHfx9YgEr1PZWp4Wr3HS/FXspX7VMfbuUdfHlRK9P6KYWwY5pHp0RIEg==
X-Received: by 2002:a05:600c:4446:b0:477:b0b9:3131 with SMTP id
 5b1f17b1804b1-47939df7d12mr94386205e9.8.1765220967135; 
 Mon, 08 Dec 2025 11:09:27 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7d66803esm650075e9.10.2025.12.08.11.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 11:09:26 -0800 (PST)
Date: Mon, 8 Dec 2025 11:09:22 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 05/11] eal: add internal APIs to query loaded driver
 paths
Message-ID: <20251208110922.3a442388@phoenix.local>
In-Reply-To: <20251208115245.3809624-6-bruce.richardson@intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251208115245.3809624-1-bruce.richardson@intel.com>
 <20251208115245.3809624-6-bruce.richardson@intel.com>
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

On Mon,  8 Dec 2025 11:52:39 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

>  
> +RTE_EXPORT_SYMBOL(rte_eal_driver_path_next)
> +const char *
> +rte_eal_driver_path_next(const char *start, bool cmdline_only)
> +{
> +

Shouldn't this be RTE_EXPORT_INTERNAL_SYMBOL
