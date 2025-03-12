Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6F1C28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 16:11:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88E4C40663;
	Wed, 12 Mar 2025 17:11:15 +0100 (CET)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id 99BDB402D3
 for <dev@dpdk.org>; Wed, 12 Mar 2025 17:11:14 +0100 (CET)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-224191d92e4so319275ad.3
 for <dev@dpdk.org>; Wed, 12 Mar 2025 09:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741795873;
 x=1742400673; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aI4QP+CmTwpZ/YWxctGXTTaM1zcLUfJC6GOvBPOjkCA=;
 b=AjCbxakvjuDK6wIncnXKXcM7o8t+hZJlxVmMqZ/tJ9aTiToJNJH1lffVzr4aHXzMPv
 QZ8MllxvUJHn67P157ee3AqWAqRJKQdBGAjNmDDBVWVkFdig1nxag36/JNGVR45RMoN4
 n02OBiaB2jOOOxhEL6S82K+cYUTlsVYS8NZaKrojEj4sBKPFUzMvwUyub21SbQDhyXvG
 +5o1SJny/t2+kH1prMCRoLyD7mTS2rqRnPHBAjrRrvoh+CcQzDQFE33biWVsalqOdWm7
 MiWOpXcYG5j6NN4q6wBJe2smNN1eYIsFNkaVVeZgdfaUtyogl0viFqH4VzwimBlq4Urn
 sZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741795873; x=1742400673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aI4QP+CmTwpZ/YWxctGXTTaM1zcLUfJC6GOvBPOjkCA=;
 b=i5GND5toDYStI/tidnKudZSQyOOQ+5ki2hYlpc/WhKReOgosYd8dDbWWaMDdHmXINz
 Eh7UIKgkIeYVQVsmsG1TN8mggXgX+e1Mb5uNYLufrI1S/9fepsv8KsGQtWBCdAZl4vFv
 SeJpIeX5MV3xKFc7eNY3Q1Ewt8FOPsccH/aBsak3/GJx45BWuY036vdpVMoa0Q8bnQBH
 0wJeVfKEaPOe9EsUo4QhFAPdMxECpBX9WFGVDygeoDhQSFh/pPVhNlqDHc96bOPmSrZU
 c4Mi7PRwsYKyuczzkkTLKXA+s7TyFaGTBxmrY7ygsiU8XjJdYFQFghDzydymJlCLdLHj
 KnSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoHbZL9Fft6VbUF32pSsoGKVriO0vQnHIFtlAVpGjipxb38Qo4ATg2Pdrsi8uJfzK3n+c=@dpdk.org
X-Gm-Message-State: AOJu0YwYxl5b3NkZkMmngHlTjnmNE3T4IfRIpb9+do2Z6b9kJlawWvTX
 p+AJ0NJtaJSAfxDPhRhUV05rePSoCTdidwtviACSHAMeFQDnlWaF23PWNpxoOFI=
X-Gm-Gg: ASbGncvtOTBfjplso9ysQnX6SCFqgXKg7S3QBY6D1/loVVxwWl9zyr1ZqLmO+7P7WvV
 z3HyFuuC9cBD3EQ5HaxJeXBD478sMufKeiw171VBwvadnFaNH3q6PXeBQhBSp5VzhgCVS2454vb
 QEHSqVHfYAnK5nz73PqsA01TssxDgvAKGlkFm7wWxH5zaMoehqPyImiEgoAFkeO0JV1r6EqJVJg
 WOFm3/e4k3acLYbeedjxcuo4dcGpNSERdM5up5zmFXOOXyyeUtTuXsOTxE1uSH49GfjcGRRZDWg
 DfTztWs/21gTVuK859gb1/Jg8du8sTNwp2ahrp3kRjzj6M/sAWZB4eNk1UhwpGMzVU1QFe8ZVce
 bT0piaLNe3gjAXBYZIdQWFA==
X-Google-Smtp-Source: AGHT+IFedYUqtdcqkvc7iLDP13hqi1GTXH4if3UspAwv1v92PSQTIdMmc7bScQ2EbZqHuZaeqyPR6w==
X-Received: by 2002:a17:902:e745:b0:223:88af:2c30 with SMTP id
 d9443c01a7336-2242889760dmr330460735ad.16.1741795873658; 
 Wed, 12 Mar 2025 09:11:13 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410ab9e39sm117837945ad.252.2025.03.12.09.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 09:11:13 -0700 (PDT)
Date: Wed, 12 Mar 2025 09:11:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, William Tu
 <u9012063@gmail.com>, dev@dpdk.org, andremue@linux.microsoft.com
Subject: Re: [PATCH] net/intel: remove unnecessary compiler flag for mingw
Message-ID: <20250312091110.64b77903@hermes.local>
In-Reply-To: <CAJFAV8zAhG3U9h1A=UEu_eUjLBEV+FjuZffZg8+SwEcSuwN9ww@mail.gmail.com>
References: <20250312155458.1395709-1-bruce.richardson@intel.com>
 <CAJFAV8zAhG3U9h1A=UEu_eUjLBEV+FjuZffZg8+SwEcSuwN9ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 12 Mar 2025 16:58:49 +0100
David Marchand <david.marchand@redhat.com> wrote:

> On Wed, Mar 12, 2025 at 4:55=E2=80=AFPM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > There was an issue with building DPDK using mingw v8.1[1], which
> > required using the "-fno-asynchronous-unwind-tables" compiler flag when
> > building using the mingw compiler. However, recent versions of the
> > compiler no longer seem to need this flag, so remove it.
> >
> > [1] https://inbox.dpdk.org/dev/CAJFAV8z3qFhT9Vv5xOpLhi74BYAht2YCfL2ffLr=
mei4hfSG5jg@mail.gmail.com
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com> =20
>=20
> Adding William in the loop.

Should add documentation and check for required version of mingw?
