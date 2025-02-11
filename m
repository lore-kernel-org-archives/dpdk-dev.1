Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43125C0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 22:12:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 934B240E0C;
	Tue, 11 Feb 2025 23:12:19 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 52D454027C
 for <dev@dpdk.org>; Tue, 11 Feb 2025 23:12:17 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-21f44e7eae4so103253325ad.2
 for <dev@dpdk.org>; Tue, 11 Feb 2025 14:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739311936;
 x=1739916736; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zp5ezIEdtXDwGX3qP69HJECpB4P/fRIFqtLaZysckNk=;
 b=oqVz1tyGjzH/hNCz/2m6AucapnJCpS7Tse+BAPYhN0cU2VCiAl0e94WyvdsKxbb8hV
 rWswv7AaTpF3pUwqK+lbw+vriSwHsXBZexiNS8ktgCZGaoBaffATQNrZW4r+EImIdx9r
 Xp/2SdDjGfH8wW9CZlFDGulrCLayHv+GYXxIRuZSx2bvURLeK4S8WZlqme8ulCUC8H8+
 w1pUYnCsHnRbMejfnctYbgFsAqIfXxO4rdplgZjrHM4VWAj5Z/HoDggN/FzmYypDeQy8
 0cg9jG+l+33HC/Y67pHcDnSaHawEkNK4IGarPGsmtgMvftUQ/oALA1HNbi8sPvGhag7T
 Nybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739311936; x=1739916736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zp5ezIEdtXDwGX3qP69HJECpB4P/fRIFqtLaZysckNk=;
 b=ZqcRkSplcLbr9pM66MueD19BcrxWPiGdqN9+B+fU2RNMnfuw9Y6zGs5c5Ji+mSSUf/
 BoLxc4mgGJ5XiHtGATeli+Sjq3ZBk+/vmBsZvcFnzAsddTqZ50TVCA9u98Ql/leTXe2W
 xfSNntZaXZ6QZhdEmlJWhpwCGx9xZcf1qcr3myDnokmFxv85nLIUlxc1l6HByj3QOuJN
 Uhic17fP7fVSz43itiGI6bu4eIFhddJXvdW22yadJYeDJuZKb8VHKzXguNTOtDvu6wp8
 pXWUcItwo5nLYpHtP1gKoUwUjYlLLHVIHmhvXDW+PDCSbwJ/LfyWI479riWLKKrwPnT+
 lJUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYLg0zQV+nsUYCm1qKeBaer5Oqi8qe51DjB5UBN++GlGLFk71DWzFQo9M7+qIa8WyF5Y4=@dpdk.org
X-Gm-Message-State: AOJu0YzZtO5A1DfpHbSPHkYHHlMffNXe8Sn+8Bs4OELupLVZY749ZEVv
 CM8rLxkUZ/ULKppPqKttuFrP11DbDcht7qSNlCg3QfMaoX2rY/UkylGG97LRDMA=
X-Gm-Gg: ASbGnctiBQc/Cg27h7WBwHq7zGywKn0DnrUg/wfqDDaFuqnKaFFpHPQpcqpD2BewpFu
 mnrQde5fsyQ7PtK+rXA6BnNdlp1IiRR5RQHWX+rXD0Rw9wssq7MRSG26/nzV4zFmMH4npgMKorZ
 IMt6VfiJ6tduElEQCeR11TUBFym5z8E0DvU73hjmw/uifadDtDYWIwXvNctkzKwDfB49dF8gbbw
 F7spobKI6np04GMqIvbD6Bmv74HUZ6TON2F6vZv6UWJtSimNg88srHAktrrbMZKxT77MGpDBRc9
 NtTG5K+TbkeykFki2oK2UMsqtRXEJ12Zd4YyKkalnjZOvbrnnMr/+k2nKNd52MoOzXIN
X-Google-Smtp-Source: AGHT+IFsBL/6vIzySKqN9xdsQWA4ZQVoSAvpnK4ctRHW62pN69GtHS67Sjhrtxct7iQ1o0az68acfA==
X-Received: by 2002:a05:6a00:c90:b0:730:f1b7:9bc4 with SMTP id
 d2e1a72fcca58-7322c376a1cmr930446b3a.4.1739311936464; 
 Tue, 11 Feb 2025 14:12:16 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732190891efsm2091315b3a.131.2025.02.11.14.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 14:12:16 -0800 (PST)
Date: Tue, 11 Feb 2025 14:12:12 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>, Konstantin Ananyev
 <konstantin.v.ananyev@yandex.ru>, dev@dpdk.org
Subject: Re: [PATCH 08/10] test-pmd: declare lcore_count atomic when using
 C11 memory model
Message-ID: <20250211141212.45e90ab2@hermes.local>
In-Reply-To: <1739311325-14425-9-git-send-email-andremue@linux.microsoft.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1739311325-14425-9-git-send-email-andremue@linux.microsoft.com>
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

On Tue, 11 Feb 2025 14:02:04 -0800
Andre Muezerie <andremue@linux.microsoft.com> wrote:

> Compiling with MSVC results in the error below:
> 
> app/test/test_ring_perf.c(197): error C7712: address argument to atomic
>     operation must be a pointer to an atomic integer,
>     'volatile unsigned int *' is not valid
> 
> The fix is to mark lcore_count as atomic when using C11 memory model.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Prefer using RTE_ATOMIC() all teh time now.
