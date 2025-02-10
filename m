Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD1CC0219E
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 17:04:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57367427B2;
	Mon, 10 Feb 2025 18:04:11 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 3F774427A0
 for <dev@dpdk.org>; Mon, 10 Feb 2025 18:04:10 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-21f464b9a27so76078035ad.1
 for <dev@dpdk.org>; Mon, 10 Feb 2025 09:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739207049;
 x=1739811849; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WwmN6FFYO/Z21n0e3hu6x+udrqVQrFGOiu9uP02gRjM=;
 b=UKahmc6/fJDaeGdiyjrU6t8x4WsbDY5rKIiqAzCGMmSdfv1gp9NOqqSWOovn5hi2wS
 dq+83Pa46deUJ4ZeBDqAgK0YvvEH6lN2byUXSIGphpXHGJtTmnD4uhPwgBIhf7r7JEjv
 doHu6VZAgmzPqopSBvOOJ03REow8e6lwhPfJfESFLVHmwrczphNVQZCtqG7ze+K+kj4D
 1+HUFLWYMjmMWj8XjLDKeVocLXmkazNUgOQzEfd9hXoHxbTppsBnHiO0QLTzLsZzzp9T
 Jm1yvRxtXyj8PkpddWcoR3RJFD8ybH5Is38Fkbntg1HWHWv/cHqr3Wzu1RjuL1NTNAnp
 DPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739207049; x=1739811849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WwmN6FFYO/Z21n0e3hu6x+udrqVQrFGOiu9uP02gRjM=;
 b=s9McdLXltZhhgp92o2NLn5MTU4yObVOuKyjcSxy8UoYus1hd0eRszPcQ1cQv4qRni0
 O8QP9ZoeLZ0wGuX2J8eRQUnw6FoPw8lG+HMxCPfNZOvxfMGGLhZFFHzJdbtyeqXO+h4/
 ZH33P/zP2yBO2TMDkeg99x4nN6jxqakJ+9osta4VOoVEtVKR0tTAz3JIlZXKk2B3W0GJ
 8To+AEdH01mZtoQuiaQYvkVi/KHEon3TFdXwL9QAkA/SIyGR60yK6CHME3sVij5/UPlT
 zz0KAD8KWA36YTyRzzBkVbpZMA4AJknj/Nk+xoVCfv+/2WBp9ThMNVLPOxyHEcjn0CGL
 0VSw==
X-Gm-Message-State: AOJu0YzpFg7DCUK2sXfarbdr3TrGIKZGiTqO7OTJPXytpdNMGxLzzp+W
 rAfMrT156G5sP3Ybxgl0c/aK2C8DO/xuHCG+zI5pWfbzW4ssVekbh9Td+xYeTJk=
X-Gm-Gg: ASbGnctP591BdycugZOSZnNAtckxIVkBigJOhX06zTfN94h5kgVXDebZPHElHnpw7zD
 b4lrkpXA0rN2waEuKl70xJJ0VkKO7CuPSvebvCtQgkTJ8qQSrwGWDZW1qaAPZioO/Mpf6NwLWbi
 0yjwrWQp0z7mjH/Oqxhdp1tRThCIzhBMbecyurN4a99yTWPbcz7YuPasiPuA2XTSkW854WJSb+y
 I21UDP37OIlFXYCgbFDMB81+Ys1NFy3qj5QRXb55hde8ppcBB825miOZlSjTN6CqjJR9Gd1+ywK
 a4SJtxwn5XTcPu9LyJdAT3caFVnpffvlqQEupdpzKkHuG88EBIzvdONtTkeVD+GrLs+U
X-Google-Smtp-Source: AGHT+IGeLqbIrXfMe/8uUZ2DTLOiiPMOe/HCCkdDgKkS7vBhrEtFh/V7EPhDcBfTi/TR54oB6Cz+pg==
X-Received: by 2002:a05:6a00:3029:b0:724:592d:aa5f with SMTP id
 d2e1a72fcca58-7305d4ef721mr25211514b3a.19.1739207049285; 
 Mon, 10 Feb 2025 09:04:09 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-730764c4b51sm4486458b3a.55.2025.02.10.09.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 09:04:09 -0800 (PST)
Date: Mon, 10 Feb 2025 09:04:07 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gregory Etelson <getelson@nvidia.com>
Cc: <dev@dpdk.org>, =?UTF-8?B?wqA=?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, Shani Peretz <shperetz@nvidia.com>
Subject: Re: [PATCH] crypto/mlx5: log when num of segs exceed max segs
Message-ID: <20250210090407.478ae523@hermes.local>
In-Reply-To: <20250209120851.254695-1-getelson@nvidia.com>
References: <20250209120851.254695-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Sun, 9 Feb 2025 14:08:51 +0200
Gregory Etelson <getelson@nvidia.com> wrote:

> -	MLX5_ASSERT(nb_segs <=3D qp->priv->max_segs_num);
> +	if (nb_segs > qp->priv->max_segs_num) {
> +		DRV_LOG(WARNING, "Segment count exceeds limit. "
> +				"Current segments: %d, Maximum allowed: %d. "
> +				"To resolve, either increase the segment size "
> +				"or set a higher value for the devargs max_segs_num parameter.",
> +			nb_segs, qp->priv->max_segs_num);
> +		RTE_VERIFY(nb_segs <=3D qp->priv->max_segs_num);
> +		return 0;
> +	}

Way to verbose.
RTE_VERIFY never returns since it calls rte_panic().

Would it be better to just use RTE_VERIFY()?
Maybe MLX5 should have MLX5_ASSERT() and MLX5_VERIFY() macro.

Je n=E2=80=99ai fait celle-ci plus longue que parce que je n=E2=80=99ai pas=
 eu le loisir de la faire plus courte.
I have made this longer than usual because I have not had time to make it s=
horter.
