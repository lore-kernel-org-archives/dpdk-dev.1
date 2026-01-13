Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9585D2F33D
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 16:08:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62E314064E;
	Tue, 13 Jan 2026 17:08:07 +0100 (CET)
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68]) by mails.dpdk.org (Postfix) with ESMTP id 96FE6402ED
 for <dev@dpdk.org>; Tue, 13 Jan 2026 17:08:05 +0100 (CET)
Received: by mail-wr1-f68.google.com with SMTP id
 ffacd0b85a97d-4308d81fdf6so4053298f8f.2
 for <dev@dpdk.org>; Tue, 13 Jan 2026 08:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768320485;
 x=1768925285; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhB4TwAVWxJcUwDOwj0ddgNkHmFyiKyrLVASzIhOC/I=;
 b=B4EOristmrTLQoTDh4HHVkdn5ZyUAZQvx7FTQDBsuNgmCHye6SBok6LmlDhp7RIawB
 8Md5xqONSqjzcFi6XS34gjzf5E1wxD2x1vT7PXkzQQ8c+rTcEUE6QqVEykjDjtr3uRSf
 lFRbETccG/Bxs0aubjOJiLkjWyMQo7nIINelU8YoPerBLrzKWobWo/O7j/d+y/EDw48T
 AmJC3uJ4BI7reP2q1tP3fs+RtemTJMatL2E8V4FTgt6P1V6UMsMcJVC/FZUpKP3Oo+gL
 tAREudGMKBjbNjMnWB6g3YZG5olWTFTQIzl+36piWOz7K2sFLKKe5hrOm74URfgGWrmW
 I+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768320485; x=1768925285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QhB4TwAVWxJcUwDOwj0ddgNkHmFyiKyrLVASzIhOC/I=;
 b=VDpkd2fuuELbc+E3oPwqpica48KRaXn5MSm9Liz+t1gziZKxW3J1dReSw553+4rNl4
 8If58EnO4eeA5oawP8ZqGIgdLMM3C/tpEbvix3dlyD6zQXDtJW8SJWLv7k2i4dMtmHD6
 Lo/hvcSTVCoddH8sQKi/zFg9RksmpqSwpv2wFPycYSeqsj8xO6mRbP2WO5QRvXvfysMI
 XdBa6hi73y5qMO/SBo38E9g9m3heZ3pE6+fyJq41auFi+LPt2z1Rase4p695zxUS//XL
 PzkIFJNvfeI2qIjV6ZuunAGIWDamJtJy/vvCUAecxGSgE2DLgdIW1m7xSJ2noxp4j+Ob
 oRDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfM6oIgpNKw/zRZdlktaMH0h44K/vTGJDDHedV5cGIrO8+emPzGLql+B+O/KmHvL0uYGU=@dpdk.org
X-Gm-Message-State: AOJu0YwuyXiekwF1Xt652U3uYVGFtrUpHu/8tMWy+8blxP3FCY0ztH4i
 6IaVdPOr2MJse7lMjAAQ4qcj9qpPIo1/XFBwwXoppH2NUpzoaBJ7TkDZBqiaGesELsA=
X-Gm-Gg: AY/fxX4jC1hM8TO1cVKlb5fBxp3eHUi3IA5tIU0InqZ028u/LSw5llo1TvKiqzDVsP4
 BQFW4xN4RMjkO6t0q3tEFO8gpW84if+/QCktI7kiZzFmz6OIYV9b6WQE3VYaKL4xjvHSJx/voDu
 ehifZrgc1AawLMvjgVa2Bc2IYIHcKimrDgLYfthkUYPHgNcMiyeaHl6GmXKgWiD8XbiRanAKr2h
 S0BpKxZ4V6xWGPlvd86NDOh8g+JG/yRhllxbK63YiyB3nIZ2k/luaVGqyfis+zSdeInhd6ikWNJ
 94fiM2ceEyCHZHQWVqJiiMp8xGO+p68V2W4u0BucaDvSE/ZY67uo8ayTTuGYTN5Q4raVRVKFy2K
 lQ3Ocfmf0t329Ti8UE/knSmZsrJibNr9YPUvXJNDzrM4nYQlck3K7eO/p8Tr4oaB4d/91ejHwm6
 YqA628By8BNta5CrIlw6o2zsbRKBQTzKCI0vdmlS8h548eVLKphat9
