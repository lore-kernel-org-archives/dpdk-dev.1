Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8413C3DA6D
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 15:55:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD96940A8A;
	Tue, 20 May 2025 17:55:29 +0200 (CEST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id 8F87D4029C
 for <dev@dpdk.org>; Tue, 20 May 2025 17:55:28 +0200 (CEST)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-7c9376c4dbaso641281485a.0
 for <dev@dpdk.org>; Tue, 20 May 2025 08:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1747756528;
 x=1748361328; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9oe1h+GlcjWNgNoQ5gjzVNmTWk6gOp4BLuj+OGfLgAk=;
 b=kDXwyITbFNriQrIo+1iNM42v1Aua+pRf21vvo65WpLL3yjxSjW+AzYQSY7kLZNQKzr
 veEpO9QqOicBPIqAQ8s/gFLiRKBoswmkxBgdEqnGP2nyKDxU/taRRpULF4mg9e8y66RG
 cSWBp1QzE2mNzRi56YQCVj9sOm9S+8cvjvlZESCl+Yn1EdpP189OO6C4akn3qag9AMJ9
 juqRYEvoKXS/s44bdTi6PTNSIiA3q3293WFD5BjRGpIibCEXlT/KEMKrQxVkh5seJMEP
 b2P+VnjICbkNQGthI/DtleCZOKItwXiagIcdzqcTIMklgAfYJPlkix+Fv0isvG8K+f0t
 +jTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747756528; x=1748361328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9oe1h+GlcjWNgNoQ5gjzVNmTWk6gOp4BLuj+OGfLgAk=;
 b=RpDL5KMf4vVqU7rrQOsXVEewc3A6wT6AlpqVweQQ9FCXA04Ode3vex4KVfTvC6cS2s
 UhdK0+9J9efXtImBJbYWrWTGBwJ2sQiTx+K5svEdwjv7nTFVu/q4L9gvBy3CbV292PBq
 ZcfGrPLdRtrmAvxREShrVcktC8eJrcpuPwl5hPxg1B8RD1SH5rHIE2OzAv4Ob/vpnquW
 XSj55m5m+niKLYhOGqnZaDwWgIpPZH5H2Tvi1i9A+fJi0bpxgGl1Xh5ElZe81sC0HF6K
 tBolSGkWWEJ6CmpU3RHadSFT6TZAImdoDtqV7YhoqpTfOOq0SE/xg1dpLAsDklQz55tp
 W+ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnkvpiJYUtD1Nt78L+0IwkuzCZlnxhocLFADotMYcf3GDfY5dGtvTH/3mMKAHCOt+Ed7c=@dpdk.org
X-Gm-Message-State: AOJu0YwNuHd30PJpm5YVKpvpEe7DkUJ49XdekpkJfb1pZ6Iyf+RJDnsc
 Yqvb/+VYAztus1yI/E3v9oRCNZAHr/2CgF+l7v2fzpW/J9mjC8Yb+DLwdYU1MlcbxlY=
X-Gm-Gg: ASbGncvgQ4plLhCmNwr8vWNz44HDX2BkCKsuXe28ZPDCppi4XtAsbrNefo3dmjkwdmE
 pqmhhlH+fKblLiiHM54KIgGj+/ZtLsxbPAH0e+bRl70cXQcseY1KVpc8aBBGnPhZkRKLtjI3k+e
 K9fda3MeITV75hs6plIbD+Hd8bcwSTxWoZ+LoO1GccHQaGIzJranXG6aLUO5pI/RW2xdY4OBMOj
 c5P4L5z1vGXQHy4KTsoR5T3LFd1EpwTEGGJxg+RIzBT5VsQToPEbKyET3g24ja79lfCUuwQvbys
 qGrljno6iQXlmpc2stFkT20NvxuH+muL6iG/RZQpKxE1XvUUuATW3YnEIhrrNLQLCBlt7H1Mc+D
 jOw36K4OKmhhkhtfzcgpj++9XPl/d
X-Google-Smtp-Source: AGHT+IGNpQ3gALoAbwM5TazfnjXoAn/R5eikwmBdtHkrFMTCmvH/9yOHPgLgOIE95DMqK7MOQ1AtoQ==
X-Received: by 2002:a05:620a:271e:b0:7c7:b570:e2b1 with SMTP id
 af79cd13be357-7cd39dccc33mr3910985185a.7.1747756527767; 
 Tue, 20 May 2025 08:55:27 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd468b6cb3sm748495585a.69.2025.05.20.08.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 08:55:27 -0700 (PDT)
Date: Tue, 20 May 2025 08:55:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: luyan <973788536@qq.com>
Cc: maxime.coquelin@redhat.com, chenbox@nvidia.com, dev@dpdk.org, luyan
 <luyan@cmss.chinamobile.com>
Subject: Re: [PATCH] net/tap: fix add qdisc failed when create tap
Message-ID: <20250520085520.0bda787d@hermes.local>
In-Reply-To: <tencent_C80031E4649A04EFE84C39ACCC8938FEBA06@qq.com>
References: <tencent_C80031E4649A04EFE84C39ACCC8938FEBA06@qq.com>
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

On Mon, 12 May 2025 16:22:04 +0800
luyan <973788536@qq.com> wrote:

> From: luyan <luyan@cmss.chinamobile.com>
> 
> The errno variable was assigned a positive value in the previous handling,
> but here it is compared against -EEXIST,
> When the tap already exists, this would falsely report an error.
> 
> Signed-off-by: luyan <luyan@cmss.chinamobile.com>

Patch looks good, but the commit message needs a couple of changes.

* DPDK uses a .mailmap file to keep track of all the contributors.
  You should add your email to that.
* Please use your full legal name in the Signed-off-by: portion.
  Is that your full name?
* Since this fixes a bug, please add a fixes tag like:

Fixes: 6fc6de7e0eaf ("net/tap: update netlink error code management")
