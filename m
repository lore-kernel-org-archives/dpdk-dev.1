Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E50C7EE33
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 21:50:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2929B40647;
	Thu, 26 Jun 2025 23:50:41 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 1849D402A6
 for <dev@dpdk.org>; Thu, 26 Jun 2025 23:50:38 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-312e747d2d8so2413670a91.0
 for <dev@dpdk.org>; Thu, 26 Jun 2025 14:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750974637;
 x=1751579437; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TOxHrtk08lIpGD3GQjn4S/clOAcbQ8svexDHyVpNe8U=;
 b=TlwrHr61c3J2SI7yM83OmhbHDw0dLtA9pLJp8KvBNqXad55XmVjU3FZrbMscuZ4Dq7
 xuQtC947fzUhJ/L8hy7jIvnUBfrBj/AA08XoRQcTc9ZnOG9IqAtfTbyghTT2K09Uj2GA
 u7oB6m/Lw2TAx2JjJ8NhQCZxirrcmyIVuBiqwIp09yhzwYu8JRTUxagYTc4o9JPjEAy9
 4mxYDrG2J+qZZRdisz8LUdE/RU0nzIz/WRxXXRRwTAwip5m5bFGHT5k7VEbo32Hkt0ZG
 2RDm/qqOEyWNdHHTFFk502TbVawm9wtX5akfgRgfzFUuGOj6Omi+Clups1f9TX6fwj3f
 RsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750974637; x=1751579437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TOxHrtk08lIpGD3GQjn4S/clOAcbQ8svexDHyVpNe8U=;
 b=fSD5Qp0X2ojprDRnWCOlPVEDQRm7M0Epma4+kzagPzO7c/C1/oasyyOfMv7MeU9hFb
 zxtptwmYFPLJ0HNGP3ymqdKfjg7Hpyl86MSmCT086dJrQfEdsoMWM3GakL9d9WRwdkdj
 f7JvEwA4fU2ZTB62/F/Z0eeSUGmx1AC1fHSHO2sv2IlvzvoW2QjBY0bd9zA6bFmBFwlp
 xcvTWXuzQHXPCpRdXVhp6UqTW14lCFAWNgRv40zeCEN0vj2h+3AFO26mwfs5o/KdrKYm
 vNeZFk+cZWUUN7s+VneKSbtTRpvYNEYmZHll2nKTqMiGjl3v4vd4hPMy/Qy/8FVSywIM
 hcqA==
X-Gm-Message-State: AOJu0YxoRXZV9phUF+qcvP/ubTicL6FGZAdyaCOnpGf1vE6HD5GqlG0W
 y4erzAbWexAtop4Y6vOlAfVLPRTCl7bqLZry17QnQRJAIAbvn5MAobrB/RN6NmP2J1s=
X-Gm-Gg: ASbGncueiHNsTtRGfrw+CjSG85Waw/aKX2ZzFWDX/TUQEcyX6lIiNasm5mRNHEhd5eI
 ak9yzqEa93lJ4W1duZI5SpXwYn0gr8RXIwJ/0BAaS7fujJKMZ10fDOTFUwa7gXnTrV4YeZfHoP9
 nQdhbsNUG3ynXkReXqzkFOdJ7kSO7Aw1d1rxitLre2tMsuuGnAIEgyNv85GntbzNV99zcmunVlH
 RCy2choeq+p5gdpGp+7ReG+VOgl/MGtq6AtZWaIlUnjfNLRbrDlzoiSh4oU6R8ZGpdba9Z71fa7
 UBzUapcn894glxgwnQfXe2b3eLvlSyej75nzLnkC107BoA3UGJBJ23LBLoE+i6gmbxXjcG/t8kg
 AqBuN0T0sKm+teLiDLMY92IjT/5aYcPILWTC7Dlc=
X-Google-Smtp-Source: AGHT+IFBJX9tBobD5/wWAaeJkJYQxW+r5Xr1ufxP8KgJQSbYnyMbXF97qD8NH5h8wnMy1wCeVvkgNA==
X-Received: by 2002:a17:90b:5347:b0:311:ab20:1591 with SMTP id
 98e67ed59e1d1-318c92c083emr819600a91.15.1750974637093; 
 Thu, 26 Jun 2025 14:50:37 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb2e25b9sm610335ad.2.2025.06.26.14.50.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 14:50:36 -0700 (PDT)
Date: Thu, 26 Jun 2025 14:32:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Feifei Wang <wangfeifei40@huawei.com>, Xin Wang
 <wangxin679@h-partners.com>, Yi Chen <chenyi221@huawei.com>
Subject: Re: [RFC 13/18] net/hinic3: add dev ops
Message-ID: <20250626143256.73fb353f@hermes.local>
In-Reply-To: <20250418090621.9638-14-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250418090621.9638-14-wff_light@vip.163.com>
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

On Fri, 18 Apr 2025 17:05:59 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> +static void
> +hinic3_tx_queue_release(struct rte_eth_dev *dev, uint16_t queue_id)
> +{
> +	if (dev == NULL || dev->data == NULL || dev->data->tx_queues == NULL) {
> +		PMD_DRV_LOG(WARNING, "tx queue is null when release");
> +		return;
> +	}

Looks like the calling function eth_dev_txq_release in ethdev already checks this or
would error out.

