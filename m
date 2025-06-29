Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24410C7EE30
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 16:45:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B98C402DB;
	Sun, 29 Jun 2025 18:45:17 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 0C9874025D
 for <dev@dpdk.org>; Sun, 29 Jun 2025 18:44:58 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7d3efcb9bd6so362708785a.1
 for <dev@dpdk.org>; Sun, 29 Jun 2025 09:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751215498;
 x=1751820298; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AMdWIGdF1uYWRwv+edNt1ZqyOFiXRntmrVQy1GRRoL8=;
 b=SIigxdh+gXabDvXE7vjLWs4XxZ7TOvgNZbc5hQQ13FnXL7jwVSAeJ291tb4HkoGWWb
 yl9fl4QqjE+U1+C9tnv3tvGblNWcL5wgvd3EFd/kz8UcYsgETOsVPJx9rX5C2Vpoodfo
 724dGyhGllucAUf70TISA3qzaiijDfLfBKsfZh7XXgV6B444l2SQUbtFPCA1Oy7jOXzd
 S2z2Y04yDs0JEn2XK2lyZzjuWXPkZz0ByzPkijJWzQmKG2G+wVcxB323n646hlj7O5+k
 9zX4/pGVxYPXMUbV8WIaZg2s6EY3ZP1mnkToF0nG3/Mv/FeO07N/URbNpW7AFMICJp43
 jDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751215498; x=1751820298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AMdWIGdF1uYWRwv+edNt1ZqyOFiXRntmrVQy1GRRoL8=;
 b=iIiZZgKkdKXabIEjSUSfmRoooIjhPkNyNjRBkTo87ucL7D0SluRAIzVho5D4U8kTKn
 QgubdMFMVTujZhn+08F8eL6JH5AKpM7HfgaSHYR3NxZDxF54ff2LUReLMHXq+L3PzeBG
 OqfzgaZdUqfJ0wEq2W5xKHN16x6j3LDSOde/r1HJz9KSoJ9wK4nWyMwG9lQ7M0BRJvre
 wANR55K+wCU06O/F3QxbWWz+kyHXE4E+VlCODkYK+1F/Tv//KqxDBe1mLzvz87D4vVom
 YTMoYZv4bp9XD3yfFvf+nnJ6gqRbD4ZcEmaIkLOc0wYrmnmIr8e/mhD9kkmlRtIBUr6R
 rysQ==
X-Gm-Message-State: AOJu0YwFftEzoPpG5WHuiPJqGebzzcD1IbStt0Wo4mVTwT97ge6arkrK
 SX7b7/5OPp+h3mn6CbwA3aGjctbTHuslRikZjQLwwVvTm+RQpLVzC9Jabm93Dea3kZs=
X-Gm-Gg: ASbGncsqm8N4IQmDVMvLYlo1O2+o/wRKukpJxeRxe20LTbJXKLnrX45pMRVsvMBzSJ1
 f+WPunWSQmZMVRSCrqF9+s6Kfv9CT4NZiklBd6lBE/EDSw++xvjDrzQ/T+lO1PADDFvF+2wHuQ+
 jc2Jfbk6Pp24CBUMxP2O0igoQwWKSJtZdmKCFpvCKKOh2MUa2DRGlfeCW4WuqP8XRGdhMmCk4kk
 i9PRtCrVPwaQvxFMBY4GL62jXXylSR6d6J6pNmPt7GGILQK33b8wD9FK96xzpHG9iLqtOKMwAet
 KXYWd1GS2qgrMBbOaMJBGPByNJBuhvHH/8VoaTcKwM9s0MbngLvq2kSzf9/LzvL4VB4d2uqu4w4
 YzPOryk2fb7miLcNC8yFXf0boQ+ZKiWCf7FDgk9U=
X-Google-Smtp-Source: AGHT+IG54qtPJoMpYhtnoP2Adf3axZAQ1bBlhoj87smJHCkEkrrNiyMVVYri6r6uKpAtFv16qS387A==
X-Received: by 2002:a05:620a:8812:b0:7d3:f3e1:b8db with SMTP id
 af79cd13be357-7d443990aa7mr1179945385a.31.1751215498158; 
 Sun, 29 Jun 2025 09:44:58 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d44316547bsm456985385a.27.2025.06.29.09.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 09:44:58 -0700 (PDT)
Date: Sun, 29 Jun 2025 09:35:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Subject: Re: [v4 04/10] bus/dpaa: optimize bman acquire/release
Message-ID: <20250629093547.48b3b23c@hermes.local>
In-Reply-To: <20250611071039.2939950-5-vanshika.shukla@nxp.com>
References: <20250610091411.2500413-1-vanshika.shukla@nxp.com>
 <20250611071039.2939950-1-vanshika.shukla@nxp.com>
 <20250611071039.2939950-5-vanshika.shukla@nxp.com>
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

On Wed, 11 Jun 2025 12:40:33 +0530
vanshika.shukla@nxp.com wrote:

> -#define BMAN_BUF_MASK 0x0000fffffffffffful
> +RTE_EXPORT_INTERNAL_SYMBOL(bman_release_fast)
> +int
> +bman_release_fast(struct bman_pool *pool, const uint64_t *bufs,
> +	uint8_t num)
> +{
> +	struct bman_portal *p;
> +	struct bm_rcr_entry *r;
> +	uint8_t i, avail;
> +	uint64_t bpid = pool->params.bpid;
> +	struct bm_hw_buf_desc bm_bufs[FSL_BM_BURST_MAX];
> +
> +#ifdef RTE_LIBRTE_DPAA_HWDEBUG
> +	if (!num || (num > FSL_BM_BURST_MAX))
> +		return -EINVAL;
> +	if (pool->params.flags & BMAN_POOL_FLAG_NO_RELEASE)
> +		return -EINVAL;
> +#endif
> +
> +	p = get_affine_portal();
> +	avail = bm_rcr_get_avail(&p->p);
> +	if (avail < 2)
> +		update_rcr_ci(p, avail);
> +	r = bm_rcr_start(&p->p);
> +	if (unlikely(!r))
> +		return -EBUSY;
> +
> +	/*
> +	 * we can copy all but the first entry, as this can trigger badness
> +	 * with the valid-bit
> +	 */
> +	bm_bufs[0].bpid = bpid;
> +	bm_bufs[0].hi_addr = cpu_to_be16(HI16_OF_U48(bufs[0]));
> +	bm_bufs[0].lo_addr = cpu_to_be32(LO32_OF_U48(bufs[0]));
> +	for (i = 1; i < num; i++) {
> +		bm_bufs[i].hi_addr = cpu_to_be16(HI16_OF_U48(bufs[i]));
> +		bm_bufs[i].lo_addr = cpu_to_be32(LO32_OF_U48(bufs[i]));
> +	}
> +
> +	rte_memcpy(r->bufs, bm_bufs, sizeof(struct bm_buffer) * num);

Use memcpy instead. There are more compiler and security checks around
memcpy().

> +
> +	bm_rcr_pvb_commit(&p->p, BM_RCR_VERB_CMD_BPID_SINGLE |
> +		(num & BM_RCR_VERB_BUFCOUNT_MASK));
> +
> +	return 0;
> +}
