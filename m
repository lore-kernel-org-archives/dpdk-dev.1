Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B60ACDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 16:19:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE30640654;
	Wed, 24 Jun 2026 18:19:05 +0200 (CEST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id A253E402E7
 for <dev@dpdk.org>; Wed, 24 Jun 2026 18:19:03 +0200 (CEST)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-30c52cc5285so1847247eec.1
 for <dev@dpdk.org>; Wed, 24 Jun 2026 09:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782317942;
 x=1782922742; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5OqR2DsK+/lJBVq0vxPerrlG600hK/xbu45dHa0JL60=;
 b=FzNBq/UCVGa9S8DMDA9tXMABtma/OsWKVenTmlg1wxGwnfX/yLpPU+7yy6CaUS1R2B
 6Jbia8q8eqQbz5Dr+1M2xIZxfdzBQM3aQngWwcwxm22wn9XmyOrKYOi5/jleaE52JacL
 paBTVtEoAWowztjKy07W3YFXLZoZIg6YGtid1UHhsQR2xVBLXk8PLsextH/K28MpzbO8
 RuffH8CP9KW0Mv45CJpg+P0yPS238sShPVdM3j330rmerhYz79xveVJt3fe3vOYmI0yX
 iM+LBNgkdOU67QDY5umjqTuTd0Q3yHFQHi2ZL+89BScq9hk0mBqDTbc8g0UwrBmPv6HH
 nBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782317942; x=1782922742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5OqR2DsK+/lJBVq0vxPerrlG600hK/xbu45dHa0JL60=;
 b=F8MTj6/Vf+TFrOLoH8jLwEYBKNxZb1Maob4nc9RwaiuBplJsEPsz7yHqaKNzpylH1Q
 Fmz6qBRSJdqh/bBuRnaBBU2cevKA5QLZq98h1zJ9irlwjDoj5W4It84RH6sYWp6CNKXp
 A/79oouiIG16jXQ9ldDRrSvtjS2WeGLPa864XYbrrjFAlu+83mppNKNgb/v92z8s5F/i
 nITAaV7wN10hH5opoPYTG3HZnJvUWzKsbXI/0JFGKR5VGXy67IDzTKw+ljjw4/U5DJPU
 kn/5ydHDOHfkl+v2YJo/x9dj6c78DtgYVSKpsLfQTfoGiQObyjaz9mralFbEbZeXOjNB
 JyNA==
X-Gm-Message-State: AOJu0Yzw909swpDT7ToCSKGZ1/WEcI6W5ZQqnaxLGp7RW3ZSEw+c8vBK
 24oReYisBMtzItMXPwC++10QMqY29PUGK5G2v15MlmevdCUF7AyRRIn4jbDtHo4d/HJ1pWi4ohb
 S/Hwt
X-Gm-Gg: AfdE7ckJc1mJ+73EgNmfcfT/OD/iNrZBpthZuwfUlX5ViG/AWBNLJu/DS+6BZEpkpGP
 CF/PphVllf54bIxO8bJkGsEglCbFqezFp5LszQdUl5ZAvHN5KHfKgpa9lEbK2zdzVeVrAWsjnLv
 EiEQfy27xXE2q2CMopZ1oowqUQ4Jx6ZI0bx+ak3vv2OPsYtqYbPNqXH6BpsEXhk4MTunFE0BCY4
 TlB1piQs/WWL3Ji5I7/udpDkqtq8IDNVpFcqImDZvxAqFEIS+7bJkYcDv69KWIiy76sO2PAN83l
 J9tgwafGBrDFfm5gUSAVqcPruFEIVta4H5qxkHcr2v4uoTosn5MIe34D3W3NPUAqbInhce51Oy+
 v6e5436bBNf2snroDtcEEmf7SRaIyCJOPYBAsEi83GKP4/92udqytbEK0ni8FKM3o884HWXSk6U
 u2qQE06HIJQjqzdmXIIeOSL+qNye4f4fgfyI9wItXAUKEFyJA7/3GsAcwOgi9CVCkT
X-Received: by 2002:a05:7300:7246:b0:304:ccdd:594a with SMTP id
 5a478bee46e88-30c691335afmr4283784eec.5.1782317942318; 
 Wed, 24 Jun 2026 09:19:02 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1a80sm256469eec.18.2026.06.24.09.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 09:19:02 -0700 (PDT)
Date: Wed, 24 Jun 2026 09:18:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, stable@dpdk.org, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v10 13/21] net/txgbe: fix link stability for 40G NIC
Message-ID: <20260624091858.20289fc8@phoenix.local>
In-Reply-To: <20260624115254.20348-14-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260624115254.20348-1-zaiyuwang@trustnetic.com>
 <20260624115254.20348-14-zaiyuwang@trustnetic.com>
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

On Wed, 24 Jun 2026 19:52:45 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> +
> +void txgbe_e56_rx_rd_second_code_40g(struct txgbe_hw *hw, int *SECOND_CODE, int lane)
> +{
> +	int i, median;
> +	unsigned int rdata;
> +	u32 addr;
> +	int RXS_BBCDR_SECOND_ORDER_ST[RXS_READ_COUNT];
> +
> +	/* Set ovrd_en=0 to read ASIC value */
> +	addr = E56G__RXS0_ANA_OVRDEN_1_ADDR + (lane *  E56PHY_RXS_OFFSET);
> +	rdata = rd32_ephy(hw, addr);
> +	EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_int_cstm_i) = 0;
> +	wr32_ephy(hw, addr, rdata);
> +
> +	/*
> +	 * As status update from RXS hardware is asynchronous to read status of SECOND_ORDER,
> +	 * follow sequence mentioned below.
> +	 */
> +	for (i = 0; i < RXS_READ_COUNT; i = i + 1) {
> +		addr = E56G__RXS0_ANA_OVRDVAL_5_ADDR + (lane *  E56PHY_RXS_OFFSET);
> +		rdata = rd32_ephy(hw, addr);
> +		RXS_BBCDR_SECOND_ORDER_ST[i] = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
> +							 ana_bbcdr_int_cstm_i);
> +		usec_delay(100);
> +	}
> +
> +	/* sort array RXS_BBCDR_SECOND_ORDER_ST[i] */
> +	qsort(RXS_BBCDR_SECOND_ORDER_ST, RXS_READ_COUNT, sizeof(int), txgbe_e56_int_cmp);
> +
> +	median = ((RXS_READ_COUNT + 1) / 2) - 1;
> +	*SECOND_CODE = RXS_BBCDR_SECOND_ORDER_ST[median];
> +
> +	return;
> +}

These extra returns are causing extra checkpatch warnings.
I know this is base code but if possible could you remove them.


WARNING:RETURN_VOID: void function return statements are not generally useful
#707: FILE: drivers/net/txgbe/base/txgbe_e56.c:1806:
+	return;
+}

WARNING:RETURN_VOID: void function return statements are not generally useful
#736: FILE: drivers/net/txgbe/base/txgbe_e56.c:1835:
+	return;
+}
