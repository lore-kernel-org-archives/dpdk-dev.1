Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE91C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 18:24:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20DBF40674;
	Mon, 10 Feb 2025 19:24:34 +0100 (CET)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 04F0B40673
 for <dev@dpdk.org>; Mon, 10 Feb 2025 19:24:33 +0100 (CET)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2fa51743d80so2907833a91.2
 for <dev@dpdk.org>; Mon, 10 Feb 2025 10:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739211872;
 x=1739816672; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7c1uXG3vY1vH7uSogzrNVZJxtqGwvfv136gHw7YQx+I=;
 b=tR5Os0qWUEpbmDMF+tohP949vsMDd3s5jjHhkfhvA8cK/1nX594N433ELY4IX5cVa/
 gciDV87LJk5KroLcys2z0ob7P0rAv00rhPOBsfzWhhtMq6UpeJJz2UskGN0gkBfju9oK
 JcWVMz3gPkF9tcNiPXacrSGK8Fh7FocFb9uLigbJPSg5ZQNjCWi1Isw0DwcU2PtbhwRs
 IbRTX+IzHckODBBpkOSZPSXsVlkPx6tP2LwUj7vBgmPuRLvelUzjn7nzD3TOBWJAyYme
 C0QSzZBziTF4UtjX2k0er/zqZ+ifXDOfQnZ/b8jqNqqhcNxU/wnxGP9pERiQWQA2PUjy
 VtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739211872; x=1739816672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7c1uXG3vY1vH7uSogzrNVZJxtqGwvfv136gHw7YQx+I=;
 b=Ay8rxb7iZeXfXg2UAgKSDvb8EJ92ROqJ3PPo+J94jN52qepI/ibSjS9UoLxhyU6uYQ
 zCeV7jU8QNhR9YmvAMqNyPdaLt+K4NYx99HzfQVMptetcI59/qPUVDF+jQbGqDRsSCdU
 HtSxDBrlcEcnW9GqC5LR7G5tRiKg8dqyhMxrhCRFLTxy8qkkGALcNnu98LtWqVzhhMTj
 GykdOwlycX+RlHhAWYMHBaOj6yJwB/CkiFQ2XtIzZrMzBFQJXRS4/9eh/a5RMBzG1dQW
 VFKA9VaxlyELVEWYCnt/08zFp0s4QbrCuexEZWuWFpWCWirdxMNMmkxIjKrUOE2OCuST
 pHhQ==
X-Gm-Message-State: AOJu0Yx6DS6/EEnKLqX9NQtCobCXoGi5UupXGVpyEmNSfvKFd7GTXf/E
 ntZBTsinxWCPyIpWGlAbWnASuD/j4d2rlJ8rOMTyadsCIYQWtl6UmhFIxnEzKxk=
X-Gm-Gg: ASbGncsSfiWhLK68WeB82mtDhQXLEPsNCRWuAGLyxr3H4iC5VRHyqBAPUjbQ+EK70lq
 iSBLzQpxNYVhc9bMnCkelRex3k2H/xzHQgk1JVGiw3AyBAyxwCs5HImdmwdVGLHUW6h1WFNcxC7
 YRdmEEI25UVI7joqgh8UisYvepVDv2jF3lbsPhY/v/+SomY1XT7v3lvkJv5wkBfHJxm2HvmYAyf
 ZnbQMKRjZKv4bkD4Ibp3n4bBYBYeNk9f+IJslUgDJxF34LhLNG2xszgpr0rjALAzQhP5GlqttEy
 F5bKYj+d9cCLQUO6Fd4WUtPMhGL9gEWwfp1HBoQ3DTA0MYwhyDcQ450oYir9rxstJbS/
X-Google-Smtp-Source: AGHT+IHJpK3tlBeH5jjTVVLpDuD5dH2hwOSVgciBjY3aGfPkYJ+RlwyScjCq3GNNQfv7BKBx5ukXvg==
X-Received: by 2002:a17:90b:1d52:b0:2fa:137f:5c5c with SMTP id
 98e67ed59e1d1-2fa23f44beemr20506270a91.1.1739211872218; 
 Mon, 10 Feb 2025 10:24:32 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa42dde5e5sm5519217a91.3.2025.02.10.10.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 10:24:32 -0800 (PST)
Date: Mon, 10 Feb 2025 09:40:15 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 09/14] net/zxdh: implement tables initialization
Message-ID: <20250210094015.67e40e4e@hermes.local>
In-Reply-To: <20250210015017.4105624-4-chen.bingbin@zte.com.cn>
References: <20250210014441.4105335-1-chen.bingbin@zte.com.cn>
 <20250210015017.4105624-1-chen.bingbin@zte.com.cn>
 <20250210015017.4105624-4-chen.bingbin@zte.com.cn>
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

On Mon, 10 Feb 2025 09:50:12 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> +static inline void
> +zxdh_np_comm_uint32_write_bits(uint32_t *_dst_, uint32_t _src_,
> +	uint32_t _start_pos_, uint32_t _len_)
> +{
> +	(*_dst_) =
> +	((*_dst_) & ~(ZXDH_COMM_GET_BIT_MASK(uint32_t, (_len_)) << (_start_pos_))) |
> +	(((_src_) & ZXDH_COMM_GET_BIT_MASK(uint32_t, (_len_))) << (_start_pos_));
> +}
> +

Would be more readable if mask computed once.
Don't need _ on function args

static inline void
zxdh_np_comm_uint32_write_bits(uint32_t *dst, uint32_t src,
	uint32_t start_pos, uint32_t len)
{
	uint32_t mask = ZXDH_COMM_GET_BIT_MASK(uint32_t, len) << start_pos;

	*dst = (*dst & mask) | (src & mask);
}
