Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F6DECD990
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 17:07:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AEBA42670;
	Thu,  5 Feb 2026 18:07:55 +0100 (CET)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54]) by mails.dpdk.org (Postfix) with ESMTP id 01A0A40684
 for <dev@dpdk.org>; Thu,  5 Feb 2026 18:07:53 +0100 (CET)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-64b7318f1b0so1511135a12.2
 for <dev@dpdk.org>; Thu, 05 Feb 2026 09:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770311273;
 x=1770916073; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uPVqX0RYtq7EzH0RoJ11bsZRvqCzxLSxGLFv2XqqTAk=;
 b=ILmRsE8mSmbDYSfwe8jQOWkvbzO6y59HWbuiSlbL+GIeInB7AEnx08lCdfNwWxucrF
 KKELzRcjhbTGzO2dEzG+mr6jjfA1fkJOIE/QhVRIMA2auSunAJszLWxTYxMfjBzHcjJa
 NvIxdGVQFHRRTY3m/RJzYiaDhGkJ+pvfFQHgQ2eJuiNKZQU4ayn0O3B7/prIs4pOsZam
 s2DtPvQ9gcVoQ9RwtkL4zSLty6LyynRFwnfHtrIM+JtHVjZeIkoD8w6KMnidFvKfYW/6
 NH06JNdx1ttiTyHsN0dqhGf4mDiHtFAMiZd6jBYwhSnRFQsn2O+DEdZThFK6V1jJ0yAF
 bMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770311273; x=1770916073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uPVqX0RYtq7EzH0RoJ11bsZRvqCzxLSxGLFv2XqqTAk=;
 b=mR3XIk5uPLKck5F4Hc4rsTmcTjIo1/rj0UPpwe71E6GVqDf4pLJ12rrZxRHmi/gnDp
 2BlaKu1Vsjmjf8kQtInbXF7LNAHNm243TFgpqcAeYDyLTp5Rv13knSX0mn/EMyB+SwRF
 n2nVP08k6aJyhFRZQqPk/1K2vNiBDDiuJRZEcmeV6gzeACRUvOIQM/NopHOn3vJu+g3+
 4ifPiesCNviTZu+3+Fz46mEIbNQk1kTk65eLbd34tOr0RwpcpPSM2eyXl6VO+9rtkTPO
 TLDM0mpgHXJ6BlrGLQ9ldKJyqMoQLYDEFRwOfP3ogHhH0yfNk1rbg03bBvpLtTbBZ71D
 T7lw==
X-Gm-Message-State: AOJu0YyJjaS2cWnBml6dzdBX9ackgUQrIUzpmjIDoV1SyhoH6dDEIJvB
 xbFUw97+pedPKNNYQQ6OACozwZVE2+wHvnN4DZK3yChr0ZoxESnmsCMfT4BWL5oOdEw=
X-Gm-Gg: AZuq6aLPz52LQikxJiD8I/xrKsO2DpYzlDAUk0pjNX0OZ2PPYKJBPT39JHA+zkaB4WV
 N2HzfjpxQyeWtSN2sCr9c5ZJAMy3A8iSyaQIrLVeSVNoKyaz+/yWBBzW34tXkqAFKaJnFXy57De
 GH3fFDSHdLaPjzvFlBCXYmB3JtdEaxNRGeRv1ZX29KLHTh5ggWyLJcoOVoa84tXs1dLs9PfuWDI
 nqCkNFJj+n4uBwFQRcz80l59TMvluAxSe8TxoJpiI+Cu4/nJlNY0LKP0jMbbk6cGgyjTmkZv7nN
 96JShd6wmDxMsKH9B/u20GULwUHNtBkwiNRThF9O6w7z0ZqPPv3zqeyo5WPojKFeL59upzGSvcV
 XL2guyl+UB2WYsZdvTCJu9TJXYTiQ5antjys89xD6a9yanxuLYZPr1AGRRaczLk6IB14OPvwKz9
 YWzueNbLnoE+dwwdW68VycqkwRKjNk0SFO02qo26mwd7FYoME81V5mXgkHA4B2ycQ=
X-Received: by 2002:a17:907:7fa8:b0:b8a:f29e:307a with SMTP id
 a640c23a62f3a-b8e9f396397mr526111266b.57.1770311273035; 
 Thu, 05 Feb 2026 09:07:53 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8edacf1211sm1237366b.49.2026.02.05.09.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:07:52 -0800 (PST)
Date: Thu, 5 Feb 2026 09:07:46 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Erez Shitrit <erezsh@nvidia.com>, Alex Vesker
 <valex@nvidia.com>
