Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DD9C83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 14:21:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BDDD40DDB;
	Wed, 23 Jul 2025 16:21:14 +0200 (CEST)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51]) by mails.dpdk.org (Postfix) with ESMTP id 73FA040B9B
 for <dev@dpdk.org>; Wed, 23 Jul 2025 16:21:12 +0200 (CEST)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-6facf4d8e9eso56177746d6.1
 for <dev@dpdk.org>; Wed, 23 Jul 2025 07:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753280472;
 x=1753885272; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wtc27d1NZBnfkWcgEfPU37CmqkTxr4++vsc3oS/XW08=;
 b=XA+RhZM3/XT/ZEORTr2QsxEYxsnL6SdEPL78O3zAqawocqRT9yjBwBjggdDxj4AmVR
 VNweuwy817G1nfd6RrgkY7pAzn2zpnaH2Yjk63+Ejq5rgfAr9fEWxuQxnBQtNPHJ2lWm
 rc6mxvKhR/PYYyEbeBvDMCMZ4VOADin75QpYYNLOQbOw69BvpCg2/TGeZO6j4D/XD7ZA
 DCs0B9/ne3ywS2eUUa3oF0yo+ywMVJWiqEUXhno+OQzvVLa2HgHfwNiPS2d5vDdsfIXi
 LEzps/OOc9VwqYruxNYYtWmtmH2yhCrt2pFWlYFiLXCIBFTPy6hpzm5/qn7pTNaRoNx1
 OzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753280472; x=1753885272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wtc27d1NZBnfkWcgEfPU37CmqkTxr4++vsc3oS/XW08=;
 b=V6rfl4IvPIJpbbBkubUnd6AQAXov+cTz5dznUTTtzHyErINPv4X0P6OweJB26BbP5V
 TUUhdF22dB7rBLqUPk+DgxiFnq60Nx/KU+UPatVeyDXBvIrGlsghHDq+/SeYGIc4xo/w
 Hb5ZvprVwVEODQEAnzdp2lNFQfocoyIKqT1BgtkvEGTcwb0Y0SD951IV5lCU779QRb+n
 1jEzbJMBfqfqg1dLnih9TSLpESYrqxIJ3UmeVO5iCjFDiqS8E9ilnmBn8UyVpnFCK33a
 19xIuMNS7gqwlL0vNBmjyAXZCJxdpSoSPQNi1llq+ewgetavU+1W9nGbMfPhlNq9Lock
 clJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU8ocqhat0hfB9Ja5GslJFtVyBJZ4Et3aRxHYdpoZf/pOCC0bUmk8XHgoks9T5lbmVi3s=@dpdk.org
X-Gm-Message-State: AOJu0YwTgW8pgU9xPDgXMKNS2t0Uqj6XTd1HXAsQV4k6zP+tDKhDy/Mi
 DMQubEUDbztXoB2rKC/mWoxC3ex9p7qLlwsL0cNllLDW/pGHgC/cpEnnJT65qdv6klg=
X-Gm-Gg: ASbGnctcALYHtQJKS8mSH6WDEA+m8ZYQAaBMno6vmwUOKJXdn1tD5wuiIbyOPYjEFM+
 XxOl5Yjpu7OAqNomj5g9Ic1drF+zjcWYHpa2chqJUiMRXywspYZNDZVKrO886S8K8r1klf7F52h
 Lv2YeZhWtBz+JI7tgqjWZCC+4NhDQBZkRk+VKwEh+t+i64scPv+ijgyei2hi1FbiIsMyQSQkRBN
 9dZPE+pAN97hgbUTOl/8zV87RmvCXZlmbFdl1yZ30feXExyjH8iJ6WjTVUfXrFJs3X28J8LZ8lK
 Ep7/7I0yOpeTcWWRAICLVqAT7RBY1UvlgcMoc8iC/LWA4qedmHh7oAvlO+MFAFBerdFSi1p6ngy
 /qjj+aVPs1dT3mIeoa3iWsa7WtzlrgUCiS17fTJsuY/WCCvaKCUvgzjqRB4+m7V42BKhuEjbQ3H
 9lvlGyd6DEsg==
X-Google-Smtp-Source: AGHT+IGQeRAwPEWMPFktzxDG+w965nDwC+0RA35+rzo7NI8PziAfQLTWpgmwAVpA8udr4OQaD3kBAQ==
X-Received: by 2002:a05:6214:27c9:b0:704:f952:18bc with SMTP id
 6a1803df08f44-70700723634mr40031196d6.47.1753280471571; 
 Wed, 23 Jul 2025 07:21:11 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7051bab17f6sm63710846d6.98.2025.07.23.07.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 07:21:11 -0700 (PDT)
Date: Wed, 23 Jul 2025 07:21:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Cc: thomas@monjalon.net, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v2] lib/ethdev: fix segfault in secondary process by
 validating dev_private pointer
Message-ID: <20250723072108.2d22d245@hermes.local>
In-Reply-To: <20250723045022.1580829-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250722115439.1353573-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250723045022.1580829-1-14pwcse1224@uetpeshawar.edu.pk>
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

On Wed, 23 Jul 2025 00:50:22 -0400
Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:

> In secondary processes, directly accessing 'dev->data->dev_private' can
> cause a segmentation fault if the primary process has exited or if the
> shared memory is no longer accessible.
> 
> This patch adds a safety check using rte_mem_virt2phy(), with an
> unlikely() branch hint to minimize performance impact in the fast path.
> This ensures 'dev_private' is still valid before accessing it.
> 
> Fixes: bdad90d12ec8 ("ethdev: change device info get callback to return int")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> ---

No still a band-aid solution, and it is depending on side effects.

Is your secondary process monitoring for primary process exiting?

If it is, then lets fix the monitoring path.
