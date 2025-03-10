Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0ADC282EC
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 15:01:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AED7402E1;
	Mon, 10 Mar 2025 16:01:03 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 8F0F1400D7
 for <dev@dpdk.org>; Mon, 10 Mar 2025 16:01:01 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-223fb0f619dso81885435ad.1
 for <dev@dpdk.org>; Mon, 10 Mar 2025 08:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741618860;
 x=1742223660; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hmct3OLGq18FoT4e9EGp44KacJnRK1gXWHlB0BPE+HE=;
 b=sm1W8qNFc8/4D4UI8tNt5tnYX9zSApHq3VPtclx6cAvFo6ggfotCDbiyqja1qc1mPz
 nYJTtf+UPC89RFTQGuGRU8Br+RgPF69q3rwfUQ94KS10tQON0KsWUNLd1sTdwZWC1OQI
 sL5r0Nt7LUrxX7IyFAtxW8s1LjSpzkrpI0GMWOy6gYoq8aHP9GwQwpmed+1Q3RDZgoPo
 nVB3LbVu5CaRJIZfOIakn8xRkrI7rJxy+KCo54o9FLlgYZBlulgq+JneuC/AdRLafsZI
 rRWDNxhxUOBlcWdE1eRQkM4omkxqIEMEZz9wGLJOHGvTaqFBXsbhRN+LjpZCSAB8Kcv1
 s5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741618860; x=1742223660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hmct3OLGq18FoT4e9EGp44KacJnRK1gXWHlB0BPE+HE=;
 b=semjZdAIhvxIuftB7XxnsFQb3Q8HvGX4JNLlpaMCAFQjj2h+tZh9c8IXgphaUbu346
 7s6kiTUEJWbUxtq3/aNQ8ZY5UU0i++S77Hk0sv2PNNrkO618DjwJMma0rKsJQ2E8DKdv
 Y7/QQSK0IoP9N3vNNbiNITYB3kPrROny9lEE3IAuiuPBkdUYS8Yk0KHXUbaJTPWxiNwR
 pMjQvEH+n2uH77USxphfMafew3BuopSANHju1rbaKok5fcdHgXBOpUUXVVFPmdWS72ri
 +gr5ybKCACCvfcvj1Dj5+m6zhavDogcpHRF3Xo27ASLVgH1w9ou91n8M7okkSn+7MBit
 nxyA==
X-Gm-Message-State: AOJu0YyKoXjz+dS1/zRyKCllVlUXlr8FFraNLW4El+Y0MLL3KZDCmBuT
 qB6wy1KcCkbCqnvY7VWnuRB8blFYsadc04VU0yCQssj2Tj6BM/mKA69Flk9bAgk=
X-Gm-Gg: ASbGnctuA7Dx79oCRlgXEyRYQCT9BG7f3OvWMWKIDdH47xCFNt2SjoPfs3ZomA+gnUM
 6d5ne2qJa3iVrsx2ArvXpbGrMAogtGYEQY+VJFh3T87VD0vQuDkCbAJT30KinIRRkZtTcKdhfuC
 rjmVizvAvg5gsC9w9+MkG/UuQxFEZl2qJUFiQoyRJtfDH12FLwKD7kfYtRTBpOEP62omlexYKMD
 aiU4QU+vq19jmV0TS+zYWuxEgPNvVAKpfbX54DuhUf9ZGMnrlJ4TvBg93NXiMqS7ae4doDwYwus
 qx9jLraT3ib93yM+LUYvRB6xaeLsZHmdv/dqpCM/fdPTRE+Yj8A46rwVvwQSHXwcPQ4m56r0Ww1
 yAzSLm6Od4W7Jj+wWSvXo/F0wLZI+70dD
X-Google-Smtp-Source: AGHT+IGMK73yi3I849C51NkcQ5b0VzI6Wzn/WKT0mLYoRCoubX3gbNTT+EzxRsGG0cPxNnaPzZG96Q==
X-Received: by 2002:a17:902:d2cd:b0:224:255b:c934 with SMTP id
 d9443c01a7336-225931af86amr1695955ad.51.1741618860637; 
 Mon, 10 Mar 2025 08:01:00 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109ddf86sm79040895ad.6.2025.03.10.08.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 08:01:00 -0700 (PDT)
Date: Mon, 10 Mar 2025 08:00:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gregory Etelson <getelson@nvidia.com>
Cc: <dev@dpdk.org>, <thomas@monjalon.net>, <mkashani@nvidia.com>, "Bruce
 Richardson" <bruce.richardson@intel.com>
Subject: Re: [PATCH] rust: support DPDK API
Message-ID: <20250310080058.3ae00bd3@hermes.local>
In-Reply-To: <20250306133713.393057-1-getelson@nvidia.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
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

On Thu, 6 Mar 2025 15:37:13 +0200
Gregory Etelson <getelson@nvidia.com> wrote:

> diff --git a/examples/rust/helloworld/Cargo.toml b/examples/rust/helloworld/Cargo.toml
> new file mode 100644
> index 0000000000..7f9a77968a
> --- /dev/null
> +++ b/examples/rust/helloworld/Cargo.toml
> @@ -0,0 +1,7 @@
> +[package]
> +name = "helloworld"
> +version = "0.1.0"
> +edition = "2024"
> +
> +[dependencies]
> +dpdklib = {path = "MESON_INSTALL_DESTDIR_PREFIX/rust"}
> \ No newline at end of file

Bad practice.
Don't forget EOL
