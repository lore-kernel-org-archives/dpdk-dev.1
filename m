Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4646B606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 11:10:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A91F340663;
	Fri, 23 Oct 2026 13:10:31 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id F1FD340299
 for <dev@dpdk.org>; Fri, 23 Oct 2026 13:10:26 +0200 (CEST)
X-QQ-mid: tivesync1t1792753820t96ad9945
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [115.205.193.71])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 4576205365646176969
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>	<7FB1146D440010CF+20261022111017.3605-1-zaiyuwang@trustnetic.com>
 <20261022101703.3f2aebae@phoenix.local>
In-Reply-To: <20261022101703.3f2aebae@phoenix.local>
Subject: RE: [PATCH v9 00/16] Wangxun fixes and new features
Date: Fri, 23 Oct 2026 19:10:19 +0800
Message-ID: <008e01dd62df$174c0530$45e40f90$@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ8QNehdnXO5ExpIOsSsHb9Qgxp5wK6ApzsAeLJouO1qFVsoA==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NyIq8tAQ0zz8BkFv33yTuPofO0eRPSqSPez5eOZtjKrcydETraTWVylE
 mAgo47/OMkaWWQ67fwogqWM3HZAeYZyPLR8ulivQFnxtxoOXOrUL39vLFRj5Nse3FLWx5fC
 BQ89YlGO++WN0BztWFBaeNJHUxj+xFUkZSs+WrtTxJvBT5IEEV61iVP4OCNUCaWLRII8aby
 Wu/VT/PGnvyyaDraKKXG//HDRMPkJwSHNMxSFBWGTZEPqCpdyeWIumIBB6MTSV+De3uOl9E
 c5rfFEkE0pOv7rauyWCQjNvznj+Sxp5MwqCWu5ebAHvjJXk+5WBrPxLD8R4yHbtcmcwI3KG
 bZPgLurpYJ6CM7yGKf8tFHAgkg3OYhGGchvrIMBzABfnLGKiVgbrDBMSlbKayuyAycKGRjH
 rCxQ26KhxGa+7FvpHS00VWg6ZCcJCMoYNpF/jV41c2ZXMmyKufvkBJpQb4n4orZb6gL0zdl
 fGidjHql7za8XYxprQWqellhV7v6ASsWode9rg7LzziGKnaja7qdW4SrwVjV72O0pwcJskj
 8yhQfw/UeEUSyOGMcmob6MzlZZJN5JLYujAAglaszaF+CZq8xv5bW0ysL3T+/PjH/SeL4R4
 1lMt1ndoOuBUngO3GWTi8VkKebnpHg97R8IKrVEEUN+CdHRGehNe5o1YF7E5QDb1OHkM1iL
 elS4fBtFIT0+8Tj10X1ysBNv3dlwcNPEXxwgAj/ii8dhRAunveo9BVrOPT8DEXZuXc+icYa
 h12VDhJKulJrarmeOL6UUkIHVp/f2WgWtsE3D6BUw/J95+Aj2RkbJYRPQTVpd6B2y+m4XQX
 jjO2m5Slwj46DmWLzOZDriYWI0aOl1OBv94tZGzhTqHj86pTkHvdK6gJZnF/VOF3LbXn2aH
 jU1M5USC1vCzlQHued1VmpMb3GJjYgBClw+S7jE9Gk3PRizphzgjCQuLTVPbQ9Mep7boQaN
 zGK6TtVWp7GzdYhxCBlbcLavvJuXcsJbhH3lUFurG8IrPOUC2oH80fvNIKYGXVc1vn1rl/f
 n2jTU5lpfPxHxqw4VrS35W/rtgnjAgGfDKDebD/ihovYz2SHIlPD0HyV1vZzV6Xrfa+A51h
 lKNEoBa2q+r
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Friday, October 23, 2026 1:17 AM
> To: Zaiyu Wang <zaiyuwang@trustnetic.com>; Zaiyu Wang <zaiyuwang@trustnetic.com>
> Cc: dev@dpdk.org; dev@dpdk.org
> Subject: Re: [PATCH v9 00/16] Wangxun fixes and new features
> 
> On Thu, 22 Oct 2026 19:03:06 +0800
> Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:
> 
> > This series addresses link-related issues on Wangxun Amber-lite 25G/40G NICs (CR/KR training, hot-plug, 10G link state).
> >
> > ---
> > v9:
> >  - P02: build autoneg_advertised from one mask instead of three ifs, and
> >         drop the out-of-tree reference from the message.
> >  - P03: fix the same wrong RXS field in txgbe_e56_cfg_10g(), and add the
> >         Fixes tag for the 25G commit that introduced that copy.
> >  - P10: report module removal and cancel the AN73 watchdog only on the
> >         transition to not-present, so an empty cage no longer repeats both
> >         on every poll.
> >  - P12: reset invalid bp_capa values to 0, log AML40 ffe_* values above
> > 	0xFF before their low bytes are replicated across the four lanes,
> >         and document the applicable FFE value range.
> >  - P13: clarify that laser_off disables the E56 PHY PMD through PMD_CFG0
> >         for DAC cables, while QSFP modules use the SFF-8636 Tx-disable byte.
> >  - P15: rewrite the unknown-module comment, drop the debug print that ran
> >         on every watchdog tick, and drop a commit-message bullet for a branch
> >         that is not in the parent tree.
> >  - P16: clear TXGBE_FLAG_NEED_LINK_CONFIG before the administrative-down
> >         early return, so a 25G SFP port can recover after set_link_down() and
> >         set_link_up().
> 
> Still seeing errors in AI review
> 
Hi Stephen,

I have gone through the AI review reports on this series.

Three of the four errors were withdrawn by the review itself. For the
last one I added a range check for the FFE taps in txgbe_ethdev.c. That
check is temporary: full range checking for the txgbe devargs depends on
the devargs changes that are still under discussion upstream, and I will
send it as a separate patch once those settle.

I also went through the warnings and info and fixed the ones that
applied. v10 is posted with those changes.

Thanks,
Zaiyu Wang