Subject: Re: [PATCH v5 5/6] net/mlx5: fix LTO stringop-overflow warning
Message-ID: <20260205090746.67bedd30@phoenix.local>
In-Reply-To: <fn3ooyikqw7dwka3kmwz2mtpigukakvwyema44othruighbmjn@ye5xqkfbnzm7>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260120195418.466318-1-stephen@networkplumber.org>
 <20260120195418.466318-6-stephen@networkplumber.org>
 <fn3ooyikqw7dwka3kmwz2mtpigukakvwyema44othruighbmjn@ye5xqkfbnzm7>
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

On Thu, 5 Feb 2026 14:43:35 +0100
Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:

> On Tue, Jan 20, 2026 at 11:52:10AM -0800, Stephen Hemminger wrote:
> > When compiling with LTO (Link Time Optimization) enabled, GCC's
> > interprocedural analysis produces false positive warnings about
> > potential buffer overflow in mlx5dr_action_prepare_decap_l3_data():
> > 
> >   In function 'mlx5dr_action_prepare_decap_l3_data',
> >       inlined from 'mlx5dr_action_handle_tunnel_l3_to_l2',
> >       inlined from 'mlx5dr_action_create_reformat_hws':
> >   warning: writing 4 bytes into a region of size 0 [-Wstringop-overflow=]
> >     memcpy(dst, e_src, MLX5DR_ACTION_INLINE_DATA_SIZE);
> >   note: at offset [140, 524248] into destination object 'mh_data' of size 64
> > 
> > With LTO, the function chain is fully inlined, giving GCC visibility
> > into the 64-byte stack buffer 'mh_data'. However, GCC's static analysis
> > cannot determine that num_of_actions is constrained to either
> > DECAP_L3_NUM_ACTIONS_W_NO_VLAN (6) or DECAP_L3_NUM_ACTIONS_W_VLAN (7)
> > by the callers. It assumes worst-case bounds that greatly exceed the
> > buffer size.
> > 
> > Fix this by adding an explicit bounds check at function entry. The
> > valid values for num_of_actions are 6 (no VLAN) or 7 (with VLAN),
> > which produce maximum buffer usage well under 64 bytes:
> >   - offset 12 + (num_of_actions-3) * 8 + 2 = max 46 bytes for 7 actions
> > 
> > This provides GCC with the proof it needs that subsequent memcpy
> > operations are safe.
> > 
> > This is not a data path function - it executes only during flow rule
> > creation, so the additional check has no performance impact.
> > 
> > Bugzilla ID: 1710
> > Fixes: f8c8a6d8440d ("net/mlx5/hws: add action object")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >  drivers/net/mlx5/hws/mlx5dr_action.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/net/mlx5/hws/mlx5dr_action.c b/drivers/net/mlx5/hws/mlx5dr_action.c
> > index b35bf07c3c..3b12506577 100644
> > --- a/drivers/net/mlx5/hws/mlx5dr_action.c
> > +++ b/drivers/net/mlx5/hws/mlx5dr_action.c
> > @@ -3620,6 +3620,20 @@ mlx5dr_action_prepare_decap_l3_data(uint8_t *src, uint8_t *dst,
> >  	uint8_t *e_src;
> >  	int i;
> >  
> > +	/*
> > +	 * Bounds check to help GCC LTO static analysis.
> > +	 *
> > +	 * When LTO inlines this into mlx5dr_action_handle_tunnel_l3_to_l2(),
> > +	 * GCC sees the 64-byte mh_data buffer but cannot prove num_of_actions
> > +	 * is bounded, causing false -Wstringop-overflow warnings.
> > +	 *
> > +	 * Valid num_of_actions values are DECAP_L3_NUM_ACTIONS_W_NO_VLAN (6)
> > +	 * or DECAP_L3_NUM_ACTIONS_W_VLAN (7). This check gives GCC the proof
> > +	 * it needs that the loop iterations stay within buffer bounds.
> > +	 */
> > +	if (unlikely(num_of_actions > DECAP_L3_NUM_ACTIONS_W_VLAN))
> > +		return;  
> 
> This function can be executed as part of fast path
> in async flow creation, so if possible
> I would avoid adding such a condition.
> 
> I tested locally with GCC 14.2.0 and it looks like
> if this condition is changed to equivalent __rte_assume(),
> then this condition is removed from generated code
> (https://godbolt.org/z/afx8jjr6Y as an example,
> code generated by LTO also optimizes the relevant code).
> __rte_assume() also fixes the LTO warning.
> 
> Could you please change the condition to equivalent __rte_assume()?
> 
> > +
> >  	/* num_of_actions = remove l3l2 + 4/5 inserts + remove extra 2 bytes
> >  	 * copy from end of src to the start of dst.
> >  	 * move to the end, 2 is the leftover from 14B or 18B
> > -- 
> > 2.51.0
> >   

Yes rte_assume works will resend
