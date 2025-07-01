Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4ABC7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 13:49:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 002B6402A5;
	Tue,  1 Jul 2025 15:49:42 +0200 (CEST)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by mails.dpdk.org (Postfix) with ESMTP id 47CE740264
 for <dev@dpdk.org>; Tue,  1 Jul 2025 15:49:41 +0200 (CEST)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-4a745fc9bafso76938791cf.1
 for <dev@dpdk.org>; Tue, 01 Jul 2025 06:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751377780;
 x=1751982580; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lNQQ/5N+o+oFLvNKmiglUlO9c+gHR/PvWNlDgajIGsk=;
 b=NuBtdfn07urZdt6hiZARbDtKEqqiFuJ2l8p+vJyf+iOtsN1iSC8bby09DvOz+Je5Jc
 OZGRxFDU54IM4aR/+mYNkj0/V2SkfkkmYnUCFiR5Uu+krBknCCDj5Eq+tQSJZA2x86Vp
 5NKezjr07Quwa2mMOhallf/xh8i31eKGVtkhX5WDU/VIAySWxq5KwmdRRbz2fS0fYeeo
 /9y7H6clTJe7B7ImE2c3sdjIsoLqf8FrLjWNBv/SGXvsNmjjGqgFDpEYZ/MmV0ORndP3
 mp6hfmHc+JpypIJkZyjLq5fvPCsY8jhXBmcjY8ym/CRVNKjC2WULc39jHTci8rsHhHoS
 Tb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751377780; x=1751982580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lNQQ/5N+o+oFLvNKmiglUlO9c+gHR/PvWNlDgajIGsk=;
 b=WINzO/wOoDWtiwl1MnbC8JHcsR7Y5FXNTzGIiinklIMZYYEjTRx7IpqXpR1zICrnPg
 A23NDF7AzB7jirl0k9tbKaReaq8ieefFhJdPumckPT7qoaCtA7sL4Vc98CjN2y+hFNgx
 sFST/H2eu4BOiQOxLw4qElzZOSW7F/HIi2o5pN65R/ZFamF88xMKZegssBVGb4uqCkKx
 pTZCtGKOnD18h8IL/DtRKoqVG08Lp/MQkL1SnNd1pJuEyu+ooDurCj4qiu0H/HIg/tvh
 JsdhImt37IiQ8Cqs987QHAUSpGRkgr1/ek0QEsnyRTQUbyCQpb+C6Rss3/SPJ1UUagqf
 3sVA==
X-Gm-Message-State: AOJu0Yzrld1JPUkVA2ChSfNNQHwXlaStsNCpy80qJtUDwyHDJ8ccDACj
 XOw+m0C8V2JBMeNy2BtsC4akEnlYmmiiaL2at6Hvt7Tka5gCcPG06gWxar8mxNdTV4Y=
X-Gm-Gg: ASbGnctbiRSbusP2rKFYLWA2I5ZntONpjprmPRAsmUoIcKkKUGVOlShr9W+BFYd3TxU
 nXdljlhCeuomGzO4WRTs9i+8EqGCZtn+w8EjJgdaKk1ERGIVfkMH04L6HFi0riAzzg1BbbsSlNh
 IzQEpFWqaLUX7DOdZ8KpVQhueKP2+kXLHzO1xCqGQkc+uQJnCXC3HO31n8ItAEdEruUEXCX10cO
 fWqFaBzk5GezK1RmZhax74+PdeIPD2MxD38p4bNQ5jrtG0SPCu2WgyKejspqVgbcLEZDz8U1DSJ
 QlXbUEpMLd85B6GiOzdJ1Jphxjp3QfvNdj7TJvb/TixdHf7Vx83dItuNVH/1HCeiz7K5KiwlB5Q
 xV0ZevYRqgYEthLsuUl9UlLjkd1sw7prnZMDSJPLGrscqKw5/Zg==
X-Google-Smtp-Source: AGHT+IHy1gi3Gl3sGhV37Y8wMR6ETRhZhwmkYD1U9R0Hmr7s2obQ3e4wKUn0WbmhGq6SEMmI6bs5fA==
X-Received: by 2002:a05:622a:5143:b0:4a5:9993:ede8 with SMTP id
 d75a77b69052e-4a82eaa4ac3mr57736951cf.15.1751377780453; 
 Tue, 01 Jul 2025 06:49:40 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a7fc1586f8sm75507191cf.33.2025.07.01.06.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 06:49:40 -0700 (PDT)
Date: Tue, 1 Jul 2025 06:49:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Gagandeep Singh <g.singh@nxp.com>
Subject: Re: [v5 8/9] bus/dpaa: improve DPAA cleanup
Message-ID: <20250701064937.20a91fb4@hermes.local>
In-Reply-To: <20250701113707.2793004-9-vanshika.shukla@nxp.com>
References: <20250611071039.2939950-1-vanshika.shukla@nxp.com>
 <20250701113707.2793004-1-vanshika.shukla@nxp.com>
 <20250701113707.2793004-9-vanshika.shukla@nxp.com>
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

On Tue,  1 Jul 2025 17:07:06 +0530
vanshika.shukla@nxp.com wrote:

> +/* Adding destructor for double check in case non-gracefully
> + * exit.
> + */
> +static void __attribute__((destructor(103)))
> +dpaa_finish(void)
>  {

This code should be using RTE_FINI_PRIO in rte_common.h rather
than using attribute directly.
