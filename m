Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E085C87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 04:44:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67EC64025D;
	Mon, 11 Aug 2025 06:44:29 +0200 (CEST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id BA8EC400D5
 for <dev@dpdk.org>; Mon, 11 Aug 2025 06:44:28 +0200 (CEST)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-3b78d337dd9so2355923f8f.3
 for <dev@dpdk.org>; Sun, 10 Aug 2025 21:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754887468;
 x=1755492268; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=900Nnqux0uvRNvHLSNKFlBPX/Xv4eiZn39msap6UD5Q=;
 b=tNX0sF7z3xGVee0k3JInh3w1IWqBS5BPPCWLOLDl7tX1tTK+zYpaSTuvqTZOKQOYI1
 BUIxwLE+usyg6PaEn5sMCE1tTGC09HgDvgKbof2g8KOVc0dbMHDhvyOZnZiAZlCYc+89
 wyyEgoK9ooUur/toYSbeGsu1JtzfXKBU6wGfDZQiNMGOoRQUhhH72gAmx754f8D6z1FM
 U7SXTif3G1gZ4KQHb0/uFnLJPFQvCxVw7PvIK3XH+J/yitXGb0Ra7D/T0KSjwvlN3MnH
 IucdEUCNIXtJWI5BUrjDJ64GFyXcvlRlILDjphQP/sefhiX2BCW0GhThWDaU/l5DY183
 NqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754887468; x=1755492268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=900Nnqux0uvRNvHLSNKFlBPX/Xv4eiZn39msap6UD5Q=;
 b=kgueXZGB50zpN2KhFsds4a9J/oo0B/Bfd9JMiIjejDlXpsE1Ve12IVmt02g7uvMQiC
 cKz0JPOPxCuBsYKlpDJhGyVVaVlbcPA9e9Gq8u54Uwk68D+U5zozde3EwOVkVbJV4UZT
 0YR2Djd5ZlnC5sSiTgBBYumk0JMJ+lx+5hgHYvWt1aW6SaXrf8ZZH0Udi4q57X5lSzAX
 pkdhr/UTbzq6p4OK5EeBCVnhKL5fnrJT4X6ZpYNrbqmBrW8gZPU9/fLememCIRBY2Sua
 7w4Yp5p2gS4M9tJif/ulOJG5VkM5G88pynuc6Md2yTjRvQ6W7D/rQ9RPHi5hSK7IY45o
 Y5wQ==
X-Gm-Message-State: AOJu0Yy5uqBSUDeda24EbKsdgPejW44TSvQYYhL040SIsygnjOyR42NF
 Q9MNbzHn+dCYVOWA1e3lMcNMQBiFSeGnkvjKOq/PoK/OctG5bfIkKAXSWTybuU+Alz4=
X-Gm-Gg: ASbGncvlmUHr4DNLf0gcM6LAPakBh56rkHKcR07tSoEkQqZ9aJ8CDdvfpQURj7KkFoS
 qYr7H46ybBy7vmQpxxGbru+gJRPY/vcXShrXwZW+z9y5uKBeNIEYm5yPR4AwqKy1bcfnSuBOzoi
 dbPq0KBVGSi5rjwohCum56++eMAm2wyaT83KDlqvNdh+QfduslapBA8P/S+qcsiM6mGSFpMXMRa
 z3D56XAOMsxz32CDc8084bPR3gK6OWf98GE2CYj8y4778tiNh9iGH90mEHEUWtnoFvzo+DbWV0V
 4ZFntcQ9CSp8LBarnQjT2k+4SLasP9NOQ3cXivFknRl3fsqlCynuK3llj2sW9UtVSBZYMxIx4RU
 TPAi7KB3v02WVld6gb3fXEo0YXo8DEJ15Rr/wvCJ4PmcshMCmy71RiiwhOmO71S+YUCO3OpQUM0
 0LIHFJ2RX/6g==
X-Google-Smtp-Source: AGHT+IEKdL9PbKMFm48X+nJElHJRhq9lpFn0hWAkmJnV+tZdUVU3K0K5IkOaRoDrHA3EZOgI49q2vA==
X-Received: by 2002:a05:6000:2502:b0:3b7:974d:537b with SMTP id
 ffacd0b85a97d-3b900b5042bmr8991507f8f.35.1754887467667; 
 Sun, 10 Aug 2025 21:44:27 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4696c8sm38173075f8f.55.2025.08.10.21.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Aug 2025 21:44:27 -0700 (PDT)
Date: Sun, 10 Aug 2025 21:44:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gregory Etelson <getelson@nvidia.com>
Cc: <dev@dpdk.org>, =?UTF-8?B?wqA=?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 "Viacheslav Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Ophir Munk
 <ophirmu@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix interface name parameter definition
Message-ID: <20250810214420.1b1b8079@hermes.local>
In-Reply-To: <20250810132300.124429-1-getelson@nvidia.com>
References: <20250810132300.124429-1-getelson@nvidia.com>
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

On Sun, 10 Aug 2025 16:22:59 +0300
Gregory Etelson <getelson@nvidia.com> wrote:

> The patch fixes `ifname` parameter as a character buffer.
> 
> Fixes: 1256805dd54d ("net/mlx5: move Linux-specific functions")
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---

This looks better but did you know that the ifname can never be as big as MLX5_NAMESIZE.
Kernel limits to IFNAMSIZ (ie 16). The largest allowable interface name in Linux is 15 characters.

Looks like:
	MLX5_NAMESIZE := MXL5_FS_NAME_MAX := IBV_SYSFS_NAME_MAX + 1 = 64 + 1 = 65

Because Linux interface name length is fixed by BSD legacy ABI's it will never be longer.
