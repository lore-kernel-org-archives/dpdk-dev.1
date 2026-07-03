Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6063EC43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 14:12:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CB86402C5;
	Fri,  3 Jul 2026 16:12:50 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 811F84026F
 for <dev@dpdk.org>; Fri,  3 Jul 2026 16:12:48 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso672926a91.1
 for <dev@dpdk.org>; Fri, 03 Jul 2026 07:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1783087967;
 x=1783692767; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rHHGsX+NvLBRPkAD5YWvToqk18b6NhrQnQQ21FWLzVI=;
 b=u88PfYPR62XSe40QfHZMhFnpB1czE1u53kUay4mHsno2fDGDXfikjbl+np8kVbKjCN
 DFITqTomkl7oqAaREMoj7Yj6DdS23kJHwt+HGZdunBkdP7R0b5htfAkKwbLfqvdgpJuO
 X9vYyKsDP1/ZFp4WG+szrvfA5DiDqFrjbzzCk9oFFu9zhU8mRstjzcjFPAZVKPl9rqBD
 vZBjC0wizrqx61424dowo+xKBE+XliLTbX9oIlkAPX1Hnmu3H8e56Klk5hbtgT5+be0X
 hJEsz0hQRGIpnZfG0Yow/TVv8sAhwceJSDMQZE+/WQ5gxvgQShGOD9OxyfMoXinZ1Ij7
 rcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783087967; x=1783692767;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rHHGsX+NvLBRPkAD5YWvToqk18b6NhrQnQQ21FWLzVI=;
 b=NBW8RcSmNxhXvC+89tjrm1fhlUlVrtKo3miNtG39K5G+Vnpr+Jv3H7wBMGuum5Z72w
 uh8a3v7WAKzr42qYmk2w4hDm/sY3MOMtTxYedzW7r1eUw5xJMbM0/EGJXaDPF9DctayI
 EZ6iICiZz88vnLpO9UqqTNny+eftmVl7RdqTX1lVsN0ykz/VrMPDzUhhITX1jvRYe3KF
 eirv54Z3fvCg0t0Wl0tyRYNgnrJspkOQmD0wxU2jSJWdD6NgcPw4d+VlGsYGZvhxHvFf
 PK5T/RZutRQAEwpLE7tuAgDQerjGA7dOTPxMoHDACYFFp56fU0YyI1jdbzPGbV8zUUr7
 YmQw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoQHRCVmekU61fwTiDP+v3OOLbokVW4pbO1S/m9+I3fU5m2gvbVCMfwvH6HYuso2HlBhzo=@dpdk.org
X-Gm-Message-State: AOJu0Yz4z1q/aU2Yes5Rf85RcmFsIoTVAXhaqwl2c4tQYjr9Nu/z3WH0
 9uwh+rnFHTmGzPc/3VDp2qVkU13sYz33gxcDoCZAZv06s0MExPOe5NV4oASNiy0LwEI=
X-Gm-Gg: AfdE7cl6Cy87cLO0MO7o5mYb07dDv/0xsE8L8MG/qYAC8blvYoVCGVkdLsxV49aVRwY
 L1iTMb92rVpR2agvyUqy6nTbvgLqYLFt4UH8Gc3LG7TogSL6vvXJfaPIcOLyuEfLTGKFHJ2JY/Y
 qCwp7eixNlIXHr5f5Lh+dSeCJf8cYopV4zl5RpnzZPqukLWucUruDS8YnD1927ex8mtAhogpPl1
 SWpUiDurVd/qYH2o7eztpg38DuwWy34JptdFCNXwTndmFRkdpp1pOrEKdIpXcZ7WfkdTzxZ91pg
 itAzxusz/vHOIGrs6HsI2nZ+VkUYqpUL/O97RdzBBp/iPRF50te3X35PMcFlpCLd7CoBCqYrj9Z
 lGvk/shNdP9hMuVoQ3idOJddlBvsvfZfJ5YBE+GLYCvGBfKeX2IspXVA6IfWGgjjbf4YeHw7OiU
 6M8uzCUvdSsDXyOWsFFXazij20MCBNULz56fP+nfXvxe4zCQzv2LOXNw==
X-Received: by 2002:a17:90b:3890:b0:36d:b424:4f17 with SMTP id
 98e67ed59e1d1-380ba84bdd8mr9906759a91.1.1783087967394; 
 Fri, 03 Jul 2026 07:12:47 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f3c8b19c7sm289064eec.4.2026.07.03.07.12.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 07:12:47 -0700 (PDT)
Date: Fri, 3 Jul 2026 07:12:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH] test/bpf: remove validation tests from CI
Message-ID: <20260703071244.4c6fd3c3@phoenix.local>
In-Reply-To: <2751fd1fa6d648a9b7f95797f13ef28b@huawei.com>
References: <20260703022738.2574548-1-thomas@monjalon.net>
 <2751fd1fa6d648a9b7f95797f13ef28b@huawei.com>
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

On Fri, 3 Jul 2026 08:48:33 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> > The new tests for BPF validation are triggering a strange issue
> > in GitHub Action: the last tests are killed by signal 7 SIGBUS.
> > 
> > The series fixing a lot of BPF issues was merged
> > but the related test has to be removed from the fast tests suite
> > which runs in some CI jobs.
> > 
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>  
> 
> I think I know the issue, it's tmpfs exhaustion. After some recent changes each
> test consumes 25MB in the --file-prefix directory independently, easily driving
> small VMs out of space. My ~30 new tests were the last drop for the CI.
> 
> I will try to prepare a fix today, of course please do everything that's
> needed for the CI stability meanwhile.

The BPF tests should be using unit_test_suite_runner instead of separate tests.
That would help.
