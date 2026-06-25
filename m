Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B315DCDB479
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 02:26:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FF4E40613;
	Thu, 25 Jun 2026 04:26:05 +0200 (CEST)
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com
 [74.125.224.53]) by mails.dpdk.org (Postfix) with ESMTP id EC2BF402A3
 for <dev@dpdk.org>; Thu, 25 Jun 2026 04:26:03 +0200 (CEST)
Received: by mail-yx1-f53.google.com with SMTP id
 956f58d0204a3-660e9ff0587so1119986d50.0
 for <dev@dpdk.org>; Wed, 24 Jun 2026 19:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782354363;
 x=1782959163; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GI8bz3SOy859ZY6XFhcsKpgO2AALhNGEvN7a8T4npK8=;
 b=veKzq6dCqZnFlIN1M/ynHMTv5KaF4EnG3k78V1bg9Yl2fnQKW6FhthsbgUrtTe53ky
 4AUsjpRX3HR2ejZ1yB80z23Xb4yq/oy99TBWmUdonUwa9YiklsA25q9cOZjQ75qAXVRB
 y33vL9wctz98C4Rj6sxQJ7a21ofx6JDStWNoJPDKYr20ZnPanGsM9owG2gpbtdLBUSqA
 yTEfD0ZKcI98zwjPuR21/zTfEmDvTuGbheWdnRC0Gham+ibIr6BG0Qsc/wHp9/dv/HWe
 6JzaQaAzztFzWT0M31BNUO32O9NGXEb8BX8UgwDv0zhGvB+Za8AoqLe/wQ0pqAflaw2w
 7HEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782354363; x=1782959163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GI8bz3SOy859ZY6XFhcsKpgO2AALhNGEvN7a8T4npK8=;
 b=n6md2k9nVktN9Nc+UB5SrsDjt/zt3N7qJrP0FV3BWCfUzeF45SaYozjzjtd6gdEAwC
 gAxApV92CJTjoQ6LZOiW8Ho7csHn1YSRbWJVQ3jifmOvmCgFNJ+TNVXHEOcnv1e69Nxx
 4qlSTPxbnF0LZlzh3J0ke/WiTRQ3aXJTShCCRUXoEw0+Rlk6vj7g7cMAmUamJ6BDusjc
 m2yLpDMigo7V+XFc0SRS/P+jH5ir2QxgnBGjqUStAmmS7ZW9vo58HKB/0QhmZq+uOWEp
 qbVHkEZGEste0A70Tj0nlx5EsZ8ktRWoFzVptr0pC3D0K4YFmM7Bfc1qcly00bvH8O3v
 /rAA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqFPvxN4IOr0vH4C4q8P8rakdGWBNfmEq1HIfksVTD0qZ4v63p2D3igkEs16cWhrBv+Qsw=@dpdk.org
X-Gm-Message-State: AOJu0YzdqDrCSpIFRf1v8aOG0CYOUcrifxWr4grOh9jAcnevgsziK7vL
 Ra1mTWkfagzBqLOUKDFNsqnKo3pbk/2/y/RGAv19dQ3Ej1FDUAukHZey8iRgotBA5Nc=
X-Gm-Gg: AfdE7cmUTjREEX3tc/NAWD67X6gUJuQtZADlYFoR3PrJkHWP3PseSwj/h3x8OJvYcyP
 g3PMnCYa2jeJNDMS45SVBHqMOZSvCVvLDNlsUdepZnOl+BRWKs9PwX+TQWps/+iPTIhUzWAbfqC
 c25mG6kWf7KrTF6qaz6BwlEIusq08YN2qhvHMG8CAbIX1+AZ+hI2iocGnGkktdBgCOe1II2gaJw
 UlRCOvSP74iWeXFYlNN1ZsBeiYsAcyUCneR+Oa/T3PSSq7v4MfwHitr+uJEVEu1QgjdJCyXmW8R
 qBOpVL5M0sVdadPokpanrRtj/zVdc8ThHJDSePgDV1JZJndS7YTsBD1vKA01B4qJiBjvR/B++gj
 VChTLvin8xn2cIL4Y91VHNsHpCIy7VAfIB3xd6ZcVNpya/6ksAfxpq95qmufuwAYHjYwel6cRkG
 adLLDbjNBllSP3OheL7gf0m7K3t2hCsqOj9TBBEKzpVT9qCHFyFQbaSA==
