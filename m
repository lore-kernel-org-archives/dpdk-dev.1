Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9170BFD3774
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 16:50:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 590844027F;
	Wed, 25 Feb 2026 17:50:26 +0100 (CET)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id B0264400D6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 17:50:25 +0100 (CET)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2bdca815fdfso1163572eec.1
 for <dev@dpdk.org>; Wed, 25 Feb 2026 08:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772038225;
 x=1772643025; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WQ8ZuQNiAQfXqvobZIX2WKUpZBIprnkmi+TUrC0fB+c=;
 b=yyTeqKU/lAyjy9BTUMHbS8DwtJPX/ffH/DZKAe2gb5jZWBLFWxSY0wghxqoXYKJwjC
 XjKOyAd3lKhnntMJXgfweJK+hz5pgHsmqjYHL7C4KWN1H4rHAMm9cDgJvK+FrNU7qaol
 jnuYeZYRpyIFFCUDuT8d7vFzJcZ3QBwGDpC59jGh+WO7lEVmEqOIawB2I1eldJ5cAICj
 9ZGw3uBuOIP2iv2bmVco+yjGEKDijA1nRQIQMNVgngg6SpLL32Q5Uny6OKFvSLj4QGVh
 53YcjQYI74ao5z+1BiwqUQHoqf49sfwvZiYJ/e8K8Rby3iQ8s0H7PbWs2zzMUkcXJqnn
 /phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772038225; x=1772643025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WQ8ZuQNiAQfXqvobZIX2WKUpZBIprnkmi+TUrC0fB+c=;
 b=mVVZSPR+LjGagaAiCCb+869aIAZwPChyTuzaoJUmUI6ci8DLXkh9/exeevAQIAGhw/
 uTv4KSKdy418G+pnXyGvb4m+HgWG91mo0GTNlk9lF21c9RPI4GZQMPmHcwU8HGbxE5id
 lMDCG19oBpGil2gSFoN45trHukMuZNJG7NlrT/G0O967ENIc6U1sn0QLRGTa5RGWmIN/
 PtvhnGeD3Od1BLwM+kZNCC1n11x3RTE3idaFcSLvcSfzu3aAfSeu/jz37uw68Ecysybt
 VufNctzl+myvx+PchI0GNAnkBvjlmKfYJxg4qWfI9axNd1mGvwSP6rNQyRteQNfSGRtR
 WDsA==
X-Gm-Message-State: AOJu0YxLnp98MosqnY9cmrU/DqMvGr9mFNEi1Nb2r5F7vhxoNOcXi3ua
 QtZCjG6QWTi5N2TUx1Y/b6r7S/4Q0P4YsNffy5pcdMwUesiPPvdzsW4MxSSLo7i2ljdT3XIg8r3
 SGZlw
X-Gm-Gg: ATEYQzwox9JVQYDeL20i43Ys7syrds1A8/55SMlMsBJVjT7dKhBRQfcP7Dr7qfye5yf
 0a/l8m9qnfJvlwNczqN+eaoq49JRu/0DRdmo4FTAQvknzUAVC8I9/klUVPT8TOc6OHjU3p8yO5C
 YwDGcUC/uV2uMhNluBVthPxsFmHH/pInXmqMTPnMK7RGfNZxKmG4X24G0LxyVWGYlU0h0m/TBzS
 PF4bX6SUBbxJc4DumLpIXUzyEf3QPKDOiDnel7QeLJHuL7VWpniepEX1r31odInDAndnJ75crYJ
 F9yIQSm84hA3N7Lfmpvhphks76nV9qEFlK7FIAM99uo0POV+KXs5r2KmDBJolkO5crbvvLtkh7S
 L99AethRQ8gAiR85rDY0PrMWUppbRgW9nrZH3pP/Qh/hFiCqa9AOZVOlApuuN9v5aA9T777wl4x
 HOZ0c1Yrq9RnaqbQCl0YeQUIgfzYdZtG73g3txHaNDHWUMgMcxzAVKWkKG0lZQe0Mh
X-Received: by 2002:a05:7300:730c:b0:2bd:c285:2fe with SMTP id
 5a478bee46e88-2bdc285075bmr1370034eec.9.1772038224465; 
 Wed, 25 Feb 2026 08:50:24 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bd7dbe8304sm9409959eec.17.2026.02.25.08.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 08:50:24 -0800 (PST)
Date: Wed, 25 Feb 2026 08:50:21 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v3 1/1] net/nbl: add igb uio support for NBL VF devices
Message-ID: <20260225085021.4182499e@phoenix.local>
In-Reply-To: <20260225033943.30751-2-dimon.zhao@nebula-matrix.com>
References: <20260211024029.33810-1-dimon.zhao@nebula-matrix.com>
 <20260225033943.30751-1-dimon.zhao@nebula-matrix.com>
 <20260225033943.30751-2-dimon.zhao@nebula-matrix.com>
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

On Tue, 24 Feb 2026 19:39:42 -0800
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> Due to a chip design limitation, only the VF
> supports the igb_uio driver. The PF does not.
> 
> The igb_uio driver requires allocating interrupts and configuring the
> PCIe MSI-X table before the driver's probe function is called.
> This pre-probe configuration is only possible on the VF due to the
> hardware limitation; the PF can only configure the MSI-X table during
> its probe process.
> 
> Therefore, using igb_uio on the PF will fail.
> This commit clarifies this restriction.
> 
> Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
> ---
>  doc/guides/nics/nbl.rst                       | 11 ++++
>  doc/guides/rel_notes/release_26_03.rst        |  4 ++
>  drivers/net/nbl/nbl_core.c                    |  2 +
>  drivers/net/nbl/nbl_dev/nbl_dev.c             | 33 ++++++++++--
>  drivers/net/nbl/nbl_dev/nbl_dev.h             |  3 ++
>  drivers/net/nbl/nbl_dispatch.c                | 50 +++++++++++++++++++
>  drivers/net/nbl/nbl_ethdev.c                  | 13 +++++
>  .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c | 12 +++++
>  .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.h |  9 ++++
>  .../nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c | 10 ++++
>  drivers/net/nbl/nbl_include/nbl_def_channel.h |  5 ++
>  .../net/nbl/nbl_include/nbl_def_dispatch.h    |  3 ++
>  drivers/net/nbl/nbl_include/nbl_def_hw.h      |  3 ++
>  .../net/nbl/nbl_include/nbl_def_resource.h    |  3 ++
>  14 files changed, 157 insertions(+), 4 deletions(-)
> 
> diff --git a/doc/guides/nics/nbl.rst b/doc/guides/nics/nbl.rst
> index ba0a119dfd..c74826a3c2 100644
> --- a/doc/guides/nics/nbl.rst
> +++ b/doc/guides/nics/nbl.rst
> @@ -101,3 +101,14 @@ Limitations or Known Issues
>  32-bit architectures are not supported.
>  
>  Windows and BSD are not supported yet.
> +
> +**igb_uio Driver Support**
> +
> +Due to chip design limitations, only the VF supports the ``igb_uio`` driver,
> +PF does not support this driver.
> +
> +**uio_pci_generic Driver Support**
> +
> +The ``uio_pci_generic`` driver is not supported on either PF or VF devices.
> +This is because the NBL PMD requires MSI-X interrupts to receive mailbox
> +messages, but the ``uio_pci_generic`` driver does not support MSI-X interrupts.

The igb_uio driver is deprecated at this point, it is not upstream and has
lots of issues. Can VFIO be used in no IOMMU mode for this instead?

