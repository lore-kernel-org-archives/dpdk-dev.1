Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8845ACCD1A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 13:38:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A58440616;
	Tue, 21 Oct 2025 15:38:36 +0200 (CEST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id A1278400D5
 for <dev@dpdk.org>; Tue, 21 Oct 2025 15:38:34 +0200 (CEST)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-87c103928ffso83910376d6.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 06:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761053914;
 x=1761658714; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GKMeCbjiEokWkSmfHTcZfVKHNkIxiZdoYCGf5Tz2QCM=;
 b=ImaeVpM5iFzNpWXMT7Qk6K/M9JQM7Mi6U8lqYIEVjEvwy7Tu+c9Igj0hqfjEfi3r3D
 IW9oK6Q6qqy6ofqpNpnzWcDwqH3oxlA/i1lz6rMgLbpHFg/hOhHCLquFupBTfmSP24s5
 MjQfVQ4XHDdbJtaH1QsgseqzY1XkOQ2CpVV35ZIpIeTdonvdUzVLveD22iX974dfX7Ft
 YH0OPdFIZtaQh2m9a/uqOGNzv+iU+e3wSbR4kKdyviQYg3KK3rjkXhuPDVcFlQl8dXc3
 0NZ+eV/cYGLwCBUOuf7FXa8iNUiOiVgRqTd/MUaTpHEp/1V1f/Rlg3nEeuziVyz1fYJM
 ipWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761053914; x=1761658714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GKMeCbjiEokWkSmfHTcZfVKHNkIxiZdoYCGf5Tz2QCM=;
 b=rTa0Mt7REPdV0QMhr9JskUD9oek21vRDAXHf6Ms5qEHAwMukmqjeLReqJC772J1+WL
 BlLBOVX7mLqhPUFCQJe4jaWtnvJaBuryGF8gghIn2bGDpMa3rjYJ8REtDpPVweilNINe
 UgDibSp4I6STgQSTETK0pJOK+py9dfi7XnjATD5b/nn35SW67Y+PTDXXAn4Vnxv+FeAo
 l1j1B/rHjG1Bn62m/oDS0NeZmohDLsLlm19jKQ3mIU6wyowzcZCOfgqPoiX4VHrUcrTT
 REXqkE/2yS38rvkL7/0VYQ0j+EoqPw17OF4ee9fBtFitKDwvVVwwMnupdUZRXeR2cdBG
 hhHA==
X-Gm-Message-State: AOJu0YzgFzRa9XhGPaeTOyV1k4gYLkxz6oI5fGnlvAF87jVbtBcMEzc5
 tZLt+V2rIbv7HPu7QdLevhRShcrsbjEQ/Jf2FO6uLlfH86n7cO7wO47+fYukgiZdplQ=
X-Gm-Gg: ASbGnctAxJhVrSE5agBuYqdUhbJec68shpkkU5y2NBRfDnpTJ7uQc3yUgUnLcOFkvFK
 izlGztC4pL8J4Qi200KryB/9Y65AWMiqLB5ka9NIB4+dvwqdYJ3wNd/v356aCGOfyOQPO6IpyQ9
 D/hIAJVDELItiiytfvow6+D1m1W4ZSE1wnL6cF6PmHja4vR9T3bBHPQj7Voo/vqMy+aviSguGOv
 PjF51Tf0PcCotmSJRce791RWVb5KQabIcY9Pgq6lhJ/ubjG7UiM+9iEMEEkujAeVG+sa3YBI1Cv
 bZPIM2MbO7sRm/EV3qQz25RxhbFsdsjy+qx4gZihbtr7s2+BmjjO76+/UxpZ93UFOXp6UXUJTfD
 fIeJCHVCiBW3RUZmpNqIrOg5S9nELJKVd2uMay+ySU+ZufMBLNL316MOk/z036s+rfPBeYOIMZP
 YiLcqCxhSS3LftxLcvmObXsJX8xYVqUWDxi+RuhxA=
X-Google-Smtp-Source: AGHT+IF4J2A5tFVVuPkwNiTy6eNVmJYo+nLx6GKDvZT3UZSBxFbSNAxd7KRPw2I2eVmksr6rwNmKmA==
X-Received: by 2002:a05:6214:1c81:b0:87c:f97:7acf with SMTP id
 6a1803df08f44-87c20653c2emr211434286d6.62.1761053913602; 
 Tue, 21 Oct 2025 06:38:33 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87d028b2ebfsm69023436d6.52.2025.10.21.06.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 06:38:33 -0700 (PDT)
Date: Tue, 21 Oct 2025 06:38:30 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Konstantin Ananyev
 <konstantin.v.ananyev@yandex.ru>
Subject: Re: BPF elf examples
Message-ID: <20251021063830.1202be65@phoenix.lan>
In-Reply-To: <1c2a834602b440d6841ea8120ae37db2@huawei.com>
References: <20251020131631.2a6a0de3@phoenix.lan>
 <1c2a834602b440d6841ea8120ae37db2@huawei.com>
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

On Tue, 21 Oct 2025 11:42:25 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> > -----Original Message-----
> > Tried using AI to generate tests, and as usual it sort of worked but the
> > example code generated won't load or work. Is there anywhere to find working
> > DPDK examples of using BPF load?  
> 
> Hello! I'm sitting on some patches adding a framework for generating BPF ELF 
> files using libelf and some basic unit tests based on it. Hopefully I'll be 
> able to upstream it within the next couple of months.
> 
> Generating ELF files is probably beyond the reach of current AI, but once the 
> framework is there perhaps it could be used to add test cases, would be 
> interesting to try...

I have sample programs now (thanks AI). But building them in meson is messy.
And integrating standalone files in UT is brittle.
Perhaps using bpftool like tap driver does to generate a header file (.h) and
then have UT write a /tmp file to load.
