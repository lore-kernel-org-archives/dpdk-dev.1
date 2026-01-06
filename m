Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10F0CEFCE1
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 18:01:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6B054028B;
	Tue,  6 Jan 2026 19:01:28 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id D4612400D7
 for <dev@dpdk.org>; Tue,  6 Jan 2026 19:01:26 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso10359265e9.3
 for <dev@dpdk.org>; Tue, 06 Jan 2026 10:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767722486;
 x=1768327286; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VvQPrEZ9+zP/3J048KQn7eDnL774FVzf96U02nQdQ/c=;
 b=QFGMCYs7FdiVtwIPqXvHgdCQjjbPN+6BHuyxwwasglByJcwZeY35uEPXxWKXXiIRzu
 MfLvhLoy61rGcobmaNTytbatNM6HSnOZXBEl+zplmm8N+foLpbwOKuAyRQYDEiTYirUF
 w6dWTbd6SRCc29RNjTvqz/qRkruLpNNyTz1zZNHpEf2hoax45hPuCYoaAFc1sM4gAM+U
 kZ9maNCO2P4POsxx+J01XnnwGm9UcAwoq7njIbGWRSR8sUunXLZ7kzugH6ZisJ7ThYHk
 dJ8sTNNhdj0snh700oHeLP2dEgSPZEK/vHwLfTOcR4WQBZBNxlHJiyrLdEXPYSZWtMIv
 1r1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767722486; x=1768327286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VvQPrEZ9+zP/3J048KQn7eDnL774FVzf96U02nQdQ/c=;
 b=cFotieDjGAydOH+mpq50y51H+jmOOeph9pX/9aPCc9vHxgk8sx/cb2/da3kYQk9pvA
 4FdRrQsxhzAJjGB7awC7If3DfQbB/gefSHjiERIDJDY4HxTVhwpWKN1P898/ub7L3jrK
 yB1qEu5fbLXOatWZSdDpO9fa4KavZ+sVzczpXMqyTDZ/N8M+5cru2DAIZwWqW9TlcQfs
 MI8AwSN+0k4eyXjfW9Fir0y5765SvMKA7qto/f7kGL+HW4VEdD/sybJESS1IZ0dddI8I
 Yssn5tIor+pVMN/cRLE7PcLTziMNLSUVXcupVG+VnZQiMsLFIHyDWFyd2iX9XOV9NtFA
 ee/Q==
X-Gm-Message-State: AOJu0YyNtxdDjVSEbAmZL3DZyxlWcCsGzhP2xCzQMZKHXmCgx6fCD6uf
 ik21x7dWF1IZzeWbJB3BuxzMHkCWD1lWMScTgSO68ltsTW8bEZtQErNlRlWF2qU3Pfw=
X-Gm-Gg: AY/fxX5ZFZttCwmruO76hZe++Q81686wNjZiVlSGeLHoTsHtLKptn1A4HRPGKEiHUyY
 Xkqoy5QETLzaf8yaYpRSBdmgDYyd/VJdtQu8PRf8K5SZSGrLCR/o88UAfPFHpm9J1ypsinWBx2p
 voLYVMFQAa0QC5bJqpMAo+462vizOsBip877eJr85ZA0rbXhQUscijhqLeqEq8WTWEzoxmPUtxr
 8HYqTcd4Ifts43Fby/4pCGVPiaPO8rWRyOUzSA+Hzy2y4YPoHrHtanKFOmMvaco+buBuvk6qGGQ
 rFlnb1ChLycljGI3E175ai9PqlaiDvSVx1znBS76y1AixXLEqLC9ZpotQacolTiqU7HOzqeGAnx
 IGYpmbkPn0G9NFZqmV2tG23aLVXLydHlIeE8/ASbzkJ+s7c4cPZ3Kmi4BiQ9iF4QaANh7FAmgRH
 IzsKtG7rWrSvrp2dyyzYrmmg5Vds/0dLRXb8Wu3CqciZr+JN06cj05
X-Google-Smtp-Source: AGHT+IEck2JFJndrGNl+bOLHgMc95z22+Z8rGNMB7h5wNi3Z66QVR/sIc1opM4BbT7RDpDytnzxBHA==
X-Received: by 2002:a05:600c:45c9:b0:477:c478:46d7 with SMTP id
 5b1f17b1804b1-47d7f098346mr41135065e9.22.1767722486011; 
 Tue, 06 Jan 2026 10:01:26 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f653c61sm54110355e9.10.2026.01.06.10.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 10:01:25 -0800 (PST)
Date: Tue, 6 Jan 2026 10:01:21 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v2 1/2] test: add a test for null PMD
Message-ID: <20260106100121.0173d424@phoenix.local>
In-Reply-To: <0e08cb939d1147c694b46c55c9668db2@huawei.com>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260106164815.158430-1-stephen@networkplumber.org>
 <20260106164815.158430-2-stephen@networkplumber.org>
 <0e08cb939d1147c694b46c55c9668db2@huawei.com>
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

On Tue, 6 Jan 2026 17:40:43 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> > +/* Create random valid ethernet packets */
> > +static int
> > +test_mbuf_setup_burst(struct rte_mbuf **bufs, unsigned int burst_size)
> > +{
> > +	unsigned int i;
> > +
> > +	if (rte_pktmbuf_alloc_bulk(mp, bufs, burst_size) != 0)
> > +		return -1;
> > +
> > +	for (i = 0; i < burst_size; i++) {
> > +		struct rte_mbuf *m = bufs[i];
> > +		uint16_t len;
> > +
> > +		/* Choose random length between ether min and available space */
> > +		len = rte_rand_max(rte_pktmbuf_tailroom(m) - RTE_ETHER_MIN_LEN)  
> 
> Nit: could technically use rte_pktmbuf_tailroom(m) - RTE_ETHER_MIN_LEN + 1.
> 
> > +			+ RTE_ETHER_MIN_LEN;
> > +		m->data_len = len;
> > +		m->buf_len = len;  
> 
> Not sure why we are changing buf_len here.
> 
> > +	}
> > +	return 0;
> > +}  

Next version is going to use packet generator stuff that is in test infra now.