X-Received: by 2002:a05:690e:1686:b0:661:37ed:647b with SMTP id
 956f58d0204a3-664881414e3mr450262d50.14.1782354363132; 
 Wed, 24 Jun 2026 19:26:03 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6647f74a3e2sm735366d50.2.2026.06.24.19.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 19:26:03 -0700 (PDT)
Date: Wed, 24 Jun 2026 19:26:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: "'Zaiyu Wang'" <zaiyuwang@trustnetic.com>, <dev@dpdk.org>,
 <stable@dpdk.org>
Subject: Re: [PATCH v10 13/21] net/txgbe: fix link stability for 40G NIC
Message-ID: <20260624192600.579930ee@phoenix.local>
In-Reply-To: <05c401dd0444$1c9a3ba0$55ceb2e0$@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260624115254.20348-1-zaiyuwang@trustnetic.com>
 <20260624115254.20348-14-zaiyuwang@trustnetic.com>
 <20260624091858.20289fc8@phoenix.local>
 <05c401dd0444$1c9a3ba0$55ceb2e0$@trustnetic.com>
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

On Thu, 25 Jun 2026 09:44:07 +0800
Jiawen Wu <jiawenwu@trustnetic.com> wrote:

> > > +void txgbe_e56_rx_rd_second_code_40g(struct txgbe_hw *hw, int *SECOND_CODE, int lane)
> > > +{
> > > +	int i, median;
> > > +	unsigned int rdata;
> > > +	u32 addr;
> > > +	int RXS_BBCDR_SECOND_ORDER_ST[RXS_READ_COUNT];
> > > +
> > > +	/* Set ovrd_en=0 to read ASIC value */
> > > +	addr = E56G__RXS0_ANA_OVRDEN_1_ADDR + (lane *  E56PHY_RXS_OFFSET);
> > > +	rdata = rd32_ephy(hw, addr);
> > > +	EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_int_cstm_i) = 0;
> > > +	wr32_ephy(hw, addr, rdata);
> > > +
> > > +	/*
> > > +	 * As status update from RXS hardware is asynchronous to read status of SECOND_ORDER,
> > > +	 * follow sequence mentioned below.
> > > +	 */
> > > +	for (i = 0; i < RXS_READ_COUNT; i = i + 1) {
> > > +		addr = E56G__RXS0_ANA_OVRDVAL_5_ADDR + (lane *  E56PHY_RXS_OFFSET);
> > > +		rdata = rd32_ephy(hw, addr);
> > > +		RXS_BBCDR_SECOND_ORDER_ST[i] = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
> > > +							 ana_bbcdr_int_cstm_i);
> > > +		usec_delay(100);
> > > +	}
> > > +
> > > +	/* sort array RXS_BBCDR_SECOND_ORDER_ST[i] */
> > > +	qsort(RXS_BBCDR_SECOND_ORDER_ST, RXS_READ_COUNT, sizeof(int), txgbe_e56_int_cmp);
> > > +
> > > +	median = ((RXS_READ_COUNT + 1) / 2) - 1;
> > > +	*SECOND_CODE = RXS_BBCDR_SECOND_ORDER_ST[median];
> > > +
> > > +	return;
> > > +}  
> > 
> > These extra returns are causing extra checkpatch warnings.
> > I know this is base code but if possible could you remove them.
> > 
> > 
> > WARNING:RETURN_VOID: void function return statements are not generally useful
> > #707: FILE: drivers/net/txgbe/base/txgbe_e56.c:1806:
> > +	return;
> > +}
> > 
> > WARNING:RETURN_VOID: void function return statements are not generally useful
> > #736: FILE: drivers/net/txgbe/base/txgbe_e56.c:1835:
> > +	return;
> > +}  
> 
> Alternatively, it can be declared as a static function. It is only invoked in this .c file.
> 
> 

Checkpatch complains about the extra return (it is old BSD stylism).
Like I said, not a big deal; just showing it.
