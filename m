Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F78FD46BE1
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 17:36:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09ADA4026F;
	Wed, 28 Jan 2026 18:36:16 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 5E3264003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 18:36:14 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-42fb5810d39so77541f8f.2
 for <dev@dpdk.org>; Wed, 28 Jan 2026 09:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769621774;
 x=1770226574; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b0IAAs9iAaRaOSkfBHfcpFYzBnCxEUKaWnEFOMLtvdQ=;
 b=b0xSZATqFGjj2Mlh0osH/EGvQ5b9VGqKXWqGtVADsHrw7sa5EvmLzXXOoGhogzBZYz
 xmY0Zz/CanzfxKV6IJcl8CQznIFZDa8yhkKMdGX9fjb/Vwbai9eVUMkeZ7NnVJ5aWl9A
 YDvIHkz3sAhM5c1Vxg8IzLdAxqXxpI3clJY14oZFU+4Hkzm7oE6hSum5DIYrISBlb1FB
 PseNbGfKCTUcIfXwf/SixgxO6zq+39uwYZ1lK0VPkYnEtTbvThqZl769hduWgAejGlmz
 G3825IrbtBD8jr6RBk0nbGKjdgLcEuDy2vhKrp5FMK6UvKy1T7StOakjh98s/qQ3D+mT
 MmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769621774; x=1770226574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b0IAAs9iAaRaOSkfBHfcpFYzBnCxEUKaWnEFOMLtvdQ=;
 b=N1x6hj0D2fw3AOcjVcDZFMc6L1GYMFq9lHrhGewNzJI3fLohXZwhjPJ+2WROegh+4N
 1ZlwIf9hfWoxRpS/wFkAD9hOGv8CzERp+WpxP2FDuJwWKLk5n2xVmvKA9gP7V5KkggK7
 LMQQoPtmIrNvtryEgEhvl7O8kv+aUXZskIsvP7kS9uViv6ATX+q52AZpxPtIh/h/a3Ut
 Ucb+Xb964p4RU0RaSD22i53eqASUG39Zp6Bhpghwbk1KLF+EUdHOYYLqQlqOmNx7I3KB
 H1L+Iwz0/AUnS+bdC4H3xPG+G8u8ELuIwTupIhoBWR0YxvhFuiHBV9NsBz/P92zmO6Ck
 Rn2w==
X-Gm-Message-State: AOJu0YzuXZwGv59jjjmIU1ewvrBOkgjeCyd1hEAPEkOT7t4zSiXzPx9C
 tSWO5eSnPhv4p6inaWqvyMa42UgLRF3HokY91dH615Zy4hLSVtSCLTsiKXcaXYwmtXA=
X-Gm-Gg: AZuq6aKRMwoqJqZswg/asu+Yubqj+Rbrr2LLc3pWD2shqPvsScBSEeTxksgFPJXTwpJ
 qjGXMit1E10UhiReUG0Hj+/g7CpljqImA6whA1YIrDNpreu5amJX9xA1SzqSW+SLVSaYp98fLtg
 jPCOLqCHDC1qvcD1Ff/vhW3OvYyjzFF7QT2yckcapmwk4brMZdqV9ggRrZeR5hAkN+YeOpEvd2d
 TIDjn2fIsBlJ+K8vjGK+Yl40hnYYSbnsi5WjwT6e0ffVzF/BIHFls1leLvitUKqzV6ATMQ+sf57
 QQICcQa2X2r1j+Bt7Gza+4S9mSf+sZTxIvWuJRVKogbi+yc1IQrEmcsIrJiuQUryGYzQwrYJ+3s
 /jS04PaXyohiNWbqbuygPOXO2Y+FVPfoY1aBC7ynPqWKNIeLoavZK9zuB6USmegtFv8rlTStbph
 PdKLlbpd0Wx49vsI2NPlWXT3pII028vet4rqt6BY9Mp/u5Ufmg6bepTZN6JZWMeRQ=
X-Received: by 2002:a05:6000:2c01:b0:431:808:2d50 with SMTP id
 ffacd0b85a97d-435dd050dabmr8758846f8f.13.1769621773812; 
 Wed, 28 Jan 2026 09:36:13 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e132368csm7770463f8f.31.2026.01.28.09.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 09:36:13 -0800 (PST)
Date: Wed, 28 Jan 2026 09:36:09 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Scott Mitchell <scott.k.mitch1@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 3/3] net/af_packet: software checksum and tx poll
 control
Message-ID: <20260128093609.71674748@phoenix.local>
In-Reply-To: <CAFn2buDn=jUNT2n8dAB0TceoQB5ebkC9nHejg43vDJyfpKMeqQ@mail.gmail.com>
References: <20260127181355.98437-1-scott.k.mitch1@gmail.com>
 <20260127181355.98437-4-scott.k.mitch1@gmail.com>
 <20260127105749.2e2059a2@phoenix.local>
 <CAFn2buDn=jUNT2n8dAB0TceoQB5ebkC9nHejg43vDJyfpKMeqQ@mail.gmail.com>
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

On Tue, 27 Jan 2026 23:05:54 -0800
Scott Mitchell <scott.k.mitch1@gmail.com> wrote:

> > I don't think each driver should be doing its own checksum helper.
> > It should be done at application or through libraries.
> > All modern hardware does checksum offload, so if it doesn't probably
> > a driver bug.  
> 
> The goal from the app perspective is to set rte_eth_txmode.offloads
> consistently across PMDs. Hardware devices are good but software
> devices like af_packet don't provide a consistent experience. The
> approach in this patch is similar to existing software eth devices tap
> [1] and vhost [2]. In v2 I will share checksum code with tap to avoid
> duplication and ensure they remain consistent.
> 
> [1] https://github.com/DPDK/dpdk/blob/v25.11/drivers/net/tap/rte_eth_tap.c#L559-L624
> [2] https://github.com/DPDK/dpdk/blob/v25.11/drivers/net/vhost/rte_eth_vhost.c#L317-L357
> 
> > Needs to be a separate patch. Don't do two things in one patch.
> > Not sure if some variant of the existing configure thresholds
> > could be used for this.  
> 
> ack, will split txpoll control. I'm not aware of any other way to
> prevent poll if dpdk tx is faster than kernel rx.

Well tap should NOT be doing software GSO and LRO in DPDK.
The kernel driver has ability to do that, and is better done there.
