Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACDCCCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 17:21:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0CFB4021E;
	Fri, 24 Oct 2025 19:21:17 +0200 (CEST)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0DE4A40151
 for <dev@dpdk.org>; Fri, 24 Oct 2025 19:21:16 +0200 (CEST)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-7a26ea3bf76so3157745b3a.2
 for <dev@dpdk.org>; Fri, 24 Oct 2025 10:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761326475;
 x=1761931275; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z0BcNE2CBs482whltNfCSdTGmlu0ZwgG60BkRo9qhrg=;
 b=r4A9M8v3xmhTyy+JPQYH1ycGGmxnH/mwG0ouUGSzCkpiCDZGvYMO8uedaHUWRiTkkn
 0ojHzlQKHARrxW24GLbrF352fm4aEw5EPNpTwj6Q1VRiy2Wt82cobo68oQbGcUreRBKE
 TqRMl2pi2A8w+jjUfpPaJa2a10hAcfFbP4boWs64f/q2GD6sI4ykoTWgHu1SuGyzkJdX
 CtMm0O2OorqCcxQre41mumq1HJhi+y2Zrvo2Lcz0sHU3Gqi+agQrf/Mn02qVezo5+rX0
 4oG8TEluW1KR7OMq6ZIlszFjixsGjh08Wb3uihCKV5RqcD3MRzboWAK3nqozmHneUeUz
 Q31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761326475; x=1761931275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z0BcNE2CBs482whltNfCSdTGmlu0ZwgG60BkRo9qhrg=;
 b=J3G5gQxLSYF9GKuAUjwZl6b6gmGsn7G4wzWnR5lPCVtjkhZi8AkefeomTdGEjqnXlV
 SsRn7xlntuW4ePb1xMOWC57cON43e/ulT04RP8/0AMKPWKAgFKyOrHtZQ1/2LewE1kBb
 cEW6cYnZ0ophAfXsDnTJuD3d/UsC2fqBUZhCxieZFPdBf1sl1voDOH6TLn/q+wV7HzCR
 MyVxu4pNch/deuf0Fsc44YNeKiZ5GDBUj29mDcI6hONio5VbpnSyBRCAGodIVsj3bLpO
 2S034+1uyl1B0ELQvDjJ+pw8Mhh5GfqDCQIYtHO0ZOf1K4jS0jfMr82IFP2cA8+oJuUr
 S5jA==
X-Gm-Message-State: AOJu0YznbOZg6snOXXvGJe+dHjjexX+Xgm8Xm97bRrQZjkRDKgOZUR9l
 1YRVTBqQOBoLcWlz1ycKT6EQc4IxplBo3ry6XHoa9je15r3E8iWVEhs2Tes0C6cS6lM=
X-Gm-Gg: ASbGncvg+iNSVLGAAL88WugiI4UR2NhXKaEXR858m3QsX9ots11iYYpY2v99Nj+SUSN
 kS9x2qFasWocKndCKJxueGytRz5UvjGsbiukOs7o5HYixfQaVu0pl+Ez/2Zj+OzfuzAmmKsgKHK
 hJR4J21rr6c0joI84sb6kjl3OEJ+30noHdCIVa80dYM7d/LgZb/jgFym/AvtS1Q9uWD52XL2dZs
 +87WGW8sMSjIGu7FMDpZdjD5DVC5ZWKQcMM+5OwwzkWi6Fjqe8p7Ubuzkykfjjb7LWEw4aCHYb6
 AbMvD5Y7zIYKLStuwHIkg5yLyWnaKYP9vbnU3VzAqwpNujXliVumtbgAlncKwL/uxDgpXwvVlLY
 V9QAvuLll/80xx4QVW9hmb2k1jWZf8DUzBXaSQfysuskVWxSYAVmIvP/18nH6Y8UIlfftuTU4xU
 XvHxrp2hopUKuyzJjVJT8l6CVsGwNK4a+pUQ==
X-Google-Smtp-Source: AGHT+IFMBvczFOoZjPTFjfWsBkvvrsaRQFoZsPjo4takibiDPlQhygqf3NAjG3c4wG4/gnl4885rSg==
X-Received: by 2002:a05:6300:6d05:b0:340:d7a6:e503 with SMTP id
 adf61e73a8af0-340d7a6ea89mr308207637.9.1761326475124; 
 Fri, 24 Oct 2025 10:21:15 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a274a64c5esm6476466b3a.10.2025.10.24.10.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 10:21:14 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:21:13 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v12 02/13] net/sxe: add ethdev probe and remove
Message-ID: <20251024102113.39faf411@phoenix>
In-Reply-To: <20250728090517.1811244-2-liujie5@linkdatatechnology.com>
References: <20250725104855.73326-13-liujie5@linkdatatechnology.com>
 <20250728090517.1811244-1-liujie5@linkdatatechnology.com>
 <20250728090517.1811244-2-liujie5@linkdatatechnology.com>
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

On Mon, 28 Jul 2025 17:05:06 +0800
liujie5@linkdatatechnology.com wrote:

> +#ifdef SXE_DPDK_DEBUG
> +void sxe_log_stream_init(void)
> +{
> +	FILE *fp;
> +	struct timeval	tv;
> +	struct tm *td;
> +	u8 len;
> +	s8 time[40];
> +
> +	if (is_log_created)
> +		return;
> +
> +	memset(g_log_filename, 0, LOG_FILE_NAME_LEN);
> +
> +	len = snprintf(g_log_filename, LOG_FILE_NAME_LEN, "%s%s.",
> +			  LOG_FILE_PATH, LOG_FILE_PREFIX);
> +
> +	gettimeofday(&tv, NULL);
> +	td = localtime(&tv.tv_sec);
> +	strftime(time, sizeof(time), "%Y-%m-%d-%H:%M:%S", td);
> +
> +	snprintf(g_log_filename + len, LOG_FILE_NAME_LEN - len,
> +		"%s", time);
> +
> +	fp = fopen(g_log_filename, "w+");
> +	if (fp == NULL) {
> +		PMD_LOG_ERR(INIT, "open log file:%s fail, errno:%d %s.",
> +				g_log_filename, errno, strerror(errno));
> +		return;
> +	}
> +
> +	PMD_LOG_NOTICE(INIT, "log stream file:%s.", g_log_filename);
> +
> +	rte_openlog_stream(fp);
> +
> +	is_log_created = true;
> +}
> +#endif
> +


Firm NAK to drivers manipulating log streams.
We have a debug infrastructure, it should be used.

In production code it is important to think how your driver will be
used in an application, not just as a PMD developer. The application may
live in a container and in the cloud, how would you debug it.

