Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC57C5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 14:33:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B54C42EAD;
	Tue, 10 Jun 2025 16:33:56 +0200 (CEST)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id 697DF40672
 for <dev@dpdk.org>; Tue, 10 Jun 2025 16:33:54 +0200 (CEST)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-6f0ad74483fso55612616d6.1
 for <dev@dpdk.org>; Tue, 10 Jun 2025 07:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749566033;
 x=1750170833; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F5QpOaRUzvkdiPF8d2uW4AvfpL+FQ/dMAWOHezW47E0=;
 b=O4Nj4+QECB2BOFhN371Gdm9hRdAEATgYTkJo8eZj1uAyJ5VfULbCeDW5EHr9lWUMYV
 2y+n+yxweOd6eXAm1L0hFM4kvS8ekEM4AxYE9FLfW/ayFV8b3EiH7pI9rx3AZ4Y4EIcK
 5Xn11xfQApOUsHAAA+2Ad3sU42E6lOg7aYkSnZkHUVE1dsb1CC3Ypgt3oqFPeI39xGIp
 yLz2GGln892c5LvB2x7hpJZwpp2hSchAFZYvVZSm2k3guv7JWjK3AJ6cILWW3FfKVeuS
 BD9q/v+LxqgJELfHHZ/eNE9Mhp8VzL8MOBjaUHC9W0gbBmR2lqeKgV6fHDBoB8CFbBkO
 0FCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749566033; x=1750170833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F5QpOaRUzvkdiPF8d2uW4AvfpL+FQ/dMAWOHezW47E0=;
 b=S8pMnhU5unXG4Iwu5sljWYf+2w+gpRfje3OU3zXWrN2p0Fx7TTlMYWm+TBBBE4Hw6F
 t2OZALzO4Jd7wNy8A46aO8Y5Qi9cv0VX2LErYpcYCP10WWdnMK2eCR6TiuxqoT/Y4a+H
 wRYrzb+1y+hheu+qG3V3GOUa3NNl8Ep9h0EEPgF9wZ4tBkQAn2iqTgY5koPyrdo7b9Ey
 RgN4lUnn8K3hKw+aNrrg1RWeOdu4H9SPdVme6B65RCEm7/sTp4BOYtETuuP2m9FDP56H
 VWBougmWOmxdv8/al8ZR0sNNNZ+bddaCiOV/euuDCjm32EtQMhUOZxTP1+UNdXv982i5
 206g==
X-Gm-Message-State: AOJu0YypGL+BGFYX1u155Xug1aIrIK2FoqJb5MIskoG3+YdBf2CROZLp
 0QiF2/hrzUTBwhIHl2qHoVecM0LlxgBqxlbCVYsrHjvI6zeJJQVguO8y+qoUYFhjZrU=
X-Gm-Gg: ASbGnct4EhPXPQvo6R+XDckKGMDXCmqTTvgvvYSR6wWREPtv6U/px1touanS/ABO1F+
 M6kh/hrUz7iRXApSe7AYfaRRJruPf3OJvX+CyGlUMGjQ4X9HqeEnkZLYhJ66NQxtIhQOXJ2xu+F
 16CQ9GAJFxl7oRfJVmfn3X+7G5bA8qlYucQ85Vvu3Zwowp2sKvYQAApTYM4bthrJ88sJ8+Vwqmg
 NWydiiErcc62AhIwerHeVxNKQXaE4fNdX0omV2ZtXZeuTfHS3+ySgZx/dCItQVFL4ntJywgoUjR
 FQH1RA+UjE75rZdWE4ggg0Pr4gFfOSGyqXVOrq8d9dzN4uaz5cd4sDKhcU4I+89XgShHeOG8rEN
 UGCljkIMbwpPgPSIYGOWmxDDBOs4EPORCS2NXy+M=
X-Google-Smtp-Source: AGHT+IFH2rkNq6StpMDftijTxyljyEoWMO19PwVbO/Fzeiq8UWeoH5fms7a2tjD5thPT8NOjiQw4mg==
X-Received: by 2002:a05:6214:2422:b0:6fa:c55e:873 with SMTP id
 6a1803df08f44-6fb24cabc86mr50069146d6.37.1749566028222; 
 Tue, 10 Jun 2025 07:33:48 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09ac84f7sm67157446d6.36.2025.06.10.07.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 07:33:48 -0700 (PDT)
Date: Tue, 10 Jun 2025 07:26:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Howard Wang <howard_wang@realsil.com.cn>
Cc: <dev@dpdk.org>, <pro_nic_dpdk@realtek.com>
Subject: Re: [PATCH v1 2/8] net/r8169: update HW configurations for 8125 and
 8126
Message-ID: <20250610072653.347e62d9@hermes.local>
In-Reply-To: <20250610062241.4517-3-howard_wang@realsil.com.cn>
References: <20250610062241.4517-1-howard_wang@realsil.com.cn>
 <20250610062241.4517-3-howard_wang@realsil.com.cn>
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

On Tue, 10 Jun 2025 14:22:35 +0800
Howard Wang <howard_wang@realsil.com.cn> wrote:

> Signed-off-by: Howard Wang <howard_wang@realsil.com.cn>
> ---
>  drivers/net/r8169/base/rtl8125b.c      |    4 +
>  drivers/net/r8169/base/rtl8125bp_mcu.c |  172 +--
>  drivers/net/r8169/base/rtl8125d.c      |   99 +-
>  drivers/net/r8169/base/rtl8125d_mcu.c  | 1471 ++++++++++++++++++------
>  drivers/net/r8169/base/rtl8125d_mcu.h  |    1 +
>  drivers/net/r8169/base/rtl8126a.c      |    8 +-
>  drivers/net/r8169/base/rtl8126a_mcu.c  |  888 ++++++++------
>  drivers/net/r8169/r8169_hw.h           |    6 +-
>  8 files changed, 1791 insertions(+), 858 deletions(-)

Please add a little more info to the commit log.
Checkpatch wants a commit description and if there
was a problem it would help the next person looking at this commit.
