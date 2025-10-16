Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139F2CCD199
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 16:08:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CEA940A67;
	Thu, 16 Oct 2025 18:08:51 +0200 (CEST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id 295014026D
 for <dev@dpdk.org>; Thu, 16 Oct 2025 18:08:50 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-78af743c232so877759b3a.1
 for <dev@dpdk.org>; Thu, 16 Oct 2025 09:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760630929;
 x=1761235729; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rQYhPFN/K+RJh45lnHF46BtpzTrhj689S1nNYAdJiAw=;
 b=O53e/2oYPUJMGiQEBeIwKKrscs3GKlzKazfrD5XBCpTpoDUSIwfaJuaIm7TffioMF9
 5i+KTGmwkSlYFLGUqHcpM7cAUi2I/wnaKu+xBhPs7yLNI8frf3MCs40PoCKLJa4p87jX
 lLMV4QUmHoqbJvNssIqngkyxY2hlRtfEcG8DfJTCfbX1Xfi54hdFA9TlojGpS6xYTUfU
 cCFAe2VhRZXAbl2aL/abqSKrOGlIYUO+jopwuUoEHamM5Y8sZPGwRUcBhdUZDlWz4nLo
 QdcQKJJuU0QgcTQuhFtg6kQTJsyWsuaTif5s7hMeKeFa+Z0xrN9u/EtSmIL/QtWwAWfQ
 vIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760630929; x=1761235729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rQYhPFN/K+RJh45lnHF46BtpzTrhj689S1nNYAdJiAw=;
 b=fdkLmT99dsy3iGowrNDicyzb0mJyyXGrzWa+sw0hGsN9qm5sXf9/iMEFuMP/E240lg
 RPWQFY6O3FZEvk3cSU6t4n4cNnZmxGt+TTBx4BzgNjE1Fnk2UJ2fbi4/ogpv1mt1LacO
 qv4Yq7FdSd1ZWYKiYmOifvQju+7sirA6smuPkwCRHjB64TBul8uKrVPR5fMBl2/q19RK
 leHSXliWt5k3ln9qqA6CUIO76IeJCIdmpHlLmDCAdfnpnf+dDUs7WzrdWqVJd0qgcMDy
 Z4uHAMeU8YXxSK/1QF5zzxt2f1Tk+QDQuj54D4NMebWmZov3kuuwTr5CmOW6c0KN42Vx
 KAHQ==
X-Gm-Message-State: AOJu0YyLPq0tt21fe4A1TaouwLA2WVhjdeIOSQtnqvEN23R+SYQslGIh
 qFqDgpcTuQt35BV1IZhh3wYkkX7N4p8IuxE9PNtlMbhqfVr+zoV/6xT2b8fdjaqeZxjQ7HDkayd
 IgG6HjtY=
X-Gm-Gg: ASbGncsoB4/drz8Bii8c5f/vc55R1Hx8Mzi1tqAWVynD2+FWVFbph/DZ4Nt2KY0RVgp
 O2AyOZdH0aQsnGuDzK/Sahv5+AvU0zu1Thyh0sbj7dPbZBgwELEil1LPzkWhKiLGNXhcs5kSvJs
 6FfTuCZCClGbOJ7biSbtkI4oHESM3qSvbtC0bSHGYZneqqCoUyjbcUERotOfH3YE94ooRcRk+sR
 Dvnnn+6alhfUAZRYg1BPBl+tcZ4pRnPkcmGhS3IGPtE3urEoo4Az5JNeNFCdpdyIvbZbMQUKC1e
 g6H4ba2cjiN9CrOq9XBTYTj3lDiaKgo/y2fQY88LOa59VjD1JBj+2JrQNzNdWBV8JfZnrt7Bd/9
 tb0wqmdZCj0FghKLBS3BW+d1LmWSeq2Qt+B/skTdjFY918wgadDYuFxN0UidlPMVmoUru4gqD0r
 VgCuH0UXmR/YWh4YA7fbP4fEoeUUsr/26uzr7axJqepJCde2dhUKo4
X-Google-Smtp-Source: AGHT+IFKJXpAzEj88D0KNXPRA/5e+OoU8GtRuNlANbx2/m3qwKxZnbm4+I8SXhC2mbPG9jJanl9d9A==
X-Received: by 2002:a17:903:11ce:b0:273:3f62:6eca with SMTP id
 d9443c01a7336-290c9ca804emr6198615ad.18.1760630929064; 
 Thu, 16 Oct 2025 09:08:49 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099aba4f5sm34477505ad.91.2025.10.16.09.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 09:08:48 -0700 (PDT)
Date: Thu, 16 Oct 2025 09:08:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shai Brandes <shaibran@amazon.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH v2 13/20] net/ena/base: remove redundant zeroing of Tx desc
Message-ID: <20251016090846.1ad2be40@hermes.local>
In-Reply-To: <20251015121042.2828-1-shaibran@amazon.com>
References: <20251015121042.2828-1-shaibran@amazon.com>
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

On Wed, 15 Oct 2025 15:10:42 +0300
Shai Brandes <shaibran@amazon.com> wrote:

> +/* There is an assumption in function get_tx_sq_desc() that both descriptors have the same size */
> +_Static_assert(sizeof(struct ena_eth_io_tx_meta_desc) == (sizeof(struct ena_eth_io_tx_desc)),
> +	       "ena_eth_io_tx_meta_desc should be the same size as ena_eth_io_tx_desc");
> +static void *get_tx_sq_desc(struct ena_com_io_sq *io_sq)

In general DPDK code is using static_assert instead _Static_assert
could this be used here?
