Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2677D6CFA4
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 20:40:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A08CA4064F;
	Thu, 22 Jan 2026 21:40:52 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id DD98F40297
 for <dev@dpdk.org>; Thu, 22 Jan 2026 21:40:50 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4801d98cf39so10986045e9.1
 for <dev@dpdk.org>; Thu, 22 Jan 2026 12:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769114450;
 x=1769719250; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n14HsSviZAj04jcieoAyAxV22gh3ySdPl0VeFxMzGo8=;
 b=tg6KN5OPfzac6D3iDkaQ2P2k+JHT4kqYhone0U3XdJhayZ0BK6gMgiwTGN2ELcJYU9
 +u70iB3zxSWDMTPBkuWlXtF3l46g2wfzVt7TWioiKThgnLhKEv8lGiv5oGgaLzDjSUNx
 7rw7VzKm2bILitRX3Gfy2yZB1HXfYzk+fJ+X7D/bSVz4ODgZX/fth/AlsHFSxt8c/7Mw
 bz/9saqew1d3Fqy9j8xyO+5WWFrtof3AvKsaDWsyKEbG6eyM+cvdFoofjT4dUjoNM1h5
 nzPpxVu81pX5OL+pZGM/KWUNn4BVwL0AlV7JHrkGv2YqqVHkZQRpIoKClbKfy6n8G4sp
 gFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769114450; x=1769719250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n14HsSviZAj04jcieoAyAxV22gh3ySdPl0VeFxMzGo8=;
 b=IgmH2ApNRZ48kg63vxXcmTEf7jnXnVzaR10RmN7BPjdRpZHEusQfh6RGswiDnqpfBb
 BW1F0fLHoWDalW8ZGp9p+X3BPXwhFSCzHIxshoVbFdTkkZdNa2C0ABfx+jKhS992/9tQ
 HCtj/t8zv2AWqPgAE53+mhtWCRYIxajlj+nzNzG4/S1LPO07G9iAk9I5LW5aMEssW2vB
 2rXvvFJ1R1G8vn6McTvFqNYdbPWvov18o+/gL1brgeQNkvX80cKE/0cRWfWR69KkOV/R
 lkNChFAkHXlw5dkTCdtwtDriu6dPyX/AZRzxhjURRQLj1y/k7LkbDnzesXC8PiNFBiRB
 bDvw==
X-Gm-Message-State: AOJu0YxE5zqcv15SvfkvCoPsXsm5BgxUtNE0LhXZeg5i9K1me9fzGFGN
 j7gGye0Z6G8PUtDmvm7jA3ema9AAd9PiCSXYwrCsUJ1B1KgcJGPQGDDXjK2iuPAzG5EzyE7sBnY
 /wjGo
X-Gm-Gg: AZuq6aJrHmGjsktyEFFBNEUHz1Y/I/usiA3P/TmFdyBsoQaigAKTxnWA0EyeFOdU+Hj
 kjPIM3o+tjIhr8kVYr+Wd24HR03W4YS8EYc/9Oi1qm100qnIpr5CjRL+u/07X78Z7UvIPnSgTIQ
 zpXDOjzyI/ynRlmSFP7LBRja7swHrhlyfbO+VN45SglEFtmw31BQ0QG2wJYz7AMYSrSCr1z2Tjk
 GJAgB5YWxYfWF5VbiEg19b9oNNF1rSHCyRH3wLQFW9o/ZQRRS0wb12p0Qq+3KNCZg6HmxLqgm+7
 zLBmdhP+OLjUJwfeNWrtXwe5n6E0arHbquS6om/5QuTEjt71rAlP+UukNkmGxszU+jdPj/PhnA9
 riidC/9C3jNq/d1mb4Q9XxwUAfOnf0EdS0L+NEF6Vk5cqsN4rl/FnIPIq6n/bn3cZPvBxRayG+s
 uWmJDgBL0QkipXeVpAjw1wmXhcKdIJiEoEyYQDYg+PBW7dB9uEQrwJ
X-Received: by 2002:a05:600c:1c17:b0:47e:e20e:bba3 with SMTP id
 5b1f17b1804b1-4804c9418f3mr17017165e9.7.1769114450140; 
 Thu, 22 Jan 2026 12:40:50 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d84ebb9sm5945275e9.4.2026.01.22.12.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 12:40:49 -0800 (PST)
Date: Thu, 22 Jan 2026 12:40:44 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: stable@dpdk.org, Naga Harish K S V <s.v.naga.harish.k@intel.com>, Morten
 =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>, Bruce Richardson
 <bruce.richardson@intel.com>
Subject: Re: [PATCH v3 11/14] test/eventdev: skip test if eventdev driver
 disabled
Message-ID: <20260122124044.3e13b927@phoenix.local>
In-Reply-To: <20260122005356.1168221-12-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260122005356.1168221-1-stephen@networkplumber.org>
 <20260122005356.1168221-12-stephen@networkplumber.org>
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

On Wed, 21 Jan 2026 16:50:27 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> If DPDK is build with -Ddisable_drivers=eventdev/* then the
> test will be unable to create the needed software eventdev device.
> 
> Fixes: 50823f30f0c8 ("test: build using per-file dependencies")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Maybe more needs to be done or handle this in meson build.
Not sure.
