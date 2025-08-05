Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69CEC87FD1
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 Aug 2025 15:49:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F17240E20;
	Tue,  5 Aug 2025 17:49:42 +0200 (CEST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id AB79F40BA4
 for <dev@dpdk.org>; Tue,  5 Aug 2025 17:49:40 +0200 (CEST)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-459ddf83023so13045945e9.0
 for <dev@dpdk.org>; Tue, 05 Aug 2025 08:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754408980;
 x=1755013780; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l0TIkzhGOUBJ7w+k0LQIVZP6y0KbB6hqIbt+AhZ5Np0=;
 b=NtBbZv2+YkmVSi6bh78WvNjLR3NQkGKii38d/YmFi44XbUVKv+dJwDL5HgeLj9zQag
 TTb/BWdH7ePDlVv8hCdpi0dNG9FOKBRXg9M996ZpyrhPul5PBAEbPET6WVwIjlWmXiKn
 1gC84NfdAtKpRuO11ALHGGwVEg8LZNfKPAo2BhhFfJNM59fR3zOAhSWgioeR2t7ZS1X9
 QKEcGIuw6TI7/CK16x2lGK9Iue54JJnknuWosPQb8eKonrRr7hTrMTV9/BGpCxyPsbJW
 rjWkbGqeZ1K9OWdnhdA0p+nKgWVSyaQMTkrWqUTzXli24HrT0nPJO92Sl8iSJFg7gSru
 bxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754408980; x=1755013780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l0TIkzhGOUBJ7w+k0LQIVZP6y0KbB6hqIbt+AhZ5Np0=;
 b=fZnpFGlew27JRVBOz6ji873hETu5vteh177ifj+MiaGjRNJUD732AxeF2ZX6rPJ4ru
 BbPmRfwuWSzm+J/yUNbGQcDO4Ige4UcA08qfD/CYaS+J1bEbujYeQlvgLyl2noIp11hv
 fJQs+mtL9Zbm/EKv+CoGljo9hhoVKuLCBRwgBhK8wdgrr0kvVfb1Dyqpjs0Wla6lB+FD
 kmTb07gv4zE2Rf9zIxboSEoxEWI3k2vEKTqY4nkahSWWsnCrX2mQZvfj7Xpu0+mZIztx
 PkIYgR6uJSHn4U7mfuXXHT57GeR74DF6093HvvGlLf+vaGCDypeL6K5ApOVRjjq80Jij
 zyWw==
X-Gm-Message-State: AOJu0YzEA98HgflUkAxPfPmmiAkGc3jKyR2TjKR9Qg9oxTInRTAoDafP
 AZZS9VB7pxsdheHCOs7TAb/ozprycXKctZgitzasKjmkgGigArULe76wZaAEMCn4b74=
X-Gm-Gg: ASbGnctpoIiKCttfmu7OTHXAn6X15q17CzMbXvXh5+rh4EuKc4M2htcpccgnWcGrzsM
 qf6Xo4Qs+m/CPZpWC4stzxa8qqnhbTN1QPHJfTU6gRYSRhTV7i3PYIcUxQz/qGnFtc+r832VFEh
 ER6nMv5q4pS70IPvFFsiT8WJI3yOmnOCGIYy5KtvsxhoNX+Id2TdwQ8l88DwJyzumJjTOguC1M5
 XDvxfPNs6jbjc2sFB44wIOlrFzPHS2zA/3WxZJZR0bJ6DlIv5+d8G01X9o24sxjDiK3Nt/gNOzJ
 YQUxuZQwifsRLaj9dd3rvoOSAWdPSeYXkzBuywKo3yPX/kP83hV2eHVDt6gPU78Ry/7IURryylz
 +sBvqJrtG+K2KlkVpYzESPDWAJw6RE1ttH1JC8bO4CXpe8rjoLOVP3caUvf3GaNy4mcSy6LSrb0
 pvcTFk80I8jQ==
X-Google-Smtp-Source: AGHT+IEy3Z0uP9jdkYSZFuL6g54Mn1V4tS2gU0jubCgS92CyoSZ+wa302GMPWA4S9f1a3mxvinmO1A==
X-Received: by 2002:a05:6000:22c4:b0:3b7:837c:5679 with SMTP id
 ffacd0b85a97d-3b8d94ba969mr10598908f8f.40.1754408980159; 
 Tue, 05 Aug 2025 08:49:40 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c469582sm19384507f8f.52.2025.08.05.08.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 08:49:39 -0700 (PDT)
Date: Tue, 5 Aug 2025 08:49:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shani Peretz <shperetz@nvidia.com>
Cc: <dev@dpdk.org>, <suanmingm@nvidia.com>, <stable@dpdk.org>, Kai Ji
 <kai.ji@intel.com>, Michal Kobylinski <michalx.kobylinski@intel.com>,
 Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>, Marcin Kerlin
 <marcinx.kerlin@intel.com>, Piotr Azarewicz <piotr.azarewicz@intel.com>,
 Declan Doherty <declan.doherty@intel.com>
Subject: Re: [PATCH] app/crypto-perf: fix plaintext size exceeds buffer size
Message-ID: <20250805084934.3b112d93@hermes.local>
In-Reply-To: <20250805063800.225231-1-shperetz@nvidia.com>
References: <20250805063800.225231-1-shperetz@nvidia.com>
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

On Tue, 5 Aug 2025 09:38:00 +0300
Shani Peretz <shperetz@nvidia.com> wrote:

> diff --git a/app/test-crypto-perf/cperf_test_vector_parsing.c b/app/test-crypto-perf/cperf_test_vector_parsing.c
> index 737d61d4af..04ca9cf019 100644
> --- a/app/test-crypto-perf/cperf_test_vector_parsing.c
> +++ b/app/test-crypto-perf/cperf_test_vector_parsing.c
> @@ -308,6 +308,12 @@ parse_entry(char *entry, struct cperf_test_vector *vector,
>  	if (strstr(key_token, "plaintext")) {
>  		rte_free(vector->plaintext.data);
>  		vector->plaintext.data = data;
> +
> +		if (opts->test == CPERF_TEST_TYPE_VERIFY && data_length > opts->max_buffer_size) {
> +			printf("Global plaintext larger than buffer_sz\n");
> +			return -1;
> +		}
> +
>  	

It might help user to print the sizes?
