Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D33CE8D6B
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 17:58:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEA0F402A7;
	Mon, 17 Nov 2025 18:58:47 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 52814402A0
 for <dev@dpdk.org>; Mon, 17 Nov 2025 18:58:46 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-297dc3e299bso44782455ad.1
 for <dev@dpdk.org>; Mon, 17 Nov 2025 09:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763402325;
 x=1764007125; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RUPNEnFwEozEWXrI9qk5qYjf3l3rCWUYEFVya2NBDR0=;
 b=XOsKIIrQS8XZI8VF+rZDYCfZ2gyHRifBUhgi0gVreIReJ8QLibE/gwFZH3d5KGXxRH
 SEkbf+m/Go3EmN3i9IkTEnBX40iGVPdqWjScdX1vsiF/9eM7sJg9DAumpePDFzPnrMLx
 LY8czKn0DPsku9eGXFvhJJTyfklJd34B7SQ9tNzQ/Fw1unvjANbawMDxo+f4Q698eEf8
 cSQNL8ZNGXDPnA8KvbUyFxzZqwVfPghkjQu7KNQElT08NBnwAoRGyaGteolCU3wVJi7q
 MJPKuVFod4BBjvlTCgBNmWUAZ6LXLzfbcOwC0TyZwngfKK0gLAjT1Si+0q2L1mEXCD1P
 T6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763402325; x=1764007125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RUPNEnFwEozEWXrI9qk5qYjf3l3rCWUYEFVya2NBDR0=;
 b=I76cz4t87VUyNQoxh8A7lh1cllTbv69xbXqtmHuIBf0b+8if87spJGdhz4k+V9NKnl
 GckCXMwdBll12T9rsLifYix488mNtr4SqzMpWVCzReBHNwXUbyJVZlfUZVrIua7p70Pu
 RhKv4WY6mC5ln4Fc1+Q6bNHxH16Cn5NCzAz09vtQtI6dyipoXkXfCqVdOaDlFxmpPwnb
 Hr26F8pl54V2+rUIfakII4LsqI6Y6LR26ckLYFUcrn/ytoU8BAK6AfXxVZucJGSO+iCk
 n9nG/9KVcOofj2ymwNj+ZCPPdbHfxGbj1TxDA9pNUusG/aCGu4Tevmke3uW9O3hmUm1z
 8aGA==
X-Gm-Message-State: AOJu0Yz7uf+rrcw+zXFdgRgx4xKDWdYKBDJE5wTWbbEvvhen8MB62wFa
 IeCy36NK37R6SshHTs6iiKsvJIk9uvfG8kR0MW4M5GUGvzFO0106vSCORGUQu7OfHNk=
X-Gm-Gg: ASbGnctWfCxtk+6glO8fblc/5q9riMzVBAMwfq/dT+K8vdCsVVpe19xxnG7zAvr3X9a
 /jzbLRvHwR1NpOBAl6W1xV7/PWy7rs12pCa56nrmy881o5zI7RK2hIvbksqpYnd1shx00C04/iL
 QnjeFgIcuG6miDYeOKCvbE66XmAhKTsibkBFu9AEfLhJZ3ncHWZTnaVQZrD53S1PeFwEh+MxMf3
 NmIXK0JNLKzBVi9RkVZnZzcIw6T209fzkpHPzPibtBjiw5Q0w7XTQawGAXP0odC2J9BgsJMX3rV
 6+URyWWH+ZvZHdtS6duN7iUSRN7vocnmAPWvKipTLVZYKx69C6IWvfhWpFPmsby18yRwEkjcIDi
 u/9/xhvgHXH47OhohR+C+0vcVvkQwE7m6Di5jUvZSCjolkJFoVdMCQyi69jCtf+Ly84LRa0xYqU
 ouB8IwxqPpG7Qk6UJFU/cVnJwGr+3xcMtDVMA/RSLa2Y8B
X-Google-Smtp-Source: AGHT+IGfzFyqJjGahEbrvNYw8hlou8ZB42N2GpjcRwRSh4kBgPT3e6VRwzz4RX8BQ1Sts+uuSMZvxA==
X-Received: by 2002:a05:7022:619e:b0:11b:38c:5370 with SMTP id
 a92af1059eb24-11b411ff1c3mr5807323c88.20.1763402325312; 
 Mon, 17 Nov 2025 09:58:45 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11b060885e3sm49817792c88.0.2025.11.17.09.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 09:58:45 -0800 (PST)
Date: Mon, 17 Nov 2025 09:58:42 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yang Ming <mosesyyoung@gmail.com>
Cc: dev@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>
Subject: Re: [PATCH v3 1/2] net/mlx5: improve socket file path handling
Message-ID: <20251117095842.496757e5@phoenix>
In-Reply-To: <20250829144954.2576-1-mosesyyoung@gmail.com>
References: <20250321132750.4237-1-ming.1.yang@nokia-sbell.com>
 <20250829144954.2576-1-mosesyyoung@gmail.com>
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

On Fri, 29 Aug 2025 22:49:52 +0800
Yang Ming <mosesyyoung@gmail.com> wrote:

> -#define MLX5_SOCKET_PATH "/var/tmp/dpdk_net_mlx5_%d"
> +#define MLX5_SOCKET_DPATH "/var/tmp"
> +#define MLX5_SOCKET_FNAME "dpdk_net_mlx5"
>  #define MLX5_ALL_PORT_IDS 0xffff
>  
NAK - should follow current Linux defined policy for services.


    http://0pointer.net/blog/projects/tmp.html
    https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard
    https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html*
