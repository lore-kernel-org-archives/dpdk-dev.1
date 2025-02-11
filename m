Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818AFC0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 17:48:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92615409FA;
	Tue, 11 Feb 2025 18:48:37 +0100 (CET)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id E41594067A
 for <dev@dpdk.org>; Tue, 11 Feb 2025 18:48:35 +0100 (CET)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-2fa0f222530so10720497a91.0
 for <dev@dpdk.org>; Tue, 11 Feb 2025 09:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739296115;
 x=1739900915; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RTPv9yCGJmvPX05nkrPjIiarVZ+oCjpwuio71gkNb1E=;
 b=Tm8U2stiTqkkm+xgicgt0Z5meKnpkqHh0NvVRmgRyidMiBtyQ3dVhpNsMFipwaV0QW
 pGO1YZLExdlG89PWEuYBM2hVboy5bJecLxbccpPSsVHeh0jHaqhpxPP/qfmJY5jo5VJ7
 TV/RYl57U7UbK/PDVK3ZCVBLCBKyvQltG7rRajSAqBTyoDj9z3oUDYf++KF9ojm2Ay9K
 NzRj5hWCkM+LAcXTJ6vGoIkUJhMy6d1MdQIBUwpen5bz6+zhAOKyFyJagw1HHMimzDES
 M5O8qdtHU/Wo8kbX8T0vN2RB59fUjzMm7PijEYLt2S/MEPEc5W7wS9xJr3y1v3olv4Nv
 gzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739296115; x=1739900915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RTPv9yCGJmvPX05nkrPjIiarVZ+oCjpwuio71gkNb1E=;
 b=cXQ9q0zPl57GB2cJ+PN68PSXS3X+zWnxeFQLO6f6iio/FlvsPA+8lTYomttm8gl6Ut
 +oJ76rOVjTMggZgiLWsPbtx1FHa2jVMYHx5azBHEaexfEVehrs5X7wY/u2KAH/A0NDoB
 jCGErHDu53BgS8HIGiiNXUa+qPeUSSJT5L+gt3vS2/yvINe37mitP0WXX+JSU8FurZTq
 QToqh3TGK/4UpZlse0lCiJtpKgl80HqcSzDpduZJ2t5BsfJSBYeqIvBXw5V57UPzUkww
 2Aq41lrI68jroy/3rh2ohBpWSm+Du2GsJwXzCcHOvaMlklm7WTseiP3i1n6NxYA9/4iS
 ctyA==
X-Gm-Message-State: AOJu0YwJTRq0b0YNEyRzyvY7r0obj74CkNmUys1KjML5wcLW+RT7iz1I
 HnVJr11syIXj2GHgoq1S0a4CEYImOSgzkopylDLUV+tCfcnbQSk1s7VFVN/oqPw=
X-Gm-Gg: ASbGncutQu5j9YQ7U5Q82piysygO53RJ+Ez8Ex+8UqMLq7LE5NfyfMSqXHDP/GNW0ND
 lbM8SSnVXs7EYPHbT1n0yv0PeoPQnxDYELiPYEERQJZtoLTIRo1XRrZQZLlmC5RuR0nwqcABzai
 4nFgm2cvTr7cROydO2MMpcf5ahRfWQcTPXENLUKX3lk0yAPsCsnMZG6yM6egFvdLRM7o6kOuO4+
 vu8CnwmMp+ZalwnHjJ3jdUOOHOdcMmGefFTp2M+iWCvM4LeCz6/WUTJ0FeZiQVZ3HUxiXwnk0Vr
 mRWLk8Bc3gp4lszvy5ljrpg3EAzumME0Eb0dbxL5HMzGAR0jTJOQEx4Vl2BSwH285veH
X-Google-Smtp-Source: AGHT+IFBsm3QuxiPxHYbOQmIWkwTJi8OK6zOEfE8emQtYQjn9Dczn9GMFpG8NdZ5349MkvHjLnzcXg==
X-Received: by 2002:a17:90b:510e:b0:2ee:70cb:a500 with SMTP id
 98e67ed59e1d1-2fa23f563b2mr25955292a91.1.1739296114927; 
 Tue, 11 Feb 2025 09:48:34 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3687dde5sm99145775ad.164.2025.02.11.09.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 09:48:34 -0800 (PST)
Date: Tue, 11 Feb 2025 09:48:32 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shani Peretz <shperetz@nvidia.com>
Cc: <dev@dpdk.org>, "Parav Pandit" <parav@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
 <nikhil.agarwal@amd.com>, "Hemant Agrawal" <hemant.agrawal@nxp.com>, Sachin
 Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@intel.com>, Chenbo Xia
 <chenbox@nvidia.com>, "Tomasz Duszynski" <tduszynski@marvell.com>, Chengwen
 Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>, Wei Hu
 <weh@microsoft.com>, Bruce Richardson <bruce.richardson@intel.com>, Kevin
 Laatz <kevin.laatz@intel.com>, "Tyler Retzlaff"
 <roretzla@linux.microsoft.com>, Jan Blunck <jblunck@infradead.org>
Subject: Re: [PATCH v5 2/4] lib: fix comparison between devices
Message-ID: <20250211094832.0b164537@hermes.local>
In-Reply-To: <20250206000838.23428-3-shperetz@nvidia.com>
References: <20250129085416.226718-1-shperetz@nvidia.com>
 <20250206000838.23428-1-shperetz@nvidia.com>
 <20250206000838.23428-3-shperetz@nvidia.com>
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

On Thu, 6 Feb 2025 02:08:36 +0200
Shani Peretz <shperetz@nvidia.com> wrote:

>  static int
> -cdx_parse(const char *name, void *addr)
> +cdx_parse(const char *name, void *addr, int *size)
>  {
> -	const char **out = addr;
>  	int ret;
>  
>  	ret = strncmp(name, CDX_DEV_PREFIX, strlen(CDX_DEV_PREFIX));
>  
> -	if (ret == 0 && addr)
> -		*out = name;
> +	if (ret != 0)
> +		return ret;
> +
> +	if (size != NULL)
> +		*size = strlen(name) + 1;
> +
> +	if (addr != NULL)
> +		rte_strscpy(addr, name, strlen(name) + 1);

Why use rte_strscpy() here?

The intention of strscpy() is to handle case where the resulting
buffer is limited in size. By using the input string length you aren't really
doing anything different than strcpy(). Still unsafe if output (addr) is not big enough.
