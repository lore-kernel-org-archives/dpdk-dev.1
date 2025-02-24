Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EE6C021BB
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 20:38:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E663240EE2;
	Mon, 24 Feb 2025 21:38:33 +0100 (CET)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 338B740EE2
 for <dev@dpdk.org>; Mon, 24 Feb 2025 21:38:32 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2fbfc9ff0b9so7579744a91.2
 for <dev@dpdk.org>; Mon, 24 Feb 2025 12:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740429511;
 x=1741034311; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=caX+1oC37UzadIhwIGH6xLVfirCRuauWoaWz2hGKc+Y=;
 b=I5tp5Gs7FwftCLMqy9V4+UWTn7I7MwB874BgQMMumM3qb5eYbLYegalj6TwQI4o/ak
 Wa9bqupkQHGoIb1fyLsAfdOQYyZL4Tatr1OklEnHQ9Ids5ro2SYUnL55/wdNh5lEkLG3
 BK7DYY6rCofW4qusDSe2qvRnlhZ6cclDEV8mecReCjDlx7CTAUsx0JaAE4LbUaumO21a
 xJZoTfQ/egbHvIJSFXqIEiSETfpZDLGKyDBoUZmujMRFWxdQCVswy8Dbc1s65Zeb58R2
 94pz1/2CZZAx3/AwV1jFFXc96/PF6AkzLkOqE0E5PzVNvZ8WOyJZ+fMF/z37fdmN6dHG
 PF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740429511; x=1741034311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=caX+1oC37UzadIhwIGH6xLVfirCRuauWoaWz2hGKc+Y=;
 b=roGnd0Qrf2ZA51EEXsgWLWFogqQFvS2qUMtIck1ttcyzoqkHJpFp+57xKE+iYVOr/z
 6UvOnR6Qjtg73f6E4olskoGaFVdqkM6au2Ma5dMZJsVlT7NnA8BgKhXl7sIUxw0Xfyvb
 CUDtQrGTH0ZCnEA3tI+IC2RbIfwNn/br9sYnRTcBBM8Bn0kq4Vdeb5ef2y6J7k4idvpY
 T+Q0K/P8FKg0+9TD9s1ig1iHK4GQIMzZ6ZkTB6NhTU48ncWY6B8+cFtSK+Ed8wQPzvbH
 /ejM17JVI7WZf/F6Zv1axACNpb/4KIvMLtM8gACPzkEvTDnNvVMMPqBEaqCNJ4bThpdf
 jqaQ==
X-Gm-Message-State: AOJu0YwXmT6JhpHrzvwZwAKQft1KArHUkRe2ChoLK+lefyhza49DJC2h
 0AVXr1fzV6XJfF0TC01VytvLosSncCLTb35vOyciAk1KwpLSvHPGnCEynkzaGUo=
X-Gm-Gg: ASbGncveuKgfIijUVnX5D6txgIQvw+NXpHtrjeUbfhmC5rBsBwUn+nA863f1CW/rW8t
 mQHZB7IqKCUtpuBr1Z4FPCUMwsvudVH4tSW0TI+TFbZOpm+3xpZul+J3E74yOavFEF90hib5rNG
 Z3AAMdbFuyPS8NdVAGY72gOS4weIboQvP28VB2MTFmNTiiMVc9BwmN5yU1cpknW9DlacVzpTaqn
 5lRZBhigk8p2ms44gRFrLO4rBWpZxYtjYS+fVtGFjVwqbpSeHn4UrOYKawSND01LhhVhVBy4mKT
 g+9U44UFEJDXoU58MQUjiWqRHcosAcJsVHPFw87U9b6RBi33bxB/4guDAyvSaRdnXXdDtrTIm3m
 N21I=
X-Google-Smtp-Source: AGHT+IFp1GBurCBGNH8C+oVnxvOA99xQDKHsl77kyr+zRmLEsAW0PswKPx2rNZvzlHAWsKSUSYSdgA==
X-Received: by 2002:a17:90b:254d:b0:2f6:be57:49cd with SMTP id
 98e67ed59e1d1-2fe68cf4016mr847281a91.25.1740429511265; 
 Mon, 24 Feb 2025 12:38:31 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2230a0b2387sm238325ad.258.2025.02.24.12.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 12:38:30 -0800 (PST)
Date: Mon, 24 Feb 2025 12:38:28 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shani Peretz <shperetz@nvidia.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Gaetan Rivet <grive@u256.net>
Subject: Re: [PATCH v7 1/4] bus/pci: fix registration of PCI device
Message-ID: <20250224123828.2feb3e56@hermes.local>
In-Reply-To: <20250212163836.178976-1-shperetz@nvidia.com>
References: <20250206105428.237346-1-shperetz@nvidia.com>
 <20250212163836.178976-1-shperetz@nvidia.com>
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

On Wed, 12 Feb 2025 18:38:32 +0200
Shani Peretz <shperetz@nvidia.com> wrote:

> When registering a new PCI device, the device->name field stored
> the user-provided string from devargs (e.g., "08:00.0" or "0000:08:00.0").
> This approach led to inconsistencies when registering new devices.
> 
> This patch fix this issue by saving the parsed PCI in device->name,
> so when a new PCI device is registering the name displayed in the device
> list will be the parsed version.
> 
> Fixes: 23eaa9059ec2 ("bus/pci: use given name as generic name")
> 
> Cc: stable@dpdk.org
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>

Is there a bugzilla entry for this?
Would like to be able to see what exactly was broken.

The PCI name thing goes back to 17.01 release where this was added.
Did something regress? If so why is there no test for this?

commit 23eaa9059ec24e95e32361f333ed0686f82bea74
Author: Gaetan Rivet <grive@u256.net>
Date:   Sat Jul 15 19:56:39 2017 +0200

    bus/pci: use given name as generic name
    
    When an application requests the use of a PCI device, it can currently
    interchangeably use either the longform DomBDF format (0000:00:00.0) or
    the shorter BDF format (00:00.0).
    
    When a device is inserted via the hotplug API, it must first be scanned
    and then will be identified by its name using `find_device`. The name of
    the device must match the name given by the user to be found and then
    probed.
    
    A new function sets the expected name for a scanned PCI device. It was
    previously generated from parsing the PCI address. This canonical name
    is superseded when an rte_devargs exists describing the device. In such
    case, the device takes the given name found within the rte_devargs.
    
    As the rte_devargs is linked to the rte_pci_device during scanning, it
    can be avoided during the probe. Additionally, this fixes the issue of
    the rte_devargs lookup not being done within rte_pci_probe_one.
    
    Fixes: beec692c5157 ("eal: add name field to generic device")
    Cc: stable@dpdk.org
    
    Signed-off-by: Gaetan Rivet <gaetan.rivet@6wind.com>
