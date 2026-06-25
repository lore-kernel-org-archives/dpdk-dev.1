Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B821CDB47C
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 03:20:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D9F9402A3;
	Thu, 25 Jun 2026 05:20:55 +0200 (CEST)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id 0743640279;
 Thu, 25 Jun 2026 05:20:52 +0200 (CEST)
X-QQ-mid: tivesync7t1782357647tcb83fba1
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [115.204.248.247])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 13239467919674805906
To: "'Stephen Hemminger'" <stephen@networkplumber.org>,
 "'Jiawen Wu'" <jiawenwu@trustnetic.com>
Cc: <dev@dpdk.org>,
	<stable@dpdk.org>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>	<20260624115254.20348-1-zaiyuwang@trustnetic.com>	<20260624115254.20348-14-zaiyuwang@trustnetic.com>	<20260624091858.20289fc8@phoenix.local>	<05c401dd0444$1c9a3ba0$55ceb2e0$@trustnetic.com>
 <20260624192600.579930ee@phoenix.local>
In-Reply-To: <20260624192600.579930ee@phoenix.local>
Subject: RE: [PATCH v10 13/21] net/txgbe: fix link stability for 40G NIC
Date: Thu, 25 Jun 2026 11:20:46 +0800
Message-ID: <002501dd0451$9d04ea30$d70ebe90$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIzGrJ934oa1ka+Tuv/tXGR6pozcwHs7/skAWH4+AwBYZ8GJgFPqx2kAVgDBCS1Z6r3YA==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OKpcuXgJbEN3PIT91suXE7u0p/UOAY5zXNRqwn4EaExcuBWqnPtvMXAh
 JoSE3XjUHe+LGH3m33jLq39zIZEhNU42tl1+jSl01t1J0ZfQsu2GwNQH9ubODsfco5RLO4R
 BF2ESHl2MNAqAw9zw9AlcHApC4XNkX317LXKlqRgSZ/Cpgy+c99TFGomgfpsHglSawX2eG1
 8Uf7DJBC2jPU6mGDb/5cHsguiepGBoW+2mcxUZWxqoCQUbq3shB1WORIiGnoLQJEzb8NUdw
 xtYjk/Yaa7atD4giGj/k7yRyJdYi6r4CmNQwm3FMUGtAT35dlgakQhR5vdinD5Zbb1zPKRA
 LmFPTIoNweGX+JouJPEB09MwcAA155cTLbysohlF2CBXagS0aoWEDHl8ia+1wpw80S+KB9r
 3DMBu4+SvpdZkbf5DMA4nYI06D7r+gr1nMIhEgLacu3sTjOkKdVhCsVfROywq+qR9qpzmwo
 vuwJxjUpTL9kEhpmj5FL9ZZjj4GwsPl88nlOzvS/QQHpXjac8WTIhQisWzcioWWTH7GbHIR
 UVI/l/VxyWsJ6AYGk5mtllQZc2e+1o2c4eChDHbzkBrAhrcyFOkwy5MlhMKAMLvIxYFSRzr
 znhBNqYqzcOjkZoPa30sx7P9U3wi7Z52iotneh8hv74CldPlLeH4T65k6/egDDXZDkWgwJR
 ejBYK1chPF8X9mBNLWjVkGgRLmWUY3MmrkMdznIORwB4+3+2MRbuqG4WbYl3iH5xApvgkTa
 hXqSucmzynQe+f5z9kg8YsmPPD4hlaZOZchYRqnN1GFHKEN3xqcUuS0wzXAmJOTVv9/0e26
 d908ZaRd4N+HS+Pi/MzdwLpQqdaLLcI95OHrFnhrWDo2FWSdpaYAjRC0CrNouIIfzJCh4gy
 CxlljmxWllRvR6J/hCr2qmf/J4W0lRAb9TOugZlRpC0zydca2O/hYpP2jzp9aTzH1nM9O4b
 O13cynpPecLwT7kU3yQy3R23pzULnU7KRPEhVzg2CNlaPLo5KTg5zdJXPEkVt6fA2jMAy2W
 byio13VvTqj26x96UEgCn+5h0104eD18ruNocjjo7hSM5YVShfAaVfxzmiEKnIz9V+QjVGL
 THWcSZ9SQtnmCnhTFYoIB6IJ+MvTPktfhDE04ZiyQXllGWp0eMrwJU=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Thursday, June 25, 2026 10:26 AM
