Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A54C02198
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:43:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52432402EE;
	Wed,  5 Feb 2025 17:43:53 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 50CF640289
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:43:51 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-21f2f09865bso145795ad.0
 for <dev@dpdk.org>; Wed, 05 Feb 2025 08:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738773830;
 x=1739378630; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FFzU73GA0BBUCP57hqUZILqJbhWk+5QCNEAvJa97ilA=;
 b=Eii12xrh4uBLLUgT4OD1yOK8fr5AjISPiU4zP8pXEVzVpzqdtbgmhDnu/XEv46EHZK
 ARQeNFLVqdXVL05BOKSnxPCh/hWoXfSooTbNgxXQJiGkxW/jgI9mdeh3T3/2m0Z7H8ev
 UQ7OQhShYzTLX7KRcUNErM3d/LedXmTAwIy/M3IrsVmcx1+7lkTrbx0h6/w2NiAy/XOE
 DSX/AnD2PLtVcc3GL8JNqW/nBxdcZ8HcLoyIDYRXkDPNnlsuOt/5GH4Ybp4PY16dyqw+
 NY7XZ7bxcS54cKvYlxZK1XJcJAcZOJHvCHbjMeUV7rv3DtVrscNp1tpRV6fOibaXOSw+
 2wsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738773830; x=1739378630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FFzU73GA0BBUCP57hqUZILqJbhWk+5QCNEAvJa97ilA=;
 b=X3ujIUc9oeftjdYzZ2tU+/L9Eh4feGCi4MmhmA4R9H/xivsIaSH2if6BCnNmY4Tcl/
 RUdB8QD+slgjxMn5kSQHXphWkirs3eZNzrdtOXQ+Uka1/+DBfVZwlNAuJCxsRsvyJSI/
 PztS+1RPm0PXbd6gK1UAFeeIvB9MR1WFgKW5qTaJqfocCu0LVSJVzPUgNHR/hWH1bGf9
 iyhzkgmCxr7Z/tZGxVcS2nBsJ51JejE2Qw8ZT8D3j4DQwClo6B3kOXAGUip6suWKcPcQ
 n3gigrjP/xXLOyRxSFW+3iAKpQMkRMvH9lrLt5Mry4CcGlgO/xPU+XlMxT2W8e+AM6C/
 CoXg==
X-Gm-Message-State: AOJu0Yw6+IQWtWlLuQbubQ+gfEfgWoH/1OYRZhVNGSx/ay/CG/Ml5RcA
 9qONwadJbqGb2TVyEfFx9Xg4nOsqwV29lMla9Tifvpg7ywdpl8wsbx2Sn4GJ/80=
X-Gm-Gg: ASbGncsl6SGyU96wF+NpqsVljX6kxkZEHpg7MhfAuMzUXjnFX3n9/pB/LSz57+94a9D
 HdST2mqcvLxIMIckokMd7rwebk13eqJ6rW5fq5EvArTWU7OCZnF8gKAOhZLABsOTc6FCF7z7jyI
 wmcfFRCr5atE10W5vih5IcmZfBN6Pk+fxJK3oJmidgZ089RBuqPfRBtVMqRsyrJ0fXMXe7yu3ID
 RKYvApYcvKg3/pTQS9RL3JY00Zr/8EbeD8kt5OxjPiBbtGe1eValfHp4drfoa2eRkh61iQJE5Ld
 BZhAQfS78Var76r+3BTMicXTdnvugQbLySlalXRmCQSE92Aoy+TGxfl3EPCNKptfDE7U
X-Google-Smtp-Source: AGHT+IHV1RZM06cUJdhixiVhFsRUV5hvSVB4UBQ2d8sohuHtpPNKtXs99ZmhSGWVXOFla6pO9ZhMEg==
X-Received: by 2002:a05:6a00:23ce:b0:729:1c0f:b94e with SMTP id
 d2e1a72fcca58-730423f6897mr268912b3a.6.1738773830419; 
 Wed, 05 Feb 2025 08:43:50 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe69ba353sm12572993b3a.112.2025.02.05.08.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 08:43:50 -0800 (PST)
Date: Wed, 5 Feb 2025 08:43:48 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com
Subject: Re: [PATCH v21 18/27] test: remove use of VLAs for Windows built
 code in bitset tests
Message-ID: <20250205084348.29f960ce@hermes.local>
In-Reply-To: <1738702638-22363-19-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738702638-22363-1-git-send-email-andremue@linux.microsoft.com>
 <1738702638-22363-19-git-send-email-andremue@linux.microsoft.com>
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

On Tue,  4 Feb 2025 12:57:09 -0800
Andre Muezerie <andremue@linux.microsoft.com> wrote:

> +#if defined(RTE_TOOLCHAIN_GCC) && (GCC_VERSION >= 110000)
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Warray-bounds"
> +#endif
>  
> +		/* gcc is giving false positives here when code is optimized */
>  		rte_bitset_copy(reference, bitset, size);
>  
> +#if defined(RTE_TOOLCHAIN_GCC) && (GCC_VERSION >= 110000)
> +#pragma GCC diagnostic pop
> +#endif
> +
>  

Any change requiring pragma workaround is suspect.
What happens with Gcc 15? and ASAN
