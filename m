Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826E9CA101F
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Sep 2025 15:32:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6CC44066E;
	Fri, 12 Sep 2025 17:32:13 +0200 (CEST)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48]) by mails.dpdk.org (Postfix) with ESMTP id 896F14065E
 for <dev@dpdk.org>; Fri, 12 Sep 2025 17:32:12 +0200 (CEST)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-7222f8f2b44so18418366d6.2
 for <dev@dpdk.org>; Fri, 12 Sep 2025 08:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757691132;
 x=1758295932; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kzQk5bQmXreBvp+YZrzIQLIVhSSsVbaJ3XBdIvXLT1g=;
 b=z3K4gPWttVbGB3V4TdpQAqVupSEtHGMwpphAaB61tW25U5Ndm/QUIzg76Ig+jVlheI
 3LbdH7zCLVEr4ygHsXlDyvntK4+b2xAvJ7GrNf+t9chgttyUzlhD181CsRF8xTVp0Xzv
 wtcUOrXBEH2FlcMDYFwhGB5m/v9Z3/dI31ER5Qw8T6U0whj7Qt8uZfg2SnT1zZJhrmrB
 rszoshKkrSw+MHioVJAB0WmzLIVuMTw7e3egYdrqHIND1/pW5z6YZ/8IXeN3LFDGXtyz
 DZF9ubyXWKMFoHD0boVOrEhbiMF2X/cpnqkBkrbDt1xhubeeNIdS+9fTKEtfDKLTKGn5
 07MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757691132; x=1758295932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kzQk5bQmXreBvp+YZrzIQLIVhSSsVbaJ3XBdIvXLT1g=;
 b=Bv9FA/GvT7+bKA+87OAomtFljPa536URCf9s5mxhEUK4rtM6UKSRzkWlW0Y+VqHJlK
 cTHeMeE1My6y0S9z8hANXbtT7hA1ZuAuGCi112yEXQwxrJmKpEph6KPMdASKRuDg/ypF
 pRjpfMNsJRIBVja1BjwdvKDsQrcaKwyzj1IQpAjzSe9pELuc8g6HK2D1xnDqysqfdhap
 RbCtAvqnxB0mB7b8CC8TJtLPSizdwgg1FtPX+oKpAIeg1p1OyGFT/Os6E6U4oZ+0cV5j
 9OEeF2KTNcRrjfP2mmFcSZAjoPNwoMvKN3RmeeYIQrafwYLvKHjoq0rq++KlgzRAOifU
 o3UA==
X-Gm-Message-State: AOJu0YxQzfEMH4m0xQcglyfWXvPZNujeX8IHF9zChazuoWwH7/i0qiHU
 ukD/UujWz+R8oUIv0SMu0uAL8FAZXLkXCpMqDxuEtzd14YZB7v3GLKw8YUETUUk7LtQp7JHBX70
 Tm5PF
X-Gm-Gg: ASbGncvV1ycdxlqkMVzAtmd5I3rkzW2aPy5L6cFBgm21wQ2hK89mKPfzJhkRqbob7D5
 OJeibX9rHTZzAdRdUcMlT/259OgK4kC8hrP90IPa+NPytWFL+xcJ8X1s9uBfcv8W28qxOf/qgg3
 a7EHiZPxW8jskfcG6KqoywpnCA9a6TVmTuxVMaUcTBGyivKzghHmIFffqOa4S946GqFNA2sOHYY
 nXcdutWJiLnsOx+MEX3gKEWZnCrndSfQH16tlKRkVNeE7SMmMmfs6XiJsL5MaNDDiMgxy3aPwqV
 zeoBzVWX0W21FYq8hv1uj2DGHBN8HNx/e6QWaVf9uVgo+uPa9eQnLlqxGimKA9pQLUEhYoUYawB
 Shap8c07b/s7Ks9WbTfqdgiy7QjG+713I62d3bOq9Jl5vgI9S+6p/KKF6riyQGAS7/HI/124Bsy
 zRTnY7ktG+GA==
X-Google-Smtp-Source: AGHT+IG0NED94sWJ0KYh2e5P9CmVELnrVpIzfkMtGHXWXdPuN61moDeSIHr+hri09SiZ5DGZok6tjw==
X-Received: by 2002:ad4:5dc2:0:b0:70d:aa75:cba with SMTP id
 6a1803df08f44-767c3a546e6mr49290186d6.47.1757691131069; 
 Fri, 12 Sep 2025 08:32:11 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-763b450b4a2sm29206476d6.6.2025.09.12.08.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 08:32:10 -0700 (PDT)
Date: Fri, 12 Sep 2025 08:32:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1] net/zxdh: add support compiling on riscv-64 systems
Message-ID: <20250912083207.12fd501a@hermes.local>
In-Reply-To: <20250911023211.3576860-1-wang.junlong1@zte.com.cn>
References: <20250911023211.3576860-1-wang.junlong1@zte.com.cn>
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

On Thu, 11 Sep 2025 10:32:11 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> modify meson.build for support compiling on riscv-64 systems
> 
> Signed-off-by: Junlong Wang <wang.junlong1@zte.com.cn>
> ---

Queued to next-net
