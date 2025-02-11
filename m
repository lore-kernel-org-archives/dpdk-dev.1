Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5A5C0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 16:24:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6974D409FA;
	Tue, 11 Feb 2025 17:24:47 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id A1FC54069D
 for <dev@dpdk.org>; Tue, 11 Feb 2025 17:24:46 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2fa488351ffso4923295a91.3
 for <dev@dpdk.org>; Tue, 11 Feb 2025 08:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739291086;
 x=1739895886; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J8YstkOUlTy4RmfvF0cG1MBWO1Jam3DnL+8atAuq3m8=;
 b=dnHhpJKvkIknUXi1B7nH4ovtAM9GnFMtGubM1KNwjI6oWPoKdl5o8MtBWj0GYFYcqb
 3q+PZ95bsJr8fESF/8iZ9s8tjEhH6UvmQZLsk5UPkfSGKIpNVZLQjgznnmbjset6e1ba
 hNPjfnFO8t/qMljC0F97YA/4Cgmgnoa4MzIzb0XohH6QI9TLl4RgYKB+yJyDWgXjIdxU
 A/MVFtDkFhYpIqQHlC0MDS5/SMyp+Ue3eHiM/g6MZ5WtZpB7qa2rVn3ApLzlYjtVCAn1
 4W4Ex+8WV5Xm5ss5ELgQQh8kFUyNxXdMD3/WiqHXo06NjkkGyz4Gd1HKSzBFQUj6qLKN
 0L4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291086; x=1739895886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J8YstkOUlTy4RmfvF0cG1MBWO1Jam3DnL+8atAuq3m8=;
 b=YDUtD8O1ZLmevVrappFIHD7bviEA0MNcrOEnJZ+NXixlBdKkl4A4asI+TUGsIw2eqG
 OQfe6nwi9P6PXDeOBCOXVR8OuQscecdfCfPNmbuT91ivfhhoAY+PmmFoA6fLi+5tfM3c
 5P5j4IfFpZ71qFcrh15pA9G5nocEAlSTNXXLfOoHdmd8lcwG5KgCs9b4gso3Rr9ixt7a
 da3mJWbbGy8Cz1yMD+ZOLn2i82g4e0sNYus9XOl6tJDUKbMoiLQz+oOGNX3LQzRYPxVd
 5xXfKdpK5zoXRLg8beOrpFH7TveoTvUHSodZ9k2F1yoAOr/if8hRYP04a2cRyt2Y/Ut5
 Y/6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGu2cx3K2dvAKHLsE42TDddMgEpZwgseZKJsu2IlfQsPgQAHtccM9Bgr9BK79Y/rBdZpg=@dpdk.org
X-Gm-Message-State: AOJu0Yw/s+Vb1vd3Wx9ybzKmjY/N+YbC5yew4T17jEpZKYMeT7AqnX19
 xD6vvJJU+3RQcJgJ51MJa/cqOGv5CC/0+jw337jzcHOK05GYeeD6T3URBwQEsoDExXp+7xGjUdh
 j
X-Gm-Gg: ASbGncunCr9dIAJ3OSj4m3aaVA8j9ZAqdpdIMAKZ8MX4oOm3CsWa57svHcY0+3ZNIwd
 JDBq2GJfrGZnncvbA4vCObGAxenCiKtopRDYWDIyAXxVlVs39CIhif23dMWhdkOFRVBU1roRQDN
 YHbLYcY4sWo3uVzH88kYgTU4hUPHrEwT9SffzKwYVIM4mjtRivTvEI3KAmdH/rq+F/2T8pkCbfI
 vFQHDmDW8Nybnu7xjeDKcwoeE3EjeVV8o0/zQzSoVUffWeenUWqEOenFpQ2sfYTNcfiu/c/yr4A
 YYc1r1zBttQj9CWhjBiN+mCu4mTkpo6ZNfPb05XBfoKp9SPEGGCwjMWVPuPvRWaupGXL
X-Google-Smtp-Source: AGHT+IH8tIr3by4SfJfT6ZMSpkED+qW6ndpYOzgKOv2Xt1MrPtqE2wQx9lQB4kQiX4dneUkCHKlmug==
X-Received: by 2002:a17:90b:1915:b0:2f9:cf97:56ac with SMTP id
 98e67ed59e1d1-2fa22b8e509mr32147967a91.0.1739291085826; 
 Tue, 11 Feb 2025 08:24:45 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa2d831a1csm8617326a91.44.2025.02.11.08.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:24:45 -0800 (PST)
Date: Tue, 11 Feb 2025 07:22:11 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wenbo Cao <caowenbo@mucse.com>
Cc: thomas@monjalon.net, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: Re: [PATCH v9 08/28] net/rnp: add queue setup and release operations
Message-ID: <20250211072211.29549f24@hermes.local>
In-Reply-To: <1739263818-59770-9-git-send-email-caowenbo@mucse.com>
References: <1739263818-59770-1-git-send-email-caowenbo@mucse.com>
 <1739263818-59770-9-git-send-email-caowenbo@mucse.com>
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

On Tue, 11 Feb 2025 16:49:58 +0800
Wenbo Cao <caowenbo@mucse.com> wrote:

> diff --git a/drivers/net/rnp/base/meson.build b/drivers/net/rnp/base/meson.build
> index b9db033ff6..c2ef0d05be 100644
> --- a/drivers/net/rnp/base/meson.build
> +++ b/drivers/net/rnp/base/meson.build
> @@ -7,6 +7,7 @@ sources = [
>          'rnp_mbx_fw.c',
>          'rnp_common.c',
>          'rnp_mac.c',
> +	'rnp_bdq_if.c',
>  ]
>  

The meson.build file ends up with conflicting indentation here.
Some spaces, some tabs. The DPDK standard is to use spaces (no tabs) in meson.build