X-Google-Smtp-Source: AGHT+IGYtJ7KDdrXzGebyr4eeAi7iPDFXdhnQx/mngSDmVxf2TTOVhBxTc2JPg3stI+E9WJN4KWmNA==
X-Received: by 2002:adf:ea03:0:b0:432:d9ef:3bdc with SMTP id
 ffacd0b85a97d-432d9ef3f40mr14154765f8f.46.1768320485053; 
 Tue, 13 Jan 2026 08:08:05 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dacc5sm44814601f8f.5.2026.01.13.08.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 08:08:04 -0800 (PST)
Date: Tue, 13 Jan 2026 08:07:59 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, Morten =?UTF-8?B?QnI=?=
 =?UTF-8?B?w7hydXA=?= <mb@smartsharesystems.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "techboard@dpdk.org" <techboard@dpdk.org>
Subject: Re: mbuf fast-free requirements analysis
Message-ID: <20260113080759.30a4ae29@phoenix.local>
In-Reply-To: <69116a74e319436fb4a06fb6efd684d3@huawei.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F655E0@smartserver.smartshare.dk>
 <0d1645e1c83f4ec4ad676095b910845c@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655E5@smartserver.smartshare.dk>
 <d290adf103244ff7be53844ee32bb6d0@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65601@smartserver.smartshare.dk>
 <4ef23a6663774a119d3087fb21ede984@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65608@smartserver.smartshare.dk>
 <aUmDTsLxNN-GOGDC@bricha3-mobl1.ger.corp.intel.com>
 <69116a74e319436fb4a06fb6efd684d3@huawei.com>
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

On Tue, 13 Jan 2026 14:48:19 +0000
Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:

> > > > > > >
> > > > > > > 	__rte_mbuf_raw_sanity_check_mp(m, mp);
> > > > > > > 	rte_mbuf_history_mark(mbuf,
> > > > > > > RTE_MBUF_HISTORY_OP_LIB_PREFREE_RAW);
> > > > > > > }  
> > > > > >
> > > > > > Thanks Morten, though should we really panic if condition is not  
> > > > met?  
> > > > > > Might be just do check first and return an error.  
> > > > >
> > > > > __rte_mbuf_raw_sanity_check_mp() is a no-op unless
> > > > > RTE_LIBRTE_MBUF_DEBUG is enabled.  
> > > >
> > > > Yep, I noticed.
> > > >  
> > > > >
> > > > > Using it everywhere in alloc/free in the mbuf library is the  
> > > > convention.  
> > > > >
> > > > > And if we don't do it here, the __rte_mbuf_raw_sanity_check_mp() in
> > > > > rte_mbuf_raw_free() will panic later instead.  
> > > >
> > > > Why?
> > > > This new routine (rte_mbuf_raw_prefree_seg) can check that mbuf
> > > > satisfies fast-free criteria
> > > > before updating it, and if conditions are not met simply return an
> > > > error.
> > > > Then the driver has several options:
> > > > 1) Drop the packet silently
> > > > 2) Refuse to send it
> > > > 3) Switch to some slower but always working code-path (without fast-
> > > > free)
> > > > 4) Panic  
> > >
> > > It boils down to purpose.
> > >
> > > The function is designed for use in the transmit code path designated for fast-free,  
> > where the application has promised/hinted that packets are fast-free compliant.  
> > > Violating preconditions in the fast path (by passing packets not compliant to fast-  
> > free requirements to this function) is a serious type of bug, for which DPDK usually
> > doesn't provide graceful fallback.  
> > > I don't want to make an exception (and introduce graceful fallback) for the  
> > designated fast-free code path.  
> > >
> > > My answer would be completely different if we were designing an API for standard  
> > packet transmission, whereby some packets living up to certain criteria could take a
> > faster code path for being freed.  
> > > If that was the case, I would agree with you about returning a value to indicate  
> > how to proceed, like rte_pktmbuf_prefree_seg() does.  
> > >  
> > I would tend to agree. The extra handling for those cases just expands the
> > code and adds more potential branches to the resulting binary. Lots of the
> > fastpath code just assumes you know what you are doing, and violating
> > constraints will lead to panics and segfaults generally. Therefore panicing
> > in this case doesn't seem a bit deal to me.
> >   
> I understand your point lads, and somewhat agree: if we plan to keep FAST_FREE flag forever,
> then it is probably the simplest and safest approach.
> My hope was that such function will open a possibility for the PMDs to implement similar
> perf improvement completely transparent to the user (without need for special flags and/or pre-requirements).
> But might be I am looking forward way too far with it.
> Even what Morten proposed above is a big step, so ok - let's deal with it first.
> Konstantin    
> 

We should document any restrictions on this and other semantic assumptions.
Ideally, then AI review tools could help new and old developers see places
where the assumptions are violated.
