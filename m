Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DCEC54E71
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 14:53:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED54D42DBB;
	Wed, 21 May 2025 16:53:09 +0200 (CEST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44]) by mails.dpdk.org (Postfix) with ESMTP id 40DFC42DB0
 for <dev@dpdk.org>; Wed, 21 May 2025 16:53:06 +0200 (CEST)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-ac2bb7ca40bso1157727266b.3
 for <dev@dpdk.org>; Wed, 21 May 2025 07:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1747839186;
 x=1748443986; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I2FrbdYdLZXDdWBRR09OYikeg/y59UFR7+EtKCbVsFM=;
 b=xsz9HCU4axiBnU3bzEqacH+SkiSoDZgud5QHOHMtyuS2JyXSJaPCF7tyG5oFyORCB1
 kiEh6Bt/fDipe8WHTc/MhJRo3xF79hIG3DbmYUwkdM15n1Qt6neunN6BWD39rUbER2j/
 Re6h8dE5mvbk8PnCuft7OQi6mFFPDBZrgDgFpsQuABDOwyma7FENVWdaAK2r8WwpQf1/
 lNzk4vKKaVP1DEzL8udlpcV5OqAxa4AMMVYPXDjTnNZ080J7JW7QfF4hDI+JNr1Tpxv9
 8+X4EI4cqA/5ciPs0cT1zmGTJOyMDly2ArYUXwH3FSkwIQTALFb60aE7YQRXeUR7ld0g
 0Zvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747839186; x=1748443986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I2FrbdYdLZXDdWBRR09OYikeg/y59UFR7+EtKCbVsFM=;
 b=MRukFrW3fjqftYCJZV09BChMcVKtbCNx3DRL/8U5ISEFshymiiGCpRWMEO19wc7yNA
 o4H7c6trT90buKDqL/CPkf485oF7sCnX3/GBHbu2kVy7bBSYOCDX9+xigZefFVJWZ0/w
 s/dnVLsE0NmWG0IjNNo6zWY182Rmwt6o2QGB8+9JbfwN1CisfVv8SMZiWJgj+SDe9pEw
 viS5J3I4pLwQefvECAl7w8QZEUFeirittDhvCb+3NKXXIqo7OjEG4s8X8VWHiNvVe1PZ
 D+ZyfElKMndsVlHfpUbIOFUbm9KXKgZV7GDYOxgIji/YnXSI0/UCYnULt/q9lXpu7AUx
 4BVg==
X-Gm-Message-State: AOJu0YxqQvZYxisMZubzyv6rVyryIQjLp2Ha9xKdsao0L5FVTDqVOQb3
 yzbxd0Mnj8zGGs7zZTQ+0AtiTgzF7UliuC2VNjLDrDdsJu4kBaVoqACXEGNT9euQ0vFxvYDrZI/
 2hYdC
X-Gm-Gg: ASbGncvb+CKFWA8nVJWoJd4dvV4SdBl64FeBogqAKl4GgeYzLwB5t5LnrRbm7/kvBT8
 fkBsJnfoHi6RQEUkGh+9AlO5ku31KVRmJaIAU93UUj0E6CpojUJWvAQhcTnSc/UgSvP9wgQWlcF
 uiWCQNXX6CdM13Tnt/vBQLHDjyXtt7YNva8xfBJ7GA7BJOFWhiF156Vq+cdx/vYTse0v2xrBUPt
 Z3sENG9c1hlziDUoUZWFbEUvFpGQ5Bp/cnGP/1B3eIl2LNANvsoyEILjEdTCQD5wHtc9jGwn6Cr
 CHXbnjhIfdHW6a/dLxvQr4p7xkapuid6ikkensMs3MiquQw0z7bCqQXRqGJp9kj43NWe7V2Gra6
 1x6YbUYtQ5C2L1VZjnx34hlNeqfp+
X-Google-Smtp-Source: AGHT+IFTJXFNm47ibajjtd2sbb076LU1lwhItM1IJy9xy5B+jV3lcn/4O3A6eougyusAu2++n9pDEQ==
X-Received: by 2002:a17:907:1c0a:b0:ad5:2473:3ed5 with SMTP id
 a640c23a62f3a-ad52d45ad21mr1850126966b.11.1747839185633; 
 Wed, 21 May 2025 07:53:05 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4381edsm917805366b.105.2025.05.21.07.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 07:53:05 -0700 (PDT)
Date: Wed, 21 May 2025 07:52:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org, david.marchand@redhat.com, chenbox@nvidia.com
Subject: Re: [PATCH v1] net/virtio-user: implement MAC setting for Vhost-kernel
Message-ID: <20250521075258.01d6bc50@hermes.local>
In-Reply-To: <20250521142305.343264-1-maxime.coquelin@redhat.com>
References: <20250521142305.343264-1-maxime.coquelin@redhat.com>
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

On Wed, 21 May 2025 16:23:05 +0200
Maxime Coquelin <maxime.coquelin@redhat.com> wrote:

> iff --git a/drivers/net/virtio/virtio_user/vhost_kernel_tap.c b/drivers/net/virtio/virtio_user/vhost_kernel_tap.c
> index 611e2e25ec..3e13f8f65b 100644
> --- a/drivers/net/virtio/virtio_user/vhost_kernel_tap.c
> +++ b/drivers/net/virtio/virtio_user/vhost_kernel_tap.c
> @@ -112,7 +112,7 @@ tap_get_flags(int tapfd, unsigned int *tap_flags)
>  }
> 
>  int
> -tap_set_mac(int tapfd, uint8_t *mac)
> +tap_set_mac(int tapfd, const uint8_t *mac)
>  {
>  	struct ifreq ifr;

Since static building of DPDK does not have namespaces, it would be
good if virtio use of tap and tap device did not get name conflicts.

I.e make all the global function names start with "virtio_tap_" prefix