> To: Jiawen Wu <jiawenwu@trustnetic.com>; Jiawen Wu <jiawenwu@trustnetic.com>
> Cc: 'Zaiyu Wang' <zaiyuwang@trustnetic.com>; dev@dpdk.org; stable@dpdk.org; 'Zaiyu Wang'
> <zaiyuwang@trustnetic.com>; dev@dpdk.org; stable@dpdk.org
> Subject: Re: [PATCH v10 13/21] net/txgbe: fix link stability for 40G NIC
> 
> On Thu, 25 Jun 2026 09:44:07 +0800
> Jiawen Wu <jiawenwu@trustnetic.com> wrote:
> 
> > > > +void txgbe_e56_rx_rd_second_code_40g(struct txgbe_hw *hw, int
> > > > +*SECOND_CODE, int lane) {
> > > > +	int i, median;
> > > > +	unsigned int rdata;
> > > > +	u32 addr;
> > > > +	int RXS_BBCDR_SECOND_ORDER_ST[RXS_READ_COUNT];
> > > > +
> > > > +	/* Set ovrd_en=0 to read ASIC value */
> > > > +	addr = E56G__RXS0_ANA_OVRDEN_1_ADDR + (lane *  E56PHY_RXS_OFFSET);
> > > > +	rdata = rd32_ephy(hw, addr);
> > > > +	EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_int_cstm_i) = 0;
> > > > +	wr32_ephy(hw, addr, rdata);
> > > > +
> > > > +	/*
> > > > +	 * As status update from RXS hardware is asynchronous to read status of
> SECOND_ORDER,
> > > > +	 * follow sequence mentioned below.
> > > > +	 */
> > > > +	for (i = 0; i < RXS_READ_COUNT; i = i + 1) {
> > > > +		addr = E56G__RXS0_ANA_OVRDVAL_5_ADDR + (lane *  E56PHY_RXS_OFFSET);
> > > > +		rdata = rd32_ephy(hw, addr);
> > > > +		RXS_BBCDR_SECOND_ORDER_ST[i] = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
> > > > +							 ana_bbcdr_int_cstm_i);
> > > > +		usec_delay(100);
> > > > +	}
> > > > +
> > > > +	/* sort array RXS_BBCDR_SECOND_ORDER_ST[i] */
> > > > +	qsort(RXS_BBCDR_SECOND_ORDER_ST, RXS_READ_COUNT, sizeof(int),
> > > > +txgbe_e56_int_cmp);
> > > > +
> > > > +	median = ((RXS_READ_COUNT + 1) / 2) - 1;
> > > > +	*SECOND_CODE = RXS_BBCDR_SECOND_ORDER_ST[median];
> > > > +
> > > > +	return;
> > > > +}
> > >
> > > These extra returns are causing extra checkpatch warnings.
> > > I know this is base code but if possible could you remove them.
> > >
> > >
> > > WARNING:RETURN_VOID: void function return statements are not
> > > generally useful
> > > #707: FILE: drivers/net/txgbe/base/txgbe_e56.c:1806:
> > > +	return;
> > > +}
> > >
> > > WARNING:RETURN_VOID: void function return statements are not
> > > generally useful
> > > #736: FILE: drivers/net/txgbe/base/txgbe_e56.c:1835:
> > > +	return;
> > > +}
> >
> > Alternatively, it can be declared as a static function. It is only invoked in this .c file.
> >
> >
> 
> Checkpatch complains about the extra return (it is old BSD stylism).
> Like I said, not a big deal; just showing it.
> 
Thanks.
Since this is not a critical issue and the current patch series has already been applied,
I would prefer to leave these returns as-is for now. I will address them together with
the upcoming PHY configuration updates in a future patch series.

