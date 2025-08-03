Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B2FC87FCA
	for <dpdk-dev@archiver.kernel.org>; Sun,  3 Aug 2025 17:19:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F6874026C;
	Sun,  3 Aug 2025 19:19:18 +0200 (CEST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45]) by mails.dpdk.org (Postfix) with ESMTP id 5D4E7400D5
 for <dev@dpdk.org>; Sun,  3 Aug 2025 19:19:16 +0200 (CEST)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-af66f444488so461415966b.0
 for <dev@dpdk.org>; Sun, 03 Aug 2025 10:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754241556;
 x=1754846356; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7fSXi6LB39gOtTzFAJ5dMEbEEKaMhapPZlrk8SaPo4I=;
 b=nfuisQnJ+wT8i73SSlDm0/c8bDC5LTEFBX89OmleDf11MRdKIToSiJLOPkec6gtHXv
 287CaWiDFyzLjaH3M2guRPDbzJKuU4NA+xYqNGCb35QxcER/3INvl31mOwVTyOyxYLEU
 T7OSOO4++gPUzTmSiQeLbDUB6XMcvf5Mzvv/yJZoycKksR4TDLRPiXmCyCFwOilE/Za3
 VT/llvgjxP7asMJXmu+9naWXkwFY/ElsPVJ7cJptUgudvVkeeYAYk0fgv4OOP4ph7kVo
 Sus/N5b3StnQa5yA+a/9F4EHHzJyMTqPFQQ65+vSo/ZG9TPZ60QvaSuw02iEkBbGp7fv
 DKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754241556; x=1754846356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7fSXi6LB39gOtTzFAJ5dMEbEEKaMhapPZlrk8SaPo4I=;
 b=wvOIhzFO0ySGCllz+blM4o41dcQI++reGpOg+V3e7ngLdWJ+byBBfx6vxT+d4NT5fK
 wft+hsIv8+aVJvA5uoRJeiGRLllGmg+nCqzMtKTdpqJi/9ufqT6u9BCBEldkKC6ZM9DF
 FqmiKTbtKg8U/BvVRZzBvAtw5cRGBUwgy1tCIM3hcGLftRJ61HLY9RH98DL/yMY1pvdm
 YymK38S8/TAcd+CSHPujaA8x5xw04zuVZPN57Mty2XvxKCJ7sqj6JpkDSz/DC/XGLhiw
 5TztjGLvJ5Ve0La0N6PbMxmpqsvKR3EvVzropetjWkCxc0ETi48djTfdU623/U2/KURx
 TaxQ==
X-Gm-Message-State: AOJu0Yx/Nru3G+qg5PVAJOmq2iayWByEY64wIFMilfqKe30HK0EDp0je
 kAjiLVcbZerDc37fQtw/X0CpppSS2O1sD1LkCG6WYgzyYHkFvT66Rd4jVhVNXf+C8Ok=
X-Gm-Gg: ASbGncs4vMQ3FLl8qMZbL8nXJI0pbhkH2AIyE5RC+m2ogHoWbh50Lcf/wMtY3W/hx3o
 aoV2URUs1LdFNqF3nNxFzD8ho6+v1h3pV1HrHsKMZbs3RFYFmBKoqsBTUD7j4BRfJ2iD5B9N1Gt
 gcsrKpmD4m720ncKU4eroiCOKQdgwAmK9Ah9VhB5KLbFGtCQ44/csFjaWKWBMBcAuYOCEIFUrSL
 e4sRO/JoKgUN1B1X/qvfBLIXSZ1CK+8vEPCpBdrQVDZF5WrjBwUUcPxh3lztdUXXj/vFqGuWoKc
 x3n47SwYGbdwR1jR+jzRHvtiEYlYKmdIXysHrkvigx/l5t4JHteU24Ck+uZ6o/XJIHFVtn5g8xa
 wSxtZeGTxoIVT3M7C0E4UZhFzIB5zsg6w57NY9Ntoqv3HYVgOsPPLnO4zIRJUk/0ufIeDGiuQhq
 LTZBYch8iRGQ==
X-Google-Smtp-Source: AGHT+IFBGmdgW6Z+ZkvpzMIxb2ihv864ZaD7j5nvYdYnApnqv/7RL0DXNZg5nxMZQdmTDngrc4wJQA==
X-Received: by 2002:a17:907:96ab:b0:ae3:7c8c:351d with SMTP id
 a640c23a62f3a-af9401da95dmr771270066b.56.1754241555726; 
 Sun, 03 Aug 2025 10:19:15 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af94cdbe972sm256737466b.132.2025.08.03.10.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Aug 2025 10:19:15 -0700 (PDT)
Date: Sun, 3 Aug 2025 10:19:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Xin Wang <wangxin679@h-partners.com>, Yi Chen
 <chenyi221@huawei.com>, Feifei Wang <wangfeifei40@huawei.com>
Subject: Re: [V5 02/18] net/hinic3: add basic header files
Message-ID: <20250803101909.07db35ae@hermes.local>
In-Reply-To: <20250702020953.599-3-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250702020953.599-1-wff_light@vip.163.com>
 <20250702020953.599-3-wff_light@vip.163.com>
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

On Wed,  2 Jul 2025 10:09:25 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> +static inline unsigned long
> +clock_gettime_ms(void)
> +{
> +	struct timespec tv;
> +
> +	clock_gettime(CLOCK_TYPE, &tv);
> +
> +	return (unsigned long)tv.tv_sec * HINIC3_S_TO_MS_UNIT +
> +	       (unsigned long)tv.tv_nsec / HINIC3_S_TO_NS_UNIT;
> +}
> +
> +#define jiffies		      clock_gettime_ms()
> +#define msecs_to_jiffies(ms)  (ms)
> +#define time_before(now, end) ((now) < (end))
> +

Use of clock_gettime() is discouraged. Instead, drivers should use
TSC directly like the rest of the DPDK.

Also, that version of time_before() macro is incorrect for the case of jiffie
wraparound. Better off to use uint64_t.

> +
> +static inline u16
> +ilog2(u32 n)
> +{
> +	u16 res = 0;
> +
> +	while (n > 1) {
> +		n >>= 1;
> +		res++;
> +	}
> +
> +	return res;
> +}
> +

If it matters, there are faster ways to do this function.

> +static inline int
> +hinic3_mutex_lock(pthread_mutex_t *pthreadmutex)
> +{
> +	int err;
> +
> +	err = pthread_mutex_lock(pthreadmutex);
> +	if (err)
> +		PMD_DRV_LOG(ERR, "Mutex lock failed, err: %d", err);
> +
> +	return err;
> +}
> +
> +static inline void
> +hinic3_mutex_unlock(pthread_mutex_t *pthreadmutex)
> +{
> +	pthread_mutex_unlock(pthreadmutex);
> +}

Why are you using pthread_mutex? DPDK drivers in general do not
do locking in the control path, it is assumed the application is
coded correctly to only do control operations from single context.

The driver needs to be more like other drivers.
"Snowflake" drivers mean applications have to deal with different
semantics for each device.

