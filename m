Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9310CA0FF9
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 19:57:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A946D402C1;
	Fri, 29 Aug 2025 21:57:39 +0200 (CEST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id 5CC0A4027D
 for <dev@dpdk.org>; Fri, 29 Aug 2025 21:57:38 +0200 (CEST)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-7e8704cdc76so250104985a.1
 for <dev@dpdk.org>; Fri, 29 Aug 2025 12:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756497457;
 x=1757102257; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KX/SOnwYeCJX48WpVb4AdSWHxu0kbv3jfRLzEYmhvQg=;
 b=WqB1GFQoqZeqzowAGDEuW0jhG7VzLMUUZ/re2niexMgb7CXWUROVXygFqN4KtO2gDh
 kP4RxS3XZwZbNvJ80bmzSqBITyUR+JWU5KrnZbjh/4p5cKht98AKYduMms6EXjMPceh5
 yHFrJspQSqphjn6OINb5bRJ7gr2xLflIQb/wZtTOfWAgKQDDgIHsnvZsxowmfyZIzQhd
 6GSckvUKAfRXBMDd7J7rbVOLMHL6jiHMsLZPzko6Cbu60UfMEk8uJSWar+lOHDKJV59b
 WDdYaLRv5psa/7OfDX6x3sHwJcgtEA6tCY2vrwWY589uDjLUUJKmLfgtxWaouPaR09KU
 3x5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756497457; x=1757102257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KX/SOnwYeCJX48WpVb4AdSWHxu0kbv3jfRLzEYmhvQg=;
 b=e/o+RRsrkLz23NwESM9Qti+0td2nBvn1Youj4BgJT5LerJ+s5EWU+Hm74QdWdK/5f/
 cSy7jXNqmavDXYH/RZC7IVq9YPvVOSZoLW6cIg4MvzQQ1uP5aN7GSNRKYRiawwpA3Ybk
 kr8T8zhll7/hkyiDtd7PZ7g15EIlT8aZmh+yFeA7Lx7q5/zafoNtPib9TbkdmVdeAhJg
 3JjszWZG6ySarYFpQCDQoStLNziJLr9yBRCF9RdPVZ7OvpmFmSXj6EabXvlhZMpsYvQh
 tQMFQRlgn3xeVlhvVXvlI0zLPnvWnR5eMkvYF0yA5jTpJ8wjgIv4eWQ6pjxTPwkbxAqI
 fJ+w==
X-Gm-Message-State: AOJu0YzonkHPFD510YUE63BgVQYa9mA0wkkJs611/zC9FiZtU4UGGHAO
 TUwzM5v4fsSdPCMwL0B/osd3jztGiyI8Voe0wBHeqlf8TiAsCCZaghfdYqzeevWr9wI=
X-Gm-Gg: ASbGnculHN+dvIG/b3nvAugJ+g91RW6OWiQSq8fcMPvUZbhkAM8W66ULfApAz72JkU5
 8WMoiu83Vtb6/WpbSsHrb7RJpCbaw81eUM+XaCBvSgNYnKBFd9qnIuo9sJtX/5gzbNS0S5S+LAA
 Po7Issv8u3qOV/2pGZDgjOyY9UsRM71ugLKi+X+6oFx1XBW66npC7cN2XErLgwHlZ8QKVN19il0
 Bv/X3sqKUPWU0dT1GC11WhjHuyk3hXuGMWIQSvCMid0LbDj4JU1dCJyY8pW8rICIQdnxWrq2Vvw
 Br2AJ66LqiWMkxLyZxGNwAled/sOuoklrmpqzdbFEl6pt/clMtNj3re9R4aYkPFFIsHmNDxDBWb
 Cu5vBTrFXPiKxYC9eofP2JNpNMcfiP39Byr7z/TH81Zi9Kx+iIe1n8lR/puaCERXuHhlj5vyv1b
 NRm78JpC0Bug==
X-Google-Smtp-Source: AGHT+IE7B24hhWeN/v/57CX51ztog1EFe1X3Y9j8+8HdXdbUmpO/09iInjNJmb+orljx8HV/RhKyGg==
X-Received: by 2002:a05:620a:2686:b0:7fc:6e1:ceb0 with SMTP id
 af79cd13be357-7fc06e1d140mr546794985a.37.1756497457466; 
 Fri, 29 Aug 2025 12:57:37 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70e624cf326sm21543146d6.39.2025.08.29.12.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 12:57:37 -0700 (PDT)
Date: Fri, 29 Aug 2025 12:57:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yang Ming <mosesyyoung@gmail.com>
Cc: dev@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>
Subject: Re: [PATCH v3 1/2] net/mlx5: improve socket file path handling
Message-ID: <20250829125734.7fd3aae2@hermes.local>
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

> The current implementation hardcodes the socket file path to
> /var/tmp, which has two issues:
> 
> 1. Hardcoding absolute paths is not good practice.
> 2. /var/tmp may not be writable in containerized or restricted
>    environments (e.g. when the filesystem is mounted read-only).
> 
> This patch replaces the hardcoded path with a socket file name
> (MLX5_SOCKET_FNAME) located in the DPDK runtime directory
> returned by rte_eal_get_runtime_dir(). This ensures the socket
> file can be created in both normal and containerized
> environments, while maintaining uniqueness by appending the
> process ID.
> 
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> 
> Signed-off-by: Yang Ming <mosesyyoung@gmail.com>
> ---

Rather driver specific logging, why is there not a way in EAL log
library to ope a diagnostic dump. 
