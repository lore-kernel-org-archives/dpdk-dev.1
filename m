Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A77CA0FFE
	for <dpdk-dev@archiver.kernel.org>; Sun, 31 Aug 2025 03:21:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D421C40292;
	Sun, 31 Aug 2025 05:21:57 +0200 (CEST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id 1D11640263
 for <dev@dpdk.org>; Sun, 31 Aug 2025 05:21:55 +0200 (CEST)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-4b32bbefa14so2662591cf.1
 for <dev@dpdk.org>; Sat, 30 Aug 2025 20:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756610515;
 x=1757215315; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GA+LfeJGP3ATQ/YrNRTSt2rlTNdHegiUpkkX0VnALrY=;
 b=3SYwe66RdAHBCjhSJuB4F3W/isFUJR9iz3s4tPxcSpLKKHODqlLZf+dzkEm9dKl6hv
 0vFzF8P2YYVAxTusaWDN41P9enLbE8GRgTS4e0gcd0RDNEKc+oW+BeOIaE6u3uE3wZB9
 Ye+xVyngm4l2eTNE18xn9vLBVQKbqh+1oA60zhjW0XEWWnH/ZjlPdQwgR3Wg0EBQJeKT
 hYU28VWMDoyb5g6SN9oCpg1R4Lej3u09OEHMGijIIzcydpmdjcqtyFAeRlFgdvDzuVvV
 fziifwa5sj43VS7Q5uWVc5963UcOZHjBWSblDEKTbAjI1a7oYDqUTK0szo4LqwwVH6d+
 MB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756610515; x=1757215315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GA+LfeJGP3ATQ/YrNRTSt2rlTNdHegiUpkkX0VnALrY=;
 b=R5Y3CvFvQgqRPYlFSLMCoSGlJ1ts8gdPTGV9nRGSjGnrbMS0cntp2Xalwz5HjebM6l
 9E9DCRE/YIPb/pL9vRkTd6/Z/GXp0Zv4zstQ3pmSw5B/3jgLqyJfrxMYGpFo3se4G8cn
 YxIyvPh9SmzLe9/XPPitEMvvkGGNkehwWnO8DpzE9TTA/pjmBfDtzfoI23GTA99z+QGg
 7iQSwh77ENHQdYYLh75ifK6akmpNW8FNq5rm+C4Q6SrNrhSQy5/RMqR+icaESFiuY24q
 jP3WSb2L/HVcyVzHTIep1BNOxztQtTJ3Z7o7IyEygEUwKNqgzMK9FXgniJpQ1A3S6hI3
 l0og==
X-Gm-Message-State: AOJu0YzRy379sr1Cx3+JjpNb3cRmnzVX45GeDIrwStxCiaqFcN9T7rgG
 jbLsnGPNJ12ni4aX6JW5E84jlt7Ic0tuscWO9joBT5bfoAuAR9ifnGbT8vFpkn8AipI=
X-Gm-Gg: ASbGncsK2ppFQpgD/TS5NVLGo1qwYB7r1wXqk6utDL5/2x/eX6RC8hxQJZ8T78MMEru
 6bqM5g/AKCZzvrFCDm2OJ59Dz8R2Y6SUToDKhMIIBgfSkQbmQJNW+RAsw+88OcET0221iDg4Hwg
 OTuXluB4D7CIhbeqMpJkgVP48Ey3vDe/AORaUZPdSTUXGu7ztLS4cO8dHZmmlICOVmwMupuEyba
 7ZGlEhvJEuSif4s9YZ05k07Laac2D3ppO8mDcSHhuFLI7LF9P8PPs/5NEYXg5pq49Uz5xtsH491
 Dzq6Ib27fmrQWFmuAdcHcgh+7cjjMRKY6PzK2DH//QgYSWJw4eC1JH7zLNfcMGX3MRBzyXKCnNK
 EkZx6X85YIo4Nf/I5a/dUsGjzxuNuZWk3ocARiJl1NqeRcnu7XHySxS81pEEI1veYPe2FVaVEoB
 6kZ8JzVxEZeQ==
X-Google-Smtp-Source: AGHT+IFx30k3YQb6fY7MW5yBnuJ3jrIUrBQb2UpBmh2dTLZ8xiY8As0IZllEpK1vYapL3LaxsFQ+Yg==
X-Received: by 2002:a05:622a:146:b0:4b2:9a0b:7004 with SMTP id
 d75a77b69052e-4b31d8a29c3mr41575731cf.24.1756610515192; 
 Sat, 30 Aug 2025 20:21:55 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b30b584340sm38851201cf.17.2025.08.30.20.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Aug 2025 20:21:55 -0700 (PDT)
Date: Sat, 30 Aug 2025 20:21:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Moses Young <mosesyyoung@gmail.com>
Cc: dev@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>
Subject: Re: [PATCH v3 1/2] net/mlx5: improve socket file path handling
Message-ID: <20250830202152.5d3c859e@hermes.local>
In-Reply-To: <4699661b-3c78-4be6-a743-5f02f3da7e7c@gmail.com>
References: <20250321132750.4237-1-ming.1.yang@nokia-sbell.com>
 <20250829144954.2576-1-mosesyyoung@gmail.com>
 <20250829125734.7fd3aae2@hermes.local>
 <4699661b-3c78-4be6-a743-5f02f3da7e7c@gmail.com>
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

On Sun, 31 Aug 2025 08:55:59 +0800
Moses Young <mosesyyoung@gmail.com> wrote:

> On 8/30/2025 3:57 AM, Stephen Hemminger wrote:
> > On Fri, 29 Aug 2025 22:49:52 +0800
> > Yang Ming<mosesyyoung@gmail.com> wrote:
> >  
> >> The current implementation hardcodes the socket file path to
> >> /var/tmp, which has two issues:
> >>
> >> 1. Hardcoding absolute paths is not good practice.
> >> 2. /var/tmp may not be writable in containerized or restricted
> >>     environments (e.g. when the filesystem is mounted read-only).
> >>
> >> This patch replaces the hardcoded path with a socket file name
> >> (MLX5_SOCKET_FNAME) located in the DPDK runtime directory
> >> returned by rte_eal_get_runtime_dir(). This ensures the socket
> >> file can be created in both normal and containerized
> >> environments, while maintaining uniqueness by appending the
> >> process ID.
> >>
> >> Acked-by: Dariusz Sosnowski<dsosnowski@nvidia.com>
> >>
> >> Signed-off-by: Yang Ming<mosesyyoung@gmail.com>
> >> ---  
> > Rather driver specific logging, why is there not a way in EAL log
> > library to ope a diagnostic dump.  
> 
> Hi,
> 
> Thanks for your comment. This patch is mainly an adaptation for
> our product, which runs in container environments with read-only
> filesystems. The goal is simply to remove the hard-coded /var/tmp
> path while keeping backward compatibility with existing test cases.
> 
> I agree that having a generic EAL facility for diagnostic dumps
> would make sense in the longer term. However, I believe such
> further development should be handled by the mlx5 driver
> maintainers (Mellanox/NVIDIA), while this patch focuses only on
> the immediate portability fix.
> 
> Brs,
> Yang Ming

The point is other drivers have the same container problem.
And would be good to follow conventions that containers impose.
