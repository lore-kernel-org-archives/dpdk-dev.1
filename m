Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7C0CDB479
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 01:44:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CB97402D1;
	Thu, 25 Jun 2026 03:44:17 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id B702540279;
 Thu, 25 Jun 2026 03:44:14 +0200 (CEST)
X-QQ-mid: tivesync3t1782351848te9d00f85
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com
 [115.204.248.247])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 16251941582676748098
To: "'Stephen Hemminger'" <stephen@networkplumber.org>,
 "'Zaiyu Wang'" <zaiyuwang@trustnetic.com>
Cc: <dev@dpdk.org>,
	<stable@dpdk.org>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>	<20260624115254.20348-1-zaiyuwang@trustnetic.com>	<20260624115254.20348-14-zaiyuwang@trustnetic.com>
 <20260624091858.20289fc8@phoenix.local>
In-Reply-To: <20260624091858.20289fc8@phoenix.local>
Subject: RE: [PATCH v10 13/21] net/txgbe: fix link stability for 40G NIC
Date: Thu, 25 Jun 2026 09:44:07 +0800
Message-ID: <05c401dd0444$1c9a3ba0$55ceb2e0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQIzGrJ934oa1ka+Tuv/tXGR6pozcwHs7/skAWH4+AwBYZ8GJrV8zcmQ
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Nw9C1WBu09hPV/cxSOhTvIB/6Ma3bluicGnVz/rckPPRs6uHpbVXEWQj
 Wwncaoen1m8F7008hmBkWNKdzBFfSpAG8hluHekXO2acwj8eSVzopnHeFfeIp8MmES6Ku4d
 mv1z8gU9kFU15JKYcA8aUabL9b/gshGKDaZLXaHhCU9TfFCwDxMeEQniBTik/4Qw/h+46Uo
 HbchzNxEYMitoYCtmmuxRgK2K3m0W2SLiqT1IAGr8IjwMiOt2O/JUSRUpDEk8DK7AFFgJCC
 ph6r3BLdC8/qYF0wPv/qEoVgzM9SeltjcJgWwtYAB68b8Wln8eqdErkUEHoLkN2awrUowv7
 MLN19k2YZAXUWXWDv+n9xgPZspcHbW5or8hb0NOmkgXsmVFsmoCTYesvYVzOItXjKfW7xES
 RvqI/AJBGy9NWRuD7JwQbNI5YDka2hFxU1CTftRYcUbq+FY2K/wVuQeSgpjTwOviOtszbAy
 8blRX5SrFWWotL0FueJd0bREeEaopEmrzBX+GxqdpyfzNmukWyfRpYvTYnYSZlv9kZhO065
 in0Gt9DehLK1Hzcfo8PpNI9PDjWiJ4k5PNPbEBMk26SlzmNwxnPUmif6FDKFMBRjdMlLrXQ
 Tfq9Be5lGo9UcxSXDzgsZBgpdnZr/Saga2WQcQXYTXokgbCML1rfmmn3HMIbtcKCFYqfN9V
 VZe8FBMzcLnTDubY24y8OfKYAjsi+AhgOUhsvJugJ4ix+CbeAxgKz3FjBVMctdKLjPdcln6
 3ybFxI00ZTRkQzzIkMibb9QzWUGR4QdkIEfarsM2i7hivecQknFXpO9IpJkeKRzvJU17pxJ
 kjnhJpv4aqqVRugnZd0LAMLqSF6GrGZRpIM2sYtblscKgIzWZQCxKSIfpsHBa6Hh98KA/Bc
 EpCedQ3fpNGzdvb5Y4d3hmCpqeONz2JgE9JtGQ5mtYTx7tahKwVuWXwrPOkWTUQuOE2Wlj1
 YIjFnViqVw4qFw3K1xqN/rl/gb/UCNvPOi8NySkrSnUvb1BPqShbniX++NYamsEYsFXb54X
 VkDyXvVMC/sl10RveM/dsgQ4bpprwR+03+0Pbm3YYWHh3cNP7M
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
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

> > +void txgbe_e56_rx_rd_second_code_40g(struct txgbe_hw *hw, int *SECOND_CODE, int lane)
> > +{
> > +	int i, median;
> > +	unsigned int rdata;
> > +	u32 addr;
> > +	int RXS_BBCDR_SECOND_ORDER_ST[RXS_READ_COUNT];
> > +
> > +	/* Set ovrd_en=0 to read ASIC value */
> > +	addr = E56G__RXS0_ANA_OVRDEN_1_ADDR + (lane *  E56PHY_RXS_OFFSET);
> > +	rdata = rd32_ephy(hw, addr);
> > +	EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_int_cstm_i) = 0;
> > +	wr32_ephy(hw, addr, rdata);
> > +
> > +	/*
> > +	 * As status update from RXS hardware is asynchronous to read status of SECOND_ORDER,
> > +	 * follow sequence mentioned below.
> > +	 */
> > +	for (i = 0; i < RXS_READ_COUNT; i = i + 1) {
> > +		addr = E56G__RXS0_ANA_OVRDVAL_5_ADDR + (lane *  E56PHY_RXS_OFFSET);
> > +		rdata = rd32_ephy(hw, addr);
> > +		RXS_BBCDR_SECOND_ORDER_ST[i] = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
> > +							 ana_bbcdr_int_cstm_i);
> > +		usec_delay(100);
> > +	}
> > +
> > +	/* sort array RXS_BBCDR_SECOND_ORDER_ST[i] */
> > +	qsort(RXS_BBCDR_SECOND_ORDER_ST, RXS_READ_COUNT, sizeof(int), txgbe_e56_int_cmp);
> > +
> > +	median = ((RXS_READ_COUNT + 1) / 2) - 1;
> > +	*SECOND_CODE = RXS_BBCDR_SECOND_ORDER_ST[median];
> > +
> > +	return;
> > +}
> 
> These extra returns are causing extra checkpatch warnings.
> I know this is base code but if possible could you remove them.
> 
> 
> WARNING:RETURN_VOID: void function return statements are not generally useful
> #707: FILE: drivers/net/txgbe/base/txgbe_e56.c:1806:
> +	return;
> +}
> 
> WARNING:RETURN_VOID: void function return statements are not generally useful
> #736: FILE: drivers/net/txgbe/base/txgbe_e56.c:1835:
> +	return;
> +}

Alternatively, it can be declared as a static function. It is only invoked in this .c file.


