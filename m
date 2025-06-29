Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24E6C7EE39
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 16:49:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0DEA402D2;
	Sun, 29 Jun 2025 18:49:36 +0200 (CEST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id 9789F40288
 for <dev@dpdk.org>; Sun, 29 Jun 2025 18:49:34 +0200 (CEST)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-7d3e7503333so203963185a.3
 for <dev@dpdk.org>; Sun, 29 Jun 2025 09:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751215774;
 x=1751820574; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K0Ybg8lxJ7b62IRQzm70i1ZPMfuHipTTiFFkBNdE12I=;
 b=T4jsSuX1pQUa7Si9fBxeYxchuy5zl+HeMBNzDe4qvuHsvHptiLczJ+YLWHYazlSpUA
 BE8jmFIs1kJj3kyXiBVQmu+4pDiNIVBq4CAAZVM/V8+11hunH+6j6VsE3/5jQOWjrZyT
 1Z2bi2ZxDWrS32JucGCPat4/jWEes81iILz2vomYHMf0x3OO1Qpp1iRmQg7ba+7EYne/
 jL9jsUr0fe1xLDWsn1I1hMv8Assyf1zowrG/YJ67EauyreKDm4bd1vOuSUVHpcH1DHwt
 /JABXeykIg7Ld2R/bfRit1MR5zqQD5+goktbZZbGK7WSZWJ5IXBV/Qa7ezg7K9+AyZtc
 Jung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751215774; x=1751820574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K0Ybg8lxJ7b62IRQzm70i1ZPMfuHipTTiFFkBNdE12I=;
 b=PLOm/lfOoH963hf2zQw3xQDfRmBCaoU4O7RWzGsAVF6vHcgxU7FbpSsl+5NT2/ZPIp
 s8HKDGAAWSwuXBPLkWuGsiVX9Yx7s4z4YVtYukb9iHdFsa2n3yf7fE/ddnKTKdICtUTp
 7XjOxv6ehBlz59hZzg0oA7cylbi9aJZKJ6KASAjCcqGTSida9mEqIUOf/jRxLI5/ht+/
 2gErVv1x9V7iLgctCSpoe7hPjkffUPNz7drCpp17FbHnuF2eqtlWPwQ99ROj87z08N+E
 fuycpohNovyCYX1Jnj6AbTkdVk+15wG0DtPUqIJGqUx37Jl4S5Hf9kGNHdYjZeFarBRx
 gSSA==
X-Gm-Message-State: AOJu0YzePmzVR6gVwEKNnfSsrEi8jzKVbzydJh4GvnQ8ClUXL1Y8Et9d
 bzA8O7dTyBjyKGdxWmPOT2V3WNJBLspTSUhOb93PizeejLoGXHHQH5I9z93ArDcm8i4=
X-Gm-Gg: ASbGncvy56W0p1eaaz7e6uiBNrm9Vnp+U4/bZc5lx9q69vcxj3yvXZTzMc1bHH2YtaE
 faEuKicgzHMeyRyWReMHHRE7oee6JcZAsim7yXkGGK6Z2zipzjgRg1IFivWrDGAxln+FEmNeACE
 w9NbrQSLGP1ESyO5wEB7+p/gv0B33aaYNXzz91aR7RKWk8Pjm03lKpz8xbunDDVeFExgHTw3H81
 syMf4Gp+zyta2k3bFGd04JmQpN3YV3e4ZGCeVWRQn5imfZ9CO3a7WaG2emu8EyV0X8WJNYoI+i6
 o6e7ujUVcjtm9+65WLoy3x300tRawvMYgbU2/Ar1ckr1u238w4EzovFZ/3+WirsuIo/Csp/dL1e
 7SYBxK6D+3thiUsYHcZviwEBswBNSpEPEhz1RYqQ=
X-Google-Smtp-Source: AGHT+IGkJCKgr8+I/CQgyh2Sqt0TVjz6LBuoklwI1fvjYRQRFs+J1m67fUcL1LQEpJWbkLyMuaeYHw==
X-Received: by 2002:a05:620a:cdb:b0:7d3:f193:6328 with SMTP id
 af79cd13be357-7d4439a15famr1573761885a.54.1751215773990; 
 Sun, 29 Jun 2025 09:49:33 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd7730ad9asm53635746d6.107.2025.06.29.09.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 09:49:33 -0700 (PDT)
Date: Sun, 29 Jun 2025 09:49:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shai Brandes <shaibran@amazon.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH v4 0/7] net/ena: release 2.13.0
Message-ID: <20250629094931.05268741@hermes.local>
In-Reply-To: <20250528102531.9876-1-shaibran@amazon.com>
References: <20250528102531.9876-1-shaibran@amazon.com>
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

On Wed, 28 May 2025 13:25:24 +0300
Shai Brandes <shaibran@amazon.com> wrote:

> This patchset includes an upgrade of the ENA HAL,
> introduces a new feature, and addresses three bug fixes.
> 
> Thank you in advance to the net maintainers and community members
> for your time and effort reviewing the code.
> 
> Best regards,
> Shai Brandes
> AWS Elastic Network Adapter team

Could you check against current main branch.
This no longer applies, either it already got merged or something changed.
