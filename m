Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1695C369A4
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 13:45:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2883740E3A;
	Tue,  8 Apr 2025 15:45:41 +0200 (CEST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by mails.dpdk.org (Postfix) with ESMTP id 16D2140264;
 Tue,  8 Apr 2025 15:45:39 +0200 (CEST)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-6ff07872097so51239697b3.3; 
 Tue, 08 Apr 2025 06:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744119938; x=1744724738;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b8x5BW99WjgCZxkEvrZK/jRALuNN+6kIaQ1d2vJrYDE=;
 b=EcWl9JAxH35NudbdZtWiysBcND/036nCaJD2z4Pcdx2yIDHjyBt8+doc+yS6Td+JA6
 YKrTDRQM2+Q+kBmCEl+XPBfJQ2zVnJpAsjfRfLNH9LKH3Cgc3tI4FRqiU34NYYXJ7LDN
 SvneQxWZQcChsZnmd7PG9R1t8YwclQuggl9+Y/pX/iv1LT0vXGbjXskLglqFKfSjQqgG
 DfbqHtjChZmRu2q9UslpNxEdh7OzYWYuiVtSrxPgcFsbRDLVi8OodvTUFeRkyjeoHNwq
 yLU8vwwIdF5/Qimb4oOl37YN+3jeas4SJJALERFxsTHs5EVoYQSzI2PNMITRsQvm6WVm
 iNUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdA8jC6THkMe+eXpOsIWdnmVD4ZW2GsRmqHnX2pQSSeCaWMqLQm1CSL2GhIepmU5sibmZH84s=@dpdk.org
X-Gm-Message-State: AOJu0Ywk8VGmM8Av+10YCwLIMiDyVADpnCODlE6vInZ2T9VXCTnL0t44
 cxfyt1HDxHACZ8+Pge0qReOb3wIwxZ+WKiX6Z+gPuTkxSvZ7Ff8f6R7Wf5J/
X-Gm-Gg: ASbGncs+YTCsKO8VtRntjrC5YuxUZBOi/aFbbEGayvSh1XqQhIhb5I13CxL1IDCUiiy
 /9vQ2FLfsLenu6t300EPROVtNILkjpLAi6olhfTaQAc1MZEEZEvJExREj3rzEm8T5z3qoLmqXZG
 SXQ3DOoArNac8t5cAnQrNAv1Qr2Pu4AFww2oDyXV8oo1TyuAp+mDO1801JSGCtfeMsVLFIbt+8W
 rJwHTxBorrG/7kitl8iZTK6OxsVsul0hNXqIQWXpUImkb/kzhnLYPBOEJaJsObPOvnRD+U00GbL
 kIBHulIab4pEny2qjWEIrkay0JEF4eLcnY0ps20naTHmZdsScSVSMkpqZCjuP6Imfdsox2J2kT6
 gOH+hTseSvj2nBpKj
X-Google-Smtp-Source: AGHT+IHtSHd7NbcrDwB/GRV+bDLr3Vhg7t8m01w0/8zvPeNWHxkgeY6VcFGosUQnChpRMemokVtPWA==
X-Received: by 2002:a05:690c:f82:b0:6f6:d01c:af1f with SMTP id
 00721157ae682-703e15370demr286642167b3.16.1744119938263; 
 Tue, 08 Apr 2025 06:45:38 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com.
 [209.85.219.173]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-703d1e4e45csm30810647b3.33.2025.04.08.06.45.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 06:45:37 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id
 3f1490d57ef6-e6e2971f79fso2687544276.0; 
 Tue, 08 Apr 2025 06:45:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXBGidhnf8z03Xe5CZX19+cB3/ZSxIcsfmWdpp/MwqwY3E0irWPfo0wl3uCLs6xDcD9HfV0w4I=@dpdk.org
X-Received: by 2002:a05:6902:2513:b0:e65:f1b9:b102 with SMTP id
 3f1490d57ef6-e6e1c223e6cmr27758510276.23.1744119937710; Tue, 08 Apr 2025
 06:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250326115132.1444530-1-luca.boccassi@gmail.com>
In-Reply-To: <20250326115132.1444530-1-luca.boccassi@gmail.com>
From: Luca Boccassi <bluca@debian.org>
Date: Tue, 8 Apr 2025 14:45:26 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnTOVHyvNxGbcFWRt2Xw0YqRXnKC9VjzVOsEn=utu+mrCw@mail.gmail.com>
X-Gm-Features: ATxdqUGU67TK9g4zFoNOg_rMr_pebVOZkeoJzTN0bOc79glaZJueylZl3bIy5fg
Message-ID: <CAMw=ZnTOVHyvNxGbcFWRt2Xw0YqRXnKC9VjzVOsEn=utu+mrCw@mail.gmail.com>
Subject: Re: 22.11.8 patches review and test
To: Ali Alnubani <alialnu@nvidia.com>, Raslan Darawsheh <rasland@nvidia.com>
Cc: dev@dpdk.org, John McNamara <john.mcnamara@intel.com>, 
 Thomas Monjalon <thomas@monjalon.net>, stable@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 26 Mar 2025 at 11:51, <luca.boccassi@gmail.com> wrote:
>
> Hi all,
>
> Here is a list of patches targeted for stable release 22.11.8.
>
> The planned date for the final release is 2025/04/10.
>
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>     https://dpdk.org/browse/dpdk-stable/tag/?id=v22.11.8-rc1
>
> These patches are located at branch 22.11 of dpdk-stable repo:
>     https://dpdk.org/browse/dpdk-stable/

Hi Ali and Raslan,

Will the NVIDIA validation team have bandwidth to run the tests for
22.11 for this round? Thanks!
