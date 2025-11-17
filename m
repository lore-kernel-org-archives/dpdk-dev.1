Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839F0CEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 18:01:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAE5D402C6;
	Mon, 17 Nov 2025 19:01:30 +0100 (CET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id CF13C402A0
 for <dev@dpdk.org>; Mon, 17 Nov 2025 19:01:29 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-298250d7769so30809465ad.0
 for <dev@dpdk.org>; Mon, 17 Nov 2025 10:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763402489;
 x=1764007289; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z8qdLiuhy+TEQfRn1Swk4dreSXPltBN1+clgBJM7VYI=;
 b=nYjhVQKsN4vzfwjbSUphffS6K1k1pjdS6rWL7lXyIOZe+PoSJ8GJyb6aD1bNX/ocSJ
 PDBnjxYovcsb17Em7Nv85kVFcBgd3AtPXuCoIdFLHMbImkNt7RJ0o+IeD0Ogs/opFanq
 nNFPWx5KZ77WZwV2/UNfJJPCrhLPN3fibu+IiFqGwFCmk35iNW4vIKnTsCXRDSBl968n
 BicBg9+p5sLwRdiDfNHPkI+2/CjF7s4M+/1uRKleQDw7Yid4BwSx+FKGJtlTbVJl+l8g
 smbD4HP8E96NYhEopn1u+/uFKiNOL3RjJ2xNnznXF0bqaLbx5ZO4aCVtv2FAoGWDGgJ1
 IvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763402489; x=1764007289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z8qdLiuhy+TEQfRn1Swk4dreSXPltBN1+clgBJM7VYI=;
 b=LCSkA6lQibw2DGietufL6hV/zekZuTbPsS+6CuRwVtAX5MvZYKqwFVltjfn0lJwyKu
 xZiDzbnM/GfLzXN7dCr7BQRcN+aQ02t1wuZFQvzPjDtn2z493MLm+CMPvvPv+B02rZfP
 EA+n+qB1/7Q+hVDSA8/cTfmOeRDiOrq2iQhUra+AhO7ERdJB6DwuKikAX+aMzZ+hSb86
 z4Nuk8EqlaHGy9nJNPurhuNRb/sh0xWKvB4wP6PhScGGpQiLLOS2BRwZEXuCSJX34tEQ
 JcduvD+82fgg2/rIz/z0Yhq5wmgFvXTIkiwDSMPX9U5wUPFa7MCiDuuMOtKAoOHLCbr8
 UpWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVzAVncXMS/R/nuCja4dxromzb8+ew9LZJy+WDUz44RBenrQGy5zJ4RUW04QLKK4L6n14=@dpdk.org
X-Gm-Message-State: AOJu0YySWvxPp6zLJlxtcCA9CjeaqtKoLILUCfRGbyGqo7OCLJ+vFEdp
 EjaLENf750odY8W4Fxz42wTVCsJ9acGq6Qs5VGVWIrI6TZc4ap0LNDT0ZtuwxdVNYoA=
X-Gm-Gg: ASbGncuUKadgBJkJ3wvRvqbuv6sWoDsqqfeqMYjzStDA4uPsK4ZF4OX7wN2NXvUOXXD
 lkgUKdHkTzVit01SMMy+vz5qUZLxuF6jTfC8lSYb66EHs2rsrtpkj0yEv4HVhjJsOFB5JEXZcK3
 4EQ0HZ0XtmsaCoXbfk/QIQGS4YN7WARMOJhIsNTPo0d7s7wpleg3uCiSGeS3FKmo6FE9Ps0E3qB
 8Qq/pe0hmUjk6rsuQgYdJ9Pngwiu1qHUCBQWr/SEmmhhUcJWvCuzlljayTwwN3SskBkGdTex5y8
 jde6IEIEFynoo9rCCgMnuL4YKBBYDMCvjGfem8qsFyaVoI+HJ1tLjBl+Abnt8HVuQRlynIzhxSX
 IWHougZFsznqXSz5GiyVmURs2wYUvpRxhmbhcYhc+QueUBtQ5O5SgqdfNyEV5y6iBUfaEPGf5PA
 BcmfY6xTJTtdsMsOo1LZCfNXDQ3O4VKgQMkGcZ/U808d/b
X-Google-Smtp-Source: AGHT+IFqyNx5v+18Od8M3EWtKbTh6QMF/NMCWL1QdtWtLJYraV3rwPZGNQUmWgf8Dx//+KcgsRh6uw==
X-Received: by 2002:a05:7022:922:b0:11a:4ffb:9825 with SMTP id
 a92af1059eb24-11b40e7b6admr5737743c88.6.1763402488591; 
 Mon, 17 Nov 2025 10:01:28 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11b0608861asm34146367c88.9.2025.11.17.10.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 10:01:28 -0800 (PST)
Date: Mon, 17 Nov 2025 10:01:23 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yang Xu <xu.yang3@zte.com.cn>
Cc: thomas@monjalon.net, dsosnowski@nvidia.com, viacheslavo@nvidia.com,
 bingz@nvidia.com, orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com,
 yao.chenghu@zte.com.cn, dev@dpdk.org
Subject: Re: [PATCH v2 1/1] net/mlx5: fix set port down if detect anomaly
Message-ID: <20251117100123.3cdbb741@phoenix>
In-Reply-To: <20251117091201.2261526-1-xu.yang3@zte.com.cn>
References: <20251117091201.2261526-1-xu.yang3@zte.com.cn>
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

On Mon, 17 Nov 2025 17:12:01 +0800
Yang Xu <xu.yang3@zte.com.cn> wrote:

> diff --git a/test.eml b/test.eml
> new file mode 100644
> index 0000000000..f30ef5dc8a
> --- /dev/null
> +++ b/test.eml
> @@ -0,0 +1,21 @@
> +./../dpdk-patch/0001-net-mlx5-fix-set-port-down-if-detect-anomaly.patch
> +(mbox) Adding cc: Yang Xu <xu.yang3@zte.com.cn> from line 'From: Yang Xu <xu.yang3@zte.com.cn>'
> +(body) Adding cc: Yang Xu <xu.yang3@zte.com.cn> from line 'Signed-off-by: Yang Xu <xu.yang3@zte.com.cn>'
> +Dry-OK. Log says:
> +Server: 10.5.231.43
> +MAIL FROM:<xu.yang3@zte.com.cn>
> +RCPT TO:<y>
> +RCPT TO:<xu.yang3@zte.com.cn>
> +From: Yang Xu <xu.yang3@zte.com.cn>
> +To: y
> +Cc: Yang Xu <xu.yang3@zte.com.cn>
> +Subject: [PATCH v2 1/1] net/mlx5: fix set port down if detect anomaly
> +Date: Fri, 14 Nov 2025 10:14:11 +0800
> +Message-Id: <20251114021411.3606817-1-xu.yang3@zte.com.cn>
> +X-Mailer: git-send-email 2.27.0
> +In-Reply-To: <y>
> +References: <y>
> +MIME-Version: 1.0
> +Content-Transfer-Encoding: 8bit
> +
> +Result: OK
> -- 

Bogus file, should not be in patch submission
